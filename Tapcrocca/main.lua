-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local tapCount = 0

local background = display.newImageRect( "background.jpg", 800, 1400 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local tapText = display.newText( tapCount, display.contentCenterX, 20, native.systemFont, 40 )
tapText:setFillColor( 255, 192, 203 )

local platform = display.newImageRect( "platform.jpg", 300, 50 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25

local croccantini = display.newImageRect( "croccantini.jpg", 100, 112 )
croccantini.x = display.contentCenterX
croccantini.y = display.contentCenterY
croccantini.alpha = 0.8

local physics = require( "physics" )
physics.start()

physics.addBody( platform, "static" )
physics.addBody( croccantini, "dynamic", { radius=50, bounce=0.3 } )

local function pushCroccantini()
croccantini:applyLinearImpulse( 0, -0.75, croccantini.x, croccantini.y )
tapCount = tapCount + 1
    tapText.text = tapCount
end

croccantini:addEventListener( "tap", pushCroccantini )
 
 dioporco