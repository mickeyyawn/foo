FROM alpine:3.6

MAINTAINER Mickey Yawn <mickey.yawn@turner.com>

ADD foo /foo

ENTRYPOINT ["/foo"]

