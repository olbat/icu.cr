FROM crystallang/crystal
MAINTAINER devel@olbat.net

RUN apt-get update \
&& apt-get install -y make git libpcre3 libicu-dev llvm-14 llvm-14-dev libclang-14-dev \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-14 100

RUN mkdir -p /src
WORKDIR /src

CMD crystal spec
