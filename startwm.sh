#!/bin/bash

# XFCE başlat
startxfce4 &

# XFCE oturumu başladıktan sonra masaüstü arka planını değiştirmek için bekle
(
sleep 5
    # Arka plan resmini indir
    wget -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg && xfconf-query -c xfce4-desktop -l | grep "last-image" | xargs -I{} xfconf-query -c xfce4-desktop -p "{}" -s "/tmp/resim.jpg" && xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-style -n -t int -s 3
) &

# RustDesk başlat
rustdesk &

# Oturumun sonlandırılmasını engelle
wait
