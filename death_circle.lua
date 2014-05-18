require 'class'
local physics = require( "physics" )
local _ = require ("moses")

DeathCircle = class()

function DeathCircle:init(x, y)
  self.circle = display.newCircle( x, y, 50 )
  self:setColor(0.3, 0.3, 0.3)

  physics.addBody( self.circle, "static", {radius=50} )

  self.collisionEvent = function(a, event) self:collision(event) end
  self.circle.collision = self.collisionEvent
  self.circle:addEventListener( "collision", self.circle )
end

function DeathCircle:setColor(r, g, b)
  self.circle:setFillColor(r, g, b)
end

function DeathCircle:collision(event)
    if ( event.phase == "began" ) then
      self.circle:removeSelf()
      self.circle = nil
      Runtime:dispatchEvent( {name="gameOver"} )
    elseif ( event.phase == "ended" ) then
    end
end

function DeathCircle:destroy()
  if self.circle then
    self.circle:removeSelf()
  end
end
