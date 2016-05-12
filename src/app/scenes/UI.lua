local Hero = require("app.monster.Hero")
local LevelButton = require("app.UIClass.LevelButton")
local topButton = require("app.UIClass.topButton")
local Tabel = require("app.stageConfig.stageLevelInformation")
display.addSpriteFrames("UI/ui_public1.plist","UI/ui_public1.png")
display.addSpriteFrames("UI/ui_prepare.plist","UI/ui_prepare.png")
display.addSpriteFrames("UI/ui_dailytask.plist","UI/ui_dailytask.png")
display.addSpriteFrames("UI/ui_achievement.plist","UI/ui_achievement.png")
display.addSpriteFrames("UI/ui_giftbag.plist","UI/ui_giftbag.png")
display.addSpriteFrames("map/LevelTheme/levelThemeElements.plist","map/LevelTheme/levelThemeElements.png")
local UI = class("UI", function()
    return display.newScene("UI")
end)

function UI:ctor()
	-- bloodNow.state = "false"
	self.tabel = {}
	self:createBackGround()
    self:BottomButton()
    self:RightButton()
 	self:TopButton()
 	
 	-- self:hero()
 	

end
--背景
function UI:createBackGround()
	local node = display.newNode()
	:setPosition(50,0)

	local backGround1 = display.newSprite("map/LevelTheme/themeMap1.png")
	local backGround1Size = backGround1:getContentSize()
	backGround1:setPosition(display.cx, display.cy)
	backGround1:setTag(1)
	node:addChild(backGround1)

	local backGround2 = display.newSprite("map/LevelTheme/themeMap2.png")
	local backGround2Size = backGround2:getContentSize()
	backGround2:setPosition(display.cx + (backGround1Size.width + backGround2Size.width) / 2, display.cy)
	backGround2:setTag(2)
	node:addChild(backGround2)

	local backGround3 = display.newSprite("map/LevelTheme/themeMap3.png")
	local backGround3Size = backGround3:getContentSize()
	backGround3:setPosition(display.cx + backGround1Size.width + (backGround2Size.width + backGround3Size.width) / 2 , display.cy)
	backGround3:setTag(3)
	node:addChild(backGround3)

	local backGround4 = display.newSprite("map/LevelTheme/themeMap4.png")
	local backGround4Size = backGround4:getContentSize()
	backGround4:setPosition(display.cx + backGround1Size.width + backGround2Size.width + (backGround3Size.width + backGround4Size.width) / 2, display.cy)
	backGround4:setTag(4)
	node:addChild(backGround4)

	for i,v in pairs(Tabel["levelButtonPosition"]) do
		self.tabel[i] = LevelButton.new(v[1], v[2], i, node)
		:onButtonClicked(function(event)
			self:gamePrepare(i)
		end)
	end
	cc.ui.UIScrollView.new({
		direction = cc.ui.UIScrollView.DIRECTION_BOTH,
		viewRect = {x = 0, y = 0, width = display.width, height = display.height}
		})
	:addScrollNode(node)
	:setDirection(cc.ui.UIScrollView.DIRECTION_HORIZONTAL)
	:pos(0, 0)
	:addTo(self)
	:setBounceable(false)	
end

-- function UI:hero()
-- 	Hero.new("#h01_move_1.png",200, 200, self)
-- end
--下面的button
function UI:BottomButton()
	local node1 = display.newNode()
	:setContentSize(display.width, display.height)
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
	
	local MenuHero1 = self:createButton("#MenuHero"..GameState.GameData.HeroNumber..".png", 0.55, 0.115,0.01, 0.9,node1)
	MenuHero1:onButtonClicked(function()
		local HeroHouseUI = import("app.scenes.HeroHouseUI"):new()
		display.replaceScene(HeroHouseUI,"flipAngular",0.5)
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

--创建准备界面
function UI:gamePrepare(num)
	local prepareLayer = display.newColorLayer(cc.c4b(100, 100, 100, 100))
	self:addChild(prepareLayer)
	prepareLayer.trun = true
	local topButton = topButton.new(prepareLayer, "self")

	self.topButton:hide()
	local pre_previewBg = self:createSprite("#pre_previewBg.png",0.5, 0.5 ,prepareLayer)
	pre_previewBg:setAnchorPoint(0, 0.5)
	:setScale(0.8, 0.9)
	print(num)
	local pre_previewBgLabel = self:createSprite("map/LevelTheme/levelPreview/L"..num..".png",0.5, 0.46 ,pre_previewBg)
	self:createLabel(pre_previewBg,"第"..num.."关" , 20, 0.5, 0.73,cc.c3b(47, 79, 79))
	self:setweapon(num, pre_previewBgLabel)
	
	prepareLayer.pre_taskBg = self:createSprite("#pre_taskBg.png",0.33, 0.45 ,prepareLayer)
	-- prepareLayer.pre_taskBg:setAnchorPoint(1, 0.5)
	prepareLayer.pre_taskBg:setPositionX(display.cx - prepareLayer.pre_taskBg:getContentSize().width / 2.5)
	prepareLayer.pre_taskBg:setScale(0.8, 0.9)
	prepareLayer.pre_taskLabel = self:createSprite("#pre_taskLabel.png",0.5, 0.9 ,prepareLayer.pre_taskBg)
	
	prepareLayer.littleTaskIcon = self:createSprite("#littleTaskIcon5.png",0.5, 0.1 ,prepareLayer.pre_taskBg)
	:setScale(1.08,0.96)
	prepareLayer.listView = cc.ui.UIListView.new({
		bg = "#pre_itemBarBg.png",
		viewRect = cc.rect(prepareLayer.pre_taskBg:getContentSize().width * 0.06, prepareLayer.pre_taskBg:getContentSize().height * 0.16, prepareLayer.pre_taskBg:getContentSize().width * 0.9, prepareLayer.pre_taskBg:getContentSize().height * 0.68)
		})
		prepareLayer.pre_taskBg:addChild(prepareLayer.listView)

		for i=1,3 do
			local item = prepareLayer.listView:newItem()
			local content = display.newSprite("#pre_taskSingleBg.png")			
			item:addContent(content)
			item:setItemSize(content:getContentSize().width * 1, content:getContentSize().height * 1)
			prepareLayer.listView:addItem(item)	
			self:createLabel(content, Tabel["taskItem"][num][i], 20, 0.35, 0.5,cc.c3b(47, 79, 79))
			local taskPic = self:createSprite(Tabel["taskItempic"][num][i],0.14,0.5 ,content)
			taskPic:setScale(0.9, 0.8)
			self:createSprite("#pre_taskGifted.png",0.83,0.5 ,content)
			self:createLabel(content, "x"..(28 + 4 * num), 18, 0.85,0.38,cc.c3b(255, 255, 255))
				
		end
	prepareLayer.listView:reload()
	prepareLayer.pre_itemLabel = self:createSprite("#pre_itemLabel.png",0.5, 0.9 ,prepareLayer.pre_taskBg)
	prepareLayer.listView2 = cc.ui.UIListView.new({
		viewRect = cc.rect(prepareLayer.pre_taskBg:getContentSize().width * 0.06, prepareLayer.pre_taskBg:getContentSize().height * 0.05, prepareLayer.pre_taskBg:getContentSize().width * 0.9, prepareLayer.pre_taskBg:getContentSize().height * 0.75)
		})
	prepareLayer.pre_itemBarBg = self:createSprite("#pre_itemBarBg.png",0.51, 0.43 ,prepareLayer.pre_taskBg)
	:setScale(1, 1.1)
		prepareLayer.pre_taskBg:addChild(prepareLayer.listView2)

		for i=1,4 do
			local item = prepareLayer.listView2:newItem()
			local content = display.newSprite("#pre_itemSingleBg.png")			
			item:addContent(content)
			item:setItemSize(content:getContentSize().width * 1, content:getContentSize().height * 1)
			prepareLayer.listView2:addItem(item)	
			self:createLabel(content, Tabel["tackleIntroduction"][i], 15, 0.4, 0.38,cc.c3b(47, 79, 79))
			local taskPic = self:createSprite(Tabel["tackle"][i],0.14,0.5 ,content)
			taskPic:setScale(0.9, 0.8)
			self:createButton("#pre_itemPurchase.png",0.83,0.5 ,0.01, 1,content)
			local listCoin = self:createSprite("#coinNew.png",0.29, 0.67, content)
			:setScale(0.43)
			self:createLabel(content, Tabel["tacklePrice"][i], 18, 0.37,0.67,cc.c3b(255, 255, 255))
				
		end
	prepareLayer.listView2:reload()
	prepareLayer.listView2:hide()
	prepareLayer.pre_itemBarBg:hide()
	prepareLayer.pre_itemLabel:hide()

	local pre_startButton = self:createButton("#pre_startButton.png", 0.67, 0.13,0.01, 0.9,prepareLayer)
	:onButtonClicked(function(event)

		if prepareLayer.trun then
			local scale1 = cc.ScaleTo:create(0.5, 0, 0.9, 1)
			local callback = cc.CallFunc:create(function()	
				prepareLayer.listView2:show()
				prepareLayer.pre_itemBarBg:show()
				prepareLayer.pre_itemLabel:show()
				prepareLayer.listView:hide()
				prepareLayer.pre_taskLabel:hide()
				prepareLayer.littleTaskIcon:hide()
				-- self.bloodTabel:hide() 
				-- self.coinTabel:hide() 
				-- self.diamondTabel:hide() 
			end)
			local scale2 = cc.ScaleTo:create(0.5, 0.8, 0.9, 1)
			local action = cc.Sequence:create(scale1, callback, scale2)
			prepareLayer.pre_taskBg:runAction(action)
			prepareLayer.trun = false
		else
			if GameState.GameData.bloodNowState == "true" then
				local FightScene = import(".app.scenes.FightScene").new(num)
				display.replaceScene(FightScene,"flipAngular",0.5)
			elseif GameState.GameData.UItopData.bloodNow >= 1 then
				GameState.GameData.UItopData.bloodNow = GameState.GameData.UItopData.bloodNow - 1
				topButton.bloodLabel:setString(GameState.GameData.UItopData.bloodNow)
				GameState.save(GameState.GameData)
				local FightScene = import(".app.scenes.FightScene").new(num)
				display.replaceScene(FightScene,"flipAngular",0.5)
				
			end
			
		end

	end)
end
function UI:createSprite(pic,posX,posY,parentNode)
	local sprite = display.newSprite(pic)
	:setPosition(parentNode:getContentSize().width * posX, parentNode:getContentSize().height * posY)
	parentNode:addChild(sprite)
	return sprite
end
--放置准备界面里面的武器
function UI:setweapon(a,parentNode)
	if #Tabel["weapon"][a] == 1 then
		local weapon1 = self:createSprite(Tabel["weapon"][a][1],0.5,-0.32 ,parentNode)
		:setScale(0.5)
	elseif #Tabel["weapon"][a] == 2 then	
		local weapon1 = self:createSprite(Tabel["weapon"][a][1],0.4,-0.32 ,parentNode)
		:setScale(0.5)
		local weapon2 = self:createSprite(Tabel["weapon"][a][2],0.6,-0.32 ,parentNode)
		:setScale(0.5)
	elseif #Tabel["weapon"][a] == 3 then	
		local weapon1 = self:createSprite(Tabel["weapon"][a][1],0.3,-0.32 ,parentNode)
		:setScale(0.5)
		local weapon2 = self:createSprite(Tabel["weapon"][a][2],0.5,-0.32 ,parentNode)
		:setScale(0.5)
		local weapon3 = self:createSprite(Tabel["weapon"][a][3],0.7,-0.32 ,parentNode)
		:setScale(0.5)
	else
		local weapon1 = self:createSprite(Tabel["weapon"][a][1],0.2,-0.32 ,parentNode)
		:setScale(0.5)
		local weapon2 = self:createSprite(Tabel["weapon"][a][2],0.4,-0.32 ,parentNode)
		:setScale(0.5)
		local weapon3 = self:createSprite(Tabel["weapon"][a][3],0.6,-0.32 ,parentNode)
		:setScale(0.5)
		local weapon4 = self:createSprite(Tabel["weapon"][a][4],0.8,-0.32 ,parentNode)
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
		:align(display.CENTER, display.cx, display.cy)
		:setPosition(parentNode:getContentSize().width * posX, parentNode:getContentSize().height * posY)
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
	:setPosition(parentNode:getContentSize().width * posX, parentNode:getContentSize().height * posY)
	:scaleTo(time, scale)	
	parentNode:addChild(button)
	button:onButtonPressed(function (event)
		button:setScale(1.1,1.1)
	end)
	button:onButtonRelease(function (event)
		button:setScale(scale, scale)
	end)
	
	return button
end
--上面的button
function UI:TopButton()
	self.topButton = topButton.new(self, "StartScene")
	self.topButton:setTag(1)
end

function UI:RightButton()
	if GameState.GameData.newBagState == "true" then
		local newBag = self:createButton("#newBag.png", 0.93, 0.67,0.01, 0.9,self)
		newBag:onButtonClicked(function(event)
			local layer = display.newColorLayer(cc.c4b(100, 100, 100, 100))
			self:addChild(layer)
			local newBagBG = self:createSprite("#newBagBG.png", 0.5, 0.5, layer)
			local buyButton = self:createButton("#buttonGet.png", 0.5, 0.15,0.01,0.9, newBagBG)
			buyButton:onButtonClicked(function ()
				GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond + 20
				self.topButton.diamondLabel:setString(GameState.GameData.UItopData.diamond)
				GameState.GameData.UItopData.coin = GameState.GameData.UItopData.coin + 100
				self.topButton.coinLabel:setString(GameState.GameData.UItopData.coin)
				GameState.GameData.bloodNowState = "true"
				GameState.GameData.newBagState = "false"
				GameState.save(GameState.GameData)
				newBag:removeFromParent()
				layer:removeFromParent()
			end)
			local returnButton = self:createButton("#dailytaskreturn.png", 0.92, 0.82,0.01, 0.9, newBagBG)
			returnButton:onButtonClicked(function()
				-- newBag:removeFromParent()
				layer:removeFromParent()
			end)
		end)
		self:scaleAction(newBag)
	else
		return
	end

	if GameState.GameData.giftBagState == "true" then
		local giftBag = self:createButton("#giftBag.png", 0.93, 0.48,0.01, 0.9,self)
		giftBag:onButtonClicked(function(event)
			local layer1 = display.newColorLayer(cc.c4b(100, 100, 100, 100))
			self:addChild(layer1)
			local giftBagBG = self:createSprite("#giftBagBG.png", 0.5, 0.5, layer1)
			local buyButton1 = self:createButton("#buttonGet.png", 0.5, 0.15,0.01,0.9, giftBagBG)
			buyButton1:onButtonClicked(function ()
				GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond + 100
				self.topButton.diamondLabel:setString(GameState.GameData.UItopData.diamond)
				GameState.GameData.UItopData.coin = GameState.GameData.UItopData.coin + 100
				self.topButton.coinLabel:setString(GameState.GameData.UItopData.coin)
				self.topButton.bloodLabel:setString("无限体力")
				GameState.GameData.giftBagState = "false"
				GameState.save(GameState.GameData)
				giftBag:removeFromParent()
				layer1:removeFromParent()
			end)
			local returnButton1 = self:createButton("#dailytaskreturn.png", 0.92, 0.82,0.01, 0.9, giftBagBG)
			returnButton1:onButtonClicked(function()
				-- giftBag:removeFromParent()
				layer1:removeFromParent()
			end)
		end)
		self:scaleAction(giftBag)
	else
		return
	end
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
