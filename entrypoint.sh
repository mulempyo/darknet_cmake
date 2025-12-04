#!/usr/bin/env bash
set -eo pipefail

if [ -f /opt/ros/foxy/install/setup.bash ]; then
  source /opt/ros/foxy/install/setup.bash
fi

cd /colcon_ws

colcon build --packages-up-to kwj_description darknet_ros_msgs gb_visual_detection_3d_msgs darknet_ros darknet_ros_3d mpc_ros

if [ -f ./install/setup.bash ]; then
  source ./install/setup.bash
fi

exec bash -l