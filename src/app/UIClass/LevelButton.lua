local LevelButton = class("LevelButton", function(posX, posY, number,parentNode)
    local images = {
	normal = "#levelButton.png",
	pressed = "#levelButton.png"
	}
	local button = cc.ui.UIPushButton.new(images)
	button:setColor(cc.c4b(100, 100, 100, 255))
	local BgSizeWidth = parentNode:getChildByTag(1):getContentSize().width + parentNode:getChildByTag(2):getContentSize().width + parentNode:getChildByTag(3):getContentSize().width + parentNode:getChildByTag(4):getContentSize().width
	local BgSizeHeight = parentNode:getChildByTag(1):getContentSize().height
	button:setPosition(BgSizeWidth * posX, BgSizeHeight * posY)
	button:scaleTo(0.01, 0.8)
	parentNode:addChild(button)
	button:onButtonPressed(function (event)
		button:setScale(0.9,0.9)
	end)
	button:onButtonRelease(function (event)
		button:setScale(0.8, 0.8)
	end)
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