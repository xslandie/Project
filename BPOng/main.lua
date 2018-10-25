-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
<<<<<<< HEAD
local AI= require "AI"

local function onCollisionEggs(event)
=======
local function onCollisionEggs(event)
	local obj1 = event.object1
    local obj2 = event.object2
	local phase = event.phase
	
	if ( event.phase == "began" ) then
		if (obj1.myName == "egg" and obj2.myName == "ball" )         
			then
				display.remove(obj1)
				local vx, vy = obj2:getLinearVelocity()
				obj2:setLinearVelocity(-vx, -vy)
		elseif (obj1.myName == "ball" and obj2.myName == "egg")
			then
				display.remove(obj2)
				local vx, vy = obj1:getLinearVelocity()
				obj1:setLinearVelocity(-vx, -vy)
			end
		end					
>>>>>>> 808ba7caef0f792bbc3ab9e90c234ddf93e2d125
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
		
<<<<<<< HEAD
		paddle.touchOffsetX = event.x - paddle.x
=======
		--paddle.touchOffsetX = event.x - paddle.x
>>>>>>> 808ba7caef0f792bbc3ab9e90c234ddf93e2d125
		paddle.touchOffsetY = event.y - paddle.y

	elseif ( "moved" == phase ) then
		-- Move the paddle to the new touch position
<<<<<<< HEAD
		paddle.x = event.x - paddle.touchOffsetX
		if(paddle.x<xMin) then paddle.x=xMin end
		if(paddle.x>xMax) then paddle.x=xMax end
=======
		--paddle.x = event.x - paddle.touchOffsetX
		--if(paddle.x<xMin) then paddle.x=xMin end
		--if(paddle.x>xMax) then paddle.x=xMax end
>>>>>>> 808ba7caef0f792bbc3ab9e90c234ddf93e2d125
		paddle.y = event.y - paddle.touchOffsetY
		if(paddle.y<yMin) then paddle.y=yMin end
		if(paddle.y>yMax) then paddle.y=yMax end

	elseif ( "ended" == phase or "cancelled" == phase ) then
<<<<<<< HEAD
		-- Release touch focus on the paddle
=======
		-- Release touch focus on the paddle
>>>>>>> 808ba7caef0f792bbc3ab9e90c234ddf93e2d125
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

<<<<<<< HEAD
local egg1=display.newCircle(30,pass+30,10)
local egg2=display.newCircle(30,pass*2+30,10)
local egg3=display.newCircle(30,pass*3+30,10)
local egg4=display.newCircle(30,pass*4+30,10)
local egg5=display.newCircle(display.contentWidth-30,pass+30,10)
local egg6=display.newCircle(display.contentWidth-30,pass*2+30,10)
local egg7=display.newCircle(display.contentWidth-30,pass*3+30,10)
local egg8=display.newCircle(display.contentWidth-30,pass*4+30,10)

local paddle1= display.newRect(80,display.contentCenterY,20,25)
--local paddle2= display.newRect(display.contentWidth-80,display.contentCenterY,20,25)
=======
local xbase = 30;
local ybase = 100;
local egg1=display.newImageRect( "egg.png", 15, 20)
local egg2=display.newImageRect( "egg.png", 15, 20)
local egg3=display.newImageRect( "egg.png", 15, 20)
local egg4=display.newImageRect( "egg.png", 15, 20)
local egg5=display.newImageRect( "egg.png", 15, 20)
local egg6=display.newImageRect( "egg.png", 15, 20)
local egg7=display.newImageRect( "egg.png", 15, 20)
local egg8=display.newImageRect( "egg.png", 15, 20)
egg1.x = xbase
egg1.y = ybase
egg2.x = xbase
egg2.y = ybase + 60
egg3.x = xbase
egg3.y = ybase + 120
egg4.x = xbase
egg4.y = ybase + 180
egg5.x = display.contentWidth - xbase
egg5.y = ybase
egg6.x = display.contentWidth - xbase
egg6.y = ybase + 60
egg7.x = display.contentWidth - xbase
egg7.y = ybase + 120
egg8.x = display.contentWidth - xbase
egg8.y = ybase + 180

--local paddle1= display.newRect(80,display.contentCenterY,20,25)
local paddle1=display.newImageRect( "Dinoknight.png", 80, 50)
paddle1.x = 80
paddle1.y = display.contentCenterY
local paddle2= display.newRect(display.contentWidth-80,display.contentCenterY,20,25)
>>>>>>> 808ba7caef0f792bbc3ab9e90c234ddf93e2d125
local ball= display.newCircle(display.contentCenterX,display.contentCenterY,5)

paddle1.myName = "player"
paddle2.myName = "enemy"
ball.myName = "ball"

egg1.myName = "egg"
egg2.myName = "egg"
egg3.myName = "egg"
egg4.myName = "egg"
egg5.myName = "egg"
egg6.myName = "egg"
egg7.myName = "egg"
egg8.myName = "egg"

physics.start()
AI.newAI(sceneGroup,"DinoKnightFinal(Girato)",display.contentWidth-80,display.contentCenterY,"ai"
physics.setGravity(0,0)
physics.addBody(ball,{radius=5,bounce=1})
ball.isBullet=true
physics.addBody(roof,"static")
physics.addBody(leftW,"static")
physics.addBody(rightW,"static")
physics.addBody(f1oor,"static")

<<<<<<< HEAD
physics.addBody(paddle1,"static")
=======
physics.addBody(paddle1,"static", { density=1000 })
>>>>>>> 808ba7caef0f792bbc3ab9e90c234ddf93e2d125
paddle1.limitUp= 22
paddle1.limitDown=22
ball:setLinearVelocity(-30,-300)
--ssk.misc.addSmartDrag(paddle1,{ retval = true,limitX =true})


physics.addBody(paddle1,"static")
ball:setLinearVelocity(-30,-300)
<<<<<<< HEAD
--physics.addBody(paddle2,"static")
=======
physics.addBody(paddle2,"static")
>>>>>>> 808ba7caef0f792bbc3ab9e90c234ddf93e2d125
physics.addBody(egg1,"static")
physics.addBody(egg2,"static")
physics.addBody(egg3,"static")
physics.addBody(egg4,"static")
physics.addBody(egg5,"static")
physics.addBody(egg6,"static")
physics.addBody(egg7,"static")
physics.addBody(egg8,"static")



paddle1:addEventListener("touch",dragPaddle)
Runtime:addEventListener( "collision", onCollisionEggs)

