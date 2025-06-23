#!/usr/bin/env bash
set -e
source /opt/ros/kinetic/setup.bash
source /root/ros_ws/devel/setup.bash
exec "$@"
