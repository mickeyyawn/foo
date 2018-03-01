# This is a multi stage Docker file.  The first part will be where
# we actually build the go binary.  The second part is where we expose/run
# the go binary.  I will try and describe each step as we go.

# -------------------------------- Build Stage ----------------------------------


# Let's build a go binary from source.
# We pull the latest alpine image that has the Go language installed
# in it.  This will allow us to compile the source into a binary.

FROM golang:alpine AS build

# Let's add our source repo into Docker
ADD . $GOPATH/src/github.com/mickeyyawn/foo

# Set the working directory to the root of the repo
WORKDIR $GOPATH/src/github.com/mickeyyawn/foo

# update alpine package manager (apk) so that we can install some other packages
RUN apk update

# add the git package so that we can pull other code
RUN apk --no-cache  add git

# add curl so that we download code
RUN apk --no-cache add curl 

# add bash because I am more comfortable with it
RUN apk --no-cache add --update bash && rm -rf /var/cache/apk/*

# use curl to download packr.  we will use packr to compile some static assets into the binary
RUN curl -LJO https://github.com/gobuffalo/packr/releases/download/v1.10.4/packr_1.10.4_linux_amd64.tar.gz

# untar packr so that is available in the next command
RUN tar -xvzf packr_1.10.4_linux_amd64.tar.gz

# now let's actually build a linux executable binary from go source.  much excite!
RUN GOOS=linux CGO_ENABLED=0 $GOPATH/src/github.com/mickeyyawn/foo/packr build -a -o foo




# ok, we now have go binary built and ready to go for linux.  let's 
# expose it to the outside world and tell Docker what to start.  This 
# is what I call the "run" stage.




# -------------------------------- Run Stage ----------------------------------


# We will use the base Alpine image to keep the container as small as possible.  Yes,
# we can use Scratch, but that introduces other complexities.
FROM alpine

# Let's create a directory where the executable will reside.  Not completely
# necessary, but I like to keep things organized
RUN mkdir app

# Tell docker that's where we want to set up shop and operate from
WORKDIR /app

# Copy the binary we built in the "build" stage over to this stage
COPY --from=build /go/src/github.com/mickeyyawn/foo/foo /app/

# Tell docker that is what we want to exec when Docker starts this container
ENTRYPOINT ./foo



