FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libbz2-dev libz-dev

ADD . /repo
WORKDIR /repo
RUN make -j8 LZMA=0 ZSTD=0 MD5=0

RUN mkdir -p /deps
RUN ldd /repo/hpatchz | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04 as package

COPY --from=builder /deps /deps
COPY --from=builder /repo/hpatchz /repo/hpatchz
ENV LD_LIBRARY_PATH=/deps
