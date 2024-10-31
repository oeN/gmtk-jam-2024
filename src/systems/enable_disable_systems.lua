local EnableDisableSystems = Concord.system({
})

function EnableDisableSystems:pre_update(dt)
   local world = self:getWorld()
   local game_state = world:getResource("game_state")
   for _, system in ipairs(world:getSystems()) do
      if system.enabled_on_game_states then
         local is_enabled = game_state:is_system_enabled(system)
         system:setEnabled(is_enabled)
      end
   end
end

return EnableDisableSystems