---------------------------------------------------------------------------------------------------
--  ┳┓┏┓┏┓┳┏┓┏┓┏┓
--  ┣┫┣ ┃ ┃┃┃┣ ┗┓
--  ┛┗┗┛┗┛┻┣┛┗┛┗┛
---------------------------------------------------------------------------------------------------
local MOD = require "shared.mod"
local ID  = require "shared.names"
local prototypes = {}
---------------------------------------------------------------------------------------------------
-- ASSEMBLER: RESIN
---------------------------------------------------------------------------------------------------
-- Resin extracted from wood, needed for rubber production.
table.insert(prototypes, {
    type = "recipe",
    name = ID.recipe.resin,
    categories = { "crafting" },
    enabled = false,
    energy_required = 2.5,
    ingredients = {
        { type = "item", name = "wood",        amount = 5 },
    },
    results = {
        { type = "item", name = ID.item.resin, amount = 1 }
    },
    allow_productivity = true,
    auto_recycle = false
})

---------------------------------------------------------------------------------------------------
-- ASSEMBLER (FLUID INPUT): RESINATED WOOD ELASTOMER
---------------------------------------------------------------------------------------------------
-- Resinated wood elastomer production. Loosely reflects real-world processes. We'll pretend that
-- the wood gets, let's see, mulched into a pulp, de-lignified with high-pressure steam (and a weak
-- base), impregnated with resin and then treated with low heat (<100℃) to produce a flexible,
-- moisture-resistant and electrically insulating material.(*)
table.insert(prototypes, {
    type = "recipe",
    name = ID.recipe.wood_elastomer,
    categories = { "crafting-with-fluid", "chemistry" },
    enabled = false,
    energy_required = 2.5,
    ingredients = {
        { type = "item",  name = "wood",                amount =  5 },
        { type = "item",  name = ID.item.resin,         amount =  1 },
        { type = "fluid", name = "steam",               amount = 25,
          maximum_temperature = 250 } -- elevated for the sake of some mods
    },
    results = {
        { type = "item", name = ID.item.wood_elastomer, amount =  5 }
    },
    allow_productivity = true,
    auto_recycle = false
})

-- (*): The recipe may be too condensed, but a higher degree of complexity also does not seem
-- appropriate for this mod.

---------------------------------------------------------------------------------------------------
-- CHEMICAL PLANT: SYNTHETIC RUBBER
---------------------------------------------------------------------------------------------------
-- Synthetic rubber made from oil. Its ingredients include stone to represent mineral additives.(*)
table.insert(prototypes, {
    type = "recipe",
    name = ID.recipe.synthetic_rubber,
    icons = {
        { icon = "__"..MOD.name.."__/graphics/icons/material-rubber-sheet-2.png",
          icon_size = 64, scale = 0.500, shift = { 0, 0} },
        { icon = "__base__/graphics/icons/fluid/petroleum-gas.png",
          icon_size = 64, scale = 0.250, shift = {-8,-8} }
    },
    categories = { "chemistry" },
    subgroup = "raw-material",
    order = "a[rubber-production]-b[synthetic-rubber]",
    enabled = false,
    energy_required = 5,
    ingredients = {
        { type = "item",  name = "stone",         amount =   1 },
        { type = "fluid", name = "petroleum-gas", amount = 100 }
    },
    results = {
        { type = "item",  name = ID.item.rubber,  amount =  10 }
    },
    crafting_machine_tint = {
        primary = { r = 10, g = 0, b = 30, a = 255 }
    },
    allow_productivity = true,
    auto_recycle = false
})

-- (*) Not sulfur to represent vulcanization though, because it makes rubber pointless compared to
-- plastic. Other mods (such as Bob's/Angel's) don't do this either anyway.

---------------------------------------------------------------------------------------------------
-- ASSEMBLER: INSULATED COPPER CABLE (MADE WITH WOOD ELASTOMER)
---------------------------------------------------------------------------------------------------
-- Insulated copper cable made with resinated wood elastomer.
table.insert(prototypes, {
    type = "recipe",
    name = ID.recipe.elastomer_cable,
    icons = {
        { icon = "__"..MOD.name.."__/graphics/icons/insulated-cable.png",
          icon_size = 64, scale = 0.500, shift = { 0, 0} },
        { icon = "__"..MOD.name.."__/graphics/icons/wood-elastomer.png",
          icon_size = 64, scale = 0.250, shift = {-8,-8} }
    },
    categories = { "crafting" },
    order = "a[basic-intermediates]-c[insulated-copper-cable-1]",
    enabled = false,
    energy_required = 0.5,
    ingredients = {
        { type = "item", name = "copper-cable",          amount = 2 },
        { type = "item", name = ID.item.wood_elastomer,  amount = 1 }
    },
    results = {
        { type = "item", name = ID.item.insulated_cable, amount = 2 }
    },
    allow_productivity = true,
    auto_recycle = true,
})

---------------------------------------------------------------------------------------------------
-- INSULATED COPPER CABLE (MADE WITH RUBBER)
---------------------------------------------------------------------------------------------------
-- Insulated copper cable, made with rubber. The main benefit compared to plastic is that it
-- requires a different material (stone instead of coal). It also costs less to research, and it
-- gives more options in relation to other mods.
table.insert(prototypes, {
    type = "recipe",
    name = ID.recipe.rubber_cable,
    icons = {
        { icon = "__"..MOD.name.."__/graphics/icons/insulated-cable.png",
          icon_size = 64, scale = 0.500, shift = { 0, 0} },
        { icon = "__"..MOD.name.."__/graphics/icons/material-rubber-sheet-4.png",
          icon_size = 64, scale = 0.250, shift = {-8,-8} }
    },
    categories = { "crafting" },
    --subgroup = "",
    order = "a[basic-intermediates]-c[insulated-copper-cable-2]",
    enabled = false,
    energy_required = 0.5,
    ingredients = {
        { type = "item", name = "copper-cable",          amount = 2 },
        { type = "item", name = ID.item.rubber,          amount = 1 }
    },
    results = {
        { type = "item", name = ID.item.insulated_cable, amount = 2 }
    },
    allow_productivity = true,
    auto_recycle = true
})

---------------------------------------------------------------------------------------------------
-- INSULATED COPPER CABLE (MADE WITH PLASTIC)
---------------------------------------------------------------------------------------------------
-- Insulated copper cable, made with plastic (which is actually better than rubber for static
-- installations, realistically speaking).
table.insert(prototypes, {
    type = "recipe",
    name = ID.recipe.plastic_cable,
    icons = {
        { icon = "__"..MOD.name.."__/graphics/icons/insulated-cable.png",
          icon_size = 64, scale = 0.500, shift = { 0, 0} },
        { icon = "__base__/graphics/icons/plastic-bar.png",
          icon_size = 64, scale = 0.250, shift = {-8,-8} }
    },
    categories = { "crafting" },
    order = "a[basic-intermediates]-c[insulated-copper-cable-3]",
    enabled = false,
    energy_required = 0.5,
    ingredients = {
        { type = "item", name = "copper-cable",          amount = 2 },
        { type = "item", name = "plastic-bar",           amount = 1 }
    },
    results = {
        { type = "item", name = ID.item.insulated_cable, amount = 2 }
    },
    allow_productivity = true,
    auto_recycle = true
})


---------------------------------------------------------------------------------------------------
-- UNDERGROUND ELECTRIC OUTLETS + SUBSTATION
---------------------------------------------------------------------------------------------------

-- Generates a recipe for the underground outlets on the basis of the electric poles + substation.
local function createUndergroundOutletRecipe(PoleName, ResultAmount, Ingredients)
    return {
        type = "recipe",
        name = ID.underground[PoleName],
        categories = { "crafting" },
        enabled = false,
        energy_required = 0.5,
        ingredients = Ingredients,
        results = {
            { type = "item", name = ID.underground[PoleName], amount = ResultAmount }
        },
        sort_item_ingredients = false
    }
end

-- Selects result amount and ingredients (with specific ordering!) for each of the outlets.
table.insert(prototypes, createUndergroundOutletRecipe("small-electric-pole",  2, {
    { type = "item", name = "iron-plate",            amount =  1 },
    { type = "item", name = ID.item.insulated_cable, amount =  2 }
}))
table.insert(prototypes, createUndergroundOutletRecipe("medium-electric-pole", 1, {
    { type = "item", name = "steel-plate",           amount =  2 },
    { type = "item", name = "iron-plate",            amount =  2 },
    { type = "item", name = ID.item.insulated_cable, amount =  2 }
}))
table.insert(prototypes, createUndergroundOutletRecipe("big-electric-pole", 1, {
    { type = "item", name = "steel-plate",           amount =  5 },
    { type = "item", name = "iron-plate",            amount =  4 },
    { type = "item", name = ID.item.insulated_cable, amount =  4 }
}))
table.insert(prototypes, createUndergroundOutletRecipe("substation", 1, {
    { type = "item", name = "steel-plate",           amount = 10 },
    { type = "item", name = ID.item.insulated_cable, amount =  6 },
    { type = "item", name = "advanced-circuit",      amount =  5 }
}))

---------------------------------------------------------------------------------------------------
-- FINAL WRITE TO DATABASE
---------------------------------------------------------------------------------------------------
if next(prototypes) ~= nil then
    data:extend(prototypes)
end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
