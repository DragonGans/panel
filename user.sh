#!/bin/bash

# === WARNA ===
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# === CEK ROOT ===
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[✘] Harap jalankan script ini sebagai root (sudo)${NC}"
  exit 1
fi

# === CEK USER ===
if id "ryzz" &>/dev/null; then
  echo -e "${YELLOW}[!] User 'ryzz' sudah ada.${NC}"
else
  echo -e "${BLUE}[+] Membuat user '${CYAN}ryzz${BLUE}'...${NC}"
  useradd -m -s /bin/bash ryzz

  echo -e "${BLUE}[+] Mengatur password...${NC}"
  echo "ryzz:ryzz" | chpasswd

  echo -e "${BLUE}[+] Menambahkan '${CYAN}ryzz${BLUE}' ke grup sudo...${NC}"
  usermod -aG sudo ryzz

  echo -e "${GREEN}[✓] User '${CYAN}ryzz${GREEN}' berhasil dibuat.${NC}"
fi

# === VERIFIKASI ===
echo -e "${YELLOW}------------------------------${NC}"
echo -e "${CYAN}Info User:${NC}"
id ryzz
groups ryzz
echo -e "${YELLOW}------------------------------${NC}"

# === LOGIN KE USER ===
echo -e "${BLUE}[→] Login ke user '${CYAN}ryzz${BLUE}' sekarang...${NC}"
sleep 2
su - ryzz
