#!/bin/bash
# Script buat admin Pterodactyl (versi baru) - Input username saja

PT_PATH="/var/www/pterodactyl"  # Lokasi Pterodactyl

# Minta input username
read -p "Masukkan username admin: " USERNAME

# Otomatis generate email & password
EMAIL="${USERNAME}@gmail.com"
PASSWORD="${USERNAME}1221"

# Nama depan: kapital huruf pertama username
FIRST_NAME="$(echo "$USERNAME" | sed 's/^./\U&/')"
LAST_NAME="Admin"

cd "$PT_PATH" || { echo "❌ Folder $PT_PATH tidak ditemukan"; exit 1; }

# Ambil domain dari file .env (APP_URL)
if [ -f "$PT_PATH/.env" ]; then
    DOMAIN=$(grep ^APP_URL= "$PT_PATH/.env" | cut -d '=' -f2-)
else
    DOMAIN="http://localhost"
fi

# Jalankan artisan untuk membuat user admin
php artisan p:user:make \
    --email="$EMAIL" \
    --username="$USERNAME" \
    --name-first="$FIRST_NAME" \
    --name-last="$LAST_NAME" \
    --password="$PASSWORD" \
    --admin=1 \

echo "✅ Admin berhasil dibuat!"
echo "Username : $USERNAME"
echo "Password : $PASSWORD"
echo "Email    : $EMAIL"
