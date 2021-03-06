display.addSpriteFrames("hero/hero1.plist","hero/hero1.png")
display.addSpriteFrames("hero/hero2.plist","hero/hero2.png")
display.addSpriteFrames("hero/hero3.plist","hero/hero3.png")
display.addSpriteFrames("hero/hero4.plist","hero/hero4.png")
local Tabel = require("app.stageConfig.HeroData")
local Hero = class("Hero", function (pic, posX, posY, parentNode)
	local Hero = display.newSprite(pic)
	:setPosition(posX, posY)
	parentNode:addChild(Hero)
	return Hero
end)
function Hero:ctor()
	-- self:attack()
	self.target = nil
	self.attackCount = 0
	self.state = "wait"
	self.face = "left"
	self:MoveTo()
	self.HP = 500
end
--移动和英雄转向
function Hero:MoveTo()
	
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
		if event.name == "began" then
			local posx, posy = self:getPosition()
			if event.x > posx and self.face == "left" then
				local FlipX = cc.FlipX:create(true)
				self:runAction(FlipX)
				self.face = "right"
			elseif event.x < posx and self.face == "right" then
				local FlipX = cc.FlipX:create(false)
				self:runAction(FlipX)
				self.face = "left"
			end
			return true
			-- self:runAction(self:move(GameState.GameData.HeroNumber))
			-- self:setPosition(event.x, event.y)
		elseif event.name == "moved" then
			local posx, posy = self:getPosition()
			if event.x > posx and self.face == "left" then
				local FlipX = cc.FlipX:create(true)
				self:runAction(FlipX)
				self.face = "right"
			elseif event.x < posx and self.face == "right" then
				local FlipX = cc.FlipX:create(false)
				self:runAction(FlipX)
				self.face = "left"
	 
	 		end
			self:setPosition(event.x , event.y - 120)
		end
	end)
end

--攻击
function Hero:attack(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_attack_%d.png",1,Tabel[heroNum]["attack"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end

--死亡
function Hero:dead(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_dead_%d.png",1,Tabel[heroNum]["dead"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end

--受伤
function Hero:hurt(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_hurt_%d.png",1,Tabel[heroNum]["hurt"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end

--等待
function Hero:wait(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_wait_%d.png",1,Tabel[heroNum]["wait"])
	local animation = display.newAnimation(frames,0.1)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	return(rep)
end
--英雄二的等待二
function Hero:wait2()
	local frames = display.newFrames("h02_wait_%d.png",1,3)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end
--英雄一的暴风技能
function Hero:tornado()
	local frames = display.newFrames("tornado_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate1 = cc.Animate:create(animation)
	local rep = cc.Repeat:create(animate1,15)
	
end

--移动动作
function Hero:move(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_move_%d.png",1,Tabel[heroNum]["move"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end

--技能1
function Hero:magic1(heroNum,monsterTable)
	local frames = display.newFrames("h0"..heroNum.."_magic2_%d.png",1,Tabel[heroNum]["magic2"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local callback = cc.CallFunc:create(function()
		for k,v in pairs(monsterTable) do
			v.hpnow = v.hpnow -  100
		end
		self.state = "wait"
	end)
	local seq = cc.Sequence:create(animate,callback)
	return seq

end
function Hero:magic2(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_magic_%d.png",1,Tabel[heroNum]["magic1"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end
--英雄技能2 
function Hero:magic12(heroNum,x,y, monsterTable)
	local frames = display.newFrames("h0"..heroNum.."_magic_%d.png",1,Tabel[heroNum]["magic1"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)

	local callback = cc.CallFunc:create(function()
		self:runAction(Hero:wait(GameState.GameData.HeroNumber))
		local sprite = display.newSprite("#tornado_1.png")
		sprite:setPosition(x, y)
		sprite:setTag(1)
		self:getParent():addChild(sprite)
		sprite:setTouchEnabled(true)
		sprite:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
			if event.name == "began" then
				return true
			elseif event.name == "moved" then
				sprite:setPosition(event.x, event.y)
			end
		end)
		local frames = display.newFrames("tornado_%d.png",1,6)
		local animation = display.newAnimation(frames,0.2)
		local animate1 = cc.Animate:create(animation)
		local rep = cc.Repeat:create(animate1,9)
		
		sprite:schedule(function()			
			for k,v in pairs(monsterTable) do
				local posx, posy = v:getPosition()
				local sx,sy = sprite:getPosition()
				local distance = cc.pGetDistance(cc.p(posx,posy),cc.p(sx,sy))
				if distance < 100 then
					v.hpnow = v.hpnow -  20
				end
			end
		end, 0.2)
		local callback1 = cc.CallFunc:create(function()	
			self.state = "wait"
			sprite:removeFromParent()	
			 
		end)
		local seq = cc.Sequence:create(rep, callback1)
		sprite:runAction(seq)			
	end)
	
	local seq1 = cc.Sequence:create(animate, callback)
	return(seq1)
end

function Hero:focus(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_focus_%d.png",1,Tabel[heroNum]["focus"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end

function Hero:focusPre(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_focusPre_%d.png",1,Tabel[heroNum]["focusPre"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end
--英雄2的技能三
function Hero:s01(monsterTable)
	local sprite = display.newSprite("#h02_s01_1.png")
	:setAnchorPoint(0.5, 0.3)
	self:getParent():addChild(sprite)
	local posx, posy = self:getPosition()
	if self.face == "left" then
		sprite:setPosition(posx - 80, posy + 50)
	else
		sprite:setPosition(posx + 80, posy + 50)
	end

	local frames = display.newFrames("h02_s01_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local callback = cc.CallFunc:create(function()
		for i,v in pairs(monsterTable) do
			local vx,vy = v:getPosition()
			local distance = cc.pGetDistance(cc.p(posx, posy),cc.p(vx,vy))
			if posx + 90 > vx and posx - 90 < vx and vy > posy - 100 and vy < posy + 20 then 
				v.hpnow = v.hpnow -  200
			end
		end
		self:runAction(Hero:wait(GameState.GameData.HeroNumber))
		sprite:removeFromParent()
		self.state = "wait"
	end)
	local seq = cc.Sequence:create(animate, callback)
	sprite:runAction(seq)
end

function Hero:s02(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_focusPre_%d.png",1,Tabel[heroNum]["focusPre"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.Repeat:create(animate,3)
	local callback = cc.CallFunc:create(function()
		self:runAction(self:wait(GameState.GameData.HeroNumber))
		if self.HP <= 400 then
			self.HP = self.HP + 100
		else 
			self.HP = 500
		end
		print(self.HP)
		self.state = "wait"
	end)
	local seq = cc.Sequence:create(rep, callback)
	return(seq)
end
--
function Hero:s05()

	local frames = display.newFrames("s05_%d.png",1,Tabel[2]["s05"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)

	return(animate)
end
--英雄2的第二个技能
function Hero:s05Move(posX,posY,monsterTable)
	local table = {[1] = {45, 0}, [2] = {-45, 0},[3] = {30,30}, [4] = {0, 45}, [5] = {-30,30},[6] = {30,-30},[7] = {-30,-30},[8] = {0,-45}}
	math.randomseed(os.time())
	
	local node = display.newNode()
	:setPosition(posX, posY - 110)
	self:getParent():addChild(node)
	local num = 1
	node:schedule(function()
		if num >= 9 then
			return
		end
		local sprite = display.newSprite("#s05_move_1.png")
		sprite:setRotation(15)
		sprite:setPosition(table[num][1], table[num][2])
		sprite:setAnchorPoint(0.5, 0)
		node:addChild(sprite)
		local frames = display.newFrames("s05_move_%d.png",1,Tabel[2]["s05Move"])
		local animation = display.newAnimation(frames,0.1)
		local animate = cc.Animate:create(animation)
		local callback = cc.CallFunc:create(function()
			local frames = display.newFrames("s05_explode_%d.png",1,Tabel[2]["s05Explode"])
			local animation = display.newAnimation(frames,0.1)
			local animate1 = cc.Animate:create(animation)
			local callback1 = cc.CallFunc:create(function()
				for i,v in pairs(monsterTable) do
					local vx,vy = v:getPosition()
					local distance = cc.pGetDistance(cc.p(posX, posY),cc.p(vx,vy))
					if posX + 100 > vx and posX - 100 < vx and vy > posY - 100 and vy < posY + 100 then 
						v.hpnow = v.hpnow -  30
					end
				end
				sprite:removeFromParent()
				sprite = nil
				-- self.state = "wait"		
			end)
			local seq1 = cc.Sequence:create(animate1, callback1)
			sprite:runAction(seq1)	
		end)
		local seq = cc.Sequence:create(animate, callback) 
		sprite:runAction(seq)
		num = num + 1
	end, 0.25)

end

--英雄二的技能一绿光特效
function Hero:s06()
	local frames = display.newFrames("s06_%d.png",1,Tabel[2]["s06"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end
--英雄3的技能二
function Hero:lightLine(posx, posy, angle, monsterTable)
	local frames = display.newFrames("h03_skill09_pre%d.png",1,7)
	local animation = display.newAnimation(frames,0.1)
	local animate1 = cc.Animate:create(animation)
	
	local frames = display.newFrames("h03_skill09_bomb%d.png",1,3)
	local animation = display.newAnimation(frames,0.1)
	local animate2 = cc.Animate:create(animation)

	local seq = cc.Sequence:create(animate1, animate2)
	
	local callback = cc.CallFunc:create(function(event)
		local sprite = display.newSprite("#h03_lightLine1.png")
		sprite:setRotation(angle)
		local sx, sy = self:getPosition()
		local distance = math.sqrt((posx - sx)^2 + (posy - sy)^2)
		if distance < 460 then
			sprite:setPosition((posx + sx) / 2, (posy + sy) / 2)
			sprite:setScale(distance / 460)
			local moveTo = cc.MoveTo:create(0.1, cc.p(posx, posy))
			self:runAction(moveTo)
		else
			sprite:setPosition(cc.p(sx + 460 / distance * (posx - sx) / 2, sy + 460 / distance * (posy - sy) / 2))
			local moveTo = cc.MoveBy:create(0.1, cc.p(460 / distance * (posx - sx), 460 / distance * (posy - sy)))
			self:runAction(moveTo)
		end
		
		local frames = display.newFrames("h03_lightLine%d.png",1,6)
		local animation = display.newAnimation(frames,0.1)
		local animate = cc.Animate:create(animation)
		self:getParent():addChild(sprite)
		sprite:runAction(animate)

		local frames = display.newFrames("h03_skill09_stop%d.png",1,12)
		local animation = display.newAnimation(frames,0.1)
		local animate3 = cc.Animate:create(animation)
		
		local callback1 = cc.CallFunc:create(function()
			for k,v in pairs(monsterTable) do
				local mx, my = v:getPosition()
				local lx, ly = sprite:getPosition()
				local distance1 = math.abs(((mx - sx) * (ly - sy) / (lx - sx) - my + sy) / math.sqrt(((ly - sy) / (lx - sx)) ^ 2 + 1))
				print(k..":"..distance1)
				if distance1 < 50 and mx > lx - math.abs(lx - sx) and mx < lx + math.abs(lx - sx) then
					v.hpnow = v.hpnow -  500
				end
			end
			self.state = "wait"						
			self:runAction(self:wait(GameState.GameData.HeroNumber))
		end)
		local seq1 = cc.Sequence:create(animate3, callback1)
		self:runAction(seq1)
	end)
	local seq2 = cc.Sequence:create(seq, callback)
	return seq2
end
--英雄三的技能一三
function Hero:skill(monsterTable)
	local frames = display.newFrames("h03_skill09_pre%d.png",1,7)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	
	local frames = display.newFrames("h03_skill09_bomb%d.png",1,3)
	local animation = display.newAnimation(frames,0.2)
	local animate1 = cc.Animate:create(animation)
	
	local callback = cc.CallFunc:create(function()
		for k,v in pairs(monsterTable) do
			local vx,vy = v:getPosition()
			local x,y = self:getPosition()
			if vx > x - 60 and vx < x + 60 and vy > y - 60 and vy < y + 60 then
				v.hpnow = v.hpnow -  150
			end
		end
	end)

	local frames = display.newFrames("h03_skill09_stop%d.png",1,12)
	local animation = display.newAnimation(frames,0.2)
	local animate2 = cc.Animate:create(animation)
	
	local callback1 = cc.CallFunc:create(function()
		self.state = "wait"
	end)
	
	local seq = cc.Sequence:create(animate, animate1,callback ,animate2, callback1)
	return(seq)
end
--英雄4的技能三（UFO技能）
function Hero:s12(posX, posY, monsterTable)
	local node = display.newNode()
	:setPosition(posX, posY)
	:setLocalZOrder(2)
	self:getParent():addChild(node)	
--飞碟
	local sprite1 = display.newSprite("#s12_dropout_1.png")
	-- :setPosition(posX, posY)
	:setTag(1)
	:setLocalZOrder(2)
	node:addChild(sprite1)
--云朵
	local sprite2 = display.newSprite("#s12_dropout_1.png")
	:setPosition(0, 50)
	:setLocalZOrder(2)
	node:addChild(sprite2)
	

	local frames = display.newFrames("s12_heaven_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)

	local callback1 = cc.CallFunc:create(function()
		sprite2:removeFromParent()
		sprite1:setTouchEnabled(true)
		sprite1:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
			if event.name == "began" then
				return true
			elseif event.name == "moved" then
				node:setPosition(event.x, event.y)
			end
		end)
	end)
	local seq = cc.Sequence:create(animate, callback1)

	sprite2:runAction(seq)

	local frames = display.newFrames("s12_dropout_%d.png",1,9)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)

	local callback = cc.CallFunc:create(function ()

		local sprite3 = display.newSprite("#ufolight1.png")
		:setPosition(0, - 120)
		:setLocalZOrder(1)
		node:addChild(sprite3)

		local frames = display.newFrames("ufolight%d.png",1,2)
		local animation2 = display.newAnimation(frames,0.2)
		local animate2 = cc.Animate:create(animation2)
		local rep1 = cc.Repeat:create(animate2, 48)

		sprite3:schedule(function()			
			for i,v in pairs(monsterTable) do
				local vx,vy = v:getPosition()
				local x, y = node:getPosition()
				local distance = cc.pGetDistance(cc.p(x,y),cc.p(vx,vy))
				if x + 50 > vx and x - 50 < vx and vy > y - 200 and vy < y - 50 then 
					v.hpnow = v.hpnow -  50
				end
			end
		end, 0.2)

		local callback1 = cc.CallFunc:create(function()
			node:removeFromParent()		
		end)
		local seq1 = cc.Sequence:create(rep1, callback1)
		sprite3:runAction(seq1)
	end)
	
	local frames = display.newFrames("s12_fly_%d.png",1,6)
	local animation1 = display.newAnimation(frames,0.2)
	local animate1 = cc.Animate:create(animation1)
	local rep = cc.Repeat:create(animate1, 16)
	local callback1 = cc.CallFunc:create(function()
		self.state = "wait"
	end)

	local action = cc.Sequence:create(animate, callback, rep, callback1)

	sprite1:runAction(action)
	
end


--英雄四技能一头上效果
function Hero:s12_wing()
	local sprite = display.newSprite("#s14_wing_1.png")
	:setPosition(75,140)
	self:addChild(sprite)
	local frames = display.newFrames("h04_focus_%d.png",1,4)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	
	local frames = display.newFrames("h04_focusPre_%d.png",1,2)
	local animation = display.newAnimation(frames,0.2)
	local animate1 = cc.Animate:create(animation)
	local seq = cc.Sequence:create(animate, animate1)
	local callback = cc.CallFunc:create(function()
		local frames = display.newFrames("s14_wing_%d.png",1,8)
		local animation = display.newAnimation(frames,0.2)
		local animate2 = cc.Animate:create(animation)
		sprite:runAction(animate2)
	end)
	local seq1 = cc.Sequence:create(seq,callback)
	local callback1 = cc.CallFunc:create(function()
		sprite:removeFromParent()
		self:runAction(self:wait(4)) 
	end)
	local seq2 = cc.Sequence:create(seq1,callback1)
	self:runAction(seq2)
	
end


--英雄四的技能二
function Hero:bomb(posX, posY)
	local node = display.newNode()
	node:setPosition(posX, posY)
	node:setTag(2)
	self:getParent():addChild(node)
	local bomb = display.newSprite("#h04_bomb_1.png")
	bomb:setTag(1)
	node:addChild(bomb)
	local frames = display.newFrames("h04_bomb_%d.png",1,2)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	bomb:runAction(rep)
	return node
end
--英雄四的炸弹爆炸效果
function Hero:bombExplode(posX, posY)
	local node = display.newNode()
	:setPosition(posX, posY)
	self:getParent():addChild(node)
	local bombExplode = display.newSprite("#h04_bombExplode_1.png")
	node:addChild(bombExplode)
	local frames = display.newFrames("h04_bombExplode_%d.png",1,7)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local callback = cc.CallFunc:create(function()
		node:removeFromParent()
	end)
	local seq = cc.Sequence:create(animate, callback)
	-- return(seq)
	bombExplode:runAction(seq)
end

function Hero:onEnter()
	-- body
end
function Hero:onExit()
	-- body
end
return Hero