This is a Docker container which helps to set up a SCP-only server on a remote
host so you can let third parties upload large files without giving them full
shell access.

We assue that each user has a unique ID, such as `0001`. This can be any string.

The user will be able to SCP a file from their local machine into the server,
and the file will stored in `/path/to/repo/uploads/USER_ID/FILENAME`.

First, clone this repository on your desired remote server:

```bash
git clone https://github.com/weijiekoh/dropbear-scp.git && \
cd dropbear-scp
```

Next, create an `uploads` directory:

```bash
mkdir uploads
```

Create an `authorized_keys` file which should be configured as such:

```
command="DIR=uploads/USER_0_ID && mkdir -p ~/$DIR && scp -v -r -d -t ~/$DIR",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa USER_0_RSA_PUBKEY
command="DIR=uploads/USER_1_ID && mkdir -p ~/$DIR && scp -v -r -d -t ~/$DIR",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa USER_1_RSA_PUBKEY
```

For each `USER_0_ID`, `USER_1_ID`, and so on.

For example:

```
command="DIR=uploads/0001 && mkdir -p $DIR && scp -v -r -d -t ~/$DIR",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx name@email.com
```

Run the Docker container:

```bash
docker-compose build && \
docker-compose up -d
```

The client can now upload files to your remote server as such:

```bash
scp -p 2233 /path/to/file user@host:
```

and `file` will show up in `/path/to/repo/uploads/USER_ID/`.

To change the port from 2233 to something else, edit `Dockerfile` and
`docker-compose.yml`.
