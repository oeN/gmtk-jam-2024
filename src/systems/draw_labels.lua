local DrawLabelsSystem = Concord.system({
   pool = { "label", "position" }
})

DrawLabelsSystem.enabled_on_game_states = { "playing" }

-- it will be callend only once and is a fast way to test things
function DrawLabelsSystem:load()
   local world = self:getWorld()

   Concord.entity(world)
       :give("label", "Hello, World! Active on Playing state")
       :give("position", vec2(100, 100))
end

function DrawLabelsSystem:draw()
   for _, e in ipairs(self.pool) do
      local pos = e.position.value
      lg.print(e.label.value, pos.x, pos.y)
   end
end

return DrawLabelsSystem