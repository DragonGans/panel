#!/bin/bash

# Cek apakah script dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan script ini sebagai root (sudo)"
  exit 1
fi

# Buat user ryzz
echo "[+] Membuat user 'ryzz'..."
useradd -m -s /bin/bash ryzz

# Set password
echo "[+] Mengatur password untuk 'ryzz'..."
echo "ryzz:ryzz" | chpasswd

# Tambahkan ke grup sudo
echo "[+] Menambahkan 'ryzz' ke grup sudo..."
usermod -aG sudo ryzz

# Cek apakah user sudah berhasil dibuat dan masuk grup sudo
echo "[+] Verifikasi..."
id ryzz
groups ryzz

echo "[✓] Selesai. User 'ryzz' siap digunakan."
