---------------------------------------------------------------------------------------------------
--  ┏┓┏┓┳┳┓┏┓┏┓┏┳┓┳┳┓┳┓ ┳┏┳┓┓┏
--  ┃ ┃┃┃┃┃┃┃┣┫ ┃ ┃┣┫┃┃ ┃ ┃ ┗┫
--  ┗┛┗┛┛ ┗┣┛┛┗ ┻ ┻┻┛┻┗┛┻ ┻ ┗┛
---------------------------------------------------------------------------------------------------
local MOD  = require "shared.mod"
if not MOD.delta_rubber then return end
local ID   = require "shared.names"
local FUNC = require "functions"
---------------------------------------------------------------------------------------------------
-- RUBBER [∆]
---------------------------------------------------------------------------------------------------
-- Rubber [∆] adds resin and rubber. Resin can be extracted from wood and processed into rubber
-- through simple recipes that are available right from the beginning.

-- This mod will hide the existing resin and rubber and make use of the above instead to craft the
-- insulated copper cable which the underground outlets require. The recipe using plastic will be
-- left alone, though.

-- Hides resin and rubber items/recipes and tech that unlocks them.
FUNC.HideItem(ID.item.resin)
FUNC.HideItem(ID.item.wood_elastomer)
FUNC.HideItem(ID.item.rubber)
FUNC.HideRecipe(ID.recipe.resin)
FUNC.HideRecipe(ID.recipe.wood_elastomer)
FUNC.HideRecipe(ID.recipe.synthetic_rubber)
FUNC.HideRecipe(ID.recipe.elastomer_cable)
FUNC.HideTech(ID.tech.wood_elastomer)
FUNC.HideTech(ID.tech.synthetic_rubber)

-- Enables recipe for insulated cable with electronics tech and switches the rubber ingredient.
FUNC.AddRecipeUnlock("electronics", ID.recipe.rubber_cable)
FUNC.ReplaceIngredientName(ID.recipe.rubber_cable, ID.item.rubber, "rubber")

-- Replaces secondary icon representing the rubber used in the recipe for the insulated cable.
local rubber_cable = data.raw.recipe[ID.recipe.rubber_cable]
if rubber_cable ~= nil then
    rubber_cable.icons[2].icon = "__delta-rubber__/graphics/rubber.png"
end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
