FROM --platform=linux/amd64 ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libbz2-dev libz-dev

ADD . /repo
WORKDIR /repo
RUN make -j8 LZMA=0 ZSTD=0 MD5=0
