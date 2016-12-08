FROM alpine:edge
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
        && echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
        && apk update && apk upgrade \
        && apk add ca-certificates \
                   erlang-crypto@edge \
                   erlang-parsetools@edge \
                   erlang-syntax-tools@edge \
                   elixir@edge \
        && rm -rf /var/cache/apk/*

ENV APP "web"
ENV WORK_PATH "/work/${APP}_src"

ADD docker/compile.sh /compile.sh

RUN mkdir /work \
 && mkdir /build \
 && chmod +x /compile.sh

VOLUME ["/build"]
CMD ["/compile.sh"]
