#!/bin/bash

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
  echo ""
  echo "=== MENU UTAMA ==="
  read -p "🔎 Masukkan ekstensi file yang ingin dicari (tanpa titik, contoh: zip): " EXT
  echo "📦 Mencari file *.$EXT ..."

  # Cari file sesuai ekstensi secara rekursif
  IFS=$'\n' read -d '' -r -a FOUND_FILES < <(find . -type f -iname "*.$EXT" && printf '\0')

  if [ ${#FOUND_FILES[@]} -eq 0 ]; then
    echo "❌ Tidak ada file dengan ekstensi .$EXT ditemukan!"
    continue
  fi

  # === MENU FILES ===
  while true; do
    echo ""
    echo "=== FILE DENGAN EKSTENSI .$EXT ==="
    for i in "${!FOUND_FILES[@]}"; do
      echo "[$i] ${FOUND_FILES[$i]}"
    done
    echo "[b] 🔁 Kembali ke menu ekstensi"
    echo "[x] ❌ Keluar script"

    read -p "Pilih nomor file yang ingin dikirim: " PILIHAN

    if [[ "$PILIHAN" == "b" ]]; then
      break
    elif [[ "$PILIHAN" == "x" ]]; then
      echo "👋 Keluar dari script."
      exit 0
    elif [[ "$PILIHAN" =~ ^[0-9]+$ ]] && [ "$PILIHAN" -ge 0 ] && [ "$PILIHAN" -lt ${#FOUND_FILES[@]} ]; then
      send_file "${FOUND_FILES[$PILIHAN]}"
    else
      echo "❗ Input tidak valid. Coba lagi."
    fi
  done
done
