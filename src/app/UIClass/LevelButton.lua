local LevelButton = class("LevelButton", function(posX, posY, number,parentNode)
    local images = {
	normal = "#levelButton.png",
	pressed = "#levelButton.png",
	disabled = "#levelButton.png"
	}
	local button = cc.ui.UIPushButton.new(images)
	button:setColor(cc.c4b(100, 100, 100, 255))
	local BgSizeWidth = parentNode:getChildByTag(1):getContentSize().width + parentNode:getChildByTag(2):getContentSize().width + parentNode:getChildByTag(3):getContentSize().width + parentNode:getChildByTag(4):getContentSize().width
	local BgSizeHeight = parentNode:getChildByTag(1):getContentSize().height

	local num = math.floor((number - 1) / 10) + 1
	local x = posX + 0.05 - (num - 1) * 0.242
	local y = posY + math.floor((num + 2) / 4) * 0.075

	button:setPosition(BgSizeWidth * x, BgSizeHeight * y)
	button:setScale(0.8)
	
	parentNode:getChildByTag(num):addChild(button)
	-- parentNode:addChild(button)
	button:onButtonPressed(function (event)
		button:setScale(0.9)
	end)
	button:onButtonRelease(function (event)
		button:setScale(0.8)
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
function LevelButton:ctor(posX, posY, number,parentNode)
	self.size = display.newSprite("#levelButton.png"):getContentSize()
	self:addStar(number)
end

function LevelButton:addStar(number)	
	if GameState.GameData.LevelStarNum[number] == 1 then
		local levelButtonStar1 = display.newSprite("#levelButtonStar1.png")
		levelButtonStar1:setPosition(0, self.size.height * 0.3)
		self:addChild(levelButtonStar1)
	elseif GameState.GameData.LevelStarNum[number] == 2 then 
		local levelButtonStar2 = display.newSprite("#levelButtonStar2.png")
		levelButtonStar2:setPosition(0, self.size.height * 0.3)
		self:addChild(levelButtonStar2)
	elseif GameState.GameData.LevelStarNum[number] == 3 then
		local levelButtonStar3 = display.newSprite("#levelButtonStar3.png")
		levelButtonStar3:setPosition(0, self.size.height * 0.3)
		self:addChild(levelButtonStar3)
	end
end

function LevelButton:onEnter()
	-- body
end

function LevelButton:onExit()
	-- body
end

return LevelButton