local LevelButton = require(".app.UIClass.LevelButton")
local topButton = require(".app.UIClass.topButton")
local Tabel = require(".app.stageConfig.stageLevelInformation")
display.addSpriteFrames("UI/ui_public1.plist","UI/ui_public1.png")
display.addSpriteFrames("UI/ui_prepare.plist","UI/ui_prepare.png")
display.addSpriteFrames("UI/ui_dailytask.plist","UI/ui_dailytask.png")
display.addSpriteFrames("UI/ui_achievement.plist","UI/ui_achievement.png")
display.addSpriteFrames("map/LevelTheme/levelThemeElements.plist","map/LevelTheme/levelThemeElements.png")
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

	for i,v in pairs(Tabel["levelButtonPosition"]) do
		self.tabel[i] = LevelButton.new(v[1], v[2], i, node)
		:onButtonClicked(function(event)
			self:gamePrepare(i)
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
		local scale9sp = ccui.Scale9Sprite 
		local progressbar = scale9sp:createWithSpriteFrameName("achieve_bar2.png", cc.rect(0, 0, 337,24));
		progressbar:setPreferredSize(cc.size(100, 24)) -- xiugai 300
		progressbar:setAnchorPoint(cc.p(0, 0.5))
		progressbar:setPosition(cc.p(display.cx - 89,display.cy - 26))
		node3:addChild(progressbar)
		local dailytaskReturnButton = self:createButton("#dailytaskreturn.png", 0.68, 0.65,0.01, 0.9,node3)
		:onButtonClicked(function(event)
			dailytaskLayer:removeFromParent()
		end)
	end)	
	
	local MenuAchievementButton = self:createButton("#MenuAchievement.png", 0.4, 0.1,0.01, 0.9,node1)
	MenuAchievementButton:onButtonClicked(function()
		local achievementScene = import("app.scenes.achievementScenes"):new()
		display.replaceScene(achievementScene,"flipAngular",0.5)	
	end)	
	
	local MenuHero1 = self:createButton("#MenuHero1.png", 0.55, 0.115,0.01, 0.9,node1)
	:onButtonClicked(function(event)
		
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

function UI:gamePrepare(num)
	local prepareLayer = display.newColorLayer(cc.c4b(100, 100, 100, 100)) 
	self:addChild(prepareLayer)
	topButton.new(prepareLayer, "self")
	self.topButton:hide()
	local pre_previewBg = self:createSprite("#pre_previewBg.png",0.67, 0.5 ,prepareLayer)
	:setScale(0.8, 0.9)
	print(num)
	local pre_previewBg = self:createSprite("map/LevelTheme/levelPreview/L"..num..".png",0.67, 0.5 ,prepareLayer)
	self:createLabel(pre_previewBg,"第"..num.."关" , 20, 0.135, 0.28,cc.c3b(47, 79, 79))
	self:setweapon(num, pre_previewBg)
	
	local pre_startButton = self:createButton("#pre_startButton.png", 0.67, 0.13,0.01, 0.9,prepareLayer)
	:onButtonClicked(function(event)
		print("···")
	end)

	local pre_taskBg = self:createSprite("#pre_taskBg.png",0.3, 0.45 ,prepareLayer)
	:setScale(0.8, 0.9)
	local pre_taskLabel = self:createSprite("#pre_taskLabel.png",0.22, 0.78 ,pre_taskBg)
	
	local littleTaskIcon = self:createSprite("#littleTaskIcon5.png",0.3, 0.13 ,prepareLayer)
	local pre_itemBarBg = self:createSprite("#pre_itemBarBg.png",0.3, 0.445 ,prepareLayer)
	:setScale(0.8, 0.9)
	local listView = cc.ui.UIListView.new({

		viewRect = cc.rect(display.width * 0.025, display.height * 0.025, display.width * 0.35, display.height * 0.55)
		})
		pre_itemBarBg:addChild(listView)

		for i=1,3 do
			local item = listView:newItem()
			local content = display.newSprite("#pre_taskSingleBg.png")
			:setScale(0.9, 0.9)
			item:addContent(content)
			item:setItemSize(content:getContentSize().width * 0.86, content:getContentSize().height * 0.9)
			listView:addItem(item)	
			self:createLabel(content, Tabel["taskItem"][num][i], 20, 0.1, 0.1,cc.c3b(47, 79, 79))
			local taskPic = self:createSprite(Tabel["taskItempic"][num][i],0.06,0.11 ,content)
			:setScale(0.9, 0.8)
			self:createSprite("#pre_taskGifted.png",0.32,0.11 ,content)
			self:createLabel(content, "x"..(28 + 4 * num), 18, 0.315, 0.085,cc.c3b(255, 255, 255))
				
		end
	listView:reload()
end

function UI:setweapon(a,parentNode)
	if #Tabel["weapon"][a] == 1 then
		local weapon1 = self:createSprite(Tabel["weapon"][a][1],0.17,-0.085 ,parentNode)
		:setScale(0.5)
	elseif #Tabel["weapon"][a] == 2 then	
		local weapon1 = self:createSprite(Tabel["weapon"][a][1],0.145,-0.085 ,parentNode)
		:setScale(0.5)
		local weapon2 = self:createSprite(Tabel["weapon"][a][2],0.195,-0.085 ,parentNode)
		:setScale(0.5)
	elseif #Tabel["weapon"][a] == 3 then	
		local weapon1 = self:createSprite(Tabel["weapon"][a][1],0.12,-0.085 ,parentNode)
		:setScale(0.5)
		local weapon2 = self:createSprite(Tabel["weapon"][a][2],0.17,-0.085 ,parentNode)
		:setScale(0.5)
		local weapon3 = self:createSprite(Tabel["weapon"][a][3],0.22,-0.085 ,parentNode)
		:setScale(0.5)
	elseif #Tabel["weapon"][a] == 4 then
		local weapon1 = self:createSprite(Tabel["weapon"][a][1],0.095,-0.085 ,parentNode)
		:setScale(0.5)
		local weapon2 = self:createSprite(Tabel["weapon"][a][2],0.145,-0.085 ,parentNode)
		:setScale(0.5)
		local weapon3 = self:createSprite(Tabel["weapon"][a][3],0.195,-0.085 ,parentNode)
		:setScale(0.5)
		local weapon4 = self:createSprite(Tabel["weapon"][a][4],0.245,-0.085 ,parentNode)
		:setScale(0.5)
	end
end

function UI:createLabel(parentNode, text, size, posX, posY,color)

	local label = cc.ui.UILabel.new({
			UILabelType = 2,
			text = text,
			size = size,
			color = color
			})
		:setPosition(display.width * posX, display.height * posY)
		parentNode:addChild(label)
	return label
end
--创建button的函数
function UI:createButton(path, posX, posY,time, scale, parentNode)
	local images = {
	normal = path,
	pressed = path
	}
	local button = cc.ui.UIPushButton.new(images)
	:setPosition(display.width * posX, display.height * posY)
	:scaleTo(time, scale)	
	parentNode:addChild(button)
	return button
end
--上面的button
function UI:TopButton()
	self.topButton = topButton.new(self, "StartScene")
	self.topButton:setTag(1)
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
