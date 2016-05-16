local GameState = require("framework.cc.utils.GameState")

GameState.init(function (param)
	local returnValue = nil
	if param.errorCode then
		print("error code : %d ", param.errorCode)
	else
		--crpyto
		if param.name == "save" then
			local str = json.encode(param.values)
			-- str = crypto.encryptXXTEA(str,"abcd")
			returnValue = {data = str}
		elseif param.name == "load" then
			-- local str = crypto.decryptXXTEA(param.values.data,"abcd")
			local str = param.values.data
			returnValue = json.decode(str)
		end
	end
	return returnValue
end,"src/app/GameData/GameData.txt")

local initTable = {
    hero = {
        hp = 100,
        mp = 200
    },
    UItopData = {
        bloodNow = 5,
        coin = 500,
        diamond = 200
    },
    HeroNumber = 1,
    bloodNowState = "false",
    HeroScanNumber = 1,
    newBagState = "true",
    giftBagState = "true",
    LevelStarNum = {
    				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    				0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					},
    sumStarNum = 0,
    LevelPass = {	true,	false,	false,	false,	false,
    				false,	false,	false,	false,	false,
    				false,	false,	false,	false,	false,
    				false,	false,	false,	false,	false,
    				false,	false,	false,	false,	false,
    				false,	false,	false,	false,	false,
    				false,	false,	false,	false,	false,
    				false,	false,	false,	false,	false,
				}
}

GameState.GameData = GameState.load() or initTable

return GameState