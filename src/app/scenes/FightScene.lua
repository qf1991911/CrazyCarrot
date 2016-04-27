display.addSpriteFrames("fight/ui_play.plist","fight/ui_play.png")
display.addSpriteFrames("map/Theme1/theme1Scene.plist","map/Theme1/theme1Scene.png")
display.addSpriteFrames("UI/ui_public1.plist","UI/ui_public1.png")
local Monster = require(".app.monster.monster")
local FightScene = class("FightScene", function()
	return display.newScene("FightScene")
end)

function FightScene:ctor()
	self:fightUI()
	self:fightMap()
end

function FightScene:fightUI() --战斗场景布局
	self.sprtieBG = display.newSprite("map/Theme1/theme1Map.png")
	:pos(display.cx, display.cy)
	:addTo(self)
	self.sizeofBG = self.sprtieBG:getContentSize()

	local skillbg = self:spriteCreate("#skillBg.png",self.sizeofBG.width / 2,self.sizeofBG.height / 11)
	local moneybg = self:spriteCreate("#ui_moneyBg.png",self.sizeofBG.width*.16,self.sizeofBG.height*.88)
	local wavebg = self:spriteCreate("#ui_waveBg.png",self.sizeofBG.width*.45,self.sizeofBG.height*.88) 
	local hero = self:spriteCreate("#taskHeroIcon1.png",self.sizeofBG.width*.78 , self.sizeofBG.height *.11)

	self.mission1 = self:misButtonCreate("#littleTaskIcon4.png",self.sizeofBG.width*.2 , self.sizeofBG.height *.1)
	self.mission2 = self:misButtonCreate("#littleTaskIcon2.png",self.sizeofBG.width*.26 , self.sizeofBG.height *.1)
	self.mission3 = self:misButtonCreate("#littleTaskIcon1.png",self.sizeofBG.width*.32 , self.sizeofBG.height *.1)
	local mission4 = self:spriteCreate("#littleTaskIcon5.png",self.sizeofBG.width*.38 , self.sizeofBG.height *.1)

	local pause = self:buttonCreate("#ui_stop.png",self.sizeofBG.width*.79,self.sizeofBG.height*.88)
	local state = true
	pause:onButtonClicked(function (event)
		if state then			
			pause:setButtonImage(cc.ui.UIPushButton.NORMAL, "#ui_continue.png")
			local frame = display.newSpriteFrame("ui_waveSuspend.png")
			wavebg:setSpriteFrame(frame)
		else			
			pause:setButtonImage(cc.ui.UIPushButton.NORMAL, "#ui_stop.png")	
			local frame = display.newSpriteFrame("ui_waveBg.png")
			wavebg:setSpriteFrame(frame)
		end
		state = not state
	end)
	pause:addTo(self.sprtieBG)

	local setting = self:buttonCreate("#ui_setting.png",self.sizeofBG.width*.86,self.sizeofBG.height*.88)
	setting:onButtonClicked(function (event)
		self:settingUI()
	end)
	setting:addTo(self.sprtieBG)

	local skill1 = self:buttonCreate("#skillIcon2.png",self.sizeofBG.width*.6 , self.sizeofBG.height *.1)
	skill1:addTo(self.sprtieBG)

	local skill2 = self:buttonCreate("#skillIcon1.png",self.sizeofBG.width*.69 , self.sizeofBG.height *.1)
	skill2:addTo(self.sprtieBG)

	local imagespeed = {
	on ="#ui_speed2x.png",
	on_pressed = "#ui_speed2x.png",
	on_disabled = "#ui_speed2x.png",
	off ="#ui_speed1x.png",
	off_pressed ="#ui_speed1x.png",
	off_disabled ="#ui_speed1x.png",
	}

	local speed = cc.ui.UICheckBoxButton.new(imagespeed)
	:pos(self.sizeofBG.width*.67,self.sizeofBG.height*.88)
	:addTo(self.sprtieBG)

end

function FightScene:fightMap() --地图
	local map = cc.TMXTiledMap:create("map/Theme1/L1_1.tmx")
	map:setPosition(self.sizeofBG.width / 2,self.sizeofBG.height / 2)
	:align(1)
	map:addTo(self.sprtieBG)


	local num = 0
	local mapPoint = {}
	while table.nums(map:getObjectGroup("objs"):getObject("way1_"..num)) ~= 0 do
		local objPoint = map:getObjectGroup("objs"):getObject("way1_"..num)
		num = num+1
		table.insert(mapPoint,objPoint)
	end
	local monster = Monster.new("02")
	monster:pos(mapPoint[1].x, mapPoint[1].y)
	monster:move(mapPoint)
	monster:addTo(map,1)

	local rabbit = display.newSprite("#protectPoint.png")
	rabbit:pos(mapPoint[#mapPoint].x, mapPoint[#mapPoint].y)
	rabbit:setAnchorPoint(0.5,0)
	rabbit:addTo(map,1)

	local flag = display.newSprite("#Theme1_EnemyHome.png")
	flag:pos(mapPoint[1].x, mapPoint[1].y)
	flag:setAnchorPoint(0.5,0)
	flag:addTo(map,1)

end

function FightScene:spriteCreate(way,posx,posy) --精灵创建
	local sprite = display.newSprite(way)
	:pos(posx, posy)
	:addTo(self.sprtieBG)
	return sprite 
end

function FightScene:misButtonCreate(way,posx,posy) --按钮创建
	images = {
	normal = way,
	pressed = way,
	disabled = way
	}
	local button = cc.ui.UIPushButton.new(images)
	:pos(posx, posy)
	:addTo(self.sprtieBG)
	button:onButtonClicked(function (event)
		self:mission()
	end)
	return button 

end
function FightScene:buttonCreate(way,posx,posy) --按钮创建
	images = {
	normal = way,
	pressed = way,
	disabled = way
	}
	local button = cc.ui.UIPushButton.new(images)
	:pos(posx, posy)
	self:buttonEvent(button)
	return button 

end

function FightScene:mission() --任务按钮界面
	local mislayer = display.newColorLayer(cc.c4b(0, 0, 0, 80))
	mislayer:pos(0,0)
	mislayer:addTo(self)
	mislayer:setTouchEnabled(true)
	mislayer:setTouchSwallowEnabled(true)
	mislayer:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
		if event.name == "began" then
			return true
		end
	end)
	local sizeofML = mislayer:getContentSize()

	local missionbg = display.newSprite("#taskBg.png")
	missionbg:pos(sizeofML.width / 2, sizeofML.height / 2)
	missionbg:addTo(mislayer)

	local MBGsize = missionbg:getContentSize()
	local missionClose = self:buttonCreate("#taskClose.png",MBGsize.width *.96,MBGsize.height*.9)
	missionClose:onButtonClicked(function ()
		mislayer:removeFromParent()
	end)
	missionClose:addTo(missionbg)
	
end

function FightScene:settingUI() --设置按钮界面
	local setlayer = display.newColorLayer(cc.c4b(0, 0, 0, 100))
	setlayer:pos(0,0)
	setlayer:addTo(self)
	setlayer:setTouchEnabled(true)
	setlayer:setTouchSwallowEnabled(true)
	setlayer:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
		if event.name == "began" then
			return true
		end
	end)
	local sizeofSL = setlayer:getContentSize()


	local settingBG = display.newSprite("#settingBg.png")
	settingBG:pos(sizeofSL.width / 2, sizeofSL.height / 2)
	settingBG:addTo(setlayer)
	local settingUIsize = settingBG:getContentSize()
	local continue = self:buttonCreate("#settingResume.png", settingUIsize.width / 2 , settingUIsize.height * .75)
	continue:addTo(settingBG)
	continue:onButtonClicked(function (event)
		setlayer:removeFromParent()
		-- body
	end)
	local restart = self:buttonCreate("#settingRestart.png", settingUIsize.width / 2 , settingUIsize.height * .5)
	restart:addTo(settingBG)
	local getback = self:buttonCreate("#settingReturn.png", settingUIsize.width / 2 , settingUIsize.height * .25)
	getback:addTo(settingBG)
	local levelnum = display.newSprite("#settingFlag.png")
	levelnum:pos(settingUIsize.width *.2 , settingUIsize.height * 0.88)
	levelnum:addTo(settingBG)
	-- body
end



function FightScene:buttonEvent(btnname) -- 按钮点击动作
	btnname:onButtonPressed(function(event)
		local scl = cc.ScaleTo:create(0.1,1.2)
		btnname:runAction(scl)
	end)
	btnname:onButtonRelease(function(event)
		local scl2 = cc.ScaleTo:create(0.1,1)
		btnname:runAction(scl2)
	end)
	
end


function FightScene:onEnter()

end

function FightScene:onExit()

end
return FightScene