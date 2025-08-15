#!/bin/bash

# Warna
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
cyan='\033[1;36m'
reset='\033[0m'

# ASCII Banner
banner() {
    clear
    echo -e "${cyan}"
    echo "╔══════════════════════════════════════╗"
    echo "║       🔒 CERTIFICATE MANAGER        ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${reset}"
}

# Fungsi untuk menampilkan cert yang ada
list_certificates() {
    echo -e "${yellow}📋 Sertifikat yang tersedia:${reset}"
    sudo certbot certificates | grep 'Certificate Name:' | awk '{print NR")", $3}'
    echo -e "${green}0) Keluar${reset}"
}

# Fungsi untuk menghapus cert
delete_certificate() {
    local name="$1"
    echo -e "${red}⚠️ Menghapus sertifikat: $name${reset}"
    sudo certbot delete --cert-name "$name"
    echo -e "${green}✔ Sertifikat '$name' berhasil dihapus.${reset}"
}

# Main loop
while true; do
    banner
    list_certificates

    echo
    read -p "📌 Pilih nomor sertifikat yang ingin dihapus (0 untuk keluar): " choice

    if [[ "$choice" == "0" ]]; then
        echo -e "${cyan}👋 Keluar dari Certificate Manager. Bye!${reset}"
        break
    fi

    cert_name=$(sudo certbot certificates | grep 'Certificate Name:' | awk '{print $3}' | sed -n "${choice}p")

    if [[ -z "$cert_name" ]]; then
        echo -e "${red}❌ Nomor tidak valid. Coba lagi.${reset}"
        sleep 1.5
        continue
    fi

    delete_certificate "$cert_name"
    echo -e "${yellow}⏳ Kembali ke menu utama dalam 2 detik...${reset}"
    sleep 2
done
