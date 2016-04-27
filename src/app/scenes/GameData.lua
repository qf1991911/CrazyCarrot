
local GameData = class("GameData", function ( )
	local gameDate = {}
	GameState.init(function (param)
		local returnValue = nil
		if param.errorCode then
			printf("error code:%d", param.errorCode)
		else
			if param.name == "save" then
				local str = json.encode(param.value)
				str = crypto.encryptXXTEA(str, "abcd")
				returnValue = {data = str}
			elseif param.name == "load" then
				local str = crypto.decryptXXTEA(param.values.data, "abcd")
				returnValue = json.decode(str)
				-- returnValue = param.values.data
			end
		end
		return returnValue
	end,"data.txt","1234")
	gameDate = GameState.load() or {}
	gameDate.hello = "world"
	GameState.save(gameDate)
	return gameDate
end)

function GameData:ctor()
	-- body
end
return GameData
