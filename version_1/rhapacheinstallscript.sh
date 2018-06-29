#!/bin/bash
#only for use on RHEL
sudo yum install -y -q httpd

#make sure the /run/httpd is a real directory
mkdir /run/httpd
chmod 777 /run/httpd

#change to kitserver
cd /kitserver/kits/released/Cache/2017.2.0/2017.2.0.651.0/kits/unix/2017.2.0.651.0/

#stop apache
sudo service httpd stop

#install CSP gateway (right now this is interactive)
sudo ./cinstall

#start apache
sudo service httpd start