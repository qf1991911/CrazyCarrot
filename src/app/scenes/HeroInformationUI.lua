display.addSpriteFrames("UI/ui_herohouseUI.plist","UI/ui_herohouseUI.png")
local HeroData = require("app.stageConfig.HeroData")
local topButton = require("app.UIClass.topButton")
local HeroInformationUI = class("HeroInformationUI", function()
    return display.newScene("HeroInformationUI")
end)

function HeroInformationUI:ctor()
	self:CreateHeroInformationUI()
	self:CreateTopButton()
end

function HeroInformationUI:CreateHeroInformationUI()
	
	local layer = cc.LayerColor:create(cc.c4b(0, 0, 0, 100))
	:setContentSize(display.width, display.height)
	self:addChild(layer)
	local HeroInformationUIBg = self:CreateSprite("pic/heroHouseBg.png", self, 0.5, 0.5, 1, 1,1)
	local herohouseSkillBg = self:CreateSprite("#herohouseSkillBg.png", HeroInformationUIBg, 0.5, 0.45, 0.8, 0.8, 1)
	self:listView()
	local heroSprite = self:CreateSprite("#hero"..GameState.GameData.HeroScanNumber..".png", herohouseSkillBg, 0.67, 0.41, 1, 1)
	local HeroName = self:CreateLabel(HeroData["Heroname"][GameState.GameData.HeroScanNumber], 25, herohouseSkillBg,0.715,0.8)
	local HeroInformation = self:CreateSprite("#skillUpgradeExchange.png", herohouseSkillBg, 0.85, 0.3, 0.8, 0.8)
	local heroMaxLevel = self:CreateSprite("#heroMaxLevel.png", herohouseSkillBg, 0.72, 0.13, 0.7, 0.7)
	local HeroBlood = self:CreateLabel(HeroData["information"][GameState.GameData.HeroScanNumber][1], 25, HeroInformation,0.5,0.85)
	:setTextColor(cc.c3b(118, 238, 0))
	local HeroAttack = self:CreateLabel(HeroData["information"][GameState.GameData.HeroScanNumber][2], 25, HeroInformation,0.5,0.5)
	:setTextColor(cc.c3b(118, 238, 0))
	local HeroSpeed = self:CreateLabel(HeroData["information"][GameState.GameData.HeroScanNumber][3], 25, HeroInformation,0.5,0.15)
	:setTextColor(cc.c3b(118, 238, 0))
end

function HeroInformationUI:listView()
	local listView = cc.ui.UIListView.new({
		-- bgColor = cc.c4b(255, _g, _b, 255),
		viewRect = cc.rect(self:getChildByTag(1):getChildByTag(1):getContentSize().width * 0.083,self:getChildByTag(1):getChildByTag(1):getContentSize().height * 0.15,self:getChildByTag(1):getChildByTag(1):getContentSize().width * 0.316,self:getChildByTag(1):getChildByTag(1):getContentSize().height * 0.6)
	})
	self:getChildByTag(1):getChildByTag(1):addChild(listView)
	listView:setBounceable(false)
	for i=1,#HeroData["skill"][GameState.GameData.HeroScanNumber] + 1 do
		if i <= #HeroData["skill"][GameState.GameData.HeroScanNumber] then
			local item = listView:newItem()
			local content = display.newSprite("#activeSkillBar.png")
			:setScaleX(0.9)
			:setScaleY(0.9)
			item:addContent(content)
			item:setItemSize(content:getContentSize().width * 0.86, content:getContentSize().height * 0.92)
			listView:addItem(item)
			local heroskill = self:CreateSprite(HeroData["skillPic"][GameState.GameData.HeroScanNumber][i], content, 0.15, 0.5, 1, 1)
			local skillTextBar = self:CreateSprite("#skillTextBar.png",content, 0.27, 0.6,1, 1)
			skillTextBar:setAnchorPoint(0,0.5)
			skillTextBar:setScaleX(#HeroData["skill"][GameState.GameData.HeroScanNumber][i] / 6)

			-- local scale9sp = ccui.Scale9Sprite 
			-- local skillTextBar = scale9sp:createWithSpriteFrameName("skillTextBar.png", cc.rect(0, 0, 63,35));
			-- skillTextBar:setPreferredSize(cc.size(63 * #HeroData["skill"][GameState.GameData.HeroScanNumber][i] / 6, 35)) -- xiugai 300
			-- skillTextBar:setAnchorPoint(cc.p(0, 0.5))
			-- skillTextBar:setPosition(content:getContentSize().width * 0.27, content:getContentSize().height * 0.27)
			-- content:addChild(skillTextBar)

			local skillText = self:CreateHeroInforLabel(HeroData["skill"][GameState.GameData.HeroScanNumber][i], 25, skillTextBar, 0.43, 0.5)
			skillText:setScaleX(6 / #HeroData["skill"][GameState.GameData.HeroScanNumber][i])
			local images = {
				normal = "#skillAddButton.png",
				pressed = "#skillAddButton.png",
				clicked = "#skillAddButton.png"
							}
			local skillAddButton = cc.ui.UIPushButton.new(images,{scale9 = true})
			skillAddButton:setPosition(content:getContentSize().width * 0.85,content:getContentSize().height * 0.5)
			content:addChild(skillAddButton)
			skillAddButton:onButtonClicked(function ()
				print("···")
			end)

		else
			local item = listView:newItem()
			local content = display.newSprite("#unactiveSkillBar.png")
			:setScaleX(0.9)
			:setScaleY(0.9)
			item:addContent(content)
			item:setItemSize(content:getContentSize().width * 0.86, content:getContentSize().height * 0.92)
			listView:addItem(item)
			local heroskill = self:CreateSprite(HeroData["skillPic"][GameState.GameData.HeroScanNumber][i], content, 0.15, 0.5, 1, 1)
			local unactiveIcon = self:CreateSprite("#unactiveIcon.png",content, 0.85, 0.5, 1, 1)
			local skillTextBar = self:CreateSprite("#skillTextBar.png",content, 0.27, 0.6,1, 1)
			skillTextBar:setAnchorPoint(0,0.5)
			skillTextBar:setScaleX(#HeroData["talent"][GameState.GameData.HeroScanNumber] / 6)
			local skillText = self:CreateHeroInforLabel(HeroData["talent"][GameState.GameData.HeroScanNumber], 25, skillTextBar, 0.43, 0.5)
			skillText:setScaleX(6 / #HeroData["talent"][GameState.GameData.HeroScanNumber])
			local unactiveSkillLabel = self:CreateLabel("天赋技能", 25, content, 0.43, 0.2)
		end
		
	end
	

	listView:reload()
end

function HeroInformationUI:CreateTopButton()
	topButton.new(self, "HeroHouseUI")
end

function HeroInformationUI:CreateLabel(text, size, parentNode, x, y)
	local label = cc.ui.UILabel.new({
			UILabelType = 2,
			text = text,
			size = size
			})
	label:align(display.CENTER, display.cx, display.cy)
	label:setPosition(parentNode:getContentSize().width * x, parentNode:getContentSize().height * y)
	parentNode:addChild(label)
	return label
end

function HeroInformationUI:CreateHeroInforLabel(text, size, parentNode, x, y)
	local label = cc.ui.UILabel.new({
			UILabelType = 2,
			text = text,
			size = size
			-- align = cc.TEXT_ALIGNMENT_LEFT
			})
	label:align(display.CENTER, display.cx, display.cy)
	label:setPosition(parentNode:getContentSize().width * x, parentNode:getContentSize().height * y)
	parentNode:addChild(label)
	return label
end

function HeroInformationUI:CreateSprite(pic, parentNode, posx, posy, scaleX, scaleY,Tag)
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
	return sprite
end

function HeroInformationUI:onEnter()
	-- body
end

function HeroInformationUI:onExit()
	-- body
end

return HeroInformationUI