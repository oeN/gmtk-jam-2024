local GameState = class({ name = "GameState" })

GameState.states = {
   "menu",
   "pause",
   "playing",
   "game_over"
}

function GameState:new()
   self.current = "menu" -- default state
   self.points = 0
   self.player_lives = 3
end

function GameState:is_system_enabled(system)
   return system.enabled_on_game_states[1] == "all" or
       tablex.index_of(system.enabled_on_game_states, self.current) ~= nil
end

function GameState:toggle_pause()
   if self.current == "pause" or self.current == "menu" then
      self:playing()
   else
      self:pause()
   end
end

function GameState:menu()
   self.current = "menu"
end

function GameState:playing()
   self.current = "playing"
end

function GameState:pause()
   self.current = "pause"
end

function GameState:game_over()
   self.current = "game_over"
end

return GameState