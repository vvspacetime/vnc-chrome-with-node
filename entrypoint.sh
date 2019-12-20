#!/bin/bash

echo "RTCEngine AutoTest Start!"

echo "Start VNC Server"
export DISPLAY=:99
./start-vnc.sh

echo "Node run main.js"
node main.js