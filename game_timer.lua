require 'class'
local _ = require ("moses")

GameTimer = class()

function GameTimer:init(x, y)
  self.time = 0.0
  self.text = display.newText( {x=800, y=10, text=self:getTime(), font=native.systemFont, fontSize=20} )
  self.text:setFillColor( 1, 0, 0 )
  self.text:setFillColor(0.3, 0.3, 0.3)

  self.updateEvent = function(a, event) self:updateTime(event) end
  timer.performWithDelay( 100, self.updateEvent, 0 )
end

function GameTimer:destroy()
  if self.text then
    self.text:removeSelf()
    self.text = nil
  end
end

function GameTimer:updateTime(event)
  self.time = self.time + 0.1
  self.text.text = self:getTime()
end

function GameTimer:getTime()
  return string.format("%.1f", self.time)
end

function GameTimer:restartTimer()
  self.time = 0.0
end
