# HOW TO CALL
# # ruby CSPApacheDefaultTest.rb 0 1 2 3 4 5 6 7 8 9 10
	#0 ip
	#1 page
	#2 wrkthreads 
	#3 wrkconnections 
	#4 wrkduration
	#5 templateFile 
	#6 maxSessionConnectionStart 
	#7 maxSessionConnectionStop 
	#8 maxServerConnectionStart 
	#9 maxServerConnectionStop
	#10 csvfile
# #

ip = ARGV[0]
page = ARGV[1]
wrkthreads = ARGV[2] 
wrkconnections = ARGV[3]
wrkduration = ARGV[4]
templateFile = ARGV[5] 
maxSessionConnectionStart = ARGV[6] 
maxSessionConnectionStop = ARGV[7] 
maxServerConnectionStart = ARGV[8] 
maxServerConnectionStop = ARGV[9]
csvfile = ARGV[10]

require "./CSPini"
require "./harness"

csvheader = ["Threads", "Connections", "Duration", "Page", "Total Requests", "Total Time", "Data Read", "Requests/Sec", "Transfer/Sec", "Thread Latency Avg","Thread Latency StDev", "Thread Latency Max", "Thread Latency +/- StDev", "Thread Req/Sec Avg","Thread Req/Sec StDev", "Thread Req/Sec Max", "Thread Req/Sec +/- StDev","Latency 50%","Latency 75%","Latency 90%","Latency 99%", "Connect Errors", "Read Errors", "Write Errors", "Timeout Errors"]

#harness requires the CSV gem and does most of the writing. But we have to add the column heads
CSV.open(csvfile, "wb") do |csv|
   csv << csvheader   
end

#load template configuration file into a Object
tCSP = CSP.new(templateFile)

#while still tests to run
#initialize
maxServerConnection = maxServerConnectionStart.to_i
while maxServerConnection <= maxServerConnectionStop.to_i
	#initialize
	maxSessionConnection = maxSessionConnectionStart.to_i
	while maxSessionConnection = maxSessionConnectionStop.to_i
		#set the values of the parameters
		#start with server connections
		tSYSTEMHash = tCSP.instance_variable_get(:@system_config)
		tSYSTEMHash["MAX_CONNECTIONS"] = maxServerConnection
		tCSP.instance_variable_set(:@system_config,tSYSTEMHash)
		#now session settings
		tCACHEHash = tCSP.instance_variable_get(:@cache_server)
		tCACHEHash["Maximum_Session_Connections"] = maxSessionConnection
		tCSP.instance_variable_set(:@cache_server,tCACHEHash)
		#save .ini
		tCSP.save(templateFile)
		#upload .ini
		upload(ip,username,templateFile,"/opt/cspgateway/bin/CSP.ini","fountain")
		#restart apache
		restartApache(ip,username,"fountain")
		#run test and log
		runAndLog(wrkthreads,wrkconnections,wrkduration,ip,page,csvfile)
		#iterate
		maxSessionConnection = maxSessionConnection + 1
	end
	#iterate
	maxServerConnection = maxServerConnection + 1
end
