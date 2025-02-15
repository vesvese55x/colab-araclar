#!/bin/bash

# XFCE başlat
startxfce4 &

# XFCE oturumu başladıktan sonra masaüstü arka planını değiştirmek için bekle
(

    # Arka plan resmini indir
    wget -q -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg

    # Bütün çalışma alanları için arka planı değiştir
    for workspace in $(xfconf-query -c xfce4-desktop -l | grep "workspace.*/last-image"); do
        xfconf-query -c xfce4-desktop -p "$workspace" -s /tmp/resim.jpg
    done
) &

# RustDesk başlat
rustdesk &

# Oturumun sonlandırılmasını engelle
wait
