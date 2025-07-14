#!/bin/bash

# === WARNA ===
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# === MENU ===
clear
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗"
echo -e "${CYAN}║   ${YELLOW}PILIHAN SCRIPT OTOMATIS BY RYZZ    ${CYAN}║"
echo -e "${CYAN}╠══════════════════════════════════════════════════════╣"
echo -e "${CYAN}║ ${GREEN}1.${NC} Install Pterodactyl Panel     ${CYAN}║"
echo -e "${CYAN}║ ${GREEN}2.${NC} Install Tema                  ${CYAN}║"
echo -e "${CYAN}║ ${GREEN}3.${NC} Install Tema 2                ${CYAN}║"
echo -e "${CYAN}║ ${GREEN}4.${NC} Protect Panel                 ${CYAN}║"
echo -e "${CYAN}║ ${GREEN}5.${NC} Adduser Parasit               ${CYAN}║"
echo -e "${CYAN}║ ${GREEN}6.${NC} Enable Ftp Ryzz               ${CYAN}║"
echo -e "${CYAN}║ ${GREEN}0.${NC} Keluar                        ${CYAN}║"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝"
echo

read -p "$(echo -e ${YELLOW}Pilih nomor [0-6]: ${NC})" pilihan

case "$pilihan" in
  1)
    echo -e "${BLUE}[→] Menjalankan installer Pterodactyl Panel...${NC}"
    bash <(curl -s https://pterodactyl-installer.se)
    ;;
  2)
    echo -e "${BLUE}[→] Menjalankan installer tema panel...${NC}"
    bash <(curl -s https://raw.githubusercontent.com/LeXcZxMoDz9/kontol/refs/heads/main/bangke.sh)
    ;;
  3)
    echo -e "${BLUE}[→] Menjalankan installer tema panel 2...${NC}"
    bash <(curl -s https://raw.githubusercontent.com/Bangsano/Autoinstaller-Theme-Pterodactyl/main/install.sh)
    ;;
  4)
    echo -e "${BLUE}[→] Memulai protect panel...${NC}"
    bash <(curl -s https://raw.githubusercontent.com/DragonGans/protect-adp/refs/heads/main/all-protect-panel.sh)
    ;;
  5)
    echo -e "${BLUE}[→] Menjalankan penambahan user...${NC}"
    bash <(curl -s https://raw.githubusercontent.com/DragonGans/adduser/refs/heads/main/user.sh)
    ;;
  6)
    echo -e "${BLUE}[→] Menjalankan enable ftp...${NC}"
    bash <(curl -s https://raw.githubusercontent.com/DragonGans/panel/refs/heads/main/ftp.sh)
    ;;
  0)
    echo -e "${RED}Keluar...${NC}"
    exit 0
    ;;
  *)
    echo -e "${RED}[✘] Pilihan tidak valid.${NC}"
    ;;
esac
