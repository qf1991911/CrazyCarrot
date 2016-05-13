display.addSpriteFrames("UI/ui_handbook.plist", "UI/ui_handbook.png")
local HandBook = class("HandBook", function()
	return display.newScene("HandBook")
end)

function HandBook:ctor()
	self:background()
	self:boundary()
end
function HandBook:background()
	self.bg = display.newSprite("pic/heroAchieveBG.png")
	self.bgsize = self.bg:getContentSize() 
	self.bg:pos(display.cx, display.cy)
	self.bg:addTo(self)
end
function HandBook:boundary()
	self.Boundary = display.newSprite("#handbookBg.png")
	self.Boundary:pos(self.bgsize.width / 2, self.bgsize.height /2 )
	self.Boundary:addTo(self.bg)
end
function HandBook:towerlist()
	local listview = cc.ui.UIListView.new({
		direction = UIScrollView.DIRECTION_HORIZONTAL,
		viewRect = cc.rect(0,0,215,458)
		})
	listview:addTo(self.Boundary)
	local item1 = listview:newItem()
	-- body
end
function HandBook:onEnter()
	-- body
end
function HandBook:onExit()
	-- body
end
return HandBook