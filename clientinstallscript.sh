#!/bin/bash
echo "Client Installation Script"
sudo  yum groupinstall 'Development Tools'
sudo yum install  openssl-devel
sudo yum install  git
git clone https://github.com/wg/wrk.git
cd wrk
make