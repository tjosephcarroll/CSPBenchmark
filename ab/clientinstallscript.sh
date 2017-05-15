#!/bin/bash
#only for use on RHEL

echo "Client Installation Script - RHEL"

#get ab. I'm sure there's a cleaner way, but my driver vm can have apache.
echo "Installing Apache and ab"
sudo yum -y -q install httpd

#ruby installation
echo "Installing Ruby"
sudo yum -y -q install ruby

#get benchmark from git
echo "Pulling ruby code from git repository"
git clone https://github.com/tjosephcarroll/CSPBenchmark


