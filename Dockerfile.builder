FROM alpine:edge
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
        && echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
        && apk update && apk upgrade \
        && apk add ca-certificates \
        && apk add erlang-crypto@edge \
        && apk add elixir@edge \
        && mix local.hex --force \
        && rm -rf /var/cache/apk/*

ENV APP "web"
ENV WORK_PATH "/work/${APP}_src"

ADD docker/compile.sh /compile.sh

RUN mkdir /work \
 && mkdir /build \
 && chmod +x /compile.sh

VOLUME ["/build"]
CMD ["/compile.sh"]
