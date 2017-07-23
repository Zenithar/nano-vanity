FROM alpine:edge
MAINTAINER Thibault NORMAND <me@zenithar.org>

ENV GOPATH /go
ENV VANITY_TAG v0.2

RUN apk add --update musl \
    && apk add -t build-tools build-base go mercurial git upx \
    && mkdir /go \
    && cd /go \
    && go get -tags=$VANITY_TAG github.com/xiam/vanity/... \
    && upx -9 $GOPATH/bin/vanity \
    && mv $GOPATH/bin/vanity /bin \
    && mkdir /vanity \
    && apk del --purge build-tools \
    && rm -rf /go /var/cache/apk/*

USER       nobody
EXPOSE     8080
VOLUME     [ "/vanity" ]
WORKDIR    "/vanity"
ENTRYPOINT [ "/bin/vanity" ]
CMD        [ "-h" ]
