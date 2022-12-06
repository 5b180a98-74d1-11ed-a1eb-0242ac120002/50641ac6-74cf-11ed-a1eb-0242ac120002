SWEP.Category               = "Process"

SWEP.PrintName				= "Tablette Logistique"
SWEP.Author					= "Zekirax"

SWEP.Instructions			= "Clique gauche pour alumer."

SWEP.ViewModelFOV 			= 56

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Delay          = 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "None"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"

SWEP.Weight					= 1

SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true

SWEP.WorldModel = "models/nirrti/tablet/tablet_sfm.mdl"
SWEP.ViewModel    = "models/tablet/v_tablet.mdl"

SWEP.IdleAnim				= true

SWEP.UseHands           = true

local ASR = process.ASR

ASR.net_var_can_call_asr = "Process.asr.needed"
function ASR.can_call()
    return game.GetWorld():GetNWBool(ASR.net_var_can_call_asr)
end

ASR.net_var_filled = "Process.asr.filled"
function ASR.get_filled()
    return game.GetWorld():GetNWFloat(process.ASR.net_var_filled)
end

function ASR.is_empty(ply)
    if (ASR.get_filled() == 0) then
        if (ply) then
            ply:ChatPrint("Le site n'a pas été ravitaillé. Un agent du service de ravitaillement doit ravitailler le site.")
        end

        return true
    else
        return false
    end
end

ASR.net_name = "Process.asr"

process.load_script("weapons/tablet_logi/sv_tablet.lua", true)
process.load_script("weapons/tablet_logi/cl_tablet.lua", true)

process.load_script("weapons/tablet_ads/cl_world_model.lua", true)