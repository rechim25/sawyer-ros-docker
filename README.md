# Sawyer Robot Docker Workspace

## Docker - Quick Start

```bash
# Build the image
sudo docker compose build
```

```sh
# Run the image
sudo docker compose run --rm sawyer_dev
```

## ROS Env Setup
```sh
source /opt/ros/kinetic/setup.bash
catkin_make
./intera.sh
```

## Sawyer Robot Setup

The docs can be found [here](https://web.archive.org/web/20180809121510/http://sdk.rethinkrobotics.com/intera/Main_Page).

### Networking
Let us first configure networking between your workstation (e.g., laptop) and robot.
First, we need to enter the [Field Service Menu (FSM) as in this doc](web.archive.org/web/20180809121510/http://sdk.rethinkrobotics.com/intera/Field_Service_Menu_(FSM)).
- Connect keyboard to robot on the USB port outside of controller.
- Turn off the robot and then turn it on
- Once the robot is booting, continuously press CTRL+F on the keyboard.
- At some point you should be in FSM.

In the FSM, we will set the robot to use a static IP and ROS_IP addressing:
- In the FSM, go to the configuration of the outside port
- Change IP mode to `Static IP`
- Then set a static IP, subnet mask and gateway. In my case it's set to `192.168.1.3`, `255.255.255.0`, and `192.168.1.1`.
- Save the settings and go back

Now, we need to reboot the robot in <b>SDK mode</b>:
- In the FSM main page, select `Next Boot in` to `SDK`.

<b>Note: we always need to boot the robot in SDK mode if we intend to control it with ROS<b>

Additional information can be found in [Networking](https://web.archive.org/web/20180809121510/http://sdk.rethinkrobotics.com/intera/Networking). We now completed the setup with a router in between your workstation (e.g., laptop) and robot and set the robot to use ROS_IP addressing instead of ROS_HOSTNAME.local.

### Workstation Setup (ROS Kinetic)
Follow [Workstation Setup](https://web.archive.org/web/20180728200200/http://sdk.rethinkrobotics.com/intera/Workstation_Setup). Make sure to use ROS Kinetic.


