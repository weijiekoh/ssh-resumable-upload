FROM alpine:3.10.2

RUN apk update && \
    apk --no-cache upgrade && \
    apk --no-cache add dropbear rsync rrsync

RUN adduser -D -s /bin/sh dropbear
USER dropbear
WORKDIR /home/dropbear

RUN mkdir -p /home/dropbear/.ssh/
COPY authorized_keys /
RUN cp /authorized_keys /home/dropbear/.ssh/authorized_keys
RUN chmod a-w /home/dropbear/.ssh/authorized_keys

RUN dropbearkey -t rsa -f /home/dropbear/.ssh/id_dropbear -s 2048
RUN chmod a-w /home/dropbear/.ssh/id_dropbear

CMD dropbear -FEs -r .ssh/id_dropbear -p 2233
