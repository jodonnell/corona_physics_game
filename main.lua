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

-- function loop()
--    main_game:mainGameLoop()
-- end

-- Runtime:addEventListener( "enterFrame", loop )
