-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local AI= require "AI"
system.activate("multitouch")
local physicsData = (require "shapedefs").physicsData(1)
local buttonGroup = display.newGroup()
local physics= require("physics")
physics.start()

local numEgg1 = 5
local numEgg2 = 5
local pass=display.contentHeight/5
local xMin=40
local xMax=display.contentWidth/2
local yMin=pass+25
local yMax=display.contentHeight-21
local clickedKick=false
local vmaxX, vmaxY = 500 , 500 

--Sprites options
local options =
{
    --required parameters
    width = 50,
    height = 55,
    numFrames = 8,
     
    --optional parameters; used for scaled content support
    sheetContentWidth = 200,  -- width of original 1x size of entire sheet
    sheetContentHeight = 110   -- height of original 1x size of entire sheet
}
local options2 =
{
    --required parameters
    width = 50,
    height = 55,
    numFrames = 5,
     
    --optional parameters; used for scaled content support
    sheetContentWidth = 250,  -- width of original 1x size of entire sheet
    sheetContentHeight = 55   -- height of original 1x size of entire sheet
}
local sequences_sprites = {

    -- first sequence (consecutive frames)
    {
        name = "normalRun",
        start = 1,
        count = 8,
        time = 800,
        loopCount = 0
    }
   
}
local sequences_sprites2 = {
    -- first sequence (consecutive frames)
    {
        name = "normalRun",
        start = 1,
        count = 5,
        time = 500,
        loopCount = 0
    }
}

local background = display.newImageRect("background.png", 570, 360)
background.x = display.contentCenterX
background.y = display.contentCenterY
background:scale( 1.18, 0.88)


local sprite= graphics.newImageSheet("DinoViking2.png", options)
local spriteHeader = graphics.newImageSheet("DinoVikingHeader.png", options2)

local paddle1= display.newSprite(sprite, sequences_sprites)
paddle1:play()
paddle1.x = 36
paddle1.y = display.contentCenterY
physics.addBody( paddle1, "static", physicsData:get("DinoKnight2") )

local function clickFalse()
   
	if(clickedKick==true)then
		local x, y = paddle1.x, paddle1.y
		display.remove(paddle1)
		paddle1 = display.newSprite(sprite, sequences_sprites)
		
		paddle1:play()
		paddle1.x = x
		paddle1.y = y
		physics.addBody( paddle1, "static", physicsData:get("DinoKnight2") )
	end
	
	clickedKick = false
end

local function onClick(event)
        print (" tapped!")
		
		if(clickedKick==false)then
			local x, y = paddle1.x, paddle1.y
			display.remove(paddle1)
			paddle1 = display.newSprite(spriteHeader, sequences_sprites2)
			
			paddle1:play()
			paddle1.x = x
			paddle1.y = y
			physics.addBody( paddle1, "static", physicsData:get("DinoKnight2") )
		end
		timer.performWithDelay(500, clickFalse)
	    clickedKick = true 
		
		
		if event.phase == "began" then
        display.getCurrentStage():setFocus( event.target, event.id )
        --other code
		end
		if event.phase == "ended" or event.phase == "cancelled" then
        display.getCurrentStage():setFocus( event.target, nil )
		end
		
	     
     
end

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
				if(obj1.id == 1) then
					numEgg1=numEgg1-1
					print(numEgg1)
				else numEgg2=numEgg2-1
					print(numEgg2)
				end
				
				
		elseif (obj1.myName == "ball" and obj2.myName == "egg")
			then
				display.remove(obj2)
				local vx, vy = obj1:getLinearVelocity()
				obj1:setLinearVelocity(-vx, -vy)
				if(obj2.id == 1) then
					numEgg1=numEgg1-1
					print(numEgg1)
				else numEgg2=numEgg2-1
					print(numEgg2)
				end
				
		elseif (obj1.myName == "ball" and obj2.myName == "enemy")
			then
				local vx, vy = obj1:getLinearVelocity()
				obj1:setLinearVelocity(-vx-2, vy)
				--obj1:applyLinearImpulse( 0.01, 0.01, obj1.x, obj1.y )
				
		elseif (obj1.myName == "enemy" and obj2.myName == "ball")
			then				
				local vx, vy = obj2:getLinearVelocity()
				obj2:setLinearVelocity(-vx-2, vy)
				--obj2:applyLinearImpulse( 0.01, 0.01, obj2.x, obj2.y )				
			
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
         elseif(obj1.myName =="ball" and obj2.myName == "player")
          then
		  if(clickedKick) then
            
			local vx,vy= obj1:getLinearVelocity()
			 obj1:setLinearVelocity(-(vx+50000),(vy+50000),obj1.x,obj1.y) end
			 elseif(obj1.myName =="player" and obj2.myName == "ball")then
			 
			 if(clickedKick)
			 
          then
		  local vx,vy= obj2:getLinearVelocity()
		  obj2:setLinearVelocity(-(vx+50000),(vy+50000),obj2.x,obj2.y)end
		  
		 
	
	   
    end	
end

end


--local paddle1=display.newImageRect( "DinoKnight2.png", 50, 55)

local dragBtn = display.newRect(36,display.contentCenterY,display.contentWidth/2,display.contentHeight/2)
dragBtn.isVisible=false
dragBtn.isHitTestable=true
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

local function movePaddle(posY)
 paddle1.y=posY
 

end
local function dragPaddle( event )

	local paddle = event.target
	local phase = event.phase

	
	
	if ( "began" == phase ) then

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
        movePaddle(paddle.y)
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


physics.setDrawMode( "hybrid" )



	
	


math.randomseed( os.time() )


-- Setup a label to display the FPS value
local fpsLabel = display.newText({
        x = 20,
        y = 20,
        fontSize = 15,
        font = native.systemFontBold,
        text = "FPS: " .. math.round(display.fps)
})
fpsLabel:setFillColor(1,1,0)

local timeLabel = display.newText({
	x=50,
	y=35,
	fontSize= 10,
	font = native.systemFontBold,
	text = "Time: " .. math.round(system.getTimer()/1000)
	})
timeLabel:setFillColor(1,1,0)
-- Start calculating FPS, and provide a callback function to update the label with current FPS value
startFrameRateCalculator(function(fps) 
    fpsLabel.text = "FPS: " .. math.round(fps)
	timeLabel.text = "Time: " .. math.round(system.getTimer()/1000)
end)



local xbase = 20;
local ybase = 100;

local egg1=display.newImageRect( "egg2.png", 20, 22)
local egg2=display.newImageRect( "egg2.png", 20, 22)
local egg3=display.newImageRect( "egg2.png", 20, 22)
local egg4=display.newImageRect( "egg2.png", 20, 22)
local egg5=display.newImageRect( "egg2.png", 20, 22)	
physics.addBody( egg1, "static", physicsData:get("egg2") )
physics.addBody( egg2, "static", physicsData:get("egg2") )
physics.addBody( egg3, "static", physicsData:get("egg2") )
physics.addBody( egg4, "static", physicsData:get("egg2") )
physics.addBody( egg5, "static", physicsData:get("egg2") )
local egg6=display.newImageRect( "egg4.png", 20, 22)
local egg7=display.newImageRect( "egg4.png", 20, 22)
local egg8=display.newImageRect( "egg4.png", 20, 22)
local egg9=display.newImageRect( "egg4.png", 20, 22)
local egg10=display.newImageRect( "egg4.png", 20, 22)
physics.addBody( egg6, "static", physicsData:get("eggwest2") )
physics.addBody( egg7, "static", physicsData:get("eggwest2") )
physics.addBody( egg8, "static", physicsData:get("eggwest2") )
physics.addBody( egg9, "static", physicsData:get("eggwest2") )
physics.addBody( egg10, "static", physicsData:get("eggwest2") )
egg1.x = xbase-44
egg1.y = ybase 
egg2.x = xbase-44
egg2.y = ybase + 40
egg3.x = xbase-44
egg3.y = ybase + 80
egg4.x = xbase-44
egg4.y = ybase + 120
egg5.x = xbase-44
egg5.y = ybase +160
egg6.x = display.contentWidth - xbase+44
egg6.y = ybase 
egg7.x = display.contentWidth - xbase+44
egg7.y = ybase + 40
egg8.x = display.contentWidth - xbase+44
egg8.y = ybase + 80
egg9.x = display.contentWidth - xbase+44
egg9.y = ybase + 120
egg10.x = display.contentWidth -xbase+44
egg10.y = ybase +160
egg6:scale( -1, 1 )
egg7:scale( -1, 1 )
egg8:scale( -1, 1 )
egg9:scale( -1, 1 )
egg10:scale ( -1, 1 )

egg1.id=1
egg2.id=1
egg3.id=1
egg4.id=1
egg5.id=1
egg6.id=2
egg7.id=2
egg8.id=2
egg9.id=2
egg10.id=2


local ball= display.newCircle(display.contentCenterX,display.contentCenterY,5)





local sceneGroup = display.newGroup( );

--local paddle2= display.newImageRect("DinoViking.png", 50, 55)
local sprite= graphics.newImageSheet("DinoViking2.png", options)

local paddle2 = display.newSprite(sprite, sequences_sprites)
paddle2:play()
paddle2.x=display.contentWidth-80+44
paddle2.y=display.contentCenterY
physics.addBody( paddle2, "static", physicsData:get("DinoViking") )
paddle2:scale(-1, 1)


local kickBtn=display.newRect(display.contentCenterX*1.5+22,display.contentCenterY*1.5,display.contentWidth/2+44,display.contentHeight/2)
kickBtn.alpha = 0
kickBtn.isHitTestable= true

local function onFrame(event)
	local vx, vy = ball:getLinearVelocity()
	if( math.abs(vx)>vmaxX and math.abs(vy)>vmaxY)then
		ball:setLinearVelocity(vx/math.abs(vx)*vmaxX, vy/math.abs(vy)*vmaxY)
		
	end
	
	
	if(numEgg1==0 or numEgg2==0) then
		physics.pause()
		local endBox = native.newTextBox( display.contentCenterX, display.contentCenterY, 150, 150 )
		endBox.isEditable = false
		endBox.text = "\n è finito"
		endBox.align = "center"
		--endBox.hasBackground = false
		--endBox.alpha = 1.0
		endBox.isFontSizeScaled = true 
		endBox.size = 20	
		end
	
	transition.moveTo(paddle2,{x=paddle2.x,  y=ball.y-paddle2.height/2,time=80,delay=50})
	
	--ball:applyForce(0.1,0.1,ball.x,ball.y)
	
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
egg9.myName = "egg"
egg10.myName = "egg"



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
physics.addBody(egg9,"static")
physics.addBody(egg10,"static")




dragBtn:addEventListener("touch",dragPaddle)
--ball:addEventListener("touch",dragPaddle)
kickBtn:addEventListener("touch",onClick)

Runtime:addEventListener( "collision", onCollisions)




