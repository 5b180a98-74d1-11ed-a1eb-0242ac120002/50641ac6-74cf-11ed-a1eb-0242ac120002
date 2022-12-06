SWEP.Category               = "Process"

SWEP.PrintName				= "Tablette ADS"
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

function SWEP:Initialize()
	self:SetHoldType('slam')
end

process.tablet.sounds = {}
local sounds = process.tablet.sounds

local sort_type = "nameasc"

local tablet_sounds_path = "sound/tablet_ads/"

local _, directories = file.Find(tablet_sounds_path.."*", "GAME", sort_type)

local all_sound_index = 1
for _, directory in pairs(directories) do
    if (CLIENT) then
        sounds[directory] = {}
    end

    for _, sound_file in pairs(file.Find(tablet_sounds_path..directory.."/*", "GAME", sort_type)) do
        if (SERVER) then
            table.insert(sounds, {path = 'tablet_ads/'..directory..'/'..sound_file, is_loop = directory == "alarmes"})
        else
            table.insert(sounds[directory], {name = string.match(sound_file, "(.+)%..+"), all_sound_index = all_sound_index}) -- get file name without exetension)
            all_sound_index = all_sound_index + 1
        end
    end
end

SWEP.net_name = "Process.tablet_ads.sounds"

process.load_script("weapons/tablet_ads/sv_tablet.lua", true)
process.load_script("weapons/tablet_ads/cl_html_files.lua", true) 
process.load_script("weapons/tablet_ads/cl_tablet.lua", true)
process.load_script("weapons/tablet_ads/cl_world_model.lua", true)