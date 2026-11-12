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
    -- COMMON CHANGES
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

--- CHANGE ORDERING AND FIX INGREDIENTS ---

-- Reorders items and recipes, replaces ingredients with their equivalents.
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
        FPL.ChangeIcon(r_cable_recipe, {
            { icon = "__"..MOD.name.."__/graphics/icons/insulated-cable.png",
                icon_size = 64, scale = 0.500, shift = { 0, 0} },
            { icon = "__bobelectronics__/graphics/icons/rubber.png",
                icon_size = 32, scale = 0.500, shift = {-8,-8} }
        })
        FPL.ReplaceIngredientName(r_cable_recipe, ID.item.rubber, "bob-rubber")
    end
    local p_cable_recipe = data.raw.recipe[ID.recipe.plastic_cable]
    if p_cable_recipe ~= nil then
        p_cable_recipe.subgroup = "bob-electronic-components"
        p_cable_recipe.order = "0-a1[b-insulated-cable-3]"
    end
    local elastomer_item = data.raw.item[ID.item.wood_elastomer]
    if elastomer_item ~= nil then
        elastomer_item.order = "a[petrochem-solids]-b[resinated-wood-elastomer]" -- review
        FPL.ReplaceIngredientName(elastomer_item, ID.item.resin, "bob-resin")
    end
end

---------------------------------------------------------------------------------------------------
    -- BOB'S MOD SUITE ONLY
---------------------------------------------------------------------------------------------------
-- Bob's Electronics by itself already provides an easy and efficient way of turning wood into
-- resin and then rubber, so elastomer production will just be disabled.

if not MOD.angels_petrochem then

    --- HIDE PROTOTYPES ---

    -- Hides recipes
    FPD.HideItem(ID.item.wood_elastomer)
    FPD.HideRecipe(ID.recipe.wood_elastomer)
    FPD.HideRecipe(ID.recipe.elastomer_cable)
    FPD.HideTech(ID.tech.wood_elastomer)

    --- TECH ---

    -- Unlocks rubber-insulated copper cable with wood-processing.
    FPD.AddRecipeUnlock("bob-wood-processing", ID.recipe.rubber_cable)

---------------------------------------------------------------------------------------------------
    -- BOB'S ELECTRONICS + ANGEL'S PETROCHEMICAL PROCESSING (and more)
---------------------------------------------------------------------------------------------------
-- When Angel's Petrochemical Processing is also present, rubber production becomes way harder, so
-- it makes sense to keep the wood elastomer and make adaptations for that.

elseif MOD.angels_petrochem and not MOD.angels_bioproc then

    --- RECIPES ---

    -- Wood elastomer:
    local elastomer_recipe = data.raw.recipe[ID.recipe.wood_elastomer]
    if elastomer_recipe ~= nil then
        elastomer_recipe.group = "angels-petrochem-refining"
        elastomer_recipe.subgroup = "bob-resource"
        elastomer_recipe.order = "c[resinated-wood-elastomer]"
        elastomer_recipe.categories = { "angels-liquifying" }
        elastomer_recipe.energy_required = 1
        elastomer_recipe.ingredients = {
            { type = "item",  name = "wood",                amount =  1 },
            { type = "item",  name = "bob-resin",           amount =  1 },
            { type = "fluid", name = "steam",               amount =  5,
              maximum_temperature = 250 }
        }
        elastomer_recipe.results = {
            { type = "item", name = ID.item.wood_elastomer, amount =  1 }
        }
    end

    --- TECH ---

    -- Makes elastomer tech require Angel's basic chemistry (for the liquefier) and Bob's wood
    -- processing (for the resin). Does increase research needed, but it also better fits in.
    FPD.AddPrerequisite(ID.tech.wood_elastomer, "angels-basic-chemistry")
    FPD.AddPrerequisite(ID.tech.wood_elastomer, "bob-wood-processing")

    -- Rubber-insulated copper cable recipe also unlocks with Angel's rubber tech.
    FPD.AddRecipeUnlock("angels-rubbers", ID.recipe.rubber_cable)

end

---------------------------------------------------------------------------------------------------
    -- ANGEL'S BIO PROCESSING
---------------------------------------------------------------------------------------------------
-- Even the early alternative to resin gets delayed and nerfed. An extra recipe will be created
-- to make up for the delay.

if MOD.angels_bioproc then

    --- RECIPES ---

    -- Early resin recipe for the liquefier.
    local resin_recipe = util.table.deepcopy(data.raw.recipe["angels-bio-resin-wood-reprocessing"])
    if resin_recipe ~= nil then
        resin_recipe.name = MOD.prefix.."angels-bio-processing-early-resin"
        resin_recipe.categories = { "angels-liquifying" }
        resin_recipe.group = "angels-bio-processing-nauvis"
        resin_recipe.subgroup = "angels-bio-processing-wood-2"
        resin_recipe.order = "a1[wood-resin]"
        resin_recipe.energy_required = 5
        data:extend({resin_recipe})
        FPD.AddRecipeUnlock(ID.tech.wood_elastomer, resin_recipe.name)
    end

    -- ITEM SUBGROUP: Angels bio processing wood 2.
    data:extend({{
        type = "item-subgroup",
        name = "angels-bio-processing-wood-2",
        group = "angels-bio-processing-nauvis",
        order = "ea"
    }})

    -- Fixes ordering for elastomer recipe.
    local elastomer_recipe = data.raw.recipe[ID.recipe.wood_elastomer]
    if elastomer_recipe ~= nil then
        elastomer_recipe.group = "angels-bio-processing-nauvis"
        elastomer_recipe.subgroup = "angels-bio-processing-wood-2"
        elastomer_recipe.order = "a2[wood-elastomer]"
    end

    -- Rubber-insulated copper cable recipe also unlocks with Angel's rubber tech.
    FPD.AddRecipeUnlock("angels-rubbers", ID.recipe.rubber_cable)

end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
