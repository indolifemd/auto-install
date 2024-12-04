#!/bin/bash

# Animasi pembukaan
animasi_pembukaan() {
  clear
  for i in {1..3}; do
    echo -e "\e[1;36mLoading"
    sleep 0.2
    echo -e "\e[1;36mLoading.\e[0m"
    sleep 0.2
    echo -e "\e[1;36mLoading..\e[0m"
    sleep 0.2
    echo -e "\e[1;36mLoading...\e[0m"
    sleep 0.2
    clear
  done
  echo -e "\e[1;34m------------------------------------------------------------\e[0m"
  echo -e "\e[1;36m   Welcome to Auto Install Blueprint Theme by IndoLife   \e[0m"
  echo -e "\e[1;34m------------------------------------------------------------\e[0m"
  sleep 1
}

# Fungsi instalasi tema
install_theme() {
  THEME_NAME=$1
  ZIP_NAME="${THEME_NAME}.zip"
  REPO_URL="https://github.com/indolifemd/theme.git"
  INSTALL_DIR="/var/www/pterodactyl"

  echo -e "\e[1;36mMengunduh dan menginstal tema $THEME_NAME...\e[0m"

  # Direktori sementara
  TEMP_DIR=$(mktemp -d)
  cd "$TEMP_DIR" || { echo "Gagal membuat direktori sementara"; exit 1; }

  # Clone repository
  echo -e "\e[1;32mMengunduh repository tema...\e[0m"
  git clone "$REPO_URL" || { echo -e "\e[1;31mGagal mengunduh repository.\e[0m"; exit 1; }

  # Masuk ke direktori repository
  cd theme || { echo -e "\e[1;31mGagal masuk ke direktori repository\e[0m"; exit 1; }

  # Periksa file ZIP
  if [ ! -f "$ZIP_NAME" ]; then
    echo -e "\e[1;31mFile $ZIP_NAME tidak ditemukan di repository.\e[0m"
    exit 1
  fi

  # Pindahkan dan ekstrak file
  sudo mv "$ZIP_NAME" "$INSTALL_DIR"
  cd "$INSTALL_DIR" || { echo -e "\e[1;31mGagal masuk ke direktori $INSTALL_DIR\e[0m"; exit 1; }
  sudo unzip -o "$ZIP_NAME"
  sudo rm "$ZIP_NAME"

  echo -e "\e[1;32mTema $THEME_NAME berhasil diinstal!\e[0m"
  echo -e "\e[1;36mKembali ke menu utama...\e[0m"
  sleep 2
  menu_utama
}

# Fungsi instalasi blueprint framework
install_blueprint() {
  echo -e "\e[1;36mMemulai instalasi Blueprint Framework...\e[0m"

  # Install Node.js
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg zip unzip git yarn
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  sudo apt-get update
  sudo apt-get install -y nodejs

  # Instalasi di direktori Pterodactyl
  cd /var/www/pterodactyl || { echo -e "\e[1;31mGagal masuk ke direktori Pterodactyl\e[0m"; exit 1; }
  sudo yarn
  sudo yarn add cross-env

  # Unduh dan ekstrak Blueprint Framework
  echo -e "\e[1;32mMengunduh Blueprint Framework...\e[0m"
  wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O release.zip
  sudo unzip -o release.zip
  sudo rm release.zip

  echo -e "\e[1;32mInstalasi Blueprint Framework selesai!\e[0m"
  echo -e "\e[1;36mKembali ke menu utama...\e[0m"
  sleep 2
  menu_utama
}

# Menu utama
menu_utama() {
  clear
  echo -e "\e[1;34m------------------------------------------------------------\e[0m"
  echo -e "\e[1;35m    Pilih komponen yang ingin diinstal: \e[0m"
  echo -e "\e[1;33m    1. Install Blueprint\e[0m"
  echo -e "\e[1;33m    2. Install Tema Nebula\e[0m"
  echo -e "\e[1;33m    3. Install Tema Slate\e[0m"
  echo -e "\e[1;33m    4. Install Tema BlueTables\e[0m"
  echo -e "\e[1;33m    5. Install Tema Darkenate\e[0m"
  echo -e "\e[1;33m    6. Install Tema NightAdmin\e[0m"
  echo -e "\e[1;33m    7. Install Tema Recolor\e[0m"
  echo -e "\e[1;33m    8. Install Tema Redirect\e[0m"
  echo -e "\e[1;33m    9. Install Tema Snowflakes\e[0m"
  echo -e "\e[1;33m    10. Install Tema TXAdminIntegration\e[0m"
  echo -e "\e[1;31m    11. Exit\e[0m"
  echo -e "\e[1;34m------------------------------------------------------------\e[0m"
  read -p "Masukkan nomor pilihan (1-11): " pilihan

  case $pilihan in
    1) install_blueprint ;;
    2) install_theme "nebulaslate" ;;
    3) install_theme "slate" ;;
    4) install_theme "bluetables" ;;
    5) install_theme "darkenate" ;;
    6) install_theme "nightadmin" ;;
    7) install_theme "recolor" ;;
    8) install_theme "redirect" ;;
    9) install_theme "snowflakes" ;;
    10) install_theme "txadminintegration" ;;
    11) 
      echo -e "\e[1;31mKeluar dari skrip... Terima kasih!\e[0m"
      exit 0 
      ;;
    *) 
      echo -e "\e[1;31mPilihan tidak valid. Silakan coba lagi.\e[0m"
      menu_utama 
      ;;
  esac
}

# Jalankan animasi pembukaan dan menu utama
animasi_pembukaan
menu_utama
