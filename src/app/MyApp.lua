
require("config")
require("cocos.init")
require("framework.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)

    -- GameState = require("framework.cc.utils.GameState")

    -- GameState.init(function(param)
    -- 	local returnValue = nil
    -- 	if param.errorCode then
    -- 		print("error code: %d",param.errorCode)
    -- 	else
    -- 		if param.name =="save" then
    -- 			local str = json.encode(param.values)
    -- 			str = crypto.encryptXXTEA(str, "abcd")
    -- 			returnValue = {data = str}
    -- 		elseif param.name == "load" then
    -- 			local str = crypto.decryptXXTEA(param.values.data, "abcd")
    -- 			returnValue = json.decode(str)
    -- 		end
    -- 	end
    -- 	return returnValue
    -- end,"data.txt", "1234")
    -- GameData = GameState.load() or {}
    -- GameData.hello = "world"
    -- GameState.save(GameData)

end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    self:enterScene("UI")
end

return MyApp
