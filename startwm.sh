#!/bin/bash
# XRDP için XFCE4 başlatma, klavye düzenini ayarlama ve masaüstü resmi değiştirme komutları

# XFCE4 ve RustDesk başlat
startxfce4 &
rustdesk &

# Klavye düzenini Türkçe yap
setxkbmap tr

# Resmi indir
wget -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg

# Birkaç saniye bekleyerek oturumun tam açılmasını sağla
sleep 3

# Masaüstü arka planını değiştir
xfconf-query -c xfce4-desktop -p /xfce4-desktop/background/last-image -s /tmp/resim.jpg

# İşlemi bitir
exec /bin/sh /etc/X11/Xsession
