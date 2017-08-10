#! /usr/bin/env bash


APP_NAME="foo"

hash -r


echo "Building app:"
echo $APP_NAME

now=$(date +'%Y-%m-%d_%T')
ver=$(git rev-parse HEAD)
packr build -ldflags "-X main.sha1=$ver -X main.buildTime=$now"