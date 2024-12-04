#!/bin/bash

# Menampilkan pengenal dengan animasi masuk
clear
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
echo -e "\e[1;36m    Auto Install Blueprint Theme Pterodactyl by IndoLife   \e[0m"
echo -e "\e[1;34m------------------------------------------------------------\e[0m"
echo -e "\e[1;32m        √ Auto Install | √ Mudah | √ Cepat | √ Support All Panel \e[0m"
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
  echo -e "\e[1;31m    4. Exit\e[0m"
  echo -e "\e[1;34m------------------------------------------------------------\e[0m"
  read -p "Masukkan nomor pilihan (1-4): " pilihan

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

    2)
      # Install Tema Nebula
      echo -e "\e[1;36mMengunduh dan menginstal Tema Nebula...\e[0m"
      sleep 1

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
      echo -e "\e[1;32mMenginstal tema Nebula...\e[0m"
      sudo blueprint -i nebula

      echo -e "\e[1;32mInstalasi tema Nebula selesai!\e[0m"
      echo -e "\e[1;32mTerima kasih telah menggunakan skrip ini! Instalasi berhasil.\e[0m"
      sleep 2
      menu_utama
      ;;

    3)
      # Install Tema Slate
      echo -e "\e[1;36mMengunduh dan menginstal Tema Slate...\e[0m"
      sleep 1

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
      echo -e "\e[1;32mMenginstal tema Slate...\e[0m"
      sudo blueprint -i slate

      echo -e "\e[1;32mInstalasi tema Slate selesai!\e[0m"
      echo -e "\e[1;32mTerima kasih telah menggunakan skrip ini! Instalasi berhasil.\e[0m"
      sleep 2
      menu_utama
      ;;

    4)
      # Keluar dari skrip dengan animasi keluar
      echo -e "\e[1;31mKeluar dari skrip... Terima kasih!\e[0m"
      sleep 1
      clear
      echo -e "\e[1;32mProses selesai! Sampai jumpa lagi!\e[0m"
      exit 0
      ;;

    *)
      echo -e "\e[1;31mPilihan tidak valid. Silakan pilih antara 1-4.\e[0m"
      exit 1
      ;;
  esac
}

# Memulai menu utama
menu_utama
