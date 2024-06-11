#!/bin/bash


if [ -d $HOME/ft_ping/ ]; then
  echo "Directory ft_ping exists."
fi



if [ ! -d "$HOME/vagrantShared" ]
then
	mkdir $HOME/vagrantShared/
else
	echo "vagrantShared directory already exists in user's home folder"
	echo "This script will override"
	echo "~/vagrantShared/id_rsa.pub"
	echo "~/vagrantShared/passwd_file"
	echo 
fi

echo "enter username"
read uname

while [ $pass != $confirm ]
do
	echo "enter password"
	read -s pass
	echo "re-enter password"
	read -s confirm
done

echo "Do you want a GUI? [y\n]"
res=""
while [ true ]
do
	if [[ $res == [nN] || $res == [yY]* ]]
	then
		 break
	fi
	read res
done

if [[ $res == [yY] ]]
then
	guires=true
else
	guires=false
fi

echo "enter vm vame"
read vm_name

echo "$uname:$pass" > ~/vagrantShared/passwd_file
cp ~/.ssh/id_rsa.pub ~/vagrantShared/id_rsa.pub

GUI_TOGGLE=$guires VM_NAME=$vm_name vagrant up
