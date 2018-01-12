--requires--

local storyboard = require ("storyboard")
local scene = storyboard.newScene()

centerX = display.contentCenterX
centerY = display.contentCenterY

--background--

function scene:createScene(event)

	local screenGroup = self.view
	
	background1 = display.newImage("background1.png")
	background1.x = centerX
	background1.y = centerY
	screenGroup:insert(background1)

	tree = display.newImage("tree1.png")
	tree.x = 625
	screenGroup:insert(tree)

	grave1 = display.newImage("grave1.png")
	grave1.x = 580
	grave1.y = 750
	screenGroup:insert(grave1)

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
	
end

function start(event)
	if event.phase == "began" then
		print("start")
		storyboard.gotoScene("level1", "fade", 600)
	end
end

function scene:enterScene(event)
	play_btn:addEventListener("touch", start)
end

function scene:exitScene(event)
	play_btn:removeEventListener("touch", start)
end
function scene:destroyScene(event)
end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene