#! /usr/bin/env bash


APP_NAME="foo"

hash -r


echo "Building app:"
echo $APP_NAME

mkdir -p builds
mkdir -p builds/linux
mkdir -p builds/darwin

now=$(date +'%Y-%m-%d_%T')
ver=$(git rev-parse HEAD)

GOOS=linux CGO_ENABLED=0 $GOPATH/src/github.com/mickeyyawn/foo/packr build -ldflags "-X main.sha1=$ver -X main.buildTime=$now"
mv foo builds/linux/foo

GOOS=darwin CGO_ENABLED=0 $GOPATH/src/github.com/mickeyyawn/foo/packr build -ldflags "-X main.sha1=$ver -X main.buildTime=$now"
mv foo builds/darwin/foo

