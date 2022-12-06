//-----------------------------------------//
//           SWEP INITIALISATION           //
//-----------------------------------------// 

SWEP.Category               = "Process"

SWEP.PrintName              = "Menu Animation"
SWEP.Author                 = "Endrow"

SWEP.Instructions           = "Clique gauche pour ouvrir le menu d'animation."

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

SWEP.Slot		    = 4
SWEP.SlotPos		    = 2
SWEP.DrawAmmo		    = false
SWEP.DrawCrosshair	    = false


SWEP.ViewModel 		    = ""
SWEP.WorldModel             = ""
SWEP.ViewModelFlip          = false
SWEP.UseHands               = false

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:SecondaryAttack() return false end

SWEP.net_name = "process.animation"

// -- List of the animations
// -- Animation from https://steamcommunity.com/sharedfiles/filedetails/?id=1274995014 
animation_table = {
    // -- Bras dans le dos
    [1] = {["ValveBiped.Bip01_R_UpperArm"] = Angle(3.809, 15.382, 2.654),
            ["ValveBiped.Bip01_R_Forearm"] = Angle(-63.658, 1.8 , -84.928),
            ["ValveBiped.Bip01_L_UpperArm"] = Angle(3.809, 15.382, 2.654),
            ["ValveBiped.Bip01_L_Forearm"] = Angle(53.658, -29.718, 31.455),
            ["ValveBiped.Bip01_R_Thigh"] = Angle(4.829, 0, 0),
            ["ValveBiped.Bip01_L_Thigh"] = Angle(-8.89, 0, 0),},
    // -- Bras croisés
    [2] = {["ValveBiped.Bip01_R_Forearm"] = Angle(-43.779933929443,-107.18412780762,15.918969154358),
            ["ValveBiped.Bip01_R_UpperArm"] = Angle(20.256689071655, -57.223915100098, -6.1269416809082),
            ["ValveBiped.Bip01_L_UpperArm"] = Angle(-28.913911819458, -59.408206939697, 1.0253102779388),
            ["ValveBiped.Bip01_R_Thigh"] = Angle(4.7250719070435, -6.0294013023376, -0.46876749396324),
            ["ValveBiped.Bip01_L_Thigh"] = Angle(-7.6583762168884, -0.21996378898621, 0.4060270190239),
            ["ValveBiped.Bip01_L_Forearm"] = Angle(51.038677215576, -120.44165039063, -18.86986541748),
            ["ValveBiped.Bip01_R_Hand"] = Angle(14.424224853516, -33.406204223633, -7.2624106407166),
            ["ValveBiped.Bip01_L_Hand"] = Angle(25.959447860718, 31.564517974854, -14.979378700256),},
    // -- Salut militaire
    [3] = {["ValveBiped.Bip01_R_UpperArm"] = Angle(80, -95, -77.5),
            ["ValveBiped.Bip01_R_Forearm"] = Angle(35, -125, -5),},
    // -- Se rendre
    [4] = {["ValveBiped.Bip01_L_Forearm"] = Angle(25,-65,25),
            ["ValveBiped.Bip01_R_Forearm"] = Angle(-25,-65,-25),
            ["ValveBiped.Bip01_L_UpperArm"] = Angle(-70,-180,70),
            ["ValveBiped.Bip01_R_UpperArm"] = Angle(70,-180,-70),},
    // -- Doigt d'honneur
    [5] = {["ValveBiped.Bip01_R_UpperArm"] = Angle(15,-55,-0),
            ["ValveBiped.Bip01_R_Forearm"] = Angle(0,-55,-0),
            ["ValveBiped.Bip01_R_Hand"] = Angle(20,20,90),
            ["ValveBiped.Bip01_R_Finger1"] = Angle(20,-40,-0),
            ["ValveBiped.Bip01_R_Finger3"] = Angle(0,-30,0),
            ["ValveBiped.Bip01_R_Finger4"] = Angle(-10,-40,0),
            ["ValveBiped.Bip01_R_Finger11"] = Angle(-0,-80,-0),
            ["ValveBiped.Bip01_R_Finger31"] = Angle(0,-80,0),
            ["ValveBiped.Bip01_R_Finger41"] = Angle(0,-80,0),
            ["ValveBiped.Bip01_R_Finger12"] = Angle(-0,-80,-0),
            ["ValveBiped.Bip01_R_Finger32"] = Angle(0,-80,0),
            ["ValveBiped.Bip01_R_Finger42"] = Angle(0,-80,-0),},
    // -- Lever la main
    [6] = {["ValveBiped.Bip01_L_Forearm"] = Angle(25,-65,25),
            ["ValveBiped.Bip01_L_UpperArm"] = Angle(-70,-180,70),}
}


process.load_script("weapons/anim_swep/cl_animation_swep.lua", true)
process.load_script("weapons/anim_swep/sv_animation_swep.lua", true)