require 'class'
local physics = require( "physics" )
local _ = require ("moses")

GoalCircle = class()

function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
      self:removeSelf()
      self = nil
    elseif ( event.phase == "ended" ) then
    end
end

function GoalCircle:init(x, y)
  self.circle = display.newCircle( x, y, 50 )
  self.circle:setFillColor(1, 0, 1)
  physics.addBody( self.circle, "static", {} )

  self.circle.collision = onLocalCollision
  self.circle:addEventListener( "collision", self.circle )
end

function GoalCircle:setColor(r, g, b)
  self.circle:setFillColor(r, g, b)
end

function GoalCircle:destroy()
  if self.cirle then
    self.circle:removeSelf()
  end
end
