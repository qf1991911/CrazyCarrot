display.addSpriteFrames("monster/E41.plist","monster/E41.png")
display.addSpriteFrames("monster/enemyCommon.plist","monster/enemyCommon.png")
display.addSpriteFrames("fight/fight.plist","fight/fight.png")
local MonsterData = require(".app.stageConfig.MonsterData")
local Monster = class("Monster", function (num)
	local path = "#E" .. num .. "_1.png"
	local sprite = display.newSprite(path)
	sprite.num = num
	return sprite
end)

function Monster:ctor()
	self:runAction(self:walk())
	self:setAnchorPoint(0.5,0.2)
	self.target = {}
	self.hp = MonsterData["E"..self.num].hp	
	self.hpnow = MonsterData["E"..self.num].hp
	self.Hptag = self:blood()
end

function Monster:walk() --行走帧动画
	local frames = display.newFrames("E" .. self.num .. "_%01d.png", 1, MonsterData["E"..self.num].walk)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	return rep
end

function Monster:attack() --攻击帧动画
	local frames = display.newFrames("E" .. self.num.."_attack_%01d.png", 1, MonsterData["E"..self.num].attack)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	return rep
end



function Monster:dead() --死亡帧动画
	local sprite = display.newSprite("#explosion_died_demotion_1.png")
	:setPosition(self:getPosition())
	:addTo(self:getParent())
	local frames = display.newFrames("explosion_died_demotion_%01d.png", 1, 6)
	local animation = display.newAnimation(frames,0.1)
	local animate = cc.Animate:create(animation)
	local callfun = cc.CallFunc:create(function()
		sprite:removeFromParent()
		sprite = nil
	end)
	local sq = cc.Sequence:create(animate,callfun)
	sprite:runAction(sq)
end



function Monster:move(posT, monsterTable,rabbit)--按路径移动
	local action
	for i = 1, #posT - 1 do
		local offsetX = posT[i].x - posT[i + 1].x
		local offsetY = posT[i].y - posT[i + 1].y
		local move = cc.MoveTo:create(math.sqrt(offsetX * offsetX + offsetY * offsetY) / 50, cc.p(posT[i + 1].x, posT[i + 1].y))
		
		if posT[i].x < posT[i + 1].x then
			local flip = cc.FlipX:create(true)
			action = cc.Sequence:create(action,flip, move)
		else
			local flip = cc.FlipX:create(false)
			action = cc.Sequence:create(action, flip, move)
		end
	end
	local callfun = cc.CallFunc:create(function()
		for k,v in pairs(monsterTable) do
			if v == self then
				for i,j in pairs(self.target) do
					j.target = nil
				end
				table.remove(monsterTable, k)
				self:removeFromParent()
				self = nil
			end
		end
	end)
	local callfun2 = cc.CallFunc:create(function ()
		rabbit.Rhplabel:setString(9)
	end)
	local sq = cc.Sequence:create(action,callfun,callfun2)
	self:runAction(sq) 
end

function Monster:blood()
	local size = self:getContentSize()
	local sprite = display.newSprite("#hpBar_bg.png")
	:pos(size.width / 2, size.height)
	:addTo(self)
	sprite.hptag = cc.ui.UILoadingBar.new({
		scale9 = true,
		capInsets = cc.rect(0, 0, 50, 10),
		image = "#hpBar_front.png",
		viewRect = cc.rect(0, 0, 50, 10),
		percent = 100,
		direction = DIRECTION_RIGHT_TO_LEFT
		})
	:addTo(sprite)
	sprite:hide()
	return sprite
end
function Monster:onEnter()
	-- body
end
function Monster:onExit()
	-- body
end
return Monster