---------------------------------------------------------------------------------------------------
--  ┏┓┳┓┏┳┓┳┏┳┓┳┏┓┏┓
--  ┣ ┃┃ ┃ ┃ ┃ ┃┣ ┗┓
--  ┗┛┛┗ ┻ ┻ ┻ ┻┗┛┗┛
---------------------------------------------------------------------------------------------------
local MOD  = require "shared.mod"
local ID   = require "shared.names"
local prototypes = {}
---------------------------------------------------------------------------------------------------
-- UNDERGROUND ELECTRIC OUTLETS + SUBSTATION
---------------------------------------------------------------------------------------------------
-- Generates underground variants of the electric poles + substation.

local function createUndergroundOutletEntity(poleName)
    local outlet = util.table.deepcopy(data.raw["electric-pole"][poleName])
    if outlet == nil then return end

    local small = outlet.selection_box[2][1] <= 0.5

    outlet.name = ID.underground[poleName]
    outlet.icon = "__"..MOD.name.."__/graphics/icons/"..ID.asset_dict[poleName]..".png"
    outlet.icon_mipmaps = 1
    outlet.drawing_box_vertical_extension = 0
    outlet.minable.result = ID.underground[poleName] -- entity/item names kept identical
    outlet.resistances = {
        { type = "fire", percent = 100 } -- just makes it the same for all
    }
    outlet.impact_category = "metal"
    outlet.corpse = ID.underground[poleName].."-remnants"
    outlet.dying_explosion = small and "medium-electric-pole-explosion" or "substation-explosion"
    outlet.draw_copper_wires = false
    outlet.draw_circuit_wires = false
    outlet.connection_points = {{ shadow = {}, wire = {} }} -- mandatory, except contents
    outlet.track_coverage_during_drag_building = true
    outlet.radius_visualisation_picture = {
        filename = "__"..MOD.name.."__/graphics/entities/radius-visualization-picture.png",
        priority = "extra-high", width = 180, height = 180, scale = 1
    }
    if small then
        outlet.pictures = { layers = {
            {
                filename = "__"..MOD.name.."__/graphics/entities/"..ID.asset_dict[poleName]..".png",
                priority = "high", width = 72, height = 72, scale = 0.50, direction_count = 1
            },{
                filename = "__"..MOD.name.."__/graphics/entities/"..ID.asset_dict[poleName].."-shadow.png",
                priority = "high", width = 108, height = 72, scale = 0.50, shift = {0.4, 0},
                direction_count = 1, draw_as_shadow = true
            }
        }}
    else
        outlet.pictures = { layers = {
            {
                filename = "__"..MOD.name.."__/graphics/entities/"..ID.asset_dict[poleName]..".png",
                priority = "high", width = 144, height = 144, scale = 0.50, direction_count = 1
            },{
                filename = "__"..MOD.name.."__/graphics/entities/"..ID.asset_dict[poleName].."-shadow.png",
                priority = "high", width = 216, height = 144, scale = 0.50, shift = {0.7, 0},
                direction_count = 1, draw_as_shadow = true
            }
        }}
    end
    outlet.water_reflection = nil

    return outlet
end

for _, pole_name in pairs({
    "small-electric-pole", "medium-electric-pole", "big-electric-pole", "substation"
}) do
    table.insert(prototypes, createUndergroundOutletEntity(pole_name))
end

---------------------------------------------------------------------------------------------------
-- FINAL WRITE TO DATABASE
---------------------------------------------------------------------------------------------------
if next(prototypes) ~= nil then
    data:extend(prototypes)
end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
