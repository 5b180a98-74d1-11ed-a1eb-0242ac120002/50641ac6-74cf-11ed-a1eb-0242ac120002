process.armor_locker.net_name = "process.armor_locker"

process.armor_locker.var_class = "process.armor_locker.class"
process.armor_locker.var_weapon_class_index = "process.armor_locker.weapon_class_index"

// weapons and class structur
local rifle_price = 700
local sniper_price = 1000
local semi_auto_sniper_price = 600
local smg_price = 650
local grenade_price = 350

local it_armor_price = 1000
local garde_armor_price = 800

local equipements = {
    {name = "tfa_csgo_smoke", price = grenade_price}, {name = "tfa_csgo_flash", price = grenade_price}, {name= "stungun", price = 0},
    {name= "dsr_metal_detector", price = 0}, {name= "dsr_megaphone", price = 0}, {name= "weapon_r_restrains", price = 0}, {name= "pepper_spray", price = 0}
}
local melee_weapons = {{name="tfa_mw2019_knife", price = 0}, {name="tfa_mw2019_baton", price = 0}}

local secondary_weapons = {
    {name = "mg_357", price = 0}, {name = "mg_m9", price = 0}, {name = "mg_p320", price = 0}
}

local garde_primary_weapons = {
    {name = "mg_mpapa7", price = 0}, {name = "mg_mpapa5", price = smg_price}, {name = "mg_papa90", price = smg_price},
}

local it_primary_weapons = {
    {name = "mg_mcharlie", price = 0}, {name = "mg_falpha", price = rifle_price}, {name = "mg_mike4", price = rifle_price}, {name = "mg_romeo870", price = rifle_price}, 
}

local fim_primary_weapons = process.add_tables({{name = "mg_scharlie", price = 0}, {name = "mg_tango21", price = 0}, {name = "mg_romeo700", price = 0}, }, it_primary_weapons, garde_primary_weapons)
for _, weapon in pairs(fim_primary_weapons) do
    weapon.price = 0
end

local intrus_primary_weapons = {
    {name = "mg_galima", price = 0}, {name = "mg_falpha", price = rifle_price},
    {name = "mg_sksierra", price = sniper_price}, {name = "mg_beta", price = smg_price},
}

local robot_primiary_weapons = {
    {name = "mg_tango21", price = 0}, {name = "mg_mike14", price = sniper_price}, {name = "mg_romeo870", price = rifle_price}, {name = "mg_mpapa5", price = rifle_price},
}

local mastogdi_primary_weapons = process.add_tables({{name = "mg_aalpha12", price = 0}}, intrus_primary_weapons)

hook.Add("Initialize", "Process.armor_locker.intitalize", function ()
    process.armor_locker.weapons = {
        {
            jobs = {TEAM_CADETSECU, TEAM_OFC, TEAM_OFCSGT, TEAM_OFCLTN, TEAM_CPT, TEAM_SENTINELLE, TEAM_GE},
            name = "garde",
            image = "armor_locker/garde.png",
            {
                weapons = garde_primary_weapons,
                limit = 1,
                name = "arme primaire"
            },
            {
                weapons = secondary_weapons,
                limit = 1,
                name = "arme secondaire"
            },
            {
                weapons = melee_weapons,
                limit = 1,
                name = "corps à corps"
            },
            {
                weapons = equipements,
                limit = 2,
                name = "équipement"
            }
        },
        {
            jobs = {TEAM_UIAA, TEAM_UIAAL},
            name = "Unitée robotique",
            image = "armor_locker/garde.png",
            {
                weapons = robot_primiary_weapons,
                limit = 1,
                name = "arme primaire"
            },
            {
                weapons = secondary_weapons,
                limit = 1,
                name = "arme secondaire"
            },
            {
                weapons = melee_weapons,
                limit = 1,
                name = "corps à corps"
            },
            {
                weapons = equipements,
                limit = 2,
                name = "équipement"
            }
        },
        {
            jobs = {TEAM_RCTIT, TEAM_AIT, TEAM_CPLIT, TEAM_SGTIT, TEAM_LTNIT, TEAM_CMDIT},
            name = "a.i.t.",
            image = "armor_locker/it.png",
            {
                weapons = it_primary_weapons,
                limit = 1,
                name = "arme primaire"
            },
            {
                weapons = secondary_weapons,
                limit = 1,
                name = "arme secondaire"
            },
            {
                weapons = melee_weapons,
                limit = 1,
                name = "corps à corps"
            },
            {
                weapons = equipements,
                limit = 3,
                name = "équipement"
            },
        },
        {
            jobs = {TEAM_SOLDATFIM, TEAM_LTNFIM, TEAM_CMDFIM},
            name = "F.I.M.",
            image = "armor_locker/it.png",
            {
                weapons = fim_primary_weapons,
                limit = 1,
                name = "arme primaire"
            },
            {
                weapons = secondary_weapons,
                limit = 1,
                name = "arme secondaire"
            },
            {
                weapons = melee_weapons,
                limit = 1,
                name = "corps à corps"
            },
            {
                weapons = equipements,
                limit = 3,
                name = "équipement"
            },
        },
        {
            jobs = {TEAM_AE},
            name = "a.e.",
            image = "armor_locker/garde.png",
            {
                weapons = {
                    {name = "mg_romeo870", price = 0}
                },
                limit = 1,
                name = "arme primaire"
            },
            {
                weapons = secondary_weapons,
                limit = 1,
                name = "arme secondaire"
            },
            {
                weapons = melee_weapons,
                limit = 1,
                name = "corps à corps"
            },
            {
                weapons = equipements,
                limit = 3,
                name = "équipement"
            }
        },
        {
            jobs = {TEAM_CHEFTINTERET, TEAM_BRASDROIT, TEAM_SERGENT, TEAM_SOLDAT},
            name = "Intrus",
            image = "armor_locker/civil.png",
            {
                weapons = intrus_primary_weapons,
                limit = 1,
                name = "arme primaire"
            },
            {
                weapons = secondary_weapons,
                limit = 1,
                name = "arme secondaire"
            },
            {
                weapons = melee_weapons,
                limit = 1,
                name = "corps à corps"
            },
            {
                weapons = equipements,
                limit = 3,
                name = "équipement"
            }
        },
        {
            jobs = {TEAM_MASTOGDI},
            name = "Intrus",
            image = "armor_locker/civil.png",
            {
                weapons = mastogdi_primary_weapons,
                limit = 1,
                name = "arme primaire"
            },
            {
                weapons = secondary_weapons,
                limit = 1,
                name = "arme secondaire"
            },
            {
                weapons = melee_weapons,
                limit = 1,
                name = "corps à corps"
            },
            {
                weapons = equipements,
                limit = 3,
                name = "équipement"
            }
        },
        {
            jobs = {TEAM_MASTOFIM},
            name = "FIM",
            image = "armor_locker/it.png",
            {
                weapons = mastogdi_primary_weapons,
                limit = 1,
                name = "arme primaire"
            },
            {
                weapons = secondary_weapons,
                limit = 1,
                name = "arme secondaire"
            },
            {
                weapons = melee_weapons,
                limit = 1,
                name = "corps à corps"
            },
            {
                weapons = equipements,
                limit = 3,
                name = "équipement"
            }
        },
        {
            jobs = {TEAM_D, TEAM_CONTR, TEAM_CONTRAVANCE},
            name = "class d",
            image = "armor_locker/civil.png",
            {
                weapons = garde_primary_weapons,
                limit = 1,
                name = "arme primaire"
            },
            {
                weapons = secondary_weapons,
                limit = 1,
                name = "arme secondaire"
            },
            {
                weapons = melee_weapons,
                limit = 1,
                name = "corps à corps"
            },
            {
                weapons = equipements,
                limit = 1,
                name = "équipement"
            }
        }
    }    
end)

process.load_script("entities/armor_locker/locker/sv_armor_locker.lua", true)
process.load_script("entities/armor_locker/locker/cl_armor_locker.lua", true)