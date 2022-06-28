service 'nginx' do
  action :nothing
end

service 'mysql' do
  action :nothing
end

bash 'nodejs gpg key' do
  code <<-EOL
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  EOL
end

apt_update

%w(
  mysql-server
  nginx
  gradle
  nodejs
).each do |pkg|
  package pkg do
    action :install
  end
end

git 'ohalo' do
  repository 'https://github.com/Ohalo-Ltd/ohalo-jhipster-sample'
end

bash 'build ohalo' do
  code <<-EOL
    npm install
  EOL
  cwd '/home/vagrant/ohalo'
  notifies :start, 'service[mysql]', :immediately
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  only_if { File.exist?('/etc/nginx/sites-enabled/default') }
end


