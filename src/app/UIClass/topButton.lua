display.addSpriteFrames("UI/ui_public1.plist","UI/ui_public1.png")
local topButton = class("topButton", function(parentNode, sceneName)
    local node2 = display.newNode()
    node2.tScene = sceneName
    node2.parentNode = parentNode
	parentNode:addChild(node2)
	return 	node2
end)
function topButton:ctor()
	local buttonbg1 = self:createSprite("#buttonBg.png", 0.28, 0.9)
	:setScaleX(2.2)
	:setScaleY(0.9)
	local bloodNow = self:createSprite("#bloodNew.png", 0.22, 0.9)
	local addNew1 = self:createButton("#addNew.png", 0.35, 0.9, 0.01, 0.9)
	:onButtonClicked(function(event)
		print("···")
	end)

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.53, 0.9)
	:setScaleX(2.2)
	:setScaleY(0.9)
	local  coinNew = self:createSprite("#coinNew.png", 0.47, 0.9)
	local addNew2 = self:createButton("#addNew.png", 0.6, 0.9, 0.01, 0.9)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local buttonbg2 = self:createSprite("#buttonBg.png", 0.78, 0.9)
	:setScaleX(2.2)
	:setScaleY(0.9)
	local diamondNew = self:createSprite("#diamondNew.png", 0.72, 0.9)
	local addNew3 = self:createButton("#addNew.png", 0.85, 0.9, 0.01, 0.9)
	:onButtonClicked(function(event)
		print("···")
	end)	

	local returnButton = self:createButton("#returnNew.png", 0.15, 0.9,0.01, 0.9)
	:onButtonClicked(function(event)
		if self.tScene == "self" and self:getParent().trun then
			local parentNode = self:getParent()
			parentNode:getParent():getChildByTag(1):show()
			parentNode:removeFromParent()
			parentNode = nil
		elseif self.tScene == "self" and not self:getParent().trun then
			local parentNode = self:getParent()
			local scale1 = cc.ScaleTo:create(0.5, 0, 0.9, 1)
			local callback = cc.CallFunc:create(function()	
				parentNode.listView2:hide()
				parentNode.pre_itemBarBg:hide()
				parentNode.pre_itemLabel:hide()
				parentNode.listView:show()
				parentNode.pre_taskLabel:show()
				parentNode.littleTaskIcon:show()
				self:getParent().trun = not self:getParent().trun
			end)
			local scale2 = cc.ScaleTo:create(0.5, 0.8, 0.9, 1)
			local action = cc.Sequence:create(scale1, callback, scale2)
			parentNode.pre_taskBg:runAction(action)			
		else
			display.replaceScene(require(".app.scenes." .. self.tScene):new())
		end	
	end)
end
function topButton:createButton(path, posX, posY,time, scale)
	local images = {
	normal = path,
	pressed = path
	}
	local button = cc.ui.UIPushButton.new(images)
	button:setPosition(display.width * posX, display.height * posY)
	:scaleTo(time, scale)
	:onButtonPressed(function(event)
		button:scaleTo(0.1, 1.1)
		end)
	:onButtonRelease(function(event)
		button:scaleTo(0.1, scale)
		end)	
	self:addChild(button)
	return button
end
function topButton:createSprite(pic,posX,posY)
	local sprite = display.newSprite(pic)
	:setPosition(display.width * posX, display.height * posY)
	self:addChild(sprite)
	return sprite
end
function topButton:onEnter()
	-- body
end
function topButton:onExit()
	-- body
end
return topButton