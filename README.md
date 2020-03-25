# Raspberry Pi camera as webcam
This is a tutorial on how to create a raspberry pi zero that can stream the video from the raspberry pi camera module over the network so you can do whatever you would like with it. In this case, we are using the video stream as a webcam for another computer that does not have a camera.

## Raspberry pi setup
### OS Setup
First, download the latest raspbian lite image from here: https://www.raspberrypi.org/downloads/raspbian/

Next, burn the image using etcher: https://www.balena.io/etcher/

Enable ssh by creating an empty file in the root of boot:
```
touch /media/$USER/boot/ssh
```

Add the wifi network to `wpa_supplicant.conf` in the root of boot:
```
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="NETWORK-NAME"
    psk="NETWORK-PASSWORD"
}
```

Insert card into Raspberry pi and ssh into it with 
```
ssh pi@raspberrypi.local
```

### Camera Setup
Enable the camera by typing
```
sudo raspi-config
```
and navigating to "Interfacing options" and select "Camera. Then reboot.

#### Install Motion
I'm not sure if this is the best software to do this with, but it appears to be working for now. Install Motion and its dependencies with
```
sudo apt install motion libavcodec-dev libavformat-dev libavutil-dev libjpeg-dev libjpeg62-turbo-dev libpq-dev libswresample-dev
```

Enable the camera driver
```
sudo modprobe bcm2835-v4l2
```

Use this command to check that the camera is visible and displays its settings
```
v4l2-ctl -V
```
You should seem some info about the camera.

In this directory, you should be able to start the camera with the command 
```
sudo ./start_stream.sh
```

## Computer Setup
There are a few things you may need to do in order to stream the video from the raspberry pi on the network to a virtual video device on your computer. 

First, install v4l2loopback:
```
git clone https://github.com/umlaeute/v4l2loopback.git
cd v4l2loopback 
make
sudo make install
sudo depmod -a
```

Then create a virtual video device with the command
```
sudo modprobe v4l2loopback
```
This creates a video device in /dev/video<#> where the number is just one more than the number of video devices that already exist.

### Start the video stream on your computer
If all goes well, you should be able to start the video capture with the command
```
./start_capture.sh
```

## References:
Raspberry pi as webcam: https://raspberrytips.com/raspberry-pi-camera-as-webcam/
RTSP server: https://www.raspberrypi.org/forums/viewtopic.php?t=52071
