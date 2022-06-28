#!/usr/bin/env bash
if [ -d /vagrant ]; then
    for i in /etc/chef /root/.chef /home/vagrant/.chef; do
        mkdir -p $i/accepted_licenses
        cp /vagrant/files/chef_infra_client $i/accepted_licenses/
        cp /vagrant/files/inspec $i/accepted_licenses/
    done
    chown -R vagrant. /home/vagrant/.chef
else
    echo 'Host-local /vagrant path is missing, exiting'
    exit 1
fi