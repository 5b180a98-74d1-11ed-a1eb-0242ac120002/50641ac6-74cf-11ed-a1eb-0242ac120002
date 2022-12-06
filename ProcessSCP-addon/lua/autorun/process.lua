--[[
infos sur l'addon process : 
    cl_edgescoreboard.lua utilise des modifications de l'addon "edgescoreboard". (voir détails dans le fichier)

    les module de sam utilise l'addon "sam". 
    modification de sam :
        La langue par défaut n'est plus anglais mais français.(traduction partiel. partie encore en anglais)
    
    les keycards perso se trouve dans les weapons de l'addon guthscpkeycard

    addons/darkrp-city-worker/lua/darkrp_modules/cityworker job désactivé

    dans addons/zeros_bloodlab_3.0.2/lua/ :
        darkrp_modules/zblood/sh_zbl_darkrp.lua job par défaut désactivé et autorisé le entity que pour le staff
        sh_zbl_config_main.lua job autorisé à utilise l'addon = TEAM_STAFF

    dans bodygroupr-master/lua/bodyman/bodyman_server.lua :
        ajouter à chaque tentative de changer le model : if (hook.Run("is_model_modification_blocked", ply, model_index)) then return end
        ajouter à chaque tentative de changer le skin : if (hook.Run("is_skin_modification_blocked", ply, skin_index)) then return end
        ajouter à chaque tentative de changer le bodygroup : if (hook.Run("is_bg_modification_blocked", ply, bodygroup_data)) then return end
]]

print("ProcessCommunity started")

-- create global process table
process = process or {} -- maybe defined in jobs.lua for models
process.darkrp = process.darkrp or {} -- maybe defined in jobs.lua for models
process.darkrp.vars = {}
process.pins = {}
process.squad_group = {}
process.config = {} -- shared config
process.credits = {}
process.tablet = {}
process.armor_locker = {}
process.scp = {}
process.ASR = {} // pour le job Agent du sérvice de ravitaillement
process.labo_cabinet = {}

if (SERVER) then
    process.SQL = {}-- for now sql is only used server side
    
    // server side config
    process.config.increments_point_delay = 150 -- in second (default : 300)
    
    process.config.ammo_crate_exception_ammo = {
        ["tfa_csgo_smoke"] = 3,
        ["tfa_csgo_incen"] = 3,
        ["tfa_csgo_frag"] = 3,
        ["tfa_csgo_flash"] = 3,
        ["weapon_slam"] = 3,
        ["stungun"] = 0,
        ["arccw_firearms2_m82"] = 10,
        ["weapon_bm_sg_deployer_180"] = 2,
    }

    process.config.anti_spam_delay = 0.5
    process.config.armor_delay = 600 // 10 minutes
    
    process.config.min_distance_armor_locker = 500
    
    process.config.scan_bio_duration = 180 // in second
    process.config.scan_bio_delay = 1800 // 30 minute in second

    process.config.microphone_distance = 60

    process.config.armor_reload_delay = 600

    process.config.ASR_crate_filling_amount = 0.25
    process.config.ASR_empty_delay = 60 * 60 * 2.5 // 2 heures et demi pour que ça soit vide
    process.config.ASR_timer_execution_count_before_empty = 100 // it will remove 1 percent each time
    process.config.ASR_gain = 200 // 200 if they fill all
    process.config.ASR_min_player = 25

    process.config.IC_keycard_delay = 3 // delay to try to open a door
end

process.config.ASR_delay_to_call_asr = 60 * 30 // 30 minutes

if (CLIENT) then
    process.edgescoreboard = {}
    process.f4_menu = {}

    -- color of process community
    process.black = Color(38, 50, 57)
    process.orange = Color(255, 183, 77)
    process.white = Color(228, 230, 235)
    process.hud_alpha = 255 -- used to make a hud fade

    -- client config
    process.config.distance_to_see_pseudo_in_hud = 110
end

-- load script
local file_types = {
    sh = function(path)
        if SERVER then
            AddCSLuaFile(path)
        end

        include(path)
    end,
    sv = SERVER and include or function() end,
    cl = SERVER and AddCSLuaFile or include
}

function load_script(path, not_in_process_folder)
    path = not_in_process_folder and path or "process/"..path
    file_types[path:GetFileFromFilename():sub(1, 2)](path)
end process.load_script = load_script

function load_directory(path, not_sub_directory, not_in_process_folder) -- useful when no order to load script
    local path = not_in_process_folder and path or "process/"..path
    local files, directories = file.Find(path.."*", "LUA")

    for i, file in ipairs(files) do
        load_script(path..file, true)
    end

    if (not_sub_directory) then
        return
    end

    for i, directory in ipairs(directories) do
        load_directory(directory.."/", false, true)
    end
end process.load_directory = load_directory

// load all functions before
load_script("functions/sh_other.lua")
load_script("functions/sh_scp.lua")
load_script("functions/sh_UI.lua")

load_directory("", true)

load_directory("process_vgui_elements/")
load_directory("donator/")
load_directory("level/")
load_directory("pins/")
load_directory("darkrp/")
load_directory("scan_bio/")
load_directory("guthscpkeycard/")
load_directory("effects/")

load_script("hud/cl_stencil_mask.lua")
load_script("hud/cl_material-avatar.lua")
load_script("hud/cl_hud.lua")
load_script("hud/cl_mtk_hud.lua")

load_script("f4_menu/cl_f4_menu_constant.lua")
load_script("f4_menu/cl_draw_rotated.lua")
load_script("f4_menu/cl_f4.lua")
load_directory("f4_menu/vgui_elements/")

-- credits all
local credits_msg = ""
for _, credit in ipairs(process.credits) do
    credits_msg = credits_msg..credit..", "
end
print("Credits :  "..credits_msg)

-- end msg
print("ProcessCommunity is ready")