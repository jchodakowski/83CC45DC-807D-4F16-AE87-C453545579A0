Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/bionic64'
  config.vm.provider 'virtualbox' do |v|
    v.check_guest_additions = false
    v.memory = 2048
    v.cpus = 2
  end
  config.vm.box_check_update = false
  config.vbguest.auto_update = false
  config.vm.network 'forwarded_port', guest: 80, host: 80
  config.vm.network 'forwarded_port', guest: 8080, host: 8080
  config.vm.provision 'shell', path: 'files/prep.sh'
  config.vm.provision :docker
  config.vm.provision 'chef_apply' do |chef|
    chef.recipe = File.read('files/provision.rb')
  end
end
