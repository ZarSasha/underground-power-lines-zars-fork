---------------------------------------------------------------------------------------------------
--  ┏┓┳┳┳┓┏┓┏┳┓┳┏┓┳┓┏┓
--  ┣ ┃┃┃┃┃  ┃ ┃┃┃┃┃┗┓
--  ┻ ┗┛┛┗┗┛ ┻ ┻┗┛┛┗┗┛
---------------------------------------------------------------------------------------------------
local exports = {}
---------------------------------------------------------------------------------------------------
-- DATABASE MANIPULATION
---------------------------------------------------------------------------------------------------
-- The following function are useful for quickly making changes to prototypes within the database.

--- ITEMS ---

-- Hides item.
exports.HideItem = function(itemName)
   local item = data.raw.item[itemName]
   if item == nil then return end
   item.hidden = true
end

-- Reveals item.
exports.UnhideItem = function(itemName)
   local item = data.raw.item[itemName]
   if item == nil then return end
   item.hidden = false
end

--- RECIPES ---

-- Hides and disables recipe.
exports.HideRecipe = function(recipeName)
   local recipe = data.raw.recipe[recipeName]
   if recipe == nil then return end
   recipe.enabled = false
   recipe.hidden = true
end

-- Reveals recipe.
exports.UnhideRecipe = function(recipeName)
   local recipe = data.raw.recipe[recipeName]
   if recipe == nil then return end
   recipe.hidden = false
end

-- Enables recipe.
exports.EnableRecipe = function(recipeName)
   local recipe = data.raw.recipe[recipeName]
   if recipe == nil then return end
   recipe.enabled = true
end

-- Disables recipe.
exports.DisableRecipe = function(recipeName)
   local recipe = data.raw.recipe[recipeName]
   if recipe == nil then return end
   recipe.enabled = false
end

-- Only changes the name of a single ingredient in a recipe.
exports.ReplaceIngredientName = function(recipeName, IngredientName, newIngredientName)
    local recipe = data.raw.recipe[recipeName]
    if recipe == nil then return end
    for _, ingredient in pairs(recipe.ingredients) do
        if ingredient.name == IngredientName then
            ingredient.name = newIngredientName
        end
    end
end

-- Replaces only a single ingredient in a recipe. Filters by name, uses table.
exports.ReplaceIngredient = function(recipeName, IngredientName, newIngredient)
    local recipe = data.raw.recipe[recipeName]
    if recipe == nil then return end
    for _, ingredient in pairs(recipe.ingredients) do
        if ingredient.name == IngredientName then
            ingredient = newIngredient
        end
    end
end

-- Adds a single ingredient to a recipe, uses table.
exports.AddIngredient = function(recipeName, ingredient, position)
    local recipe = data.raw.recipe[recipeName]
    if recipe == nil then return end
    if position ~= nil then
        table.insert(recipe.ingredients, position, ingredient)
    else
        table.insert(recipe.ingredients, ingredient)
    end
end

-- Removes a single ingredient from a recipe, filters by name.
exports.RemoveIngredient = function(recipeName, ingredientName)
    local recipe = data.raw.recipe[recipeName]
    if recipe == nil then return end
    for index, ingredient in pairs(recipe.ingredients) do
        if ingredient.name == ingredientName then
            table.remove(recipe.ingredients, index)
        end
    end
end

-- Only changes the name of a single result in a recipe.
exports.ReplaceResultName = function(recipeName, resultName, newResultName)
    local recipe = data.raw.recipe[recipeName]
    if recipe == nil then return end
    for _, result in pairs(recipe.results) do
        if result.name == resultName then
            result.name = newResultName
        end
    end
end

-- Replaces the amount of a single result in a recipe.
exports.ReplaceResultAmount = function(recipeName, resultName, newResult)
    local recipe = data.raw.recipe[recipeName]
    if recipe == nil then return end
    for _, result in pairs(recipe.results) do
        if result.name == resultName then
            result = newResult
        end
    end
end

-- Replaces only a single result in a recipe. Filters by name, uses table.
exports.ReplaceResult = function(recipeName, resultName, newResult)
    local recipe = data.raw.recipe[recipeName]
    if recipe == nil then return end
    for _, result in pairs(recipe.results) do
        if result.name == resultName then
            result = newResult
        end
    end
end

-- Adds a single result to a recipe, uses table.
exports.AddResult = function(recipeName, result, position)
    local recipe = data.raw.recipe[recipeName]
    if recipe == nil then return end
    if position ~= nil then
        table.insert(recipe.results, position, result)
    else
        table.insert(recipe.results, result)
    end
end

-- Removes a single result from a recipe, filters by name.
exports.RemoveResult = function(recipeName, resultName)
    local recipe = data.raw.recipe[recipeName]
    if recipe == nil then return end
    local recipe = data.raw.recipe[recipeName]
    for index, result in pairs(recipe.results) do
        if result.name == resultName then
            table.remove(recipe.results, index)
        end
    end
end

--- TECHNOLOGY ---

-- Hides and disables technology (disabled: unavailable for research).
exports.HideTech = function(techName)
    local tech = data.raw.technology[techName]
    if tech == nil then return end
    tech.enabled = false
    tech.hidden = true
end

-- Reveals and enables technology (enabled: available for research).
exports.UnhideTech = function(techName)
    local tech = data.raw.technology[techName]
    if tech == nil then return end
    tech.enabled = true
    tech.hidden = false
end

-- Adds a recipe to be unlocked with a technology in the database. Avoids duplication.
exports.AddRecipeUnlock = function(techName, recipeName, position)
    local tech = data.raw.technology[techName]
    if tech == nil then return end
    for _, effect in pairs(tech.effects) do
        if effect.type == "unlock-recipe" and effect.recipe == recipeName then return end
    end
    if position ~= nil then
        table.insert(tech.effects, position, {type = "unlock-recipe", recipe = recipeName})
    else
        table.insert(tech.effects, {type = "unlock-recipe", recipe = recipeName})
    end
end

-- Adds a prerequisite to a technology. Avoids duplication.
exports.AddPrerequisite = function(techName, prerequisite)
    local tech = data.raw.technology[techName]
    if tech == nil then return end
    for _, name in pairs(tech.prerequisites) do
        if name == prerequisite then return end
    end
    table.insert(tech.prerequisites, prerequisite)
end

-- Removes a prerequisite from a technology.
exports.RemovePrerequisite = function(techName, prerequisite)
    local tech = data.raw.technology[techName]
    if tech == nil then return end
    for index, name in pairs(tech.prerequisites) do
        if name == prerequisite then
            table.remove(tech.prerequisites, index)
        end
    end
end

-- Replaces a prerequisite from a technology.
exports.ReplacePrerequisite = function(techName, prerequisite, newPrerequisite)
    local tech = data.raw.technology[techName]
    if tech == nil then return end
    for index, name in pairs(tech.prerequisites) do
        if name == prerequisite then
            tech.prerequisites[index] = newPrerequisite
        end
    end
end

--- OTHER ---

-- Changes icon.
exports.ChangeIcon = function(type, name, icon, iconSize) -- last param optional
    local prototype = data.raw[type][name]
    if prototype ~= nil then
        if type(icon) == "string" then
            prototype.icons = nil
            prototype.icon = icon
            prototype.icon = iconSize
        elseif type(icon) == "table" then
            prototype.icon = nil -- icon_size can be ignored
            prototype.icons = icon
        end
    end
end

-- Replaces localised name. Remember to declare type.
exports.ChangeLocalisedName = function(type, name, newLocalisation)
    local prototype = data.raw[type][name]
    if prototype ~= nil then
        prototype.localised_name = newLocalisation -- table
    end
end

-- Changes order. Remember to declare type.
exports.ChangeOrder = function(type, name, order)
    local prototype = data.raw[type][name]
    if prototype ~= nil then
        prototype.order = order -- table
    end
end
---------------------------------------------------------------------------------------------------
return exports
