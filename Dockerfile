FROM alpine:3.19 as build

RUN set -xe; \
    apk add --no-cache --virtual=_build alpine-sdk

COPY . /vlmcsd

WORKDIR /vlmcsd

RUN make

FROM alpine:3.19

RUN adduser -D vlmcsd

COPY --from=build /vlmcsd/bin/vlmcsd /usr/local/bin/

CMD [ "vlmcsd", "-o2", "-m5", "-T0", "-D", "-e", "-u", "vlmcsd", "-g", "vlmcsd", "-C", "1033", "-c1", "-M1" ]