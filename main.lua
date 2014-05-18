-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

require 'finger_draw'
require 'goal_circle'
require 'player_ball'
require 'death_circle'

display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 1, 1, 1 )

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

leftGoal = GoalCircle(850, 600)

rightGoal = GoalCircle(50, 600)
rightGoal:setColor(0, 0, 1)

topGoal = GoalCircle(450, 50)
topGoal:setColor(1, 0, 0)

bottomGoal = GoalCircle(450, 1150)
bottomGoal:setColor(1, 1, 0)

deathCircle = DeathCircle(400, 400)

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


local playerBall
function loop()
  if not playerBall then
    playerBall = PlayerBall(0, 0)
  end

  if playerBall:shouldBounceOffXWall() then
    playerBall:reverseXSpeed()
  end

  if playerBall:shouldBounceOffYWall() then
    playerBall:reverseYSpeed()
  end
end

Runtime:addEventListener( "enterFrame", loop )
