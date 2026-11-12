---------------------------------------------------------------------------------------------------
--  ┏┓┏┓┳┳┓┏┓┏┓┏┳┓┳┳┓┳┓ ┳┏┳┓┓┏
--  ┃ ┃┃┃┃┃┃┃┣┫ ┃ ┃┣┫┃┃ ┃ ┃ ┗┫
--  ┗┛┗┛┛ ┗┣┛┛┗ ┻ ┻┻┛┻┗┛┻ ┻ ┗┛
---------------------------------------------------------------------------------------------------
local MOD  = require "shared.mod"
if not MOD.bob_electronics then return end
local ID   = require "shared.names"
local FPL  = require "functions.prototypes-local"
local FPD  = require "functions.prototypes-database"
---------------------------------------------------------------------------------------------------
-- BOB'S + ANGEL'S MOD SUITES
---------------------------------------------------------------------------------------------------
-- This adaptation assumes the presence of the following:
--   Bob's Functions Library mod
--   Bob's Ores
--   Bob's Metals, Chemicals and intermediates (adds tinned copper wire to Bob' insulated cable)
--   Bob's Electronics                         (adds resin and rubber)
--   Angel's Refining
--   Angels' Petrochemical Processing          (NB: changes resin and rubber)

-- Additional adjustments will be made for:
--   Angel's Smelting
--   Angel's Bio Processing                    (NB: changes resin and rubber again)

-- If Bob's mods besides Electronics are missing, some things won't be quite right, but the mod
-- should still work.

---------------------------------------------------------------------------------------------------
    -- BOB'S ELECTRONICS + ANGEL'S PETROCHEMICAL PROCESSING (and more)
---------------------------------------------------------------------------------------------------

--- HIDE PROTOTYPES ---

FPD.HideItem(ID.item.resin)
FPD.HideItem(ID.item.rubber)
FPD.HideRecipe(ID.recipe.resin)
FPD.HideRecipe(ID.recipe.synthetic_rubber)
FPD.HideTech(ID.tech.synthetic_rubber)

--- CHANGE NAMING ---

-- Updates names of items, recipes and tech to use the word "wire" instead of "cable".
FPD.ChangeLocalisedName("item", ID.item.insulated_cable, {
    "item-name.uplz-insulated-copper-wire"
})
FPD.ChangeLocalisedName("recipe", ID.recipe.rubber_cable, {
    "recipe-name.uplz-rubber-insulated-copper-wire"
})
FPD.ChangeLocalisedName("recipe", ID.recipe.elastomer_cable, {
    "recipe-name.uplz-elastomer-insulated-copper-wire"
})
FPD.ChangeLocalisedName("recipe", ID.recipe.plastic_cable, {
    "recipe-name.uplz-plastic-insulated-copper-wire"
})
FPD.ChangeLocalisedName("technology", ID.tech.insulated_cable, {
    "technology-name.uplz-insulated-copper-wire"
})

--- CHANGE ORDERING ---

-- Reorders items and recipes.
do
    local cable_item = data.raw.item[ID.item.insulated_cable]
    if cable_item ~= nil then
        cable_item.subgroup = "bob-electronic-components"
        cable_item.order = "0-a1[b-insulated-cable]"
    end
    local e_cable_recipe = data.raw.recipe[ID.recipe.elastomer_cable]
    if e_cable_recipe ~= nil then
        e_cable_recipe.subgroup = "bob-electronic-components"
        e_cable_recipe.order = "0-a1[b-insulated-cable-1]"
    end
    local r_cable_recipe = data.raw.recipe[ID.recipe.rubber_cable]
    if r_cable_recipe ~= nil then
        r_cable_recipe.subgroup = "bob-electronic-components"
        r_cable_recipe.order = "0-a1[b-insulated-cable-2]"
    end
    local p_cable_recipe = data.raw.recipe[ID.recipe.plastic_cable]
    if p_cable_recipe ~= nil then
        p_cable_recipe.subgroup = "bob-electronic-components"
        p_cable_recipe.order = "0-a1[b-insulated-cable-3]"
    end
end

--- ITEMS ---

local elastomer_item = data.raw.item[ID.item.wood_elastomer]
if elastomer_item ~= nil then
    elastomer_item.order = "a[petrochem-solids]-b[resinated-wood-elastomer]"
end

--- RECIPES ---

if MOD.angels_petrochem then

    -- Elastomer: Fixes ordering, crafting category and ingredient used.
    local elastomer_recipe = data.raw.recipe[ID.recipe.wood_elastomer]
    if elastomer_recipe ~= nil then
        elastomer_recipe.group = "angels-petrochem-refining"
        elastomer_recipe.subgroup = "bob-resource"
        elastomer_recipe.order = "c[resinated-wood-elastomer]"
        elastomer_recipe.categories = { "angels-liquifying" }
        FPL.ReplaceIngredientName(elastomer_recipe, ID.item.resin, "bob-resin")
    end
else
    local elastomer_recipe = data.raw.recipe[ID.recipe.wood_elastomer]
    if elastomer_recipe ~= nil then
        elastomer_recipe.subgroup = "bob-resource"
        elastomer_recipe.order = "c[resinated-wood-elastomer]"
        FPL.ReplaceIngredientName(elastomer_recipe, ID.item.resin, "bob-resin")
    end
end

-- Insulated copper cable: Replaces rubber ingredient with Bob's rubber.
local r_insulated_cable = data.raw.recipe[ID.recipe.rubber_cable]
if r_insulated_cable ~= nil then
    FPL.ChangeIcon(r_insulated_cable, {
        { icon = "__"..MOD.name.."__/graphics/icons/insulated-cable.png",
            icon_size = 64, scale = 0.500, shift = { 0, 0} },
        { icon = "__bobelectronics__/graphics/icons/rubber.png",
            icon_size = 32, scale = 0.500, shift = {-8,-8} }
    })
    FPL.ReplaceIngredientName(r_insulated_cable, ID.item.rubber, "bob-rubber")
end

--- TECH ---

FPD.AddRecipeUnlock(ID.tech.wood_elastomer, "bob-resin-wood")

if MOD.angels_petrochem then

    -- Rubber-insulated copper cable recipe also unlocks with Angel's rubber tech.
    FPD.AddRecipeUnlock("angels-rubbers", ID.recipe.rubber_cable)

    -- Makes elastomer tech require basic chemistry that provides the liquefier.
    FPD.AddPrerequisite(ID.tech.wood_elastomer, "angels-basic-chemistry")

end

---------------------------------------------------------------------------------------------------
    -- ANGEL'S BIO PROCESSING
---------------------------------------------------------------------------------------------------
-- Even the early alternative to resin gets delayed and nerfed. An extra recipe will be created
-- to make up for the delay.

if MOD.angels_bioproc then

    -- Early resin recipe for the liquefier.
    local resin = util.table.deepcopy(data.raw.recipe["angels-bio-resin-wood-reprocessing"])
    if resin ~= nil then
        resin.name = MOD.prefix.."angels-bio-processing-early-resin"
        resin.categories = { "angels-liquifying" }
        resin.group = "angels-bio-processing-nauvis"
        resin.subgroup = "angels-bio-processing-wood-2"
        resin.order = "a1[wood-resin]"
        resin.energy_required = 5
        data:extend({resin})
        FPD.AddRecipeUnlock(ID.tech.wood_elastomer, resin.name)
    end

    -- ITEM SUBGROUP: Angels bio processing wood 2.
    data:extend({{
        type = "item-subgroup",
        name = "angels-bio-processing-wood-2",
        group = "angels-bio-processing-nauvis",
        order = "ea"
    }})

    -- Fixes ordering for elastomer recipe.
    local elastomer = data.raw.recipe[ID.recipe.wood_elastomer]
    if elastomer ~= nil then
        elastomer.group = "angels-bio-processing-nauvis"
        elastomer.subgroup = "angels-bio-processing-wood-2"
        elastomer.order = "a2[wood-elastomer]"
    end
else
    -- Unlocks rubber-insulated copper cable with wood-processing.
    FPD.AddRecipeUnlock("bob-wood-processing", ID.recipe.rubber_cable)

end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
