FROM crystallang/crystal
MAINTAINER devel@olbat.net

RUN apt-get update \
&& apt-get install -y make libicu-dev llvm-3.8-dev libclang-3.8-dev \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN ln -s $(llvm-config-3.8 --libdir)/libclang.so /usr/lib/

RUN mkdir -p /src
WORKDIR /src

CMD crystal spec
