# Foo

A very simple project that exercises Docker and Go in various ways.


# Why ?

I needed (wanted) a container image that I owned when using k8s, ecs, etc... It
also provided a proving ground to experiment with Docker and Go.

# Features (Demonstrates)

- Dependency management in Go using [Dep](https://github.com/golang/dep)
- Asset bundling in Go using [Packr](https://github.com/gobuffalo/packr)
- Building go binary using a [multi-stage](https://docs.docker.com/develop/develop-images/multistage-build/) dockerfile.
- Using [Alpine](https://alpinelinux.org/) to minimize image bloat
- Using [Gorilla Mux](https://github.com/gorilla/mux) for lightweight route handling.
- Building/tagging Docker image
- Pushing docker image to [Docker Hub](https://hub.docker.com/)



## Build and tag the docker image

```
docker build -t mickeyyawn/foo:latest .
```

## Run the container that we just built

```
docker run -p 127.0.0.1:8080:8080  --env PORT=8080  -i -d  mickeyyawn/foo:latest
```

## Test the app to make sure it is running

```
curl 127.0.0.1:8080/_hc
```
or...

Open your browser and navigate to htttp://127.0.0.1:8080 to see Foo in all of it's glory
If all goes well, you should see a page proclaiming: "Hello, this is the foo app."


## Push it to DockerHub

Ok, now that we have assured it runs ok locally, let's push it to our public Docker Hub repo.
Obviously you won't be able to push to the mickeyyawn repo, but you get the idea.



```
docker login --password=$DOCKERHUB_PWD --username=mickeyyawn
docker push mickeyyawn/foo
docker pull mickeyyawn/foo
```







