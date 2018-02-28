#FROM ubuntu:12.04

#MAINTAINER Mickey Yawn <mickey.yawn@turner.com>

#ADD /builds/linux/foo /foo

#ENTRYPOINT ["/foo"]









# build stage
FROM golang:alpine AS build

ADD . $GOPATH/src/github.com/mickeyyawn/foo

WORKDIR $GOPATH/src/github.com/mickeyyawn/foo

RUN  GOOS=linux CGO_ENABLED=0  go build -o foo
#RUN cd $GOPATH/src/github.com/mickeyyawn/puny && ls -l



# run stage
FROM alpine

RUN mkdir app

WORKDIR /app

COPY --from=build /go/src/github.com/mickeyyawn/foo/foo /app/

ENTRYPOINT ./foo


#docker build -t mickeyyawn/foo .
#docker run --rm mickeyyawn/foo

