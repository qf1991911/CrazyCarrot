display.addSpriteFrames("hero/hero1.plist","hero/hero1.png")
display.addSpriteFrames("hero/hero2.plist","hero/hero2.png")
display.addSpriteFrames("hero/hero3.plist","hero/hero3.png")
display.addSpriteFrames("hero/hero4.plist","hero/hero4.png")
local Tabel = require(".app.stageConfig.HeroData")
local Hero = class("Hero", function (pic, posX, posY, parentNode)
	local Hero = display.newSprite(pic)
	:setPosition(posX, posY)
	parentNode:addChild(Hero)
	return Hero
end)
function Hero:ctor()
	-- self:attack()
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

--移动
function Hero:move(heroNum, posx, posy)
	local frames = display.newFrames("h0"..heroNum.."_move_%d.png",1,Tabel[heroNum]["move"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)

	local move = cc.MoveTo:create(posx, posy)
	local action = cc.Spawn:create(animate, move)
	return(action)
end

--技能1
function Hero:magic1(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_magic2_%d.png",1,Tabel[heroNum]["magic2"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return animate

end
function Hero:magic2(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_magic_%d.png",1,Tabel[heroNum]["magic1"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end
--技能2 
function Hero:magic12(heroNum, posX, posY)
	local frames = display.newFrames("h0"..heroNum.."_magic_%d.png",1,Tabel[heroNum]["magic1"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)

	local callback = cc.CallFunc:create(function()
		local sprite = display.newSprite("#tornado_1.png")
		sprite:setPosition(90, 80)
		self:addChild(sprite)
		local frames = display.newFrames("tornado_%d.png",1,6)
		local animation = display.newAnimation(frames,0.2)
		local animate1 = cc.Animate:create(animation)
		local rep = cc.Repeat:create(animate1,10)
		sprite:runAction(rep)
	end)
	
	local seq = cc.Sequence:create(animate, callback)
	return(seq)
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
--英雄2的第三个技能
function Hero:s01()
	local frames = display.newFrames("h02_s01_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end

function Hero:s02(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_focusPre_%d.png",1,Tabel[heroNum]["focusPre"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end

function Hero:s05()

	local frames = display.newFrames("s05_%d.png",1,Tabel[2]["s05"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)

	return(animate)
end

function Hero:s05Move(posX,posY)
	local tabel = {[1] = {30, 0}, [2] = {-30, 0},[3] = {23,23}, [4] = {0, 30}, [5] = {-23,23},[6] = {23,-23},[7] = {-23,-23},[8] = {0,-30}}
	math.randomseed(os.time())
	
	local node = display.newNode()
	:setPosition(posX, posY)
	self:getParent():addChild(node)	
	
		local sprite = display.newSprite("#s05_move_1.png")
		for i,v in ipairs(table) do
			node:setPosition(v[1], v[2])
		end
		
		sprite:setAnchorPoint(0.5, 0)
		node:addChild(sprite)
		

		local frames = display.newFrames("s05_move_%d.png",1,Tabel[2]["s05Move"])
		local animation = display.newAnimation(frames,0.2)
		local animate = cc.Animate:create(animation)
		local callback = cc.CallFunc:create(function()
			local frames = display.newFrames("s05_explode_%d.png",1,Tabel[2]["s05Explode"])
			local animation = display.newAnimation(frames,0.2)
			local animate1 = cc.Animate:create(animation)
				local callback1 = cc.CallFunc:create(function()
					node:removeFromParent()
				end)
				local seq1 = cc.Sequence:create(animate1, callback1)
			sprite:runAction(seq1)	
		end)
		local seq = cc.Sequence:create(animate, callback) 
		local rep = cc.Repeat:create(seq,9)
		sprite:runAction(rep)

	
end

function Hero:s05Explode()
	
end

function Hero:s06()
	local frames = display.newFrames("s06_%d.png",1,Tabel[2]["s06"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end

function Hero:lightLine()
	local frames = display.newFrames("h03_lightLine_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end
--英雄3的技能二，skill_pre -> skill_bomb ->skill_stop
function Hero:skill()
	local frames = display.newFrames("h03_skill09_pre%d.png",1,7)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	
	local frames = display.newFrames("h03_skill09_bomb%d.png",1,3)
	local animation = display.newAnimation(frames,0.2)
	local animate1 = cc.Animate:create(animation)
	
	local frames = display.newFrames("h03_skill09_stop%d.png",1,12)
	local animation = display.newAnimation(frames,0.2)
	local animate2 = cc.Animate:create(animation)
	local seq = cc.Sequence:create(animate, animate1, animate2)
	return(seq)
end
--英雄4的技能三（UFO技能）
function Hero:s12(posX, posY)
	local node = display.newNode()
	:setPosition(posX, posY)
	self:addChild(node)	
	local sprite1 = display.newSprite("#s12_dropout_1.png")
	:setPosition(posX, posY)
	:setLocalZOrder(2)
	node:addChild(sprite1)

	local sprite2 = display.newSprite("#s12_dropout_1.png")
	:setPosition(posX, posY + 50)
	:setLocalZOrder(2)
	node:addChild(sprite2)
	local frames = display.newFrames("s12_heaven_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	
	local callback1 = cc.CallFunc:create(function()
		sprite2:removeFromParent()
	end)
	local seq = cc.Sequence:create(animate, callback1)
	sprite2:runAction(seq)
	


	local frames = display.newFrames("s12_dropout_%d.png",1,9)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)

	local callback = cc.CallFunc:create(function ()
		local sprite3 = display.newSprite("#ufolight1.png")
		:setPosition(posX, posY - 120)
		:setLocalZOrder(1)
		node:addChild(sprite3)

		local frames = display.newFrames("ufolight%d.png",1,2)
		local animation2 = display.newAnimation(frames,0.2)
		local animate2 = cc.Animate:create(animation2)
		local rep1 = cc.Repeat:create(animate2, 4 / 0.4)

		local callback1 = cc.CallFunc:create(function()
			node:removeFromParent()
		end)
		local seq1 = cc.Sequence:create(rep1, callback1)
		sprite3:runAction(seq1)
	end)
	
	local frames = display.newFrames("s12_fly_%d.png",1,6)
	local animation1 = display.newAnimation(frames,0.2)
	local animate1 = cc.Animate:create(animation1)
	local rep = cc.Repeat:create(animate1, 10)

	local action = cc.Sequence:create(animate, callback, rep)

	sprite1:runAction(action)
	

	
end


--英雄四技能一头上效果
function Hero:s12_wing()
	local frames = display.newFrames("s14_wing_%d.png",1,8)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end


--英雄四的技能二
function Hero:bomb(posX, posY)
	local node = display.newNode()
	:setPosition(posX, posY)
	self:addChild(node)
	local bomb = display.newSprite("#h04_bomb_1.png")
	node:addChild(bomb)
	local frames = display.newFrames("h04_bomb_%d.png",1,2)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	bomb:runAction(rep)
	-- if conditions then
	-- 	self:runAction(Hero:bombExplode())
	-- 	node:removeFromParent()
	-- end
end
--英雄四的炸弹爆炸效果
function Hero:bombExplode()
	local frames = display.newFrames("h04_bombExplode_%d.png",1,7)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	return(animate)
end

function Hero:onEnter()
	-- body
end
function Hero:onExit()
	-- body
end
return Hero