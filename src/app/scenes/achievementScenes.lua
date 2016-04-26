display.addSpriteFrames("UI/ui_achievement.plist","UI/ui_achievement.png")
display.addSpriteFrames("UI/ui_handbook.plist","UI/ui_handbook.png")
local Tabel = require(".app.stageConfig.stageLevelInformation")
local achievementScenes = class("achievementScenes", function()
    return display.newScene("achievementScenes")
end)
function achievementScenes:ctor()
	local heroAchieveBG = self:createSprite("pic/heroAchieveBG.png",0.5, 0.5, self)

	local achievetitleBg = self:createSprite("#handbookBg.png",0.5, 0.42 ,self)
	:setScaleX(0.9)
	
	local achievetitle = self:createSprite("#achievetitle.png",0.5, 0.78 ,self)
	self:listView()
	



end
function achievementScenes:createSprite(pic,posX,posY,parentNode)
	local sprite = display.newSprite(pic)
	:setPosition(display.width * posX, display.height * posY)
	if parentNode then
		parentNode:addChild(sprite)
	end
	
	return sprite
end
function achievementScenes:listView()
	local listView = cc.ui.UIListView.new({
		-- bgColor = cc.c4b(255, _g, _b, 255),
		viewRect = cc.rect(display.width * 0.15, display.height * 0.1, display.width * 0.7, display.height * 0.6)
	})
	-- :onTouch(print("···"))
	self:addChild(listView)
	listView:setBounceable(false)
	for i = 1, #Tabel["item"] do
	-- for i,v in pairs(Tabel["item"]) do
		local item = listView:newItem()

		local content = display.newSprite("#achieveBar.png")
		:setScale(0.86, 0.8)
		item:addContent(content)
		item:setItemSize(content:getContentSize().width * 0.86, content:getContentSize().height * 0.75)
		listView:addItem(item)
		local achieveDiamond = self:createSprite("#achieveDiamond.png",0.088, 0.13,content)
		:setScale(0.8)
		local tabel1 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = Tabel["item"][i][1],
			size = 20
			})
		:setPosition(display.width * 0.074, display.height * 0.07)
		content:addChild(tabel1)
		local tabel2 = cc.ui.UILabel.new({
			UILabelType = 2,
			text = Tabel["item"][i][2],
			size = 30
			})
		:setPosition(display.width * 0.25, display.height * 0.15)
		content:addChild(tabel2)
		-- local loadBar = cc.ui.UILoadingBar.new({
		-- 	scale9 = true,
		-- 	capInsets = cc.rect(0, 0, 337,24),
		-- 	image = "#achieve_bar2.png",
		-- 	viewRect = cc.rect(0, 0, 337,24 ),
		-- 	percent = 60,
		-- 	direction = DIRETION_RIGHT_TO_LEFT 			
		-- 	})
		-- :setPosition(display.width * 0.244, display.height * 0.071)
		-- content:addChild(loadBar)
		local running = self:createSprite("#running.png",0.7, 0.1,content)
		 -- 创建进度条的动画渲染器  
	  local left = cc.ProgressTimer:create(display.newSprite("#achieve_bar2.png"))  
	  -- 设置进度条类型，这里是条形进度类型  
	  left:setType(cc.PROGRESS_TIMER_TYPE_BAR)  
	  -- 设置圆心位置为左下角  
	  -- left:setMidpoint(cc.p(0, 0))  
	  -- 设置横向进度条变化率，y=0意味着没有竖向的变化  
	  --left:setBarChangeRate(cc.p(1, 0))  
	  -- 设置在x=100,y为屏幕宽度一半的位置  
	  left:setPosition(100, 5)  
	  
	  content:addChild(left)

		

	end
	listView:reload()



end
function achievementScenes:onEnter()
	-- body
end
function achievementScenes:onExit()
	-- body
end
return achievementScenes