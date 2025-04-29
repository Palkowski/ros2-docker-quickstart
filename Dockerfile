# specify the ROS distribution
FROM osrf/ros:jazzy-desktop-full

## install vim
#RUN apt-get update && apt-get install -y vim && rm -rf /var/lib/apt/lists/*

## copy vim config
#COPY configs/.vimrc /root/

# install ros dev tools
RUN apt-get update \
  && apt-get install -y ros-dev-tools \
  && rm -rf /var/lib/apt/lists/*

# create a non-root user
ARG USERNAME=ros
ARG USER_UID=1001
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && mkdir /home/$USERNAME/.config \
  && chown $USER_UID:$USER_GID /home/$USERNAME/.config

# USER ros
# to do something as a user
# USER root
# to do as a root

# set up sudo
# RUN apt-get update \
#   && apt-get install -y sudo \
#   && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
#   && chmod 0440 /etc/sudoers.d/$USERNAME \
#   && rm -rf /var/lib/apt/lists/*

# copy bash config
COPY configs/.bashrc /home/${USERNAME}/

# add entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["bin/bash", "/entrypoint.sh"]
CMD ["bash"]

