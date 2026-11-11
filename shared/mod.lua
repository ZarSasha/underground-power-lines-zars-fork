---------------------------------------------------------------------------------------------------
--  ┏┓┓┏┏┓┳┓┏┓┳┓
--  ┗┓┣┫┣┫┣┫┣ ┃┃
--  ┗┛┛┗┛┗┛┗┗┛┻┛
---------------------------------------------------------------------------------------------------
-- For use within the settings and prototype stages.
---------------------------------------------------------------------------------------------------
-- MOD
---------------------------------------------------------------------------------------------------
local mod = {

    -- Mod name and prefix used for names.
    name = "underground-power-lines-zars-fork",
    prefix = "uplz-",

    -- Checks for presence of other mods:
    -- Bob's mod suite:
    bob_electronics  = mods["bobelectronics"     ] and true or false,
    bob_plates       = mods["bobplates"          ] and true or false,
    -- Angel's mod suite:
    angels_bioproc   = mods["angelsbioprocessing"] and true or false,
    angels_smelting  = mods["angelssmelting"     ] and true or false,
    angels_petrochem = mods["angelspetrochem"    ] and true or false,
    angels_refining  = mods["angelsrefining"     ] and true or false,
    -- Rubber [∆]:
    delta_rubber     = mods["delta-rubber"       ] and true or false,
    -- Krastorio 2:
    krastorio2       = mods["Krastorio2"         ] and true or false,
    -- Nullius:
    nullius          = mods["nullius"            ] and true or false,
    -- Pyanodon's mod suite:
    py_coal_proc     = mods["pycoalprocessing"   ] and true or false,
    py_petroleum     = mods["pypetroleumhandling"] and true or false,
    -- Wooden Industry:
    wood_industry    = mods["wood-industry"      ] and true or false
}

return mod
---------------------------------------------------------------------------------------------------
