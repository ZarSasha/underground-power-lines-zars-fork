---------------------------------------------------------------------------------------------------
--  ┏┓┏┓┳┳┓┏┓┏┓┏┳┓┳┳┓┳┓ ┳┏┳┓┓┏
--  ┃ ┃┃┃┃┃┃┃┣┫ ┃ ┃┣┫┃┃ ┃ ┃ ┗┫
--  ┗┛┗┛┛ ┗┣┛┛┗ ┻ ┻┻┛┻┗┛┻ ┻ ┗┛
---------------------------------------------------------------------------------------------------
local MOD  = require "shared.mod"
if not MOD.space_exploration then return end
local ID   = require "shared.names"
---------------------------------------------------------------------------------------------------
-- SPACE EXPLORATION
---------------------------------------------------------------------------------------------------

--- RECIPES ---

-- Space Exploration changes the recipes for all the larger electric poles and the substation. This
-- mod will adapt the recipes for the underground outlets so they mostly fit in. NB: The medium
-- outlet will not be made to require the small one for its recipe, because it annoys me and it's
-- an exception for the mod anyway.

-- Small underground outlet. No changes.

-- Medium underground outlet. Does not include the small one in its recipe!
local medium_outlet = data.raw.recipe[ID.recipe.u_medium_outlet]
if medium_outlet ~= nil then
    medium_outlet.ingredients = {
        { type = "item", name = "iron-plate",            amount =  3 },
        { type = "item", name = ID.item.insulated_cable, amount =  6 },
        { type = "item", name = "steel-plate",           amount =  2 }
    }
end

-- Big underground outlet.
local big_outlet = data.raw.recipe[ID.recipe.u_big_outlet]
if big_outlet ~= nil then
    big_outlet.ingredients = {
        { type = "item", name = "iron-plate",            amount =  4 },
        { type = "item", name = ID.item.insulated_cable, amount = 10 },
        { type = "item", name = "concrete",              amount =  1 },
        { type = "item", name = "steel-plate",           amount =  5 }
    }
end

-- Underground substation.
local substation_outlet = data.raw.recipe[ID.recipe.u_substation]
if substation_outlet ~= nil then
    substation_outlet.ingredients = {
        { type = "item", name = ID.item.insulated_cable, amount = 20 },
        { type = "item", name = "advanced-circuit",      amount =  5 },
        { type = "item", name = "concrete",              amount =  5 },
        { type = "item", name = "steel-plate",           amount = 10 }
    }
end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
