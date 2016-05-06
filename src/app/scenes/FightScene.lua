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
local HeroData = require(".app.stageConfig.HeroData")
local Hero = require(".app.monster.Hero")
local Monster = require(".app.monster.Monster")
local Tower = require(".app.tower.Tower")
local PassData = require(".app.stageConfig.PassData")
local Tabel = require(".app.stageConfig.stageLevelInformation")

local FightScene = class("FightScene", function(passnum)
	local scene = display.newScene("FightScene")
	scene.pass =  passnum
	return scene
end)

function FightScene:ctor()
	self.monster = {}
	self.way = {}
	self.tower = {}
	self.heroSprite = nil
	self:fightUI()
	self:fightMap()
	self:buildArea()
	self:HeroCreate()
end

function FightScene:fightUI() --战斗场景布局
	self.sprtieBG = display.newSprite("map/Theme1/theme1Map.png")
	:pos(display.cx, display.cy)
	:addTo(self)
	self.sizeofBG = self.sprtieBG:getContentSize()

	local skillbg = self:spriteCreate("#skillBg.png",self.sizeofBG.width / 2,self.sizeofBG.height / 11)

	local moneybg = self:spriteCreate("#ui_moneyBg.png",self.sizeofBG.width*.2,self.sizeofBG.height*.88)
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
	pause:addTo(self.sprtieBG)

	local setting = self:buttonCreate("#ui_setting.png",self.sizeofBG.width*.86,self.sizeofBG.height*.88)
	setting:onButtonClicked(function (event)
		self:settingUI()
		local director = cc.Director:getInstance():pause()
	end)
	setting:addTo(self.sprtieBG)
-- --英雄技能创建
-- 	if GameState.GameData.HeroNumber == 1 then
		
-- 		local skill1 = self:buttonCreate("#skillIcon2.png",self.sizeofBG.width*.6 , self.sizeofBG.height *.1)
-- 		:onButtonClicked(function (event)
-- 			self.heroSprite:stopAllActions()
-- 			local magic1 = self.heroSprite:magic1(GameState.GameData.HeroNumber)
-- 			local callback = cc.CallFunc:create(function ()
-- 				self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
-- 			end)
-- 			local action = cc.Sequence:create(magic1, callback) 
-- 			self.heroSprite:runAction(action)
-- 		end)
-- 		skill1:addTo(self.sprtieBG)

-- 		local skill2 = self:buttonCreate("#skillIcon1.png",self.sizeofBG.width*.69 , self.sizeofBG.height *.1)
-- 		skill2:onButtonClicked(function (event)			
-- 			self.heroSprite:stopAllActions()
-- 			self.heroSprite:runAction(self.heroSprite:magic12(GameState.GameData.HeroNumber,190, 160))
-- 		end)
-- 		skill2:addTo(self.sprtieBG)
-- 	else
-- --英雄二三四的技能	
-- --**技能一**--	
-- 		local skill1 = self:buttonCreate(HeroData[GameState.GameData.HeroNumber]["skill1"],self.sizeofBG.width*.51 , self.sizeofBG.height *.1)
-- 		skill1:onButtonClicked(function (event)
-- 			self.heroSprite:stopAllActions()
-- 			if GameState.GameData.HeroNumber == 4 then
-- 				self.heroSprite:s12_wing()
-- 			elseif GameState.GameData.HeroNumber == 3 then
-- 				local magic2 = self.heroSprite:skill()
-- 				local callback = cc.CallFunc:create(function ()
-- 					self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
-- 				end)
-- 				local action = cc.Sequence:create(magic2, callback) 
-- 				self.heroSprite:runAction(action)	
-- 			elseif GameState.GameData.HeroNumber == 2 then
-- 				self.heroSprite:runAction(self.heroSprite:s02(GameState.GameData.HeroNumber))

-- 			end
-- 		end)
-- 		skill1:addTo(self.sprtieBG)
-- --**技能二**--
-- 		local skill2 = display.newSprite(HeroData[GameState.GameData.HeroNumber]["skill2"],self.sizeofBG.width*.6 , self.sizeofBG.height *.1)
-- 		skill2:setPosition(self.sizeofBG.width*.6 , self.sizeofBG.height *.1)	
-- 		self.sprtieBG:addChild(skill2)
-- 		skill2:setTouchEnabled(true)
-- 		skill2:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)

-- 			if event.name == "began" then
-- 				self.skillPic = display.newSprite(HeroData[GameState.GameData.HeroNumber]["skillPic"])
-- 				:setScale(0.6)
-- 				self.skillPic:setPosition(event.x, event.y)
-- 				self:addChild(self.skillPic)
-- 				return true
-- 			elseif event.name == "moved" then
-- 				self.skillPic:setPosition(event.x, event.y)
-- 			elseif event.name == "ended" then
-- 				if  event.y < self.sizeofBG.height * 0.1 + 41 then
-- 					self.skillPic:removeFromParent()
-- 					self.skillPic = nil
-- 					return
-- 				else
-- --英雄二
-- 					if GameState.GameData.HeroNumber == 2 then
-- 						print("start")
-- 						self.heroSprite:s05Move(event.x, event.y)
-- 						print("end")
-- --英雄三
-- 					elseif GameState.GameData.HeroNumber == 3 then
-- 						self.heroSprite:stopAllActions()
-- 						local posx, posy = self.heroSprite:getPosition()
-- 						local distance = math.sqrt((event.x - posx)^2 + (event.y - posy)^2)
-- 						local Dx = event.x - posx
-- 						local Dy = event.y - posy
-- 						if event.x > posx and self.heroSprite.face == "left" then
-- 							local FlipX = cc.FlipX:create(true)
-- 							self.heroSprite:runAction(FlipX)
-- 							self.heroSprite.face = "right"
-- 						elseif event.x < posx and self.heroSprite.face == "right" then
-- 							local FlipX = cc.FlipX:create(false)
-- 							self.heroSprite:runAction(FlipX)
-- 							self.heroSprite.face = "left"
-- 						end
-- 						local angle = 0
-- 						if event.x < posx then
-- 							angle = math.deg(math.asin(Dy / distance))
-- 						elseif event.x > posx then
-- 							angle = math.deg(math.asin(-Dy / distance))
-- 						end
-- 						local skillNow = self.heroSprite:lightLine(event.x, event.y, angle)
-- 						print(self.heroSprite.face)
-- 						self.heroSprite:runAction(skillNow)

-- --英雄四
-- 					else
-- 						self.heroSprite:bomb(event.x, event.y)

-- 					end
-- 					self.skillPic:removeFromParent()
-- 					self.skillPic = nil					
-- 				end	
-- 			end		
-- 		end)

-- --**技能三**--
-- 		local skill3 = self:buttonCreate(HeroData[GameState.GameData.HeroNumber]["skill3"],self.sizeofBG.width*.69 , self.sizeofBG.height *.1)

-- 		skill3:onButtonClicked(function (event)
-- 			self.heroSprite:stopAllActions()
-- 			if GameState.GameData.HeroNumber == 3 then
-- 				local magic2 = self.heroSprite:skill()
-- 				local callback = cc.CallFunc:create(function ()
-- 					self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
-- 				end)
-- 				local action = cc.Sequence:create(magic2, callback) 
-- 				self.heroSprite:runAction(action)				
-- 			elseif GameState.GameData.HeroNumber == 4 then
-- 				local magic1 = self.heroSprite:magic2(GameState.GameData.HeroNumber)
-- 				local callback = cc.CallFunc:create(function ()
-- 				self.heroSprite:s12(display.cx, display.cy)
-- 				self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
-- 				end)
-- 				local action = cc.Sequence:create(magic1, callback) 
-- 				self.heroSprite:runAction(action)
-- 			elseif GameState.GameData.HeroNumber == 2 then
-- 				self.heroSprite:s01()
-- 			end
-- 		end)
-- 		skill3:addTo(self.sprtieBG)
-- 	end

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

	-- local tower = Tower.new(PassData["L"..self.pass].pretower)
	-- local pretower = self.map:getObjectGroup("objs"):getObject("preTower")
	-- tower:pos(pretower.x, pretower.y)
	-- tower:addTo(self.map,3)
	-- table.insert(self.tower,tower)


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
			if v.num == "16" or v.num =="18"  then 
				v.firetime = v.firetime + 1
				if v.firetime >= 120 then
					local num = 0
					for i,j in pairs(self.monster) do
						local tx,ty = j:getPosition()
						local distance = cc.pGetDistance(cc.p(x,y),cc.p(tx,ty))
						if distance <= v.attackArea then							
							j.hpnow = j.hpnow -  v.power
							-- j.Hptag.hptag:setPercent(j.hpnow / j.hp *100)
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
						if v.firetime == 50 then
							local bullet = v:fire2()
							v.firetime = v.firetime - 50
							bullet:runAction(v:fireAction2(tx,ty+10,bullet,1))
							
							for i,j in pairs(self.monster) do
								local bx,by = bullet:getPosition()
								local mx,my = j:getPosition()
								local distance = cc.pGetDistance(cc.p(bx,by),cc.p(mx,my))
								if distance < 60 then 
									v.target.hpnow = v.target.hpnow -  v.power
								end
							end
							-- v.target.Hptag:show()
							-- v.target.hpnow = v.target.hpnow -  v.power
							-- v.target.Hptag.hptag:setPercent(v.target.hpnow / v.target.hp *100)							
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
						v.firetime = v.firetime + 1
						if v.firetime == 30 then
							local bullet = v:fire(0)
							v.firetime = v.firetime - 30
							bullet:runAction(v:fireAction(tx,ty+10,bullet,0))
							v.target.hpnow = v.target.hpnow -  v.power						
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
		self:HeroAttack()
	end)
	self:scheduleUpdate()
	self:rabbit()
	
	local flag = display.newSprite("#Theme1_EnemyHome.png")
	flag:pos(self.way[1].x, self.way[1].y)
	flag:setAnchorPoint(0.5,0)
	flag:addTo(self.map,1)

end
function FightScene:HeroCreate()
	self.heroSprite = Hero.new("#h01_move_"..GameState.GameData.HeroNumber..".png",200, 200, self.map)
	self.heroSprite:setLocalZOrder(2)
	self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
	-- local scheduler = require(cc.PACKAGE_NAME..".scheduler")
	-- 	local count = 0
	-- 	local function onInterval(dt)
	-- 		count = count + 1
	-- 		if count == 30 then
	-- 			for i,v in ipairs(self.monster) do
	-- 				local vx,vy = v:getPosition()
	-- 				-- print(i, vx, vy)
	-- 				local x, y = self.heroSprite:getPosition()
	-- 				local distance = cc.pGetDistance(cc.p(x,y),cc.p(vx,vy))
	-- 				if distance <= 100 then 
	-- 					-- self.heroSprite:runAction(self.heroSprite:move(GameState.GameData.HeroNumber, vx,vy))
	-- 					self.heroSprite:runAction(self.heroSprite:attack(GameState.GameData.HeroNumber))
	-- 					v.Hptag:show()
	-- 					v.hpnow = v.hpnow -  20
	-- 					v.Hptag.hptag:setPercent(v.hpnow / v.hp *100)
	-- 					break
	-- 				end
	-- 			end
	-- 			count = count - 10
	-- 		end
	-- 	end
	-- 	
	--英雄技能创建
		if GameState.GameData.HeroNumber == 1 then
			
			local skill1 = self:buttonCreate("#skillIcon2.png",self.sizeofBG.width*.6 , self.sizeofBG.height *.1)
			:onButtonClicked(function (event)
				self.heroSprite:stopAllActions()
				local magic1 = self.heroSprite:magic1(GameState.GameData.HeroNumber)
				local callback = cc.CallFunc:create(function ()
					self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
				end)
				local action = cc.Sequence:create(magic1, callback) 
				self.heroSprite:runAction(action)
			end)
			skill1:addTo(self.sprtieBG)

			local skill2 = self:buttonCreate("#skillIcon1.png",self.sizeofBG.width*.69 , self.sizeofBG.height *.1)
			skill2:onButtonClicked(function (event)			
				self.heroSprite:stopAllActions()
				self.heroSprite:runAction(self.heroSprite:magic12(GameState.GameData.HeroNumber,190, 160))
			end)
			skill2:addTo(self.sprtieBG)
		else
	--英雄二三四的技能	
	--**技能一**--	
			local skill1 = self:buttonCreate(HeroData[GameState.GameData.HeroNumber]["skill1"],self.sizeofBG.width*.51 , self.sizeofBG.height *.1)
			skill1:onButtonClicked(function (event)
				self.heroSprite:stopAllActions()
				if GameState.GameData.HeroNumber == 4 then
					self.heroSprite:s12_wing()

				elseif GameState.GameData.HeroNumber == 3 then
					local magic2 = self.heroSprite:skill()
					local callback = cc.CallFunc:create(function ()
						self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
					end)
					local action = cc.Sequence:create(magic2, callback) 
					self.heroSprite:runAction(action)	
				elseif GameState.GameData.HeroNumber == 2 then
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
							print("start")
							self.heroSprite:s05Move(event.x, event.y)
							print("end")
	--英雄三
						elseif GameState.GameData.HeroNumber == 3 then
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
							local skillNow = self.heroSprite:lightLine(event.x, event.y, angle)
							print(self.heroSprite.face)
							self.heroSprite:runAction(skillNow)

	--英雄四
						else
							self.heroSprite:bomb(event.x-20, event.y- 70)
							-- for k,v in pairs(self.monster) do
							-- 	local vx,vy = v:getPosition()
							-- 	-- print(event.x-20, event.y- 70)
							-- 	local distance = cc.pGetDistance(cc.p(vx,vy), cc.p(event.x-20, event.y- 70))
							-- 	if 	distance <= 50 then
							-- 		self.map:getChildByTag(2):getChild():runAction(self.heroSprite:bombExplode(event.x-20, event.y- 70))
							-- 		self.map:getChildByTag(2):getChild():removeFromParent()
							-- 	end
							-- end
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
					local magic2 = self.heroSprite:skill()
					local callback = cc.CallFunc:create(function ()
						self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
					end)
					local action = cc.Sequence:create(magic2, callback) 
					self.heroSprite:runAction(action)				
				elseif GameState.GameData.HeroNumber == 4 then
					local magic1 = self.heroSprite:magic2(GameState.GameData.HeroNumber)
					local callback = cc.CallFunc:create(function ()
					self.heroSprite:s12(display.cx, display.cy, self.monster)
					self.heroSprite:runAction(self.heroSprite:wait(GameState.GameData.HeroNumber))
					end)
					local action = cc.Sequence:create(magic1, callback) 
					self.heroSprite:runAction(action)

					-- local function onInterval(dt)
					-- 	print("............................")
					-- 	for i,v in ipairs(self.monster) do
					-- 		local vx,vy = v:getPosition()
					-- 		local x, y = self:getChildByTag(3):getChildByTag(1):getPosition()
					-- 		local distance = cc.pGetDistance(cc.p(x,y),cc.p(vx,vy))
					-- 		if distance <= 100 and vy < y then 
					-- 			print("开始")
					-- 			self.heroSprite:runAction(self.heroSprite:attack(GameState.GameData.HeroNumber))
					-- 			v.Hptag:show()
					-- 			v.hpnow = v.hpnow -  50
					-- 			v.Hptag.hptag:setPercent(v.hpnow / v.hp *100)
					-- 			-- break
					-- 			print("end")
					-- 		end
					-- 	end
					-- end
					-- scheduler.scheduleGlobal(onInterval, 0.2)

				elseif GameState.GameData.HeroNumber == 2 then
					self.heroSprite:s01()

				end
			end)
			skill3:addTo(self.sprtieBG)
		end
	-- end)
end

function FightScene:HeroAttack()
	if self.heroSprite.target == nil then
		for k,v in pairs(self.monster) do
			local mX, mY = v:getPosition()
			local x, y = self.heroSprite:getPosition()
			local distance = cc.pGetDistance(cc.p(mX, mY), cc.p(x, y))
			if distance <= 50 then
				self.heroSprite.target = v
				print("start")
				local x, y = v:getPosition()
				local posx, posy = self:getPosition()
				if x > posx and self.face == "left" then
					local FlipX = cc.FlipX:create(true)
					self:runAction(FlipX)
					self.face = "right"
				elseif x < posx and self.face == "right" then
					local FlipX = cc.FlipX:create(false)
					self:runAction(FlipX)
					self.face = "left"
				end
				print("end")
				table.insert(v.target, self.heroSprite)
				v:stopAllActions()
				break
			end
		end
	elseif self.heroSprite.target and self.heroSprite.state == "wait" then
		self.heroSprite.state = "attack"
		print(self.heroSprite.state)
		local attack = self.heroSprite:attack(GameState.GameData.HeroNumber)
		local callBack = cc.CallFunc:create(function()
			if self.heroSprite.target then
				-- print(self.heroSprite.state)
				self.heroSprite.target.hpnow = self.heroSprite.target.hpnow - 100
				self.heroSprite.state = "wait"
			end
		end)
		local action = cc.Sequence:create(attack, callBack)
		self.heroSprite:runAction(action)
	end
end


function FightScene:buildArea() --炮塔建造区域
	local things = self.map:getLayer("things")
	local way = self.map:getLayer("content")
	local blankAreaTable = {}
	for i=1,11 do
		for j=0,6 do
			local tile = way:getTileAt(cc.p(i,j))
			if tile == nil then			
				local blankArea = display.newSprite("#blankArea.png")
				blankArea.j = j
				blankArea:pos(35 + i * 70 , 35 + (6 - j) * 70)
				blankArea:addTo(self.map,2)
				blankArea:setTouchEnabled(true)
				blankArea:setOpacity(50)
				table.insert(blankAreaTable,blankArea)
				blankArea:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
					for k,v in pairs(self.tower) do
						v:setTouchEnabled(true)
						if v.attackAreashow then
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
						buildlist:addTo(self.map,2)
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
								local tower = Tower.new(str)
								local bX,bY = buildlist:getPosition()
								tower:pos(bX,bY)
								tower:addTo(self.map,3)
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
		local director = cc.Director:getInstance():resume()
		local restart = self.new(self.pass)
		display.replaceScene(restart,"flipX",1)
	end)

	local getback = self:buttonCreate("#settingReturn.png", settingUIsize.width / 2 , settingUIsize.height * .25)
	getback:addTo(settingBG)
	getback:onButtonClicked(function (event)
		local director = cc.Director:getInstance():resume()
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
	self.rabbit.hp = 10
	local sizeR = self.rabbit:getContentSize()

	local rabbitHpBg = display.newSprite("#blood-1.png")
	rabbitHpBg:pos(sizeR.width / 2, sizeR.height)
	:addTo(self.rabbit)
	local sizeHp = rabbitHpBg:getContentSize()

	print(self.RabbitHp)

	self.rabbit.Rhplabel = cc.ui.UILabel.new({
		UILabelType = 1,
		text = self.rabbit.hp,
		font = "font/fontBlood.fnt"
		}) 
	:align(1, sizeHp.width / 1.6, sizeHp.height /1.9)
	:addTo(rabbitHpBg)

end

function FightScene:onEnter()

end

function FightScene:onExit()

end
return FightScene