#!/bin/bash

docker stop notebook
docker rm notebook

xhost local:docker

docker run -it --rm --name notebook\
       -v /tmp/.X11-unix:/tmp/.X11-unix:ro\
       -e DISPLAY="unix$DISPLAY"\
       -v /tmp/:/tmp\
       -v /mnt/labshare:/mnt/labshare:ro\
       notebook
