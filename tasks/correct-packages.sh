#!/bin/sh
killall apt apt-get;
export DEBIAN_FRONTEND=noninteractive;
dpkg --configure -a;