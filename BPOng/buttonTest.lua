local buttonGroup = display.newGroup()

local kickBtn = display.newRect(buttonGroup,display.contentCenterX*1.5+22,display.contentCenterY*1.5,display.contentWidth/2+44,display.contentHeight/2)


local groupBounds = buttonGroup.contentBounds
local groupRegion = display.newRect( 0, 0, groupBounds.xMax-groupBounds.xMin+200, groupBounds.yMax-groupBounds.yMin+200 )
groupRegion.x = groupBounds.xMin + ( buttonGroup.contentWidth/2 )
groupRegion.y = groupBounds.yMin + ( buttonGroup.height/2 )
groupRegion.isVisible = false
groupRegion.isHitTestable = true
local function detectButton( event )
 
    for i = 1,buttonGroup.numChildren do
        local bounds = buttonGroup[i].contentBounds
        if (
            event.x > bounds.xMin and
            event.x < bounds.xMax and
            event.y > bounds.yMin and
            event.y < bounds.yMax
        ) then
            return buttonGroup[i]
        end
    end
end

local function handleTouch( event)
    local touchOverButton = detectButton( event )
	if( event.phase == "began")
	then
	if(touchOverButton~= nil )
	then 
	if not (buttonGroup.touchID) then
	buttonGroup.touchID= event.id
	
	buttonGroup.activeButton= touchOverButton
	end
	return true
	
	end
	
	elseif( event.phase == "moved" ) then
	if( touchOverButton == nil and buttonGroup.activeButton~= nil ) then
	event.target:dispatchEvent( { name="touch", phase="ended", target=event.target, x=event.x, y=event.y } )
	 return true
	 end
	 
	 elseif( event.phase =="ended" and buttonGroup.activeButton~=nil)
	 then
	 buttonGroup.touchID =nil
	 buttonGroup.activeButton=nil
	 return true 
	 end
	 
	
end
groupRegion:addEventListener("touch",handleTouch)

