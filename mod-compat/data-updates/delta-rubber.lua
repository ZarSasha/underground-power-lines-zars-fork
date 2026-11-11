---------------------------------------------------------------------------------------------------
--  ┏┓┏┓┳┳┓┏┓┏┓┏┳┓┳┳┓┳┓ ┳┏┳┓┓┏
--  ┃ ┃┃┃┃┃┃┃┣┫ ┃ ┃┣┫┃┃ ┃ ┃ ┗┫
--  ┗┛┗┛┛ ┗┣┛┛┗ ┻ ┻┻┛┻┗┛┻ ┻ ┗┛
---------------------------------------------------------------------------------------------------
local MOD  = require "shared.mod"
if not MOD.delta_rubber then return end
local ID   = require "shared.names"
local FPD  = require "functions.prototypes-database"
---------------------------------------------------------------------------------------------------
-- RUBBER [∆]
---------------------------------------------------------------------------------------------------
-- Rubber [∆] adds resin and rubber. Resin can be extracted from wood and processed into rubber
-- through simple recipes that are available right from the beginning.

-- This mod will hide the existing resin and rubber and make use of the above instead to craft the
-- insulated copper cable which the underground outlets require. The recipe using plastic will be
-- left alone, though.

-- Hides resin and rubber items/recipes and tech that unlocks them.
FPD.HideItem(ID.item.resin)
FPD.HideItem(ID.item.wood_elastomer)
FPD.HideItem(ID.item.rubber)
FPD.HideRecipe(ID.recipe.resin)
FPD.HideRecipe(ID.recipe.wood_elastomer)
FPD.HideRecipe(ID.recipe.synthetic_rubber)
FPD.HideRecipe(ID.recipe.elastomer_cable)
FPD.HideTech(ID.tech.wood_elastomer)
FPD.HideTech(ID.tech.synthetic_rubber)

-- Enables recipe for insulated cable with electronics tech and switches the rubber ingredient.
FPD.AddRecipeUnlock("electronics", ID.recipe.rubber_cable)
FPD.ReplaceIngredientName(ID.recipe.rubber_cable, ID.item.rubber, "rubber")

-- Replaces secondary icon representing the rubber used in the recipe for the insulated cable.
local rubber_cable = data.raw.recipe[ID.recipe.rubber_cable]
if rubber_cable ~= nil then
    rubber_cable.icons[2].icon = "__delta-rubber__/graphics/rubber.png"
end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
