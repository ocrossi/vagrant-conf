#!/bin/bash

set -eou pipefail

username=$1

export DEBIAN_FRONTEND=noninteractive

#global installs
apt-get update  && apt-get upgrade -y
apt-get install -y git fuse gcc tldr fzf make cmake curl zsh tmux man python3 unzip ripgrep docker-compose


curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
mv ./nvim.appimage /usr/bin/nvim
chmod +x /usr/bin/nvim

# Add Docker official GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
 


# User config

mkdir -p "/etc/skel/.config/nvim"
git clone https://github.com/ocrossi/kickstart.nvim "/etc/skel/.config/nvim"


useradd -m $username
cat /vagrantShared/passwd_file | chpasswd
echo "$username  ALL=(ALL:ALL) ALL" >> /etc/sudoers
chsh -s "$(which zsh)" $username
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

su -l $username -c '
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cat /vagrantShared/id_rsa.pub

# create home
mkdir -p "/home/$(whoami)/.ssh" &&
	touch "/home/$(whoami)/.ssh/authorized_keys" &&
	cd "/home/$(whoami)/.ssh" &&
	cat /vagrantShared/id_rsa.pub > /home/$(whoami)/.ssh/authorized_keys

# generate ssh key
echo -e "\n" | ssh-keygen -t rsa -N ""


'

# delete vagrant user
usermod --expiredate 1 vagrant

service sshd restart

# delete part
rm /vagrantShared/*

cat <<EOF
Environment deployed successfully!
EOF
