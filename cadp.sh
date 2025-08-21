#!/bin/bash
# Script Admin Pterodactyl

PT_PATH="/var/www/pterodactyl"  # Lokasi Pterodactyl

# === Warna ===
RED="\e[1;31m"
GREEN="\e[1;32m"
CYAN="\e[1;36m"
YELLOW="\e[1;33m"
RESET="\e[0m"

# === Banner ===
clear
echo -e "${GREEN}"
cat << "EOF"
 █████╗ ██████╗ ██████╗ ██╗   ██╗███████╗███████╗██████╗ 
██╔══██╗██╔══██╗██╔══██╗██║   ██║██╔════╝██╔════╝██╔══██╗
███████║██║  ██║██║  ██║██║   ██║███████╗█████╗  ██████╔╝
██╔══██║██║  ██║██║  ██║██║   ██║╚════██║██╔══╝  ██╔══██╗
██║  ██║██████╔╝██████╔╝╚██████╔╝███████║███████╗██║  ██║
╚═╝  ╚═╝╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝
EOF
echo -e "${CYAN}        [ Script Pterodactyl Admin Panel Tool ]${RESET}"
echo ""

# === Menu ===
echo -e "${YELLOW}[1]${RESET} Add Admin User"
echo -e "${YELLOW}[2]${RESET} Delete User"
echo -e "${YELLOW}[0]${RESET} Exit"
echo ""
read -p "Pilih opsi: " MENU

case $MENU in
  1)
    # === Add Admin User ===
    read -p "Masukkan username admin: " USERNAME

    EMAIL="${USERNAME}@gmail.com"
    PASSWORD="${USERNAME}1221"
    FIRST_NAME="$(echo "$USERNAME" | sed 's/^./\U&/')"
    LAST_NAME="Admin"

    cd "$PT_PATH" || { echo -e "${RED}❌ Folder $PT_PATH tidak ditemukan${RESET}"; exit 1; }

    if [ -f "$PT_PATH/.env" ]; then
        DOMAIN=$(grep ^APP_URL= "$PT_PATH/.env" | cut -d '=' -f2-)
    else
        DOMAIN="http://localhost"
    fi

    php artisan p:user:make \
        --email="$EMAIL" \
        --username="$USERNAME" \
        --name-first="$FIRST_NAME" \
        --name-last="$LAST_NAME" \
        --password="$PASSWORD" \
        --admin=1

    echo ""
    echo -e "${GREEN}✅ Admin berhasil dibuat!${RESET}"
    echo "=============================="
    echo "Panel    : $DOMAIN"
    echo "Username : $USERNAME"
    echo "Password : $PASSWORD"
    echo "Email    : $EMAIL"
    echo "=============================="
    echo "*RULES SEPERTI BIASA*"
    echo "1. JANGAN DIJUAL DAN SHARE SEMBARANGAN"
    echo "2. JANGAN DDOS DOMAIN"
    echo "3. CREATE ADP LAGI BUAT DIPAKE SENDIRI"
    echo "4. PW ADP INI JANGAN DIGANTI"
    echo "5. YANG GANTI PW ANAK YATIM "
    echo -e "${CYAN}Tekan [ENTER] untuk keluar...${RESET}"
    read
    ;;

  2)
    # === Delete User ===
    echo -e "${RED}⚠️ Mode hapus user!${RESET}"
    echo -e "${CYAN}Jalankan command berikut: ${RESET}"
    echo ""
    echo -e "${YELLOW}php $PT_PATH/artisan p:user:delete${RESET}"
    echo ""
    echo -e "${CYAN}Tekan [ENTER] untuk keluar...${RESET}"
    read
    ;;

  0)
    echo -e "${RED}Keluar...${RESET}"
    exit 0
    ;;

  *)
    echo -e "${RED}❌ Pilihan tidak valid!${RESET}"
    ;;
esac
