-- make init.lua work
package.path = package.path .. ";./?/init.lua"

-- why do I need this?
table.unpack = table.unpack or unpack
