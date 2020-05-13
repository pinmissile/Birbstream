#!/bin/bash
source config.sh
streaming="0"
day="0"
while true
do
  hour=$(date +\"%H\")
  if [[ $hour =~ ^(\"21\"|\"22\"|\"23\"|\"00\"|\"01\"|\"02\"|\"03\"|\"04\"|\"05\"|\"06\"|\"19\")$ ]]; then
    if [ $day == "1" ]
    then
      killall ffmpeg
      streaming="0"
    fi
    day="0"
    stream_cmd="-f video4linux2 -s 1920x1080 -framerate 30 -i /dev/video2 -c:v h264_omx -threads 0 -an -f flv"
  else
    if [ $day == "0" ]
      then
      killall ffmpeg
      streaming="0"
    fi
    day="1"
    stream_cmd="-f video4linux2 -s 1280x720 -framerate 24 -i /dev/video0 -c:v h264_omx -threads 0 -an -f flv"
  fi
  ping -c 1 www.twitch.tv &> /dev/null
  if [[ $? -eq 0 ]] ; then
    if [ $streaming -eq "0" ]
    then
      echo "Connection established. Starting stream in 60 seconds."
      sleep 2
      ../FFMpeg/ffmpeg $stream_cmd $stream_url &
      streaming="1"
    fi
  elif [ $streaming -eq "1" ]
  then
    echo "Connection lost. Killing stream."
    killall ffmpeg
    streaming="0"
  fi
  sleep 10
done
