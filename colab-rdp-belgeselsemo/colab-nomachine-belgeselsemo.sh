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


# XFCE4 Oturumunu Arka Planda Başlat (Çıktıları Gizle)
echo "startxfce4" > ~/.xsession
startxfce4 &>/dev/null &

# Install Cloudflared and create a tunnel
wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb > /dev/null 2>&1
sudo dpkg -i cloudflared.deb > /dev/null 2>&1

cloudflared tunnel --url rdp://localhost:4000 > cloudflared.log 2>&1 &
sleep 5

link=$(grep -oP 'https://[a-zA-Z0-9.-]+\.trycloudflare\.com' cloudflared.log | head -n 1)

# Clear the screen before displaying the final messages
clear

if [ -z "$link" ]; then
  echo -e "\e[1;31mURL could not be obtained. Check Cloudflared logs.\e[0m"
else
  clear
  echo -e "\e[1;36m============================= TÜRKÇE TALİMATLAR =============================\e[0m"
  echo -e "\e[1;35mNoMachine ile şu bağlantıdan bağlanabilirsiniz:\e[1;31m cloudflared access rdp --hostname $link --url localhost:4100 \e[0m"
  echo -e "\e[1;35mKullanıcı adı ve şifre:\e[1;31m root:belgeselsemo\e[0m"
  echo -e "\e[1;35mTR Klavye ve VLC Fix Komutu:\e[1;31m setxkbmap tr && sed -i 's/geteuid/getppid/' /usr/bin/vlc\e[0m"
  echo -e "\e[1;35mYüklenen Extra Programlar:\e[1;31m Wine-VLC-Firefox-Android Studio-LXTerminal-Handbrake-MKVToolNix-RClone-Stacer-Streamlink-Terabox-CrossOver\e[0m"

  # "Bu içerik" yazısının üzerinde 1 satır boşluk
  echo -e "\n\e[1;30mBu içerik \e[1;34mCHATGPT\e[1;30m ve \e[1;34mDEEPSEEK\e[1;30m sayesinde \e[1;34mhttps://belgeselsemo.com.tr\e[1;30m sitesi tarafından oluşturulmuştur.\e[0m"
  
  echo -e "\n\n\e[1;36m============================ ENGLISH INSTRUCTIONS ============================\e[0m"
  echo -e "\e[1;35mYou can connect using NoMachine via this link:\e[1;31m cloudflared access rdp --hostname $link --url localhost:4100 \e[0m"
  echo -e "\e[1;35mUsername and Password:\e[1;31m root:belgeselsemo\e[0m"
  echo -e "\e[1;35mTR Keyboard and VLC Fix Command:\e[1;31m setxkbmap tr && sed -i 's/geteuid/getppid/' /usr/bin/vlc\e[0m"
  echo -e "\e[1;35mInstalled Extra Apps:\e[1;31m Wine-VLC-Firefox-Android Studio-LXTerminal-Handbrake-MKVToolNix-RClone-Stacer-Streamlink-Terabox-CrossOver\e[0m"

  # "Bu içerik" yazısının üzerinde 1 satır boşluk
  echo -e "\n\e[1;30mThis content created with the help of \e[1;34mCHATGPT\e[1;30m and \e[1;34mDEEPSEEK\e[1;30m by \e[1;34mhttps://belgeselsemo.com.tr\e[1;30m.\e[0m"

   # "Bu içerik" yazısının üzerinde 1 satır boşluk
  echo -e "\n\n\e[1;36m============================ ANDROID STUDIO YÜKLE (SANAL MAKİNE TERMİNAL'E YAPIŞTIR) - İSTEĞE BAĞLI ============================\e[0m"
  echo -e "\n\e[1;31mwget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.1.2.12/android-studio-2024.1.2.12-linux.tar.gz && tar -xvzf android-studio-2024.1.2.12-linux.tar.gz && sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 && echo -e \"[Desktop Entry]\\nVersion=1.0\\nType=Application\\nName=Android Studio\\nExec=\$(pwd)/android-studio/bin/studio.sh\\nIcon=\$(pwd)/android-studio/bin/studio.png\\nComment=Integrated Android developer tools for development and debugging.\\nCategories=Development;IDE;\\nTerminal=false\\nStartupNotify=true\" > ~/Desktop/android-studio.desktop && chmod +x ~/Desktop/android-studio.desktop && sudo cp ~/Desktop/android-studio.desktop /usr/share/applications/\e[0m"
 echo -e "\n\e[1;36m============================ INSTALL ANDROID STUDIO (PASTE INTO VIRTUAL MACHINE TERMINAL) - OPTIONAL ============================\e[0m"

  # DWService Bilgilendirme
  echo -e "\n\n\n\n\e[1;36m=========== İnternet Tarayıcısıyla Bağlanma (DWService) - İsteğe Bağlı ===========\e[0m"
  echo -e "\e[1;35mAşağıdaki komutu buradan çalıştırın. Oluşturacağı User ve Password giriş bilgileriyle https://access.dwservice.net/login.dw adresinden bağlanabilirsiniz..\e[0m"
  echo -e "\n\e[1;31mwget https://www.dwservice.net/download/dwagent.sh -q -O dwagent.sh && chmod +x dwagent.sh && echo \"2\" | ./dwagent.sh\e[0m"
  echo -e "\e[1;36m=========== Connect with Web Browser (DWService) - OPTIONAL ===========\e[0m"

fi

