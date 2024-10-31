local GameState = require("game_state")

local InitGameState = Concord.system()

function InitGameState:load()
   local world = self:getWorld()
   local game_state = GameState()

   game_state:playing()
   world:setResource("game_state", game_state)
end

return InitGameState
