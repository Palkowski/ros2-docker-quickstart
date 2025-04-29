#!/bin/bash

set -e

source /opt/ros/jazzy/setup.bash

echo "provided arguments: $@"

exec $@

