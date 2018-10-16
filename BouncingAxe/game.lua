
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local player
local physics= require("physics")

local plat



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	local background= display.newImageRect(sceneGroup,"background.jpg",800,1400)
	background.x= display.contentCenterX
	background.y= display.contentCenterY
	local roof = display.newRect(display.contentCenterX, 0, display.contentWidth, 5) 
    local leftW= display.newRect(0,display.contentCenterY,5,display.contentHeight)

	
	
	plat = display.newImageRect( "platform.png", 300 , 50 )
 plat.x= display.contentCenterX
 plat.y= display.contentHeight-25
	
	
	player= display.newImageRect(sceneGroup,"axe.png",150,120)
	player.x= display.contentCenterX
	player.y= display.contentCenterY-200
	physics.start()
	physics.addBody(player,"dynamic" ,{bounce=1})
	physics.addBody(plat,"static")
	physics.addBody( roof, "static", { friction=0.5, bounce=0.3 } )
	physics.addBody( leftW, "static", { friction=0.5, bounce=0.3 } )
	player.angularVelocity=10
	
	
	
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
