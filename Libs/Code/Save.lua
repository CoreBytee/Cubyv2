-- The variable below is the ID of the script you've created, you won't need
-- to enter any information other than this.

local Link = "https://Database.scriptitwithcod.repl.co"


local Coro = require("coro-http")
local Json = require("json")
local Wait = require("./Wait.lua")
local Query = require("querystring")

local Module = {}




function DoGet(Store, Key)
	local URL = Link .. "/nL7shgcKnNXaqB8w2WZ5swpFeeUtGm2acMYqbhAy8Sv3fSY9nSAGjANgqeFNtsS9/get/" .. Store .. "/" .. Key 

	

	local Res, Body = Coro.request("GET", URL)
	Data = Json.parse(Body)
		
	--print(Res, Body)
	if Data.status == "ok" then
		if Data.data then
			return Json.decode(Data.data)
		else
			return nil
		end
	else
		print("Database error:", Data.error)	
		return
	end




	--return Data
end

function DoPost(Store, Key, data)

	local URL
	--print(type(data))
	if type(data) == "table" then
		URL = Link .. "/nL7shgcKnNXaqB8w2WZ5swpFeeUtGm2acMYqbhAy8Sv3fSY9nSAGjANgqeFNtsS9/save/" .. Store .. "/" .. Key .. "/" .. Json.encode(data)
	else
		URL = Link .. "/nL7shgcKnNXaqB8w2WZ5swpFeeUtGm2acMYqbhAy8Sv3fSY9nSAGjANgqeFNtsS9/save/" .. Store .. "/" .. Key .. "/" .. data
	end
	--print(URL)
	

	local Res, Body = Coro.request("GET", URL)
	Data = Json.parse(Body)
		
	--print(Res, Body)
	if Data.status == "ok" then
		return Json.decode(Data.data)
	else
		print("Database error:", Data.error)	
		return
	end
end

function Module:GetDatabase(sheet)
	local database = {}
	function database:PostAsync(key, value)
		return DoPost(string.lower(sheet), key, value)
	end
	function database:GetAsync(key)
		return DoGet(string.lower(sheet), key)
	end
	return database
end

return Module


