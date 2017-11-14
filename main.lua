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
physics.setGravity( 0, 9.8 )


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

local playerBall
local count = 0
function loop()
  if not playerBall then
    playerBall = PlayerBall(10, 10)
  end
  playerBall:update()
  
  if fingerDraw then
    fingerDraw:update()
  end

  local xGrav = math.random(-20, 20)
  local yGrav = math.random(-20, 20)

  if count > 20 then
    PlayerBall(xGrav + 100, yGrav + 100)
    physics.setGravity( xGrav, yGrav )
    count = 0
  end
  count  = count + 1
  
end

local line = display.newLine(0, display.contentHeight, display.contentWidth, display.contentHeight)
line:setStrokeColor(0, 0, 0)
line.strokeWidth = 3
physics.addBody(line, "static", {})

local line = display.newLine(0, 0, 0, display.contentHeight)
line:setStrokeColor(0, 0, 0)
line.strokeWidth = 3
physics.addBody(line, "static", {})

local line = display.newLine(display.contentWidth, 0, display.contentWidth, display.contentHeight)
line:setStrokeColor(0, 0, 0)
line.strokeWidth = 3
physics.addBody(line, "static", {})

local line = display.newLine(0, 0, display.contentWidth, 0)
line:setStrokeColor(0, 0, 0)
line.strokeWidth = 3
physics.addBody(line, "static", {})


Runtime:addEventListener( "enterFrame", loop )
