# build stage

FROM golang:alpine AS build

ADD . $GOPATH/src/github.com/mickeyyawn/foo

WORKDIR $GOPATH/src/github.com/mickeyyawn/foo

# update alpine package manager (apk), 
RUN apk update

# then add git ...
RUN apk --no-cache  add git

# then add curl ...
RUN apk --no-cache add curl 

# then add bash ...
RUN apk --no-cache add --update bash && rm -rf /var/cache/apk/*

RUN curl -LJO https://github.com/gobuffalo/packr/releases/download/v1.10.4/packr_1.10.4_linux_amd64.tar.gz

#RUN ls -l
RUN tar -xvzf packr_1.10.4_linux_amd64.tar.gz

WORKDIR $GOPATH/src/github.com/mickeyyawn/foo

RUN GOOS=linux CGO_ENABLED=0 $GOPATH/src/github.com/mickeyyawn/foo/packr build -a -o foo


# ----------------------------------------------------------------------------------------
# run stage
FROM alpine

RUN mkdir app

WORKDIR /app

COPY --from=build /go/src/github.com/mickeyyawn/foo/foo /app/

ENTRYPOINT ./foo


#docker build -t mickeyyawn/foo .
#docker run -p 127.0.0.1:8080:8080  --env PORT=8080  -i -d  mickeyyawn/foo:latest





