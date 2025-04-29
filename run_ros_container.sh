#!/bin/sh
docker container run -it --name my_ros_container \
    -v $PWD/shared_files:/shared_files_in \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --env=DISPLAY \
    my_ros_img

