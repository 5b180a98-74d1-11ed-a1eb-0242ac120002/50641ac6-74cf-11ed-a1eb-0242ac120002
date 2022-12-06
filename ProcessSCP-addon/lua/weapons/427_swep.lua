AddCSLuaFile()
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "None"
SWEP.Weight = 3
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Author = "Zekirax"
SWEP.Purpose = "Vous êtes SCP 427-1"
SWEP.Category = "Process scp"
SWEP.Instructions = "Appuyer sur le clic gauche pour attaquer une cible."
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.PrintName = "SCP 427"
SWEP.HoldType = "melee"
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.Range = 100

SWEP.HitSound = {
	[1] = "scp_939/bite_1.mp3",
	[2] = "scp_939/bite_2.mp3",
	[3] = "scp_939/bite_3.mp3",
}

SWEP.MissSound = {
	[1] = "npc/fast_zombie/claw_miss2.wav",
	[2] = "npc/fast_zombie/claw_miss1.wav",
}



function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
end

function SWEP:Holster()
    return true
end

-- Attacks a prey.
function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + 1.5)
	local ply = self:GetOwner()
    tr = {}
    tr.start = ply:GetShootPos()
    tr.endpos = ply:GetShootPos() + (ply:GetAimVector() * self.Range)
    tr.filter = ply
    tr.mask = MASK_SHOT
    trace = util.TraceLine(tr)
    victim = trace.Entity
	ply:SetAnimation(PLAYER_ATTACK1)
	if SERVER then
		if trace.Hit and
		victim:IsPlayer() and 
		(!victim:HasWeapon("427_swep")) then
			bullet = {}
			bullet.Num = 1
			bullet.Src = ply:GetShootPos()
			bullet.Dir = ply:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force = 1
			bullet.Damage = 40
			bullet.Distance = self.Range
			ply:FireBullets(bullet)
			ply:EmitSound(self.HitSound[math.random( 1,#self.HitSound )], 95)
		else
			ply:EmitSound(self.MissSound[math.random( 1,#self.MissSound )], 95)
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end