local PATH = (...):gsub('%.init$', '')

local my = {}

require(PATH .. '.lua_fixes')
require(PATH .. '.love_extensions')
require(PATH .. '.vscode_debugger')

my.concord_helpers = require(PATH .. '.concord_helpers')

my.lg = love.graphics
my.lk = love.keyboard
my.lm = love.math
my.lp = love.physics

return my