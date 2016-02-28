# Video4Linux

<https://en.wikipedia.org/wiki/Video4Linux>

Libraries and CLI front-end for camera manipulations.

List supported formats for all cameras:

    v4l2-ctl --list-formats-ext

Shows resolution, FPS and encoding (YUYV, MJPEG)

<http://superuser.com/questions/639738/how-can-i-list-the-available-video-modes-for-a-usb-webcam-in-linux>

Each camera appears as a `/dev/videoX` device.
