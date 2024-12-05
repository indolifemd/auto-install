#!/bin/bash

# Warna teks
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
RESET='\033[0m'

# Fungsi untuk animasi awal
show_animation() {
    clear
    echo -e "${CYAN}${BOLD}======================================="
    echo -e "          Auto Install Theme           "
    echo -e "             by Indolife              "
    echo -e "=======================================${RESET}"
    sleep 0.5
    echo ""
    echo -e "${YELLOW}>> Loading...${RESET}"
    sleep 0.5
    echo -e "${GREEN}>> Preparing the script...${RESET}"
    sleep 0.5
    echo -e "${BLUE}>> Ready to go!${RESET}"
    sleep 1
}

# Fungsi untuk menginstal Node.js dan dependensi dasar
install_node() {
    echo -e "${CYAN}>> INSTALL NODE 20 DAN KEY <<${RESET}"
    sudo apt-get install -y ca-certificates curl gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt-get update
    sudo apt-get install -y nodejs
    echo -e "${GREEN}Node.js dan dependensi dasar telah berhasil diinstal.${RESET}"
}

# Fungsi untuk menginstal Blueprint.zip base
install_blueprint() {
    echo -e "${CYAN}>> INSTALL BLUEPRINT.ZIP BASE <<${RESET}"
    cd /var/www/pterodactyl || exit
    yarn
    yarn add cross-env
    sudo apt install -y zip unzip git curl wget
    wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O release.zip
    sudo unzip release.zip
    FOLDER="/var/www/pterodactyl"
    WEBUSER="www-data"
    USERSHELL="/bin/bash"
    PERMISSIONS="www-data:www-data"
    sudo sed -i -E -e "s|WEBUSER=\"www-data\" #;|WEBUSER=\"$WEBUSER\" #;|g" \
    -e "s|USERSHELL=\"/bin/bash\" #;|USERSHELL=\"$USERSHELL\" #;|g" \
    -e "s|OWNERSHIP=\"www-data:www-data\" #;|OWNERSHIP=\"$PERMISSIONS\" #;|g" $FOLDER/blueprint.sh
    sudo chmod +x blueprint.sh
    sudo bash blueprint.sh
    echo -e "${GREEN}Blueprint berhasil diinstal.${RESET}"
}

# Fungsi untuk menginstal theme berdasarkan nama
install_theme() {
    echo -e "${CYAN}>> PROSES DOWNLOAD DAN INSTAL THEME <<${RESET}"
    THEME_NAME=$1
    if [ -z "$THEME_NAME" ]; then
        echo -e "${RED}Nama theme diperlukan.${RESET}"
        return
    fi
    cd /var/www/pterodactyl || exit
    if [ ! -f "nebulaslate2.zip" ]; then
        git clone https://github.com/indolifemd/theme.git
        cd theme || exit
        sudo mv nebulaslate2.zip /var/www/pterodactyl
    fi
    sudo unzip -o nebulaslate2.zip
    blueprint -i "$THEME_NAME"
    echo -e "${GREEN}Theme $THEME_NAME berhasil diinstal.${RESET}"
}

# Menu pilihan
show_menu() {
    echo -e "${CYAN}Silakan pilih opsi instalasi:${RESET}"
    echo -e "${YELLOW}1. Install Node.js dan Dependensi${RESET}"
    echo -e "${YELLOW}2. Install Blueprint (wajib)${RESET}"
    echo -e "${YELLOW}3. Install Theme Nebula${RESET}"
    echo -e "${YELLOW}4. Install Theme Slate${RESET}"
    echo -e "${YELLOW}5. Install Theme Bluetables${RESET}"
    echo -e "${YELLOW}6. Install Theme Darkenate${RESET}"
    echo -e "${YELLOW}7. Install Theme Nightadmin${RESET}"
    echo -e "${YELLOW}8. Install Theme Recolor${RESET}"
    echo -e "${YELLOW}9. Install Theme Redirect${RESET}"
    echo -e "${YELLOW}10. Install Theme Snowflakes${RESET}"
    echo -e "${YELLOW}11. Install Theme Txadminintegration${RESET}"
    echo -e "${RED}12. Keluar${RESET}"
    echo -e "${WHITE}Pilih opsi [1-12]:${RESET}"
    read -r choice
}

# Perulangan menu
while true; do
    show_animation  # Menampilkan animasi di awal
    show_menu
    case $choice in
    1)
        install_node
        ;;
    2)
        install_blueprint
        ;;
    3)
        install_theme "nebula"
        ;;
    4)
        install_theme "slate"
        ;;
    5)
        install_theme "bluetables"
        ;;
    6)
        install_theme "darkenate"
        ;;
    7)
        install_theme "nightadmin"
        ;;
    8)
        install_theme "recolor"
        ;;
    9)
        install_theme "redirect"
        ;;
    10)
        install_theme "snowflakes"
        ;;
    11)
        install_theme "txadminintegration"
        ;;
    12)
        echo -e "${RED}Keluar dari program.${RESET}"
        break
        ;;
    *)
        echo -e "${RED}Pilihan tidak valid, coba lagi.${RESET}"
        ;;
    esac
done
