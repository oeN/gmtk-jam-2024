local LinkPhysicsAndEcsSystem = Concord.system({
   pool = {
      "physic_props",
      "position",
      "angle",
   },
})

LinkPhysicsAndEcsSystem.enabled_on_game_states = {
   "playing",
}

function LinkPhysicsAndEcsSystem:update(_dt)
   for _, e in ipairs(self.pool) do
      local position = e.position.value
      local physic_body = e.physic_props.body

      local x, y = physic_body:getPosition()
      position.x = x
      position.y = y

      e.angle.value = physic_body:getAngle()
   end
end

return LinkPhysicsAndEcsSystem
