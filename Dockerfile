FROM crystallang/crystal
MAINTAINER devel@olbat.net

RUN apt-get update \
&& apt-get install -y make libicu-dev llvm-5.0-dev libclang-5.0-dev libpcre3 \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /src
WORKDIR /src

CMD crystal spec
