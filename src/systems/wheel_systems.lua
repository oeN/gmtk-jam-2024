local WheelSystem = Concord.system({
   pool = { "wheel", "physic_props" },
   player_input = { "player_input" },
})

function WheelSystem:create_entities()
   local world = self:getWorld()
   local physics_world = world:getResource("physics_world")
   local lp = my.lp

   local physic_body = lp.newBody(physics_world, 100, 100, "dynamic")
   local physic_shape = lp.newPolygonShape(-20, -12.5, 20, -12.5, 20, 12.5, -20, 12.5)
   local physic_fixture = lp.newFixture(physic_body, physic_shape, 1)

   physic_fixture:setRestitution(0.5)
   physic_body:setMass(100)
   physic_body:setLinearDamping(0.2)
   physic_body:setAngularDamping(0.8)

   -- temporary add here a simple wheel
   local wheel = Concord.entity(self:getWorld()):give("wheel"):give("key")
   physic_fixture:setUserData(wheel.key.value)
   wheel:give("position", vec2(100, 100)):give("angle"):give("physic_props", {
      body = physic_body,
      shape = physic_shape,
      fixture = physic_fixture,
   })
end

function WheelSystem:update(dt)
   local world = self:getWorld()
   local debug_info = world:getResource("debug_info") or {}

   local moveX, moveY = 0, 0
   local forwardForce = 2000
   local turnSpeed = 30

   for _, e in ipairs(self.player_input) do
      local player_input = e.player_input.value
      moveX, moveY = player_input:get("move")
      debug_info.move = "X: " .. moveX .. " - Y: " .. moveY
   end

   for _, e in ipairs(self.pool) do
      local physic_body = e.physic_props.body
      local forX, forY = physic_body:getWorldVector(1, 0)

      local dx, dy = forwardForce * forX * moveX, forwardForce * forY * moveY

      physic_body:applyForce(dx, dy)
      physic_body:setAngularVelocity(moveY * turnSpeed * dt)
   end

   -- world:setResource("debug_info", debug_info)
end

return WheelSystem
