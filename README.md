# ROS2 quickstart with docker

This is the collection of scripts that allows you to setup and run a ROS2
jazzy with minimum effort using Docker. This might be useful for Linux or
maybe BSD users who don't use the appropriate Ubuntu LTS release.

## Setup

Check if docker daemon is enabled
```bash
systemctl is-enabled docker
```

Run docker daemon
```bash
systemctl start docker
```

Add user to group "docker" as root:
```bash
usermod -aG docker <username>
```

Or with `sudo`:
```bash
sudo usermod -aG docker $USER
```

Let the GUI programs run inside docker containers
```bash
xhost +local:
```

Yes, this means that X11 is needed.

## Dockerfile customization

If you want different ROS distribution, you should open `Dockerfile` with
text editor and change the line:
```bash
FROM <desired ros image>
```
according to the available ROS images. Then open `entrypoint.sh` and edit
this line accordingly:
```bash
source /opt/ros/<desired ros distribution>/setup.bash
```

If you want `vim` to be preinstalled in your container and your `.vimrc`
copied there, then uncomment "install vim" and "copy vim config" related
lines and put your `.vimrc` file inside the `configs` directory.

## Using scripts

Now we are ready to build our ROS image with script `build_ros_image.sh`.
Then, to make a new container, use `run_ros_container.sh`. If this script
was executed before, then the container already exists. To activate it, use
`start_ros_container.sh`. To get inside the container in new terminal, use
`ros_root_exec.sh` or `ros_user_exec.sh`, to have a root or user privileges
respectively. You can also change image name `my_ros_img` and container
name `my_ros_container` in these scripts to your liking. That should be
enough, but some useful docker commands are listed below.

# Useful docker commands in case something goes wrong

## Get the list of docker images

```bash
docker image ls
```
or
```bash
docker images
```

## Remove docker image

```bash
docker image rm -f <image-name>
```
or
```bash
docker rmi -f <image-name>
```

Remove dangling images:
```bash
docker rmi $(docker images -f "dangling=true" -q)
```

## Get the list of docker containers

```bash
docker container ls -a
```
or
```bash
docker ps -a
```

## Remove docker container

```bash
docker container rm -f <container-name>
```
or
```bash
docker rm -f <container-name>
```

## Get docker image of ROS

```bash
docker image pull ros:jazzy
```
or
```bash
docker pull ros:jazzy
```

It could be `ros:humble` or `ros:noetic` or whatever ROS distribution we
want. Generally, this command allows us to get any image from docker
repository like this: `docker pull <image-name>`.

## Run new docker container

```bash
docker container run -it --name <container-name> <image-name>
```
or
```bash
docker run -it --name <container-name> <image-name>
```

Here `run` really means "create new", so use `start` to activate already
existing container. To add a shared directory, use `run` with `-v` flag:

```bash
-v $PWD/outside-dir:/inside-dir
```

Like this:

```bash
docker container run -it --name <container-name> -v $PWD/outside-dir:/inside-dir <image-name>
```

So the contents of `outside-dir/` are awailable inside the docker container
and stored in `inside-dir/`. To run as user:

```bash
docker container run -it --user <username> --name <container-name> -v $PWD/outside-dir:/inside-dir <image-name>
```

## Start existing docker container (which was created with docker run)

```bash
docker container start -i <container-name>
```

or

```bash
docker start -i <container-name>
```

## Stop docker container

```bash
docker container stop <container-name>
```

or

```bash
docker stop <container-name>
```

## Remove all deactivated containers

```bash
docker container prune
```

## Get inside already running container in a new terminal

```bash
docker container exec -it <container-name> /bin/bash
```

or

```bash
docker exec -it <container-name> /bin/bash
```

## Build from dockerfile

```bash
docker image build -t <my-image-name> <path/to/Dockerfile>
```

or

```bash
docker build -t <my-image-name> <path/to/Dockerfile>
```

