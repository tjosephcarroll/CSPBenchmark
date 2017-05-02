#!/bin/bash
echo "Client Installation Script - RHEL"

#wrk installation
echo "Installing wrk http benchmark tool"
sudo yum -y -q groupinstall 'Development Tools'
sudo yum -y -q install  openssl-devel
sudo yum -y -q install  git
git clone https://github.com/wg/wrk.git
cd wrk
make
cd ..

#ruby installation
echo "installing ruby"
sudo yum -y -q install ruby

#get benchmark from git
echo "Pulling ruby code from git repository"
git clone https://github.com/tjosephcarroll/CSPBenchmark


