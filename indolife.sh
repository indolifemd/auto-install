#!/bin/bash

# Fungsi untuk menginstal Node.js dan dependensi dasar
install_node() {
    echo ">> INSTALL NODE 20 DAN KEY <<"
    sudo apt-get install -y ca-certificates curl gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt-get update
    sudo apt-get install -y nodejs
    echo "Node.js dan dependensi dasar telah berhasil diinstal."
}

# Fungsi untuk menginstal Blueprint.zip base
install_blueprint() {
    echo ">> INSTALL BLUEPRINT.ZIP BASE <<"
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
    echo "Blueprint berhasil diinstal."
}

# Fungsi untuk menginstal theme berdasarkan nama
install_theme() {
    echo ">> PROSES DOWNLOAD DAN INSTAL THEME <<"
    THEME_NAME=$1
    if [ -z "$THEME_NAME" ]; then
        echo "Nama theme diperlukan."
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
    echo "Theme $THEME_NAME berhasil diinstal."
}

# Menu pilihan
show_menu() {
    echo "Silakan pilih opsi instalasi:"
    echo "1. Install Node.js dan Dependensi"
    echo "2. Install Blueprint (wajib)"
    echo "3. Install Theme Nebula"
    echo "4. Install Theme Slate"
    echo "5. Install Theme Bluetables"
    echo "6. Install Theme Darkenate"
    echo "7. Install Theme Nightadmin"
    echo "8. Install Theme Recolor"
    echo "9. Install Theme Redirect"
    echo "10. Install Theme Snowflakes"
    echo "11. Install Theme Txadminintegration"
    echo "12. Keluar"
    echo "Pilih opsi [1-12]:"
    read -r choice
}

# Perulangan menu
while true; do
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
        echo "Keluar dari program."
        break
        ;;
    *)
        echo "Pilihan tidak valid, coba lagi."
        ;;
    esac
done
