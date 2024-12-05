#!/bin/bash

install_blueprint() {
    echo ">> INSTALL BLUEPRINT <<"
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
}

install_theme() {
    echo ">> INSTALL THEME <<"
    THEME_NAME=$1
    if [ -z "$THEME_NAME" ]; then
        echo "Theme name required"
        return
    fi
    git clone https://github.com/indolifemd/theme.git
    cd theme || exit
    sudo mv nebulaslate2.zip /var/www/pterodactyl
    cd /var/www/pterodactyl || exit
    sudo unzip nebulaslate2.zip
    blueprint -i "$THEME_NAME"
}

show_menu() {
    echo "Silakan pilih opsi instalasi:"
    echo "1. Install Blueprint (wajib)"
    echo "2. Install Theme Nebula"
    echo "3. Install Theme Slate"
    echo "4. Install Theme Bluetables"
    echo "5. Install Theme Darkenate"
    echo "6. Install Theme Nightadmin"
    echo "7. Install Theme Recolor"
    echo "8. Install Theme Redirect"
    echo "9. Install Theme Snowflakes"
    echo "10. Install Theme Txadminintegration"
    echo "11. Kembali"
    echo "Pilih opsi [1-11]:"
    read -r choice
}

while true; do
    show_menu
    case $choice in
    1)
        install_blueprint
        ;;
    2)
        install_theme "nebula"
        ;;
    3)
        install_theme "slate"
        ;;
    4)
        install_theme "bluetables"
        ;;
    5)
        install_theme "darkenate"
        ;;
    6)
        install_theme "nightadmin"
        ;;
    7)
        install_theme "recolor"
        ;;
    8)
        install_theme "redirect"
        ;;
    9)
        install_theme "snowflakes"
        ;;
    10)
        install_theme "txadminintegration"
        ;;
    11)
        echo "Keluar dari program."
        break
        ;;
    *)
        echo "Pilihan tidak valid, coba lagi."
        ;;
    esac
done
