FROM crystallang/crystal
MAINTAINER devel@olbat.net

RUN apt-get update \
&& apt-get install -y make git libpcre3 libicu-dev llvm-15 llvm-15-dev libclang-15-dev \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-15 100

RUN mkdir -p /src
WORKDIR /src

CMD crystal spec
