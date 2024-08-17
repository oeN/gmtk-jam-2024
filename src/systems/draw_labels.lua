local DrawLabelsSystem = Concord.system({
   pool = { "label", "position" }
})

function DrawLabelsSystem:draw()
   for _, e in ipairs(self.pool) do
      local pos = e.position.value
      lg.print(e.label.value, pos.x, pos.y)
   end
end

return DrawLabelsSystem