require 'finger_draw'
require 'goal_circle'
require 'player_ball'
require 'death_circle'
require 'game_timer'

display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 1, 1, 1 )

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

gameTimer = GameTimer()

function resetGoals()
  if leftGoal then
    print("left goal destroyed")
    leftGoal:destroy()
  end
  leftGoal = GoalCircle(850, 600)

  if rightGoal then
    rightGoal:destroy()
  end
  rightGoal = GoalCircle(50, 600)
  rightGoal:setColor(0, 0, 1)

  if topGoal then
    topGoal:destroy()
  end
  topGoal = GoalCircle(450, 50)
  topGoal:setColor(1, 0, 0)

  if bottomGoal then
    bottomGoal:destroy()
  end
  bottomGoal = GoalCircle(450, 1150)
  bottomGoal:setColor(1, 1, 0)

  if deathCircle then
    deathCircle:destroy()
  end
  deathCircle = DeathCircle(600, 400)
end

resetGoals()

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


local gameOver = false
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

  if gameOver then
    gameOver = false
    gameOver2()
  end

  if fingerDraw then
    fingerDraw:update()
  end
end

Runtime:addEventListener( "enterFrame", loop )

function gameOver2()
  if fingerDraw then
    fingerDraw:clear()
  end
  resetGoals()
  playerBall:destroy()
  playerBall = PlayerBall(0, 0)

  gameTimer:restartTimer()
end

function gameOverHappened()
  gameOver = true
end
Runtime:addEventListener( "gameOver", gameOverHappened )
