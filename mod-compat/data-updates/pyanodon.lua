---------------------------------------------------------------------------------------------------
--  ┏┓┏┓┳┳┓┏┓┏┓┏┳┓┳┳┓┳┓ ┳┏┳┓┓┏
--  ┃ ┃┃┃┃┃┃┃┣┫ ┃ ┃┣┫┃┃ ┃ ┃ ┗┫
--  ┗┛┗┛┛ ┗┣┛┛┗ ┻ ┻┻┛┻┗┛┻ ┻ ┗┛
---------------------------------------------------------------------------------------------------
local MOD  = require "shared.mod"
if not (MOD.py_coal_proc or MOD.py_petroleum) then return end
local ID   = require "shared.names"
local FPD  = require "functions.prototypes-database"
---------------------------------------------------------------------------------------------------
-- PYANODON'S MOD SUITE
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- PYANODON'S COAL PROCESSING
---------------------------------------------------------------------------------------------------
-- Pyanodon's Coal Processing changes the recipes for all the electric poles and the substation.
-- Since no sticks are used, the recipes will simply be adapted to use the exact same ingredients
-- in the same amounts and in the same order, except the insulated copper cable is used instead.

if MOD.py_coal_proc then

    -- Small underground outlet.
    local small_outlet = data.raw.recipe[ID.recipe.u_small_outlet]
    if small_outlet ~= nil then
        small_outlet.ingredients = {
            { type = "item", name = ID.item.insulated_cable, amount =  2 },
            { type = "item", name = "iron-plate",            amount =  1 }
        }
        small_outlet.results = {
            { type = "item", name = ID.item.u_small_outlet,  amount =  1 }
        }
    end

    -- Medium underground outlet.
    local medium_outlet = data.raw.recipe[ID.recipe.u_medium_outlet]
    if medium_outlet ~= nil then
        medium_outlet.ingredients = {
            { type = "item", name = ID.item.insulated_cable, amount =  2 },
            { type = "item", name = "nbfe-alloy",            amount =  2 },
            { type = "item", name = "niobium-plate",         amount =  1 }
        }
    end

    -- Big underground outlet.
    local big_outlet = data.raw.recipe[ID.recipe.u_big_outlet]
    if big_outlet ~= nil then
        big_outlet.ingredients = {
            { type = "item", name = ID.item.insulated_cable, amount = 19 },
            { type = "item", name = "steel-plate",           amount =  6 },
            { type = "item", name = "niobium-plate",         amount =  2 }
        }
    end

    -- Underground substation.
    local substation_outlet = data.raw.recipe[ID.recipe.u_substation]
    if substation_outlet ~= nil then
        substation_outlet.ingredients = {
            { type = "item", name = ID.item.insulated_cable, amount =  6 },
            { type = "item", name = "advanced-circuit",      amount =  5 },
            { type = "item", name = "steel-plate",           amount = 10 }
        }
    end
end

---------------------------------------------------------------------------------------------------
-- PYANODON'S PETROLEUM HANDLING
---------------------------------------------------------------------------------------------------
-- Pyanodon's Petroleum Handling adds rubber fairly early on, so this mod will make use of that
-- instead.
if MOD.py_petroleum then
    FPD.HideItem(ID.item.rubber)
    FPD.HideRecipe(ID.recipe.synthetic_rubber)
    FPD.HideTech(ID.tech.synthetic_rubber)
    FPD.ReplaceIngredientName(ID.recipe.rubber_cable, ID.item.rubber, "rubber")
    FPD.AddRecipeUnlock("rubber", ID.recipe.rubber_cable)
end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
