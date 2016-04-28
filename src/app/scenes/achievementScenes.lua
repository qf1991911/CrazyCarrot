display.addSpriteFrames("UI/ui_public1.plist","UI/ui_public1.png")
display.addSpriteFrames("UI/ui_achievement.plist","UI/ui_achievement.png")
display.addSpriteFrames("UI/ui_handbook.plist","UI/ui_handbook.png")
local Tabel = require(".app.stageConfig.stageLevelInformation")
local topButton = require(".app.UIClass.topButton")
local achievementScenes = class("achievementScenes", function()
    return display.newScene("achievementScenes")
end)
function achievementScenes:ctor()
	local heroAchieveBG = self:createSprite("pic/heroAchieveBG.png",0.5, 0.5, self)

	local achievetitleBg = self:createSprite("#handbookBg.png",0.5, 0.42 ,self)
	:setScaleX(0.9)
	
	local achievetitle = self:createSprite("#achievetitle.png",0.5, 0.78 ,self)
	self:listView()
	self:TopButton()



end
function achievementScenes:createSprite(pic,posX,posY,parentNode)
	local sprite = display.newSprite(pic)
	:setPosition(display.width * posX, display.height * posY)
	if parentNode then
		parentNode:addChild(sprite)
	end
	
	return sprite
end
function achievementScenes:listView()
	local listView = cc.ui.UIListView.new({
		-- bgColor = cc.c4b(255, _g, _b, 255),
		viewRect = cc.rect(display.width * 0.15, display.height * 0.1, display.width * 0.7, display.height * 0.6)
	})
	-- :onTouch(print("···"))
	self:addChild(listView)
	listView:setBounceable(false)
	for i = 1, #Tabel["achieveItem"] do
	-- for i,v in pairs(Tabel["item"]) do
		local item = listView:newItem()

		local content = display.newSprite("#achieveBar.png")
		:setScale(0.86, 0.8)
		item:addContent(content)
		item:setItemSize(content:getContentSize().width * 0.86, content:getContentSize().height * 0.75)
		listView:addItem(item)
		local achieveDiamond = self:createSprite("#achieveDiamond.png",0.088, 0.13,content)
		:setScale(0.8)
		local label1 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = Tabel["achieveItem"][i][1],
			size = 20
			})
		:setPosition(display.width * 0.074, display.height * 0.07)
		content:addChild(label1)
		local label2 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = Tabel["achieveItem"][i][2],
			size = 30,
			color = cc.c3b(255, 100, 0)
			})
		:setPosition(display.width * 0.25, display.height * 0.15)
		content:addChild(label2)
		local scale9sp = ccui.Scale9Sprite 
		local progressbar = scale9sp:createWithSpriteFrameName("achieve_bar2.png", cc.rect(0, 0, 337,24));
		progressbar:setPreferredSize(cc.size(300, 24)) -- xiugai 300
		progressbar:setAnchorPoint(cc.p(0, 0.5))
		progressbar:setPosition(cc.p(234.5, 57))
		content:addChild(progressbar)
		local achieveDiamond = self:createSprite("#running.png",0.7, 0.1,content)
	end
	listView:reload()
end
function achievementScenes:TopButton()
	topButton.new(self, "UI")
end
function achievementScenes:onEnter()
	-- body
end
function achievementScenes:onExit()
	-- body
end
return achievementScenes