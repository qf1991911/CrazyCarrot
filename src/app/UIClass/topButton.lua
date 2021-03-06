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
	local buttonbg1 = self:createSprite("#buttonBg.png", 0.308, 0.9)
	:setScaleX(3)
	:setScaleY(0.9)
	if GameState.GameData.bloodNowState == "false" then
		self.bloodLabel = self:createLabel(buttonbg1, GameState.GameData.UItopData.bloodNow, 22, 0.54, 0.5,cc.c3b(255, 204, 0))
		:setScaleX(0.45)
		:setScaleY(1.1)		
	elseif GameState.GameData.bloodNowState == "true" then
		self.bloodLabel = self:createLabel(buttonbg1, "无限体力", 22, 0.54, 0.5,cc.c3b(255, 204, 0))
		:setScaleX(0.45)
		:setScaleY(1.1)
	end
	local bloodNow = self:createSprite("#bloodNew.png", 0.22, 0.9)
	local addNew1 = self:createButton("#addNew.png", 0.4, 0.9, 0.01, 0.9)
	:onButtonClicked(function(event)	
		if self:getParent():getChildByTag(2) then
			self:getParent():getChildByTag(2):removeFromParent()	
		elseif self:getParent():getChildByTag(3) then
			self:getParent():getChildByTag(3):removeFromParent()
		elseif self:getParent():getChildByTag(4) then
			self:getParent():getChildByTag(4):removeFromParent()
		end	
		self:CreateBuyScene()
	end)

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.56, 0.9)
	:setScaleX(3)
	:setScaleY(0.9)
	self.coinLabel = self:createLabel(buttonbg2, GameState.GameData.UItopData.coin, 22, 0.54, 0.5,cc.c3b(255, 204, 0))
	:setScaleX(0.45)
	:setScaleY(1.1)	
	local  coinNew = self:createSprite("#coinNew.png", 0.47, 0.9)
	local addNew2 = self:createButton("#addNew.png", 0.655, 0.9, 0.01, 0.9)
	:onButtonClicked(function(event)
		if self:getParent():getChildByTag(2) then
			self:getParent():getChildByTag(2):removeFromParent()	
		elseif self:getParent():getChildByTag(3) then
			self:getParent():getChildByTag(3):removeFromParent()
		elseif self:getParent():getChildByTag(4) then
			self:getParent():getChildByTag(4):removeFromParent()
		end	
		self:CreateCoinBuyScene()
	end)	

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.805, 0.9)
	:setScaleX(3)
	:setScaleY(0.9)
	self.diamondLabel = self:createLabel(buttonbg2, GameState.GameData.UItopData.diamond, 22, 0.54, 0.5,cc.c3b(255, 204, 0))
	:setScaleX(0.45)
	:setScaleY(1.1)	
	local diamondNew = self:createSprite("#diamondNew.png", 0.72, 0.9)
	local addNew3 = self:createButton("#addNew.png", 0.9, 0.9, 0.01, 0.9)
	:onButtonClicked(function(event)
		if self:getParent():getChildByTag(2) then
			self:getParent():getChildByTag(2):removeFromParent()	
		elseif self:getParent():getChildByTag(3) then
			self:getParent():getChildByTag(3):removeFromParent()
		elseif self:getParent():getChildByTag(4) then
			self:getParent():getChildByTag(4):removeFromParent()
		end	
		self:CreateDiamondBuyScene()
	end)	

	local returnButton = self:createButton("#returnNew.png", 0.15, 0.9,0.01, 0.9)
	:onButtonClicked(function(event)
		if self:getParent():getChildByTag(2) then
			self:getParent():getChildByTag(2):removeFromParent()
		elseif self:getParent():getChildByTag(3) then
			self:getParent():getChildByTag(3):removeFromParent()
		elseif self:getParent():getChildByTag(4) then
			self:getParent():getChildByTag(4):removeFromParent()
		else
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
				local TrunScene = require("app.scenes." .. self.tScene):new()
				display.replaceScene(TrunScene,"flipAngular",0.5)
			end	
		end
	end)
end

function topButton:CreateBuyScene()
	local dailytaskLayer = display.newColorLayer(cc.c4b(100, 100, 100, 50))
	dailytaskLayer:setContentSize(display.width * 1.5, display.height )
	dailytaskLayer:setScale(0.85)
	dailytaskLayer:setTag(2)
	self:getParent():addChild(dailytaskLayer)
	dailytaskLayer:setTouchEnabled(true)
	dailytaskLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ()			
	end)

	local shop_bg = self:createShopSprite("#shop_bg.png",0.4,0.5, dailytaskLayer)
	local shopBg1 = self:createShopSprite("#shopBg.png",0.19,0.5, shop_bg)
	local shopBg2 = self:createShopSprite("#shopBg.png",0.4,0.5, shop_bg)
	local shopBg3 = self:createShopSprite("#shopBg.png",0.61,0.5, shop_bg)
	local shopBg4 = self:createShopSprite("#shopBg.png",0.82,0.5, shop_bg)
	local shopTitleBg = self:createShopSprite("#shopTitleBg.png",0.4,0.85, dailytaskLayer)
	local shopEnergyTitle = self:createShopSprite("#shopEnergyTitle.png",0.5,0.72, shopTitleBg)
	local shop_energy1 = self:createShopSprite("#shop_energy.png",0.35,0.8, shopBg1)
	local energyNum1 = self:createShopSprite("#energyNum1.png",0.6,0.8, shopBg1)
	local shop_energy_pic1 = self:createShopSprite("#shop_energy1.png",0.5,0.55, shopBg1)
	local price1 = self:createShopSprite("#energyNeedMoney1.png",0.5,0.25, shopBg1)
	local buyButton1 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg1,0.9)
	:onButtonClicked(function()
		if GameState.GameData.bloodNowState == "false" then
			GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 10
			GameState.GameData.UItopData.bloodNow = GameState.GameData.UItopData.bloodNow + 1
			self.bloodLabel:setString(GameState.GameData.UItopData.bloodNow)
			self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
			GameState.save(GameState.GameData)
		end
	end)
	local shop_energy2 = self:createShopSprite("#shop_energy.png",0.35,0.8, shopBg2)
	local energyNum2 = self:createShopSprite("#energyNum2.png",0.6,0.8, shopBg2)
	local shop_energy_pic2 = self:createShopSprite("#shop_energy2.png",0.5,0.55, shopBg2)
	local price2 = self:createShopSprite("#energyNeedMoney2.png",0.5,0.25, shopBg2)
	local buyButton2 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg2,0.9)
	:onButtonClicked(function()
		if GameState.GameData.bloodNowState == "false" then
			GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 40
			GameState.GameData.UItopData.bloodNow = GameState.GameData.UItopData.bloodNow + 5
			self.bloodLabel:setString(GameState.GameData.UItopData.bloodNow)
			self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
			GameState.save(GameState.GameData)
		end
	end)
	local shop_energy3 = self:createShopSprite("#shop_energy.png",0.35,0.8, shopBg3)
	local energyNum2 = self:createShopSprite("#energyNum3.png",0.6,0.8, shopBg3)
	local shop_energy_pic3 = self:createShopSprite("#shop_energy3.png",0.5,0.55, shopBg3)
	local price3 = self:createShopSprite("#energyNeedMoney3.png",0.5,0.25, shopBg3)
	local buyButton3 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg3,0.9)
	:onButtonClicked(function()
		if GameState.GameData.bloodNowState == "false" then
			GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 60
			GameState.GameData.UItopData.bloodNow = GameState.GameData.UItopData.bloodNow + 10
			self.bloodLabel:setString(GameState.GameData.UItopData.bloodNow)
			self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
			GameState.save(GameState.GameData)
		end
	end)
	local shop_energy4 = self:createShopSprite("#energyNum4.png",0.5,0.8, shopBg4)
	local shop_energy_pic4 = self:createShopSprite("#shop_energy4.png",0.5,0.55, shopBg4)
	local price4 = self:createShopSprite("#energyNeedMoney4.png",0.5,0.25, shopBg4)
	local buyButton4 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg4,0.9)
	:onButtonClicked(function()
		if GameState.GameData.bloodNowState == "false" then
			GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 560
			GameState.GameData.bloodNowState = "true"
			self.bloodLabel:setString("无限体力")
			self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
			GameState.save(GameState.GameData)
		end
	end)
end

function topButton:CreateCoinBuyScene()
	local dailytaskLayer = display.newColorLayer(cc.c4b(100, 100, 100, 50))
	dailytaskLayer:setContentSize(display.width * 1.5, display.height)
	dailytaskLayer:setScale(0.85)
	dailytaskLayer:setTag(3)
	self:getParent():addChild(dailytaskLayer)
	dailytaskLayer:setTouchEnabled(true)
	dailytaskLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ()			
	end)

	local shop_bg = self:createShopSprite("#shop_bg.png",0.4,0.5, dailytaskLayer)
	local shopBg1 = self:createShopSprite("#shopBg.png",0.19,0.5, shop_bg)
	local shopBg2 = self:createShopSprite("#shopBg.png",0.4,0.5, shop_bg)
	local shopBg3 = self:createShopSprite("#shopBg.png",0.61,0.5, shop_bg)
	local shopBg4 = self:createShopSprite("#shopBg.png",0.82,0.5, shop_bg)
	local shopTitleBg = self:createShopSprite("#shopTitleBg.png",0.4,0.85, dailytaskLayer)
	local shopCoinTitle = self:createShopSprite("#shopCoinTitle.png",0.5,0.72, shopTitleBg)
	
	local coinNum1 = self:createShopSprite("#coinNum1.png",0.5,0.8, shopBg1)
	local shop_coin1 = self:createShopSprite("#shop_coin1.png",0.5,0.55, shopBg1)
	local price1 = self:createShopSprite("#coinNeedMoney1.png",0.5,0.25, shopBg1)
	local buyButton1 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg1,0.9)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 30
		GameState.GameData.UItopData.coin = GameState.GameData.UItopData.coin + 300
		self.coinLabel:setString(GameState.GameData.UItopData.coin)
		self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)
	local coinNum2 = self:createShopSprite("#coinNum2.png",0.5,0.8, shopBg2)
	local shop_coin2 = self:createShopSprite("#shop_coin2.png",0.5,0.55, shopBg2)
	local price2 = self:createShopSprite("#coinNeedMoney2.png",0.5,0.25, shopBg2)
	local buyButton2 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg2,0.9)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 50
		GameState.GameData.UItopData.coin = GameState.GameData.UItopData.coin + 600
		self.coinLabel:setString(GameState.GameData.UItopData.coin)
		self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)

	local coinNum3 = self:createShopSprite("#coinNum3.png",0.5,0.8, shopBg3)
	local shop_coin3 = self:createShopSprite("#shop_coin3.png",0.5,0.55, shopBg3)
	local price3 = self:createShopSprite("#coinNeedMoney3.png",0.5,0.25, shopBg3)
	local buyButton3 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg3,0.9)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 100
		GameState.GameData.UItopData.coin = GameState.GameData.UItopData.coin + 1500
		self.coinLabel:setString(GameState.GameData.UItopData.coin)
		self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)
	local coinNum4 = self:createShopSprite("#coinNum4.png",0.5,0.8, shopBg4)
	local shop_coin4 = self:createShopSprite("#shop_coin4.png",0.5,0.55, shopBg4)
	local price4 = self:createShopSprite("#coinNeedMoney4.png",0.5,0.25, shopBg4)
	local buyButton4 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg4,0.9)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond - 200
		GameState.GameData.UItopData.coin = GameState.GameData.UItopData.coin + 4000
		self.coinLabel:setString(GameState.GameData.UItopData.coin)
		self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)
end

function topButton:CreateDiamondBuyScene()
	local dailytaskLayer = display.newColorLayer(cc.c4b(100, 100, 100, 50))
	dailytaskLayer:setContentSize(display.width * 1.5, display.height)
	dailytaskLayer:setScale(0.85)
	dailytaskLayer:setTag(4)
	self:getParent():addChild(dailytaskLayer)
	dailytaskLayer:setTouchEnabled(true)
	dailytaskLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ()			
	end)

	local shop_bg = self:createShopSprite("#shop_bg.png",0.4,0.5, dailytaskLayer)
	local shopBg1 = self:createShopSprite("#shopBg.png",0.19,0.5, shop_bg)
	local shopBg2 = self:createShopSprite("#shopBg.png",0.4,0.5, shop_bg)
	local shopBg3 = self:createShopSprite("#shopBg.png",0.61,0.5, shop_bg)
	local shopBg4 = self:createShopSprite("#shopBg.png",0.82,0.5, shop_bg)
	local shopTitleBg = self:createShopSprite("#shopTitleBg.png",0.4,0.85, dailytaskLayer)
	local shopDiamondTitle = self:createShopSprite("#shopDiamondTitle.png",0.5,0.72, shopTitleBg)
	
	local diamondNum1 = self:createShopSprite("#diamondNum1.png",0.5,0.8, shopBg1)
	local shop_diamond1 = self:createShopSprite("#shop_diamond1.png",0.5,0.55, shopBg1)
	local price1 = self:createShopSprite("#diamondNeedMoney1.png",0.5,0.25, shopBg1)
	local buyButton1 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg1,0.9)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond + 30
		self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)
	local diamondNum2 = self:createShopSprite("#diamondNum2.png",0.5,0.8, shopBg2)
	local shop_diamond2 = self:createShopSprite("#shop_diamond2.png",0.5,0.55, shopBg2)
	local price2 = self:createShopSprite("#diamondNeedMoney2.png",0.5,0.25, shopBg2)
	local buyButton2 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg2,0.9)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond + 66
		self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)

	local diamondNum3 = self:createShopSprite("#diamondNum3.png",0.5,0.8, shopBg3)
	local shop_diamond3 = self:createShopSprite("#shop_diamond3.png",0.5,0.55, shopBg3)
	local price3 = self:createShopSprite("#diamondNeedMoney3.png",0.5,0.25, shopBg3)
	local buyButton3 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg3,0.9)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond +144
		self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
		GameState.save(GameState.GameData)
	end)
	local diamondNum4 = self:createShopSprite("#diamondNum4.png",0.5,0.8, shopBg4)
	local shop_diamond4 = self:createShopSprite("#shop_diamond4.png",0.5,0.55, shopBg4)
	local price4 = self:createShopSprite("#diamondNeedMoney4.png",0.5,0.25, shopBg4)
	local buyButton4 = self:createBuyButton("#shopCommomBuy.png",0.5,0.14,shopBg4,0.9)
	:onButtonClicked(function()
		GameState.GameData.UItopData.diamond = GameState.GameData.UItopData.diamond + 280
		self.diamondLabel:setString(GameState.GameData.UItopData.diamond)
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

function topButton:createBuyButton(path, posX, posY, parentNode,scale)
	local images = {
	normal = path,
	pressed = path
	}
	local button = cc.ui.UIPushButton.new(images)
	button:setPosition(parentNode:getContentSize().width * posX, parentNode:getContentSize().height * posY)
	:setScale(0.9)
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