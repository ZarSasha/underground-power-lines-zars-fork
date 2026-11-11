---------------------------------------------------------------------------------------------------
--  ┏┳┓┏┓┏┓┓┏┳┓┏┓┓ ┏┓┏┓┓┏
--   ┃ ┣ ┃ ┣┫┃┃┃┃┃ ┃┃┃┓┗┫
--   ┻ ┗┛┗┛┛┗┛┗┗┛┗┛┗┛┗┛┗┛
---------------------------------------------------------------------------------------------------
local MOD  = require "shared.mod"
local ID   = require "shared.names"
local FUNC = require "functions"
local prototypes = {}
---------------------------------------------------------------------------------------------------
-- DUMMY TECHNOLOGY FOR INSULATED COPPER CABLE
---------------------------------------------------------------------------------------------------
-- Unlocks nothing of its own, but will be used as a prerequisite for outlet techs. Most useful
-- when insulated cable (or perhaps also rubber) has more than one recipe.

table.insert(prototypes, {
    type = "technology",
    name = ID.tech.insulated_cable,
    icon = "__"..MOD.name.."__/graphics/technology/insulated-cable.png",
    icon_size = 128,
    prerequisites = {
        "automation-science-pack"
    },
    research_trigger = {
        type = "craft-item", item = ID.item.insulated_cable
    }
})

---------------------------------------------------------------------------------------------------
-- TECHNOLOGY FOR RESINATED WOOD ELASTOMER PRODUCTION
---------------------------------------------------------------------------------------------------
-- Provides one way of producing an insulation material for the insulated copper cable.

table.insert(prototypes, {
    type = "technology",
    name = ID.tech.wood_elastomer,
    icon = "__"..MOD.name.."__/graphics/technology/wood-elastomer.png",
    icon_size = 128,
    prerequisites = {
        "automation-science-pack",
        "automation" -- for unlocking assembler mk1 modified for fluid input
    },
    effects = {
        { type = "unlock-recipe", recipe = ID.recipe.elastomer_cable  },
        { type = "unlock-recipe", recipe = ID.recipe.wood_elastomer   },
        { type = "unlock-recipe", recipe = ID.recipe.resin            }
    },
    unit = {
  		ingredients = {
  		    { "automation-science-pack", 1 }
  		},
        count = 10,
        time = 10
    }
})

---------------------------------------------------------------------------------------------------
-- TECHNOLOGY FOR SYNTHETIC RUBBER PRODUCTION
---------------------------------------------------------------------------------------------------
-- Provides another way of producing an insulation material for the insulated copper cable.
table.insert(prototypes, {
    type = "technology",
    name = ID.tech.synthetic_rubber,
    icon = "__"..MOD.name.."__/graphics/technology/synthetic-rubber.png",
    icon_size = 128,
    prerequisites = {
        "oil-processing" --, "sulfur-processing"
    },
    effects = {
        { type = "unlock-recipe", recipe = ID.recipe.rubber_cable     },
        { type = "unlock-recipe", recipe = ID.recipe.synthetic_rubber }
    },
    unit = {
  		ingredients = {
  		    { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
  		},
        count = 50,
        time = 30
    }
})

---------------------------------------------------------------------------------------------------
-- TECHNOLOGY FOR SMALL UNDERGROUND ELECTRIC OUTLET
---------------------------------------------------------------------------------------------------
table.insert(prototypes, {
    type = "technology",
    name = ID.tech.u_small_outlet,
    icon = "__"..MOD.name.."__/graphics/technology/small-electric-outlet.png",
    icon_size = 128,
    order = "uplz-1",
    prerequisites = {
        "automation-science-pack",
        ID.tech.insulated_cable
    },
    effects = {
        { type = "unlock-recipe", recipe = ID.recipe.u_small_outlet }
    },
    unit = {
  		ingredients = {
  		    { "automation-science-pack", 1 }
  		},
        count = 10,
        time = 10
    }
})

---------------------------------------------------------------------------------------------------
-- TECHNOLOGY FOR MEDIUM UNDERGROUND ELECTRIC OUTLET
---------------------------------------------------------------------------------------------------
table.insert(prototypes, {
    type = "technology",
    name = ID.tech.u_medium_outlet,
    icon = "__"..MOD.name.."__/graphics/technology/medium-electric-outlet.png",
    icon_size = 128,
    order = "uplz-2",
    prerequisites = {
        "electric-energy-distribution-1",
        ID.tech.insulated_cable
    },
    effects = {
      { type = "unlock-recipe", recipe = ID.recipe.u_medium_outlet }
    },
    unit = {
		ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack"   ,1 }
		},
        count = 15,
        time = 30
    }
})

---------------------------------------------------------------------------------------------------
-- TECHNOLOGY FOR BIG UNDERGROUND ELECTRIC OUTLET
---------------------------------------------------------------------------------------------------
table.insert(prototypes, {
    type = "technology",
    name = ID.tech.u_big_outlet,
    icon = "__"..MOD.name.."__/graphics/technology/big-electric-outlet.png",
    icon_size = 128,
    order = "uplz-3",
    prerequisites = {
        "electric-energy-distribution-1",
        ID.tech.insulated_cable
    },
    effects = {
      { type = "unlock-recipe", recipe = ID.recipe.u_big_outlet }
    },
    unit = {
		ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
		},
        count = 15,
        time = 30
    }
})

---------------------------------------------------------------------------------------------------
-- TECHNOLOGY FOR UNDERGROUND SUBSTATION
---------------------------------------------------------------------------------------------------
table.insert(prototypes, {
    type = "technology",
    name = ID.tech.u_substation,
    icon = "__"..MOD.name.."__/graphics/technology/substation.png",
    icon_size = 128,
    order = "uplz-4",
    prerequisites = {
        "electric-energy-distribution-2",
        ID.tech.insulated_cable
    },
    effects = {
      { type = "unlock-recipe", recipe = ID.recipe.u_substation }
    },
    unit = {
		ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
		},
        count = 25,
        time = 45
    }
})

---------------------------------------------------------------------------------------------------
-- FINAL WRITE TO DATABASE
---------------------------------------------------------------------------------------------------
if next(prototypes) ~= nil then
    data:extend(prototypes)
end

---------------------------------------------------------------------------------------------------
-- MODIFICATION OF PLASTIC TECH
---------------------------------------------------------------------------------------------------
-- Provides another way to produce insulated copper cable, with plastic.
FUNC.AddRecipeUnlock("plastics", ID.recipe.plastic_cable)

---------------------------------------------------------------------------------------------------
-- END NOTES
---------------------------------------------------------------------------------------------------
