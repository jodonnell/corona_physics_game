-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

require 'finger_draw'

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )


display.setStatusBar( display.HiddenStatusBar )
-- Your code here
local circleTop = display.newCircle( 450, 50, 50 )
circleTop:setFillColor(250, 0, 0)
physics.addBody( circleTop, "static", {} )

local circleBottom = display.newCircle( 450, 1150, 50 )
circleBottom:setFillColor(250, 250, 0)
physics.addBody( circleBottom, "static", {} )

local circleRight = display.newCircle( 50, 600, 50 )
circleRight:setFillColor(0, 0, 250)
physics.addBody( circleRight, "static", {} )

local circleLeft = display.newCircle( 850, 600, 50 )
circleLeft:setFillColor(250, 0, 250)
physics.addBody( circleLeft, "static", {} )


local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
      self:removeSelf()
    elseif ( event.phase == "ended" ) then
    end
end

circleLeft.collision = onLocalCollision
circleLeft:addEventListener( "collision", circleLeft )

circleTop.collision = onLocalCollision
circleTop:addEventListener( "collision", circleTop )

circleBottom.collision = onLocalCollision
circleBottom:addEventListener( "collision", circleBottom )

circleRight.collision = onLocalCollision
circleRight:addEventListener( "collision", circleRight )



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
function loop()
  if not circleInBound then
    circleInBound = display.newCircle( 0, 0, 5 )
    circleInBound:setFillColor(0, 0, 0)
    physics.addBody( circleInBound, {radius=5, bounce=1} )
    circleInBound:setLinearVelocity(300, 300)
  end

  if circleInBound.x > 900 or circleInBound.x < 0 then
    local vx, vy = circleInBound:getLinearVelocity()
    circleInBound:setLinearVelocity(vx * -1, vy)
  end

  if circleInBound.y > 1200 or circleInBound.y < 0 then
    local vx, vy = circleInBound:getLinearVelocity()
    circleInBound:setLinearVelocity(vx, vy * -1)
  end
end

Runtime:addEventListener( "enterFrame", loop )
