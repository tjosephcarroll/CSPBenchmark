#!/bin/bash
echo "Client Installation Script - RHEL"

#wrk installation
sudo yum -y -q groupinstall 'Development Tools'
sudo yum -y -q install  openssl-devel
sudo yum -y -q install  git
git clone https://github.com/wg/wrk.git
cd wrk
make
cd ..

#ruby installation
sudo yum -y -q install ruby

#get benchmark from git
git clone https://github.com/tjosephcarroll/CSPBenchmark


