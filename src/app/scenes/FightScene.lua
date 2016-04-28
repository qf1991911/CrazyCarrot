display.addSpriteFrames("fight/ui_play.plist","fight/ui_play.png")
display.addSpriteFrames("map/Theme1/theme1Scene.plist","map/Theme1/theme1Scene.png")
display.addSpriteFrames("UI/ui_public1.plist","UI/ui_public1.png")
local Monster = require(".app.monster.Monster")
local Tower = require(".app.tower.Tower")
local PassData = require(".app.stageConfig.PassData")

local FightScene = class("FightScene", function(passnum)
	local scene = display.newScene("FightScene")
	
	self.Theme = math.floor(passnum-1/10)+1
	self.pass =  passnum % 10
	return scene
end)

function FightScene:ctor()
	self:fightUI()
	self:fightMap()
	self.monster = {}
	self.way = {}

end

function FightScene:fightUI() --战斗场景布局
	self.sprtieBG = display.newSprite("map/Theme1/theme1Map.png")
	:pos(display.cx, display.cy)
	:addTo(self)
	self.sizeofBG = self.sprtieBG:getContentSize()

	local skillbg = self:spriteCreate("#skillBg.png",self.sizeofBG.width / 2,self.sizeofBG.height / 11)

	local moneybg = self:spriteCreate("#ui_moneyBg.png",self.sizeofBG.width*.16,self.sizeofBG.height*.88)

	local wavebg = self:spriteCreate("#ui_waveBg.png",self.sizeofBG.width*.45,self.sizeofBG.height*.88)
	local wbgsize = wavebg:getContentSize() 
	local wavelb = self:waveLabel1()
	wavelb:pos(wbgsize.width*.38, wbgsize.height*.45)
	wavelb:addTo(wavebg)
	self.wavelbnow = self:waveLabel1()
	self.wavelbnow:pos(wbgsize.width*.1, wbgsize.height*.45)
	self.wavelbnow:setString(1)
	self.wavelbnow:addTo(wavebg)

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
	self.map = cc.TMXTiledMap:create(PassData["L"..self.Theme.."_"..self.pass].map)
	self.map:setPosition(self.sizeofBG.width / 2,self.sizeofBG.height / 2)
	:align(1)
	self.map:addTo(self.sprtieBG)
	local num = 0
	while table.nums(self.map:getObjectGroup("objs"):getObject("way1_"..num)) ~= 0 do
		local objPoint = self.map:getObjectGroup("objs"):getObject("way1_"..num)
		num = num+1
		table.insert(self.way,objPoint)
	end

	local wave = 1
	local time = os.time()
	local septum = 0
	local num = 15
	
	local enemyhome = self:enemyHomePos()
	enemyhome:runAction(self:enemyhomeAction())
	enemyhome:setOpacity(0)
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function (dt)
		if wave<= PassData["L"..self.Theme.."_"..self.pass].wave and os.time()-time > PassData["L"..self.Theme.."_"..self.pass]["wavetime"..wave] and septum == 0 and num > 0 then
			local monster = self:monsterCreate(PassData["L"..self.Theme.."_"..self.pass]["wave"..wave])
			table.insert(self.monster,monster)
			num = num - 1
			enemyhome:setOpacity(255)
			self.wavelbnow:setString(wave)
		end
		if num == 0 then
			enemyhome:setOpacity(0)
			wave = wave + 1
			num = 15
		end
		septum = (septum + 1) % 60
		-- for k,v in pairs(self.monster) do
		-- 	local x,y = v:getPosition()

		-- end
	end)
	self:scheduleUpdate()

	local rabbit = display.newSprite("#protectPoint.png")
	rabbit:pos(self.way[#self.way].x, self.way[#self.way].y)
	rabbit:setAnchorPoint(0.5,0)
	rabbit:addTo(self.map,1)

	local flag = display.newSprite("#Theme1_EnemyHome.png")
	flag:pos(self.way[1].x, self.way[1].y)
	flag:setAnchorPoint(0.5,0)
	flag:addTo(self.map,1)

	local tower = Tower.new(PassData["L"..self.Theme.."_"..self.pass].pretower)
	local pretower = self.map:getObjectGroup("objs"):getObject("preTower")
	tower:pos(pretower.x, pretower.y)
	tower:addTo(self.map)

end

function FightScene:waveLabel1() --波数文字
	local label = cc.ui.UILabel.new({
		UILabelType = 1,
		text = PassData["L"..self.Theme.."_"..self.pass].wave,
		font = "font/fontTitleNumber.fnt"
		})
	return label
end

function FightScene:enemyHomePos() --出怪漩涡
	local enemyhome = display.newSprite("#enemyHomePos.png")
	:pos(self.way[1].x, self.way[1].y)
	:addTo(self.map)
	return enemyhome
end
function FightScene:enemyhomeAction()--漩涡动作
	local rotate = cc.RotateBy:create(0.5,60)
	local rep = cc.RepeatForever:create(rotate)
	return rep
	-- body
end

function FightScene:monsterCreate(numofmonster) --出怪
	local monster = Monster.new(numofmonster)
	monster:pos(self.way[1].x, self.way[1].y)
	monster:move(self.way)
	monster:addTo(self.map,1)
	return monster
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