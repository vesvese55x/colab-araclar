wget -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg && xfconf-query -c xfce4-desktop -l | grep "last-image" | xargs -I{} xfconf-query -c xfce4-desktop -p "{}" -s "/tmp/resim.jpg" && xfconf-query -c xfce4-desktop -p "/backdrop/screen0/monitor0/last-image-style" -s "1" && xfconf-query -c xfce4-desktop -p "/backdrop/screen0/monitor1/last-image-style" -s "1" && xfconf-query -c xfce4-desktop -p "/backdrop/workspace0/last-image-style" -s "1" && xfconf-query -c xfce4-desktop -p "/backdrop/workspace1/last-image-style" -s "3"

