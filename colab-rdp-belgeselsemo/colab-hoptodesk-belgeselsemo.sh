#!/bin/bash
sed -i 's/\r$//' "$0"

# Başlangıç mesajı
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
sudo apt remove --purge xfce4-power-manager -y > /dev/null 2>&1

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
sudo dpkg -i crossover_24.0.6-1.deb > /dev/null 2>&1
sudo apt-get install -f > /dev/null 2>&1

wget https://data.nephobox.com/issue/terabox/Linux/1.9.1/TeraBox_1.9.1_amd64.deb > /dev/null 2>&1
sudo apt install -y ./TeraBox_1.9.1_amd64.deb > /dev/null 2>&1
sudo apt --fix-broken install > /dev/null 2>&1
pip install streamlink > /dev/null 2>&1

wget https://github.com/rustdesk/rustdesk/releases/download/1.3.7/rustdesk-1.3.7-x86_64.deb > /dev/null 2>&1
sudo apt install -y ./rustdesk-1.3.7-x86_64.deb > /dev/null 2>&1
sudo apt --fix-broken install > /dev/null 2>&1

# NoMachine Yükle
wget https://download.nomachine.com/download/8.16/Linux/nomachine_8.16.1_1_amd64.deb > /dev/null 2>&1
dpkg -i nomachine_8.16.1_1_amd64.deb > /dev/null 2>&1
apt --fix-broken install -y > /dev/null 2>&1

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


# === Xvfb başlat ===
echo -e "${INFO}🚀 Sanal ekran (Xvfb) başlatılıyor...${RESET}"
export DISPLAY=:99
Xvfb :99 -screen 0 1920x1080x24 &> /dev/null &
sleep 2

# === XFCE4 oturumu başlat ===
echo -e "startxfce4" > ~/.xsession
startxfce4 &> /dev/null &
sleep 10

# === HopToDesk indir ve kur ===
echo -e "${INFO}⬇️ HopToDesk indiriliyor ve kuruluyor...${RESET}"
wget -q https://hoptodesk.com/hoptodesk.deb -O hoptodesk.deb
sudo dpkg -i hoptodesk.deb > /dev/null 2>&1 || sudo apt-get install -f -y > /dev/null 2>&1

# === HopToDesk başlat ===
echo -e "${INFO}🟢 HopToDesk başlatılıyor...${RESET}"
DISPLAY=:99 nohup hoptodesk &> /dev/null &
sleep 5

# === Ekran görüntüsü al ===
timestamp=$(date +"%Y%m%d_%H%M%S")
SCREENSHOT_PATH=~/Desktop/ekran-goruntusu_$timestamp.png
DISPLAY=:99 import -window root "$SCREENSHOT_PATH" > /dev/null 2>&1

# === Cloudflared kurulumu ===
echo -e "${INFO}☁️ Cloudflared indiriliyor...${RESET}"
wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb > /dev/null 2>&1
sudo dpkg -i cloudflared.deb > /dev/null 2>&1

# === HTTP sunucu başlat ve Cloudflared tüneli kur ===
echo -e "${INFO}🌐 Cloudflare Tunnel başlatılıyor...${RESET}"
cd ~/Desktop
python3 -m http.server 7860 > /dev/null 2>&1 &
sleep 3
cloudflared tunnel --url http://localhost:7860 --no-autoupdate > tunnel.log 2>&1 &
sleep 5

# === URL’yi yakala ===
CF_URL=$(grep -o 'https://.*\.trycloudflare\.com' tunnel.log | head -n1)

# === Sonuç ekranı ===
clear
if [[ -f "$SCREENSHOT_PATH" && -n "$CF_URL" ]]; then
    echo -e "${YES}✅ HopToDesk başlatıldı, ekran görüntüsü alındı ve Cloudflare üzerinden yayınlandı.${RESET}"
    echo -e "${INFO}🖼️ Görüntü dosyası: ${YES}$SCREENSHOT_PATH${RESET}"
    echo -e "${INFO}🔗 Public bağlantı: ${YES}${CF_URL}/ekran-goruntusu_$timestamp.png${RESET}"
else
    echo -e "${NO}❌ Bir şeyler yanlış gitti. Dosya veya bağlantı oluşturulamadı.${RESET}"
fi
