
require("config")
require("cocos.init")
require("framework.init")
local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
    
    GameState = require("app.GameData.GameData")
    GameState.save(GameState.GameData)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    self:enterScene("UI")
end

return MyApp
