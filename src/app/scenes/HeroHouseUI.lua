display.addSpriteFrames("UI/ui_herohouseUI.plist","UI/ui_herohouseUI.png")
display.addSpriteFrames("UI/ui_handbook.plist","UI/ui_handbook.png")
local HeroData = require("app.stageConfig.HeroData")
local topButton = require("app.UIClass.topButton")
local HeroHouseUI = class("HeroHouseUI", function()
    return display.newScene("HeroHouseUI")
end)

function HeroHouseUI:ctor()
	self:CreateUI()
	self:TopButton()
	self:listView()
end

function HeroHouseUI:CreateUI()
	local HeroBg = self:CreateSprite("pic/heroHouseBg.png", self, 0.5, 0.5, 1, 1)
	local heroListviewBg = self:CreateSprite("#handbookBg.png", self, 0.5, 0.45, 0.9, 0.9,1)
	local heroChooseLabel = self:CreateSprite("#herohousetitle.png", heroListviewBg, 0.5, 0.78, 1, 1)
	
end

function HeroHouseUI:listView()
	local listView = cc.ui.UIListView.new({
		-- bgColor = cc.c4b(255, _g, _b, 255),
		viewRect = cc.rect(self:getChildByTag(1):getContentSize().width * 0.1,0,self:getChildByTag(1):getContentSize().width * 0.8,self:getChildByTag(1):getContentSize().height * 0.9),
		direction = cc.ui.UIScrollView.DIRECTION_HORIZONTAL
	})
	self:getChildByTag(1):addChild(listView)
	listView:setBounceable(false)

	for i = 1, 4 do
	
		local item = listView:newItem()
		local node = display.newNode()
		nodeNum = i
		local content = display.newSprite("#hero_bg.png")
		content:setScale(0.86, 0.8)
		node:addChild(content)
		local content1 = display.newSprite("#hero_haswarBg.png")
		content1:setScale(0.86, 0.8)
		node:addChild(content1)
		if nodeNum ~= GameState.GameData.HeroNumber then
			
			content1:hide()
		else
			content1:show()
			content:hide()
		end
		item:addContent(node)

		local hero_war = self:CreateSprite("#hero_war.png", content, 0.5, 0, 1, 1)
		hero_war:setTouchEnabled(true)
		hero_war:addNodeEventListener(cc.NODE_TOUCH_EVENT,function ()
			if nodeNum ~= GameState.GameData.HeroNumber then
				content:hide()
				content1:show()
			end
		end)
		local hero_haswar = self:CreateSprite("#hero_haswar.png", content1, 0.5, 0, 1, 1)
		item:setItemSize(content:getContentSize().width * 0.83, content:getContentSize().height * 0.75)
		listView:addItem(item)
		local heroSprite = self:CreateSprite("#hero"..i..".png",content,0.5, 0.5,1,1)
		heroSprite:setScale(0.8)
		local heroSprite1 = self:CreateSprite("#hero"..i..".png",content1,0.5, 0.5,1,1)
		heroSprite1:setScale(0.8)
		local label1 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = HeroData["Heroname"][i],
			size = 30
			})
		:align(display.CENTER, display.cx, display.cy)
		:setPosition(content:getContentSize().width * 0.5, content:getContentSize().height * 0.88)
		content:addChild(label1)
		local label2 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = HeroData["HeroIntroduce"][i],
			size = 22,
			color = cc.c3b(255, 100, 0)
			})
		:setPosition(content:getContentSize().width * 0.13, content:getContentSize().height * 0.2)
		content:addChild(label2)
		local label3 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = HeroData["Heroname"][i],
			size = 30
			})
		:align(display.CENTER, display.cx, display.cy)
		:setPosition(content:getContentSize().width * 0.5, content:getContentSize().height * 0.88)
		content1:addChild(label3)
		local label4 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = HeroData["HeroIntroduce"][i],
			size = 22,
			color = cc.c3b(255, 100, 0)
			})
		:setPosition(content:getContentSize().width * 0.13, content:getContentSize().height * 0.2)
		content1:addChild(label4)

		-- local scale9sp = ccui.Scale9Sprite 
		-- local heroNatureBar = scale9sp:createWithSpriteFrameName("heroNatureBar.png", cc.rect(0, 0, 337,24));
		-- heroNatureBar:setPreferredSize(cc.size(300, 24)) -- xiugai 300
		-- heroNatureBar:setAnchorPoint(cc.p(0, 0.5))
		-- heroNatureBar:setPosition(cc.p(234.5, 57))
		-- content:addChild(heroNatureBar)

	end
	listView:reload()
end

function HeroHouseUI:CreateSprite(pic, parentNode, posx, posy, scaleX, scaleY,Tag)
	local sprite = display.newSprite(pic)
	if parentNode == "self" then 
		sprite:setPosition(display.width * posx, display.height * posy)
	else
		sprite:setPosition(parentNode:getContentSize().width * posx, parentNode:getContentSize().height * posy)
	end
	sprite:setScaleX(scaleX)
	sprite:setScaleY(scaleY)
	if Tag then
		sprite:setTag(Tag)
	end
	parentNode:addChild(sprite)
	return parentNode
end
function HeroHouseUI:TopButton()
	topButton.new(self, "UI")
end
function HeroHouseUI:onEnter()
	-- body
end

function HeroHouseUI:onExit()
	-- body
end

return HeroHouseUI