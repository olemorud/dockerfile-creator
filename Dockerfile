FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade -y \
 && yes | unminimize

RUN mkdir $HOME/output
VOLUME $HOME/output

COPY utils.sh /utils/utils.sh
RUN echo "source /utils/utils.sh" >> ~/.bashrc
