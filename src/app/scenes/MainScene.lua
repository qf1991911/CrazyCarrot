display.addSpriteFrames("Mainscenes/ui_public1.plist","Mainscenes/ui_public1.png")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
   self:createBackGround()
   self:BottomButton()
   self:TopButton()
   self:RightButton()
   
end

function MainScene:createBackGround()
	local node = display.newNode()

	

	local backGround1 = display.newSprite("map/LevelTheme/themeMap1.png")
	local backGround1Size = backGround1:getContentSize()
	backGround1:setPosition(display.cx, display.cy)
	node:addChild(backGround1)

	local backGround2 = display.newSprite("map/LevelTheme/themeMap2.png")
	local backGround2Size = backGround2:getContentSize()
	backGround2:setPosition(display.cx + (backGround1Size.width + backGround2Size.width) / 2, display.cy)
	node:addChild(backGround2)

	local backGround3 = display.newSprite("map/LevelTheme/themeMap3.png")
	local backGround3Size = backGround3:getContentSize()
	backGround3:setPosition(display.cx + backGround1Size.width + (backGround2Size.width + backGround3Size.width) / 2 , display.cy)
	node:addChild(backGround3)

	local backGround4 = display.newSprite("map/LevelTheme/themeMap4.png")
	local backGround4Size = backGround4:getContentSize()
	backGround4:setPosition(display.cx + backGround1Size.width + backGround2Size.width + (backGround3Size.width + backGround4Size.width) / 2, display.cy)
	node:addChild(backGround4)

	local level11 = self:createButton("#levelButton.png", 0.0, 0.36,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	local level12 = self:createButton("#levelButton.png", 0.21, 0.26,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	local level13 = self:createButton("#levelButton2.png", 0.2, 0.46,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	local level14 = self:createButton("#levelButton.png", 0.33, 0.58,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	local level15 = self:createButton("#levelButton.png", 0.5, 0.5,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	local level16 = self:createButton("#levelButton.png", 0.55, 0.25,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	local level17 = self:createButton("#levelButton.png", 0.72, 0.37,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	local level18 = self:createButton("#levelButton.png", 0.9, 0.55,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	local level19 = self:createButton("#levelButton.png", 1.07, 0.46,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	local level110 = self:createButton("#levelButton.png", 1, 0.25,node)
	:scaleTo(0.01, 0.8)
	:onButtonClicked(function(event)
		print("···")
	end)

	-- local level21 = self:createButton("#levelButton.png", 1.5, 0.25,node)
	-- :scaleTo(0.01, 0.8)
	-- :onButtonClicked(function(event)
	-- 	print("···")
	-- end)

	cc.ui.UIScrollView.new({
		direction = cc.ui.UIScrollView.DIRECTION_BOTH,
		viewRect = {x = 0, y = 0, width = 960, height = 640}
		})
	:addScrollNode(node)
	:setDirection(cc.ui.UIScrollView.DIRECTION_HORIZONTAL)
	:pos(0, 0)
	:addTo(self)

	:setBounceable(false)

	
	
	
end
function MainScene:Star()
	

end
function MainScene:BottomButton()
	local node1 = display.newNode()
	self:addChild(node1)

	local MenuDailyTask = self:createButton("#MenuDailyTask.png", 0.25, 0.1,node1)
	:onButtonClicked(function(event)
		print("···")
		end)	
	
	local MenuAchievementButton = self:createButton("#MenuAchievement.png", 0.4, 0.1,node1)
	:onButtonClicked(function(event)
		print("···")
	end)	
	
	local MenuHero1 = self:createButton("#MenuHero1.png", 0.55, 0.115,node1)
	:onButtonClicked(function(event)
		print("···")
	end)	
	
	local MenuHandbook = self:createButton("#MenuHandbook.png", 0.7, 0.1,node1)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local helpButton = self:createButton("#helpButton.png", 0.85, 0.1,self)
	:onButtonClicked(function(event)
		print("···")
	end)
end

function MainScene:createButton(path, posX, posY,parentNode)
	local images = {
	normal = path,
	pressed = path
	}
	local button = cc.ui.UIPushButton.new(images)
	:setPosition(display.width * posX, display.height * posY)
	:scaleTo(0.01, 0.9)	
	parentNode:addChild(button)
	return button
end

function MainScene:TopButton()
	local node2 = display.newNode()
	self:addChild(node2)

	local buttonbg1 = self:createSprite("#buttonBg.png", 0.28, 0.9, node2)
	:setScaleX(2.2)
	:setScaleY(0.9)
	local bloodNow = self:createSprite("#bloodNew.png", 0.22, 0.9, node2)
	local addNew1 = self:createButton("#addNew.png", 0.35, 0.9,node2)
	:onButtonClicked(function(event)
		print("···")
	end)

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.53, 0.9, node2)
	:setScaleX(2.2)
	:setScaleY(0.9)
	local  coinNew = self:createSprite("#coinNew.png", 0.47, 0.9, node2)
	local addNew2 = self:createButton("#addNew.png", 0.6, 0.9,node2)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.78, 0.9, node2)
	:setScaleX(2.2)
	:setScaleY(0.9)
	local diamondNew = self:createSprite("#diamondNew.png", 0.72, 0.9, node2)
	local addNew3 = self:createButton("#addNew.png", 0.85, 0.9,node2)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local returnButton = self:createButton("#returnNew.png", 0.15, 0.9, node2)
	:onButtonClicked(function(event)
		print("···")
	end)	
end

function MainScene:createSprite(pic,posX,posY,parentNode)
	local sprite = display.newSprite(pic)
	:setPosition(display.width * posX, display.height * posY)
	parentNode:addChild(sprite)
	return sprite
end
function MainScene:RightButton()
	local newBag = self:createButton("#newBag.png", 0.93, 0.67,self)
	:onButtonClicked(function(event)
		print("···")
	end)
	self:scaleAction(newBag)

	local giftBag = self:createButton("#giftBag.png", 0.93, 0.48,self)
	:onButtonClicked(function(event)
		print("···")
	end)
	self:scaleAction(giftBag)
end
function MainScene:scaleAction(parentNode)
	
	local action1 = cc.ScaleTo:create(0.2, 1.1, 0.85, 1)
	local action2 = cc.ScaleTo:create(1, 1, 1, 1)
	local actionA = cc.EaseElasticOut:create(action2)
	local seq1 = cc.Sequence:create(action1, actionA)
	local rep = cc.RepeatForever:create(seq1)
	parentNode:runAction(rep)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
