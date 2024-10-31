local DrawPhysicShapesSystem = Concord.system({
   pool = { "physic_props" },
})

DrawPhysicShapesSystem.enabled_on_game_states = {
   "playing",
}

function DrawPhysicShapesSystem:draw()
   local lg = my.lg
   for _, e in ipairs(self.pool) do
      local shape = e.physic_props.shape
      local body = e.physic_props.body

      lg.push_pop(function()
         lg.setColor(1, 0, 0)
         if shape:getType() == "polygon" then
            lg.polygon("line", body:getWorldPoints(shape:getPoints()))
         elseif shape:getType() == "circle" then
            lg.circle("line", body:getX(), body:getY(), shape:getRadius())
         else
            lg.line(body:getWorldPoints(shape:getPoints()))
         end
      end)
   end
end

return DrawPhysicShapesSystem
