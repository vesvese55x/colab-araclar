#!/bin/bash

rustdesk & disown
startxfce4 & disown
setxkbmap tr  & disown

# 5 saniye bekle ve ardından resmi indir ve duvar kağıdını ayarla
(sleep 5; wget -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg && for workspace in $(xfconf-query -c xfce4-desktop -l | grep "workspace.*/last-image"); do xfconf-query -c xfce4-desktop -p $workspace -s /tmp/resim.jpg; done) & disown
