--project- Zombie attack

local storyboard = require ("storyboard")
local scene = storyboard.newScene ()

--Housekeeping stuff

require "sprite"

--physics.setDrawMode("hybrid")

--local scene = storyboard.newScene()

local centerX = display.contentCenterX
local centerY = display.contentCenterY

--set up forward references

function scene:createScene(event)

	local physics = require "physics"
	physics.start()
	physics.setGravity( 0, 0)
	--physics.setDrawMode("hybrid")

	local screenGroup = self.view
	
	background1 = display.newImage("background1.png")
	background1.x = centerX
	background1.y = centerY
	screenGroup:insert(background1)
	
	cave = display.newImage("cave.png")
	cave.x = 630
	cave.y = 120
	caveShape = {-120,-100,90,-110,20,10,-120,110}
	physics.addBody(cave, "static", {density=1.6, bounce=0.1, friction=.2, shape = caveShape })
	screenGroup:insert(cave)
	
	tree = display.newImage("tree1.png")
	tree.x = 625
	tree.y = 890
	treeShape = {-40,-12,50,-12,50,40,-40,40}
	physics.addBody(tree, "static", {bounce=0.1, friction=.2, shape=treeShape})
	screenGroup:insert(tree)
	
	grave1 = display.newImage("grave1.png")
	grave1.x = 590
	grave1.y = 550
	grave1shape = {-40,-12,70,-20,70,12,-40,20}
	physics.addBody(grave1, "static", {bounce=0.1, friction=.2, shape=grave1shape})
	screenGroup:insert(grave1)
	
	grave2 = display.newImage("grave2.png")
	grave2.x = 590
	grave2.y = 400
	grave2Shape = {-40,-12,50,-12,50,12,-40,12}
	physics.addBody(grave2, "static", {bounce=0.1, friction=.2, shape=grave2Shape})
	screenGroup:insert(grave2)
	
	
	
	--zombies--
	
	local zombieSpriteSheet = sprite.newSpriteSheet("zombiesprite1.png",143 , 90)
	zombieSprites = sprite.newSpriteSet(zombieSpriteSheet, 1, 9)
	sprite.add(zombieSprites, "zombie", 1, 9, 1000, 0)
	zombie1 = sprite.newSprite(zombieSprites)
	zombie1Shape = {-40,-30,50,-30,50,20,-40,20}
	physics.addBody(zombie1, "kenematic", {bounce=0.0, friction=.2,shape=zombie1Shape})
	zombie1.x = 590
	zombie1.y = 550
	zombie1.alpha = 0
	zombie1.isFixedRotation = true
	local state = zombie1.isFixedRotation
	screenGroup:insert(zombie1)
	zombie1:prepare("zombie")
	zombie1:play()
	
	local zombie2SpriteSheet = sprite.newSpriteSheet("zombiesprite1.png",143 , 90)
	zombie2Sprites = sprite.newSpriteSet(zombie2SpriteSheet, 1, 9)
	sprite.add(zombie2Sprites, "zombie2", 1, 9, 900, 0)
	zombie2 = sprite.newSprite(zombie2Sprites)
	zombie2Shape = {-40,-30,50,-30,50,20,-40,20}
	physics.addBody(zombie2, "kenematic", {bounce=0.0, friction=.2,shape=zombie2Shape})
	zombie2.x = 590
	zombie2.y = 400
	zombie2.alpha = 0
	zombie2.isFixedRotation = true
	local state = zombie2.isFixedRotation
	screenGroup:insert(zombie2)
	zombie2:prepare("zombie2")
	zombie2:play()
	
	--hero sprite--
	
	local heroSpriteSheet = sprite.newSpriteSheet("herosprite4.png",150 , 80)
	heroSprites = sprite.newSpriteSet(heroSpriteSheet, 1, 15)
	sprite.add(heroSprites, "godown", 1, 1, 1000, 0)
	sprite.add(heroSprites, "goup", 6, 1, 1000, 0)
	sprite.add(heroSprites, "goright", 2, 4, 1000, 0)
	sprite.add(heroSprites, "goleft", 7, 4, 1000, 0)
	sprite.add(heroSprites, "swardattack", 11, 5, 350,1)
	hero = sprite.newSprite(heroSprites)
	heroShape = {-50,-12,30,-12,30,12,-50,12}
	heroAttackShape = {-50,-12,30,-12,30,12,-50,12}
	physics.addBody(hero, "dynamic", {bounce=0.0, friction=4.5, shape=heroShape})
	hero.x = 300
	hero.y = centerY
	hero.isFixedRotation = true
	local state = hero.isFixedRotation
	screenGroup:insert(hero)
	
	
	
	
	--D-pad--
	
	up = display.newImage("up.png")
	up.x = 200
	up.y = 880
	screenGroup:insert(up)
	
	down = display.newImage("down.png")
	down.y = 880
	down.x = 70
	screenGroup:insert(down)
	
	left = display.newImage("left.png")
	left.y = 815
	left.x = 135
	screenGroup:insert(left)
	
	right = display.newImage("right.png")
	right.y = 940
	right.x = 135
	screenGroup:insert(right)
	
	--Attack--
	
	attack = display.newImage("atackbtn1.png")
	attack.x = 150
	attack.y = 100
	screenGroup:insert(attack)

end

--D-Pad--

local motionx = 0
local motiony = 0
local speed = 7

local function stop (event)

	if event.phase == "ended" then
	motionx = 0
	motiony = 0
	end
end

local function moveHero(event)

	hero.x = hero.x + motionx
	hero.y = hero.y + motiony
end

local function goingup(event)

	if event.phase == "began" then
	motionx = speed
	motiony = 0
	hero:prepare("goup")
	hero:play()
	end
	
end

local function goingdown(event)

	if event.phase == "began" then
	motionx = -speed
	motiony = 0
	hero:prepare("godown")
	hero:play()
	end
	
end

local function goingleft(event)

	if event.phase == "began" then
	motionx = 0
	motiony = -speed
	hero:prepare("goleft")
	hero:play()
	end
	
end

local function goingright(event)

	if event.phase == "began" then
	motionx = 0
	motiony = speed
	hero:prepare("goright")
	hero:play()
	end
	
end

--hero ray cast--

--    local range = 40
	--local hits = phisics.rayCast(hero.x, hero.y + range, hero.y)
	--lo-cal line = display.newline(hero.x, hero.y + range, hero.y)
	--line:setColor(0,0,225)


local function attacking(event)
	
	if event.phase == "began" then
	--hero:setSequence(changebody)
	--phisics.removeBody(hero)
	--phisics.addBody(hero, { shape=heroAttackShape }
	hero:prepare("swardattack")
	hero:play()

	end
end

--walls--

local function walls(event)

	if hero.x < 70 then 
	hero.x = 70
	end
	
	if hero.x > 700 then 
	hero.x = 700
	end
	
	if hero.y > 990 then 
	hero.y = 990
	end
	
	if hero.y < 40 then 
	hero.y = 40
	end
	
	if speed < 0 then
	speed = 0
	end
	
end

function cave_btn(event)
	if event.phase == "began" then
		print("start")
		storyboard.gotoScene("level2start", "fade", 300)
	end
end


function onCollision (event)
	if event.phase == "began" then
	--storyboard.gotoScene("level2start", "fade", 400)
		if(zombie1) or (zombie2) then
			zombie1:removeSelf()
			zombie1 = nil
			
			zombie2:removeSelf()
			zombie2 = nil
		end
	end
end

--move-zombies--

local function startGame()
	transition.to( zombie1, { time=3000, alpha=1 } )
	transition.to( zombie2, { time=3000, alpha=1 } )
	transition.to( zombie1, { time=20000, y=hero.y, x=hero.x } )
	transition.to( zombie2, { time=20000, y=hero.y, x=hero.x } )
end

function scene:enterScene(event)

	storyboard.purgeScene("start")
	
	Runtime:addEventListener("touch", stop)
	Runtime:addEventListener("enterFrame", moveHero)
	up:addEventListener("touch", goingup)
	down:addEventListener("touch", goingdown)
	left:addEventListener("touch", goingleft)
	right:addEventListener("touch", goingright)
	attack:addEventListener("touch", attacking)
	Runtime:addEventListener("enterFrame", walls)
	cave:addEventListener("touch", cave_btn)
	--attack:addEventListener("touch", heroRayCast)
	Runtime:addEventListener("collision", onCollision)
	--zombie2.enterFrame = zombieAttacking
	--Runtime:addEventListener("enterFrame", zombie2)
	startGame()
end

function scene:exitScene(event)

	Runtime:removeEventListener("touch", stop)
	Runtime:removeEventListener("enterFrame", moveHero)
	up:removeEventListener("touch", goingup)
	down:removeEventListener("touch", goingdown)
	left:removeEventListener("touch", goingleft)
	right:removeEventListener("touch", goingright)
	attack:removeEventListener("tap", attacking)
	Runtime:removeEventListener("enterFrame", walls)
	cave:removeEventListener("touch", cave_btn)
	--attack:removeEventListener("tap", heroRayCast)
	Runtime:removeEventListener("collision", onCollision)
	--Runtime:removeEventListener("enterFrame", zombie2)
end

function scene:destroyScene(event)

end

function scene:didExitScene(event)
storyboard.removeScene( "level1")
end

scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)
scene:addEventListener("didExitScene")

return scene
