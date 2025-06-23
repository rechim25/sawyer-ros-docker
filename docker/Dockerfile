FROM ros:kinetic-robot

ENV DEBIAN_FRONTEND=noninteractive \
    ROS_WS=/root/ros_ws

# ────────────────────────────────────────────────────────────────
# 1. Core OS & ROS-level build tools
# ────────────────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
        git python-rosdep python-rosinstall python-wstool python-vcstools \
        nano \
        build-essential pkg-config \
        python-catkin-pkg \
        python-setuptools \
        ros-kinetic-control-msgs \
        ros-kinetic-joystick-drivers \
        ros-kinetic-xacro \
        ros-kinetic-tf2-ros \
        ros-kinetic-rviz \
        ros-kinetic-cv-bridge \
        ros-kinetic-actionlib \
        ros-kinetic-actionlib-msgs \
        ros-kinetic-dynamic-reconfigure \
        ros-kinetic-trajectory-msgs \
        ros-kinetic-rospy-message-converter \
    && rm -rf /var/lib/apt/lists/*

# ────────────────────────────────────────────────────────────────
# 2. rosdep – initialise once inside the image
# ────────────────────────────────────────────────────────────────
RUN [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ] && rosdep init || echo "rosdep already initialized" \
 && rosdep update

# ────────────────────────────────────────────────────────────────
# 3. Create Catkin workspace and fetch Sawyer SDK
#    (kept in the image so CI builds catch compile errors early)
# ────────────────────────────────────────────────────────────────
RUN mkdir -p $ROS_WS/src
WORKDIR $ROS_WS/src
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash && \
                  cd $ROS_WS && \
                  catkin_make -j$(nproc)"


# ────────────────────────────────────────────────────────────────
# 4. Install Intera Robot SDK
# ────────────────────────────────────────────────────────────────
RUN git clone https://github.com/RethinkRobotics/sawyer_robot.git \
 && wstool init . \
 && wstool merge sawyer_robot/sawyer_robot.rosinstall \
 && wstool update
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash && \
                  cd $ROS_WS && \
                  catkin_make -j$(nproc)"

# Finally, copy intera config file to ws root for accesibility
RUN cp $ROS_WS/src/intera_sdk/intera.sh $ROS_WS/

# ────────────────────────────────────────────────────────────────
# 5. Entrypoint – drops you into a Catkin-aware shell
# ────────────────────────────────────────────────────────────────
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
