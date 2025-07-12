#!/bin/sh

sudo apt install \
wget curl tree tmux file eza trash stow btop \
zsh kitty alacritty neovim fzf \
tor obfs4proxy \
mpv qbittorrent \
cmake ninja-build clang-format \
pass gh git git-crypt \
nodejs npm \
obs-studio v4l2loopback-dkms v4l2loopback-utils v4l-utils \
podman-desktop qemu-user-static -y

sudo apt install \
  libx11-dev \
  libxext-dev \
  libxrandr-dev \
  libxcursor-dev \
  libxi-dev \
  libxinerama-dev \
  libxxf86vm-dev \
  libegl1-mesa-dev \
  libwayland-dev \
  libwayland-egl-backend-dev \
  libdbus-1-dev \
  libdrm-dev -y

  sudo apt install flatpak gnome-software-plugin-flatpak -y
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub com.interversehq.qView -y

# curl -s https://ohmyposh.dev/install.sh | bash -s
