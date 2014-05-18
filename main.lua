require 'finger_draw'
require 'goal_circle'
require 'player_ball'
require 'death_circle'
require 'game_timer'
local GGScore = require( "GGScore" )
local board = GGScore:new( "all", true )
board:load()

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

  if deathCircle2 then
    deathCircle2:destroy()
  end
  deathCircle2 = DeathCircle(300, 400)


  if deathCircle3 then
    deathCircle3:destroy()
  end
  deathCircle3 = DeathCircle(300, 800)

  if deathCircle4 then
    deathCircle4:destroy()
  end
  deathCircle4 = DeathCircle(600, 800)

end

resetGoals()

local fingerDraw

local function onScreenTouch( event )
  if event.phase == "began" then
    fingerDraw = FingerDraw(event.x, event.y)
  elseif event.phase == "moved" then
    fingerDraw:movedTo(event.x, event.y)
  elseif event.phase == "ended" or event.phase == "cancelled" then
    fingerDraw:clear()
  end

  return true
end
Runtime:addEventListener( "touch", onScreenTouch )

local runOnce = true
local gameOver = false
local playerBall
function loop()
  if not playerBall then
    playerBall = PlayerBall(380, 440)
  end
  playerBall:update()
  
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

  if leftGoal.destroyed and rightGoal.destroyed and topGoal.destroyed and bottomGoal.destroyed and runOnce then
    runOnce = false
    physics.pause()
    gameTimer:pause()
    board:add( "Jacob", gameTimer.time )
    board:save()

    local scores = board:getScores(true)
    print(scores[1].value)
    for i = 1, #scores, 1 do
      local text = display.newText({x=400, y=30 * i + 100, text=scores[i].value, font=native.systemFont, fontSize=20})
      text:setFillColor(0, 0, 0)
    end
  end
end

Runtime:addEventListener( "enterFrame", loop )

function gameOver2()
  if fingerDraw then
    fingerDraw:clear()
  end
  resetGoals()
  playerBall:destroy()
  playerBall = PlayerBall(380, 440)

  gameTimer:restartTimer()
end

function gameOverHappened()
  gameOver = true
end
Runtime:addEventListener( "gameOver", gameOverHappened )
