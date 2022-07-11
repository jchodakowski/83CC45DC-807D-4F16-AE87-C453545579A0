service 'nginx' do
  action :nothing
end

bash 'nodejs gpg key' do
  code <<-EOL
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  EOL
end

apt_update

%w(
  openjdk-11-jdk-headless
  nginx
  nodejs
).each do |pkg|
  package pkg do
    action :install
  end
end

remote_file '/usr/local/bin/docker-compose' do
  source 'https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64'
  owner 'root'
  group 'root'
  mode '0755'
  not_if { File.exist?('/usr/local/bin/docker-compose') }
end

git 'ohalo-jhipster-sample' do
  repository 'https://github.com/Ohalo-Ltd/ohalo-jhipster-sample'
end

workdir = '/home/vagrant/ohalo-jhipster-sample'
bash 'npm install' do
  code <<-EOL
    npm install
  EOL
  cwd workdir
end

bash 'gradlew bootJar' do
  code <<-EOL
    ./gradlew bootJar -Pprod jibDockerBuild
  EOL
  cwd workdir
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  only_if { File.exist?('/etc/nginx/sites-available/ohalo-jhipster-sample') }
end

bash 'copy nginx config' do
  code <<-EOL
    cp /vagrant/files/nginx.conf /etc/nginx/sites-available/ohalo-jhipster-sample
  EOL
  only_if { File.exist?('/vagrant/files/nginx.conf') }
end

file '/etc/nginx/sites-available/ohalo-jhipster-sample' do
  owner 'root'
  group 'root'
  mode '0644'
end

link '/etc/nginx/sites-enabled/default' do
  to '/etc/nginx/sites-available/ohalo-jhipster-sample'
  notifies :start, 'service[nginx]', :immediately
end

bash 'docker compose' do
  code <<-EOL
    docker-compose -f src/main/docker/app.yml up -d
  EOL
  cwd workdir
  only_if { File.exist?('/usr/local/bin/docker-compose') }
end

