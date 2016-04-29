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
	self:runAction(animate)
end

--死亡
function Hero:dead(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_dead_%d.png",1,Tabel[heroNum]["dead"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

--受伤
function Hero:hurt(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_hurt_%d.png",1,Tabel[heroNum]["hurt"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

--等待
function Hero:wait(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_wait_%d.png",1,Tabel[heroNum]["wait"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:wait2(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_wait_%d.png",1,Tabel[heroNum]["wait2"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end
--英雄一的暴风技能
function Hero:tornado()
	local frames = display.newFrames("tornado_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

--移动
function Hero:move(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_move_%d.png",1,Tabel[heroNum]["move"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

--技能1
function Hero:magic1(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_magic_%d.png",1,Tabel[heroNum]["magic1"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

--技能2 
function Hero:magic2(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_magic2_%d.png",1,Tabel[heroNum]["magic2"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:focus(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_focus_%d.png",1,Tabel[heroNum]["focus"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:focusPre(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_focusPre_%d.png",1,Tabel[heroNum]["focusPre"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end
--英雄2的第三个技能
function Hero:s01()
	local frames = display.newFrames("h02_s01_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:s02(heroNum)
	local frames = display.newFrames("h0"..heroNum.."_focusPre_%d.png",1,Tabel[heroNum]["focusPre"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:s05()
	local frames = display.newFrames("s05_%d.png",1,Tabel[2]["s05"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:s05Move()
	local frames = display.newFrames("s05_%d.png",1,Tabel[2]["s05Move"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:s05Explode()
	local frames = display.newFrames("s05_explode_%d.png",1,Tabel[2]["s05Explode"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:s06()
	local frames = display.newFrames("s06_%d.png",1,Tabel[2]["s06"])
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:lightLine()
	local frames = display.newFrames("h03_lightLine_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
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
	self:runAction(seq)
end
--UFO出场几动作
function Hero:s12(posX, posY)
	local node = display.newNode()
	:setPosition(posX, posY)
	self:addChild(node)	
	local sprite1 = display.newSprite("#s12_dropout_1.png")
	:setPosition(posX, posY)
	:setLocalZOrder(2)
	node:addChild(sprite1)


	local frames = display.newFrames("s12_dropout_%d.png",1,9)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)

	local callback = cc.CallFunc:create(function ()
		local sprite2 = display.newSprite("#ufolight1.png")
		:setPosition(posX, posY - 120)
		:setLocalZOrder(1)
		node:addChild(sprite2)

		local frames = display.newFrames("ufolight%d.png",1,2)
		local animation = display.newAnimation(frames,0.2)
		local animate2 = cc.Animate:create(animation)
		local rep1 = cc.RepeatForever:create(animate2)
		sprite2:runAction(rep1)
	end)
	
	local frames = display.newFrames("s12_fly_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate1 = cc.Animate:create(animation)
	local rep = cc.Repeat:create(animate1, 10)

	local action = cc.Sequence:create(animate, callback, rep)

	sprite1:runAction(action)
	

	
end

function Hero:s12_heaven()
	local frames = display.newFrames("s12_heaven_%d.png",1,6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:s12_wing()
	local frames = display.newFrames("s12_wing_%d.png",1,8)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:ufolight()
	local frames = display.newFrames("ufolight%d.png",1,2)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:bomb()
	local frames = display.newFrames("h04_bomb_%d.png",1,2)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:bombExplode()
	local frames = display.newFrames("h04_bombExplode_%d.png",1,7)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	self:runAction(animate)
end

function Hero:onEnter()
	-- body
end
function Hero:onExit()
	-- body
end
return Hero