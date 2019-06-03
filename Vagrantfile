def install_plugin(plugin)
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

install_plugin('vagrant-vbguest')

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.3"
  config.vm.hostname = "dev.rsblog.jp"
  config.vm.network "private_network", ip: "192.168.33.66"

  config.vm.provision "shell", privileged: true, :path => "provision/provision.sh"
  # config.vm.provision "shell", privileged: false, :path => "provision/yesod_init.sh"
  # always run shell
  # config.vm.provision "shell", run: "always", privileged: true, :path => "provision/provision_always_root.sh"
  # config.vm.provision "shell", run: "always", privileged: false, :path => "provision/provision_always.sh"  

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
end
