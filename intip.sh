#!/bin/bash

# Warna
green="\e[32m"
red="\e[31m"
yellow="\e[33m"
cyan="\e[36m"
reset="\e[0m"

# Banner
banner() {
    clear
    echo -e "${green}"
    echo "   ██████╗ ████████╗███████╗██████╗ ██████╗  █████╗ ████████╗██╗ ██████╗ ██╗   ██╗"
    echo "   ██╔══██╗╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗██║   ██║"
    echo "   ██████╔╝   ██║   █████╗  ██████╔╝██████╔╝███████║   ██║   ██║██║   ██║██║   ██║"
    echo "   ██╔═══╝    ██║   ██╔══╝  ██╔═══╝ ██╔═══╝ ██╔══██║   ██║   ██║██║   ██║██║   ██║"
    echo "   ██║        ██║   ███████╗██║     ██║     ██║  ██║   ██║   ██║╚██████╔╝╚██████╔╝"
    echo "   ╚═╝        ╚═╝   ╚══════╝╚═╝     ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝  ╚═════╝ "
    echo -e "${reset}"
    echo -e "${cyan}      >> Pterodactyl Log Viewer by RyooXneru <<${reset}\n"
}

# Menu utama
menu() {
    while true; do
        banner
        echo -e "${yellow}List Server Aktif:${reset}"
        docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" | nl -w2 -s'. '

        echo -e "\n${red}0. Keluar${reset}"
        echo -ne "\n${cyan}Pilih nomor server: ${reset}"
        read pilihan

        if [[ "$pilihan" == "0" ]]; then
            echo -e "${red}Keluar...${reset}"
            exit 0
        fi

        server=$(docker ps --format "{{.Names}}" | sed -n "${pilihan}p")

        if [[ -z "$server" ]]; then
            echo -e "${red}Pilihan tidak valid!${reset}"
            sleep 1
        else
            lihat_log "$server"
        fi
    done
}

# Fungsi lihat log
lihat_log() {
    server="$1"
    clear
    echo -e "${green}>> Menampilkan log server: ${yellow}$server${reset}\n"
    echo -e "${cyan}Tekan CTRL+C untuk kembali ke menu${reset}\n"

    # Trap CTRL+C biar balik menu
    trap 'echo -e "\n${red}Kembali ke menu...${reset}"; sleep 1; return' INT

    docker logs -f "$server"
}

# Jalankan menu
menu
