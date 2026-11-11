---------------------------------------------------------------------------------------------------
--  ┳┓┏┓┏┳┓┏┓
--  ┃┃┣┫ ┃ ┣┫
--  ┻┛┛┗ ┻ ┛┗
---------------------------------------------------------------------------------------------------

local MOD = require "shared.mod"

require "prototypes.remnants"
require "prototypes.entities"
require "prototypes.items"
require "prototypes.recipes"
require "prototypes.technology"

---------------------------------------------------------------------------------------------------
-- ASSEMBLER MK1 FLUID BOX
---------------------------------------------------------------------------------------------------
-- Makes the Assembler machine MK1 accept fluid input, so resinated wood elastomer recipe can work
-- early on. It seems unlikely to cause any issues. May be disabled with certain mods that don't
-- need it.

if not (MOD.delta_rubber or MOD.angels_petrochem) then

    require ("__base__.prototypes.entity.pipecovers")

    local assembler = data.raw["assembling-machine"]["assembling-machine-1"]
    if assembler ~= nil then
        local pipe_pictures = require("__base__.prototypes.entity.assembler-pictures")
        table.insert(assembler.crafting_categories, "crafting-with-fluid")
        assembler.fluid_boxes = {
            {
                production_type = "input",
                pipe_picture = pipe_pictures.assembler3pipepictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections = {{
                    flow_direction = "input",
                    direction = defines.direction.north,
                    position = {0, -1}
                }},
                secondary_draw_orders = { north = -1 }
            },{
                production_type = "output",
                pipe_picture = pipe_pictures.assembler3pipepictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections = { {
                    flow_direction = "output",
                    direction = defines.direction.south,
                    position = {0, 1}
                }},
                secondary_draw_orders = { north = -1 }
            }
        }
        assembler.fluid_boxes_off_when_no_fluid_recipe = true
    end

end

---------------------------------------------------------------------------------------------------
