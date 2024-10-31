my = require("lib.my.init")

require("lib.batteries"):export()
Concord = require("lib.Concord")
baton = require("lib.baton.baton")
Concord.helpers = my.concord_helpers

require("components")

Systems = {}
Concord.utils.loadNamespace("systems", Systems)

local world = Concord.world()
local physic_world

function world:onEntityAdded(e)
   -- add the key component to the entity in order to have a unique
   -- key.value for each entity and be able to use world:getEntityByKey(key)
   e:give("key")
end

function world:onEntityRemoved(e)
   if e.physic_props then
      e.physic_props.fixture:release()
      e.physic_props.body:destroy()
      e.physic_props.body:release()
      e.physic_props.shape:release()
   end
end

function love.load()
   -- just for fast prototyping, if you want to add systems
   -- in order do it manually
   local allSystems = {}
   for _, system in pairs(Systems) do
      table.insert(allSystems, system)
   end
   world:addSystems(table.unpack(allSystems))

   Concord.entity(world):give(
      "player_input",
      baton.new({
         controls = {
            left = { "key:left", "key:a", "axis:leftx-", "button:dpleft" },
            right = { "key:right", "key:d", "axis:leftx+", "button:dpright" },
            up = { "key:up", "key:w", "axis:lefty-", "button:dpup" },
            down = { "key:down", "key:s", "axis:lefty+", "button:dpdown" },
            shoot = { "key:space", "button:a" },
            thrust = { "key:e", "button:x" },
            pause = { "key:p", "button:start" },
         },
         pairs = {
            move = { "down", "up", "left", "right" },
         },
         joystick = love.joystick.getJoysticks()[1],
      })
   )

   world:emit("load")
   world:emit("create_entities")
end

function love.update(dt)
   world:emit("pre_update", dt)
   world:emit("input", dt)
   world:emit("physic_update", dt)
   world:emit("update", dt)
end

function love.draw()
   world:emit("before_draw")
   world:emit("draw")
   world:emit("after_draw")
end
