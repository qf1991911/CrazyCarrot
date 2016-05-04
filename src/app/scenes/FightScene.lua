display.addSpriteFrames("fight/ui_play.plist","fight/ui_play.png")
display.addSpriteFrames("fight/fight.plist","fight/fight.png")
display.addSpriteFrames("map/Theme1/theme1Scene.plist","map/Theme1/theme1Scene.png")
display.addSpriteFrames("UI/ui_public1.plist","UI/ui_public1.png")
display.addSpriteFrames("Tower/T01.plist","Tower/T01.png")
display.addSpriteFrames("Tower/T02.plist","Tower/T02.png")
display.addSpriteFrames("Tower/T03.plist","Tower/T03.png")
display.addSpriteFrames("Tower/T07.plist","Tower/T07.png")
display.addSpriteFrames("Tower/T11.plist","Tower/T11.png")
display.addSpriteFrames("Tower/T16.plist","Tower/T16.png")
display.addSpriteFrames("Tower/T18.plist","Tower/T18.png")
display.addSpriteFrames("Tower/bullet.plist","Tower/bullet.png")
local Tabel = require(".app.stageConfig.HeroData")
local Hero = require(".app.monster.Hero")
local Monster = require(".app.monster.Monster")
local Tower = require(".app.tower.Tower")
local PassData = require(".app.stageConfig.PassData")

local FightScene = class("FightScene", function(passnum)
	local scene = display.newScene("FightScene")
	scene.pass =  passnum
	return scene
end)

function FightScene:ctor()
	self.monster = {}
	self.way = {}
	self.tower = {}
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
	local pausing = self:spriteCreate("#ui_waveSuspend.png",self.sizeofBG.width*.45,self.sizeofBG.height*.88)
	pausing:hide()

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

	local heroSprite = Hero.new("#h01_move_"..GameState.GameData.HeroNumber..".png",200, 200, self)
	heroSprite:runAction(heroSprite:wait(GameState.GameData.HeroNumber))
	for i,v in ipairs(self.monster) do
		local tx,ty = v:getPosition()
		local distance = cc.pGetDistance(cc.p(x,y),cc.p(tx,ty))
		if distance <= 500 then 
			heroSprite:runAction(heroSprite:move(GameState.GameData.HeroNumber, tx, ty))
			heroSprite:runAction(heroSprite:attack(GameState.GameData.HeroNumber))
		end
	end
	
	local pause = self:buttonCreate("#ui_stop.png",self.sizeofBG.width*.79,self.sizeofBG.height*.88)
	local state = true
	pause:onButtonClicked(function (event)
		if state then			
			pause:setButtonImage(cc.ui.UIPushButton.NORMAL, "#ui_continue.png")
			local director = cc.Director:getInstance():pause()
			pausing:show()
			wavebg:hide()
		else			
			pause:setButtonImage(cc.ui.UIPushButton.NORMAL, "#ui_stop.png")
			local director = cc.Director:getInstance():resume()
			pausing:hide()
			wavebg:show()
		end
		state = not state
	end)
	pause:addTo(self.sprtieBG)

	local setting = self:buttonCreate("#ui_setting.png",self.sizeofBG.width*.86,self.sizeofBG.height*.88)
	setting:onButtonClicked(function (event)
		self:settingUI()
		local director = cc.Director:getInstance():pause()
	end)
	setting:addTo(self.sprtieBG)

	if GameState.GameData.HeroNumber == 1 then
		local skill1 = self:buttonCreate("#skillIcon2.png",self.sizeofBG.width*.6 , self.sizeofBG.height *.1)
		:onButtonClicked(function (event)
			heroSprite:stopAllActions()
			local magic1 = heroSprite:magic1(GameState.GameData.HeroNumber)
			local callback = cc.CallFunc:create(function ()
				heroSprite:runAction(heroSprite:wait(GameState.GameData.HeroNumber))
			end)
			local action = cc.Sequence:create(magic1, callback) 
			heroSprite:runAction(action)
		end)
		skill1:addTo(self.sprtieBG)

		local skill2 = self:buttonCreate("#skillIcon1.png",self.sizeofBG.width*.69 , self.sizeofBG.height *.1)
		skill2:onButtonClicked(function (event)
			heroSprite:stopAllActions()				
			local magic2 = heroSprite:magic12(GameState.GameData.HeroNumber)
			local callback = cc.CallFunc:create(function ()
				heroSprite:runAction(heroSprite:wait(GameState.GameData.HeroNumber))
			end)
			local action = cc.Sequence:create(magic2, callback) 
			heroSprite:runAction(action)
		end)
		skill2:addTo(self.sprtieBG)
	else 
		local skill1 = self:buttonCreate(Tabel[GameState.GameData.HeroNumber]["skill1"],self.sizeofBG.width*.51 , self.sizeofBG.height *.1)
		skill1:onButtonClicked(function (event)

			if GameState.GameData.HeroNumber == 4 then
				local magic1 = heroSprite:magic2(GameState.GameData.HeroNumber)
				local callback = cc.CallFunc:create(function ()
					heroSprite:s12(200,100)
					heroSprite:runAction(heroSprite:wait(GameState.GameData.HeroNumber))
				end)
				local action = cc.Sequence:create(magic1, callback) 
				heroSprite:runAction(action)
			end
		end)
		skill1:addTo(self.sprtieBG)

		local skill2 = display.newSprite(Tabel[GameState.GameData.HeroNumber]["skill2"])
		skill2:setPosition(self.sizeofBG.width*.6 , self.sizeofBG.height *.1)	
		self.sprtieBG:addChild(skill2)
		skill2:setTouchEnabled(true)
		skill2:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)

			if event.name == "began" then
				self.skillPic = display.newSprite(Tabel[GameState.GameData.HeroNumber]["skillPic"])
				:setScale(0.6)
				self.skillPic:setPosition(event.x, event.y)
				self:addChild(self.skillPic)
				return true
			elseif event.name == "moved" then
				self.skillPic:setPosition(event.x, event.y)
			else
				print("···")
				if GameState.GameData.HeroNumber == 2 then
					heroSprite:s05Move(event.x, event.y)
				elseif GameState.GameData.HeroNumber == 3 then
					heroSprite:stopAllActions()
					local skillNow = heroSprite:skill()
					local callback = cc.CallFunc:create(function(event)
						heroSprite:runAction(heroSprite:wait(GameState.GameData.HeroNumber))
						end)
					local seq = cc.Sequence:create(skillNow,callback)
					heroSprite:runAction(seq)
				else
					heroSprite:runAction(heroSprite:bomb(event.x, event.y))
				end
				self.skillPic:removeFromParent()
				self.skillPic = nil
				print("end")
			end			
		end)
	end
		local skill3 = self:buttonCreate(Tabel[GameState.GameData.HeroNumber]["skill3"],self.sizeofBG.width*.69 , self.sizeofBG.height *.1)
		skill3:onButtonClicked(function (event)
			heroSprite:stopAllActions()
			if GameState.GameData.HeroNumber == 3 then
				local magic2 = heroSprite:skill()
				local callback = cc.CallFunc:create(function ()
					heroSprite:runAction(heroSprite:wait(GameState.GameData.HeroNumber))
				end)
				local action = cc.Sequence:create(magic2, callback) 
				heroSprite:runAction(action)				
			elseif GameState.GameData.HeroNumber == 4 then
				heroSprite:runAction(heroSprite:wait(GameState.GameData.HeroNumber))
				heroSprite:bomb(300, 100)
			elseif GameState.GameData.HeroNumber == 2 then
				heroSprite:s05Move(event.x,event.y)
			end
		end)
		skill3:addTo(self.sprtieBG)


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
	self.map = cc.TMXTiledMap:create(PassData["L"..self.pass].map)
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

	local tower = Tower.new(PassData["L"..self.pass].pretower)
	local pretower = self.map:getObjectGroup("objs"):getObject("preTower")
	tower:pos(pretower.x, pretower.y)
	tower:addTo(self.map,3)
	table.insert(self.tower,tower)
	local tower2 = Tower.new(PassData["L"..self.pass].pretower)
	tower2:pos(200,300)
	tower2:addTo(self.map,3)
	table.insert(self.tower,tower2)

	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function (dt)
		if wave<= PassData["L"..self.pass].wave and os.time()-time > PassData["L"..self.pass]["wavetime"..wave] and septum == 0 and num > 0 then
			local monster = self:monsterCreate(PassData["L"..self.pass]["wave"..wave])
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
		for k,v in pairs(self.tower) do
			local x,y = v:getPosition()
			if v.num == "16" or v.num =="18" or v.num == "11" or v.num == "03" then 
			else
				if v.target then
					local tx,ty = v.target:getPosition()
					local distance = cc.pGetDistance(cc.p(x,y),cc.p(tx,ty))
					if distance > v.attackArea then					
						for a,b in pairs(v.target.target) do
							if b == v then
								table.remove(table, a)
							end
						end						
						v.target = nil
					else
						local degree = math.deg(math.asin((ty-y)/distance))
						if tx < x and degree > 0 then
							degree = 180 - degree
						elseif tx < x and degree <= 0 then
							degree = -180 - degree
						end
						v:towerAim(90 - degree)
						v.firetime = v.firetime + 1
						if v.firetime == 30 then
							local bullet = v:fire()
							v.firetime = v.firetime - 30
							bullet:runAction(v:fireAction(tx,ty+10,bullet))
							v.target.Hptag:show()
							v.target.hpnow = v.target.hpnow -  v.power
							v.target.Hptag.hptag:setPercent(v.target.hpnow / v.target.hp *100)
							if v.target.hpnow <= 0 then
								for i,j in pairs(self.monster) do
									if j == v.target then
										for x,y in pairs(v.target.target) do
											y.target = nil
										end
										table.remove(self.monster,i)
										j:dead()
										j:removeFromParent()
										j = nil
									end
								end
								
							end
						end
					end
				else
					for i,j in pairs(self.monster) do
						local tx,ty = j:getPosition()
						local distance = cc.pGetDistance(cc.p(x,y),cc.p(tx,ty))
						if distance <= v.attackArea then 
							v.target = j
							table.insert(j.target,v)						
							break
						end
					end
				end
			end
		end
	end)
	self:scheduleUpdate()
	self:rabbit()
	
	local flag = display.newSprite("#Theme1_EnemyHome.png")
	flag:pos(self.way[1].x, self.way[1].y)
	flag:setAnchorPoint(0.5,0)
	flag:addTo(self.map,1)

	

end

function FightScene:waveLabel1() --波数文字
	local label = cc.ui.UILabel.new({
		UILabelType = 1,
		text = PassData["L"..self.pass].wave,
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
	monster:move(self.way, self.monster,self.rabbit)
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
		local director = cc.Director:getInstance():pause()
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
		local director = cc.Director:getInstance():resume()
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
		local director = cc.Director:getInstance():resume()
	end)

	local restart = self:buttonCreate("#settingRestart.png", settingUIsize.width / 2 , settingUIsize.height * .5)
	restart:addTo(settingBG)
	restart:onButtonClicked(function(event)
		local restart = self.new(self.pass)
		display.replaceScene(restart,"flipX",1)
	end)

	local getback = self:buttonCreate("#settingReturn.png", settingUIsize.width / 2 , settingUIsize.height * .25)
	getback:addTo(settingBG)
	getback:onButtonClicked(function (event)
		local UI = require(".app.scenes.UI")
		local ui = UI.new()
		display.replaceScene(ui,"splitRows",1)
	end)

	local levelnum = display.newSprite("#settingFlag.png")
	levelnum:pos(settingUIsize.width *.2 , settingUIsize.height * 0.88)
	levelnum:addTo(settingBG)
	local flagsize = levelnum:getContentSize()
	local labelpass = cc.ui.UILabel.new({
		UILabelType = 1,
		text = self.pass,
		font = "font/fontLevelButton.fnt"
		})
	:align(1,flagsize.width / 2, flagsize.height / 1.7)
	:addTo(levelnum)
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

function FightScene:rabbit() --兔子
	self.rabbit = display.newSprite("#protectPoint.png")
	self.rabbit:pos(self.way[#self.way].x, self.way[#self.way].y)
	self.rabbit:setAnchorPoint(0.5,0)
	self.rabbit:addTo(self.map,1)
	local sizeR = self.rabbit:getContentSize()

	local rabbitHp = display.newSprite("#blood-1.png")
	rabbitHp:pos(sizeR.width / 2, sizeR.height)
	:addTo(self.rabbit)
	local sizeHp = rabbitHp:getContentSize()

	self.rabbit.Rhplabel = cc.ui.UILabel.new({
		UILabelType = 1,
		text = 10,
		font = "font/fontBlood.fnt"
		}) 
	:align(1, sizeHp.width / 1.6, sizeHp.height /1.9)
	:addTo(rabbitHp)

end

function FightScene:onEnter()

end

function FightScene:onExit()

end
return FightScene