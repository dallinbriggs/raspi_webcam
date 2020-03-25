#!/bin/bash

ffmpeg -i tcp://192.168.2.172:8081 -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video2
