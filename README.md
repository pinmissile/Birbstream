Currently using h264 encoding to hardware accelerate the NoIR camera, which is very dumb since the framerate ends up being horrible. I unfortunatly didn't really have the motivation to fix that since the bird's nest I streamed got absolutely demolished by a crow.
# Bird Stream
A simple shell script for streaming a video feed of an outdoors bird's nest on www.twitch.tv with two cameras - One for day and one for night. The script automatically closes the stream if it loses connection to twitch.tv, restarts upon reconnecting, and will switch between the cameras depending on the local time. (06 - 21 for day, and the rest for night)
## Hardware
I used a [Raspberry Pi 3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) running Raspbian 4.19, a [Pi NoIR Camera](https://www.raspberrypi.org/products/pi-noir-camera-v2/), and a [Logitech C270 USB camera](https://www.amazon.com/Logitech-Desktop-Widescreen-Calling-Recording/dp/B004FHO5Y6). A case for the Raspberry Pi, as well as an IR spotlight is also recommended.
## Software
Setup is fairly straightforward, but since video inputs may from unit to unit, it might be necessairy to do some minor changes in the script to get it to run for you. We're gonna be using FFMpeg to hardware accelerate the webcam footage. I used [this]([https://blog.veloc1ty.de/2018/10/29/raspberry-pi-3-stream-webcam-to-twitch/](https://blog.veloc1ty.de/2018/10/29/raspberry-pi-3-stream-webcam-to-twitch/)) guide by veloc1ty, but I'll go through all the steps here anyway. If you want more details, check out the guide.
### Dependencies
Install the required software:
```
apt-get install autoconf automake build-essential libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev libomxil-bellagio-dev git
```
Clone the FFMpeg repo:
```
git clone https://github.com/ffmpeg/FFMpeg --depth 1
```
Clone this repo:
```
git clone https://github.com/pinmissile/Bird-Stream.git
```
### Configuring
Configure the FFMpeg script:
```
./configure --enable-gpl --enable-nonfree --enable-mmal --enable-omx --enable-omx-rpi
```
Compile it:
```
make -j4
```
Make sure to enable the Raspberry Pi camera by running `raspi-config` and enabling Camera under Interface.
# BirbStream
A simple shell script for streaming a video feed of an outdoors bird's nest on www.twitch.tv with two cameras - One for day and one for night. The script automatically closes the stream if it loses connection to twitch.tv, restarts upon reconnecting, and will switch between the cameras depending on the local time. (06 - 21 for day, and the rest for night)
## Hardware
I used a [Raspberry Pi 3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) running Raspbian 4.19, a [Pi NoIR Camera](https://www.raspberrypi.org/products/pi-noir-camera-v2/), and a [Logitech C270 USB camera](https://www.amazon.com/Logitech-Desktop-Widescreen-Calling-Recording/dp/B004FHO5Y6). A case for the Raspberry Pi, as well as an IR spotlight is also recommended.
## Software
Setup is fairly straightforward, but since video inputs may from unit to unit, it might be necessairy to do some minor changes in the script to get it to run for you. We're gonna be using FFMpeg to hardware accelerate the webcam footage and stream it. I used [this]([https://blog.veloc1ty.de/2018/10/29/raspberry-pi-3-stream-webcam-to-twitch/](https://blog.veloc1ty.de/2018/10/29/raspberry-pi-3-stream-webcam-to-twitch/)) guide by veloc1ty, but I'll go through all the steps here anyway. If you want more details, check out the guide.
### Dependencies
Install the required software:
```
apt-get install autoconf automake build-essential libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev libomxil-bellagio-dev git
```
Clone the FFMpeg repo:
```
git clone https://github.com/ffmpeg/FFMpeg --depth 1
```
Clone this repo:
```
git clone https://github.com/pinmissile/Bird-Stream.git
```
### Configuring
Configure the FFMpeg script:
```
./configure --enable-gpl --enable-nonfree --enable-mmal --enable-omx --enable-omx-rpi
```
Compile it:
```
make -j4
```
Make sure to enable the Raspberry Pi camera by running `raspi-config` and enabling Camera under Interface.

Create the config file. This is where you put your stream key, which can be found in your Twitch Channel Settings:
```
cd Bird-Stream/
echo stream_url="rtmp://live.twitch.tv/app/{yourlivekey}" > config.sh
```
If you don't want to stream on Twitch, you can always switch that out for a different rtmp URL.
### How To Run
After installing dependencies and configuring, all you need to do is:
``` 
bash stream.sh
```
Adding a `cron` job to run the script on boot is recommended in the event of a power outage. 
If you're having trouble running the NoIR camera, you may have to increase the available memory for the GPU with the command `gpu_mem_256`.

## Known Issues
Currently using h264 encoding to hardware accelerate the NoIR camera, which is very dumb since the framerate ends up being horrible. I unfortunatly didn't really have the motivation to fix that since the bird's nest I streamed got absolutely demolished by a crow.
Create the config file. This is where you put your stream key, which can be found in your Twitch Channel Settings:
```
cd Bird-Stream/
echo stream_url="rtmp://live.twitch.tv/app/{yourlivekey}" > config.sh
```
If you don't want to stream on Twitch, you can always switch that out for a different rtmp URL.
### How To Run
After installing dependencies and configuring, all you need to do is:
``` 
bash stream.sh
```
Adding a `cron` job to run the script on boot is recommended in the event of a power outage. 
If you're having trouble running the NoIR camera, you may have to increase the available memory for the GPU with the command `gpu_mem_256`.

## Known Issues
Currently using h264 encoding to hardware accelerate the NoIR camera, which is very dumb since the framerate ends up being horrible. I unfortunatly didn't really have the motivation to fix that since the bird's nest I streamed got absolutely demolished by a crow.