local my = require 'lib.my.init'

require("lib.batteries"):export()
Concord = require("lib.Concord")
Concord.helpers = my.concord_helpers

local vc_default = Concord.helpers.value_component_with_default


Concord.component("label", vc_default(""))
Concord.component("position", vc_default(vec2(0, 0)))

Systems = {}
Concord.utils.loadNamespace("systems", Systems)

local world = Concord.world()

function world:onEntityAdded(e)
   -- add the key component to the entity in order to have a unique
   -- key.value for each entity and be able to use world:getEntityByKey(key)
   e:give("key")
end

function love.load()
   -- just for fast prototyping, if you want to add systems
   -- in order do it manually
   local allSystems = {}
   for _, system in pairs(Systems) do
      table.insert(allSystems, system)
   end
   world:addSystems(table.unpack(allSystems))

   Concord.entity(world)
       :give("label", "Hello, World!")
       :give("position", vec2(100, 100))

   world:emit("load")
end

function love.update(dt)
   world:emit("update", dt)
end

function love.draw()
   world:emit("draw")
end