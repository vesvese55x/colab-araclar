#!/bin/bash

# XFCE oturumu başladıktan sonra masaüstü arka planını değiştirmek için bekle
(
    sleep 5  # XFCE'nin tam açılmasını bekler

    # Arka plan resmini indir
    wget -q -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg

xfconf-query -c xfce4-desktop -p /xfce4-desktop/background/last-image -s /tmp/resim.jpg
) &

# RustDesk başlat
rustdesk &

# XFCE başlat
startxfce4 &



# Oturumun sonlandırılmasını engelle
wait


