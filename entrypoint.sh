#!/usr/bin/env bash
set -euo pipefail

AUTO_BUILD="${AUTO_BUILD:-1}"    
BUILD_LOG="${BUILD_LOG:-/colcon_ws/build-startup.log}"

ROS_SETUP="/opt/ros/foxy/install/setup.bash"
WS="/colcon_ws"

if [ -f "$ROS_SETUP" ]; then
  source "$ROS_SETUP"
fi

if [ -d "$WS" ]; then
  cd "$WS"
fi

STAMP1="$WS/install/.built_darknet_ros"
STAMP2="$WS/install/.built_darknet_ros_3d"

if [ "${AUTO_BUILD}" = "1" ] && [ -d "$WS/src" ]; then
  set +e
  {
    echo "=== [startup build] begin: $(date) ==="

    if [ ! -f "$STAMP1" ]; then
      echo "[1/2] colcon build --packages-select darknet_ros"
      colcon build --packages-select darknet_ros
      STATUS=$?
      if [ $STATUS -ne 0 ]; then
        echo "[ERROR] darknet_ros build failed (exit $STATUS)"
      else
        touch "$STAMP1"
        echo "[OK] darknet_ros built"
        [ -f "$WS/install/setup.bash" ] && source "$WS/install/setup.bash"
      fi
    else
      echo "[skip] darknet_ros already built"
    fi

    if [ ! -f "$STAMP2" ]; then
      echo "[2/2] colcon build --packages-up-to darknet_ros_3d"
      colcon build --packages-up-to darknet_ros_3d
      STATUS=$?
      if [ $STATUS -ne 0 ]; then
        echo "[ERROR] darknet_ros_3d up-to build failed (exit $STATUS)"
      else
        touch "$STAMP2"
        echo "[OK] darknet_ros_3d (up-to) built"
      fi
    else
      echo "[skip] darknet_ros_3d already built"
    fi

    echo "=== [startup build] end: $(date) ==="
  } | tee -a "$BUILD_LOG"
  set -e
fi

if [ -f "$WS/install/setup.bash" ]; then
  source "$WS/install/setup.bash"
fi

exec "$@"
