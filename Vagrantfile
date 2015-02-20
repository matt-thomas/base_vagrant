require 'yaml'

vconfig = YAML::load_file('config.yml')

Vagrant.configure(2) do |config|
  config.vm.box = "dbarbar/local-springboard"

  config.vm.network :private_network, ip: vconfig['ip']
  config.vm.hostname = vconfig['name']
  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  config.vm.synced_folder vconfig['docroot'], "/docroot", type: "nfs"

  unless vconfig['synced_folders'].nil?
    vconfig['synced_folders'].each do |item|
      config.vm.synced_folder item['source'], item['destination'], type: "nfs"
    end
  end

  # VirtualBox
  config.vm.provider "virtualbox" do |v, override|
    v.name = vconfig['name']
    v.memory = vconfig['memory']
    v.cpus = vconfig['cpus']

    # Fix issue with DNS
    # @todo Is this still needed?
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # VMWare Fusion
  config.vm.provider "vmware_fusion" do |v, override|
    v.name = vconfig['name']
    v.memory = vconfig['memory']
    v.cpus = vconfig['cpus']
  end

  config.vm.provision "shell" do |s|
    s.path = "scripts/provision.sh"
    s.args = [vconfig['domain']]
  end

end
