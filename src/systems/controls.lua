local ControlsSystem = Concord.system({
   pool = {
      "player_input",
   }
})

-- ControlsSystem.enabled_on_game_states = {
--    "playing",
-- }

function ControlsSystem:input(_dt)
   local world = self:getWorld()
   local game_state = world:getResource("game_state")

   for _, e in ipairs(self.pool) do
      local player_input = e.player_input.value;
      player_input:update()

      -- local active_device = player_input:getActiveDevice()
      if player_input:pressed("pause") then
         game_state:toggle_pause()
      end
   end
end

return ControlsSystem