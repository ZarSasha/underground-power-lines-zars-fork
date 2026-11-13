---------------------------------------------------------------------------------------------------
--  ┏┓┏┓┳┳┓┏┓┏┓┏┳┓┳┳┓┳┓ ┳┏┳┓┓┏
--  ┃ ┃┃┃┃┃┃┃┣┫ ┃ ┃┣┫┃┃ ┃ ┃ ┗┫
--  ┗┛┗┛┛ ┗┣┛┛┗ ┻ ┻┻┛┻┗┛┻ ┻ ┗┛
---------------------------------------------------------------------------------------------------
local MOD  = require "shared.mod"
if not MOD.wood_industry then return end
local ID   = require "shared.names"
local FPL  = require "functions.prototypes-local"
local FPD  = require "functions.prototypes-database"
---------------------------------------------------------------------------------------------------
-- WOODEN INDUSTRY
---------------------------------------------------------------------------------------------------
-- Makes use of resin and wood chips from this mod. Still keeps resin recipe, because it works
-- just fine as an early, but inefficient alternative.

-- Hides resin item. Hides rubber completely, not needed.
FPD.HideItem(ID.item.resin)
FPD.HideItem(ID.item.rubber)
FPD.HideRecipe(ID.recipe.synthetic_rubber)
FPD.HideRecipe(ID.recipe.rubber_cable)
FPD.HideTech(ID.tech.synthetic_rubber)

-- Changes icon of resin recipe, keeps original ordering despite new product.
local resin_recipe = data.raw.recipe[ID.recipe.resin]
if resin_recipe ~= nil then
    resin_recipe.icon = "__wood-industry__/graphics/icons/resin.png"
    resin_recipe.subgroup = "raw-material"
	resin_recipe.order = "a[elastomer-production]-a[resin]"
	FPL.ReplaceResultName(resin_recipe, ID.item.resin, "resin")
end

-- Updates recipe for wood elastomer.
local elastomer_recipe = data.raw.recipe[ID.recipe.wood_elastomer]
if elastomer_recipe ~= nil then
    --[[
    -- Replaces wood with wood chips for slightly higher realism.
    FPL.ReplaceIngredient(elastomer_recipe, "wood", {
        type = "item", name = "woodchips", amount = 10
    })
    ]]
    -- Replaces resin ingredient.
    FPL.ReplaceIngredientName(elastomer_recipe, ID.item.resin, "resin")
end

---------------------------------------------------------------------------------------------------
