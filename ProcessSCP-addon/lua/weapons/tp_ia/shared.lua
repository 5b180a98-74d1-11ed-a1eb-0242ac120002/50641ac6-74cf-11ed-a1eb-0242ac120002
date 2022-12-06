//-----------------------------------------//
//           SWEP INITIALISATION           //
//-----------------------------------------// 

SWEP.Category               = "Process"

SWEP.PrintName              = "TP IA"
SWEP.Author                 = "Endrow"

SWEP.Instructions           = "Clique gauche pour ouvrir le menu de TP."

SWEP.Spawnable              = true 
SWEP.AdminOnly              = false 

SWEP.Primary.Ammo           = "None"
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic	    = false

SWEP.Secondary.Ammo         = "None"
SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = 0
SWEP.Secondary.Automatic     = false


SWEP.Weight                 = 1
SWEP.AutoSwitchTo           = false 
SWEP.AutoSwitchFrom         = false

SWEP.Slot		        = 4
SWEP.SlotPos		    = 2
SWEP.DrawAmmo		    = false
SWEP.DrawCrosshair	    = false


SWEP.ViewModel 		    = ""
SWEP.WorldModel         = ""
SWEP.ViewModelFlip      = false
SWEP.UseHands           = false

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:SecondaryAttack() return false end

SWEP.net_name = "process.tpia"

tp_list = {
    [1] = Vector(-5898.145996, 10930.421875, -1580.398804), // class-D
    [2] = Vector(-7750.097656, 9462.191406, -1711.828857),// Scientist
    [3] = Vector(-5728.929199, 9110.499023, -1706.406616), // Guard post
    [4] = Vector(-3482.384277, 9123.029297, -1711.898804), // Zone stockage
    [5] = Vector(-7245.297363, 6881.917480, -2223.828857), // Bunker
    [6] = Vector(-5601.513672, 4918.814453, -1711.828857), // CheckPoint LCZ-->HCZ
    [7] = Vector(-4056.364990, 3776.811768, -1784.603027), // Generateur
    [8] = Vector(-5372.763184, 2835.268066, -1711.828857), // 035
    [9] = Vector(-11063.993164, 2999.673828, -39.968750), // 096
    [10] = Vector(-9676.876953, -164.044952, -1711.898804), // 008
    [11] = Vector(-7406.097168, -13.410476, -1711.828857), // CheckPoint HCZ-->LCZ
    [12] = Vector(-7598.287598, -6500.468750, -1711.968750), // Serveurs IA
    [13] = Vector(-5973.911621, -6831.231445, -1706.564453), // Bureau ADM
    [14] = Vector(-5334.721680, -6075.201172, -1707.968750), // QG IT
    [15] = Vector(-1929.974976, -5872.265137, -1711.968750), // Gate A
}

process.load_script("weapons/tp_ia/cl_tp_ia.lua", true)
process.load_script("weapons/tp_ia/sv_tp_ia.lua", true)
