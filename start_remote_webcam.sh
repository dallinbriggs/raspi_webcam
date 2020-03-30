#!/bin/bash

ssh pi@192.168.2.4 "python3 /home/pi/raspi_webcam/stream_camera.py"

ffmpeg -i http://192.168.2.4:8081/stream.mjpg -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video2
