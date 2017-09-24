# docker-atom-editor

## Overview

Install and run the [Atom editor](https://atom.io/) from within a Docker container.

## Building the image

Clone this repository, change into the source directory and run eg:

```
DEBIAN_MIRROR=deb.debian.org make
```

## Running Atom

```
PROJECT=myproject
NAME=${PROJECT}-atom
# when the atom volume exists, preferences will tell what to open
VOL=$(docker volume ls -q --filter name=^$NAME$)
if [ -n "$VOL" ] ; then
  CMD="/usr/bin/atom -f"
else
  # but the first time atom is launched, force open the project directory
  CMD="/usr/bin/atom -f /home/atom/src/$PROJECT"
fi

docker run
  --name=$NAME \
  --rm=true \
  -d \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v /dev/shm:/dev/shm \
  --mount source=$NAME,destination=/home/atom \
  --mount source=$PROJECT,destination=/home/atom/src/$PROJECT \
  -e DISPLAY \
  atom
```
Note that `-v /dev/shm:/dev/shm` may be optional and can be replaced by `--shm-size="<number><unit>"`.
