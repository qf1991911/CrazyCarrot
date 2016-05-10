display.addSpriteFrames("UI/ui_public1.plist","UI/ui_public1.png")
display.addSpriteFrames("UI/ui_shop.plist","UI/ui_shop.png")
local topButton = class("topButton", function(parentNode, sceneName)
    local node2 = display.newNode()
    node2.tScene = sceneName
    node2.parentNode = parentNode
	parentNode:addChild(node2)
	return 	node2
end)
function topButton:ctor()
	local buttonbg1 = self:createSprite("#buttonBg.png", 0.28, 0.9)
	:setScaleX(2.2)
	:setScaleY(0.9)
	self.bloodTable = self:createLabel(buttonbg1, GameState.GameData.UItopData.bloodNow, 25, 0.54, 0.5,cc.c3b(255, 255, 255))
	:setScaleX(0.45)
	:setScaleY(1.1)	
	local bloodNow = self:createSprite("#bloodNew.png", 0.22, 0.9)
	local addNew1 = self:createButton("#addNew.png", 0.35, 0.9, 0.01, 0.9)
	:onButtonClicked(function(event)
		-- local shop_bg = self:createSprite("#shop_bg.png", 0.5, 0.5)
		self:CreateBuyScene()
		-------6666666666666-------- 
		--666666666666666666666666--
	end)

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.53, 0.9)
	:setScaleX(2.2)
	:setScaleY(0.9)
	self.coinTabel = self:createLabel(buttonbg2, GameState.GameData.UItopData.coin, 25, 0.54, 0.5,cc.c3b(255, 204, 0))
	:setScaleX(0.45)
	:setScaleY(1.1)	
	local  coinNew = self:createSprite("#coinNew.png", 0.47, 0.9)
	local addNew2 = self:createButton("#addNew.png", 0.6, 0.9, 0.01, 0.9)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.78, 0.9)
	:setScaleX(2.2)
	:setScaleY(0.9)
	self.diamondTabel = self:createLabel(buttonbg2, GameState.GameData.UItopData.diamond, 25, 0.54, 0.5,cc.c3b(255, 204, 0))
	:setScaleX(0.45)
	:setScaleY(1.1)	
	local diamondNew = self:createSprite("#diamondNew.png", 0.72, 0.9)
	local addNew3 = self:createButton("#addNew.png", 0.85, 0.9, 0.01, 0.9)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local returnButton = self:createButton("#returnNew.png", 0.15, 0.9,0.01, 0.9)
	:onButtonClicked(function(event)
		if self.tScene == "self" and self:getParent().trun then
			local parentNode = self:getParent()
			parentNode:getParent():getChildByTag(1):show()
			parentNode:removeFromParent()
			parentNode = nil
		elseif self.tScene == "self" and not self:getParent().trun then
			local parentNode = self:getParent()
			local scale1 = cc.ScaleTo:create(0.5, 0, 0.9, 1)
			local callback = cc.CallFunc:create(function()	
				parentNode.listView2:hide()
				parentNode.pre_itemBarBg:hide()
				parentNode.pre_itemLabel:hide()
				parentNode.listView:show()
				parentNode.pre_taskLabel:show()
				parentNode.littleTaskIcon:show()
				self:getParent().trun = not self:getParent().trun
			end)
			local scale2 = cc.ScaleTo:create(0.5, 0.8, 0.9, 1)
			local action = cc.Sequence:create(scale1, callback, scale2)
			parentNode.pre_taskBg:runAction(action)			
		else
			display.replaceScene(require("app.scenes." .. self.tScene):new())
		end	
	end)
end
function topButton:CreateBuyScene()
	-- local shop_bg = self:createSprite("#shop_bg.png", 0.5, 0.5)
	local dailytaskLayer = cc.LayerColor:create(cc.c4b(100, 100, 100, 50))
	:setContentSize(display.width, display.height)
	self:addChild(dailytaskLayer)
	local node = display.newNode()
	node:setContentSize(display.width, display.height )
	:setScale(0.8,0.9)
	dailytaskLayer:addChild(node)
	node:setTouchEnabled(true)
	node:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ()			
	end)

	local shop_bg = self:createShopSprite("#shop_bg.png",0.5,0.45, node)
	local shopBg1 = self:createShopSprite("#shopBg.png",0.19,0.5, shop_bg)
	local shopBg2 = self:createShopSprite("#shopBg.png",0.4,0.5, shop_bg)
	local shopBg3 = self:createShopSprite("#shopBg.png",0.61,0.5, shop_bg)
	local shopBg4 = self:createShopSprite("#shopBg.png",0.82,0.5, shop_bg)
	local shopTitleBg = self:createShopSprite("#shopTitleBg.png",0.5,0.8, node)
	local shopEnergyTitle = self:createShopSprite("#shopEnergyTitle.png",0.5,0.72, shopTitleBg)
	local shop_energy1 = self:createShopSprite("#shop_energy.png",0.35,0.8, shopBg1)
	local energyNum1 = self:createShopSprite("#energyNum1.png",0.6,0.8, shopBg1)
	local shop_energy_pic1 = self:createShopSprite("#shop_energy1.png",0.5,0.55, shopBg1)
	local price1 = self:createShopSprite("#energyNeedMoney1.png",0.5,0.25, shopBg1)
	local buyButton1 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,0.01,0.9,shopBg1)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 10
		GameState.GameData.UItopData.bloodNow = GameState.GameData.UItopData.bloodNow + 1
		self.bloodTable:setString(GameState.GameData.UItopData.bloodNow)
		self.diamondTabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)
	local shop_energy2 = self:createShopSprite("#shop_energy.png",0.35,0.8, shopBg2)
	local energyNum2 = self:createShopSprite("#energyNum2.png",0.6,0.8, shopBg2)
	local shop_energy_pic2 = self:createShopSprite("#shop_energy2.png",0.5,0.55, shopBg2)
	local price2 = self:createShopSprite("#energyNeedMoney2.png",0.5,0.25, shopBg2)
	local buyButton2 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,0.01,0.9,shopBg2)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 40
		GameState.GameData.UItopData.bloodNow = GameState.GameData.UItopData.bloodNow + 5
		self.bloodTable:setString(GameState.GameData.UItopData.bloodNow)
		self.diamondTabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)
	local shop_energy3 = self:createShopSprite("#shop_energy.png",0.35,0.8, shopBg3)
	local energyNum2 = self:createShopSprite("#energyNum3.png",0.6,0.8, shopBg3)
	local shop_energy_pic3 = self:createShopSprite("#shop_energy3.png",0.5,0.55, shopBg3)
	local price3 = self:createShopSprite("#energyNeedMoney3.png",0.5,0.25, shopBg3)
	local buyButton3 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,0.01,0.9,shopBg3)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 60
		GameState.GameData.UItopData.bloodNow = GameState.GameData.UItopData.bloodNow + 10
		self.bloodTable:setString(GameState.GameData.UItopData.bloodNow)
		self.diamondTabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)
	local shop_energy4 = self:createShopSprite("#energyNum4.png",0.5,0.8, shopBg4)
	local shop_energy_pic4 = self:createShopSprite("#shop_energy4.png",0.5,0.55, shopBg4)
	local price4 = self:createShopSprite("#energyNeedMoney4.png",0.5,0.25, shopBg4)
	local buyButton4 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,0.01,0.9,shopBg4)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 560
------**************需要修改
		-- GameState.GameData.UItopData.bloodNow = GameState.GameData.UItopData.bloodNow.state
		self.bloodTable:setString(GameState.GameData.UItopData.bloodNow)
		self.diamondTabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)
end
function topButton:createButton(path, posX, posY,time, scale)
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
	self:addChild(button)
	return button
end

function topButton:createBuyButton(path, posX, posY,time, scale, parentNode)
	local images = {
	normal = path,
	pressed = path
	}
	local button = cc.ui.UIPushButton.new(images)
	button:setPosition(parentNode:getContentSize().width * posX, parentNode:getContentSize().height * posY)
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

function topButton:createSprite(pic,posX,posY,parentNode)
	local sprite = display.newSprite(pic)
	:setPosition(display.width * posX, display.height * posY)
	
	if not parentNode then
		parentNode = self
	end
	parentNode:addChild(sprite)
	return sprite
end
function topButton:createShopSprite(pic,posX,posY,parentNode)
	local sprite = display.newSprite(pic)
	:setPosition(parentNode:getContentSize().width * posX, parentNode:getContentSize().height * posY)
	
	if not parentNode then
		parentNode = self
	end
	parentNode:addChild(sprite)
	return sprite
end
function topButton:createLabel(parentNode, text, size, posX, posY,color)

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

function topButton:onEnter()
	-- body
end
function topButton:onExit()
	-- body
end
return topButton