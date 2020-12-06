-- The variable below is the ID of the script you've created, you won't need
-- to enter any information other than this.

local Link = "https://Database.scriptitwithcod.repl.co"


local Coro = require("coro-http")
local Json = require("json")
local Wait = require("./Wait.lua")
local Query = require("querystring")

local Module = {}

local Token = require("../Tokens").Save or os.getenv("SAVETOKEN")

local Cache = _G.SaveCache

if not Cache then
	Cache = {}
	_G.SaveCache = Cache
end


function DoGet(Store, Key)
	local URL = Link .. "/" .. Token .. "/get/" .. Store .. "/" .. Key 


	local Res, Body = Coro.request("GET", URL)
	Data = Json.parse(Body)

	if Data.status == "ok" then
		if Data.data then
			return Data.data
		else
			return nil
		end
	else
		print("Database error:", Data.error)	
		return
	end

end

function DoPost(Store, Key, data)
	local URL

	if type(data) == "table" then
		URL = Link .. "/" .. Token .. "/save/" .. Store .. "/" .. Key 
	else
		URL = Link .. "/" .. Token .. "/save/" .. Store .. "/" .. Key 
	end

	local StringData = Query.urlencode(Json.encode(data))

	Res, Body = Coro.request("POST", URL, {{"Content-Type", "application/json"}}, StringData)
	Data = Json.parse(Body)

	if Data.status == "ok" then
		return true
	else
		print("Database error:", Data.error)	
		return false
	end
end

function DoGetStore(Store, Key)
	local URL = Link .. "/" .. Token .. "/getstore/" .. Store

	local Res, Body = Coro.request("GET", URL)
	Data = Json.parse(Body)

	if Data.status == "ok" then
		if Data.data then
			return Data.data
		else
			return nil
		end
	else
		print("Database error:", Data.error)	
		return
	end

end

function Module:GetDatabase(sheet)
	local database = {}

	if not Cache[string.lower(sheet)] then
		Cache[string.lower(sheet)] = {}
	end

	function database:PostAsync(key, value)
		return DoPost(string.lower(sheet), key, value)
	end

	function database:GetStoreAsync(key)
		return DoGetStore(string.lower(sheet))
	end

	function database:GetAsync(key)
		return DoGet(string.lower(sheet), key)
	end
	return database
end

return Module


