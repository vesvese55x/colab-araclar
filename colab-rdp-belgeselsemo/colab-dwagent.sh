#!/bin/bash
sed -i 's/\r$//' "$0"

# Started Message
echo -e "\n\n\e[1;36m============================= İŞLEMLER BAŞLADI (BELGESELSEMO.COM.TR) =============================\e[0m"
echo -e "\n\e[1;31mGerekli işlemler yapılıyor. Lütfen bekleyiniz... (Yaklaşık 7-8 dk sonra GÖREV TAMAMLANDI yazısı görünecektir...) \e[0m"
echo -e "\e[1;31mPerforming necessary operations. Please wait... (After approximately 7-8 minutes, the MISSION COMPLETED message will appear...) \e[0m"
echo -e "\n\e[1;36m============================= STARTING PROCESSES (BELGESELSEMO.COM.TR) =============================\e[0m"

# Set root password
echo "root:root" | sudo chpasswd > /dev/null 2>&1

# Install XFCE4 Desktop and necessary packages
sudo apt update > /dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt-get install keyboard-configuration > /dev/null 2>&1
sudo apt install -y xfce4 xfce4-goodies handbrake celluloid rclone lxterminal firefox mkvtoolnix-gui neofetch python3 python3-pip stacer > /dev/null 2>&1
sudo update-alternatives --set x-terminal-emulator /usr/bin/lxterminal > /dev/null 2>&1

# Install Qemu-KVM & Virt-Manager and necessary packages
apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager > /dev/null 2>&1 && (command -v systemctl > /dev/null 2>&1 && systemctl enable libvirtd --now > /dev/null 2>&1 || (command -v service > /dev/null 2>&1 && (service libvirtd start > /dev/null 2>&1 && update-rc.d libvirtd defaults > /dev/null 2>&1) || (command -v initctl > /dev/null 2>&1 && initctl start libvirtd > /dev/null 2>&1 || echo "Sistem init sistemi tanınamadı. libvirtd servisi başlatılamadı."))) && usermod -aG libvirt $(whoami) > /dev/null 2>&1

# Install Brave-Browser
curl -fsS https://dl.brave.com/install.sh | sh > /dev/null 2>&1
wget -q -O /opt/brave.com/brave/brave-browser https://raw.githubusercontent.com/vesvese55x/colab-araclar/refs/heads/main/brave-browser && chmod +x /opt/brave.com/brave/brave-browser


# Install Wine and 32-bit architecture support
sudo apt-get install -y wine > /dev/null 2>&1
sudo dpkg --add-architecture i386 > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1
sudo apt-get install -y wine32 > /dev/null 2>&1
sudo apt --fix-broken install > /dev/null 2>&1

# Install Crossover, TeraBox and RustDesk
wget https://media.codeweavers.com/pub/crossover/cxlinux/demo/crossover_24.0.4-1.deb > /dev/null 2>&1
sudo apt install -y ./crossover_24.0.4-1.deb > /dev/null 2>&1
sudo apt --fix-broken install > /dev/null 2>&1

wget https://data.nephobox.com/issue/terabox/Linux/1.9.1/TeraBox_1.9.1_amd64.deb > /dev/null 2>&1
sudo apt install -y ./TeraBox_1.9.1_amd64.deb > /dev/null 2>&1
sudo apt --fix-broken install > /dev/null 2>&1
pip install streamlink > /dev/null 2>&1

wget https://github.com/rustdesk/rustdesk/releases/download/1.3.7/rustdesk-1.3.7-x86_64.deb > /dev/null 2>&1
sudo apt install -y ./rustdesk-1.3.7-x86_64.deb > /dev/null 2>&1
sudo apt --fix-broken install > /dev/null 2>&1

# Preparing the Desktop Icons
for dir in ~/Desktop ~/Documents; do
    [ -f "$dir" ] && sudo rm -f "$dir"
    [ ! -d "$dir" ] && mkdir "$dir"
done
cp /usr/share/applications/brave-browser.desktop ~/Desktop
cp /usr/share/applications/firefox.desktop ~/Desktop
cp /usr/share/applications/terabox.desktop ~/Desktop
cp /usr/share/applications/fr.handbrake.ghb.desktop ~/Desktop/HandBrake.desktop
cp /usr/share/applications/rustdesk.desktop ~/Desktop
cp /usr/share/applications/stacer.desktop ~/Desktop
cp /usr/share/applications/org.bunkus.mkvtoolnix-gui.desktop ~/Desktop/MKV-ToolNix.desktop
cp /usr/share/applications/virt-manager.desktop ~/Desktop
cp /usr/share/applications/io.github.celluloid_player.Celluloid.desktop ~/Desktop/Celluloid.desktop
cp /usr/share/applications/lxterminal.desktop ~/Desktop

wget -q -O ~/Documents/gdrive-dropbox-mounter  https://raw.githubusercontent.com/vesvese55x/colab-araclar/refs/heads/main/gdrive-dropbox-mounter
wget -q -O ~/Documents/drive-vs-dropbox.jpg https://www.pcworld.com/wp-content/uploads/2023/04/drive-vs-dropbox.jpg
wget -q -O ~/Desktop/gdrive-dropbox-mounter.desktop  https://raw.githubusercontent.com/vesvese55x/colab-araclar/refs/heads/main/gdrive-dropbox-mounter.desktop
chmod +x ~/Desktop/*.desktop

# Installing Dbus-GDM-Video Dummy
apt install -y dbus-x11 gdm3 xserver-xorg-video-dummy > /dev/null 2>&1

# Starting Dbus
echo "startxfce4" > ~/.xsession
service dbus start > /dev/null 2>&1

# Connection configuration
bash -c 'echo -e "Section \"Monitor\"\n    Identifier \"Monitor0\"\nEndSection\n\nSection \"Device\"\n    Identifier \"Device0\"\n    Driver \"dummy\"\n    VideoRam 256000\nEndSection\n\nSection \"Screen\"\n    Identifier \"Screen0\"\n    Device \"Device0\"\n    Monitor \"Monitor0\"\n    SubSection \"Display\"\n        Modes \"1920x1080\"\n    EndSubSection\nEndSection" > /etc/X11/xorg.conf.d/10-monitor.conf' > /dev/null 2>&1

echo '#!/bin/bash
wget -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg
xfconf-query -c xfce4-desktop -l | grep "last-image" | xargs -I{} xfconf-query -c xfce4-desktop -p "{}" -s "/tmp/resim.jpg"
xfconf-query -c xfce4-desktop -p "/backdrop/screen0/monitor0/last-image-style" -s "1"
xfconf-query -c xfce4-desktop -p "/backdrop/screen0/monitor1/last-image-style" -s "1"
xfconf-query -c xfce4-desktop -p "/backdrop/workspace0/last-image-style" -s "1"
xfconf-query -c xfce4-desktop -p "/backdrop/workspace1/last-image-style" -s "1"' > ~/Desktop/wallpaper-changer && chmod +x ~/Desktop/wallpaper-changer


# Starting XFCE4
systemctl restart gdm3
startxfce4 &>/dev/null &
bash ~/Desktop/wallpaper-changer.sh &

sleep 2  

clear
echo -e "\n\n\e[1;36m============================= GÖREV TAMAMLANDI (BELGESELSEMO.COM.TR) =============================\e[0m"
echo -e "\nİşleminiz başarıyla tamamlanmıştır. Sol üstteki ⠿ simgesine tıklayın. Sonra \e[31m🖥️ (Ekran)\e[0m simgesine tıklayarak Sanal Makine'nize bağlanabilirsiniz... "
echo -e "Your operation has been completed successfully. Click the ⠿ icon in the top left. Then click the \e[31m🖥️ (Screen)\e[0m icon to connect to your Virtual Machine..."
echo -e "\n\e[1;36m============================= MISSION COMPLETED (BELGESELSEMO.COM.TR) =============================\e[0m"

