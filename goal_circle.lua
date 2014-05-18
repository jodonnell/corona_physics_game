require 'class'
local physics = require( "physics" )
local _ = require ("moses")

GoalCircle = class()

function GoalCircle:init(x, y)
  self.circle = display.newCircle( x, y, 50 )
  self.circle:setFillColor(1, 0, 1)

  physics.addBody( self.circle, "static", {} )

  self.collisionEvent = function(a, event) self:collision(event) end
  self.circle.collision = self.collisionEvent
  self.circle:addEventListener( "collision", self.circle )
  
  self.destroyed = false
end

function GoalCircle:setColor(r, g, b)
  self.circle:setFillColor(r, g, b)
end

function GoalCircle:destroy()
  if self.circle then
    self.circle:removeSelf()
    self.circle = nil
  end
  self.destroyed = true
end

function GoalCircle:collision(event)
    if ( event.phase == "began" ) then
      self:destroy()
    elseif ( event.phase == "ended" ) then
    end
end
