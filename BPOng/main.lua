-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local function onCollisionEggs(event)
end

local pass=display.contentHeight/5
local xMin=40
local xMax=display.contentWidth/2
local yMin=pass
local yMax=display.contentHeight
local function dragPaddle( event )

	local paddle = event.target
	local phase = event.phase

	if ( "began" == phase ) then
		-- Set touch focus on the paddle
		display.currentStage:setFocus( paddle )
		-- Store initial offset position
		
		paddle.touchOffsetX = event.x - paddle.x
		paddle.touchOffsetY = event.y - paddle.y

	elseif ( "moved" == phase ) then
		-- Move the paddle to the new touch position
		paddle.x = event.x - paddle.touchOffsetX
		if(paddle.x<xMin) then paddle.x=xMin end
		if(paddle.x>xMax) then paddle.x=xMax end
		paddle.y = event.y - paddle.touchOffsetY
		if(paddle.y<yMin) then paddle.y=yMin end
		if(paddle.y>yMax) then paddle.y=yMax end

	elseif ( "ended" == phase or "cancelled" == phase ) then
		-- Release touch focus on the paddle
		display.currentStage:setFocus( nil )
	end

	return true  -- Prevents touch propagation to underlying objects
end

--variables+basic graphics
display.setStatusBar( display.HiddenStatusBar)
local physics= require("physics")
local background = display.newRect(display.contentCenterX,display.contentCenterY,1400,display.contentHeight)
background:setFillColor(0)

local roof = display.newRect(display.contentCenterX, pass, display.contentWidth, 2) 
    local leftW= display.newRect(0,display.contentCenterY,2,display.contentHeight)
    local rightW= display.newRect(display.contentWidth,display.contentCenterY,2,display.contentHeight)
	local f1oor = display.newRect(display.contentCenterX,display.contentHeight, display.contentWidth, 2)
	--leftW.isVisible= false
	--rightW.isVisible=false
	--roof.isVisible=false
	--f1oor.isVisible=false

local egg1=display.newCircle(30,pass+30,10)
local egg2=display.newCircle(30,pass*2+30,10)
local egg3=display.newCircle(30,pass*3+30,10)
local egg4=display.newCircle(30,pass*4+30,10)
local egg5=display.newCircle(display.contentWidth-30,pass+30,10)
local egg6=display.newCircle(display.contentWidth-30,pass*2+30,10)
local egg7=display.newCircle(display.contentWidth-30,pass*3+30,10)
local egg8=display.newCircle(display.contentWidth-30,pass*4+30,10)

local paddle1= display.newRect(80,display.contentCenterY,20,25)
local paddle2= display.newRect(display.contentWidth-80,display.contentCenterY,20,25)
local ball= display.newCircle(display.contentCenterX,display.contentCenterY,5)
physics.start()
physics.setGravity(0,0)
physics.addBody(ball,{radius=5,bounce=1})
ball.isBullet=true
physics.addBody(roof,"static")
physics.addBody(leftW,"static")
physics.addBody(rightW,"static")
physics.addBody(f1oor,"static")

physics.addBody(paddle1,"static")
paddle1.limitUp= 22
paddle1.limitDown=22
ball:setLinearVelocity(-30,-300)
--ssk.misc.addSmartDrag(paddle1,{ retval = true,limitX =true})


physics.addBody(paddle1,"static")
ball:setLinearVelocity(-30,-300)
physics.addBody(paddle2,"static")
physics.addBody(egg1,"static")
physics.addBody(egg2,"static")
physics.addBody(egg3,"static")
physics.addBody(egg4,"static")
physics.addBody(egg5,"static")
physics.addBody(egg6,"static")
physics.addBody(egg7,"static")
physics.addBody(egg8,"static")



paddle1:addEventListener("touch",dragPaddle)

