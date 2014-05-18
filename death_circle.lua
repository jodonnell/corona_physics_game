require 'class'
local physics = require( "physics" )
local _ = require ("moses")

DeathCircle = class()

function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
      self:removeSelf()
    elseif ( event.phase == "ended" ) then
    end
end

function DeathCircle:init(x, y)
  self.circle = display.newCircle( x, y, 50 )
  physics.addBody( self.circle, "static", {} )

  self.circle.collision = onLocalCollision
  self.circle:addEventListener( "collision", self.circle )
  self:setColor(0.3, 0.3, 0.3)
end

function DeathCircle:setColor(r, g, b)
  self.circle:setFillColor(r, g, b)
end
