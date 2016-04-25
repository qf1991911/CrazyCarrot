local LevelButton = class("LevelButton", function(posX, posY, number,parentNode)
    local images = {
	normal = "#levelButton.png",
	pressed = "#levelButton.png"
	}
	local button = cc.ui.UIPushButton.new(images)
	:setColor(cc.c4b(100, 100, 100, 255))
	:setPosition(display.width * posX, display.height * posY)
	:scaleTo(0.01, 0.8)
	parentNode:addChild(button)
	local size = button:getContentSize()
	local label = cc.ui.UILabel.new({
		UIlabelType = 2,
		text = number,
		size = 35,
		})
	:align(display.CENTER, size.width / 2, size.height / 2)
	button:addChild(label)
	return button
end)
function LevelButton:ctor()
	self.pass = false
	-- self:LevelButtonLabel("")
end

function LevelButton:onEnter()
	-- body
end
function LevelButton:onExit()
	-- body
end
return LevelButton