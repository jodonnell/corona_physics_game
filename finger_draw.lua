require 'class'
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
  _.push(lines, line)
end
