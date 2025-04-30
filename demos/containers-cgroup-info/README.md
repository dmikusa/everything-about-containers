# Container CGroup Info

This is a demo app that can be run to view the container cgroup information.

It shows the current memory and CPU limits.

## Build

Run `./gradlew bootBuildImage`. This will take a few minutes.

## Run

To run the image you built: `podman run -it --rm -p 8080:8080 --cpus=1 --memory=1G containers-cgroup-info:0.0.1-SNAPSHOT`

If you'd prefer to run from a pre-built container, it's available on Docker Hub. `podman run -it --rm -p 8080:8080 --cpus=1 --memory=1G docker.io/dmikusa/containers-cgroup-info`.

You can adjust the `--cpus` and `--memory` arguments to define different limits on the container.
