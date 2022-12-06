--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------
This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.
Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
      Once you've done that, copy and paste the job to this file and edit it.
The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua
For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomJobFields
Add your custom jobs under the following line:
---------------------------------------------------------------------------]]
local function format_team_table(...)
    local table = {}
    for _, value in pairs({...}) do
        table[value] = true
    end

    return table
end

-- weapons
    -- keycard
    local lvl0 = "process_keycard_lvl_0"
    local lvl1 = "process_keycard_lvl_1"
    local lvl2 = "process_keycard_lvl_2"
    local lvl3 = "process_keycard_lvl_3"
    local lvl4 = "process_keycard_lvl_4"
    local lvl5 = "process_keycard_lvl_5"

    -- other
    local ia_swep = "ia_swep"
    local tablet_ads = "tablet_ads"
    local tablet_logi = "tablet_logi"
    local swep_baton = "weapon_baton"
    local restrains = "weapon_r_restrains"
    local sig_sauer = "mg_p320"
    local radio = "weapon_rdo_radio"
    local cyanure = "cyanide_syringe_swep"
    local tranquilizer = "tranquilizer_syringe_swep"
    local adrenaline = "rust_syringe"
    local aks74u = "arccw_firearms2_aks74u"
    local laptop = "cc_laptop_hands"
    local weapon_medkit = "dsr_medkit"

    -- SCP
    local swep_096 = "vkx_scp_096"         
    local swep_966 = "966_swep"          
    local swep_173 = "vkx_scp_173"         
    local swep_1983pro = "demogorgon_claws"
    local swep_079 = "079_activated_swep"  
    local swep_682 = "fv_scp682"   
    local swep_106 = "gu_scp_106"
    local swep_999 = "999_swep"
    local swep_457 = "457_swep"
    local swep_1048 = "1048_swep"
    local swep_939 = "939_swep"
    local swep_049 = "weapon_scp049"
    local swep_087 = "087_swep"

    table.Merge(GAMEMODE.Config.DisallowDrop, format_team_table(ia_swep, swep_096, swep_966, swep_173, swep_1983pro, swep_079, swep_682, swep_999, swep_1048, swep_527, swep_049, swep_087))
    
-- attachments 
    /*local function give_att(ply, ...) not use anymore
        if (CLIENT) then return end
        
        for _, att in pairs({...}) do
            ArcCW:PlayerGiveAtt(ply, att)
        end

        ArcCW:PlayerSendAttInv(ply)
    end if SERVER then process.give_att = give_att end*/
    
    -- model
    process = process or {}
    process.darkrp = process.darkrp or {}
    process.darkrp.models = {}
    local models = process.darkrp.models -- to set correct position offset for pins
    
    function process.add_tables(...)
        local output_table = {}
        for _, value in pairs({...}) do
            table.Add(output_table, value)
        end

        return output_table
    end
    local add_tables = process.add_tables
    -- civil
    local model_D = {
        "models/player/1000shells/class_d_white.mdl"
    } models.D = model_D
    -- intru
        local model_blacklist = {"models/blacklist/merc1.mdl"} models.blacklist = blacklist
        local model_spy = {"models/blacklist/spy1.mdl"} models.spy = model_spy
        local model_ghilliesuit = {"models/player/joheskiller/ghilliesuit_winter.mdl"} models.ghilliesuit = model_ghilliesuit
        local model_bm_intru = {"models/humans/pyri_pm/marine_pm.mdl"} models.bm_intru = model_bm_intru
        local model_kerry = {"models/player/kerry.mdl"} models.kerry = model_kerry

        local model_intru = add_tables(model_spy, model_ghilliesuit, blacklist, model_bm_intru, model_kerry)
        
    -- scientifique
    local model_sup_f = {"models/player/bobert/AOHarley.mdl"} models.superviseur_f = model_sup_f
    local model_sup_m = {
        "models/player/lenoax_gordon.mdl",
    } models.superviseur = model_sup_m

        local model_superviseur = add_tables(model_sup_f, model_sup_m) 
    
    local model_sdc = {"models/nada/male/MedicalHazmat.mdl"} models.sdc = model_sdc

    local model_chercheur = {
        "models/humans/pyri_pm/scientist_03_pm.mdl",
        "models/humans/pyri_pm/scientist_02_pm.mdl",
        "models/humans/pyri_pm/scientist_pm.mdl",
        "models/humans/pyri_pm/scientist_female_pm.mdl"
    } models.chercheur = model_chercheur

    -- logistique
    local model_medecin = {
        "models/player/kerry/medic/medic_01.mdl",
        "models/player/kerry/medic/medic_01_f.mdl",
        "models/player/kerry/medic/medic_02.mdl",
        "models/player/kerry/medic/medic_02_f.mdl",
        "models/player/kerry/medic/medic_03.mdl",
        "models/player/kerry/medic/medic_03_f.mdl",
        "models/player/kerry/medic/medic_04.mdl",
        "models/player/kerry/medic/medic_04_f.mdl",
        "models/player/kerry/medic/medic_05.mdl",
        "models/player/kerry/medic/medic_05_f.mdl",
        "models/player/kerry/medic/medic_06.mdl",
        "models/player/kerry/medic/medic_06_f.mdl",
        "models/player/kerry/medic/medic_07.mdl",
        "models/player/hostage/hostage_04.mdl"
    } models.medecin = model_medecin
    local model_concierge = {"models/humans/pyri_pm/custodian_pm.mdl"} models.concierge = model_concierge
    local model_logisticien = {"models/humans/pyri_pm/cwork_pm.mdl"} models.logisticien = model_logisticien
    local model_technicien = {"models/humans/pyri_pm/engineer_pm.mdl"} models.technicien = model_technicien
    local model_cook_f = {"models/humans/pyri_pm/cafeteria_female_pm.mdl"} models.cook = model_cook_f
    local model_gordonramsay = {"models/dannio/noahg/gordonramsay.mdl"} models.gordonramsay = model_gordonramsay
    
    -- ADMINISTRATION
    local model_costard = {
        "models/player/Suits/male_01_closed_coat_tie.mdl",
        "models/player/Suits/male_01_closed_tie.mdl",
        "models/player/Suits/male_01_open.mdl",
        "models/player/Suits/male_01_open_tie.mdl",
        "models/player/Suits/male_01_open_waistcoat.mdl",
        "models/player/Suits/male_01_shirt.mdl",
        "models/player/Suits/male_01_shirt_tie.mdl",

        "models/player/Suits/male_02_closed_coat_tie.mdl",
        "models/player/Suits/male_02_closed_tie.mdl",
        "models/player/Suits/male_02_open.mdl",
        "models/player/Suits/male_02_open_tie.mdl",
        "models/player/Suits/male_02_open_waistcoat.mdl",
        "models/player/Suits/male_02_shirt.mdl",
        "models/player/Suits/male_02_shirt_tie.mdl",

        "models/player/Suits/male_03_closed_coat_tie.mdl",
        "models/player/Suits/male_03_closed_tie.mdl",
        "models/player/Suits/male_03_open.mdl",
        "models/player/Suits/male_03_open_tie.mdl",
        "models/player/Suits/male_03_open_waistcoat.mdl",
        "models/player/Suits/male_03_shirt.mdl",
        "models/player/Suits/male_03_shirt_tie.mdl",

        "models/player/Suits/male_04_closed_coat_tie.mdl",
        "models/player/Suits/male_04_closed_tie.mdl",
        "models/player/Suits/male_04_open.mdl",
        "models/player/Suits/male_04_open_tie.mdl",
        "models/player/Suits/male_04_open_waistcoat.mdl",
        "models/player/Suits/male_04_shirt.mdl",
        "models/player/Suits/male_04_shirt_tie.mdl",

        "models/player/Suits/male_05_closed_coat_tie.mdl",
        "models/player/Suits/male_05_closed_tie.mdl",
        "models/player/Suits/male_05_open.mdl",
        "models/player/Suits/male_05_open_tie.mdl",
        "models/player/Suits/male_05_open_waistcoat.mdl",
        "models/player/Suits/male_05_shirt.mdl",
        "models/player/Suits/male_05_shirt_tie.mdl",

        "models/player/Suits/male_06_closed_coat_tie.mdl",
        "models/player/Suits/male_06_closed_tie.mdl",
        "models/player/Suits/male_06_open.mdl",
        "models/player/Suits/male_06_open_tie.mdl",
        "models/player/Suits/male_06_open_waistcoat.mdl",
        "models/player/Suits/male_06_shirt.mdl",
        "models/player/Suits/male_06_shirt_tie.mdl",

        "models/player/Suits/male_07_closed_coat_tie.mdl",
        "models/player/Suits/male_07_closed_tie.mdl",
        "models/player/Suits/male_07_open.mdl",
        "models/player/Suits/male_07_open_tie.mdl",
        "models/player/Suits/male_07_open_waistcoat.mdl",
        "models/player/Suits/male_07_shirt.mdl",
        "models/player/Suits/male_07_shirt_tie.mdl",

        "models/player/Suits/male_08_closed_coat_tie.mdl",
        "models/player/Suits/male_08_closed_tie.mdl",
        "models/player/Suits/male_08_open.mdl",
        "models/player/Suits/male_08_open_tie.mdl",
        "models/player/Suits/male_08_open_waistcoat.mdl",
        "models/player/Suits/male_08_shirt.mdl",
        "models/player/Suits/male_08_shirt_tie.mdl",

        "models/player/Suits/male_09_closed_coat_tie.mdl",
        "models/player/Suits/male_09_closed_tie.mdl",
        "models/player/Suits/male_09_open.mdl",
        "models/player/Suits/male_09_open_tie.mdl",
        "models/player/Suits/male_09_open_waistcoat.mdl",
        "models/player/Suits/male_09_shirt.mdl",
        "models/player/Suits/male_09_shirt_tie.mdl",

        "models/pacagma/rockstar_games/gta_online_female_assistant/gta_online_female_assistant_player_blu.mdl",
        "models/pacagma/rockstar_games/gta_online_female_assistant/gta_online_female_assistant_player.mdl"
    } models.costard = model_costard

    -- secu
    local model_FIM = { // with no hazmat
        "models/process/models/fim_msk.mdl",
        "models/process/models/fim_nomsk.mdl"
    } models.FIM = model_FIM

    local model_UITS = {"models/process/models/uits_msk.mdl", "models/process/models/uits_nomsk.mdl"} models.UITS = model_UITS

    local model_IT = {"models/process/models/ait_msk.mdl", "models/process/models/ait_nomsk.mdl"} models.IT = model_IT
    
    local model_masto = {"models/ghosts_federation/ghosts_fedjuggernaut_od_player.mdl"} models.masto = model_masto
    local model_masto_gdi = {"models/gta5/juggernautpm.mdl"} models.masto_gdi = model_masto_gdi

    local model_talos = {"models/player/tfa_kz_helghast_assault.mdl"} models.talos = model_talos

    local model_uiaa = {"models/codiw_mechs/c6/C6_T2_0CF.mdl"} models.uiaa = model_uiaa
    local model_uiaal = {"models/codiw_mechs/c6/c6_t3_0ce.mdl"} models.uiaal = model_uiaal

    local model_citizen = {
        "models/player/Group01/male_09.mdl",
        "models/player/Group01/male_08.mdl",
        "models/player/Group01/male_07.mdl",
        "models/player/Group01/male_06.mdl",
        "models/player/Group01/male_05.mdl",
        "models/player/Group01/male_04.mdl",
        "models/player/Group01/male_03.mdl",
        "models/player/Group01/male_02.mdl",
        "models/player/Group01/male_01.mdl"
    } models.ia = model_citizen

    local model_ge = {
        "models/player/cheddar/agent/agent_vance.mdl",
        "models/player/cheddar/agent/agent_van.mdl",
        "models/player/cheddar/agent/agent_ted.mdl",
        "models/player/cheddar/agent/agent_sandro.mdl",
        "models/player/cheddar/agent/agent_mike.mdl",
        "models/player/cheddar/agent/agent_joe.mdl",
        "models/player/cheddar/agent/agent_eric.mdl",
        "models/player/cheddar/agent/agent_art.mdl",
    } models.ge = model_ge

    local model_chien = {"models/lb/gtacityrp/bcmpd_police_dog.mdl"} models.chien = model_chien
    
    local model_capitaine = {
        "models/maolong/heavy/bms_security_guard_03_sleeveless.mdl",
        "models/maolong/heavy/bms_security_guard_02_sleeveless.mdl",
        "models/maolong/heavy/bms_security_guard_01_sleeveless.mdl",
        "models/maolong/heavy/bms_security_guard_03.mdl",
        "models/maolong/heavy/bms_security_guard_02.mdl",
        "models/maolong/heavy/bms_security_guard_01.mdl",
        "models/maolong/heavy/female/guard_female_pm.mdl"
    } models.capitaine = model_capitaine
    
    local model_garde = {
        "models/maolong/bms_security_guard_03_sleeveless.mdl",
        "models/maolong/bms_security_guard_02_sleeveless.mdl",
        "models/maolong/bms_security_guard_01_sleeveless.mdl",
        "models/maolong/bms_security_guard_03.mdl",
        "models/maolong/bms_security_guard_02.mdl",
        "models/maolong/bms_security_guard_01.mdl",
        "models/maolong/female/guard_female_pm.mdl"
    } models.garde = model_garde
    
    local model_ae = {"models/arachnit/random/georgian_riot_police/georgian_riot_police_player.mdl"} models.ae = model_ae
    
    local model_auxiliaire = {"models/player/spike/sircorgi.mdl"}
    
    local model_asr = {"models/kerry/detective/male_01.mdl", "models/kerry/detective/male_02.mdl", "models/kerry/detective/male_03.mdl", "models/kerry/detective/male_04.mdl", "models/kerry/detective/male_05.mdl",
    "models/kerry/detective/male_09.mdl", "models/kerry/detective/male_06.mdl", "models/kerry/detective/male_07.mdl", "models/kerry/detective/male_08.mdl"
}
    local model_sentinelle = add_tables(model_asr, model_garde, model_auxiliaire, model_ge, model_IT, model_UITS, model_costard, model_gordonramsay, model_cook_f, model_technicien, model_logisticien, model_concierge)
    
    -- scp
    local model_999 = {"models/scp/999/jq/scp_999_pmjq.mdl"}
    local model_131 = {"models/thenextscp/scp131/scp131.mdl"}
    local model_049 = {"models/vinrax/player/Scp049_player.mdl"}
    local model_096 = {"models/scp096anim/player/scp096pm_raf.mdl"}
    local model_073 = {"models/player/scientist.mdl"}
    local model_457 = {"models/cultist/scp/scp_457.mdl"}
    local model_966 = {"models/vasey105/scp/scp966/scp-966.mdl"}
    local model_006fr = {"models/sirris/sergeikozin.mdl"}
    local model_527 = {"models/scp_527/scp_527.mdl"}
    local model_173 = {"models/breach173.mdl"}
    local model_106 = {"models/scp/106/unity/unity_scp_106_player.mdl"}
    local model_682 = {"models/scp_682/scp_682.mdl"}
    local model_939 = {"models/939/939.mdl"}
    local model_1983pro = {"models/player/stalker/packboy.mdl"}
    local model_1048 = {"models/1048/tdy/tdybrownpm.mdl"}
    
    -- body group
    -- garde
    local bg_ofc_chest = {0, 1, 2, 5, 7}
    local bg_ae_chest = {0, 6, 7}
    local bg_asr_chest = {5}

    local bg_ofc_helmet = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13}
    local bg_ofcsgt_helmet = {14} table.Add(bg_ofcsgt_helmet, bg_ofc_helmet)
    local bg_ofcltn_helmet = {15} table.Add(bg_ofcltn_helmet, bg_ofc_helmet)
    local bg_asr_helmet = {14}
    local bg_surveillant_helmet = {4, 5, 6, 7}
    
    local bg_ofc_mask = {0, 1, 2}
    local bg_ofc_holster = {0, 1, 2}
    local bg_ofc_flashlight = {0, 1}
    local bg_ofc_glasses = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}

    -- IT
    local bg_IT = {
        ["Head"] = {0},
        ["body"] = {0},
        ["Couvre-Chef"] = {0,1,2,3},
        ["Req. Casque - Lampe"] = {0,1},
        ["Req. Casque - Strobe IR"] = {0,1},
        ["Req. Casque - JVN"] = {0,1,2},
        ["Req. Casque - Protections Auditives"] = {0,1},
        ["Req. Casque - Microphone"] = {0,1},
        ["Req. Casque - Masque"] = {0,1,2},
        ["Lunettes"] = {0,1},
        ["Manches"] = {0,1},
        ["Veste"] = {0,1},
        ["Req. Veste - Équipement universel"] = {0, 1},
        ["Req. Veste - Équipement spécialisé"] = {0,1,2,3},
        ["Req. Veste - Sac à dos"] = {0,1},
        ["Ceinturon"] = {0},
        ["Req. Ceinturon - Équipement Standard"] = {0,1},
        ["Req. Ceinturon - Équipement Spécifique"] = {0,1,2},
        ["Body"] = {0},
        ["Head"] = {0},
        ["Grenade"] = {0},
        ["Helmet"] = {0,1},
        ["Left_Arm"] = {0,1,2},
        ["Right_Arm"] = {0,1,2},
    }

    local bg_IT_cadet = table.Copy(bg_IT)
    bg_IT_cadet["Patch d'épaule"] = {0}

    local bg_IT_agent = table.Copy(bg_IT)
    bg_IT_agent["Patch d'épaule"] = {1}

    local bg_IT_cpl = table.Copy(bg_IT)
    bg_IT_cpl["Patch d'épaule"] = {2}

    local bg_IT_sgt = table.Copy(bg_IT)
    bg_IT_sgt["Patch d'épaule"] = {3}

    local bg_IT_ltn = table.Copy(bg_IT)
    bg_IT_ltn["Patch d'épaule"] = {4}

    local bg_IT_cmd = table.Copy(bg_IT)
    bg_IT_cmd["Patch d'épaule"] = {5}

    -- uiaa
    local bg_UIAA_skin = {0, 9, 18}

-- nv
local nv_quadtube_pro = "nvg_gpnvg"
local nv_thermique = "nvg_t7"
    
-- armor
local it_armor = 250
local ofc_armor = 180

local function give_health_and_armor(ply, health, armor)
    health = health or 100
    ply:SetHealth(health)
    ply:SetMaxHealth(health)

    armor = armor or 0
    ply:SetArmor(armor)
    ply:SetMaxArmor(armor < ofc_armor and ofc_armor or armor)
end

local function give_gaz_mask(ply)
    ply:SetNWBool("HasGasmask", true)
    ply:SetNWInt("GasmaskHealth", 100)
    ply:SetNWInt("FilterDuration", 60)
    ply:SetNWInt("Filter", math.min( 3600, ply:GetNWInt("Filter") + 100) )
end

-- force
local walkspeed = 130
local runspeed = 250
local jumppower = 200

local force_garde = 1.1
local force_ait = 1.25
local force_intru = 1.25
local force_chien = 1.5
local force_masto = 0.8 process.darkrp.force_masto = force_masto // used for uits class
local force_106 = 0.2
local force_1983 = 2

--[[-- ======================= ADMINISTRATION ======================= --]]
TEAM_SECRETAIRE = DarkRP.createJob("Secrétaire Administratif", {
    color = Color(255, 5, 5),
    model = model_costard,
    description = [[Vous êtes un membre de classe C et accrédité niveau 2, vous assistez les directeurs de branche dans leur travail.]],
    weapons = {
        lvl2,
        radio
    },
    command = "secretaire",
    max = 4,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Administration",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 10,
    model_hazmat = "models/nada/male/IDMRWorker.mdl",
})

TEAM_ADJ = DarkRP.createJob("Adjoint du directeur", {
    color = Color(255, 5, 5),
    model = model_costard,
    description = [[Vous êtes un membre de classe C et accrédité niveau 3 , vous êtes le larbin, euh l'assistant du Directeur du site et le remplacez lors de son absence.]],
    weapons = {
        lvl3,
        radio
    },
    command = "adj",
    max = 1,
    salary = 140,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Administration",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 20,
    model_hazmat = "models/nada/male/IDMRWorker.mdl",
})

TEAM_DIRLOG = DarkRP.createJob("Direction Logistique", {
    color = Color(108, 122, 137),
    model = model_costard,
    description = [[ous êtes un membre de classe B et accrédité niveau 3. Vous gérez le pôle logistique et distribuez le travail au sein de la branche.]],
    weapons = {
        lvl3,
        sig_sauer,
        radio,
        tablet_logi
    },
    command = "dirlog",
    max = 1,
    salary = 250,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Administration",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 21,
    whitelist = "secondaire",
    model_hazmat = "models/nada/male/IDMRWorker.mdl",
})

local iaa_can_pickup = process.to_if_check_table(ia_swep, tablet_ads, tablet_logi, radio, tp_ia, lvl5)
TEAM_IAA = DarkRP.createJob("IAA", {
    color = Color(255, 5, 5),
    model = model_costard,
    description = [[Vous avez une accréditation de niveau 4 et n'êtes pas classifié comme membre du personnel. Vous êtes l'intelligence artificielle du site, vous gérez le site sous les ordres des directeurs de branches, vous aidez aussi à protéger aussi le site.]],
    weapons = {
        ia_swep,
        tp_ia,
        tablet_ads,
        tablet_logi,
        radio,
        lvl5,
    },
    command = "iaa",
    max = 1,
    salary = 250,
    admin = 0,
    vote = false,
    category = "Administration",
    candemote = false,
    PlayerSpawn = function(ply)
        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
        
        give_health_and_armor(ply, 2147483647)

        ply:SetMaterial("models/wireframe")
        ply:SetColor(Color(0, 191, 255))
    end,
    level = 23,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons. IAA will only have ia_swep
    PlayerCanPickupWeapon = function(ply, weapon) return iaa_can_pickup[weapon:GetClass()] end,
    whitelist = "principale",
})

TEAM_DIRSECU = DarkRP.createJob("Directeur de la sécurité", {
    color = Color(5, 180, 255),
    model = model_costard,
    description = [[Vous êtes un membre de classe B et accrédité niveau 4. Vous gérez tous les départements de sécurité et réglez les problèmes au sein de la branche de la sécurité.]],
    weapons = {
        lvl4,
        sig_sauer,
        radio
    },
    command = "dirsecu",
    max = 1,
    salary = 250,
    admin = 0,
    vote = false,
    category = "Administration",
    candemote = false,
 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, ofc_armor)
    end,
    level = 24,
    whitelist = "principale",
    model_hazmat = "models/nada/male/IDMRWorker.mdl",
})

TEAM_DIRSCT = DarkRP.createJob("Directeur Scientifique", {
    color = Color(255, 255, 159),
    model = model_costard,
    description = [[Vous êtes un membre de classe B et accrédité niveau 4, vous gérez toute la branche scientifique, vous vous assurez que vos esclaves, je veux dire scientifiques, ont tout le matériel nécessaire pour leurs expériences, vous ne pouvez faire ou participer à des expériences.]],
    weapons = {
        lvl4,
        sig_sauer,
        radio
    },
    command = "dirsct",
    max = 1,
    salary = 250,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Administration",
    candemote = false,
 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 25,
    whitelist = "principale",
    model_hazmat = "models/nada/male/IDMRWorker.mdl",
})

TEAM_DDS = DarkRP.createJob("Directeur du site", {
    color = Color(255, 5, 5),
    model = model_costard,
    description = [[Vous êtes un membre de classe B et accrédité niveau 4 , vous gérez le site.]],
    weapons = {
        lvl4,
        tablet_ads,
        tablet_logi,
        sig_sauer,
        radio
    },
    command = "dds",
    max = 1,
    salary = 300,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Administration",
    candemote = false,
 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 26,
    whitelist = "principale",
    model_hazmat = "models/nada/male/IDMRWorker.mdl",
})

TEAM_MCE = DarkRP.createJob("Membre du comité d'éthique", {
    color = Color(255, 5, 5),
    model = model_costard,
    description = [[Vous êtes un membre de classe B et accrédité niveau 4, vous inspectez le site et vérifiez si l'éthique humaine et si les protocoles de la fondation y sont appliqués.]],
    weapons = {
        lvl4,
        sig_sauer,
        radio
    },
    command = "mce",
    max = 1,
    salary = 260,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Administration",
    candemote = false,
 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 26,
    whitelist = "principale",
    model_hazmat = "models/nada/male/IDMRWorker.mdl",
})

--[[-- ======================= SÉCURITÉ ======================= --]]
-- surveillance rapprochée et sentinelles
TEAM_CHIEN = DarkRP.createJob("Chien", {
    color = Color(5, 180, 255),
    model = model_chien,
    description = [[Vous êtes un...chien ? Vous assistez les sentinelles et les autres branches de la sécurité lors de leurs patrouilles et arrestations.]],
    weapons = {
        "weapon_pet",
        radio
    },
    command = "chien",
    max = 2,
    salary = 50,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Sécurité",
    candemote = false, 
    runspeed= runspeed * force_chien, 
    damagescale=0.75,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, 25)
    end,
    level = 7,
})

TEAM_UIAA = DarkRP.createJob("UIAA", {
    color = Color(255, 5, 5),
    model = model_uiaa,
    skins = {0, 9, 18},
    bodygroups = {
        ["studio"] = {0},
        ["head"] = {0},
        ["arm"] = {0},
        ["body"] = {0},
        ["leg"] = {0},
    },
    description = [[Vous avez une accréditation de niveau 4 et n'êtes pas classifié comme membre du personnel. Vous êtes une unité de l'IAA, vous patrouiller dans le site sous ordre de l'IAA et vous êtes doté d'une arme pour vous défendre.]],
    weapons = {
        lvl4,
        radio
    },
    command = "uiaa",
    max = 3,
    salary = 120,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    runspeed= runspeed * 1.35, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, 255)

        ArcticNVGs_SetPlayerGoggles(ply, nv_thermique)
    end,
    level = 13,
    donator = 1,
})

TEAM_UIAAL = DarkRP.createJob("UIAA Lourde", {
    color = Color(255, 5, 5),
    model = model_uiaal,
    skins = {0, 9, 18},
    bodygroups = {
        ["studio"] = {0},
        ["head"] = {0},
        ["arm"] = {0},
        ["body"] = {0},
        ["leg"] = {0},
    },
    description = [[Vous avez une accréditation de niveau 4 et n'êtes pas classifié comme membre du personnel. Vous êtes une unité de l'IAA, vous patrouiller dans le site sous ordre de l'IAA et vous êtes doté d'une arme pour vous défendre.]],
    weapons = {
        lvl4,
        radio
    },
    command = "uiaal",
    max = 2,
    salary = 400,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    runspeed= runspeed * 1.35, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, 255)

        ArcticNVGs_SetPlayerGoggles(ply, nv_thermique)
    end,
    level = 13,
    donator = 2,
})

TEAM_GE = DarkRP.createJob("Garde d'élite (GE)", {
    color = Color(100, 0, 0),
    model = model_ge,
    skins = {0},
    bodygroups = {
        ["male_05"] = {0},
        ["body"] = {0},
        ["aviator"] = {0, 1},
        ["chest"] = {0},
        ["hands"] = {0, 1},
        ["ties"] = {0,1,2,3,4,5},
    },
    description = [[Vous êtes un membre de classe C et accrédité niveau 3. Vous assurez la sécurité du personnel de classe B et A, vous êtes un soldat d'élite incorruptible, vous pouvez désobéir à un ordre si vous jugez que celui-ci a des conséquences sur la protection de votre protégé les seules personnes/choses à avoir une totale autorité sur vous son l'O5 , les sentinelles, l'IA et vos protocoles.]],
    weapons = {
        lvl4,
        radio
    },
    command = "ge",
    max = 3,
    salary = 160,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    runspeed= runspeed * force_garde, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, ofc_armor)
    end,
    level = 18,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_SENTINELLE = DarkRP.createJob("Sentinelle", {
    color = Color(255, 5, 5),
    model = model_sentinelle,
    description = [[Vous êtes un membre de classe B et accrédité niveau 4. Vous avez été envoyé par l'O5 pour surveiller le membre du personnel et chercher les traces de corruptions et les possibles intrus. En état, passif, vous êtes sous les ordres des directeurs et gradés de la sécurité. Vous pouvez à tout moment vous déguiser pour enquêter et vous fondre dans la masse pour mieux agir. En cas d'arrestation, vous pouvez présenter votre badge qu'en cas d'extrême besoin. ATTENTION, l'abus de pouvoir n'est en aucun cas permit sous peine de vous faire abattre par vos collègues ou de voir votre whitelist disparaître par magie.]],
    weapons = {
       lvl4,
       radio
    },
    //skins = {0,1,2,4},
    /*bodygroups = {
        ["body"] = {0, 1},
        ["Armor"] = {0, 3},
        ["Badge"] = {2},
    },*/
    command = "sent",
    max = 3,
    salary = 200,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    runspeed= runspeed * force_garde, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, ofc_armor)
    end,
    level = 19,
    whitelist = "secondaire",
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

-- FIM
TEAM_SOLDATFIM = DarkRP.createJob("Soldat FIM", {
    color = Color(5, 180, 255),
    model = model_FIM,
    description = [[Vous êtes accrédité de niveau 3 et membre du personnel de Classe-C Vous êtes un F.I.M , vous intervenez sur site seulement en cas de force majeure.]],
    weapons = {
        lvl3,
        radio
    },
    command = "fim",
    max = 8,
    salary = 150,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)
        
        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 20,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_MASTOFIM = DarkRP.createJob("Mastodonte FIM", {
    color = Color(5, 180, 255),
    model = model_masto,
    skins = {
        0
    },
    description = [[Vous êtes accrédité de niveau 3 et de membre du personnel de Classe-C. Vous êtes le bourrin de l'équipe F.I.M, vous intervenez sur site seulement en cas de force majeure.]],
    weapons = {
        lvl3,
        radio,
        "arccw_firearms2_m249"
    },
    command = "mastofim",
    max = 1,
    salary = 400,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_masto, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, 180)
        
        ply:SetSkin(4)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 29,
    donator = 2,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_LTNFIM = DarkRP.createJob("Lieutenant FIM", {
    color = Color(5, 180, 255),
    model = model_FIM,
    description = [[Vous êtes accrédité de niveau 3 et êtes un membre du personnel de Classe-C Vous êtes Lieutenant F.I.M ... Vous intervenez sur site seulement en cas de force majeure.]],
    weapons = {
        lvl4,
        radio
    },
    command = "ltnfim",
    max = 1,
    salary = 175,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 30,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_CMDFIM = DarkRP.createJob("Commandant FIM", {
    color = Color(5, 180, 255),
    model = model_FIM[1],
    description = [[Vous êtes accrédité de niveau 4 un membre du personnel de Classe-C. Vous êtes commandant F.I.M ... Vous intervenez sur site seulement en cas de force majeure.]],
    weapons = {
        lvl4,
        radio
    },
    command = "cmdfim",
    max = 1,
    salary = 250,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 31,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

-- agent de sécu/garde
TEAM_CADETSECU = DarkRP.createJob("Cadet de la sécurité", {
    color = Color(5, 180, 255),
    model = model_garde,
    bodygroups = {
        ["chest"] = bg_ofc_chest,
        ["mask&cigar"] = bg_ofc_mask,
        ["holster"] = bg_ofc_holster,
        ["flashlight"] = bg_ofc_flashlight,
        ["glasses"] = bg_ofc_glasses,
        ["helmet"] = bg_ofc_helmet,
    },
    description = [[Vous êtes un membre de classe C et accrédité niveau 1. Vos connaissances sur la Fondation sont limitées. Vous êtes une sorte de stagiaire au sein de la sécurité pénitentiaire. Vous maintenez l'ordre au sein du bloc carcéral uniquement avec l'aide des autres membres de sécurité pénitentiaire.]],
    weapons = {
        lvl1,
        radio
    },
    command = "cadet",
    max = 4,
    salary = 80,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_guard_pm.mdl",
    runspeed= runspeed * force_garde, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, ofc_armor)
    end,
    level = 5,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_SURVEILLANT = DarkRP.createJob("Auxiliaire Carcéral", {
    color = Color(5, 180, 255),
    model = model_auxiliaire,
    description = [[Vous êtes un membre de classe C et accrédité au niveau 2. Vous êtes assigné au secteur pénitencier exclusivement et maintenez l'ordre au sein du bloc carcéral. Vos connaissances sur les SCP sont encore plutôt limitées. Vous écoutez les ordres de vos supérieurs et faites simplement votre travail.]],
    weapons = {
        lvl2,
        radio,
        sig_sauer
    },
    command = "surveillant",
    max = 2,
    salary = 100,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_guard_pm.mdl",
    runspeed= runspeed * force_garde, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100)
    end,
    level = 8,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_OFC = DarkRP.createJob("Agent de la sécurité", {
    color = Color(5, 180, 255),
    model = model_garde,
    bodygroups = {
        ["chest"] = bg_ofc_chest,
        ["mask&cigar"] = bg_ofc_mask,
        ["holster"] = bg_ofc_holster,
        ["flashlight"] = bg_ofc_flashlight,
        ["glasses"] = bg_ofc_glasses,
        ["helmet"] = bg_ofc_helmet,
    },
    description = [[Vous êtes un membre de classe C et accrédité niveau 2 . Vos connaissances sur les SCP sont assez étendues. Vous maintenez l'ordre et la discipline au sein de la cantine avec l'aide des autres membres de sécurité pénitentiaire et patrouillez dans le site pour maintenir l'ordre et la sécurité. Vous pouvez accompagner les scientifiques lors de leur expérience.]],
    weapons = {
        lvl3,
        radio
    },
    command = "ofc",
    max = 7,
    salary = 120,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_guard_pm.mdl",
    runspeed= runspeed * force_garde, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, ofc_armor)
    end,
    level = 10,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_AE = DarkRP.createJob("Anti-Émeute", {
    color = Color(5, 180, 255),
    model = model_ae,
    skins = {1},
    bodygroups = {
        ["Gloves"] = {0,1,2},
        ["Body"] = {0},
        ["Balaclava"] = {0},
        ["Helmet"] = {0},
        ["Gas Mask"] = {0},
        ["Visor"] = {0, 1,2},
        ["Shield"] = {0},
        ["Gear"] = {0,1,2},
        ["Smoke Grenades"] = {0,1},
    },
    description = [[Vous êtes un membre de classe C et accrédité niveau 3 . Vous maintenez l'ordre et la discipline au sein de la cantine avec l'aide des autres membres de sécurité pénitentiaire. Vous gérez les patrouilles et partez en patrouille avec vos hommes. Vous partez avec les scientifiques en expérience aussi.]],
    weapons = {
        lvl3,
        radio,
        "riot_shield"
    },
    command = "ae",
    max = 2,
    salary = 120,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_guard_pm.mdl",
    runspeed= runspeed * force_garde, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, ofc_armor)
    end,
    level = 8,
    donator = 1,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_OFCSGT = DarkRP.createJob("Sergent de la sécurité", {
    color = Color(5, 180, 255),
    model = model_garde,
    bodygroups = {
        ["chest"] = bg_ofc_chest,
        ["mask&cigar"] = bg_ofc_mask,
        ["holster"] = bg_ofc_holster,
        ["flashlight"] = bg_ofc_flashlight,
        ["glasses"] = bg_ofc_glasses,
        ["helmet"] = bg_ofcsgt_helmet,
    },
    description = [[Vous êtes un membre de classe C et accrédité niveau 3 . Vous maintenez l'ordre et la discipline aux sein de la cantine avec l'aide des autres membres de sécurité pénitentiaire. Vous gérez les patrouilles et partez en patrouille avec vos hommes. Vous partez avec les scientifiques en expérience aussi.]],
    weapons = {
        lvl3,
        radio
    },
    command = "ofcsgt",
    max = 1,
    salary = 120,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_guard_pm.mdl",
    runspeed= runspeed * force_garde, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, ofc_armor)
    end,
    level = 14,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_OFCLTN = DarkRP.createJob("Lieutenant de la sécurité", {
    color = Color(5, 180, 255),
    model = model_garde,
    bodygroups = {
        ["chest"] = bg_ofc_chest,
        ["mask&cigar"] = bg_ofc_mask,
        ["holster"] = bg_ofc_holster,
        ["flashlight"] = bg_ofc_flashlight,
        ["glasses"] = bg_ofc_glasses,
        ["helmet"] = bg_ofcltn_helmet,
    },
    description = [[Vous êtes un membre de classe C et accrédité niveau 3 . Vous maintenez l'ordre et la discipline au sein de la cantine avec l'aide des autres membres de sécurité pénitentiaire. Vous êtes le bras droit du capitaine et le remplacer en son absence. Vous gérez les patrouilles et partez en patrouille avec vos hommes. Vous partez avec les scientifiques en expérience aussi.]],
    weapons = {
        lvl4,
        radio
    },
    command = "ofcltn",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_guard_pm.mdl",
    runspeed= runspeed * force_garde, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, ofc_armor)
    end,
    level = 19,
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

TEAM_CPT = DarkRP.createJob("Capitaine", {
    color = Color(5, 180, 255),
    model = model_capitaine,
    bodygroups = {
        ["chest"] = bg_ofc_chest,
        ["mask&cigar"] = bg_ofc_mask,
        ["holster"] = bg_ofc_holster,
        ["flashlight"] = bg_ofc_flashlight,
        ["glasses"] = bg_ofc_glasses,
        ["helmet"] = bg_ofcltn_helmet,
    },
    description = [[Vous êtes un membre de classe C et accrédité niveau 4 . Vous maintenez l'ordre et la discipline au sein de la cantine avec l'aide des autres membres de sécurité pénitentiaire. Vous êtes le plus haut gradé dans la branche de sécurité pénitentiaire. Vous gérez les patrouilles et partez en patrouille avec vos hommes. Vous partez avec les scientifiques en expérience aussi.]],
    weapons = {
        lvl4,
        radio
    },
    command = "CPT",
    max = 1,
    salary = 190,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_guard_pm.mdl",
    runspeed= runspeed * force_garde, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, ofc_armor)
            end,
    level = 21,
    whitelist = "principale",
    model_hazmat = "models/nada/male/IDMROfficer.mdl",
})

-- AIT
TEAM_RCTIT = DarkRP.createJob("Recrue d'intervention tactique (RIT)", {
    color = Color(5, 180, 255),
    model = model_IT,
    bodygroups = bg_IT_cadet,
    description = [[Vous êtes un membre de classe C et accrédité niveau 2. Vous intervenez sur des zones sensibles et protégez les installions importantes du site avec vos collègues du département d'intervention tactique.]],
    weapons = {
        lvl2,
        radio
    },
    command = "rcit",
    max = 3,
    salary = 80,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)
        
        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 9,
    model_hazmat = "models/player/R6S_R6Hazmat.mdl",
})

TEAM_AIT = DarkRP.createJob("Agent d'intervention Tactique (AIT)", {
    color = Color(5, 180, 255),
    model = model_IT,
    bodygroups = bg_IT_agent,
    description = [[Vous êtes un membre de classe C et accrédité niveau 3 . Vous intervenez sur des zones sensibles et protégez les installions importantes du site avec vos collègues du département d'intervention tactique. Suivez les ordres de vos supérieurs.]],
    weapons = {
        lvl3,
        radio
    },
    command = "ait",
    max = 4,
    salary = 100,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 12,
    model_hazmat = "models/player/R6S_R6Hazmat.mdl",
})

TEAM_UITS = DarkRP.createJob("Unité d'intervention tactique spécialisé (UITS)", {
    color = Color(5, 180, 255),
    model = model_UITS,
    description = [[Vous êtes un membre de classe C et accrédité niveau 3 , comme le nom l'indique, vous êtes une unité médicale, vous performez les premiers secours au membre du personnel. Attention, vous n'êtes pas un docteur, vous appliquez seulement les premiers soins. Vous n'allez sûrement pas commencer une opération chirurgicale. Vous avez les mêmes missions qu'un AIT sauf que vous vous êtes spécialisée dans le secourisme.]],
    weapons = {
        lvl3,
        radio,
        "tfa_csgo_smoke",
        "tfa_csgo_flash",
        "pepper_spray",
        "weapon_r_restrains",
        "dsr_megaphone",
        "dsr_metal_detector",
        "stungun",
        sig_sauer,
    },
    command = "uits",
    max = 2,
    salary = 120,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 13,
    donator = 1,
    model_hazmat = "models/player/R6S_R6Hazmat.mdl",
})

TEAM_CPLIT = DarkRP.createJob("Caporal d'Intervention Tactique (CPL IT)", {
    color = Color(5, 180, 255),
    model = model_IT,
    bodygroups = bg_IT_cpl,
    description = [[Vous êtes un membre de classe C et accrédité niveau 3 . Vous pouvez former les recrues IT en AIT. Vous pouvez aussi assister le sergent/lieutenant/commandant lors des formations de spécialisation. Vous intervenez sur des zones sensibles et protégez les installions importantes du site avec vos collègues du département d'intervention tactique. Suivez les ordres de vos supérieurs et dirigez vos hommes.]],
    weapons = {
        lvl3,
        radio
    },
    command = "cplit",
    max = 1,
    salary = 130,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 16,
    model_hazmat = "models/player/R6S_R6Hazmat.mdl",
})

TEAM_SGTIT = DarkRP.createJob("Sergent d'Intervention Tactique (SGT IT)", {
    color = Color(5, 180, 255),
    model = model_IT,
    bodygroups = bg_IT_sgt,
    description = [[Vous êtes un membre de classe C et accrédité niveau 3 . Vous pouvez former les recrues IT en AIT. Vous pouvez aussi assister le lieutenant/commandant lors des formations de spécialisation. Vous intervenez sur des zones sensibles et protégez les installions importantes du site avec vos collègues du département d'intervention tactique. Suivez les ordres de vos supérieurs et dirigez vos hommes.]],
    weapons = {
        lvl3,
        radio
    },
    command = "sgtit",
    max = 1,
    salary = 140,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 19,
    model_hazmat = "models/player/R6S_R6Hazmat.mdl",
})

TEAM_LTNIT = DarkRP.createJob("Lieutenant d'Intervention Tactique (LTN IT)", {
    color = Color(5, 180, 255),
    model = model_IT,
    bodygroups = bg_IT_ltn,
    description = [[Vous êtes un membre de classe C et accrédité niveau 4 . Vous pouvez former les recrues IT en AIT et les AIT en SGT. Vous pouvez aussi vous occuper des formations de spécialisation avec l'aide d'un formateur. Vous intervenez sur des zones sensibles et protégez les installions importantes du site avec vos collègues du département d'intervention tactique. Suivez les ordres de vos supérieurs et dirigez vos hommes.]],
    weapons = {
        lvl4,
        radio
    },
    command = "ltnit",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 22,
    model_hazmat = "models/player/R6S_R6Hazmat.mdl",
})

TEAM_CMDIT = DarkRP.createJob("Commandant d'Intervention Tactique (CDT IT)", {
    color = Color(5, 180, 255),
    model = model_IT,
    bodygroups = bg_IT_cmd,
    description = [[Vous êtes un membre de classe C et accrédité niveau 4 . Vous pouvez former les recrues IT en AIT, les AIT en SGT et les SGT en LTN. Vous pouvez aussi vous occuper des formations de spécialisation avec l'aide d'un formateur. Vous êtes le plus gradé dans le DIT. Vous intervenez sur des zones sensibles et protégez les installions importantes du site avec vos collègues du département d'intervention tactique. Suivez les ordres de vos supérieurs et dirigez vos hommes.]],
    weapons = {
        lvl4,
        radio
    },
    command = "cmdit",
    max = 1,
    salary = 190,
    admin = 0,
    vote = false,
    category = "Sécurité",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 26,
    whitelist = "principale",
    model_hazmat = "models/player/R6S_R6Hazmat.mdl",
})


--[[-- ======================= SCIENTIFIQUE ======================= --]]

TEAM_SCIAS = DarkRP.createJob("Assistant Scientifique", {
    color = Color(255, 255, 159),
    model = model_chercheur,
    description = [[Vous êtes un membre de classe C et accrédité niveau 1, vous êtes nouveau sur le site process. Vous pouvez assister les autres scientifiques. Vous pouvez expérimenter sous la tutelle d'un chercheur Junior ou plus, sur les SCP de Classe-Sûr. Vous connaissez tous les SCP présents sur l'installation, mais ne connaissez précisément que les SCP de Classe SAFE et les autres classes.]],
    weapons = {
        lvl1,
        radio,
        laptop
    },
    command = "scias",
    max = 10,
    salary = 80,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Scientifique",
    candemote = false,
    model_zombie = "models/zombies/pyri_pm/zombie_sci_pm.mdl",
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 1,
    model_hazmat = "models/nada/male/MedicalHazmat.mdl",
})

TEAM_SCTJR = DarkRP.createJob("Scientifique Junior", {
    color = Color(255, 255, 159),
    model = model_chercheur,
    description = [[Vous êtes un membre de classe C et accrédité niveau 2, vous travaillez depuis plusieurs mois sur le site process. Vous pouvez expérimenter sur les SCP de Classe SAFE et Euclid sous autorisation d'un chercheur titulaire. Vous connaissez tous les SCP présents sur l'installation, mais ne connaissez précisément que les SCP de Classe SAFE et Euclide et les autres classes.]],
    weapons = {
        lvl2,
        radio,
        laptop
    },
    command = "sctjr",
    max = 4,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Scientifique",
    candemote = false,
    model_zombie = "models/zombies/pyri_pm/zombie_sci_pm.mdl",
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 10,
    model_hazmat = "models/nada/male/MedicalHazmat.mdl",
})

TEAM_SCTTITU = DarkRP.createJob("Scientifique Titulaire", {
    color = Color(255, 255, 159),
    model = model_chercheur,
    description = [[Vous êtes un membre de classe C et accrédité niveau 2, Vous travaillez depuis plusieurs années sur le site process. Vous pouvez expérimenter sur les SCP de Classe SAFE, Euclid et Keter sous autorisation du superviseur de recherche et sous la tutelle d'un chercheur senior. Vous connaissez tous les SCP présents sur l'installation.]],
    weapons = {
        lvl2,
        radio,
        laptop
    },
    command = "scttitu",
    max = 4,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Scientifique",
    candemote = false,
    model_zombie = "models/zombies/pyri_pm/zombie_sci_pm.mdl",
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 16,
    model_hazmat = "models/nada/male/MedicalHazmat.mdl",
})

TEAM_SDC = DarkRP.createJob("SDC (spécialiste du confinement)", {
    color = Color(255, 255, 159),
    model = model_sdc,
    description = [[Vous êtes un membre de classe C et accrédité niveau 3, vous connaissez tous les SCP et leur confinement du site par cœur, vous pouvez accompagner les IT sur les reconfinements pour sécuriser les confinements et les installations du site. Vous ne pouvez pas faire d'expériences, mais vous pouvez effectuer des inspections sur tous les confinements du site ainsi que les maintenances.]],
    skins = {0},
    weapons = {
        lvl3,
        radio
    },
    command = "sdc",
    max = 2,
    salary = 110,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Scientifique",
    candemote = false,
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 13,
})

TEAM_SCTSCENIOR = DarkRP.createJob("Scientifique Sénior", {
    color = Color(255, 255, 159),
    model = model_chercheur,
    description = [[Vous êtes un membre de classe C et accrédité niveau 3, Vous travaillez depuis pas mal d'années sur le site process. Vous pouvez expérimenter sur les SCP de Classe SAFE, Euclid et Keter. Vous connaissez très bien tous les SCP présents sur l'installation.]],
    weapons = {
        lvl3,
        radio,
        laptop
    },
    command = "sctsenior",
    max = 2,
    salary = 190,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Scientifique",
    candemote = false,
    model_zombie = "models/zombies/pyri_pm/zombie_sci_pm.mdl",
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 19,
    model_hazmat = "models/nada/male/MedicalHazmat.mdl",
})

TEAM_SCTPROF = DarkRP.createJob("Professeur de Recherche", {
    color = Color(255, 255, 159),
    model = model_chercheur,
    description = [[Le professeur enseigne tout ce qu'il faut savoir d'assistant à scientifique senior, afin que ces derniers puissent s'occuper des expériences. Il peut également expérimenter en présence ou non des scientifiques concernés afin de les former en théorie et pratique. Vous épaulez surtout le superviseur sur la formation des chercheurs donc évitez de faire trop d'expériences seul.]],
    weapons = {
        lvl4,
        radio,
        laptop
    },
    command = "sctprof",
    max = 2,
    salary = 220,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Scientifique",
    candemote = false,
    model_zombie = "models/zombies/pyri_pm/zombie_sci_pm.mdl",
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 21,
    model_hazmat = "models/nada/male/MedicalHazmat.mdl",
})

TEAM_SUPERSCT = DarkRP.createJob("Superviseur", {
    color = Color(255, 255, 159),
    model = model_superviseur,
    bodygroups = {
        ["Glasses"] = {0, 1, 2, 3, 4},
        ["Pencil"] = {0, 1},
        ["Body"] = {1},
    },
    description = [[Vous êtes un membre de classe C et accrédité niveau 4, vous gérez vos scientifiques et leurs formations, vous vous occupez de gérer les activités des scientifiques et vous vérifiez leurs progressions tout en rapportant au directeur de votre pôle. Vous connaissez tous les SCP et vous pouvez expérimenter sur tous les SCP.]],
    weapons = {
        lvl4,
        radio,
        laptop
    },
    command = "sctsup",
    max = 1,
    salary = 250,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Scientifique",
    candemote = false,
    model_zombie = "models/zombies/pyri_pm/zombie_sci_pm.mdl",
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 23,
    whitelist = "principale",
    model_hazmat = "models/nada/male/MedicalHazmat.mdl",
})

--[[-- ======================= LOGISTIQUE ======================= --]]
TEAM_CONCIERGE = DarkRP.createJob("Concierge", {
    color = Color(108, 122, 137),
    model = model_concierge,
    description = [[Vous êtes un membre de classe C et accrédité niveau 0 . Vos connaissances sur la Fondation sont très limitées. Vous nettoyez le site (même les chiottes) et le maintenez propre.]],
    weapons = {
        lvl0,
        radio
    },
    command = "concierge",
    max = 3,
    salary = 40,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Logistique",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 3,
})

// city worker job
TEAM_TECH = DarkRP.createJob("Technicien", {
    color = Color(108, 122, 137),
    model = model_technicien,
    description = [[Vous êtes un membre de classe C et accrédité niveau 2 . Vos connaissances sur la Fondation sont limitées. Vous réparez et maintenez en fonctionnement les systèmes du site.]],
    weapons = {
        lvl2,
        radio,
        "cityworker_pliers", "cityworker_shovel", "cityworker_wrench", // for city worker
    },
    command = "tech",
    max = 3,
    salary = 50,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Logistique",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 4,
})

TEAM_LOGI = DarkRP.createJob("Logisticien", {
    color = Color(108, 122, 137),
    model = model_logisticien,
    description = [[Vous êtes un membre de classe C et accrédité niveau 2. Vos connaissances sur la Fondation sont limitées. Votre rôle est de commander et de livrer les équipements demandés par les gérants des pôles du site.]],
    weapons = {
        lvl2,
        radio
    },
    command = "logi",
    max = 2,
    salary = 40,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Logistique",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 4,
})

TEAM_MEDIC = DarkRP.createJob("Personnel médical", {
    color = Color(108, 122, 137),
    model = model_medecin,
    description = [[Vous êtes un membre de classe C et accrédité niveau 1 . Vos connaissances sur la Fondation sont limitées. Vous devez choisir une spécialité dans la médecine et à partir de là vous vous occupez de soigner les membres du personnel.]],
    weapons = {
        lvl1,
        weapon_medkit,
        radio
    },
    command = "medic",
    max = 3,
    salary = 75,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Logistique",
    candemote = false,
    medic = true,
    model_zombie = "models/zombies/pyri_pm/zombie_sci_pm.mdl",
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 3,
})

TEAM_COOK = DarkRP.createJob("Cuisinier", {
    cook = true,
    color = Color(108, 122, 137),
    model = model_cook_f,
    description = [[Vous êtes un membre de classe C et accrédité niveau 0. Vos connaissances sur la Fondation sont très limitées. Vous nourrissez les membres du personnel du site, qu'ils soient Classe D, membre de la sécurité ou des scientifiques, et même du personnel administratif.]],
    weapons = {
        lvl0,
        radio
    },
    command = "cuisinier",
    max = 3,
    salary = 40,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Logistique",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 3,
})

TEAM_CHIEFCOOK = DarkRP.createJob("Chef Cuisinier", {
    cook = true,
    color = Color(108, 122, 137),
    model = model_gordonramsay,
    description = [[Vous êtes un membre de classe C et accrédité niveau 2. Vous êtes le chef cuisinier du site, vous gérez les stocks de nourriture du site et vous rendez compte au directeur logistique du site pour vous ravitaillez et vous gérez vos cuisiniers, vous êtes un maître culinaire, agissez comme tel.]],
    weapons = {
        lvl2,
        radio
    },
    command = "chefcuisinier",
    max = 1,
    salary = 60,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Logistique",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 7,
    donator = 1,
})

TEAM_UDS = DarkRP.createJob("Unité de désinfection", {
    color = Color(108, 122, 137),
    model = model_sdc,
    description = [[Vous êtes un membre de classe C et accrédité niveau 2 . Vos connaissances sur la Fondation sont limitées. Vous pouvez assister les membres de la sécurité lors d'expérience où votre présence est requise. Vous désinfectez les zones contaminées escorté par la sécurité.]],
    skins = {3},
    weapons = {
        lvl2,
        radio
    },
    command = "uds",
    max = 2,
    salary = 50,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Logistique",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 6,
})

TEAM_ASR = DarkRP.createJob("Agent du service de ravitaillement", {
    color = Color(108, 122, 137),
    model = model_asr,
    description = [[Vous êtes accrédité de niveau 3 et de membre du personnel de Classe-C. Vous êtes un agent externe chargé de ravitailler le site, vous n'êtes pas une unité de combat et vous n'intervenez pas sur les déconfinements et alertes du site. Votre mission principale est de protéger, sécuriser et livrer votre cargaison.]],
    weapons = {
        lvl3,
        radio,
        "mg_mpapa7",
        sig_sauer
    },
    skins = {0,1,2,3,4},
    bodygroups = {
        ["body"] = {0, 1},
        ["Armor"] = {2},
        ["Badge"] = {2},
    },
    command = "asr",
    max = 3,
    salary = 250,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Logistique",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, 25)
    end,
    level = 5,
})
-- ============= Civil ===================================================================================
TEAM_D = DarkRP.createJob("Classe Delta", {
    color = Color(231, 157, 19),
    model = model_D,
    description = [[Vous êtes un prisonnier condamné à mort ayant signé un contrat pour servir la science. Vous ne savez rien de la Fondation.]],
    weapons = {
    },
    command = "delta",
    max = 0,
    salary = 35,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Civil",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 0,
    model_hazmat = "models/nada/male/factoryworker.mdl",
})

TEAM_CONTR = DarkRP.createJob("Classe Delta contrebandier ", {
    color = Color(231, 157, 19),
    model = model_D,
    description = [[Vous êtes un prisonnier condamné à mort ayant signé un contrat pour servir la science. Vous ne connaissez rien de la Fondation. Cependant, vous pouvez vendre des armes.]],
    weapons = {
    },
    command = "contrebandier",
    max = 2,
    salary = 40,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Civil",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 9,
    model_hazmat = "models/nada/male/factoryworker.mdl",
})

TEAM_CONTRAVANCE = DarkRP.createJob("Classe Delta contrebandier avancé", {
    color = Color(231, 157, 19),
    model = model_D,
    description = [[Vous êtes un prisonnier condamné à mort ayant signé un contrat pour servir la science. Vous ne connaissez rien de la Fondation. Cependant, vous pouvez vendre des armes plus avancées.]],
    weapons = {
    },
    command = "contrebandieravance",
    max = 1,
    salary = 40,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Civil",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 13,
    donator = 1,
    model_hazmat = "models/nada/male/factoryworker.mdl",
})

TEAM_RAT = DarkRP.createJob("animal", {
    color = Color(231, 157, 19),
    model = 
    {
        "models/TSBB/Animals/Rat.mdl",
        "models/TSBB/Animals/Rat2.mdl"
    },
    description = [[Vous êtes un rat qui se balade sur le site, vous craignez les humains et donc vous évitez les endroits à découvert et bien sur les humains ,mais cela vous empêches pas de les embêter un petit peu. Survivez et restez sur vos gardes.]],
    weapons = {
        "swep_rat"
    },
    command = "rat",
    donator = 1,
    level = 1,
    max = 2,
    salary = 1,
    admin = 0,
    vote = false,
    modelScale = 0.4,
    hasLicense = false,
    category = "Civil",
    candemote = false,
    runspeed = runspeed * 2,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == "swep_rat" end,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply,20)
    end,
})

// intru
TEAM_SOLDAT = DarkRP.createJob("Soldat", {
    color = Color(5, 180, 255),
    model = model_intru,
    description = [[Vous êtes un soldat d'un groupe d'intérêt, votre but pour la plupart du temps sera de foutre un gros bordel dans la fondation.]],
    weapons = {
        
    },
    command = "soldat",
    max = 5,
    salary = 100,
    admin = 0,
    vote = false,
    category = "Civil",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 27,
})

TEAM_MASTOGDI = DarkRP.createJob("Soldat Mastodonte", {
    color = Color(5, 180, 255),
    model = model_masto_gdi,
    description = [[Vous êtes un soldat d'un groupe d'intérêt, votre but pour la plupart du temps sera de foutre un gros bordel dans la fondation.]],
    weapons = {
        lvl3,
        radio,
        "arccw_firearms2_m249"
    },
    command = "mastogdi",
    max = 1,
    salary = 400,
    admin = 0,
    vote = false,
    category = "Civil",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_masto, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, 180)
        
        ply:SetSkin(4)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 29,
    donator = 2,
})

TEAM_SERGENT  = DarkRP.createJob("Sergent", {
    color = Color(5, 180, 255),
    model = model_intru,
    description = [[Vous êtes un membre d'un groupe d'intérêt, vous êtes le sergent du groupe, vous dirigez vos hommes durant les opérations lancées.]],
    weapons = {

    },
    command = "sergent",
    max = 1,
    salary = 110,
    admin = 0,
    vote = false,
    category = "Civil",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 28,
})

TEAM_BRASDROIT = DarkRP.createJob("Bras droit", {
    color = Color(5, 180, 255),
    model = model_intru,
    description = [[Vous êtes un membre d'un groupe d'intérêt, vous êtes le bras droit de votre chef, vous l'aidez et l'épaulez lors de ses opérations.]],
    weapons = {
    },
    command = "brasdroit",
    max = 1,
    salary = 200,
    admin = 0,
    vote = false,
    category = "Civil",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 29,
})

TEAM_CHEFTINTERET = DarkRP.createJob("Chef Groupe d'intérêt", {
    color = Color(5, 180, 255),
    model = model_intru,
    description = [[Vous êtes un membre d'un groupe d'intérêt, vous gérez et organisez des attaques contre la fondation.]],
    weapons = {
    },
    command = "chefinteret",
    max = 1,
    salary = 250,
    admin = 0,
    vote = false,
    category = "Civil",
    candemote = false, 
    model_zombie = "models/zombies/pyri_pm/zombie_marine_pm.mdl",
    runspeed= runspeed * force_ait, 
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100, it_armor)

        ArcticNVGs_SetPlayerGoggles(ply, nv_quadtube_pro)
        give_gaz_mask(ply)
    end,
    level = 32,
    whitelist = "principale",
})
-- ============= SCP ==================
--safe 
TEAM_131 = DarkRP.createJob("SCP 131", {
    color = Color(5, 180, 255),
    model = model_131,
    description = [[.]],
    weapons = {
        
    },
    command = "131",
    max = 2,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 300)
        
    end,
    level = 5,
    donator = 1,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == "" end
})

TEAM_202 = DarkRP.createJob("SCP 202", {
    color = Color(5, 180, 255),
    model = model_citizen,
    description = [[.]],
    weapons = {
        
    },
    command = "202",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 150)
        
    end,
    level = 5,
})

TEAM_999 = DarkRP.createJob("SCP 999", {
    color = Color(5, 180, 255),
    model = model_999,
    description = [[.]],
    weapons = {
        swep_999
    },
    command = "999",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)

    end,
    level = 5,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_999 end
})

-- euclide
TEAM_049 = DarkRP.createJob("SCP 049", {
    color = Color(5, 180, 255),
    model = model_049,
    description = [[.]],
    weapons = {
        swep_049
    },
    command = "049",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100)

    end,
    level = 10,
})

TEAM_087 = DarkRP.createJob("SCP 087", {
    color = Color(5, 180, 255),
    model = model_costard,
    description = [[.]],
    weapons = {
        swep_087
    },
    command = "087",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)

        ply:SetNoDraw(true)
    end,
    level = 10,
})

TEAM_073 = DarkRP.createJob("SCP 073", {
    color = Color(5, 180, 255),
    model = model_073,
    description = [[.]],
    weapons = {
        
    },
    command = "073",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)

    end,
    level = 10,
    donator = 1,
})

TEAM_096 = DarkRP.createJob("SCP 096", {
    color = Color(5, 180, 255),
    model = model_096,
    description = [[.]],
    weapons = {
        swep_096
    },
    command = "096",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 120)

    end,
    level = 10,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_096 end
})

TEAM_457 = DarkRP.createJob("SCP 457", {
    color = Color(5, 180, 255),
    model = model_457,
    description = [[.]],
    weapons = {
        swep_457
    },
    command = "457",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)

    end,
    level = 10,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_457 end
})

TEAM_966 = DarkRP.createJob("SCP 966", {
    color = Color(5, 180, 255),
    model = model_966,
    description = [[.]],
    weapons = {
        swep_966
    },
    command = "966",
    max = 3,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 500)

    end,
    level = 10,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_966 end
})

TEAM_006fr = DarkRP.createJob("SCP 006fr", {
    color = Color(5, 180, 255),
    model = model_006fr,
    description = [[.]],
    weapons = {
        "tfa_mw2019_knife"
    },
    command = "006fr",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2000)

    end,
    level = 10,
})

TEAM_079 = DarkRP.createJob("SCP 079", {
    color = Color(255, 5, 5),
    model = model_costard,
    description = [[Vous avez une accréditation de niveau 4 et n'êtes pas classifié comme membre du personnel. vous êtes l'intelligence artificielle du site, vous gérez le site sous les ordres des directeurs de branches, vous aidez aussi à protéger aussi le site.]],
    weapons = {

    },
    command = "079",
    max = 1,
    salary = 50,
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)

        ply:SetMaterial("models/wireframe")
        ply:SetColor(Color(0, 0, 0))
    end,
    level = 10,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_079 or weapon:GetClass() == tablet_ads end
})

TEAM_527 = DarkRP.createJob("SCP 527", {
    color = Color(5, 180, 255),
    model = model_527,
    description = [[.]],
    weapons = {
        
    },
    command = "527",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100)

    end,
    level = 10,
    donator = 1,
})

TEAM_173 = DarkRP.createJob("SCP 173", {
    color = Color(5, 180, 255),
    model = model_173,
    description = [[.]],
    weapons = {
        swep_173
    },
    command = "173",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)
    end,
    level = 10,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_173 end
})

-- keter
TEAM_SCP106 = DarkRP.createJob("SCP 106", {
    color = Color(5, 180, 255),
    model = model_106,
    description = [[.]],
    weapons = {
        swep_106
    },
    command = "106",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)
    end,
    level = 15,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_106 end,
    walkspeed = walkspeed * force_106,
    runspeed = runspeed * force_106,
    jumppower = jumppower * force_106,
})

TEAM_682 = DarkRP.createJob("SCP 682", {
    color = Color(5, 180, 255),
    model = model_682,
    description = [[.]],
    weapons = {
        swep_682
    },
    command = "682",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)
    end,
    level = 15,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_682 end
})

TEAM_939 = DarkRP.createJob("SCP 939", {
    color = Color(5, 180, 255),
    model = model_939,
    description = [[.]],
    weapons = {
        swep_939
    },
    command = "939",
    max = 2,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,

    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 5000)

    end,
    level = 15,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_939 end
})

TEAM_1983pro = DarkRP.createJob("SCP 1983pro", {
    color = Color(5, 180, 255),
    model = model_1983pro,
    skins = {1},
    bodygroups = {
        ["head_chains"] = {1},
        ["arms_chains"] = {1},
    },
    description = [[.]],
    weapons = {
        swep_1983pro
    },
    command = "1983pro",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)

    end,
    level = 15,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_1983pro end,
    runspeed = runspeed * force_1983,
    walkspeed = runspeed * force_1983, // when left scp can't run anymore. fault to the swep
    jumppower = jumppower * force_1983,
})

TEAM_1048 = DarkRP.createJob("SCP 1048", {
    color = Color(5, 180, 255),
    model = model_1048,
    description = [[.]],
    weapons = {
        swep_1048
    },
    command = "1048",
    max = 1,
    salary = 50, -- pour tout scp
    admin = 0,
    vote = false,
    category = "SCP",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 100)

    end,
    level = 15,
    donator = 1,
    PlayerLoadout = function(ply) return true end, -- to not have default weapons.
    PlayerCanPickupWeapon = function(ply, weapon) return weapon:GetClass() == swep_1048 end
})
--====================== STAFF =================================
TEAM_STAFF = DarkRP.createJob("Membre du personnel Process", {
    color = Color(5, 180, 255),
    model = model_citizen,
    description = [[Vous êtes membre du personnel Process.]],
    weapons = {
        restrains,
        ia_swep,
        lvl5,
        tablet_ads,
        tablet_logi,
        sig_sauer,
    },
    command = "staff",
    max = 0,
    salary = 50,
    admin = 0,
    vote = false,
    category = "Staff",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply, 2147483647)
    end,
    immunity = 15,
})

TEAM_RO5 = DarkRP.createJob("Représentant de l'O5", {
    color = Color(255, 5, 5),
    model = model_costard,
    description = [[Vous êtes un membre de classe B et accrédité niveau 4. Vous êtes un individu envoyé sur l'Installation par le Haut-Commandement O5, dans un but bien précis.]],
    weapons = {
        lvl4
    },
    command = "ro5",
    max = 0,
    salary = 300,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Staff",
    candemote = false,
    PlayerSpawn = function(ply)
        give_health_and_armor(ply)
    end,
    level = 32,
    immunity = 20,
})
--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_D

------------------------- create custom check -----------------
hook.Add("Initialize", "Process.darkrp.jobs.lua", function () -- wait Initialization of GAS.JobWhitelist.CanAccessJob 
    -- create job permission
    for _, job in pairs(RPExtraTeams) do
        job.level = job.level or 0
        job.donator = job.donator or 0
        job.immunity = job.immunity or 1
        
        job.walkspeed = job.walkspeed or walkspeed
        job.runspeed = job.runspeed or runspeed
        job.jumppower = job.jumppower or jumppower
    
        function job.customCheck(ply)
            local same_job_count = 0
            for _, ply in pairs(player.GetAll()) do
                if (job == ply:getJobTable()) then
                    same_job_count = same_job_count + 1
                end
            end

            if (
                (job.max <= same_job_count and job.max != 0) or
                ply:Team() == job.team or
                ply:getDarkRPVar(process.darkrp.vars.level) < job.level or
                ply:getDarkRPVar(process.darkrp.vars.donator) < job.donator or 
                sam.ranks.get_immunity(ply:GetUserGroup()) < job.immunity or 
                (job.team == TEAM_ASR and process.ASR.can_call())
            ) then
                return false
            end
    
            return true
        end
    
        function job.CustomCheckFailMsg(ply)
            if ( ply:Team() == job.team ) then
                return "Vous êtes déjà "..job.name
            end
            
            local same_job_count = 0
            for _, ply in pairs(player.GetAll()) do
                if (job == ply:getJobTable()) then
                    same_job_count = same_job_count + 1
                end
            end
            if (job.max <= same_job_count and job.max != 0) then
                return "Il n'y a plus de place pour ce job."
            end

            if (sam.ranks.get_immunity(ply:GetUserGroup()) < job.immunity) then
                return "Membre du personnel process requis"
            end
            
            if (ply:getDarkRPVar(process.darkrp.vars.donator) < job.donator) then
                return "Donateur requis"
            end
            
            if (ply:getDarkRPVar(process.darkrp.vars.level) < job.level) then
                return "Niveau "..job.level.." requis"
            end

            if (job.team == TEAM_ASR and process.ASR.can_call()) then
                return "Un agent du service de ravitaillement n'est pas requis"
            end

            return "Vous n'êtes pas sur la list blanche ".. (job.whitelist or "joueur") // if not whitelisted with GAS whitelist module
        end
    end

    local jobs_with_no_collid = format_team_table(TEAM_IAA, TEAM_079, TEAM_STAFF)
    local jobs_with_noclip = format_team_table(TEAM_IAA, TEAM_079, TEAM_SCP106)

    -- job changed
    local class_d_teams = process.to_if_check_table(TEAM_D, TEAM_CONTRAVANCE, TEAM_CONTR)
    hook.Add( "PlayerChangedTeam", "Process.darkrp.change_team", function ( ply, oldTeam, newTeam )
        if CLIENT then return end
        -- reset mat
        ply:SetMaterial("")
        ply:SetColor(color_white)

        -- default name when choosing a scp
        local old_job = RPExtraTeams[oldTeam]
        local new_job = RPExtraTeams[newTeam]

        if class_d_teams[newTeam] then  
            local name = "D-"..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)
            ply:setRPName(name)                             
        elseif (new_job and new_job.category == "SCP") then
            if (new_job.max == 1) then
                ply:setRPName(new_job.name, false)
            else
                local same_job_count = 1
                for _, other_ply in pairs(player.GetAll()) do
                    if (other_ply:getJobTable() == new_job) then
                        same_job_count = same_job_count + 1
                    end
                end
                
                ply:setRPName(new_job.name.."-"..same_job_count, false)
            end
        end
    end)

    -- job with niclip
    hook.Add("PlayerNoClip", "Process.darkrp.job_with_noclip", function (ply)
        if (ply:Team() == TEAM_IAA or (ply:Team() == TEAM_079 and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == swep_079)) then
            return true
        end
    end)
    
    hook.Add( "PlayerSpawn", "Process.darkrp.player_spawn", function ( ply)
        -- run and walk speed
        timer.Simple(0, function () -- must be one tick later.
            local job = RPExtraTeams[ply:Team()]
            ply:SetWalkSpeed(job.walkspeed)
            ply:SetRunSpeed(job.runspeed)
            ply:SetJumpPower(job.jumppower)

            if (jobs_with_no_collid[ply:Team()]) then
                ply:SetCollisionGroup(COLLISION_GROUP_WORLD)
            end
        end)
    end )
    
    hook.Add("PlayerDeath", "Process.darkrp.set_default_job", function (ply)
        -- default team when respawn
        if (ply:Team() != GAMEMODE.DefaultTeam) then
            ply:changeTeam( GAMEMODE.DefaultTeam, true )
        end
        if (ply:Team() == TEAM_RAT) then
            ply:GetRagdollEntity():SetModelScale(ply:getJobTable().modelScale)
        end
    end)    
end)
