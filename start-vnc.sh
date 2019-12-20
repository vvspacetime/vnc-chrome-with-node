export DISPLAY=:99
Xvfb :99 -screen 0 1366x768x16 &
x11vnc -passwd TestVNC -display :99 -N -forever &