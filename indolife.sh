#!/bin/bash

# Menampilkan pengenal
clear
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
echo -e "\e[1;33m    Auto Install Blueprint Theme Pterodactyl by IndoLife   \e[0m"
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
echo -e "\e[1;32m        √ Auto Install | √ Mudah | √ Cepat | √ Support All Panel \e[0m"
echo -e "\e[1;33m------------------------------------------------------------\e[0m"

# Menampilkan ucapan selamat datang
echo -e "\e[1;32mSelamat datang! Skrip ini akan memandu Anda untuk menginstal komponen yang dipilih.\e[0m"
echo -e "\e[1;33m------------------------------------------------------------\e[0m"
sleep 2

# Fungsi untuk menampilkan menu utama
menu_utama() {
  echo "Pilih komponen yang ingin diinstal:"
  echo "1. Install Blueprint"
  echo "2. Install Tema Nebula"
  echo "3. Install Tema Slate"
  echo "4. Exit"
  read -p "Masukkan nomor pilihan (1-4): " pilihan

  case $pilihan in
    1)
      # Install Blueprint
      echo "Memulai instalasi Blueprint Framework..."

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
      echo "Mengunduh Blueprint Framework..."
      wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O release.zip

      # Ekstrak Blueprint Framework
      echo "Mengekstrak Blueprint Framework..."
      sudo unzip release.zip
      sudo rm release.zip

      # Sesuaikan pengaturan hak akses dan pemilik file
      FOLDER="/var/www/pterodactyl"
      WEBUSER="www-data"
      USERSHELL="/bin/bash"
      PERMISSIONS="www-data:www-data"
      sudo sed -i -E -e "s|WEBUSER=\"www-data\" #;|WEBUSER=\"$WEBUSER\" #;|g" -e "s|USERSHELL=\"/bin/bash\" #;|USERSHELL=\"$USERSHELL\" #;|g" -e "s|OWNERSHIP=\"www-data:www-data\" #;|OWNERSHIP=\"$PERMISSIONS\" #;|g" $FOLDER/blueprint.sh

      # Berikan izin eksekusi dan jalankan skrip Blueprint
      echo "Memberikan izin eksekusi pada blueprint.sh dan menjalankan instalasi Blueprint..."
      sudo chmod +x blueprint.sh
      sudo bash blueprint.sh

      echo "Instalasi Blueprint selesai!"
      echo -e "\e[1;32mTerima kasih telah menggunakan skrip ini! Instalasi berhasil.\e[0m"
      sleep 2
      menu_utama
      ;;

    2)
      # Install Tema Nebula
      echo "Mengunduh dan menginstal Tema Nebula..."

      # Clone repository tema
      git clone https://github.com/dadan55/IndoLife234.git
      cd IndoLife234 || { echo "Gagal masuk ke direktori IndoLife234"; exit 1; }

      # Pindahkan file ZIP ke direktori Pterodactyl
      sudo mv nebulaslate.zip /var/www/pterodactyl

      # Ekstrak file tema
      cd /var/www/pterodactyl
      sudo unzip nebulaslate.zip

      # Memeriksa file yang telah diekstrak
      echo "Memeriksa file tema yang telah diekstrak..."
      ls /var/www/pterodactyl

      # Instalasi tema Nebula
      echo "Menginstal tema Nebula..."
      sudo blueprint -i nebula

      echo "Instalasi tema Nebula selesai!"
      echo -e "\e[1;32mTerima kasih telah menggunakan skrip ini! Instalasi berhasil.\e[0m"
      sleep 2
      menu_utama
      ;;

    3)
      # Install Tema Slate
      echo "Mengunduh dan menginstal Tema Slate..."

      # Clone repository tema
      git clone https://github.com/dadan55/IndoLife234.git
      cd IndoLife234 || { echo "Gagal masuk ke direktori IndoLife234"; exit 1; }

      # Pindahkan file ZIP ke direktori Pterodactyl
      sudo mv nebulaslate.zip /var/www/pterodactyl

      # Ekstrak file tema
      cd /var/www/pterodactyl
      sudo unzip nebulaslate.zip

      # Memeriksa file yang telah diekstrak
      echo "Memeriksa file tema yang telah diekstrak..."
      ls /var/www/pterodactyl

      # Instalasi tema Slate
      echo "Menginstal tema Slate..."
      sudo blueprint -i slate

      echo "Instalasi tema Slate selesai!"
      echo -e "\e[1;32mTerima kasih telah menggunakan skrip ini! Instalasi berhasil.\e[0m"
      sleep 2
      menu_utama
      ;;

    4)
      # Keluar dari skrip
      echo "Keluar dari skrip... Terima kasih!"
      exit 0
      ;;

    *)
      echo "Pilihan tidak valid. Silakan pilih antara 1-4."
      exit 1
      ;;
  esac
}

# Memulai menu utama
menu_utama
