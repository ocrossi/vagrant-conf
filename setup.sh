#!/bin/bash

username=rossi

#global installs
apt update  && apt upgrade -y
apt install -y git fuse gcc tldr fzf make cmake curl zsh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
mv ./nvim.appimage /usr/bin/nvim
chmod +x /usr/bin/nvim


# User config

mkdir -p "/etc/skel/.config/nvim"
git clone https://github.com/ocrossi/lazy-nvim-config "/etc/skel/.config/nvim"


useradd -m $username
cat /vagrantShared/passwd_file | chpasswd
echo "$username  ALL=(ALL:ALL) ALL" >> /etc/sudoers
chsh -s "$(which zsh)" $username
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

su -l $username -c '
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
'


su -l $username -c '
cat /vagrantShared/id_rsa.pub

mkdir -p "/home/$(whoami)/.ssh" &&
	touch "/home/$(whoami)/.ssh/authorized_keys" &&
	cd "/home/$(whoami)/.ssh" &&
	cat /vagrantShared/id_rsa.pub > authorized_keys
'

usermod --expiredate 1 vagrant
service sshd restart

# delete part
# rm /vagrantShared/id_rsa.pub
# rm /vagrantShared/passwd_file
