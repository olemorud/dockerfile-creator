
This Ubuntu docker image logs new packages installed by apt-get in `packages` and dumps the environment in file `envdump` when `exportimage` is called.

`exportimage` additionally writes a Dockerfile to stdout. The Docker image will look something like this
```
FROM ubuntu:20.04

COPY $(basename $PACKAGELOG) .
COPY $(basename $ENVLOG) .

RUN apt update \
 && apt install \$(cat $(basename $PACKAGELOG)) \
 && source $(basename $ENVLOG)
```

## Run
This runs the docker image and saves the output to ./output/*
```
sudo docker run -it \
--volume $(pwd)/output:/root/output \
ghcr.io/olemorud/ubuntu-tool:latest
```
