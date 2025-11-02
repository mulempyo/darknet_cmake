#!/usr/bin/env bash
set -eo pipefail

if [ -f /opt/ros/foxy/install/setup.bash ]; then
  source /opt/ros/foxy/install/setup.bash
fi

cd /colcon_ws

colcon build --packages-up-to darknet_ros darknet_ros_3d

if [ -f ./install/setup.bash ]; then
  source ./install/setup.bash
fi

exec bash -l