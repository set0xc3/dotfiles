#!/bin/sh

pacman -Sy --noconfirm \
base-devel \
cmake \
ninja-build \
clang-format \
nodejs \
npm \
git git-crypt lazygit \
gh \
rustup

rustup default stable

git clone https://aur.archlinux.org/paru.git && cd paru
makepkg -si

# Сетевые утилиты и безопасность

paru -Sy --noconfirm \
pass \
wget \
curl \
tor \
obfs4proxy-bin \
podman-desktop \
virt-manager \
qemu-user-static

# Текстовые редакторы и среды

paru -Sy --noconfirm \
neovim \
fzf \
stow

# Терминалы и эмуляторы

paru -Sy --noconfirm \
zsh \
kitty \
alacritty \
tmux


# Мультимедиа

paru -Sy --noconfirm \
mpv \
obs-studio \
v4l2loopback-dkms \
v4l2loopback-utils \
v4l-utils

# Утилиты командной строки

paru -Sy --noconfirm \
xclip wl-clipboard \
tree \
file \
eza \
trash \
btop

paru -Sy --noconfirm \
zed \
waterfox-bin \
obsidian \
obs-studio \
telegram-desktop \
discord-desktop \
qbittorrent \
freecad \
kicad \
libreoffice-still \
blender
