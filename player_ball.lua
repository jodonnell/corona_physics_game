require 'class'
local physics = require( "physics" )
local _ = require ("moses")

PlayerBall = class()

function PlayerBall:init(x, y)
  self.circle = display.newCircle( x, y, 5 )
  self.circle:setFillColor(0, 0, 0)
  physics.addBody( self.circle, {radius=5, bounce=1} )
  self.circle:setLinearVelocity(300, 300)
end

function PlayerBall:setColor(r, g, b)
  self.circle:setFillColor(r, g, b)
end

function PlayerBall:shouldBounceOffXWall()
  return self.circle.x > 900 or self.circle.x < 0
end

function PlayerBall:shouldBounceOffYWall()
  return self.circle.y > 1200 or self.circle.y < 0
end

function PlayerBall:reverseXSpeed()
  local vx, vy = self.circle:getLinearVelocity()
  self.circle:setLinearVelocity(vx * -1, vy)
end

function PlayerBall:reverseYSpeed()
    local vx, vy = self.circle:getLinearVelocity()
    self.circle:setLinearVelocity(vx, vy * -1)
end
