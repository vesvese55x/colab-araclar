#!/bin/bash
sed -i 's/\r$//' "$0"

# Started Message
echo -e "\n\n\e[1;36m============================= İŞLEMLER BAŞLADI (BELGESELSEMO.COM.TR) =============================\e[0m"
echo -e "\n\e[1;31mGerekli işlemler yapılıyor. Lütfen bekleyiniz...\e[0m"
echo -e "\e[1;31mPerforming necessary operations. Please wait...\e[0m"
echo -e "\n\e[1;36m============================= STARTING PROCESSES (BELGESELSEMO.COM.TR) =============================\e[0m"

# Set root password
echo "root:belgeselsemo" | sudo chpasswd > /dev/null 2>&1

# Install XFCE4 Desktop and necessary packages
sudo apt update > /dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt-get install keyboard-configuration > /dev/null 2>&1
sudo apt install -y xfce4 xfce4-goodies handbrake celluloid rclone xrdp lxterminal mkvtoolnix-gui neofetch python3 python3-pip stacer webhttrack > /dev/null 2>&1
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
wget https://media.codeweavers.com/pub/crossover/cxlinux/demo/crossover_24.0.6-1.deb > /dev/null 2>&1
sudo apt install -y ./crossover_24.0.6-1.deb > /dev/null 2>&1
sudo apt --fix-broken install > /dev/null 2>&1

wget https://data.nephobox.com/issue/terabox/Linux/1.9.1/TeraBox_1.9.1_amd64.deb > /dev/null 2>&1
sudo apt install -y ./TeraBox_1.9.1_amd64.deb > /dev/null 2>&1
sudo apt --fix-broken install > /dev/null 2>&1
pip install streamlink > /dev/null 2>&1

wget https://github.com/rustdesk/rustdesk/releases/download/1.3.7/rustdesk-1.3.7-x86_64.deb > /dev/null 2>&1
sudo apt install -y ./rustdesk-1.3.7-x86_64.deb > /dev/null 2>&1
sudo apt --fix-broken install > /dev/null 2>&1

# Preparing the Desktop Icons & Changign the Desktop Wallpaper
sudo rm -rf ~/Desktop && mkdir ~/Desktop
sudo rm -rf ~/Documents && mkdir ~/Documents
cp /usr/share/applications/brave-browser.desktop ~/Desktop
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
wget -q -O ~/Desktop/wallpaper-changer.sh https://github.com/vesvese55x/colab-araclar/raw/refs/heads/main/walpaper-changer.sh && chmod +x ~/Desktop/wallpaper-changer.sh
chmod +x ~/Desktop/*.desktop
wget -q -O /usr/share/backgrounds/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg 
sudo cp /usr/share/backgrounds/resim.jpg /usr/share/backgrounds/xfce/xfce-blue.jpg
sudo cp /usr/share/backgrounds/resim.jpg /usr/share/backgrounds/xfce/xfce-stripes.png
sudo cp /usr/share/backgrounds/resim.jpg /usr/share/backgrounds/xfce/xfce-teal.jpg
sudo cp /usr/share/backgrounds/resim.jpg /usr/share/backgrounds/xfce/xfce-verticals.png
sudo cp /usr/share/backgrounds/resim.jpg /usr/share/backgrounds/greybird.svg

# Install NoVNC and TigerVNC
sudo apt install -y tigervnc-standalone-server novnc websockify > /dev/null 2>&1

# Configure VNC
mkdir -p ~/.vnc
echo "belgeselsemo" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd
echo 'startxfce4 &' >> ~/.vnc/xstartup

# Start VNC Server
vncserver :1 -geometry 1360x768 -depth 24 > /dev/null 2>&1

# Start NoVNC
websockify -D --web=/usr/share/novnc/ 6080 localhost:5901 > /dev/null 2>&1
sleep 5

# Install Cloudflared and create a tunnel
wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb > /dev/null 2>&1
sudo dpkg -i cloudflared.deb > /dev/null 2>&1
cloudflared tunnel --url localhost:6080 > cloudflared.log 2>&1 &
sleep 5

link=$(grep -oP 'https://[a-zA-Z0-9.-]+\.trycloudflare\.com' cloudflared.log | head -n 1)

# Clear the screen before displaying the final messages
clear

if [ -z "$link" ]; then
  echo -e "\e[1;31mURL alınamadı. Cloudflared loglarını kontrol edin.\e[0m"
else
  echo -e "\n"
  echo -e "\e[1;36m============================= TÜRKÇE TALİMATLAR =============================\e[0m"
  echo -e "\e[1;35mWeb tarayıcınızda şu bağlantıyı açın:\e[1;31m $link/vnc.html \e[0m"
  echo -e "\e[1;35mNoVNC Şifresi: \e[1;31mbelgeselsemo\e[0m"
  echo -e "\e[1;35mTR Klavye ve VLC Fix Komutu:\e[1;31m setxkbmap tr && sed -i 's/geteuid/getppid/' /usr/bin/vlc\e[0m"
  echo -e "\e[1;35mYüklenen Extra Programlar:\e[1;31m Wine-VLC-Firefox-Android Studio-LXTerminal-Handbrake-MKVToolNix-RClone-Stacer-Streamlink-Terabox-CrossOver\e[0m"
  echo -e "\n\e[1;30mBu içerik \e[1;34mCHATGPT\e[1;30m ve \e[1;34mDEEPSEEK\e[1;30m sayesinde \e[1;34mhttps://belgeselsemo.com.tr\e[1;30m sitesi tarafından oluşturulmuştur.\e[0m"
  echo -e "\n\n\e[1;36m============================ ENGLISH INSTRUCTIONS ============================\e[0m"
  echo -e "\e[1;35mOpen the following link in your web browser:\e[1;31m $link/vnc.html \e[0m"
  echo -e "\e[1;35m- Password: \e[1;31mbelgeselsemo\e[0m"
  echo -e "\e[1;35mTR Keyboard and VLC Fix Command:\e[1;31m setxkbmap tr && sed -i 's/geteuid/getppid/' /usr/bin/vlc\e[0m"
  echo -e "\e[1;35mInstalled Extra Apps:\e[1;31m Wine-VLC-Firefox-Android Studio-LXTerminal-Handbrake-MKVToolNix-RClone-Stacer-Streamlink-Terabox-CrossOver\e[0m"
  echo -e "\n\e[1;30mThis content is created with the help of \e[1;34mCHATGPT\e[1;30m and \e[1;34mDEEPSEEK\e[1;30m by \e[1;34mhttps://belgeselsemo.com.tr\e[1;30m.\e[0m"
fi

