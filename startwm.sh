#!/bin/bash
# XRDP için XFCE4 başlatma, klavye düzenini ayarlama ve masaüstü yapılandırma komutları

# Ortam değişkenlerini yükle
export LANG=C.UTF-8
export DISPLAY=:0

# XFCE4 ve RustDesk başlat
startxfce4 &
rustdesk &

# Klavye düzenini Türkçe yap
setxkbmap tr

# Resmi indir
wget -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg

# Birkaç saniye bekleyerek oturumun tam açılmasını sağla
sleep 5

# Masaüstü arka planını değiştir
xfconf-query -c xfce4-desktop -l | grep "last-image" | xargs -I{} xfconf-query -c xfce4-desktop -p "{}" -s "/tmp/resim.jpg"

# İşlemleri bitir ve oturumun çalışmasını sağla
exec /bin/sh /etc/X11/Xsession
