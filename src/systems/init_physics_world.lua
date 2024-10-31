local InitPhysicsWorld = Concord.system()

function InitPhysicsWorld:load()
   local world = self:getWorld()
   lp.setMeter(64)
   local physics_world = lp.newWorld(0, 0, true)
   world:setResource("physics_world", physics_world)
end

return InitPhysicsWorld
