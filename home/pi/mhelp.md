MCLIENT
=======

Configuration for automatic media playback from USB and network sources.

The service starts automatically on boot, so you should not normally have to interact with it directly. The service that manages playback is lovingly known as `mclient`. Under the hood it's just a shell script that looks for media in an attached USB device and listens for streaming media. Media playback is delegated to the built-in `omxplayer`. The script is managed by `runit`.

In essence, `mclient` simply wraps the single command `omxplayer -r udp://0.0.0.0:8080 `. See `etc/sv/mclient/run` for the actual script.

SUPPORTED MEDIA FORMATS:
------------------------

Currently, only MP4-encoded media is known to be supported.

PLAYING MEDIA FROM USB DRIVE:
-----------------------------

Attach a USB drive to this device. mclient will attempt to play back any supported media file it finds in the root directory.

STREAMING MEDIA OVER THE NETWORK:
---------------------------------

When mclient is running it listens for UDP traffic on port 8080. VLC provides a convenient UI for streaming over UDP. Give it the local IP of this device, select port 8080, and make sure "UDP" is selected and that the video is encapsulated with MPEG TS. If the file you're trying to play is not an MP4, you may have to set transcoding options as well.
Alternatively, you can use `ffmpeg` for more advanced streaming.

FFMPEG SIMPLE EXAMPLE:
----------------------

```sh
# stream an MP4 file over UDP (don't forget to update the video path and IP)
ffmpeg -re -i ./my-video.mp4 -c copy -f mpegts udp://xxx.xxx.x.x:8080
```

FFMPEG MULTI-OUTPUT EXAMPLE:
-------------------------

```sh
# stream to multiple IPs directly from ffmpeg
ffmpeg -re -i ./my-video.mp4 -f tee -map 0:v \
"[f=mpegts:onfail=ignore]udp://xxx.xxx.x.x:8080\
|[f=mpegts:onfail=ignore]udp://xxx.xxx.x.x:8080"
```

FFMPEG ADVANCED EXAMPLE:
------------------------

```sh
# stream from Mac webcam input
ffmpeg \
-f avfoundation \
-s 1280x720 \
-pix_fmt uyvy422 \
-framerate 15 \
-i "0" \
-vcodec libx264 \
-pix_fmt yuv420p \
-preset ultrafast \
-tune zerolatency \
-thread_type slice \
-slices 1 \
-intra-refresh 1 \
-b:v 400KB \
-s 1280x720 \
-r 15 \
-g 30 \
-f mpegts \
udp://xxx.xxx.x.x:8080
```

DEBUGGING
---------

If you're streaming to the device but not seeing playback, first make sure the packets are reaching the right port:

```sh
# listen on port 8080 and print to STDOUT
socat - UDP-LISTEN:8080
```

If you do not see output, leave `socat` running above and test the network from the streaming host:

```sh
# read from STDIN and send to pi
socat - UDP-SENDTO:xxx.xxx.x.xxx:8080  # set the pi's IP
```

Once the network is functioning, verify that mclient is running:

```sh
# print process status
mstatus
```

Else check a known good file against omxplayer directly:

```sh
omxplayer /opt/vc/src/hello_pi/hello_video/test.h264
```
