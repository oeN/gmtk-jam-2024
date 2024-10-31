local vc_default = Concord.helpers.value_component_with_default

Concord.component("label", vc_default(""))
Concord.component("position", vc_default(vec2(0, 0)))

Concord.component("player_input", vc_default(nil))