-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

require 'finger_draw'
require 'goal_circle'

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )


display.setStatusBar( display.HiddenStatusBar )

leftGoal = GoalCircle(850, 600)

rightGoal = GoalCircle(50, 600)
rightGoal:setColor(0, 0, 250)

topGoal = GoalCircle(450, 50)
topGoal:setColor(250, 0, 0)

bottomGoal = GoalCircle(450, 1150)
bottomGoal:setColor(250, 250, 0)

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
