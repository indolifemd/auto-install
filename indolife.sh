#!/bin/bash

# Menampilkan pengenal dengan animasi masuk
clear
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
echo -e "\e[1;36m    Auto Install Blueprint Theme Pterodactyl by IndoLife   \e[0m"
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
echo -e "\e[1;32m        âˆš Auto Install | âˆš Mudah | âˆš Cepat | âˆš Support All Panel \e[0m"
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
echo -e "\e[1;33mSelamat datang! Skrip ini akan memandu Anda untuk menginstal komponen yang dipilih.\e[0m"
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
sleep 1

# Animasi teks pembuka
for i in {1..3}
do
  echo -e "\e[1;32mMemulai inisialisasi... (Tunggu sebentar)\e[0m"
  sleep 0.5
  clear
  echo -e "\e[1;32mMemulai inisialisasi.. (Tunggu sebentar)\e[0m"
  sleep 0.5
  clear
done

sleep 1

# Fungsi untuk menampilkan menu utama
menu_utama() {
  echo -e "\e[1;34m------------------------------------------------------------\e[0m"
  echo -e "\e[1;35m    Pilih komponen yang ingin diinstal: \e[0m"
  echo -e "\e[1;33m    1. Install Blueprint\e[0m"
  echo -e "\e[1;33m    2. Install Tema Nebula\e[0m"
  echo -e "\e[1;33m    3. Install Tema Slate\e[0m"
  echo -e "\e[1;33m    4. Install bluetables\e[0m"
  echo -e "\e[1;33m    5. Install darkenate\e[0m"
  echo -e "\e[1;33m    6. Install nightadmin\e[0m"
  echo -e "\e[1;33m    7. Install recolor\e[0m"
  echo -e "\e[1;33m    8. Install redirect\e[0m"
  echo -e "\e[1;33m    9. Install snowflakes\e[0m"
  echo -e "\e[1;33m    10. Install txadminintegration\e[0m"
  echo -e "\e[1;31m    11. Exit\e[0m"
  echo -e "\e[1;34m------------------------------------------------------------\e[0m"
  read -p "Masukkan nomor pilihan (1-11): " pilihan

  case $pilihan in
    1)
      # Install Blueprint
      echo -e "\e[1;36mMemulai instalasi Blueprint Framework...\e[0m"
      sleep 1
      # Install Node.js 20
      sudo apt-get install -y ca-certificates curl gnupg
      sudo mkdir -p /etc/apt/keyrings
      curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
      echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
      sudo apt-get update
      sudo apt-get install -y nodejs

      # Install Blueprint Framework
      cd /var/www/pterodactyl || { echo "Gagal masuk ke direktori Pterodactyl"; exit 1; }
      sudo yarn
      sudo yarn add cross-env
      sudo apt install -y zip unzip git curl wget

      # Unduh Blueprint Framework
      echo -e "\e[1;32mMengunduh Blueprint Framework...\e[0m"
      wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O release.zip

      # Ekstrak Blueprint Framework
      echo -e "\e[1;32mMengekstrak Blueprint Framework...\e[0m"
      sudo unzip release.zip
      sudo rm release.zip

      # Sesuaikan pengaturan hak akses dan pemilik file
      FOLDER="/var/www/pterodactyl"
      WEBUSER="www-data"
      USERSHELL="/bin/bash"
      PERMISSIONS="www-data:www-data"
      sudo sed -i -E -e "s|WEBUSER=\"www-data\" #;|WEBUSER=\"$WEBUSER\" #;|g" -e "s|USERSHELL=\"/bin/bash\" #;|USERSHELL=\"$USERSHELL\" #;|g" -e "s|OWNERSHIP=\"www-data:www-data\" #;|OWNERSHIP=\"$PERMISSIONS\" #;|g" $FOLDER/blueprint.sh

      # Berikan izin eksekusi dan jalankan skrip Blueprint
      echo -e "\e[1;32mMemberikan izin eksekusi pada blueprint.sh dan menjalankan instalasi Blueprint...\e[0m"
      sudo chmod +x blueprint.sh
      sudo bash blueprint.sh

      echo -e "\e[1;32mInstalasi Blueprint selesai!\e[0m"
      echo -e "\e[1;32mTerima kasih telah menggunakan skrip ini! Instalasi berhasil.\e[0m"
      sleep 2
      menu_utama
      ;;

# Menampilkan header awal
clear
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
echo -e "\e[1;36m    Auto Install Themes from IndoLife Repository            \e[0m"
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
sleep 1

# Variabel global
REPO_URL="https://github.com/indolifemd/theme.git"
WORK_DIR="/var/www/pterodactyl"
THEME_DIR="$WORK_DIR/theme"

# Validasi direktori kerja Pterodactyl
validate_directory() {
  if [ ! -d "$WORK_DIR" ]; then
    echo -e "\e[1;31mDirektori Pterodactyl ($WORK_DIR) tidak ditemukan! Pastikan Anda sudah menginstal Pterodactyl.\e[0m"
    exit 1
  fi
}

# Unduh repository
download_repository() {
  if [ -d "$THEME_DIR" ]; then
    echo -e "\e[1;33mDirektori 'theme' sudah ada. Menghapus...\e[0m"
    sudo rm -rf "$THEME_DIR"
  fi

  echo -e "\e[1;32mMengunduh repository tema dari $REPO_URL...\e[0m"
  git clone "$REPO_URL" "$THEME_DIR" || { echo -e "\e[1;31mGagal mengunduh repository tema.\e[0m"; exit 1; }
}

# Tampilkan daftar tema
list_themes() {
  FILES=$(find "$THEME_DIR" -type f -name "*.zip" | sed 's#.*/##' | sed 's/.zip$//g')
  if [ -z "$FILES" ]; then
    echo -e "\e[1;31mTidak ada tema ditemukan di repository.\e[0m"
    exit 1
  fi

  echo -e "\e[1;35mDaftar tema yang tersedia:\e[0m"
  i=1
  for THEME in $FILES; do
    if [ $i -le 9 ]; then
      echo -e "\e[1;33m    $i. $THEME\e[0m"
      THEME_LIST[$i]="$THEME"
      ((i++))
    fi
  done
  echo -e "\e[1;31m    9. Keluar\e[0m"
  return $i
}

# Proses instalasi tema tertentu
install_theme() {
  local THEME_NAME=$1
  local FILE_PATH="$THEME_DIR/$THEME_NAME.zip"

  echo -e "\e[1;36mMemproses tema: $THEME_NAME\e[0m"

  # Pastikan file .zip ada
  if [ ! -f "$FILE_PATH" ]; then
    echo -e "\e[1;31mFile $THEME_NAME.zip tidak ditemukan.\e[0m"
    return
  fi

  # Salin file .zip ke direktori kerja
  sudo cp "$FILE_PATH" "$WORK_DIR"

  # Ekstrak file .zip
  echo -e "\e[1;32mMengekstrak $THEME_NAME.zip...\e[0m"
  sudo unzip -o "$WORK_DIR/$THEME_NAME.zip" -d "$WORK_DIR" || { echo -e "\e[1;31mGagal mengekstrak $THEME_NAME.zip.\e[0m"; sudo rm "$WORK_DIR/$THEME_NAME.zip"; return; }
  sudo rm "$WORK_DIR/$THEME_NAME.zip"

  # Jalankan perintah blueprint untuk menginstal tema
  echo -e "\e[1;32mMenginstal tema $THEME_NAME dengan blueprint...\e[0m"
  sudo blueprint -i "$THEME_NAME" || { echo -e "\e[1;31mGagal menginstal tema $THEME_NAME.\e[0m"; return; }

  echo -e "\e[1;32mTema $THEME_NAME berhasil diinstal!\e[0m"
}

# Menu utama
menu_utama() {
  validate_directory
  download_repository

  while true; do
    echo -e "\e[1;34m------------------------------------------------------------\e[0m"
    echo -e "\e[1;36mPilih opsi:\e[0m"
    list_themes
    TOTAL_OPTIONS=$?

    read -p "Masukkan nomor pilihan Anda (1-9): " PILIHAN

    if [[ $PILIHAN -ge 1 && $PILIHAN -lt $TOTAL_OPTIONS ]]; then
      install_theme "${THEME_LIST[$PILIHAN]}"
    elif [[ $PILIHAN -eq 9 ]]; then
      echo -e "\e[1;31mKeluar dari skrip... Terima kasih telah menggunakan!\e[0m"
      exit 0
    else
      echo -e "\e[1;31mPilihan tidak valid! Silakan coba lagi.\e[0m"
    fi
  done
}

# Jalankan menu utama
menu_utama
