display.addSpriteFrames("fight/ui_play.plist","fight/ui_play.png")
display.addSpriteFrames("map/Theme1/theme1Scene.plist","map/Theme1/theme1Scene.png")
display.addSpriteFrames("fight/ui_play.plist","fight/ui_play.png")
local FightScene = class("FightScene", function()
	return display.newScene("FightScene")
end)

function FightScene:ctor()
	self:fightUI()
	self:fightMap()
end

function FightScene:fightUI()
	self.sprtieBG = display.newSprite("map/Theme1/theme1Map.png")
	:pos(display.cx, display.cy)
	:addTo(self)
	self.sizeofBG = self.sprtieBG:getContentSize()

	local skillbg = self:spriteCreate("#skillBg.png",self.sizeofBG.width / 2,self.sizeofBG.height / 11)
	local moneybg = self:spriteCreate("#ui_moneyBg.png",self.sizeofBG.width*.16,self.sizeofBG.height*.88)
	local wavebg = self:spriteCreate("#ui_waveBg.png",self.sizeofBG.width*.45,self.sizeofBG.height*.88) 
	local misstion = 1






end

function FightScene:fightMap()
	local map = cc.TMXTiledMap:create("map/Theme1/L1_1.tmx")
	map:setPosition(self.sizeofBG.width / 2,self.sizeofBG.height / 2)
	:align(1)
	map:addTo(self.sprtieBG)
end

function FightScene:spriteCreate(way,posx,posy)
	local sprite = display.newSprite(way)
	:pos(posx, posy)
	:addTo(self.sprtieBG)
	return sprite 
end

function FightScene:buttonCreate(way,posx,posy)
	images = {
	normal = way,
	pressed = way,
	disabled = way
	}
	local button = cc.ui.UIPushButton.new(images)
	:pos(posx, posy)
	:addTo(self.sprtieBG)

end

function FightScene:onEnter()

end

function FightScene:onExit()

end
return FightScene