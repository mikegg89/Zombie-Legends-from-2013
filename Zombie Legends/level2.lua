--project- Zombie attack

local storyboard = require ("storyboard")
local scene = storyboard.newScene ()

--Housekeeping stuff

require "sprite"
--local physics = require "physics"
--physics.start()
--physics.setGravity( 0, 0)
--physics.setDrawMode("hybrid")

--local scene = storyboard.newScene()

local centerX = display.contentCenterX
local centerY = display.contentCenterY

--set up forward references

function scene:createScene(event)

	local screenGroup = self.view
	
	background2 = display.newImage("level2_bg.png")
	background2.x = centerX
	background2.y = centerY
	screenGroup:insert(background2)
		
	--zombies--
	
	local zombieSpriteSheet = sprite.newSpriteSheet("zombiesprite1.png",143 , 90)
	zombieSprites = sprite.newSpriteSet(zombieSpriteSheet, 1, 9)
	sprite.add(zombieSprites, "zombie", 1, 9, 1000, 0)
	zombie1 = sprite.newSprite(zombieSprites)
	zombie1Shape = {-40,-30,50,-30,50,20,-40,20}
	physics.addBody(zombie1, "kenematic", {bounce=0.0, friction=.2,shape=zombie1Shape})
	zombie1.x = 690
	zombie1.y = 850
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
	
	
		--torches--
	local torchSpriteSheet = sprite.newSpriteSheet("torchsprite.png",100 , 74)
	torchSprites = sprite.newSpriteSet(torchSpriteSheet, 1, 6)
	sprite.add(torchSprites, "rightwall", 1, 3, 1000, 0)
	righttorch = sprite.newSprite(torchSprites)
	torchShape = {-50,-20,500,-70,60,32,-540,40}
	physics.addBody(righttorch, "static", {bounce=0.0, friction=4.5, shape=torchShape})
	righttorch.x = 520
	righttorch.y = 960
	righttorch:prepare("rightwall")
	righttorch:play()
	screenGroup:insert(righttorch)
	
	local torchlSpriteSheet = sprite.newSpriteSheet("torchsprite.png",100 , 74)
	torchlSprites = sprite.newSpriteSet(torchlSpriteSheet, 1, 6)
	sprite.add(torchlSprites, "leftwall", 4, 3, 1000, 0)
	lefttorch = sprite.newSprite(torchlSprites)
	torchlShape = {-540,-40,500,-30,50,12,-10,12}
	physics.addBody(lefttorch, "static", {bounce=0.0, friction=4.5, shape=torchlShape})
	lefttorch.x = 540
	lefttorch.y = 60
	lefttorch:prepare("leftwall")
	lefttorch:play()
	screenGroup:insert(lefttorch)
	
	
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
	physics.addBody(hero, "dynamic", {bounce=0.0, friction=4.5, shape=heroShape})
	hero.x = 100
	hero.y = centerY
	hero.isFixedRotation = true
	local state = hero.isFixedRotation
	screenGroup:insert(hero)
	
	--D-pad--
	
	up = display.newImage("blackup.png")
	up.x = 200
	up.y = 880
	screenGroup:insert(up)
	
	down = display.newImage("blackdown.png")
	down.y = 880
	down.x = 70
	screenGroup:insert(down)
	
	left = display.newImage("blackleft.png")
	left.y = 815
	left.x = 135
	screenGroup:insert(left)
	
	right = display.newImage("blackright.png")
	right.y = 940
	right.x = 135
	screenGroup:insert(right)
	
	--Attack--
	
	attack = display.newImage("blackatackbtn1.png")
	attack.x = 150
	attack.y = 100
	screenGroup:insert(attack)

end

-- preload audio

-- game functions

--spawn zombies--

--local function spawn()
	
	--return zombie1
--end




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
	
	--if event.phase == "ended" then
	--up:removeEventListener("touch", goingup)
	--end
end

local function goingdown(event)

	if event.phase == "began" then
	motionx = -speed
	motiony = 0
	hero:prepare("godown")
	hero:play()
	end
	
	--if event.phase == "ended" then
	--down:removeEventListener("touch", goingdown)
	--end
end

local function goingleft(event)

	if event.phase == "began" then
	motionx = 0
	motiony = -speed
	hero:prepare("goleft")
	hero:play()
	end
	
	--if event.phase == "ended" then
	--left:removeEventListener("touch", goingleft)
	--end
end

local function goingright(event)

	if event.phase == "began" then
	motionx = 0
	motiony = speed
	hero:prepare("goright")
	hero:play()
	end
	
	--if event.phase == "ended" then
	--right:removeEventListener("touch", goingright)
	--end
end

--attack--

local function attacking(event)
	
	if event.phase == "began" then
	hero:prepare("swardattack")
	hero:play()
	end
	
	--if event.phase == "ended" then
	--attack:removeEventListener("tap", attacking)
	--end
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


function onCollision (event)
	if event.phase == "began" then
	--storyboard.gotoScene("level3start", "fade", 400)
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
	
	transition.to( zombie1, { time=2000, alpha=1 } )
	transition.to( zombie2, { time=2000, alpha=1 } )
	transition.to( zombie1, { time=20000, y=hero.y, x=hero.x } )
	transition.to( zombie2, { time=20000, y=hero.y, x=hero.x } )
end

function scene:enterScene(event)
	
	storyboard.purgeScene("level1")
	storyboard.purgeScene("level2start")
	storyboard.purgeScene("level3start")

	
	Runtime:addEventListener("touch", stop)
	Runtime:addEventListener("enterFrame", moveHero)
	up:addEventListener("touch", goingup)
	down:addEventListener("touch", goingdown)
	left:addEventListener("touch", goingleft)
	right:addEventListener("touch", goingright)
	attack:addEventListener("touch", attacking)
	Runtime:addEventListener("enterFrame", walls)
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
	Runtime:removeEventListener("collision", onCollision)
	--Runtime:removeEventListener("enterFrame", zombie2)
end

function scene:destroyScene(event)

end

scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)

return scene
