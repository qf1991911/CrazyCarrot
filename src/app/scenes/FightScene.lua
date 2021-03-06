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
display.addSpriteFrames("UI/ui_result.plist","UI/ui_result.png")
local HeroData = require("app.stageConfig.HeroData")
local Hero = require("app.monster.Hero")
local Monster = require("app.monster.Monster")
local Tower = require("app.tower.Tower")
local PassData = require("app.stageConfig.PassData")
local Tabel = require("app.stageConfig.stageLevelInformation")

local FightScene = class("FightScene", function(passnum)
	local scene = display.newScene("FightScene")
	scene.pass =  passnum
	return scene
end)

function FightScene:ctor()
	self.BarrierMark = {}	
	self.monster = {}
	self.way = {}
	self.tower = {}
	self.starnum = 0
	self.gameover = false
	self.heroSprite = nil
	self:fightUI()
	self:fightMap()
	self:buildArea()
	self:HeroCreate()
	self:barrier()


end

function FightScene:fightUI() --战斗场景布局
	self.sprtieBG = display.newSprite("map/Theme"..math.ceil(self.pass/ 10).."/theme"..math.ceil(self.pass/ 10).."Map.png")
	:pos(display.cx, display.cy)
	:addTo(self)
	self.sizeofBG = self.sprtieBG:getContentSize()

	local skillbg = self:spriteCreate("#skillBg.png",self.sizeofBG.width / 2,self.sizeofBG.height / 11)
	skillbg:addTo(self.sprtieBG)
	local moneybg = self:spriteCreate("#ui_moneyBg.png",self.sizeofBG.width*.2,self.sizeofBG.height*.88)
	moneybg:addTo(self.sprtieBG)
	local pausing = self:spriteCreate("#ui_waveSuspend.png",self.sizeofBG.width*.45,self.sizeofBG.height*.88)
	pausing:addTo(self.sprtieBG)
	pausing:hide()

	local wavebg = self:spriteCreate("#ui_waveBg.png",self.sizeofBG.width*.45,self.sizeofBG.height*.88)
	wavebg:addTo(self.sprtieBG)
	local wbgsize = wavebg:getContentSize() 
	local wavelb = self:waveLabel1()
	wavelb:pos(wbgsize.width*.38, wbgsize.height*.45)
	wavelb:addTo(wavebg)
	self.wavelbnow = self:waveLabel1()
	self.wavelbnow:pos(wbgsize.width*.1, wbgsize.height*.45)
	self.wavelbnow:setString(1)
	self.wavelbnow:addTo(wavebg)

	local hero = self:spriteCreate("#taskHeroIcon1.png",self.sizeofBG.width*.78 , self.sizeofBG.height *.11)
	hero:addTo(self.sprtieBG)

	self.mission1 = self:misButtonCreate("#littleTaskIcon4.png",self.sizeofBG.width*.2 , self.sizeofBG.height *.1)
	self.mission2 = self:misButtonCreate("#littleTaskIcon2.png",self.sizeofBG.width*.26 , self.sizeofBG.height *.1)
	self.mission3 = self:misButtonCreate("#littleTaskIcon1.png",self.sizeofBG.width*.32 , self.sizeofBG.height *.1)
	local mission4 = self:spriteCreate("#littleTaskIcon5.png",self.sizeofBG.width*.38 , self.sizeofBG.height *.1)
	mission4:addTo(self.sprtieBG)
	-- 	self.heroSprite = Hero.new("#h01_move_"..GameState.GameData.HeroNumber..".png",200, 200, self.map)
	-- 	self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
	-- 	for i,v in ipairs(self.monster) do
	-- 		local tx,ty = v:getPosition()
	-- 		local distance = cc.pGetDistance(cc.p(x,y),cc.p(tx,ty))
	-- 		if distance <= 200 then 
	-- 			self.heroSprite:runAction(self.heroSprite:move(GameState.GameData.HeroNumber, tx, ty))
	-- 			self.heroSprite:runAction(self.heroSprite:attack(GameState.GameData.HeroNumber))
	-- 			j.Hptag:show()
	-- 			j.hpnow = j.hpnow -  200
	-- 			j.Hptag.hptag:setPercent(j.hpnow / j.hp *100)
	-- 		end
	-- 	end
	
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
	pause:addTo(self.sprtieBG,3)

	local setting = self:buttonCreate("#ui_setting.png",self.sizeofBG.width*.86,self.sizeofBG.height*.88)
	setting:onButtonClicked(function (event)
		self:settingUI()
		local director = cc.Director:getInstance():pause()
	end)
	setting:addTo(self.sprtieBG,3)


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

	self.wave = 1
	local time = os.time()
	local septum = 0
	local num = 15
	self.windmill = {}
	local enemyhome = self:enemyHomePos()
	enemyhome:runAction(self:enemyhomeAction())
	enemyhome:setOpacity(0)
	self.map:setTouchEnabled(true)
	self.map:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
		
		if event.name == "began" then
			self.forbidden = display.newSprite("#forbid.png")
			self.forbidden:setPosition(event.x,event.y)
			self.forbidden:addTo(self)
			if self.map:getChildByTag(999) then
				self.map:getChildByTag(999):removeFromParent()
				self.map:getChildByTag(1000):setOpacity(50)
				self.map:getChildByTag(1000):setTag(1001)
			elseif self.map:getChildByTag(666) then 
				local attackArea = self.map:getChildByTag(666)
				for k,v in pairs(self.tower) do
					if v.attackAreashow == attackArea then
						v.attackAreashow = nil
					end
				end
				attackArea:removeFromParent()
				attackArea = nil
			end
			return true
		elseif event.name == "ended" then
		 	self.forbidden:removeFromParent()
		 	self.forbidden = nil
		end 
	end)

	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function (dt)
		if self.wave <= PassData["L"..self.pass].wave and os.time()-time > PassData["L"..self.pass]["wavetime"..self.wave] and septum == 0 and num > 0 then
			local monster = self:monsterCreate(PassData["L"..self.pass]["wave"..self.wave])
			table.insert(self.monster,monster)
			num = num - 1
			enemyhome:setOpacity(255)
			self.wavelbnow:setString(self.wave)
		end
		if num == 0 then
			enemyhome:setOpacity(0)
			self.wave = self.wave + 1
			num = 15
		end
		septum = (septum + 1) % 60
		for k,v in pairs(self.tower) do
			local x,y = v:getPosition()
			if v.num == "16" or v.num =="18"  then 
				v.firetime = v.firetime + v.stage 
				if v.firetime >= 120 then
					local num = 0
					for i,j in pairs(self.monster) do
						local tx,ty = j:getPosition()
						local distance = cc.pGetDistance(cc.p(x,y),cc.p(tx,ty))
						if distance <= v.attackArea then					
							j.hpnow = j.hpnow -  v.power
							num = num + 1							
						end
					end
					if num > 0 then
						v.firetime = 0
						local bullet = v:fire(1)
						bullet:runAction(v:fireAnimation(bullet,1))
					end
				end
			elseif v.num == "03" then
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
						v.firetime = v.firetime + 1 
						if v.firetime >= 50 then
							local bullet = v:fire2()
							table.insert(self.windmill,bullet)
							bullet.power = (v.power + v.stage)*.1
							bullet.attack = false		
							v.firetime = v.firetime - 50
							local callfun  = cc.CallFunc:create(function (event)
								for q,w in pairs(self.windmill) do
									table.remove(self.windmill,q)
								end								
							end)
							local action = v:fireAction2(tx,ty+10,bullet,1)
							local sq = cc.Sequence:create(action,callfun)
							bullet:runAction(sq)
							
										
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
			elseif v.num == "01" or v.num == "02" then
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
						v.firetime = v.firetime + v.stage 
						if v.firetime >= 30 then
							local bullet = v:fire(0)
							v.firetime = v.firetime - 30
							if v.target.type == "layer" then
								local size = v.target:getContentSize()
								bullet:runAction(v:fireAction(tx,ty+10,bullet,0))
							else
								bullet:runAction(v:fireAction(tx,ty+10,bullet,0))
							end
							v.target.hpnow = v.target.hpnow -  v.power						
						end
					end
				else
					if #self.BarrierMark == 0 then
						for i,j in pairs(self.monster) do
							local tx,ty = j:getPosition()
							local distance = cc.pGetDistance(cc.p(x,y),cc.p(tx,ty))
							if distance <= v.attackArea then 
								v.target = j
								table.insert(j.target,v)						
								break
							end
						end
					else
						for i,j in pairs(self.BarrierMark) do
							local tx,ty = j:getPosition()
							local distance = cc.pGetDistance(cc.p(x,y),cc.p(tx,ty))
							if distance <= v.attackArea then 
								v.target = j
								table.insert(j.target,v)														
								break
							else
								for a,b in pairs(self.monster) do
									local tx,ty = b:getPosition()
									local distance = cc.pGetDistance(cc.p(x,y),cc.p(tx,ty))
									if distance <= v.attackArea then 
										v.target = b
										table.insert(b.target,v)						
										break
									end
								end
							end
						end
					end
				end
			end			
		end
		for k,v in pairs(self.monster) do
			if v.hpnow ~= v.hp then
				v.Hptag:show()
				v.Hptag.hptag:setPercent(v.hpnow / v.hp *100)
			end
			if v.hpnow <= 0 then
				for i,j in pairs(v.target) do
					j.target = nil
				end
				table.remove(self.monster,k)
				v:dead()
				v:removeFromParent()
				v = nil
			end		
		end

		for a,b in pairs(self.windmill) do
			for k,v in pairs(self.monster) do
				local bx,by = b:getPosition()
				local tx,ty = v:getPosition()
				local distance = cc.pGetDistance(cc.p(bx,by),cc.p(tx,ty))
				if distance < 60 then
					v.hpnow = v.hpnow - b.power
				end
			end
		end

		for g,h in pairs(self.BarrierMark) do              
			h.hptag.hptag:setPercent(h.hpnow / h.hp *100)
			if h.hpnow <= 0 then
				for k,v in pairs(h.target) do
					v.target = nil
				end
				local layer = self.map:getLayer("things")
				dump(h.thing)
				for a,b in pairs(h.thing) do
					print(b.i, b.j)
					layer:removeTileAt(cc.p(b.i, b.j))
				end
				h:removeFromParent()
				table.remove(self.BarrierMark,g)
				h = nil
			end
		end
		if self.rabbit.hp <= 0 and self.gameover == false then
			self:result()
			self.gameover = true
		end 

		if os.time() - time > (PassData["L"..self.pass]["wavetime"..PassData["L"..self.pass].wave] + 15) and #self.monster == 0 then
			time = os.time()
			self:success()
			self:unscheduleUpdate()
		end
		self:HeroAttack()
	end)
	self:scheduleUpdate()
	self:rabbit()
	
	local flag = display.newSprite("#Theme1_EnemyHome.png")
	flag:pos(self.way[1].x, self.way[1].y)
	flag:setAnchorPoint(0.5,0)
	flag:addTo(self.map,1)

end
function FightScene:barrier()
	local things = self.map:getLayer("things")
	for i=0,12 do
		for j=0,6 do
			local thing = things:getTileAt(cc.p(i,j))
			-- local gid = things:getTileGIDAt(cc.p(i,j))	
			-- local idx = self.map:getPropertiesForGID(gid)
			-- print(idx)		
			if thing ~= nil then
				thing.number, thing.Barrier = self:checkBarrier(things, i, j)
				thing.i = i
				thing.j = j
				table.insert(thing.Barrier.thing, thing)
				if thing.Barrier.touch ~= true then
					self:barrierTouch(thing)
				end
				-- self:barrierTouch(thing)
				
				-- thing.gid = things:getTileGIDAt(cc.p(i,j))
				-- local idx = self.map:getPropertiesForGID(thing.gid)
				-- if type(idx) == "number" then
				-- 	--left



				-- elseif type(idx) == "table" then
				-- 	local number = math.floor(idx.thingIdx / 100)
				-- end
				-- idx.thingIdx

			-- 	thing.Barrier = display.newSprite("#blankArea.png")
			-- 	thing.Barrier:setOpacity(0)
			-- 	thing.Barrier:pos( 35 + i * 70 ,35 + (6 - j) * 70)
			-- 	thing.Barrier:addTo(self.map,4)
			-- 	local point = self:spriteCreate("#point.png", 35, 60)
			-- 	point:hide()
			-- 	point:addTo(Barrier)
			-- 	thing.Barrier.point = point
			-- 	thing.Barrier.gid = things:getTileGIDAt(cc.p(i,j))
			-- 	local idx = self.map:getPropertiesForGID(Barrier.gid)
			-- 	for k,v in pairs(idx) do
			-- 		thing.Barrier.idx = math.floor(v/100)
			-- 	end
			-- 	thing.Barrier.i = i
			-- 	thing.Barrier.j = j
			-- 	thing.Barrier.target = {}
				
			-- 	thing.Barrier.type = "layer"
			-- 	thing.Barrier:setTouchEnabled(true)
			-- 	thing.Barrier:setTouchSwallowEnabled(true)
			-- 	thing.Barrier:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ()
			-- 		thing.Barrier:setTouchEnabled(false)
			-- 		if thing.Barrier.idx == 0  then
			-- 			local thing2 = things:getTileAt(cc.p(Barrier.i-1,j))
			-- 			local thing3 = things:getTileAt(cc.p(Barrier.i,j+1))
			-- 			local thing4 = things:getTileAt(cc.p(Barrier.i-1,j+1))
			-- 			if thing2.Barrier.idx == 3 then
			-- 				thing.Barrier.hptag = self:thingsBlood(thing.Barrier)
			-- 				thing.Barrier.hp = 2000
			-- 				thing.Barrier.hpnow = 2000
			-- 			end
			-- 			if thing3.Barrier.idx == 2 then
			-- 				thing.Barrier.hptag = self:thingsBlood(thing.Barrier)
			-- 				thing.Barrier.hp = 2000
			-- 				thing.Barrier.hpnow = 2000
			-- 			end
			-- 			if thing2.Barrier.idx == 4 or thing3.Barrier.idx == 4 or thing4.Barrier.idx == 4 then
			-- 				thing.Barrier.hptag = self:thingsBlood(thing.Barrier)
			-- 				thing.Barrier.hp = 3000
			-- 				thing.Barrier.hpnow = 3000
			-- 			end


			-- 		if #self.BarrierMark ~= 0  then
			-- 			for k,v in pairs(self.BarrierMark) do
			-- 				if v == Barrier then 	
			-- 					for i,j in pairs(v.target) do
			-- 						j.target = nil 
			-- 					end
			-- 					v.point:hide()
			-- 					v = nil
			-- 					self.BarrierMark = {}
			-- 				else	
			-- 					for i,j in pairs(v.target) do
			-- 						j.target = nil 
			-- 					end
			-- 					v.point:hide()
			-- 					v = nil
			-- 					Barrier.point:show()								
			-- 					self.BarrierMark = {}																	
			-- 					table.insert(self.BarrierMark,thing.Barrier)	
			-- 				end					
			-- 			end
			-- 		else
			-- 			Barrier.point:show()
			-- 			table.insert(self.BarrierMark,thing.Barrier)
			-- 		end
			-- 		print(i,j)
			-- 		Barrier:setTouchEnabled(true)
			-- 	end)
			end
		end
	end
end

function FightScene:checkBarrier(things, i, j)
	local thing = things:getTileAt(cc.p(i,j))
	if nil == thing then
		return 0
	end
	thing.gid = things:getTileGIDAt(cc.p(i,j))
	local idx = self.map:getPropertiesForGID(thing.gid)
	local number = 0
	-- thing.Barrier = nil
	if type(idx) == "number" then	
		--left
		if number == 0 and (i - 1) >= 0 then
			number, thing.Barrier = self:checkBarrier(things, i - 1, j)
		end
		--down
		if number == 0 and (j + 1) <= 6 then
			number, thing.Barrier = self:checkBarrier(things, i, j + 1)
		end
		--leftdown
		if number == 0 and (j + 1) <= 6 and (i - 1) >= 0 then
			number, thing.Barrier = self:checkBarrier(things, i - 1, j + 1)
		end
	elseif type(idx) == "table" then
		number = math.floor(idx.thingIdx / 100)
		if nil == thing.Barrier then
			thing.Barrier = display.newSprite("#blankArea.png")
			thing.Barrier:setScaleX(math.ceil(number / 2))
			thing.Barrier:setScaleY(2 - number % 2)
			thing.Barrier:setOpacity(0)
			thing.Barrier:pos( 35 + (i + math.ceil(number / 2) / 2 - 0.5) * 70 ,35 + ((6 - j) + (2 - number % 2) / 2 - 0.5) * 70)
			thing.Barrier:addTo(self.map,4)
			thing.Barrier.hp = number*1000
			thing.Barrier.hpnow = number*1000
			thing.Barrier.target = {}
			thing.Barrier.i = i
			thing.Barrier.j = j
			thing.Barrier.thing = {}
		end
	end

	return number, thing.Barrier
end

function FightScene:barrierTouch(thing)
	-- print(thing.number, thing.Barrier)
	thing.Barrier.touch = true
	thing.Barrier.hptag = self:thingsBlood(thing)
	thing.Barrier.hptag:hide()
	thing.Barrier:setTouchEnabled(true)
	thing.Barrier:setTouchSwallowEnabled(true)
	thing.Barrier:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ()
		thing.Barrier.hptag:show()
		print("chumo")
		-- thing.Barrier:setTouchEnabled(false)
		if #self.BarrierMark ~= 0  then
			for k,v in pairs(self.BarrierMark) do
				if v == thing.Barrier then 	
					for i,j in pairs(v.target) do
						j.target = nil 
					end
					-- v.point:hide()
					v = nil
					self.BarrierMark = {}
					
				else	
					for i,j in pairs(v.target) do
						j.target = nil 
					end
					-- v.point:hide()
					v = nil
					-- Barrier.point:show()								
					self.BarrierMark = {}																	
					table.insert(self.BarrierMark,thing.Barrier)	
				end					
			end
		else
			table.insert(self.BarrierMark,thing.Barrier)
		end
		-- thing.Barrier:setTouchEnabled(true)
	end)
end

function FightScene:thingsBlood(thing)
	local sprite = display.newSprite("#hpBar_bg.png")
	:pos(35	,70)
	:addTo(thing.Barrier)
	sprite:setScaleX(1 / math.ceil(thing.number / 2))
	sprite:setScaleY(1 / (2 - thing.number % 2))
	sprite.hptag = cc.ui.UILoadingBar.new({
		scale9 = true,
		capInsets = cc.rect(0, 0, 50, 10),
		image = "#hpBar_front.png",
		viewRect = cc.rect(0, 0, 50, 10),
		percent = 100,
		direction = DIRECTION_RIGHT_TO_LEFT
		})
	:addTo(sprite)
	-- sprite:hide()
	return sprite
end
-- function FightScene:judge()
-- 	if Barrier.gid == 1 then 
-- 		Barrier.hp = 3000
-- 		Barrier.hptag:setPosition(70,70)
-- 		local Barrier2 = things:getTileAt(cc.p(Barrier.i+1,j))
-- 		Barrier2.point:hide()
-- 		Barrier2.hatag:hide()
-- 		local Barrier3 = things:getTileAt(cc.p(Barrier.i+1,j+1))
-- 		Barrier3.point:hide()
-- 		Barrier3.hatag:hide()
-- 		local Barrier4 = things:getTileAt(cc.p(Barrier.i,j+1))
-- 		Barrier4.point:hide()
-- 		Barrier4.hatag:hide()
-- 	elseif Barrier.gid == 2 then
-- 		Barrier.hp = 3000
-- 		Barrier.hptag:setPosition(0,70)
-- 		local Barrier2 = things:getTileAt(cc.p(Barrier.i-1,j))
-- 		Barrier2.point:hide()
-- 		Barrier2.hatag:hide()
-- 		local Barrier3 = things:getTileAt(cc.p(Barrier.i-1,j+1))
-- 		Barrier3.point:hide()
-- 		Barrier3.hatag:hide()
-- 		local Barrier4 = things:getTileAt(cc.p(Barrier.i,j+1))
-- 		Barrier4.point:hide()
-- 		Barrier4.hatag:hide()
-- 	elseif Barrier.gid == 8 then
-- 		Barrier.hp = 3000
-- 		Barrier.hptag:setPosition(70,140)
-- 		local Barrier2 = things:getTileAt(cc.p(Barrier.i,j-1))
-- 		Barrier2.point:hide()
-- 		Barrier2.hatag:hide()
-- 		local Barrier3 = things:getTileAt(cc.p(Barrier.i+1,j-1))
-- 		Barrier3.point:hide()
-- 		Barrier3.hatag:hide()
-- 		local Barrier4 = things:getTileAt(cc.p(Barrier.i+1,j))
-- 		Barrier4.point:hide()
-- 		Barrier4.hatag:hide()
-- 	elseif Barrier.gid == 9 then
-- 		Barrier.hp = 3000
-- 		Barrier.hptag:setPosition(0,140)
-- 		local Barrier2 = things:getTileAt(cc.p(Barrier.i-1,j-1))
-- 		Barrier2.point:hide()
-- 		Barrier2.hatag:hide()
-- 		local Barrier3 = things:getTileAt(cc.p(Barrier.i,j-1))
-- 		Barrier3.point:hide()
-- 		Barrier3.hatag:hide()
-- 		local Barrier4 = things:getTileAt(cc.p(Barrier.i-1,j))
-- 		Barrier4.point:hide()
-- 		Barrier4.hatag:hide()
-- 	end
-- end
-- function FightScene:jugde2()
-- 	if Barrier.gid == 3 or Barrier.gid == 4 then
-- 		Barrier.hp = 2000
-- 		local Barrier2 = things:getTileAt(cc.p(Barrier.i,j+1))
-- 		Barrier2.point:hide()
-- 		Barrier2.hatag:hide()
-- 	elseif Barrier.gid == 10 or Barrier.gid == 11 then
-- 		Barrier.hp = 2000
-- 		Barrier.hptag:setPosition(35,140)
-- 		local Barrier2 = things:getTileAt(cc.p(Barrier.i,j-1))
-- 		Barrier2.point:hide()
-- 		Barrier2.hatag:hide()
-- 	end
-- end

-- function FightScene:judge3()
-- 	if Barrier.gid == 5 or Barrier.gid == 12 then
-- 		Barrier.hp = 2000
-- 		Barrier.hptag:setPosition(70,70)
-- 		local Barrier2 = things:getTileAt(cc.p(Barrier.i+1,j))
-- 		Barrier2.point:hide()
-- 		Barrier2.hatag:hide()
-- 	elseif Barrier.gid == 6 or Barrier.gid == 13 then
-- 		Barrier.hp = 2000
-- 		Barrier.hptag:setPosition(0,70)
-- 		local Barrier2 = things:getTileAt(cc.p(Barrier.i-1,j))
-- 		Barrier2.point:hide()
-- 		Barrier2.hatag:hide()
-- 	end
-- end

function FightScene:HeroCreate()
	self.heroSprite = Hero.new("#h01_move_"..GameState.GameData.HeroNumber..".png",200, 200, self.map)
	self.heroSprite:setLocalZOrder(2)
	self.heroSprite:setAnchorPoint(0.5,0.2)
	self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
	
	--英雄技能创建
		if GameState.GameData.HeroNumber == 1 then
			
			local skill1 = self:buttonCreate("#skillIcon2.png",self.sizeofBG.width*.6 , self.sizeofBG.height *.1)
			:onButtonClicked(function (event)
				self.heroSprite.state = "skill"
				self.heroSprite:stopAllActions()
				local magic1 = self.heroSprite:magic1(GameState.GameData.HeroNumber,self.monster)
				local callback = cc.CallFunc:create(function ()
					self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
				end)
				local action = cc.Sequence:create(magic1, callback) 
				self.heroSprite:runAction(action)
			end)
			skill1:addTo(self.sprtieBG)

			local skill2 = self:buttonCreate("#skillIcon1.png",self.sizeofBG.width*.69 , self.sizeofBG.height *.1)
			skill2:onButtonClicked(function (event)	
				self.heroSprite.state = "skill"		
				self.heroSprite:stopAllActions()
				local x,y = self.heroSprite:getPosition()
				self.heroSprite:runAction(self.heroSprite:magic12(GameState.GameData.HeroNumber,x,y,self.monster))
			end)
			skill2:addTo(self.sprtieBG)
		else
	--英雄二三四的技能	
	--**技能一**--	
			local skill1 = self:buttonCreate(HeroData[GameState.GameData.HeroNumber]["skill1"],self.sizeofBG.width*.51 , self.sizeofBG.height *.1)
			skill1:onButtonClicked(function (event)
				self.heroSprite:stopAllActions()
				if GameState.GameData.HeroNumber == 4 then
					self.heroSprite.state = "skill"
					self.heroSprite:s12_wing()

				elseif GameState.GameData.HeroNumber == 3 then
					self.heroSprite.state = "skill"
					local magic2 = self.heroSprite:skill(self.monster)
					local callback = cc.CallFunc:create(function ()
						self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
					end)
					local action = cc.Sequence:create(magic2, callback) 
					self.heroSprite:runAction(action)	
				elseif GameState.GameData.HeroNumber == 2 then
					self.heroSprite.state = "skill"
					self.heroSprite:runAction(self.heroSprite:s02(GameState.GameData.HeroNumber))

				end
			end)
			skill1:addTo(self.sprtieBG)
	--**技能二**--
			local skill2 = display.newSprite(HeroData[GameState.GameData.HeroNumber]["skill2"],self.sizeofBG.width*.6 , self.sizeofBG.height *.1)
			skill2:setPosition(self.sizeofBG.width*.6 , self.sizeofBG.height *.1)	
			self.sprtieBG:addChild(skill2)
			skill2:setTouchEnabled(true)
			skill2:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)

				if event.name == "began" then
					self.skillPic = display.newSprite(HeroData[GameState.GameData.HeroNumber]["skillPic"])
					:setScale(0.6)
					self.skillPic:setPosition(event.x, event.y)
					self:addChild(self.skillPic)
					return true
				elseif event.name == "moved" then
					self.skillPic:setPosition(event.x, event.y)
				elseif event.name == "ended" then
					if  event.y < self.sizeofBG.height * 0.1 + 41 then
						self.skillPic:removeFromParent()
						self.skillPic = nil
						return
					else
	--英雄二
						if GameState.GameData.HeroNumber == 2 then
						self.heroSprite.state = "skill"
						-- self.heroSprite:stopAllActions()
						-- self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))					
						self.heroSprite:s05Move(event.x, event.y,self.monster)
						
	--英雄三
						elseif GameState.GameData.HeroNumber == 3 then
							self.heroSprite.state = "skill"
							self.heroSprite:stopAllActions()
							local posx, posy = self.heroSprite:getPosition()
							local distance = math.sqrt((event.x - posx)^2 + (event.y - posy)^2)
							local Dx = event.x - posx
							local Dy = event.y - posy
							if event.x > posx and self.heroSprite.face == "left" then
								local FlipX = cc.FlipX:create(true)
								self.heroSprite:runAction(FlipX)
								self.heroSprite.face = "right"
							elseif event.x < posx and self.heroSprite.face == "right" then
								local FlipX = cc.FlipX:create(false)
								self.heroSprite:runAction(FlipX)
								self.heroSprite.face = "left"
							end
							local angle = 0
							if event.x < posx then
								angle = math.deg(math.asin(Dy / distance))
							elseif event.x > posx then
								angle = math.deg(math.asin(-Dy / distance))
							end
							local skillNow = self.heroSprite:lightLine(event.x, event.y, angle, self.monster)
							print(self.heroSprite.face)
							self.heroSprite:runAction(skillNow)
	--英雄四
						else
							local boom = self.heroSprite:bomb(event.x-20, event.y- 70)
							boom:schedule(function()

								-- if self.monster then
								for k,v in pairs(self.monster) do
									local vx,vy = v:getPosition()
									local distance = cc.pGetDistance(cc.p(vx,vy), cc.p(event.x-20, event.y- 70))
									print(distance)
									if 	distance <= 50 then
										v.hpnow = v.hpnow -  80
										self.heroSprite:bombExplode(event.x-20, event.y- 70)
										self.heroSprite.state = "wait"
										boom:removeFromParent()
									end
								end						
							end, 0.1)					
						end
						self.skillPic:removeFromParent()
						self.skillPic = nil					
					end	
				end		
			end)

	--**技能三**--
			local skill3 = self:buttonCreate(HeroData[GameState.GameData.HeroNumber]["skill3"],self.sizeofBG.width*.69 , self.sizeofBG.height *.1)

			skill3:onButtonClicked(function (event)
				self.heroSprite:stopAllActions()
				if GameState.GameData.HeroNumber == 3 then
					self.heroSprite.state = "skill"
					local magic2 = self.heroSprite:skill(self.monster)
					local callback = cc.CallFunc:create(function ()
						self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
					end)
					local action = cc.Sequence:create(magic2, callback) 
					self.heroSprite:runAction(action)				
				elseif GameState.GameData.HeroNumber == 4 then
					self.heroSprite.state = "skill"
					local magic1 = self.heroSprite:magic2(GameState.GameData.HeroNumber)
					local callback = cc.CallFunc:create(function ()
						self.heroSprite:s12(display.cx, display.cy, self.monster)
						self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))						
					end)
					local action = cc.Sequence:create(magic1, callback) 
					self.heroSprite:runAction(action)
				elseif GameState.GameData.HeroNumber == 2 then
					self.heroSprite.state = "skill"
					self.heroSprite:s01(self.monster)
				end
			end)
			skill3:addTo(self.sprtieBG)
		end
end

function FightScene:HeroAttack()
	if self.heroSprite.target == nil then
		for k,v in pairs(self.monster) do
			local mX, mY = v:getPosition()
			local x, y = self.heroSprite:getPosition()
			local distance = cc.pGetDistance(cc.p(mX, mY), cc.p(x, y))
			if distance <= 80 then
				self.heroSprite:setPosition(mX, mY)
				self.heroSprite.target = v
				table.insert(v.target, self.heroSprite)
				v:stopAllActions()
				local x, y = v:getPosition()
				local posx, posy = self.heroSprite:getPosition()
				if x > posx and self.heroSprite.face == "left" then
					local FlipX = cc.FlipX:create(true)
					self.heroSprite:runAction(FlipX)
					self.heroSprite.face = "right"
				elseif x < posx and self.heroSprite.face == "right" then
					local FlipX = cc.FlipX:create(false)
					self.heroSprite:runAction(FlipX)
					self.heroSprite.face = "left"
				end
				break
			end
		end
	elseif self.heroSprite.target and self.heroSprite.state == "wait" then
		self.heroSprite.state = "attack"
		-- print(self.heroSprite.state)
		local attack = self.heroSprite:attack(GameState.GameData.HeroNumber)
		local callBack = cc.CallFunc:create(function()
			if self.heroSprite.target then
				-- print(self.heroSprite.state)
				self.heroSprite.target.hpnow = self.heroSprite.target.hpnow - 50
				self.heroSprite.state = "wait"
			end
		end)
		local action = cc.Sequence:create(attack, callBack)
		self.heroSprite:runAction(action)
	end
end


function FightScene:buildArea() --炮塔建造区域

	local way = self.map:getLayer("content")
	local blankAreaTable = {}
	for i=1,11 do
		for j=0,6 do 
			local tile = way:getTileAt(cc.p(i,j))
			if tile == nil then			
				local blankArea = display.newSprite("#blankArea.png")
				blankArea.j = j
				blankArea:pos(35 + i * 70 , 35 + (6 - j) * 70)
				blankArea.pos = cc.p(35 + i * 70 , 35 + (6 - j) * 70)
				blankArea:addTo(self.map,2)
				blankArea:setTouchEnabled(true)
				blankArea:setOpacity(50)
				table.insert(blankAreaTable,blankArea)
				blankArea:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
					for k,v in pairs(self.tower) do
						v:setTouchEnabled(true)
						if v.attackAreashow ~= nil then
							print(v.attackAreashow)
							v.attackAreashow:removeFromParent()
							v.attackAreashow = nil
						end
					end
					blankArea:setOpacity(255)
					if event.name == "began" then 
						if self.map:getChildByTag(999) then
							self.map:getChildByTag(999):removeFromParent()
							self.map:getChildByTag(1000):setOpacity(50)
							self.map:getChildByTag(1000):setTag(1001)
						end
						local buildlist = display.newNode()
						buildlist:pos(35 + i * 70 , 35 + (6 - j) * 70)
						buildlist:addTo(self.map,5)
						buildlist:setTag(999)
						blankArea:setTag(1000)

						local A = #Tabel["weapon"][self.pass]
						for k=1,A do
							local towericon =  display.newSprite(Tabel["weapon"][self.pass][k])
							if blankArea.j == 0 then
							 -- towericon:pos(40 * (2 * ((k - 1) % 3 + 1) - 1 - (A > 2 and 3 or A)), -70 - math.floor(k / 4) * 80)
								towericon:pos(40 * (2 * ((k - 1) % 3) - ((A > 2 and 3 or A) - 1) % 3), -70 - math.floor(k / 4) * 80)
							else	
								towericon:pos(40 * (2 * ((k - 1) % 3) - ((A > 2 and 3 or A) - 1) % 3), 105 + math.floor(k / 4) * 80)
							end
							towericon:addTo(buildlist,2)
							local towericonsize = towericon:getContentSize()
							towericon:setTouchEnabled(true)
							towericon:setTouchSwallowEnabled(true)
							towericon:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)

								local tnum = string.sub(Tabel["weapon"][self.pass][k],11,11)
								local tnum1 = string.sub(Tabel["weapon"][self.pass][k],12,12)
								local str = (tnum1 == ".") and ("0" .. tnum) or (tnum .. tnum1)
								local tower = Tower.new(str,self.tower,blankArea)
								local bX,bY = buildlist:getPosition()
								tower:pos(bX,bY)
								tower:addTo(self.map,4)
								table.insert(self.tower,tower)
								blankArea:setTouchEnabled(false)
								self.map:getChildByTag(999):removeFromParent()
								blankArea:setOpacity(0)
							end)

							local cost = display.newSprite("#fortMoneyBg.png")
							cost:pos(towericonsize.width / 2, 0)
							:addTo(towericon)
							local costsize = cost:getContentSize()

							local costLabel = cc.ui.UILabel.new({
								UILabelType = 1,
								text = 100,
								font = "font/fontFortMoney.fnt"
								})
							:align(1, costsize.width *0.65,costsize.height * 0.35)
							:addTo(cost)

						end
						return true 
					end
				end)
			end
		end
	end
	local pretower = self.map:getObjectGroup("objs"):getObject("preTower")
	table.nums(pretower)
	if table.nums(pretower) ~= 0 then
		for k,v in pairs(blankAreaTable) do
			local offsetX = math.abs(v.pos.x - pretower.x)
			local offsetY = math.abs(v.pos.y - pretower.y)
			if offsetX + offsetY < 70 then
				local tower = Tower.new(PassData["L"..self.pass].pretower,self.tower,v)
				tower:pos(pretower.x, pretower.y)
				tower:addTo(self.map,4)
				table.insert(self.tower,tower)
			end
		end
	end
	
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
		local director = cc.Director:getInstance():resume()
		local restart = self.new(self.pass)
		display.replaceScene(restart,"flipX",1)
	end)

	local getback = self:buttonCreate("#settingReturn.png", settingUIsize.width / 2 , settingUIsize.height * .25)
	getback:addTo(settingBG)
	getback:onButtonClicked(function (event)
		local director = cc.Director:getInstance():resume()
		local UI = require("app.scenes.UI")
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
	self.rabbit.hp = 10
	local sizeR = self.rabbit:getContentSize()

	local rabbitHpBg = display.newSprite("#blood-1.png")
	rabbitHpBg:pos(sizeR.width / 2, sizeR.height)
	:addTo(self.rabbit)
	local sizeHp = rabbitHpBg:getContentSize()
	self.rabbit.Rhplabel = cc.ui.UILabel.new({
		UILabelType = 1,
		text = self.rabbit.hp,
		font = "font/fontBlood.fnt"
		}) 
	:align(1, sizeHp.width / 1.6, sizeHp.height /1.9)
	:addTo(rabbitHpBg)
end
function FightScene:result() -- 2元复活
	local director = cc.Director:getInstance():pause()
	local BGlayer = display.newColorLayer(cc.c4b(0, 0, 0, 80))
	BGlayer:pos(0,0)
	BGlayer:addTo(self)
	BGlayer:setTouchEnabled(true)
	BGlayer:setTouchSwallowEnabled(true)
	BGlayer:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
		if event.name == "began" then
			return true
		end
	end)
	local sizeoflayer = BGlayer:getContentSize()

	local revive = display.newSprite("#rebornLayerBG.png")
	revive:pos(sizeoflayer.width / 2, sizeoflayer.height / 2)
	revive:addTo(BGlayer)
	local sizeofRevive = revive:getContentSize()

	local surebutton = self:buttonCreate("#buttonSure.png",sizeofRevive.width / 2, sizeofRevive.height / 3.5)
	surebutton:addTo(revive)
	surebutton:onButtonClicked(function (event)
		local director = cc.Director:getInstance():resume()
		BGlayer:removeFromParent()
		BGlayer = nil
		self.rabbit.hp = 10
		self.rabbit.Rhplabel:setString(self.rabbit.hp)
		self.gameover = false
	end)

	local canclebutton = self:buttonCreate("#buttonCancel.png",sizeofRevive.width*.9, sizeofRevive.height*.9)
	canclebutton:addTo(revive)
	canclebutton:onButtonClicked(function (event)
		local director = cc.Director:getInstance():resume()
		BGlayer:removeFromParent()
		BGlayer = nil
		self:fail()
	end)
end
function FightScene:fail() --失败界面
	local director = cc.Director:getInstance():pause()
	local BGlayer = display.newColorLayer(cc.c4b(0, 0, 0, 80))
	BGlayer:pos(0,0)
	BGlayer:addTo(self)
	BGlayer:setTouchEnabled(true)
	BGlayer:setTouchSwallowEnabled(true)
	BGlayer:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
		if event.name == "began" then
			return true
		end
	end)
	local sizeoflayer = BGlayer:getContentSize()

	local heroFail = self:spriteCreate("#resultFailHero4.png",sizeoflayer.width / 2, sizeoflayer.height / 1.38)
	heroFail:addTo(BGlayer,10)
	local failPic = self:spriteCreate("#resultFailPic.png",sizeoflayer.width / 2,sizeoflayer.height /2.4)
	failPic:addTo(BGlayer,11)
	local sizeofPic = failPic:getContentSize()
	local zai1 = self:spriteCreate("#failTitle1.png",sizeofPic.width / 4,sizeofPic.height /1.3)
	zai1:addTo(failPic,12)
	local jie = self:spriteCreate("#failTitle2.png",sizeofPic.width / 2.3,sizeofPic.height /1.1)
	jie:addTo(failPic,12)
	local zai2 = self:spriteCreate("#failTitle3.png",sizeofPic.width / 1.6,sizeofPic.height /1.1)
	zai2:addTo(failPic,12)
	local li = self:spriteCreate("#failTitle4.png",sizeofPic.width / 1.25,sizeofPic.height /1.3)
	li:addTo(failPic,12)

	local label = cc.ui.UILabel.new({
		text = "第 "..self.pass.." 关",
		size = 20
		}) 
	label:align(1, sizeofPic.width / 2, sizeofPic.height/1.4)
	label:addTo(failPic)

	local backButton = self:buttonCreate("#resultAgain.png",sizeofPic.width*0.2,0)
	backButton:addTo(failPic)
	backButton:onButtonClicked(function (event)
		local director = cc.Director:getInstance():resume()
		local restart = self.new(self.pass)
		display.replaceScene(restart,"flipX",1)
	end)

	local continueButton = self:buttonCreate("#resultContinue.png",sizeofPic.width*0.8,0)
	continueButton:addTo(failPic)
	continueButton:onButtonClicked(function (event)
		local director = cc.Director:getInstance():resume()
		local UI = require("app.scenes.UI")
		local ui = UI.new()
		display.replaceScene(ui,"splitRows",1)
	end)
	-- local scaleSprite = ccui.Scale9Sprite
	-- local tips = scaleSprite:createWithSpriteFrameName("failTipBg.png",cc.rect(0,0,200,50))
	local tips = self:spriteCreate("#failTipBg.png",sizeofPic.width / 2,sizeofPic.height /2.5)
	tips:setScaleX(4)
	tips:setScaleY(2)
	tips:addTo(failPic)
	local light = self:spriteCreate("#failLight.png",sizeofPic.width / 3,sizeofPic.height /2)
	light:addTo(failPic,1)

	local label2 = cc.ui.UILabel.new({
		text = "提示:升级英雄可\n以使英雄变得更强大！",
		size = 20,
		align = cc.TEXT_ALIGNMENT_CENTER
		})
	label2:align(1, sizeofPic.width / 1.95,sizeofPic.height /2.3)
	label2:addTo(failPic,1)

end
function FightScene:success() --过关界面
	local BGlayer = display.newColorLayer(cc.c4b(0, 0, 0, 80))
	BGlayer:pos(0,0)
	BGlayer:addTo(self)
	BGlayer:setTouchEnabled(true)
	BGlayer:setTouchSwallowEnabled(true)
	BGlayer:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
		if event.name == "began" then
			return true
		end
	end)
	local sizeoflayer = BGlayer:getContentSize()
	local herosuccess = self:spriteCreate("#resultWinHero4.png",sizeoflayer.width / 2, sizeoflayer.height / 1.38)
	herosuccess:addTo(BGlayer,10)

	local successPic = self:spriteCreate("#resultBgPic.png",sizeoflayer.width / 2,sizeoflayer.height /2.4)
	successPic:addTo(BGlayer,11)
	local sizeofPic = successPic:getContentSize()

	local label = cc.ui.UILabel.new({
		text = "第 "..self.pass.." 关",
		size = 20
		}) 
	label:align(1, sizeofPic.width / 2, sizeofPic.height/1.75)
	label:addTo(successPic)

	local backButton = self:buttonCreate("#resultAgain.png",sizeofPic.width*0.2,0)
	backButton:addTo(successPic)
	backButton:onButtonClicked(function (event)
		local restart = self.new(self.pass)
		display.replaceScene(restart,"flipX",1)
	end)

	local continueButton = self:buttonCreate("#resultContinue.png",sizeofPic.width*0.8,0)
	continueButton:addTo(successPic)
	continueButton:onButtonClicked(function (event)
		local UI = require("app.scenes.UI")
		local ui = UI.new()
		display.replaceScene(ui,"splitRows",1)
	end)

	local lightRound = self:spriteCreate("#resultroundLight.png", sizeoflayer.width / 2, sizeoflayer.height / 1.85)
	lightRound:setScale(2.5)
	lightRound:addTo(BGlayer,8)
	local rotate = cc.RotateBy:create(0.5,30)
	local rep = cc.RepeatForever:create(rotate)
	lightRound:runAction(rep)

	local particle = cc.ParticleSystemQuad:create("particle/particlestar.plist")
	local batch = cc.ParticleBatchNode:createWithTexture(particle:getTexture())
	particle:addTo(batch)
	batch:addTo(BGlayer,9)
	particle:pos(sizeoflayer.width / 2, sizeoflayer.height / 1.2)
	particle:setTotalParticles(30)

	local purpleLight = self:spriteCreate("#resultpurpleLight.png",sizeoflayer.width / 2, sizeoflayer.height / 1.85)
	purpleLight:setScale(2.5)
	purpleLight:addTo(BGlayer,7)

	local moneyget = self:spriteCreate("#resultMoneyBg.png",sizeofPic.width*0.48,sizeofPic.height *0.18)
	moneyget:addTo(successPic)
	local sizeofM = moneyget:getContentSize()

	local label2 = cc.ui.UILabel.new({
		text = "本关获得金币 132",
		size = 20,
		})
	label2:align(1, sizeofM.width / 1.6, sizeofM.height / 2)
	label2:addTo(moneyget)
	 
	local starright = self:spriteCreate("#starRight.png", sizeofPic.width*0.68,sizeofPic.height *0.68)
	starright:addTo(successPic)
	starright:hide()
	local starmid = self:spriteCreate("#starMid.png", sizeofPic.width*0.5,sizeofPic.height *0.71)
	starmid:addTo(successPic)
	starmid:hide()
	local starleft = self:spriteCreate("#starLeft.png", sizeofPic.width*0.31,sizeofPic.height *0.68)
	starleft:addTo(successPic)
	starleft:hide()
	if self.rabbit.hp < 3 then
		starleft:show()
		self.starnum = 1
	elseif self.rabbit.hp >= 3 and self.rabbit.hp < 10 then
		starleft:show()
		starmid:show()
		self.starnum = 2
	else 
		starleft:show()
		starmid:show()
		starright:show()
		self.starnum = 3
	end
	local taskPic = self:spriteCreate(Tabel["taskItempic"][self.pass][1], sizeofPic.width*0.35,sizeofPic.height *0.35)
	taskPic:setScale(0.55)
	taskPic:addTo(successPic)
	local taskPic2 = self:spriteCreate(Tabel["taskItempic"][self.pass][2], sizeofPic.width*0.45,sizeofPic.height *0.35)
	taskPic2:setScale(0.55)
	taskPic2:addTo(successPic)
	local taskPic3 = self:spriteCreate(Tabel["taskItempic"][self.pass][3], sizeofPic.width*0.55,sizeofPic.height *0.35)
	taskPic3:setScale(0.55)
	taskPic3:addTo(successPic)
	local taskPic4 = self:spriteCreate("#taskThingIcon.png", sizeofPic.width*0.65,sizeofPic.height *0.35)
	taskPic4:setScale(0.55)
	taskPic4:addTo(successPic)

end
function FightScene:onEnter()

end

function FightScene:onExit()

end
return FightScene