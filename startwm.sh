#!/bin/bash
rustdesk &
startxfce4 &

(
    sleep 5  # XFCE'nin tam açılmasını bekler

    # Arka plan resmini indir
    wget -q -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg

    # Bütün çalışma alanları için arka planı değiştir
    for workspace in $(xfconf-query -c xfce4-desktop -l | grep "workspace.*/last-image"); do
        xfconf-query -c xfce4-desktop -p "$workspace" -s /tmp/resim.jpg
    done
) &

wait
