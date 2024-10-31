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
   -- physic_body:setLinearDamping(0.9)
   -- physic_body:setAngularDamping(0.2)

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

   local move_vec = vec2(0, 0)
   local forward_force = 10000
   local turn_speed = 70
   local grip_factor = 0.6
   local inertia_factor = 0.1

   for _, e in ipairs(self.player_input) do
      local player_input = e.player_input.value
      move_vec:scalar_set(player_input:get("move"))
      debug_info.move = tostring(move_vec)
   end

   for _, e in ipairs(self.pool) do
      local physic_body = e.physic_props.body
      local mass = physic_body:getMass()

      -- X is forward, -X is backward, +Y is left, -Y is right
      local current_right_normal = vec2(physic_body:getWorldVector(0, -1))
      local current_forward_normal = vec2(physic_body:getWorldVector(1, 0))

      local vel_vec = vec2(physic_body:getLinearVelocity())
      local lateral_velocity = current_right_normal * current_right_normal:dot(vel_vec)

      debug_info.vel_vec = tostring(vel_vec)
      debug_info.lateral_velocity = tostring(lateral_velocity)

      -- get rid of all the lateral velocity
      local impulse = lateral_velocity * mass * -grip_factor
      physic_body:applyLinearImpulse(impulse:unpack())
      physic_body:applyAngularImpulse(inertia_factor * physic_body:getInertia() * -physic_body:getAngularVelocity())

      debug_info.forward_vec = tostring(current_forward_normal)

      local force_vec = current_forward_normal * forward_force * move_vec.x
      if move_vec.x == 0 then
         local forward_velocity = current_forward_normal * current_forward_normal:dot(vel_vec)
         debug_info.forward_velocity = tostring(forward_velocity)
         local current_forward_speed = forward_velocity:normalize()
         force_vec = -forward_force * current_forward_speed
         -- force_vec = forward_velocity * drag_force_magnitude * -vel_vec.x
         -- physic_body:applyForce(drag_vec:unpack())
      end

      debug_info.force_vec = tostring(force_vec)

      physic_body:applyForce(force_vec:unpack())
      physic_body:setAngularVelocity(move_vec.y * turn_speed * dt)
   end

   -- world:setResource("debug_info", debug_info)
end

return WheelSystem
