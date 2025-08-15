#!/bin/bash
# Script buat admin Pterodactyl (versi baru)
# Pastikan jalankan di folder instalasi panel (misal /var/www/pterodactyl)

PT_PATH="/var/www/pterodactyl"   # Lokasi Pterodactyl
EMAIL="ryoo@gmail.com"         # Email admin
USERNAME="ryoo"
PASSWORD="ryoo1221"
FIRST_NAME="Ryoo"
LAST_NAME="Admin"

cd "$PT_PATH" || { echo "❌ Folder $PT_PATH tidak ditemukan"; exit 1; }

# Jalankan artisan untuk membuat user admin
php artisan p:user:make \
    --email="$EMAIL" \
    --username="$USERNAME" \
    --name-first="$FIRST_NAME" \
    --name-last="$LAST_NAME" \
    --password="$PASSWORD" \
    --admin=1 \
    -q

echo "✅ Admin berhasil dibuat!"
echo "Username : $USERNAME"
echo "Password : $PASSWORD"
echo "Email    : $EMAIL"
