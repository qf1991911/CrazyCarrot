local LevelButton = require(".app.UIClass.LevelButton")
local Tatel = require(".app.stageConfig.stageLevelInformation")
display.addSpriteFrames("UI/ui_public1.plist","UI/ui_public1.png")
display.addSpriteFrames("UI/ui_dailytask.plist","UI/ui_dailytask.png")
local UI = class("UI", function()
    return display.newScene("UI")
end)

function UI:ctor()
	self.tabel = {}
	self:createBackGround()
    self:BottomButton()
    self:TopButton()
    self:RightButton()
   
   
end
--背景
function UI:createBackGround()
	local node = display.newNode()
	:setPosition(50,0)

	

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

	for i,v in pairs(Tatel["levelButtonPosition"]) do
		self.tabel[i] = LevelButton.new(v[1], v[2], i, node)
		:onButtonClicked(function(event)
			print("···")
		end)
	end
	

	

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

--下面的button
function UI:BottomButton()
	local node1 = display.newNode()
	self:addChild(node1)

	

	local MenuDailyTask = self:createButton("#MenuDailyTask.png", 0.25, 0.1,0.01, 0.9,node1)
	:onButtonClicked(function(event)
		
		local dailytaskLayer = cc.LayerColor:create(cc.c4b(100, 100, 100, 50))
		:setContentSize(display.width, display.height)
		self:addChild(dailytaskLayer)
		local node3 = display.newNode()
		node3:setContentSize(display.width, display.height)
		dailytaskLayer:addChild(node3)
		node3:setTouchEnabled(true)
		node3:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ()			
		end)

		local dailytask = self:createSprite("#dailytaskBg.png",0.5,0.5, node3)
		local dailytask_bar = self:createSprite("#dailytask_bar1.png",0.52,0.459, node3)
		local dailytaskDiamond = self:createSprite("#dailytaskDiamond.png",0.5,0.385, node3)
		local dailytaskRunning = self:createSprite("#dailyTaskRunning.png",0.5,0.3, node3)
		local dailytaskReturnButton = self:createButton("#dailytaskreturn.png", 0.68, 0.65,0.01, 0.9,node3)
		:onButtonClicked(function(event)
			dailytaskLayer:removeFromParent()
		end)
	end)	
	
	local MenuAchievementButton = self:createButton("#MenuAchievement.png", 0.4, 0.1,0.01, 0.9,node1)
	:onButtonClicked(function(event)
		
	end)	
	
	local MenuHero1 = self:createButton("#MenuHero1.png", 0.55, 0.115,0.01, 0.9,node1)
	:onButtonClicked(function(event)
		print("···")
	end)	
	
	local MenuHandbook = self:createButton("#MenuHandbook.png", 0.7, 0.1,0.01, 0.9,node1)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local helpButton = self:createButton("#helpButton.png", 0.85, 0.1,0.01, 0.9,self)
	:onButtonClicked(function(event)
		print("···")
	end)
end
--创建button的函数
function UI:createButton(path, posX, posY,time, scale, parentNode)
	local images = {
	normal = path,
	pressed = path
	}
	local button = cc.ui.UIPushButton.new(images)
	button:setPosition(display.width * posX, display.height * posY)
	:scaleTo(time, scale)
	:onButtonPressed(function(event)
		button:scaleTo(0.1, 1.1)
		end)
	:onButtonRelease(function(event)
		button:scaleTo(0.1, scale)
		end)	
	parentNode:addChild(button)
	return button
end
--上面的button
function UI:TopButton()
	local node2 = display.newNode()
	self:addChild(node2)

	local buttonbg1 = self:createSprite("#buttonBg.png", 0.28, 0.9, node2)
	:setScaleX(2.2)
	:setScaleY(0.9)
	local bloodNow = self:createSprite("#bloodNew.png", 0.22, 0.9, node2)
	local addNew1 = self:createButton("#addNew.png", 0.35, 0.9, 0.01, 0.9, node2)
	:onButtonClicked(function(event)
		print("···")
	end)

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.53, 0.9, node2)
	:setScaleX(2.2)
	:setScaleY(0.9)
	local  coinNew = self:createSprite("#coinNew.png", 0.47, 0.9, node2)
	local addNew2 = self:createButton("#addNew.png", 0.6, 0.9, 0.01, 0.9, node2)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.78, 0.9,node2)
	:setScaleX(2.2)
	:setScaleY(0.9)
	local diamondNew = self:createSprite("#diamondNew.png", 0.72, 0.9,node2)
	local addNew3 = self:createButton("#addNew.png", 0.85, 0.9, 0.01, 0.9, node2)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local returnButton = self:createButton("#returnNew.png", 0.15, 0.9,0.01, 0.9, node2)
	:onButtonClicked(function(event)
		print("···")
	end)	
end
--创建精灵的函数
function UI:createSprite(pic,posX,posY,parentNode)
	local sprite = display.newSprite(pic)
	:setPosition(display.width * posX, display.height * posY)
	parentNode:addChild(sprite)
	return sprite
end
--右面的button
function UI:RightButton()
	local newBag = self:createButton("#newBag.png", 0.93, 0.67,0.01, 0.9,self)
	:onButtonClicked(function(event)
		print("···")
	end)
	self:scaleAction(newBag)

	local giftBag = self:createButton("#giftBag.png", 0.93, 0.48,0.01, 0.9,self)
	:onButtonClicked(function(event)
		print("···")
	end)
	self:scaleAction(giftBag)
end
--缩放动作
function UI:scaleAction(parentNode)
	
	local action1 = cc.ScaleTo:create(0.2, 1.1, 0.85, 1)
	local action2 = cc.ScaleTo:create(1, 1, 1, 1)
	local actionA = cc.EaseElasticOut:create(action2)
	local seq1 = cc.Sequence:create(action1, actionA)
	local rep = cc.RepeatForever:create(seq1)
	parentNode:runAction(rep)

end

function UI:onEnter()
end

function UI:onExit()
end

return UI
