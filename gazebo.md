# Gazebo

Most popular open source robot simulator.

http://gazebosim.org/

http://www.osrfoundation.org/

Demo: https://www.youtube.com/watch?v=RvfuKP5m0w0

Ubuntu install:

    sudo apt-get install gazebo6

List available demo worlds:

    ls /usr/share/gazebo-X.Y/worlds

Those models are on a separate repository:

    https://bitbucket.org/osrf/gazebo_models/src

Run a world:

    gazebo worlds/pioneer2dx.world

Can use multiple physics engines, including ODE and Bullet.

## Client and server

Uses a server client model.

Each client is a "window".

When you run:

    gazebo worlds/pioneer2dx.world

it starts both the client and the server.

## Controls

Rotate view: shift + mouse drag.

## Control robot

TODO

http://answers.ros.org/question/67472/gazebo-how-to-control-robots-models/
http://answers.gazebosim.org/question/4447/how-to-control-a-robot/
http://gazebosim.org/tutorials/?tut=ros_control

## Restart simulation

http://answers.gazebosim.org/question/8801/how-to-reset-the-simulation/

In particular, closing the GUI does not reset the simulation, which runs in the sever: http://answers.ros.org/question/64896/gazebo-world-not-reset-on-fresh-launch/
