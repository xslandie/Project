local Library= require "CoronaLibrary"

local lib= Library:new{name='Ai', publisherId='com.ai'}



lib.newAI= function(_group,_img,_x,_y,ai_type,_sprite)
          local img=_img
		  local group=_group
		  local x = _x
	      local y = _y
		  local aiType= ai_type
		  local sprite= _sprite or nil
		  local obj
		  local ballX
		  local ballY
		  local physics = require ("physics")
		  
		  --if(sprite~=nil)then
		  --obj = spriteObj;
		--obj.x = x
		--obj.y = y
		--group:insert(spriteObj)
		--obj:setSequence( "normalRun" )
		--obj:play()
		--else
		obj=display.newImage(img,x,y)
		--end
		physics:addBody(obj,"static",{density=200,friction=0.2})

--Methods-----------------------------------------------------------------
function obj:followBall(ball)
     ballY=ball.y
end
function obj:mergeY()
        obj.y= obj.ballY
end

function obj:followY(ball)	
        obj:followBall(ball)	
          if(obj.ballY~=nil) then
		  timer.performWithDelay(200,mergeY() )
		  end
end
function obj:actionAI(ball)
        while(obj~=nil)
		 do obj:followY(ball)
		end


end
function obj:enterFrame()
   self:actionAI()
   end
        Runtime:addEventListener( "enterFrame", obj)
		return obj
end
return lib
