display.addSpriteFrames("monster/E41.plist","monster/E41.png")
display.addSpriteFrames("monster/enemyCommon.plist","monster/enemyCommon.png")
local MonsterData = require(".app.stageConfig.MonsterDate")
local Monster = class("Monster", function (num)
	local path = "#E" .. num .. "_1.png"
	local sprite = display.newSprite(path)
	sprite:setAnchorPoint(0.5,0)
	sprite.num = num
	return sprite
end)

function Monster:ctor()
	self:runAction(self:attack())
end

function Monster:walk()
	local frames = display.newFrames("E" .. self.num .. "_%01d.png", 1, MonsterData["E"..self.num].walk)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	return rep
end

function Monster:attack()
	local frames = display.newFrames("E" .. self.num.."_attack_%01d.png", 1, MonsterData["E"..self.num].attack)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	return rep
end

function Monster:blood()

end

function Monster:dead()
	local frames = display.newFrames("explosion_died_demotion_%01d.png", 1, 6)
	local animation = display.newAnimation(frames,0.2)
	local animate = cc.Animate:create(animation)
	local rep = cc.RepeatForever:create(animate)
	return rep

end



function Monster:move(posT)
	local action
	print("ad")
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
	self:runAction(action)
end

function Monster:onEnter()
	-- body
end
function Monster:onExit()
	-- body
end
return Monster