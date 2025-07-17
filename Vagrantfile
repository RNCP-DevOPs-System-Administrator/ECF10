Vagrant.configure("2") do |config|

  config.vm.define "srv-ad" do |ad|
    ad.vm.box = "gusztavvargadr/windows-server-2022-standard"
    ad.vm.hostname = "srv-ad"
    ad.vm.network "public_network", ip: "192.168.1.2"
	ad.vm.synced_folder "./data", "C:/Users/vagrant/Desktop/vagrant_data"
    ad.vm.communicator = "winrm"
	ad.vm.boot_timeout = 600
	ad.vm.provider "virtualbox" do |vb|
	  vb.name = "srv-ad"
      vb.memory = 2048
      vb.cpus = 2
	  vb.gui = true
	end

  end

  config.vm.define "srv-glpi" do |glpi|
    glpi.vm.box = "generic-x64/ubuntu2210"
    glpi.vm.hostname = "srv-glpi"
    glpi.vm.network "public_network", ip: "192.168.1.3"
	glpi.vm.synced_folder "./data", "/vagrant_data"
	glpi.vm.provider "virtualbox" do |vb|
	  vb.name = "srv-glpi"
      vb.memory = 1024
      vb.cpus = 1
	end
    glpi.vm.provision "shell", path: "scripts/glpi-step1.sh"
  end
	
  config.vm.define "srv-nagios" do |nagios|
    nagios.vm.box = "debian/bullseye64"
    nagios.vm.hostname = "srv-nagios"
    nagios.vm.network "public_network", ip: "192.168.1.4"
	nagios.vm.synced_folder "./data", "/vagrant_data"
	nagios.vm.provider "virtualbox" do |vb|
	  vb.name = "srv-nagios"
      vb.memory = 1024
      vb.cpus = 1
	end
    nagios.vm.provision "shell", path: "scripts/nagios.sh"
  end
  
end
