-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

require 'finger_draw'

display.setStatusBar( display.HiddenStatusBar )
-- Your code here
local circleTop = display.newCircle( 450, 50, 50 )
circleTop:setFillColor(250, 0, 0)

local circleBottom = display.newCircle( 450, 1150, 50 )
circleBottom:setFillColor(250, 250, 0)

local circleRight = display.newCircle( 50, 600, 50 )
circleRight:setFillColor(0, 0, 250)

local circleLeft = display.newCircle( 850, 600, 50 )
circleLeft:setFillColor(250, 0, 250)


--circle-based collision detection
local function hasCollidedCircle( obj1, obj2 )
   if ( obj1 == nil ) then  --make sure the first object exists
      return false
   end
   if ( obj2 == nil ) then  --make sure the other object exists
      return false
   end

   local dx = obj1.x - obj2.x
   local dy = obj1.y - obj2.y

   local distance = math.sqrt( dx*dx + dy*dy )
   local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)

   if ( distance < objectSize ) then
      return true
   end
   return false
end


local fingerDraw

local function onScreenTouch( event )
  if event.phase == "began" then
    fingerDraw = FingerDraw(event.x, event.y)
  elseif event.phase == "moved" then
    fingerDraw:movedTo(event.x, event.y)
  elseif event.phase == "ended" or event.phase == "cancelled" then
    fingerDraw:movedTo(event.x, event.y)
  end

  return true
end


Runtime:addEventListener( "touch", onScreenTouch )

display.setDefault( "background", 1, 1, 1 )


local circleInBound
local xMove = 7
local yMove = 7
function loop()
  if not circleInBound then
    circleInBound = display.newCircle( 0, 0, 5 )
    circleInBound:setFillColor(0, 0, 0)
  end
  circleInBound.x = circleInBound.x + xMove
  circleInBound.y = circleInBound.y + yMove

  if circleInBound.x > 900 then
    xMove = xMove * -1
  end

  if circleInBound.x < 0 then
    xMove = xMove * -1
  end

  if circleInBound.y > 1200 then
    yMove = yMove * -1
  end

  if circleInBound.y < 0 then
    yMove = yMove * -1
  end


  if (fingerDraw) then
  for k, v in pairs(fingerDraw:lines()) do
    if (fingerDraw and hasCollidedCircle(circleInBound, v)) then
      yMove = yMove * -1
      xMove = xMove * -1
    end
  end
  end
end

Runtime:addEventListener( "enterFrame", loop )
