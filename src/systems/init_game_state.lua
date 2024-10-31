local GameState = require("game_state")

local InitGameState = Concord.system()

function InitGameState:load()
   local world = self:getWorld()
   world:setResource("game_state", GameState())
end

return InitGameState