#!/bin/bash
echo "Client Installation Script - RHEL"

#wrk installation
sudo  yum groupinstall 'Development Tools'
sudo yum install  openssl-devel
sudo yum install  git
git clone https://github.com/wg/wrk.git
cd wrk
make
cd ..

#ruby installation
sudo yum install ruby

#get benchmark from git
git clone https://github.com/tjosephcarroll/CSPBenchmark


