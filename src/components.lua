local vc_default = Concord.helpers.value_component_with_default

Concord.component("label", vc_default(""))
Concord.component("angle", vc_default(0.0))
Concord.component("position", vc_default(vec2(0, 0)))

Concord.component("player_input", vc_default(nil))

Concord.component("physic_props", function(c, params)
   params = params or {}
   c.body = params.body or nil
   c.shape = params.shape or nil
   c.fixture = params.fixture or nil
end)

Concord.component("wheel")
