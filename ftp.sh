#!/bin/bash

# === WARNA ===
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# === CEK ROOT ===
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[✘] Harap jalankan script ini sebagai root (sudo)${NC}"
  exit 1
fi

echo -e "${BLUE}[+] Menginstall vsftpd...${NC}"
apt update && apt install vsftpd -y

echo -e "${BLUE}[+] Backup konfigurasi lama...${NC}"
cp /etc/vsftpd.conf /etc/vsftpd.conf.bak

echo -e "${BLUE}[+] Menulis konfigurasi vsftpd baru...${NC}"
cat >/etc/vsftpd.conf <<EOF
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES

userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO

pasv_enable=YES
pasv_min_port=30000
pasv_max_port=31000
pasv_address=$(curl -4 -s ifconfig.me)

xferlog_enable=YES
log_ftp_protocol=YES
EOF

echo -e "${BLUE}[+] Menambahkan user 'root' ke whitelist FTP...${NC}"
echo "root" > /etc/vsftpd.userlist

echo -e "${BLUE}[+] Menghapus blokir PAM terhadap user root...${NC}"
sed -i '/^root$/d' /etc/ftpusers

echo -e "${BLUE}[+] Mengatur permission folder root agar bisa diakses FTP...${NC}"
chmod 755 /root

echo -e "${BLUE}[+] Membuka port FTP dan passive mode (21, 30000-31000)...${NC}"
ufw allow 21/tcp
ufw allow 30000:31000/tcp

echo -e "${BLUE}[+] Restarting vsftpd...${NC}"
systemctl restart vsftpd

# === BIND MOUNT FOLDER VOLUME ===
echo -e "${BLUE}[+] Menyiapkan bind mount folder /var/lib/pterodactyl/volume ke /root/volume...${NC}"
mkdir -p /root/volume

# Tambahkan ke fstab jika belum ada
if ! grep -q "/var/lib/pterodactyl/volume /root/volume none bind" /etc/fstab; then
  echo "/var/lib/pterodactyl/volume /root/volume none bind 0 0" >> /etc/fstab
  echo -e "${GREEN}[✓] Baris fstab berhasil ditambahkan${NC}"
else
  echo -e "${YELLOW}[!] Baris fstab sudah ada, dilewati${NC}"
fi

# Lakukan mount sekarang juga
mount --bind /var/lib/pterodactyl/volumes /root/volumes

echo -e "${GREEN}[✓] FTP untuk user 'root' berhasil dikonfigurasi!${NC}"
echo -e "${CYAN}Coba login pakai FTP Client ke: ${YELLOW}$(curl -s ifconfig.me):21${NC}"
echo -e "${CYAN}Akses folder volume di dalam: ${YELLOW}/volume${NC}"
echo -e "${GREEN}Login ke ftp ip:(curl -4 -s ifconfig.me)"
