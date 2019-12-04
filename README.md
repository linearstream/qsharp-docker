# Qsharp Docker

Collaterals used for creating the docker image [breakdownlane/qsharp](https://hub.docker.com/r/breakdownlane/qsharp)

## Prerequisites

The image versioning is based on git log output and expects your git workspace to be git status clean to build the image.
This was to prevent pushing an image without committing a change.

## Installing

To create your own docker image from the collaterals, run:

```
make DOCKER_USER=you build
```

Verify that the image was created using:

```
docker images
```
Given the example above should result in:

```
REPOSITORY      TAG                                        IMAGE ID            CREATED             SIZE
you/qsharp      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   d8fad5d06c55        7 days ago          1.07GB
you/qsharp      latest                                     d8fad5d06c55        7 days ago          1.07GB
```

## Author

**Josh Thies**

- docker:  [breakdownlane](https://hub.docker.com/breakdownlane)
- twitter: [breakdown_lane](https://twitter.com/breakdown_lane)
