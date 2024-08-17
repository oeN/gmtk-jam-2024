local ConcordHelpers = {}

ConcordHelpers.value_component_with_default = function(default)
   return function(c, value)
      c.value = value or default
   end
end

ConcordHelpers.value_component = ConcordHelpers.value_component_with_default(0)

return ConcordHelpers