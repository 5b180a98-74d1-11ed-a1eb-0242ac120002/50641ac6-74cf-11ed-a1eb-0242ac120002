SWEP.Category 			    = "Process scp"
SWEP.PrintName				= "SCP 1048-A"
SWEP.Author					= "BIBI"
SWEP.Instructions = "Appuyer sur le clic gauche pour frapper les joueurs.\nAppuyer le clic droit pour hurler et blesser les joueurs aux alentours.\nPlus le joueur est proche plus les dégâts sont augmentés. (60s de CD)"
SWEP.ViewModelFOV = 56
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Delay          = 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "None"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 2
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= false
SWEP.IdleAnim				= true
SWEP.ViewModel				= "models/weapons/v_hands.mdl"
SWEP.WorldModel				= ""
SWEP.HoldType 				= "normal"
SWEP.ViewModelFlip      = false
SWEP.HitSound = {
	[0] = "npc/zombie/zombie_hit.wav",
	[1] = "npc/zombie/claw_strike2.wav",
	[2] = "npc/zombie/claw_strike3.wav",
}
SWEP.NonDamaging = {---- Jobs that cannot be attack.
-- TODO Voir les jobs qui peuvent être attaqué.
"IAA",
"SCP 999",
"SCP 131",
"SCP 049",
"SCP 096",
"SCP 457",
"SCP 966",
"SCP 079",
"SCP 205",
"SCP 173",
"SCP 106",
"SCP 682",
"SCP 939",
"SCP 1983pro",
"SCP 1048",
}

SWEP.NotAffectedScream = {---- Jobs that cannot be affected by the scream.
-- TODO Voir les jobs qui peuvent être affecté par le cris.
"IAA",
"UIAA",
"SCP 999",
"SCP 131",
"SCP 049",
"SCP 096",
"SCP 457",
"SCP 966",
"SCP 079",
"SCP 173",
"SCP 106",
"SCP 939",
"SCP 1048",
}

function SWEP:Initialize()
        self:SetWeaponHoldType( "normal" )
		self:SetHoldType("normal")
		reload = 1
end

function SWEP:PreDrawViewModel()
    return true
end

-- Simple knife wound.
function SWEP:PrimaryAttack()
	if (SERVER) then
		self.Weapon:SetNextPrimaryFire( CurTime() + 1 )
		tr = {}
		tr.start = self:GetOwner():GetShootPos()
		tr.endpos = self:GetOwner():GetShootPos() + (self:GetOwner():GetAimVector() * 75)
		tr.filter = self:GetOwner()
		tr.mask = MASK_SHOT
		trace = util.TraceLine(tr)
		local victim = trace.Entity

		if (trace.Hit) then
			if victim:IsPlayer() then
				-- Does not affect other instances of 1048 or SCP
				if table.HasValue(self.NonDamaging, team.GetName( victim:Team() )) or victim:HasWeapon("1048a_swep") then return end
					bullet = {}
					bullet.Num = 1
					bullet.Src = self:GetOwner():GetShootPos()
					bullet.Dir = self:GetOwner():GetAimVector()
					bullet.Spread = Vector(0, 0, 0)
					bullet.Tracer = 0
					bullet.Force = 1
					bullet.Damage = 30
					bullet.Distance = 90
					self:GetOwner():FireBullets(bullet) 
					self:GetOwner():EmitSound(self.HitSound[math.random( 0,#self.HitSound -1 )], 75)
			end
		else
			self:EmitSound( "Weapon_Knife.Slash" )
		end
	end
end


-- Makes a shout that affects all players within a circle of 200 units during 5s, those within 100 units suffer 10% of their current life every second.
-- Those between 100 and 200 units suffer 5% of their current life every second.
-- TODO Retester sur des vraies joueur, sur les bot , la condition or v:HasWeapon("1048a_swep") rend indetectable les bot à la boucle
function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire( CurTime() + 60 )
	self.Weapon:EmitSound("scp_1048/1048A_scream.wav",100)

	timer.Create("NextDammageScream"..self:GetOwner():SteamID(),1,5, function()
		if !IsValid(self:GetOwner()) then return end
		if (SERVER) then
			local trace = self:GetOwner():GetPos()
			local ents_in_shpere = ents.FindInSphere(trace, 200)
			for k,v in pairs(ents_in_shpere) do
				if v:IsPlayer() then
					if table.HasValue(self.NotAffectedScream, team.GetName( v:Team() )) or v:HasWeapon("1048a_swep") then return end
					-- TODO : Troubler la vision du joueur atteint quand il est touché.
					if(v:GetPos():Distance(self:GetOwner():GetPos()) <= 100) then
						v:TakeDamage(v:GetMaxHealth()/10)
					else
						v:TakeDamage(v:GetMaxHealth()/5)
					end
				end
			end
		end
	end )
end

hook.Add("PlayerDeath", "affected_by_SCP1048a", function(ply)
	ply:StopSound("player/breathe1.wav")
	if timer.Exists("NextDammageScream"..ply:SteamID()) then
		timer.Remove("NextDammageScream"..ply:SteamID())
	end
end)