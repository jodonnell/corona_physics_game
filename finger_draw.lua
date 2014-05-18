require 'class'
local physics = require( "physics" )
local _ = require ("moses")

FingerDraw = class()

local lines = {}
function FingerDraw:init(x, y)
  self.last = {x=x, y=y}
end

function FingerDraw:movedTo(x, y)
  if (#lines > 30) then
    local removeLine = _.pop(lines)
    removeLine:removeSelf()
  end

  local line = display.newLine(self.last["x"], self.last["y"], x, y)
  self.last = {x=x, y=y}
  line.strokeWidth = 3
  line:setStrokeColor(0, 0, 0)
  physics.addBody(line, "static", {})
  _.push(lines, line)
end

function FingerDraw:lines()
  return lines
end

function FingerDraw:update()
  _.each(lines, function(i,line)
           local lineWidth = math.random(6, 12)
           line.strokeWidth = lineWidth
  end)
end

function FingerDraw:clear()
  _.each(lines, function(i,line)
           line:removeSelf()
           line = nil
  end)
  lines = {}
end
