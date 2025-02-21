#!/bin/bash
sed -i 's/\r$//' "$0"

# Started Message
echo -e "\n\n\e[1;36m============================= İŞLEMLER BAŞLADI (BELGESELSEMO.COM.TR) =============================\e[0m"
echo -e "\n\e[1;31mGerekli işlemler yapılıyor. Lütfen bekleyiniz...\e[0m"
echo -e "\e[1;31mPerforming necessary operations. Please wait...\e[0m"
echo -e "\n\e[1;36m============================= STARTING PROCESSES (BELGESELSEMO.COM.TR) =============================\e[0m"

# Gerekli Paketlerin Yüklenmesi
apt install -y unrar p7zip-full qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager > /dev/null 2>&1
systemctl enable libvirtd --now && usermod -aG libvirt $(whoami) > /dev/null 2>&1

sudo apt-get update > /dev/null 2>&1
sudo apt-get install qemu -y > /dev/null 2>&1
sudo apt install qemu-utils -y > /dev/null 2>&1
sudo apt install qemu-system-x86 -y > /dev/null 2>&1

# Sanal Disk ve ISO'ları İndir
wget -O RTL8139F.iso 'https://drive.google.com/uc?export=download&id=1wDL8vo9mmYKw1HKXZzaYHoKmzSt_wXai' > /dev/null 2>&1
wget -O 8.iso 'https://github.com/minios-linux/minios-live/releases/download/v4.1.1/minios-bookworm-xfce-standard-amd64-4.1.1.iso' > /dev/null 2>&1

qemu-img create -f raw 8.img 30G > /dev/null 2>&1

# QEMU Sanal Makineyi Başlat
sudo qemu-system-x86_64 \
  -m 15G \
  -cpu EPYC \
  -boot order=d \
  -drive file=8.iso,media=cdrom \
  -drive file=8.img,format=raw \
  -drive file=RTL8139F.iso,media=cdrom \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :0 \
  -cpu core2duo \
  -smp cores=6 \
  -device rtl8139,netdev=n0 -netdev user,id=n0 \
  -accel tcg,thread=multi \
  -fsdev local,security_model=passthrough,id=fsdev0,path=/ \
  -device virtio-9p-pci,fsdev=fsdev0,mount_tag=hostfs > /dev/null 2>&1 &

# Cloudflared Kurulumu
wget -O c.deb https://github.com/cloudflare/cloudflared/releases/download/2025.1.1/cloudflared-linux-amd64.deb > /dev/null 2>&1
sudo apt install -y ./c.deb > /dev/null 2>&1

cloudflared tunnel --url tcp://localhost:5900 > cloudflared.log 2>&1 &
sleep 5

# Cloudflared URL'yi Al
link=$(grep -oP 'https://[a-zA-Z0-9.-]+\.trycloudflare\.com' cloudflared.log | head -n 1)

clear
if [ -z "$link" ]; then
  echo -e "\e[1;31mURL alınamadı. Cloudflared loglarını kontrol edin.\e[0m"
else
  clear
  echo -e "\n"
  echo -e "\e[1;36m============================= TÜRKÇE TALİMATLAR =============================\e[0m"
  echo -e "\e[1;35mKomutu Terminalinize yazın ve Enter'a tıklayınız:\e[1;31m  cloudflared access rdp --hostname $link --url localhost:5903\e[0m"
  echo -e "\e[1;35mMiniOS Giriş Ekranı Ad-Şifre :\e[1;31m  root:toor\e[0m"
fi
