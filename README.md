This is a Docker container which helps to set up a SCP-only server on a remote
host so you can let third parties upload large files without giving them full
shell access.

First, clone this repository:

```
git clone
cd 
```

It runs a Dropbear instance, which in turn reads an `authorized_keys` file
which should be configured as such:

```
command="DIR=uploads/USER_0_ID && mkdir -p $DIR && scp -v -r -d -t ~/$DIR",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa USER_0_RSA_PUBKEY
command="DIR=uploads/USER_1_ID && mkdir -p $DIR && scp -v -r -d -t ~/$DIR",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa USER_1_RSA_PUBKEY
```

For each `USER_0`, `USER_1`, and so on.

For example:

```
command="DIR=uploads/0001 && mkdir -p $DIR && scp -v -r -d -t ~/$DIR",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwcFaQgXr+6lTjc7TTQDtma1dlTx2+10XyF7Wr7xAEMOwfzRnm6QM35+ZUPaVFjS9e/IH9QUTWtDg8pJI9T8ynatmDngiU+iwvLRfHrKkInBapM7ykLfpeFjohwfRNaISxCF5xi/fivhtG4QI6C64WCepcj0CD2E++Uq/IwHzmtbpOeNLp6Kf+FSwAeZOsKt3aeNtRQb12nLVTnlmfOAIC3fz9GP35BEy053dZBRJ7wqvE/rajo3nE5u/yJUQf7saaOSDm+9sHcK4ZNSB5+2C9CyF4yXUOQZIyJ2rTpyHjmdA2aYQ0cRWUOSig9oi+6SaBjBGZ4fSjUIID8CzLxpWb weijie.koh@ethereum.org
```
