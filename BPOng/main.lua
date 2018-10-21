-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local background = display.newRect(display.contentCenterX,display.contentCenterY,1400,display.contentHeight)
background:setFillColor(0)

local paddle1= display.newRect(0,display.contentCenterY,5,150)
local paddle2= display.newRect(display.contentWidth,display.contentCenterY,5,150)
local ball= display.newCircle(display.contentCenterX,display.contentCenterY,5)