local UpdatePhysicSystem = Concord.system({
   -- we'll update the physics world here only if there are
   -- entities with the "physic_props" component
   pool = { "physic_props" },
})

UpdatePhysicSystem.enabled_on_game_states = {
   "playing",
}

function UpdatePhysicSystem:physic_update(dt)
   local world = self:getWorld()
   local physics_world = world:getResource("physics_world")
   physics_world:update(dt)
end

return UpdatePhysicSystem
