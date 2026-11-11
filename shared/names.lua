---------------------------------------------------------------------------------------------------
--  ┏┓┓┏┏┓┳┓┏┓┳┓
--  ┗┓┣┫┣┫┣┫┣ ┃┃
--  ┗┛┛┗┛┗┛┗┗┛┻┛
---------------------------------------------------------------------------------------------------
local MOD = require "shared.mod"
local prefix = MOD.prefix
---------------------------------------------------------------------------------------------------
-- DICTIONARY OF INTERNAL NAMES
---------------------------------------------------------------------------------------------------
-- Names to be used for the underground electric outlets added by this mod.

local names = {}

local entity = {
    u_small_outlet  = prefix.."underground-small-electric-outlet",
    u_medium_outlet = prefix.."underground-medium-electric-outlet",
    u_big_outlet    = prefix.."underground-big-electric-outlet",
    u_substation    = prefix.."underground-substation",
    u_kr_substation = prefix.."underground-kr-superior-substation" -- Krastorio 2
}

local item = {
    u_small_outlet  = entity.u_small_outlet,
    u_medium_outlet = entity.u_medium_outlet,
    u_big_outlet    = entity.u_big_outlet,
    u_substation    = entity.u_substation,
    u_kr_substation = entity.u_kr_substation, -- Krastorio 2
    insulated_cable = prefix.."insulated-copper-cable",
    rubber          = prefix.."rubber",
    wood_elastomer  = prefix.."resin-wood-elastomer",
    wood_chips      = prefix.."wood-chips",
    resin           = prefix.."resin"
}

local recipe = {
    u_small_outlet   = entity.u_small_outlet,
    u_medium_outlet  = entity.u_medium_outlet,
    u_big_outlet     = entity.u_big_outlet,
    u_substation     = entity.u_substation,
    u_kr_substation  = entity.u_kr_substation, -- Krastorio 2
    elastomer_cable  = prefix.."elastomer-insulated-copper-cable",
    rubber_cable     = prefix.."rubber-insulated-copper-cable",
    plastic_cable    = prefix.."plastic-insulated-copper-cable",
    synthetic_rubber = prefix.."synthetic-rubber",
    wood_elastomer   = item.wood_elastomer,
    resin            = item.resin
}

local tech = {
    u_small_outlet   = entity.u_small_outlet,
    u_medium_outlet  = entity.u_medium_outlet,
    u_big_outlet     = entity.u_big_outlet,
    u_substation     = entity.u_substation,
    u_kr_substation  = entity.u_kr_substation, -- Krastorio 2
    insulated_cable  = item.insulated_cable,
    synthetic_rubber = recipe.synthetic_rubber,
    wood_elastomer   = item.wood_elastomer
}

-- Table of names used to reference graphical assets.
local asset = {
    u_small_outlet  = "small-electric-outlet",
    u_medium_outlet = "medium-electric-outlet",
    u_big_outlet    = "big-electric-outlet",
    u_substation    = "substation",
    u_kr_substation = "kr-substation",
    insulated_cable = "insulated-cable",
    rubber          = "rubber",
    wood_elastomer  = "wood-elastomer",
    resin           = "resin"
}

-- Dictionary of asset names used for outlets, tied to the original poles.
local asset_dict = {
    ["small-electric-pole"]    = asset.u_small_outlet,
    ["medium-electric-pole"]   = asset.u_medium_outlet,
    ["big-electric-pole"]      = asset.u_big_outlet,
    ["substation"]             = asset.u_substation,
    ["kr-superior-substation"] = asset.u_kr_substation -- Krastorio 2
}

-- Dictionary of names of underground variants, tied to the original poles.
local underground = {
    ["small-electric-pole"]    = entity.u_small_outlet,
    ["medium-electric-pole"]   = entity.u_medium_outlet,
    ["big-electric-pole"]      = entity.u_big_outlet,
    ["substation"]             = entity.u_substation,
    ["kr-superior-substation"] = entity.u_kr_substation -- Krastorio 2
}

names.entity      = entity
names.item        = item
names.recipe      = recipe
names.tech        = tech
names.asset       = asset
names.asset_dict  = asset_dict
names.underground = underground

return names

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------

-- Note: If undefined, recipes inherit their names from items, and items from entities.
