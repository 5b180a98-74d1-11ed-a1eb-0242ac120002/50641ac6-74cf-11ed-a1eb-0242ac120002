AddCSLuaFile()
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Delay = 2
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Delay = 2
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "None"
SWEP.Weight = 3
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.UseHands = false
SWEP.Author = "BIBI & Zekirax"
SWEP.Purpose = "Vous infectez les personnes que vous touchez, répandez l'infection au plus de monde possible."
SWEP.Category = "Process scp"
SWEP.Instructions = "Appuyer sur le clic gauche pour infecter les joueurs.\nAppuyer le clic droit pour hurler."
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/scp_008/v_zombiearms.mdl"
SWEP.WorldModel = ""
SWEP.PrintName = "SCP 008"
SWEP.HoldType = "fist"
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.healthregen = 1


SWEP.AttackAnims = {ACT_VM_SECONDARYATTACK, ACT_VM_HITCENTER}

SWEP.WorldAnim = {ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL, ACT_GMOD_GESTURE_RANGE_ZOMBIE}

SWEP.HitSound = {
	[0] = "npc/zombie/zombie_hit.wav",
	[1] = "npc/zombie/claw_strike2.wav",
	[2] = "npc/zombie/claw_strike3.wav",
}

SWEP.MissSound = {
	[0] = "npc/fast_zombie/claw_miss2.wav",
	[1] = "npc/fast_zombie/claw_miss1.wav",
}

SWEP.TimerCheckTurning = {
	[0] = 15,
	[1] = 15,
	[2] = 5,
	[3] = 10,
	[4] = 15,
	[5] = 60,
	[6] = 60,
	[7] = 60,

}

SWEP.jobNotAffected = {---- Jobs that cannot be infected.
"IAA",
"UIAA",
"Membre du personnel Process",
"Mastodonte FIM",
"UIAA Lourde"
}

function SWEP:Initialize()
    self:SetHoldType("knife")
end

function SWEP:Holster()
    return true
end

function SWEP:OnRemove()
	self:SetColor( Color(255, 255, 255, 255) )
end

-- Allows to hit uninfected players and infect them if hit.
function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
    tr = {}
    tr.start = ply:GetShootPos()
    tr.endpos = ply:GetShootPos() + (ply:GetAimVector() * 75)
    tr.filter = ply
    tr.mask = MASK_SHOT
    trace = util.TraceLine(tr)
	if SERVER then
		if (trace.Hit) then
			ply:EmitSound(self.HitSound[math.random( 0,#self.HitSound -1 )], 75)
			if trace.Entity:IsPlayer() then
				local victim = trace.Entity
				if !victim:HasWeapon("008_swep") or !process.scp.is_impervious_to_disease(ent, self.jobNotAffected) then
					bullet = {}
					bullet.Num = 1
					bullet.Src = ply:GetShootPos()
					bullet.Dir = ply:GetAimVector()
					bullet.Spread = Vector(0, 0, 0)
					bullet.Tracer = 0
					bullet.Force = 1
					bullet.Damage = 30
					bullet.Distance = 75
					ply:FireBullets(bullet)
					-- Start timer if a non-infected player is hit
					if !victim.IsTurningZombie and !process.scp.is_impervious_to_disease(victim) then
						process.TimerCreateTurning(0, victim)
					end
				end
			end
		else
			ply:EmitSound(self.MissSound[math.random( 0,#self.MissSound -1 )], 95)
		end
	end

    ply:DoAnimationEvent(table.Random(self.WorldAnim))
    self.Weapon:SendWeaponAnim(self.AttackAnims[math.random(1, 2)])
    self.Weapon:SetNextPrimaryFire(CurTime() + 1.5)
end

-- Make the player scream.
function SWEP:SecondaryAttack()
	local ply = self:GetOwner()
	if SERVER then
		ply:EmitSound("npc/zombie/zombie_pain"..math.random(1,6)..".wav")
		self.Weapon:SetNextSecondaryFire(CurTime() + 2.5)
	end
end

-- Regenerates the player's health points every 5 seconds.
function SWEP:Think()
    local ply = self:GetOwner()
    local health = ply:Health()

	ply:SetHealth(math.Clamp(health + self.healthregen, 0, ply:GetMaxHealth()))
	self.Weapon:NextThink( CurTime() + 5 )
end