display.addSpriteFrames("UI/ui_herohouseUI.plist","UI/ui_herohouseUI.png")
display.addSpriteFrames("UI/ui_handbook.plist","UI/ui_handbook.png")
display.addSpriteFrames("UI/ui_herohouseAni.plist","UI/ui_herohouseAni.png")
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
	local heroChooseLabel = self:CreateSprite("#herohousetitle.png", heroListviewBg, 0.5, 0.93, 1, 1)

end
function HeroHouseUI:ui_herohouseAni(heroNum)
	local frames = display.newFrames("hero"..heroNum.."_%d.png",1,10)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	return rep
end
function HeroHouseUI:listView()
	local listView = cc.ui.UIListView.new({
		-- bgColor = cc.c4b(255, _g, _b, 255),
		viewRect = cc.rect(self:getChildByTag(1):getContentSize().width * 0.1,0,self:getChildByTag(1):getContentSize().width * 0.8,self:getChildByTag(1):getContentSize().height * 0.9),
		direction = cc.ui.UIScrollView.DIRECTION_HORIZONTAL
	})
	self:getChildByTag(1):addChild(listView)
	listView:setBounceable(false)
	local a = {}
	-- local b = {}
	for i = 1, 4 do
		-- b[i] = i
		local item = listView:newItem()
		local node = display.newNode()
		local j = i + 4
		a[i] = display.newSprite("#hero_bg.png")
		a[i]:setScale(0.86, 0.8)
		a[i]:setTouchEnabled(true)
		a[i]:addNodeEventListener(cc.NODE_TOUCH_EVENT,function()
			GameState.GameData.HeroScanNumber = i
			GameState.save(GameState.GameData)
			local HeroInformationUI = import(".app.scenes.HeroInformationUI").new(num)
			display.replaceScene(HeroInformationUI,"flipAngular",0.5)
		end)
		node:addChild(a[i])
		a[j] = display.newSprite("#hero_haswarBg.png")
		a[j]:setScale(0.86, 0.8)
		a[j]:setTouchEnabled(true)
		a[j]:addNodeEventListener(cc.NODE_TOUCH_EVENT,function()
			GameState.GameData.HeroScanNumber = j - 4
			GameState.save(GameState.GameData)
			local HeroInformationUI = import(".app.scenes.HeroInformationUI").new(num)
			display.replaceScene(HeroInformationUI,"flipAngular",0.5)
		end)
		node:addChild(a[j])
		if i ~= GameState.GameData.HeroNumber then
			
			a[j]:hide()
		else
			a[j]:show()
			a[i]:hide()
		end
		item:addContent(node)
		
		local images = {
			normal = "#hero_war.png",
			pressed = "#hero_war.png",
			disabled = "#hero_war.png"
						}
		local hero_war = cc.ui.UIPushButton.new(images)
		hero_war:setPosition(a[i]:getContentSize().width * 0.5, 0)
		hero_war:onButtonPressed(function ()
			if i ~= GameState.GameData.HeroNumber then
				a[5]:hide()
				a[1]:show()
				a[6]:hide()
				a[2]:show()
				a[7]:hide()
				a[3]:show()
				a[8]:hide()
				a[4]:show()
				a[i]:hide()
				a[j]:show()
				GameState.GameData.HeroNumber = i
				GameState.save(GameState.GameData)
			end
		end)
		a[i]:addChild(hero_war)
		local hero_haswar = self:CreateSprite("#hero_haswar.png", a[j], 0.5, 0, 1, 1)
		item:setItemSize(a[i]:getContentSize().width * 0.83, a[i]:getContentSize().height * 0.75)
		listView:addItem(item)
		local heroSprite = self:CreateSprite("#hero"..i..".png",a[i],0.5, 0.5,1,1)
		heroSprite:runAction(self:ui_herohouseAni(i))
		local heroSprite1 = self:CreateSprite("#hero"..i..".png",a[j],0.5, 0.5,1,1)
		heroSprite1:runAction(self:ui_herohouseAni(i))
		local label1 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = HeroData["Heroname"][i],
			size = 30
			})
		:align(display.CENTER, display.cx, display.cy)
		:setPosition(a[i]:getContentSize().width * 0.5, a[i]:getContentSize().height * 0.88)
		a[i]:addChild(label1)
		local label2 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = HeroData["HeroIntroduce"][i],
			size = 22,
			color = cc.c3b(255, 100, 0)
			})
		:setPosition(a[i]:getContentSize().width * 0.13, a[i]:getContentSize().height * 0.2)
		a[i]:addChild(label2)
		local label3 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = HeroData["Heroname"][i],
			size = 30
			})
		:align(display.CENTER, display.cx, display.cy)
		:setPosition(a[i]:getContentSize().width * 0.5, a[i]:getContentSize().height * 0.88)
		a[j]:addChild(label3)
		local label4 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = HeroData["HeroIntroduce"][i],
			size = 22,
			color = cc.c3b(255, 100, 0)
			})
		:setPosition(a[i]:getContentSize().width * 0.13, a[i]:getContentSize().height * 0.2)
		a[j]:addChild(label4)

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
	return sprite
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