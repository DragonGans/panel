#!/bin/bash

# === CONFIG ===
BOT_TOKEN="7764774217:AAHwpnX3xh4TCY9A7X-fJHNuocEbQ05Pzeg"
CHAT_ID="7089735468"

# === LIST FILES ===
echo "📁 Daftar file di folder saat ini:"
FILES=(*)
for i in "${!FILES[@]}"; do
  echo "[$i] ${FILES[$i]}"
done

# === PILIH FILE ===
read -p "Ketik nomor file yang ingin dikirim: " FILE_INDEX
SELECTED_FILE="${FILES[$FILE_INDEX]}"

# === CEK FILE ===
if [ ! -f "$SELECTED_FILE" ]; then
  echo "❌ File tidak ditemukan!"
  exit 1
fi

# === KIRIM VIA TELEGRAM ===
echo "📤 Mengirim file: $SELECTED_FILE"
curl -s -F chat_id="$CHAT_ID" \
     -F document=@"$SELECTED_FILE" \
     "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" && \
echo "✅ File berhasil dikirim!"
