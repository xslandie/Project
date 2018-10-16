-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()	 
physics.setGravity( 0, 0 )
 	 
--Set Random Number Generator
math.randomseed( os.time() )

--configure image sheet
local sheetOption =
{
   frames =
   {
    {   -- 1) dinosaur
            x = 0,
            y = 0,
            width = 102,
            height = 85
        },
    {   -- 2) putin 
            x = 0,
            y = 265,
            width = 98,
            height = 76
        },
    {   -- 3) bear
            x = 98,
            y = 265,
            width = 20,
            height = 40
   
   },
},

}

local objectSheet = graphics.newImageSheet( "gameObject.png", sheetOption)


--initialaze variabiles
local lives = 3
local score = 0
local died = false
 
local dinosaurTable = {}
 
local putin
local gameLoopTimer
local livesText
local scoreText

-- Set up Audio 
inno = audio.loadStream("Sounds/inno_russia.mp3" )
audio.play(inno, { loops = -1, fadein = 750, channel = 1 } )

-- Set up display groups
local backGroup = display.newGroup()  -- Display group for the background image
local mainGroup = display.newGroup()  -- Display group for the putin, dinosaur, bear, etc.
local uiGroup = display.newGroup()    -- Display group for UI objects like the score

-- Load the background
local background = display.newImageRect( backGroup, "background.jpg", 800, 1400 )
background.x = display.contentCenterX
background.y = display.contentCenterY

putin = display.newImageRect( mainGroup,"gameObject.png", 150, 110 )
putin.x = display.contentCenterX
putin.y = display.contentCenterY +200
physics.addBody( putin, { radius=30, isSensor=true } )
putin.myName = "putin"

-- Display lives and score
livesText = display.newText( uiGroup, "Lives: " .. lives, 200, 80, native.systemFont, 36 )
scoreText = display.newText( uiGroup, "Score: " .. score, 400, 80, native.systemFont, 36 )

-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local function updateText()
    livesText.text = "Lives: " .. lives
    scoreText.text = "Score: " .. score
end


local function createDinosaur()
     local newDinosaur = display.newImageRect( mainGroup, "dinosaur.jpg" 102, 85 )
	 table.insert( dinosaurTable, newDinosaur )
	 physics.addBody( newDinosaur, "dynamic", { radius=40, bounce=0.8 } )
	 newDinosaur.myName = "dinosaur"
	 
	 local whereFrom = math.random( 3 )
	 
	 if (whereFrom ==  1 ) then
	         -- From the left
        newDinosaur.x = -60
        newDinosaur.y = math.random( 500 )
        newDinosaur:setLinearVelocity( math.random( 40,120 ), math.random( 20,60 ) )
    elseif ( whereFrom == 2 ) then
        -- From the top
        newDinosaur.x = math.random( display.contentWidth )
        newDinosaur.y = -60
        newDinosaur:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )
    elseif ( whereFrom == 3 ) then
        -- From the right
        newDinosaur.x = display.contentWidth + 60
        newDinosaur.y = math.random( 500 )
        newDinosaur:setLinearVelocity( math.random( -120,-40 ), math.random( 20,60 ) )
	 end
	 newDinosaur:applyTorque( math.random( -6,6 ) )
end

local function fireBear()
 
    local newBear = display.newImageRect( mainGroup, "bear.jpeg" 14, 40 )
    physics.addBody( newBear, "dynamic", { isSensor=true } )
    newBear.isBullet = true
    newBear.myName = "bear"
	
	newBear.x = putin.x
    newBear.y = putin.y
	newBear:toBack()
	
	transition.to( newBear, { y=-40, time=500, } )
end
