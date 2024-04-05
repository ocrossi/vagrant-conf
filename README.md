## Requirements

Vagrant and VirtualBox installed

plugin vagrant vagrant-disksize : do
                                    vagrant plugin install vagrant-disksize


# to script
A directory ~/vagrantShared 
populated with 1 password file and one pubkey to setup ssh connection without vagrant

can ssh $username@127.0.0.1 -p 2222

## next steps
a way to input username and password, secure and efficient
add encryption to pass before giving it to chpass
and we good

remove linked clone if all good, should just be for tests purposes
add delete part


## goals
ssh key of host should be added to authorized_keys current vm to allow ssh directly into it and not using ssh vagrant all the time

