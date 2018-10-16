-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()	 
physics.setGravity( 0, 0 )
inno = audio.loadStream("Sounds/inno_russia.mp3" ) 	 
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
audio.play(background, { loops = -1, fadein = 750, channel = 1 } )

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
     local newDinosaur = display.newImageRect( mainGroup, objectSheet, 1, 102, 85 )

 
end