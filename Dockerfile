FROM alpine:3.6
MAINTAINER MengskySama <mengskysama@gmail.com>

ENV WEIGHTTP_VERSION 0.4
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
apk add --update alpine-sdk python curl libev-dev

#build
WORKDIR /tmp
RUN curl https://codeload.github.com/lighttpd/weighttp/tar.gz/weighttp-${WEIGHTTP_VERSION} | tar xvz
WORKDIR /tmp/weighttp-weighttp-${WEIGHTTP_VERSION}
RUN ./waf configure && ./waf build && ./waf install

# cleanup
RUN cd / && rm -rf /tmp/weighttp* && \
apk del --purge alpine-sdk python curl && \
rm -rf /var/cache/apk/*

ENTRYPOINT ["weighttp"]
