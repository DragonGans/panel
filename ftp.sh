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

# === CEK USER ===
if id "ryzz" &>/dev/null; then
  echo -e "${YELLOW}[!] User 'ryzz' sudah ada.${NC}"
else
  echo -e "${BLUE}[+] Membuat user 'ryzz'...${NC}"
  useradd -m -s /bin/bash ryzz
  echo "ryzz:ryzz" | chpasswd
  echo -e "${BLUE}[+] User 'ryzz' dibuat dengan password default 'ryzz'${NC}"
fi

echo -e "${BLUE}[+] Menginstall vsftpd...${NC}"
apt update && apt install vsftpd -y

echo -e "${BLUE}[+] Backup konfigurasi lama...${NC}"
cp /etc/vsftpd.conf /etc/vsftpd.conf.bak

echo -e "${BLUE}[+] Menulis konfigurasi baru untuk vsftpd...${NC}"
cat >/etc/vsftpd.conf <<EOF
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_root=/root
chroot_local_user=NO
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

echo -e "${BLUE}[+] Menambahkan user 'ryzz' ke whitelist FTP...${NC}"
echo "ryzz" > /etc/vsftpd.userlist

echo -e "${BLUE}[+] Memberi akses user 'ryzz' ke direktori /root...${NC}"
usermod -aG root ryzz
chmod 755 /root

echo -e "${BLUE}[+] Membuka port firewall FTP...${NC}"
ufw allow 21/tcp
ufw allow 30000:31000/tcp

echo -e "${BLUE}[+] Restarting vsftpd...${NC}"
systemctl restart vsftpd

echo -e "${GREEN}[✓] User 'ryzz' sekarang bisa login FTP ke direktori /root${NC}"
echo -e "${CYAN}Coba login pakai FTP Client ke: ${YELLOW}$(curl -4 -s ifconfig.me):21${NC}"
echo -e "${YELLOW}Username: ryzz  |  Password: ryzz${NC}"
