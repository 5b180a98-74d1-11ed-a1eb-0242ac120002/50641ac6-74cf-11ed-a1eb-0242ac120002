process.armor_locker.net_name_uits = "process.uits_armor_locker"

process.armor_locker.uits_classes = {
    {
        name = "Paramédic",
        weapons = {"mg_smgolf45", "dsr_medkit"},
        bodygroups = {{id = 11, values = {1}}, {id = 15, values = {0, 1, 2}}},
        force = 1,
    },
    {
        name = "EXPLOSIF",
        weapons = {"mg_mcharlie", "tfa_csgo_incen", "tfa_csgo_frag"},
        bodygroups = {{id = 11, values = {0}}, {id = 15, values = {0, 1}}},
        force = 1,
    },
    {
        name = "talos",
        weapons = {"mg_tango21", "mg_p320"},
        force = 1.5,
        model = "models/player/tfa_kz_helghast_assault.mdl",
    },
    {
        name = "MASTODONTE",
        weapons = {"mg_aalpha12", "mg_p320"},
        force = 0.8,
        model = "models/ghosts_federation/Ghosts_FedJuggernaut_OD_player.mdl",
        skin = 0,
    },
    {
        name = "bouclier",
        weapons = {"mg_mpapa7", "deployable_shield"},
        bodygroups = {{id = 11, values = {1}}, {id = 15, values = {0, 1}}},
        force = 1,
    },
    {
        name = "TIREUR d'élite",
        weapons = {"mg_romeo700", "mg_crossbow"},
        bodygroups = {{id = 11, values = {4}}, {id = 15, values = {0, 1}}},
        force = 1,
    },
    {
        name = "LANCE-FLAMMES",
        weapons = {"weapon_752_m2_flamethrower", "tfa_csgo_incen"},
        bodygroups = {{id = 11, values = {3}}, {id = 15, values = {0, 1}}},
        force = 1,
    },
    {
        name = "ingénieur",
        weapons = {"mg_romeo870", "weapon_bm_sg_deployer_180"},
        bodygroups = {{id = 11, values = {2}}, {id = 15, values = {0, 1}}},
        force = 1,
    },
}

process.load_script("entities/armor_locker/uits_locker/sv_armor_locker_uits.lua", true)
process.load_script("entities/armor_locker/uits_locker/cl_armor_locker_uits.lua", true)