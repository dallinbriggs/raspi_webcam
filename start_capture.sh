#!/bin/bash

ffmpeg -i http://192.168.2.4:8081/stream.mjpg -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video2
