display.addSpriteFrames("StartScene/ui_settings.plist","StartScene/ui_settings.png")
local FightScene = require(".app.scenes.FightScene")

local StartScene = class("StartScene", function()
    return display.newScene("StartScene")
end)

function StartScene:ctor()
    self:startUI()
    self:button()
    -- self:restrat()
end

function StartScene:startUI()
	local logoaction = self:logoaction()
	local logolayer = cc.Layer:create()
	:setPosition(0,display.cy / 2)
	:addTo(self,1)
	logolayer:runAction(logoaction)

	local BG = display.newSprite("StartScene/mainCover.png")
	:center()
	:addTo(self)

	local rope1 = display.newSprite("#rope.png")
	:pos(display.cx*1.32, display.cy*1.8)
	:addTo(logolayer)

	local rope2 = display.newSprite("#rope.png")
	:pos(display.cx*.69, display.cy*1.8)
	:addTo(logolayer)

	local logo = display.newSprite("#mainLogo.png")
	:pos(display.cx, display.cy*1.57)
	:scale(1)
	:addTo(logolayer)

end

function StartScene:button()
	local playaction = self:playaction()
	local imagestart = {
	normal = "#playButoon.png",	
	pressed = "#playButoon.png",
	disabled = "#playButoon.png"
	}
	local startbutton = cc.ui.UIPushButton.new(imagestart)
	:pos(display.cx, display.cy*0.8)
	:setScale(0.8)
	:addTo(self)
	startbutton:runAction(playaction)
	startbutton:onButtonClicked(function()
		local fightscene = FightScene:new()
		display.replaceScene(fightscene,"flipX",1)
	end)	
	self:buttonEvent(startbutton)

	local imageset = {
	normal = "#soundButton.png",	
	pressed = "#soundButton.png",
	disabled = "#soundButton.png"
	}
	local setbutton = cc.ui.UIPushButton.new(imageset)
	:pos(display.cy / 4, display.cy / 4)
	:setScale(0.8)
	setbutton:onButtonClicked(function (event)
		self:music(setbutton,startbutton)
		setbutton:setButtonEnabled(false)
		startbutton:setButtonEnabled(false)
	end)
	:addTo(self)
	self:buttonEvent(setbutton)
	

	local imagemoregames = {
	normal = "#moreGames.png",	
	pressed = "#moreGames.png",
	disabled = "#moreGames.png"
	}
	local moregames = cc.ui.UIPushButton.new(imagemoregames)
	:pos(display.width - display.cy / 4, display.height - display.cy / 4)
	:setScale(0.9)
	:addTo(self)
	self:buttonEvent(moregames)

end

function StartScene:music(setbutton,startbutton)

	local musicset = display.newSprite("#soundSetBg.png")
	:pos(display.cx, display.cy)
	:addTo(self,2)
	local sizeofMST = musicset:getContentSize()

	local imagesoundEF = {
	off = "#sound_setClose.png",
	off_pressed = "#sound_setClose.png",
	off_disabled = "#sound_setClose.png",
	on = "#sound_setOpen.png",
	on_pressed = "#sound_setOpen.png",
	on_disabled = "#sound_setOpen.png"

	}
	local soundeffect = cc.ui.UICheckBoxButton.new(imagesoundEF)
	:pos(sizeofMST.width / 2.8, sizeofMST.height / 2)
	:addTo(musicset)

	local bgm = cc.ui.UICheckBoxButton.new(imagesoundEF)
	:pos(sizeofMST.width * 0.79, sizeofMST.height / 2)
	:addTo(musicset)

	local imagesetagain = {
	normal = "#setAgainButton.png",
	pressed = "#setAgainButton.png",
	disabled = "#setAgainButton.png"
	}

	local setagain  = cc.ui.UIPushButton.new(imagesetagain)
	:pos(sizeofMST.width /5 ,sizeofMST.height /6)
	:addTo(musicset)
	setagain:onButtonClicked(function()
		self:restrat(setagain,soundeffect,bgm)
		setagain:setButtonEnabled(false)
		soundeffect:setButtonEnabled(false)
		bgm:setButtonEnabled(false)
		-- body
	end)
	self:buttonEvent(setagain)

	local imageteach = {
	normal = "#setTeachButton.png",
	pressed = "#setTeachButton.png",
	disabled = "#setTeachButton.png"
	}

	local setteach  = cc.ui.UIPushButton.new(imageteach)
	:pos(sizeofMST.width /2 ,sizeofMST.height /6)
	:addTo(musicset)
	self:buttonEvent(setteach)

	local imageabout = {
	normal = "#setAboutButton.png",
	pressed = "#setAboutButton.png",
	disabled = "#setAboutButton.png"
	}

	local setabout  = cc.ui.UIPushButton.new(imageabout)
	:pos(sizeofMST.width * 0.8 ,sizeofMST.height /6)
	:addTo(musicset)
	self:buttonEvent(setabout)



	local imageclose = {
	normal = "#setCloseButton.png",
	pressed = "#setCloseButton.png",
	disabled = "#setCloseButton.png"
	}

	local setclose  = cc.ui.UIPushButton.new(imageclose)
	:pos(sizeofMST.width * 0.95,sizeofMST.height*0.82)
	:addTo(musicset)
	setclose:onButtonClicked(function (event)
		musicset:removeFromParent()
		setbutton:setButtonEnabled(true)
		startbutton:setButtonEnabled(true)
	end)

end

function StartScene:restrat(setagain,soundeffect,bgm)
	local restart = display.newSprite("#restartPopLayer .png")
	:pos(display.cx, display.cy)
	:addTo(self,3)
	restart:setTouchSwallowEnabled(true)
	local sizeofRST = restart:getContentSize()

	local label1 = cc.ui.UILabel.new({
		text = "重 置 数 据",
		size = 26,
		color = cc.c3b(255, 0, 0)
		})
	:align(1,sizeofRST.width / 2, sizeofRST.height*.8)
	:addTo(restart)

	local label2 = cc.ui.UILabel.new({
		text = "重 置 后 您 将 失 去 所 有 的 进 度\n是 否 重 置？",
		size = 18,
		color = cc.c3b(255, 0, 0) 
		})
	:align(5,sizeofRST.width*0.1, sizeofRST.height*.5)
	:addTo(restart)

	local imagesure = {
	normal = "#restartPopSure.png",
	pressed = "#restartPopSure.png",
	disabled = "#restartPopSure.png"
	}
	local sure = cc.ui.UIPushButton.new(imagesure)
	:pos(sizeofRST.width *.75,sizeofRST.height / 5)
	:addTo(restart)
	self:buttonEvent(sure)

	local imagescancle= {
	normal = "#restartPopCancle.png",
	pressed = "#restartPopCancle.png",
	disabled = "#restartPopCancle.png"
	}
	local cancel = cc.ui.UIPushButton.new(imagescancle)
	:pos(sizeofRST.width *0.25,sizeofRST.height / 5)
	:addTo(restart)
	cancel:onButtonClicked(function()
		restart:removeFromParent()
		setagain:setButtonEnabled(true)
		soundeffect:setButtonEnabled(true)
		bgm:setButtonEnabled(true)
	end)
	self:buttonEvent(cancel)


	-- body

end

function StartScene:logoaction()
	local move = cc.MoveTo:create(1,cc.p(0,0))
	local el = cc.EaseElasticOut:create(move)
	return el

end

function StartScene:playaction()
	local scale = cc.ScaleTo:create(0.1,1.3,0.8,1)
	local scale3 = cc.ScaleTo:create(1.5,1,1,1)
	local el3 = cc.EaseElasticOut:create(scale3)
	local del = cc.DelayTime:create(3)
	local sq = cc.Sequence:create(scale,el3,del)

	local rep = cc.RepeatForever:create(sq)
	return rep

end

function StartScene:buttonEvent(btnname)
	btnname:onButtonPressed(function(event)
		local scl = cc.ScaleTo:create(0.1,1.2)
		btnname:runAction(scl)
	end)
	btnname:onButtonRelease(function(event)
		local scl2 = cc.ScaleTo:create(0.1,1)
		btnname:runAction(scl2)
	end)
	
end
function StartScene:onEnter()

end

function StartScene:onExit()

end

return StartScene