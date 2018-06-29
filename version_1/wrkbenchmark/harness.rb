#functions that are the test harness

require 'net/ssh'
require 'net/scp'
require 'csv'

#opens an ssh connection and restarts apache
def restartApache (ip,username,password)
	Net::SSH.start(ip, username, :password => password) do |ssh|
	# capture all stderr and stdout output from a remote process
	output = ssh.exec!("service httpd restart")
	#puts output
	end
end

#upload a CSP.ini
def upload (ip,username,localpath,remotepath,password)
	Net::SCP.upload!(ip, username,localpath, remotepath,:ssh => { :password => password })
end

def runAndLog(threads,connections,duration,ipaddress,page,csvfile)
# # This is what the output of our wrk command looks like
# #
# # Running 30s test @ http://192.168.2.101/csp/sys/UtilHome.csp
# # 12 threads and 400 connections
# #  Thread Stats   Avg      Stdev     Max   +/- Stdev
# #    Latency   374.33ms  552.64ms   1.99s    79.20%
# #    Req/Sec    24.94     10.06    60.00     70.95%
# #  611 requests in 30.07s, 58.68MB read
# #  Socket errors: connect 0, read 0, write 0, timeout 135
# # Requests/sec:     20.32
# # Transfer/sec:      1.95MB
	#wrk
	results = `wrk -t#{threads} -c#{connections} -d#{duration}s http://#{ipaddress}#{page}`
	puts results
	results = results.gsub(/\s+/,",")
	results = results.split(",")

	threads = threads
	connections = connections 
	duration = duration 
	page = page 
	if (results[35]=="errors:")
		totalRequests = results[27]
		totalTime = results[30]
		dataRead = results[32]
		requestsSec = results[48]
		transferSec = results[50]
		threadLatencyAvg = results[18]
		threadLatencyStDev = results[19]
		threadLatencyMax = results[20]
		threadLatencyStDev = results[21]
		threadReqSecAvg = results[23]
		threadReqSecStDev = results[24]
		threadReqSecMax = results[25]
		threadReqSecStDev = results[26]
		connectErrors = results[37] 
		readErrors = results[40] 
		writeErrors = results[43] 
		timeoutErrors = results[46]
	else
		totalRequests = results[27]
		totalTime = results[30]
		dataRead = results[32]
		requestsSec = results[35]
		transferSec = results[37]
		threadLatencyAvg = results[18]
		threadLatencyStDev = results[19]
		threadLatencyMax = results[20]
		threadLatencyStDev = results[21]
		threadReqSecAvg = results[23]
		threadReqSecStDev = results[24]
		threadReqSecMax = results[25]
		threadReqSecStDev = results[26]
		connectErrors = "" 
		readErrors = "" 
		writeErrors = "" 
		timeoutErrors = ""
	end



	csventry = [threads,connections,duration,page,totalRequests,totalTime,dataRead,requestsSec,transferSec,threadLatencyAvg,threadLatencyStDev,threadLatencyMax,threadLatencyStDev,threadReqSecAvg,threadReqSecStDev,threadReqSecMax,threadReqSecStDev,connectErrors,readErrors,writeErrors,timeoutErrors]


	CSV.open(csvfile, "a+") do |csv|
		csv << csventry
	end
end