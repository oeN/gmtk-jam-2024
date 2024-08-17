lg = love.graphics
lw = love.window
lk = love.keyboard
lm = love.math
lp = love.physics

function lg.push_pop(callback)
   lg.push()
   local current_color = { lg.getColor() }
   local current_font = lg.getFont()
   callback()
   lg.setColor(current_color)
   lg.setFont(current_font)
   lg.pop()
end