Vagrant.configure('2') do |config|
  #config.vm.box = 'centos/7'
  config.vm.box = 'ubuntu/bionic64'
  #config.vm.box_check_update = false
  config.vbguest.auto_update = false
  config.vm.network 'forwarded_port', guest: 80, host: 80
  config.vm.network 'forwarded_port', guest: 443, host: 443
  config.vm.provision 'shell', path: 'files/prep.sh'
  config.vm.provision 'chef_apply' do |chef|
    chef.recipe = File.read('files/provision.rb')
  end
end
