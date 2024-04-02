#!/bin/bash

username=rossi
pass=test

apt update  && apt upgrade -y
apt install -y git fuse gcc tldr fzf make cmake curl zsh
chsh $(which zsh)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x ./nvim.appimage
mv ./nvim.appimage /usr/bin/nvim

useradd -m $username



# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"




mkdir -p "/home/$username/.config/nvim"

git clone https://github.com/ocrossi/lazy-nvim-config "/home/$username/.config/nvim"

su $username
