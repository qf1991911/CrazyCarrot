
require("config")
require("cocos.init")
require("framework.init")
local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
    GameState = require("framework.cc.utils.GameState")
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    self:enterScene("UI")
end

return MyApp
