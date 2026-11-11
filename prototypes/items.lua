---------------------------------------------------------------------------------------------------
--  ┳┏┳┓┏┓┳┳┓┏┓
--  ┃ ┃ ┣ ┃┃┃┗┓
--  ┻ ┻ ┗┛┛ ┗┗┛
---------------------------------------------------------------------------------------------------
local MOD = require "shared.mod"
local ID  = require "shared.names"
local item_sounds = require "__base__.prototypes.item_sounds"
local prototypes = {}
---------------------------------------------------------------------------------------------------
-- RESIN
---------------------------------------------------------------------------------------------------
-- Extracted from wood, needed for the production of resinated wood elastomer.
table.insert(prototypes, {
	type = "item",
	name = ID.item.resin,
	icon = "__"..MOD.name.."__/graphics/icons/resin.png",
	subgroup = "raw-material",
	order = "a[elastomer-production]-a[resin]",
	pictures = {
		{filename = "__"..MOD.name.."__/graphics/icons/resin.png",
		 size = 64, scale = 0.5},
		{filename = "__"..MOD.name.."__/graphics/icons/resin-1.png",
		 size = 64, scale = 0.5},
		{filename = "__"..MOD.name.."__/graphics/icons/resin-2.png",
		 size = 64, scale = 0.5},
	},
	inventory_move_sound = item_sounds.solid_fuel_inventory_move,
	pick_sound = item_sounds.solid_fuel_inventory_pickup,
	drop_sound = item_sounds.solid_fuel_inventory_move,
    stack_size = 100,
	weight = 1 * kg,
	auto_recycle = false
})

---------------------------------------------------------------------------------------------------
-- RESINATED WOOD ELASTOMER
---------------------------------------------------------------------------------------------------
-- An insulating material. Produced from wood, resin and steam, needed for insulated copper cables.
table.insert(prototypes, {
    type = "item",
    name = ID.item.wood_elastomer,
    icon = "__"..MOD.name.."__/graphics/icons/wood-elastomer.png",
    subgroup = "raw-material",
    order = "a[elastomer-production]-c[resinated-wood-elastomer]",
    inventory_move_sound = item_sounds.plastic_inventory_move,
    pick_sound = item_sounds.plastic_inventory_pickup,
    drop_sound = item_sounds.plastic_inventory_move,
    stack_size = 100,
    weight = 0.5 * kg,
    auto_recycle = false
})

---------------------------------------------------------------------------------------------------
-- RUBBER
---------------------------------------------------------------------------------------------------
-- An insulating material. Produced synthetically from oil, needed for insulated copper cables.
table.insert(prototypes, {
    type = "item",
    name = ID.item.rubber,
    icon = "__"..MOD.name.."__/graphics/icons/material-rubber-sheet-2.png",
    pictures = {
		{filename = "__"..MOD.name.."__/graphics/icons/material-rubber-sheet-1.png",
		 size = 64, scale = 0.5},
		{filename = "__"..MOD.name.."__/graphics/icons/material-rubber-sheet-2.png",
		 size = 64, scale = 0.5},
		{filename = "__"..MOD.name.."__/graphics/icons/material-rubber-sheet-3.png",
		 size = 64, scale = 0.5},
	},
    subgroup = "raw-material",
    order = "a[rubber-production]-b[rubber]",
    inventory_move_sound = item_sounds.plastic_inventory_move,
    pick_sound = item_sounds.plastic_inventory_pickup,
    drop_sound = item_sounds.plastic_inventory_move,
    stack_size = 100,
    weight = 2 * kg,
    auto_recycle = false
})

---------------------------------------------------------------------------------------------------
-- INSULATED COPPER CABLE
---------------------------------------------------------------------------------------------------
-- Insulated cobber cable.
table.insert(prototypes, {
    type = "item",
    name = ID.item.insulated_cable,
    icon = "__"..MOD.name.."__/graphics/icons/insulated-cable.png",
    subgroup = data.raw.item["copper-cable"].subgroup,
    order = "a[basic-intermediates]-c[insulated-copper-cable]",
    inventory_move_sound = item_sounds.wire_inventory_move,
    pick_sound = item_sounds.wire_inventory_pickup,
    drop_sound = item_sounds.wire_inventory_move,
    stack_size = 100,
    weight = 0.5 * kg
})

---------------------------------------------------------------------------------------------------
-- UNDERGROUND ELECTRIC OUTLETS + SUBSTATION
---------------------------------------------------------------------------------------------------
-- Generates underground electric "poles" on the basis of their vanilla counterparts.

local function createUndergroundOutletItem(poleName)
    local item = util.table.deepcopy(data.raw.item[poleName])
    item.name = ID.underground[poleName]
    item.icon = "__"..MOD.name.."__/graphics/icons/"..ID.asset_dict[poleName]..".png"
    item["icon_mipmaps"] = 1
    item["place_result"] = ID.underground[poleName]

    return item
end

for _, pole_name in pairs({
    "small-electric-pole", "medium-electric-pole", "big-electric-pole", "substation"
}) do
    table.insert(prototypes, createUndergroundOutletItem(pole_name))
end

---------------------------------------------------------------------------------------------------
-- FINAL WRITE TO DATABASE
---------------------------------------------------------------------------------------------------
if next(prototypes) ~= nil then
    data:extend(prototypes)
end

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
