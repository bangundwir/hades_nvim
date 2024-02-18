#!/bin/bash

# Fungsi untuk menampilkan pesan kesalahan
display_error() {
    echo "Terjadi kesalahan: $1" >&2
    exit 1
}

# Fungsi untuk menginstal Node.js dan npm di Arch Linux
install_node_arch() {
    echo "Memulai instalasi Node.js dan npm..."
    sudo pacman -S --noconfirm nodejs npm || display_error "Gagal menginstal Node.js dan npm"
}

# Fungsi untuk menginstal Node.js dan npm di Ubuntu
install_node_ubuntu() {
    echo "Memulai instalasi Node.js dan npm..."
    curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - || display_error "Gagal menambahkan repositori Node.js"
    sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install nodejs || display_error "Gagal menginstal Node.js dan npm"
}

# Fungsi untuk mengkloning packer.nvim
install_packer_nvim() {
    echo "Memulai mengunduh dan menginstal packer.nvim..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim || display_error "Gagal mengkloning packer.nvim"
}

# Fungsi untuk mengkloning konfigurasi Neovim
install_neovim_config() {
    echo "Memulai mengunduh dan menginstal konfigurasi Neovim..."
    git clone https://github.com/bangundwir/hades_nvim.git ~/.config/nvim || display_error "Gagal mengkloning konfigurasi Neovim"
}

# Menampilkan pesan selamat datang dan informasi
echo "Selamat datang pada skrip instalasi Neovim!"
echo "Skrip ini akan membantu Anda menginstal Neovim beserta beberapa dependensinya."

# Memeriksa distribusi yang digunakan
if [ -f "/etc/arch-release" ]; then
    echo "Distribusi: Arch Linux"
    install_node_arch
elif [ -f "/etc/lsb-release" ]; then
    echo "Distribusi: Ubuntu"
    install_node_ubuntu
else
    display_error "Distribusi tidak didukung"
fi

# Memeriksa apakah packer.nvim sudah terinstal
if [ -d "~/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
    echo "packer.nvim sudah terinstal, melewati langkah ini."
else
    install_packer_nvim
fi

# Memeriksa apakah konfigurasi Neovim sudah ada
if [ -d "~/.config/nvim" ]; then
    echo "Konfigurasi Neovim sudah ada, melewati langkah ini."
else
    install_neovim_config
fi

echo "Instalasi Neovim selesai! Selamat menikmati pengeditan yang lebih baik dengan Neovim."

