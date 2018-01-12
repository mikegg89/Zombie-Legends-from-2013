--requires--

local storyboard = require ("storyboard")
local scene = storyboard.newScene()

centerX = display.contentCenterX
centerY = display.contentCenterY

--background--

function scene:createScene(event)

	local screenGroup = self.view
	
	background3 = display.newImage("level2_bg.png")
	background3.x = centerX
	background3.y = centerY
	screenGroup:insert(background3)

	gate = display.newImage("maingate1.png")
	gate.x = centerX
	gate.y = centerY
	screenGroup:insert(gate)
	
	title = display.newImage("title.png")
	title.x = 350
	title.y = centerY
	screenGroup:insert(title)
	
	play_btn = display.newImage("play_btn.png")
	play_btn.x = 715
	play_btn.y = 880
	screenGroup:insert(play_btn)
	
	level2_btn = display.newImage("play_btn.png")
	level2_btn.x = 650
	level2_btn.y = 880
	screenGroup:insert(level2_btn)
	
	level3_btn = display.newImage("play_btn.png")
	level3_btn.x = 585
	level3_btn.y = 880
	screenGroup:insert(level3_btn)
end

function start(event)
	if event.phase == "began" then
		print("start")
		storyboard.gotoScene("level1", "fade", 300)
	end
end

function lev2(event)
	if event.phase == "began" then
		print("start")
		storyboard.gotoScene("level2", "fade", 300)
	end
end

function scene:enterScene(event)

	storyboard.purgeScene("level2")
	storyboard.purgeScene("level1")
	storyboard.removeScene("level1")
	storyboard.removeScene("level2")
	
	play_btn:addEventListener("touch", start)
	level2_btn:addEventListener("touch", lev2)
end

function scene:exitScene(event)
	play_btn:removeEventListener("touch", start)
	level2_btn:removeEventListener("touch", lev2)
end
function scene:destroyScene(event)
end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene