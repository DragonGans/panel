#!/bin/bash
# ================================================
# Auto Install xRDP + Pilihan Desktop Environment
# By: Bima (ryoo) - siap upload ke GitHub 😎
# ================================================

# Cek apakah root
if [ "$(id -u)" -ne 0 ]; then
   echo "⚠️ Jalankan script ini sebagai root!"
   exit 1
fi

clear
echo "======================================"
echo "  🚀 Auto Installer xRDP + Desktop   "
echo "======================================"
echo ""
echo "Pilih Desktop Environment:"
echo "1) Cinnamon"
echo "2) XFCE4"
echo "3) MATE"
echo "4) GNOME"
echo "5) KDE Plasma"
echo ""
read -p "Masukkan pilihan [1-5]: " pilihan

case $pilihan in
    1)
        DE="cinnamon-session"
        echo "🖥️ Install Cinnamon Desktop..."
        DEBIAN_FRONTEND=noninteractive apt install -y cinnamon-core
        ;;
    2)
        DE="startxfce4"
        echo "🖥️ Install XFCE4 Desktop..."
        DEBIAN_FRONTEND=noninteractive apt install -y xfce4 xfce4-goodies
        ;;
    3)
        DE="mate-session"
        echo "🖥️ Install MATE Desktop..."
        DEBIAN_FRONTEND=noninteractive apt install -y mate-desktop-environment-core
        ;;
    4)
        DE="gnome-session"
        echo "🖥️ Install GNOME Desktop..."
        DEBIAN_FRONTEND=noninteractive apt install -y ubuntu-gnome-desktop
        ;;
    5)
        DE="startplasma-x11"
        echo "🖥️ Install KDE Plasma Desktop..."
        DEBIAN_FRONTEND=noninteractive apt install -y kde-plasma-desktop
        ;;
    *)
        echo "❌ Pilihan tidak valid!"
        exit 1
        ;;
esac

echo "🚀 Update & Upgrade sistem..."
apt update && apt upgrade -y

echo "🔧 Install xRDP..."
DEBIAN_FRONTEND=noninteractive apt install -y xrdp

echo "🔧 Konfigurasi xRDP agar pakai $DE..."
echo "$DE" > /etc/skel/.xsession
echo "$DE" > ~/.xsession

# Tambahkan user xrdp ke ssl-cert
adduser xrdp ssl-cert

echo "🔥 Atur firewall agar port 3389 terbuka..."
ufw allow 3389/tcp
ufw --force enable

echo "🔄 Restart service xrdp..."
systemctl enable xrdp
systemctl restart xrdp

echo "======================================"
echo "✅ Instalasi selesai!"
echo "Sekarang kamu bisa RDP ke VPS dengan IP VPS kamu di port 3389."
echo "Desktop Environment: $DE"
echo "======================================"
