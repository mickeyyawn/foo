# foo
Foo is a dead simple project that demonstrates builing a go binary, building
a docker image containing that binary, running that container locally, then
pushing that image to Docker Hub (pubilc registry) for others to consume.

It assumes you build the go binary outside constructing the container.  Do
that using the following command:  (note: users packr to insert resources
into the binary:  https://github.com/gobuffalo/packr)

    GOOS=linux CGO_ENABLED=0 packr build -a -o foo

That will create a binary in the root of the repo.

Now we want to build the docker image and tag it.

    docker build -t mickeyyawn/foo:latest .

To test the image and golang binary, crank up a container with this:


    docker run -p 127.0.0.1:8080:8080  --env PORT=8080  -i -d  mickeyyawn/foo:latest


Test out the app:   curl 127.0.0.1:8080/_hc

If all goes well, you should see a page proclaiming: "Hello World from golang!"

Ok, now that we have assured it runs ok locally, let's push it to our
public Docker Hub repo.


    docker login --password=$DOCKERHUB_PWD --username=mickeyyawn
    docker push mickeyyawn/foo

As an additional exercise, you can pull the public image you just pushed and
crank it up (instead of building it manually as we did above.)

    docker pull mickeyyawn/foo

TODO: Add k8s yml def.