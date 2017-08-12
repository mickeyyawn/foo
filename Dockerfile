FROM alpine:3.6

MAINTAINER Mickey Yawn <mickey.yawn@turner.com>

ADD /builds/linux/foo /foo

ENTRYPOINT ["/foo"]

