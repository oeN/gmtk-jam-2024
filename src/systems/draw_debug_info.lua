local DrawDebugInfo = Concord.system({})

DrawDebugInfo.enabled_on_game_states = {
   "all",
}

local lg = my.lg

function DrawDebugInfo:draw()
   local world = self:getWorld()
   local debug_info = world:getResource("debug_info") or {}
   local ui_canvas = world:getResource("ui_canvas")

   lg.setCanvas(ui_canvas)
   local keys = tablex.keys(debug_info)
   tablex.sort(keys)
   for i, key in ipairs(keys) do
      lg.print(key .. ": " .. debug_info[key], 10, 20 * i)
   end
   lg.setCanvas()
end

return DrawDebugInfo
