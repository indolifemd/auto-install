#!/bin/bash

echo ">> INSTALL NODE 20 DAN KEY <<"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install -y nodejs

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

echo ">> PROSES DOWNLOAD THEME NEBULA × SLATE <<"
git clone https://github.com/indolifemd/theme.git

cd theme || exit
sudo mv nebulaslate2.zip /var/www/pterodactyl

echo ">> PROSES PENDEKSTRAKAN <<"
cd /var/www/pterodactyl || exit
sudo unzip nebulaslate2.zip

echo ">> PROSES PENGINSTALLAN <<"
blueprint -i nebula
blueprint -i slate
blueprint -i bluetables
blueprint -i darkenate
blueprint -i nightadmin
blueprint -i recolor
blueprint -i redirect
blueprint -i snowflakes
blueprint -i txadminintegration

echo ">> INSTALASI SELESAI <<"
echo "Silakan pilih opsi:"
echo "1. blueprint (wajib)"
echo "2. Nebula"
echo "3. Slate"
echo "4. Bluetables"
echo "5. Darkenate"
echo "6. Nightadmin"
echo "7. Recolor"
echo "8. Redirect"
echo "9. Snowflakes"
echo "10. txadminintegration"
echo "11. Kembali"
