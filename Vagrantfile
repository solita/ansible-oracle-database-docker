# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    provisioner = Vagrant::Util::Platform.windows? ? :guest_ansible : :ansible

    nodes = {
        'dbvagrant' => { :ip  => '192.168.50.50', :memory => 4000 },
    }

    config.ssh.insert_key = false
    config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

    nodes.each do |node_name, node_opts|
        config.vm.define node_name do |node_config|
            node_config.vm.hostname = "#{node_name}"
            node_config.vm.box = "elastic/oraclelinux-7-x86_64"

            node_config.vm.network :private_network, ip: node_opts[:ip]

            node_config.vm.provider "virtualbox" do |v|
                v.gui = false
                v.memory = node_opts[:memory]
                v.cpus = 4
                v.customize ["createhd",  "--filename", ".vagrant/#{node_name}_docker.vdi", "--size", "262144"] unless File.exist?(".vagrant/#{node_name}_docker.vdi")
                v.customize ["storageattach", :id, "--storagectl", "IDE Controller", '--device', 0, "--port", "1", "--type", "hdd", "--medium", ".vagrant/#{node_name}_docker.vdi"]

                v.customize ["createhd",  "--filename", ".vagrant/#{node_name}_oracledata.vdi", "--size", "262144"] unless File.exist?(".vagrant/#{node_name}_oracledata.vdi")
                v.customize ["storageattach", :id, "--storagectl", "IDE Controller", '--device', 1, "--port", "1", "--type", "hdd", "--medium", ".vagrant/#{node_name}_oracledata.vdi"]
            end

        end
    end

    # Otherwise host-only network for node static ip is nqqot available
    #config.vm.provision "shell", inline: "sudo systemctl restart network;"

    nodes.each_with_index do |(node_name, opts), i|
        config.vm.define node_name do |machine|
            if i == nodes.size - 1 then
                machine.vm.provision provisioner do |ansible|
                    ansible.limit = "all"
                    ansible.playbook = "vagrant.yml"
                    ansible.inventory_path = "environments/dbvagrant"
                    ansible.verbose = "vv"
                    #ansible.tags = ["oracledb-create"]
                    ansible.extra_vars = {
                        "local_netmask" => "192.168.50.0/24",
                        "vagrant_environment" => true
                    }
                end
            end
        end
    end
end