-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local AI= require "AI"
local pass=display.contentHeight/5
local xMin=40
local xMax=display.contentWidth/2
local yMin=pass+25
local yMax=display.contentHeight-21



local function onCollisions(event)

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

			
			
         elseif(obj1.myName == "enemy" and obj2.myName =="wall" )
		   then 
		   if(obj1.y<=yMin)
	       then obj1.y=yMin 
            elseif(obj1.y>yMax) 
			then obj1.y=yMax end
          elseif(obj1.myName == "wall" and obj2.myName =="enemy" )
		   then 
		   if(obj2.y<=yMin)
	       then obj2.y=yMin
            elseif(obj2.y>yMax) 
			then obj2.y=yMax end	
elseif(obj1.myName == "ball" and obj2.myName =="wall" )
		   then 
		   local vx, vy = obj1:getLinearVelocity()
				obj1:setLinearVelocity(vx, -vy)
		   
		   if(obj1.y<=yMin-19)
	       then transition.moveTo(obj1,{x=obj1.x,y=yMin,time=0})
            elseif(obj1.y>=yMax+21) 
			then transition.moveTo(obj1,{x=obj1.x,y=yMax,time=0}) end
          elseif(obj1.myName == "wall" and obj2.myName =="ball" )
		  then
		  local vx, vy = obj2:getLinearVelocity()
				obj2:setLinearVelocity(vx, -vy)
		   
		   if(obj2.y<=yMin-19)
	       then transition.moveTo(obj2,{x=obj2.x,y=yMin,time=0})
            elseif(obj2.y>yMax) 
			then transition.moveTo(obj2,{x=obj2.x,y=yMax,time=0}) end							
	
	   
    end	
end

end



local function dragPaddle( event )

	local paddle = event.target
	local phase = event.phase

	if ( "began" == phase ) then
		-- Set touch focus on the paddle
		display.currentStage:setFocus( paddle )
		-- Store initial offset position
		

		--paddle.touchOffsetX = event.x - paddle.x

		--paddle.touchOffsetX = event.x - paddle.x

		paddle.touchOffsetY = event.y - paddle.y

	elseif ( "moved" == phase ) then
		-- Move the paddle to the new touch position

		--paddle.x = event.x - paddle.touchOffsetX
		--if(paddle.x<xMin) then paddle.x=xMin end
		--if(paddle.x>xMax) then paddle.x=xMax end

		--paddle.x = event.x - paddle.touchOffsetX
		--if(paddle.x<xMin) then paddle.x=xMin end
		--if(paddle.x>xMax) then paddle.x=xMax end

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

local function startFrameRateCalculator(callbackFunction)
    
    local lastTimestampMs
    local frameCounter = 0
    
    Runtime:addEventListener("enterFrame", function()
            
        frameCounter = frameCounter + 1
        local currentTimestampMs = system.getTimer()
            
        if (not lastTimestampMs) then
            lastTimestampMs = currentTimestampMs
        end
        
        -- Calculate actual fps approximately four times every second
        if (frameCounter >= (display.fps / 4)) then
            local deltaMs = currentTimestampMs - lastTimestampMs            
            local fps = frameCounter / (deltaMs / 1000) 
            frameCounter = 0
            lastTimestampMs = currentTimestampMs
            callbackFunction(fps)
        end
    end)
end

local physics= require("physics")
physics.start()
local background = display.newImage("background.jpg")
background.x = display.contentCenterX
background.y = display.contentCenterY
background:scale( 0.305, 0.2252)


	local roof = display.newRect(display.contentCenterX, pass, display.contentWidth+88, 10, {density=2000}) 
    local leftW= display.newRect(-44,display.contentCenterY,2,display.contentHeight)
    local rightW= display.newRect(display.contentWidth+44,display.contentCenterY,2,display.contentHeight)
	local f1oor = display.newRect(display.contentCenterX,display.contentHeight, display.contentWidth+88, 20)
	leftW.isVisible= false
	rightW.isVisible=false
	roof.isVisible=false
	f1oor.isVisible=false
    roof.myName= "wall"
	leftW.myName= "wall"
	rightW.myName= "wall"
	f1oor.myName= "wall"
	


math.randomseed( os.time() )


-- Setup a label to display the FPS value
local fpsLabel = display.newText({
        x = display.contentCenterX,
        y = 20,
        fontSize = 50,
        font = native.systemFontBold,
        text = "FPS: " .. math.round(display.fps) .. " prova"
})
fpsLabel:setFillColor(1,1,0)

-- Start calculating FPS, and provide a callback function to update the label with current FPS value
startFrameRateCalculator(function(fps) 
    fpsLabel.text = "FPS: " .. math.round(fps) .. " prova"
end)



local xbase = 20;
local ybase = 100;
local egg1=display.newImageRect( "egg.png", 20, 30)
local egg2=display.newImageRect( "egg.png", 20, 30)
local egg3=display.newImageRect( "egg.png", 20, 30)
local egg4=display.newImageRect( "egg.png", 20, 30)	
local egg5=display.newImageRect( "eggwest.png", 20, 30)
local egg6=display.newImageRect( "eggwest.png", 20, 30)
local egg7=display.newImageRect( "eggwest.png", 20, 30)
local egg8=display.newImageRect( "eggwest.png", 20, 30)
egg1.x = xbase-44
egg1.y = ybase
egg2.x = xbase-44
egg2.y = ybase + 60
egg3.x = xbase-44
egg3.y = ybase + 120
egg4.x = xbase-44
egg4.y = ybase + 180
egg5.x = display.contentWidth - xbase+44
egg5.y = ybase
egg6.x = display.contentWidth - xbase+44
egg6.y = ybase + 60
egg7.x = display.contentWidth - xbase+44
egg7.y = ybase + 120
egg8.x = display.contentWidth - xbase+44
egg8.y = ybase + 180
egg5:scale( -1, 1 )
egg6:scale( -1, 1 )
egg7:scale( -1, 1 )
egg8:scale( -1, 1 )

--local paddle1= display.newRect(80,display.contentCenterY,20,25)
local ball= display.newCircle(display.contentCenterX,display.contentCenterY,5)
local paddle1=display.newImageRect( "Dinoknight.png", 60, 50, {density=1500})
paddle1.x = 80-44
paddle1.y = display.contentCenterY


local paddle2= display.newImageRect("ScheleDinoWest.png",70,55, {density=1500})
paddle2.x=display.contentWidth-80+44
paddle2.y=display.contentCenterY
paddle2:scale(1,1)
local function onFrame(event)

	transition.moveTo(paddle2,{x=paddle2.x,  y=ball.y-paddle2.height/2,time=80,delay=50})
	--ball:applyForce(0.1,0.1,ball.x,ball.y)
	local vx, vy = ball:getLinearVelocity()
	if (math.abs(vx)<100 and math.abs(vy)<100)
	then ball:setLinearVelocity(100,100)end
	ball:setLinearVelocity(vx*2/1.9999,vy*2/1.9999)
	
	if(paddle2.y<yMin-21)
	then paddle2.y=yMin
	elseif(paddle2.y>yMax+21)
	 then 
	  paddle2.y=yMax
	  end
	
	if(ball.y<=yMin-19)
	 then ball.y=yMin 
	 local vx, vy = ball:getLinearVelocity()
				ball:setLinearVelocity(vx-2,-vy+2)
	 
	elseif(ball.y>=yMax+21) 
		then ball.y=yMax
		   local vx, vy = ball:getLinearVelocity()
				ball:setLinearVelocity(vx-2, -vy+2)
         end
	
end
Runtime:addEventListener("enterFrame",onFrame)	




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



physics.setPositionIterations(6)
physics.setGravity(0,0)
physics.addBody(ball,{radius=5,bounce=1})
ball.isBullet=true
ball.isSensor=false
physics.addBody(roof,"static",{density=2000, friction=0.5})
physics.addBody(leftW,"static",{density=2000, friction=0.5})
physics.addBody(rightW,"static",{density=2000, friction=0.5})
physics.addBody(f1oor,"static",{density=2000, friction=0.5})

physics.addBody(paddle1,"static", { density=1000 })

paddle1.limitUp= 22
paddle1.limitDown=22

paddle2.limitUp= 22
paddle2.limitDown=22



ball:setLinearVelocity(-100,-250)
--ssk.misc.addSmartDrag(paddle1,{ retval = true,limitX =true})



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
--ball:addEventListener("touch",dragPaddle)

Runtime:addEventListener( "collision", onCollisions)




