#for moving files from one machine to another on VMonkey Machines
# gem install net-scp 
  require 'net/ssh'
  require 'net/scp'

#uploads a file
#Net::SCP.upload!(ip, username,localpath, remotepath,:ssh => { :password => password })
ip = "172.16.208.48"
username = "root"
password = "fountain"

#opens an ssh connection and restarts apache
def restartApache (ip,username,password)
	Net::SSH.start(ip, username, :password => password) do |ssh|
	  # capture all stderr and stdout output from a remote process
	  output = ssh.exec!("service httpd restart")
	  puts output
	end
end

def upload (ip,username,localpath,remotepath,password)
	Net::SCP.upload!(ip, username,localpath, remotepath,:ssh => { :password => password })
end

upload(ip,username,"CSP1.ini","/opt/cspgateway/bin/CSP.ini",password)