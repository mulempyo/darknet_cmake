#!/usr/bin/env bash
set -eo pipefail

# ROS2 환경
if [ -f /opt/ros/foxy/install/setup.bash ]; then
  source /opt/ros/foxy/install/setup.bash
fi

# 워크스페이스로 이동
cd /colcon_ws

# 빌드
colcon build --packages-select darknet_ros darknet_ros_3d

# 워크스페이스 환경 반영
if [ -f ./install/setup.bash ]; then
  source ./install/setup.bash
fi