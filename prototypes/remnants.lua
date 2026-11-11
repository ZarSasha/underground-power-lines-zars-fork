---------------------------------------------------------------------------------------------------
--  ┳┓┏┓┳┳┓┳┓┏┓┳┓┏┳┓┏┓
--  ┣┫┣ ┃┃┃┃┃┣┫┃┃ ┃ ┗┓
--  ┛┗┗┛┛ ┗┛┗┛┗┛┗ ┻ ┗┛
---------------------------------------------------------------------------------------------------
local MOD = require "shared.mod"
local ID  = require "shared.names"
local prototypes = {}
---------------------------------------------------------------------------------------------------
-- UNDERGROUND ELECTRIC OUTLETS + SUBSTATION
---------------------------------------------------------------------------------------------------

local function createUndergroundOutletRemnants(poleName)
    local remnants = {
        type = "corpse",
        name = ID.underground[poleName].."-remnants",
        icon = "__"..MOD.name.."__/graphics/icons/"..ID.asset_dict[poleName]..".png",
        icon_size = 64,
        flags = { "placeable-neutral", "not-on-map" },
        subgroup = "energy-pipe-distribution-remnants",
        order = "a-a-a",
        collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15,
        final_render_layer = "remnants",
        animation_overlay_final_render_layer = "object",
        --remove_on_tile_placement = false
    }
    if remnants.selection_box[2][1] <= 0.5 then
        remnants.animation = { layers = {{
            filename = "__"..MOD.name.."__/graphics/remnants/"..ID.asset_dict[poleName]..".png",
            line_length = 1, width = 72, height = 72, scale = 0.50,
            frame_count = 1, direction_count = 1,
        }}}
    else
        remnants.animation = { layers = {{
            filename = "__"..MOD.name.."__/graphics/remnants/"..ID.asset_dict[poleName]..".png",
            line_length = 1, width = 144, height = 144, scale = 0.50,
            frame_count = 1, direction_count = 1,
        }}}
    end
    return remnants
end

for _, pole_name in pairs({
    "small-electric-pole", "medium-electric-pole", "big-electric-pole", "substation"
}) do
    table.insert(prototypes, createUndergroundOutletRemnants(pole_name))
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
