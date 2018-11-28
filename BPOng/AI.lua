local Library= require "CoronaLibrary"

local lib= Library:new{name='Ai', publisherId='com.ai'}
local physics = require ("physics")


lib.newAI= function(img,ai_type,_ball)
          local img=_img
		 
		  local aiType= ai_type
		  local obj
		  local ball=_ball  
		  obj=img
		 
		
		
		physics:addBody(obj,"static",{density=200,friction=0.2})

--Methods-----------------------------------------------------------------
function obj:remove()
		Runtime:removeEventListener("enterFrame", obj)
		
		display.remove( obj )		
	end

function obj:actionAI( event )	
end

function obj:enterFrame()
		self:actionAI()
	end
	
	Runtime:addEventListener( "enterFrame", obj )
	
	
	return obj
end

return lib