#!/bin/bash

rustdesk &
startxfce4 &
setxkbmap tr &

(sleep 5 
wget -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg && xfconf-query -c xfce4-desktop -l | grep "last-image" | xargs -I{} xfconf-query -c xfce4-desktop -p "{}" -s "/tmp/resim.jpg") &

wait
