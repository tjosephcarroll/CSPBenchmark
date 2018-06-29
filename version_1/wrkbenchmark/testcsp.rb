require "./CSPini"
require "./harness"

tCSP = CSP.new("CSP.ini")
tSYSTEMHash = tCSP.instance_variable_get(:@system_config)
tSYSTEMHash["MAX_CONNECTIONS"] = 5
tCSP.instance_variable_set(:@system_config,tSYSTEMHash)
tCACHEHash = tCSP.instance_variable_get(:@cache_server)
tCACHEHash["Maximum_Session_Connections"] = 5
tCSP.instance_variable_set(:@cache_server,tCACHEHash)
tCSP.save("CSP2.ini")