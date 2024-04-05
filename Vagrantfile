Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 8096
    vb.cpus = 4
    vb.linked_clone = true
  end
  config.disksize.size = '50GB'
  config.vm.synced_folder "~/vagrantShared", "/vagrantShared"
  config.vm.provision "shell", path: "setup.sh"
end
