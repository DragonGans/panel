#!/bin/bash

# === WARNA ===
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

# === FUNGSI LOADING ===
loading() {
  echo -ne "${YELLOW}Loading"
  for i in {1..6}; do
    echo -ne "."
    sleep 0.3
  done
  echo -e "${NC}"
}

# === MENU UTAMA ===
while true; do
  clear
  echo -e "${GREEN}"
  cat << "EOF"
██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗ 
██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
███████║███████║██║     █████╔╝ █████╗  ██████╔╝
██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
EOF
  echo -e "${CYAN}════════════════════════════════════════════════════${NC}"
  echo -e "${YELLOW}        HACKTOOLS BY BIMZXRYOOXNERU${NC}"
  echo -e "${CYAN}════════════════════════════════════════════════════${NC}\n"

  echo -e "${GREEN} 1.${NC} Install Pterodactyl Panel"
  echo -e "${GREEN} 2.${NC} Install Tema"
  echo -e "${GREEN} 3.${NC} Install Tema 2"
  echo -e "${GREEN} 4.${NC} Protect Panel"
  echo -e "${GREEN} 5.${NC} Adduser ryzz"
  echo -e "${GREEN} 6.${NC} Enable FTP Ryzz"
  echo -e "${GREEN} 7.${NC} Maling SC Bot"
  echo -e "${GREEN} 8.${NC} Install RDP"
  echo -e "${GREEN} 9.${NC} Create ADP"
  echo -e "${GREEN}10.${NC} Intip Server"
  echo -e "${GREEN}11.${NC} Delete Certificate"
  echo -e "${GREEN} 0.${NC} Keluar"
  echo -e "${CYAN}════════════════════════════════════════════════════${NC}\n"

  # Input
  read -p "$(echo -e ${YELLOW}Pilih nomor [0-11]: ${NC})" pilihan

  case "$pilihan" in
    1) echo -e "${BLUE}[→] Menjalankan installer Pterodactyl Panel...${NC}"; loading
       bash <(curl -s https://pterodactyl-installer.se) ;;
    2) echo -e "${BLUE}[→] Menjalankan installer tema panel...${NC}"; loading
       bash <(curl -s https://raw.githubusercontent.com/LeXcZxMoDz9/kontol/refs/heads/main/bangke.sh) ;;
    3) echo -e "${BLUE}[→] Menjalankan installer tema panel 2...${NC}"; loading
       bash <(curl -s https://raw.githubusercontent.com/Bangsano/Autoinstaller-Theme-Pterodactyl/main/install.sh) ;;
    4) echo -e "${BLUE}[→] Memulai protect panel...${NC}"; loading
       bash <(curl -s https://raw.githubusercontent.com/DragonGans/protect-adp/refs/heads/main/all-protect-panel.sh) ;;
    5) echo -e "${BLUE}[→] Menjalankan penambahan user...${NC}"; loading
       bash <(curl -s https://raw.githubusercontent.com/DragonGans/adduser/refs/heads/main/user.sh) ;;
    6) echo -e "${BLUE}[→] Menjalankan enable FTP...${NC}"; loading
       bash <(curl -s https://raw.githubusercontent.com/DragonGans/panel/refs/heads/main/ftp.sh) ;;
    7) echo -e "${BLUE}[→] Menjalankan maling SC...${NC}"; loading
       bash <(curl -s https://raw.githubusercontent.com/DragonGans/panel/refs/heads/main/tele.sh) ;;
    8) echo -e "${BLUE}[→] Menjalankan install RDP...${NC}"; loading
       bash <(curl -s https://raw.githubusercontent.com/DragonGans/panel/refs/heads/main/rdp.sh) ;;
    9) echo -e "${BLUE}[→] Menjalankan create ADP...${NC}"; loading
       bash <(curl -s https://raw.githubusercontent.com/DragonGans/panel/refs/heads/main/cadp.sh) ;;
    10) echo -e "${BLUE}[→] Menjalankan intip server...${NC}"; loading
        bash <(curl -s https://raw.githubusercontent.com/DragonGans/panel/refs/heads/main/intip.sh) ;;
    11) echo -e "${BLUE}[→] Menjalankan delete certificate...${NC}"; loading
        bash <(curl -s https://raw.githubusercontent.com/DragonGans/panel/refs/heads/main/cert.sh) ;;
    0) echo -e "${RED}Keluar...${NC}"; exit 0 ;;
    *) echo -e "${RED}[✘] Pilihan tidak valid, coba lagi...${NC}"; sleep 1 ;;
  esac
done
