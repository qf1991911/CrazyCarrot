display.addSpriteFrames("Tower/T01.plist","Tower/T01.png")
display.addSpriteFrames("Tower/T02.plist","Tower/T02.png")
display.addSpriteFrames("Tower/T03.plist","Tower/T03.png")
display.addSpriteFrames("Tower/T07.plist","Tower/T07.png")
display.addSpriteFrames("Tower/T11.plist","Tower/T11.png")
display.addSpriteFrames("Tower/T16.plist","Tower/T16.png")
display.addSpriteFrames("Tower/T18.plist","Tower/T18.png")
display.addSpriteFrames("Tower/bullet.plist","Tower/bullet.png")
display.addSpriteFrames("fight/fight.plist","fight/fight.png")
local TowerData = require(".app.stageConfig.TowerData")
local Tower = class("Tower", function (num)
	local tower = display.newNode()
	tower.num = num
	tower.attackArea = TowerData["T" .. tower.num].attackArea
	tower.target = nil
	tower.firetime = 0
	tower.power = TowerData["T" .. tower.num].power
	tower.bulletAnimation = TowerData["T" .. tower.num].bulletAnimation
	return tower
end)

function Tower:ctor()
	self.rotate = false

	self.stage = 3
	if self.num == "18" then
		self:t18create()
	elseif self.num == "03" or self.num == "11" or self.num == "16" then
		self.gun = display.newSprite("#T"..self.num.."_"..self.stage.."_1.png")
		:addTo(self)
		-- self.gun:runAction(self:stage1())
	else		
		self.base = display.newSprite("#T"..self.num.."_seat"..self.stage..".png")
			:addTo(self)
		self.gun = display.newSprite("#T"..self.num.."_"..self.stage.."_1.png")   
		:addTo(self)
		self.gun:setAnchorPoint(cc.p(0.5, 0.15))
		-- self.gun:runAction(self:stage1())	
	end
	-- self:setTouchEnabled(true)
	-- self:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
	-- 	if event.name == "began" then
	-- 		local attackAreashow = display.newSprite("#towerRange.png")
	-- 		attackAreashow:pos(0,0)
	-- 		attackAreashow:addTo(self)
	-- 		return true
	-- 	end
	-- end)

end
function Tower:stage1() --炮塔状态
	local frame = display.newFrames("T"..self.num.."_"..self.stage.."_%01d.png",1,TowerData["T"..self.num]["stage"..self.stage])
	local animation = display.newAnimation(frame,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	return rep	
end


function Tower:t18create() --18号炮塔
	self.base = display.newSprite("#T18_seat"..self.stage..".png")
	:pos(0, -display.cx /20)
	:addTo(self)
	self.gun = display.newSprite("#T18_"..self.stage..".png")
	:addTo(self,1)
	self.gun:runAction(self:actiont18())
	self.ball = display.newSprite("#T18_"..self.stage.."_ball.png")
	:pos(-30, 0)
	:addTo(self,2)
	self.ball:runAction(self:actiont18ball())
end

function Tower:actiont18() --18号炮塔状态
	local up = cc.MoveTo:create(1,cc.p(0,3))
	local down = cc.MoveTo:create(1,cc.p(0,-3))
	local sq = cc.Sequence:create(up,down)
	local rep = cc.RepeatForever:create(sq)
	return rep
end

function Tower:actiont18ball() --18号环绕球动作
	local bezier1 = cc.BezierBy:create(1,{cc.p(0,-10),cc.p(60,-10),cc.p(60,0)})
	local bezier2 = cc.BezierBy:create(1,{cc.p(0,10),cc.p(-60,10),cc.p(-60,0)})
	local callfun = cc.CallFunc:create(function ()
		self.ball:setLocalZOrder(0)
	end)
	local callfun2 = cc.CallFunc:create(function ()
		self.ball:setLocalZOrder(2)
	end)
	local sq = cc.Sequence:create(bezier1,callfun,bezier2,callfun2)
	local rep = cc.RepeatForever:create(sq)
	return rep
end
function Tower:towerAim(degree)
		self:setRotation(degree)
end

function Tower:fire(num)
	local parent = self:getParent()
	local posx,posy = self:getPosition()
	local bullet = display.newSprite("#B"..self.num.."_"..num..".png")
	:pos(posx, posy)
	:addTo(parent,2)
	return bullet
end

function Tower:fire2(num)
	local parent = self:getParent()
	local posx,posy = self:getPosition()
	local bullet = display.newSprite("#B03_3_0.png")
	:pos(posx, posy)
	:addTo(parent,2)
	return bullet
end
function Tower:fireAction(posx,posy,bullet,num1)
	local move = cc.MoveTo:create(0.1,cc.p(posx,posy))
	local boom = self:fireAnimation(bullet,num1)
	local sq = cc.Sequence:create(move,boom)
	return sq
end
function Tower:fireAction2(posx,posy,bullet,num1)
	local bx,by = bullet:getPosition()
	local distance = cc.pGetDistance(cc.p(bx,by),cc.p(posx,posy))
	local newX = (posx - bx) / distance *1500
	local newY = (posy - by) / distance *1500
	local move = cc.MoveTo:create(5,cc.p(newX,newY))
	local rotate = cc.RotateBy:create(5,1800)
	local sp = cc.Spawn:create(move,rotate)
	local boom = self:fireAnimation(bullet,num1)
	local sq = cc.Sequence:create(sp,boom)
	return sq
end

function Tower:fireAnimation(bullet,num1)
	local frame = display.newFrames("B"..self.num.."_%01d.png",num1,self.bulletAnimation)
	local animation = display.newAnimation(frame, 0.1)
	local animate = cc.Animate:create(animation)
	local callfun = cc.CallFunc:create(function (bullet)
		bullet:removeFromParent()
		bullet = nil
	end)
	local sq = cc.Sequence:create(animate,callfun)
	return sq
end

function Tower:stageup()
	
end


function Tower:onEnter()
	-- body
end

function Tower:onExit()
	-- body
end
return Tower