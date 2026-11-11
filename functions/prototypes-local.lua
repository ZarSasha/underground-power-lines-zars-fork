---------------------------------------------------------------------------------------------------
--  ┏┓┳┳┳┓┏┓┏┳┓┳┏┓┳┓┏┓
--  ┣ ┃┃┃┃┃  ┃ ┃┃┃┃┃┗┓
--  ┻ ┗┛┛┗┗┛ ┻ ┻┗┛┛┗┗┛
---------------------------------------------------------------------------------------------------
local exports = {}
---------------------------------------------------------------------------------------------------
-- PROTOTYPE TABLE MANIPULATION
---------------------------------------------------------------------------------------------------
-- The following function are useful for quickly making changes to local prototypes.

--- ITEMS ---

-- Hides item.
exports.HideItem = function(item)
   item.hidden = true
end

-- Reveals item.
exports.UnhideItem = function(item)
   item.hidden = false
end

--- RECIPES ---

-- Hides and disables recipe.
exports.HideRecipe = function(recipe)
   recipe.enabled = false
   recipe.hidden = true
end

-- Reveals recipe.
exports.UnhideRecipe = function(recipe)
   recipe.hidden = false
end

-- Enables recipe.
exports.EnableRecipe = function(recipe)
   recipe.enabled = true
end

-- Disables recipe.
exports.DisableRecipe = function(recipe)
   recipe.enabled = false
end

-- Only changes the name of a single ingredient in a recipe.
exports.ReplaceIngredientName = function(recipe, IngredientName, newIngredientName)
    for _, ingredient in pairs(recipe.ingredients) do
        if ingredient.name == IngredientName then
            ingredient.name = newIngredientName
        end
    end
end

-- Replaces the amount of a single ingredient in a recipe.
exports.ReplaceIngredientAmount = function(recipe, IngredientName, newIngredient)
    for _, ingredient in pairs(recipe.ingredients) do
        if ingredient.name == IngredientName then
            ingredient = newIngredient
        end
    end
end

-- Replaces only a single ingredient in a recipe. Filters by name, uses table.
exports.ReplaceIngredient = function(recipe, IngredientName, newIngredient)
    for _, ingredient in pairs(recipe.ingredients) do
        if ingredient.name == IngredientName then
            ingredient = newIngredient
        end
    end
end

-- Adds a single ingredient to a recipe, uses table.
exports.AddIngredient = function(recipe, ingredient, position)
    if position ~= nil then
        table.insert(recipe.ingredients, position, ingredient)
    else
        table.insert(recipe.ingredients, ingredient)
    end
end

-- Removes a single ingredient from a recipe, filters by name.
exports.RemoveIngredient = function(recipeName, ingredientName)
    local recipe = data.raw.recipe[recipeName]
    for index, ingredient in pairs(recipe.ingredients) do
        if ingredient.name == ingredientName then
            table.remove(recipe.ingredients, index)
        end
    end
end

--- TECHNOLOGY ---

-- Hides and disables technology (disabled: unavailable for research).
exports.HideTech = function(tech)
    tech.enabled = false
    tech.hidden = true
end

-- Reveals and enables technology (enabled: available for research).
exports.UnhideTech = function(tech)
    tech.enabled = true
    tech.hidden = false
end

-- Adds a recipe to be unlocked with a technology in the database.
exports.AddRecipeUnlock = function(tech, recipeName, position)
    if position ~= nil then
        table.insert(tech.effects, position, {type = "unlock-recipe", recipe = recipeName})
    else
        table.insert(tech.effects, {type = "unlock-recipe", recipe = recipeName})
    end
end

-- Removes a prerequisite from a technology.
exports.RemovePrerequisite = function(tech, prerequisite)
    for index, name in pairs(tech.prerequisites) do
        if name == prerequisite then
            table.remove(tech.prerequisites, index)
        end
    end
end

-- Replaces a prerequisite from a technology.
exports.ReplacePrerequisite = function(tech, prerequisite, newPrerequisite)
    for index, name in pairs(tech.prerequisites) do
        if name == prerequisite then
            tech.prerequisites[index] = newPrerequisite
        end
    end
end

--- OTHER ---

-- Replaces localised name.
exports.ChangeLocalisedName = function(prototype, newLocalisedName)
    prototype.localised_name = newLocalisedName -- table
end

-- Changes order.
exports.ChangeOrder = function(prototype, order)
    prototype.order = order -- table
end

-- Changes icon.
exports.ChangeIcon = function(prototype, icon, iconSize) -- last param optional
    if type(icon) == "string" then
        prototype.icons = nil
        prototype.icon = icon
        prototype.icon = iconSize
    elseif type(icon) == "table" then
        prototype.icon = nil -- icon_size can be ignored
        prototype.icons = icon
    end
end

---------------------------------------------------------------------------------------------------
return exports
