# CSP.ini Driver


class CSP
# Loads in a CSP.ini file
# If no initial file path given it can create a new one

#Hashes of setting key value pairs
	@original_filepath = nil
	@system_index = {}
	@app_path_index = {}
	@app_path_ = {}
	@app_path_csp = {}
	@app_path_csp_user = {}
	@system_config = {}
	@local_server = {}
	@cache_server = {}

	#takes a bracket tag from the CSP.ini and returns a hash describing it
	def buildHash(value,cspArray)
		myIndex = cspArray.index(value)
		tHash = {}
		tHash[value] = ""
		myIndex = myIndex+1
		key = cspArray[myIndex]
		while ((key != "")&&(key != nil))
			keyArray = key.split("=")
			tHash[keyArray[0]] = keyArray[1]
			myIndex = myIndex+1
			key = cspArray[myIndex]
		end
		tHash
	end


	def save(filepath = nil)
		#handle cases where filepath == nil
		if ((filepath == nil)&&(@original_filepath == nil))
			filepath = "CSP.ini"
			@original_filepath = "CSP.ini"
		elsif ((filepath == nil)&&(@original_filepath != nil))
			filepath = @original_filepath
		end
		
		#build hash of hashes
		tHash ={:system_index => @system_index, :app_path_index => @app_path_index, :app_path_ => @app_path_, :app_path_csp => @app_path_csp, :app_path_csp_user => @app_path_csp_user, :system_config => @system_config, :local_server => @local_server, :cache_server => @cache_server}
		cspFile = File.open(filepath,"w+")
		tHash.each do |key, value|
			value.each do |subkey, subvalue|
				if (subvalue=="")
					cspFile.write(subkey + "\n")
				else
					cspFile.write(subkey+"="+subvalue+"\n")
				end
			end
			cspFile.write("\n")
		end
		cspFile.close()
	end



	def initialize(filepath = nil)
		#if a filepath was passed in open it and set variables accordingly
		if ((filepath!="") && (filepath!=nil))
			@original_filepath = filepath
			cspFile = File.read(filepath)
			
			cspArray = cspFile.split(/\n/)
			#set instance variables to the hashes
			@system_index = buildHash("[SYSTEM_INDEX]",cspArray)
			@app_path_index = buildHash("[APP_PATH_INDEX]",cspArray)
			@app_path_ = buildHash("[APP_PATH:/]",cspArray)
			@app_path_csp = buildHash("[APP_PATH:/csp]",cspArray)
			@app_path_csp_user = buildHash("[APP_PATH:/csp/user]",cspArray)
			@system_config = buildHash("[SYSTEM]",cspArray)
			@local_server = buildHash("[LOCAL]",cspArray)
			@cache_server = buildHash("[CACHE]",cspArray)
		end
		#If there's no file path don't do anything
	end

end


myclass = CSP.new("CSP.ini")
myclass.save("CSP1.ini")



