#!/bin/bash


# XFCE oturumu başladıktan sonra masaüstü arka planını değiştirmek için bekle
(
    # Arka plan resmini indir
    wget -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg && xfconf-query -c xfce4-desktop -l | grep "last-image" | xargs -I{} xfconf-query -c xfce4-desktop -p "{}" -s "/tmp/resim.jpg" && xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-style -n -t int -s 3
) &

# XFCE başlat
sleep 5
startxfce4 &

# RustDesk başlat
rustdesk &

# Oturumun sonlandırılmasını engelle
wait
