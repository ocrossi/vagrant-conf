#!/bin/bash

mkdir ~/vagrantShared/

echo "enter username"
read uname

echo "enter password"
read -s pass

echo "Do you want a GUI? [y\n]"
res=""
while [[ "$res" != [nN] -o "$res" != [yY] ]]
do
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
