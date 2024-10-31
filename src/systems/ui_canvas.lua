local UICanvasSystem = Concord.system({})

local lg = my.lg

function UICanvasSystem:load()
   local world = self:getWorld()
   local canvas = lg.newCanvas(lg.getWidth(), lg.getHeight())
   world:setResource("ui_canvas", canvas)
   world:setResource("debug_info", {})
end

function UICanvasSystem:before_draw()
   local world = self:getWorld()
   local ui_canvas = world:getResource("ui_canvas")
   lg.setCanvas(ui_canvas)
   lg.clear()
   lg.setCanvas()
end

function UICanvasSystem:after_draw()
   local world = self:getWorld()
   local ui_canvas = world:getResource("ui_canvas")

   lg.draw(ui_canvas, 0, 0)
end

return UICanvasSystem
