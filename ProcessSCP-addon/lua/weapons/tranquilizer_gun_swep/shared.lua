AddCSLuaFile()

PrecacheParticleSystem("AC_muzzle_shotgun")
PrecacheParticleSystem("AC_muzzle_shotgun_db")
PrecacheParticleSystem("AC_muzzle_pistol_suppressed")
PrecacheParticleSystem("AC_muzzle_pistol_ejection")
PrecacheParticleSystem("AC_muzzle_pistol_smoke_barrel")
PrecacheParticleSystem("AC_muzzle_minigun_smoke_barrel")
include("animations.lua")
include("customization.lua")

if CLIENT then
    killicon.Add( "mg_romeo700", "VGUI/entities/mg_romeo700", Color(255, 0, 0, 255))
    SWEP.WepSelectIcon = surface.GetTextureID("VGUI/spawnicons/icon_cac_weapon_sn_romeo700")
end

SWEP.GripPoseParameters = {"grip_ang_offset", "grip_vert_offset", "grip_vertpro_offset", "grip_stockhvy_offset", "grip_stocktac_offset", "grip_stockskel_offset", "grip_stocksn_offset"}
SWEP.GripPoseParameters2 = {"grip_pistolgrip_offset"}

SWEP.Base = "mg_base" 

SWEP.PrintName = "Fusil tranquillisant"
SWEP.Category = "Process - Armes"
SWEP.SubCategory = "Fusils de précision"
SWEP.Spawnable = true
SWEP.VModel = Model("models/viper/mw/weapons/v_romeo700.mdl") 
SWEP.WorldModel = Model("models/viper/mw/weapons/w_romeo700.mdl") 
SWEP.Trigger = {
    PressedSound = Sound("mw19.sksierra.fire.first"),
    ReleasedSound = Sound("mw19.sksierra.disconnector"),
    Time = 0.03
}

SWEP.Slot = 3 
SWEP.HoldType = "Rifle"

SWEP.Primary.Sound = Sound("son_silencieux_remix.mp3")
game.AddAmmoType( {
	name = "tranquilizer_flechette",
	dmgtype = DMG_BULLET,
	tracer = TRACER_NONE,
	plydmg = 0,
	npcdmg = 0,
	force = 0,
	minsplash = 0,
	maxsplash = 0
} )
SWEP.Primary.Ammo = "tranquilizer_flechette"
SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = true
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 328  
SWEP.CanChamberRound = true
SWEP.CanDisableAimReload = false
SWEP.EmptyReloadRechambers = true
SWEP.Projectile = {
    Class = "mg_sniper_bullet", --bullet entity class
    Speed = 30000, 
    Gravity = 8,
    Penetrate = true
}
SWEP.ParticleEffects = {
    ["MuzzleFlash"] = "AC_muzzle_shotgun",
    ["MuzzleFlash_DB"] = "AC_muzzle_shotgun_db",
    ["MuzzleFlash_Suppressed"] = "AC_muzzle_pistol_suppressed",
    ["Ejection"] = "AC_muzzle_pistol_ejection", 
    ["Overheating"] = "AC_muzzle_pistol_smoke_barrel", 
}

/*SWEP.Reverb = { 
    RoomScale = 50000, --(cubic hu)
    --how big should an area be before it is categorized as 'outside'?

    Sounds = {
        Outside = {
            Layer = Sound("Atmo_Sniper.Outside"),
            Reflection = Sound("Reflection_Sniper.Outside")
        },

        Inside = { 
            Layer = Sound("Atmo_Shotgun.Inside"),
            Reflection = Sound("Reflection_Shotgun.Inside")
        }
    }
}*/

SWEP.Firemodes = {

    [1] = {
        Name = "Semi-Automatic",
        OnSet = function(self)
            self.Primary.Automatic = false
            return "Firemode_Semi"
        end
    },

}

SWEP.BarrelSmoke = {
    Particle = "AC_muzzle_minigun_smoke_barrel",
    Attachment = "muzzle",
    ShotTemperatureIncrease = 75,
    TemperatureThreshold = 100, --temperature that triggers smoke
    TemperatureCooldown = 65 --degrees per second
}

SWEP.Cone = {
    Hip = 1, --accuracy while hip
    Ads = 0.033, --accuracy while aiming
    Increase = 0.086, --increase cone size by this amount every time we shoot
    AdsMultiplier = 0.025, --multiply the increase value by this amount while aiming
    Max = 2.5, --the cone size will not go beyond this size
    Decrease = 1, -- amount (in seconds) for the cone to completely reset (from max)
    Seed = 6985 --just give this a random number
}

SWEP.Recoil = {
    Vertical = {7, 10}, --random value between the 2
    Horizontal = {-1.75, 2.75}, --random value between the 2
    Shake = 3, --camera shake
    AdsMultiplier = 0.05, --multiply the values by this amount while aiming
    Seed = 3584, --give this a random number until you like the current recoil pattern
}
SWEP.Bullet = {
    Damage = {102, 85}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
    EffectiveRange = 250, --in meters, damage scales within this distance
    DropOffStartRange = 30,
    Range = 300, --in meters, after this distance the bullet stops existing
    Tracer = false, --show tracer
    NumBullets = 1, --the amount of bullets to fire
    PhysicsMultiplier = 1.25, --damage is multiplied by this amount when pushing objects
    HeadshotMultiplier = 2,
    Penetration = {
        DamageMultiplier = 0.85, --how much damaged is multipled by when leaving a surface.
        MaxCount = 6, --how many times the bullet can penetrate.
        Thickness = 25, --in hu, how thick an obstacle has to be to stop the bullet.
    }
}

SWEP.Zoom = {
    FovMultiplier = 0.95,
    ViewModelFovMultiplier = 1,
    Blur = {
        EyeFocusDistance = 10
    }
}

SWEP.WorldModelOffsets = {
    Bone = "tag_sling",
    Angles = Angle(15,0,-180),
    Pos = Vector(9,-1,-1.5)
}

SWEP.ViewModelOffsets = {
    Aim = {
        Angles = Angle(0, 0, 0),
        Pos = Vector(0, 0, 0)
    },
    Idle = {
        Angles = Angle(0, 0, 0),
        Pos = Vector(0, 0, 0)
    },
    Inspection = {
        Bone = "tag_sling",
        X = {
            [0] = {Pos = Vector(0, 3, 3), Angles = Angle(40, 0, -30)},
            [1] = {Pos = Vector(0, 0, 0), Angles = Angle(-10, 0, 0)}
        },
        Y = {
            [0] = {Pos = Vector(0, 0, 0), Angles = Angle(-10, 20, 0)},
            [1] = {Pos = Vector(4, 0, 1.5), Angles = Angle(10, -20, 0)}
        }
    },
    
    RecoilMultiplier = 1,
    KickMultiplier = 1,
    AimKickMultiplier = 0.75
}

SWEP.Shell = {
    Model = Model("models/viper/mw/shells/vfx_shell_ar_lod0.mdl"),
    Scale = 1,
    Force = 150,
    SpinForce = 250,
    Sound = Sound("MW_Casings.308")
}

function SWEP:Projectiles()
    if (CLIENT) then
        return
    end

    if SERVER then
        local ent = ents.Create( "tranquilizer_dart" )
        if ( !IsValid( ent ) ) then return end

        local Forward = self:GetOwner():GetAimVector()

        ent:SetPos( self:GetOwner():GetShootPos() + Forward * 35 )
        ent:SetAngles( self:GetOwner():EyeAngles() + Angle(0, 48, 0))
        ent:SetOwner( self:GetOwner() )
        ent:Spawn()
        ent:Activate()

        ent:SetVelocity( Forward * 8000 )
    end
end