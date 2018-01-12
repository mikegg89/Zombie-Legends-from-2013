display.setStatusBar(display.HiddenStatusBar)

physics = require "physics"
physics.start()
physics.setGravity( 0, 0)
--physics.setDrawMode("hybrid")

local storyboard = require "storyboard"
storyboard.gotoScene ("start")