-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
require "ssk2.loadSsk"
_G.ssk.init()
local function dragPaddle( event)
  local paddle= event.target
  local phase= event.phase
  
  
  if("began" == phase) then
  
  display.currentStage:setFocus(paddle)
  paddle.touchOffsetY= event.y - paddle.y
  
  elseif ("moved" ==phase) then
  
   paddle.y= event.y - paddle.touchOffsetY
  
  elseif ("ended" == phase or "cancelled" == phase) then
  
    display.currentStage:setFocus(nil)
  end
  return true
end

--variables+basic graphics
local physics= require("physics")
local background = display.newRect(display.contentCenterX,display.contentCenterY,1400,display.contentHeight)
background:setFillColor(0)
local roof = display.newRect(display.contentCenterX, 0, display.contentWidth, 2) 
    local leftW= display.newRect(0,display.contentCenterY,2,display.contentHeight)
    local rightW= display.newRect(display.contentWidth,display.contentCenterY,2,display.contentHeight)
	local f1oor = display.newRect(display.contentCenterX,display.contentHeight, display.contentWidth, 2)
	--leftW.isVisible= false
	--rightW.isVisible=false
	--roof.isVisible=false
	--f1oor.isVisible=false
local paddle1= display.newRect(0,display.contentCenterY,5,150)
local paddle2= display.newRect(display.contentWidth,display.contentCenterY,5,150)
local ball= display.newCircle(display.contentCenterX,display.contentCenterY,5)
physics.start()
physics.setGravity(0,0)
physics.addBody(ball,{radius=5,bounce=1})
physics.addBody(roof,"static")
physics.addBody(leftW,"static")
physics.addBody(rightW,"static")
physics.addBody(f1oor,"static")
physics.addBody(paddle1,"static")
paddle1.limitUp= 22
paddle1.limitDown=22
ball:setLinearVelocity(-30,-300)
--ssk.misc.addSmartDrag(paddle1,{ retval = true,limitX =true})

paddle1:addEventListener("touch",dragPaddle)

