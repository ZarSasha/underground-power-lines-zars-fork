---------------------------------------------------------------------------------------------------
--  ┏┓┏┓┳┳┓┏┓┏┓┏┳┓┳┳┓┳┓ ┳┏┳┓┓┏
--  ┃ ┃┃┃┃┃┃┃┣┫ ┃ ┃┣┫┃┃ ┃ ┃ ┗┫
--  ┗┛┗┛┛ ┗┣┛┛┗ ┻ ┻┻┛┻┗┛┻ ┻ ┗┛
---------------------------------------------------------------------------------------------------
local MOD  = require "shared.mod"
if not MOD.krastorio2 then return end
local ID   = require "shared.names"
---------------------------------------------------------------------------------------------------
-- KRASTORIO 2
---------------------------------------------------------------------------------------------------

--- RECIPES ---

-- Krastorio 2 changes the recipes for all the electric poles and the substation. This mod will
-- adapt the recipes for the underground outlets so they fit in.

-- Small underground outlet. (Also reduces result amount to 1.)
local small_outlet = data.raw.recipe[ID.recipe.u_small_outlet]
if small_outlet ~= nil then
    small_outlet.ingredients = {
        { type = "item", name = "iron-plate",            amount =  1 },
        { type = "item", name = ID.item.insulated_cable, amount =  1 }
    }
    small_outlet.results = {
        { type = "item", name = ID.item.u_small_outlet,  amount =  1 }
    }
end

-- Medium underground outlet.
local medium_outlet = data.raw.recipe[ID.recipe.u_medium_outlet]
if medium_outlet ~= nil then
    medium_outlet.ingredients = {
        { type = "item", name = "iron-plate",            amount =  2 },
        { type = "item", name = ID.item.insulated_cable, amount =  4 },
        { type = "item", name = "kr-iron-beam",          amount =  2 }
    }
end

-- Big underground outlet.
local big_outlet = data.raw.recipe[ID.recipe.u_big_outlet]
if big_outlet ~= nil then
    big_outlet.ingredients = {
        { type = "item", name = "iron-plate",            amount =  4 },
        { type = "item", name = ID.item.insulated_cable, amount =  8 },
        { type = "item", name = "kr-steel-beam",         amount =  4 }
    }
end

-- Underground substation.
local substation_outlet = data.raw.recipe[ID.recipe.u_substation]
if substation_outlet ~= nil then
    substation_outlet.ingredients = {
        { type = "item", name = ID.item.insulated_cable, amount = 16 },
        { type = "item", name = "advanced-circuit",      amount =  5 },
        { type = "item", name = "kr-steel-beam",         amount =  8 }
    }
end

--- SUPERIOR UNDERGROUND SUBSTATION ---

-- Krastorio 2 also adds a superior version of the substation. This mod will create an
-- underground version of that as well:

local prototypes = {}

--- ENTITIES ---
do
    local sub = util.table.deepcopy(data.raw["electric-pole"][ID.entity.u_substation])
    sub.name = ID.entity.u_kr_substation
    sub.minable.result = ID.item.u_kr_substation
    sub.icon =
        "__"..MOD.name.."__/graphics/entities/kr-superior-substation.png"
    sub.pictures.layers[1].filename =
        "__"..MOD.name.."__/graphics/entities/kr-superior-substation.png"
    sub.max_health = 250
    sub.maximum_wire_distance = 24.25
    sub.supply_area_distance = 12
    table.insert(prototypes, sub)
end

--- ITEMS ---
do
    local sub = util.table.deepcopy(data.raw.item[ID.item.u_substation])
    sub.name = ID.item.u_kr_substation
    sub.icon = "__"..MOD.name.."__/graphics/icons/kr-superior-substation.png"
    sub.order = "a[energy]-e[substation-mk2]"
    sub.place_result = ID.entity.u_kr_substation
    table.insert(prototypes, sub)
end

--- RECIPES ---
do
    local sub = util.table.deepcopy(data.raw.recipe[ID.recipe.u_substation])
    sub.name = ID.recipe.u_kr_substation
    sub.energy_required = 1
    sub.ingredients = {
        { type = "item", name = "kr-rare-metals",        amount = 6 },
        { type = "item", name = "processing-unit",       amount = 2 },
        { type = "item", name = "kr-imersium-beam",      amount = 3 },
        { type = "item", name = ID.item.u_substation,    amount = 1 },
        { type = "item", name = "small-lamp",            amount = 2 }
    }  -- Note: auto-sort disabled
    sub.results = {
        { type = "item", name = ID.item.u_kr_substation, amount = 1 }
    }

    table.insert(prototypes, sub)
end

--- TECHNOLOGY ---

-- TECHNOLOGY: Superior underground substation.
table.insert(prototypes, {
    type = "technology",
    name = ID.tech.u_kr_substation,
    icon = "__"..MOD.name.."__/graphics/technology/kr-superior-substation.png",
    icon_size = 128,
    order = "uplz-5",
    prerequisites = {
        "electric-energy-distribution-3",
        ID.tech.insulated_cable
    },
    effects = {
        { type = "unlock-recipe", recipe = ID.recipe.u_kr_substation },
    },
    unit = {
  		ingredients = {
  		    { "production-science-pack",  1 },
            { "utility-science-pack",     1 },
            { "kr-advanced-tech-card",    1 }
  		},
        count = 50, -- 300/4 = 75 seems too much after all
        time = 45
    }
})

--- FINAL DATA WRITE ---

if next(prototypes) ~= nil then
    data:extend(prototypes)
end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
