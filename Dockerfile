# build stage

FROM golang:alpine AS build

ADD . $GOPATH/src/github.com/mickeyyawn/foo

WORKDIR $GOPATH/src/github.com/mickeyyawn/foo

#RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# update alpine package manager (apk), 
RUN apk update

# then add git ...
RUN apk --no-cache  add git

# then add curl ...
RUN apk --no-cache add curl 

# then add bash ...
RUN apk --no-cache add --update bash && rm -rf /var/cache/apk/*


#RUN go get -d -u github.com/golang/dep


#RUN go get -d -u github.com/gobuffalo/packr
#RUN go install github.com/gobuffalo/packr

RUN curl -LJO https://github.com/gobuffalo/packr/releases/download/v1.10.4/packr_1.10.4_linux_amd64.tar.gz

#RUN ls -l
RUN tar -xvzf packr_1.10.4_linux_amd64.tar.gz

#RUN ls -l

#RUN mv packr_1.10.4_linux_amd64/packr $GOPATH/bin/packr



#RUN cd $(go env GOPATH)/src/github.com/golang/dep

#RUN cd $GOPATH/src/github.com/golang/dep


# set our working directory to the cloned dep repo
#WORKDIR $GOPATH/src/github.com/golang/dep

#RUN ls -l
#DEP_LATEST=$(git describe --abbrev=0 --tags)

# list tags.  not necessary, but might help future debugging...
#RUN git tag

#RUN git checkout v0.4.1
#RUN git checkout $DEP_LATEST


#RUN go install -ldflags="-X main.version=v0.4.1" ./cmd/dep
#RUN git checkout master



#### try the install script ????
#RUN sh $GOPATH/src/github.com/golang/dep/install.sh

#RUN which bash
#RUN ls -l
#RUN bash $GOPATH/src/github.com/golang/dep/install.sh


WORKDIR $GOPATH/src/github.com/mickeyyawn/foo

#RUN dep ensure

#RUN which packr



#WORKDIR $GOPATH/bin
#RUN ls -l





WORKDIR $GOPATH/src/github.com/mickeyyawn/foo


#RUN ls -l



RUN GOOS=linux CGO_ENABLED=0 $GOPATH/src/github.com/mickeyyawn/foo/packr build -a -o foo

#RUN  GOOS=linux CGO_ENABLED=0  go build -o foo
#RUN cd $GOPATH/src/github.com/mickeyyawn/puny && ls -l










# run stage
FROM alpine

RUN mkdir app

WORKDIR /app

COPY --from=build /go/src/github.com/mickeyyawn/foo/foo /app/

ENTRYPOINT ./foo


#docker build -t mickeyyawn/foo .
#docker run -p 127.0.0.1:8080:8080  --env PORT=8080  -i -d  mickeyyawn/foo:latest





