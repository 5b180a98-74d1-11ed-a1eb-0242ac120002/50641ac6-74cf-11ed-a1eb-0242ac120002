AddCSLuaFile()
SWEP.Author = "BIBI & Zekirax"
SWEP.Purpose = "Vous êtes SCP 1048, utiliser la matière et la chair de vos victimes pour faire des instances de 1048-A. (60s CD)"
SWEP.Instructions = "Appuyer sur le clic gauche pour transformer un joueur en 1048-A, il faut d'abord que la victime soit assomé et découper."
SWEP.Category = "Process scp"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrintName = "SCP 1048"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.HitSound = "npc/strider/creak1.wav"

SWEP.HoldType = "knife"

SWEP.AllowDrop = false

SWEP.PlayerRippedOff = false
SWEP.Delay = 1
SWEP.Range = 100
SWEP.Damage = 0
SWEP.IndexNumber = 0 -- position for increment number instance.
SWEP.NonTransformableJob = {---- Jobs that cannot be transform.
-- TODO Voir les jobs qui peuvent être transformé.
"IAA",
"UIAA",
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

-- Return actual increment number for instance name of SCP 1048.
local function IncrementNumber(ent)
	ent.IndexNumber = ent.IndexNumber + 1
	return ent.IndexNumber
end

function SWEP:Initialize()
    self:SetHoldType("knife")
end

-- First, stuns the player, then he must click again to cut the player's flesh (in RP), then he transforms the player (and wakes him up).
function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 2 )
    local ply = self.Owner
    local tr = util.TraceHull {
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * 50,
        filter = ply,
        mins = Vector(-10, -10, -10),
        maxs = Vector(10, 10, 10)
    }

    local victim = tr.Entity
    local vm = self:GetOwner():GetViewModel()
    if not IsValid(vm) then return end
    vm:SendViewModelMatchingSequence(vm:LookupSequence("attackch"))
    vm:SetPlaybackRate(1 + 1/3)
	if (SERVER) then
		if victim:IsPlayer() and !self.PlayerRippedOff then
			if table.HasValue(self.NonTransformableJob, team.GetName( victim:Team() )) or victim:HasWeapon("1048a_swep") then return end
			self:EmitSound(self.HitSound)
				ply:Say('/me rend inconscient l\'entité '..victim:GetName())
				DarkRP.toggleSleep(victim)
				self.PlayerRippedOff = victim
				self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
				timer.Create("unconscious_by_1048_"..victim:SteamID(), math.random(40,60), 1, function()
					if !IsValid(victim) then return end
					if victim.IsSleeping then
						DarkRP.toggleSleep(victim,"wake")
					end
					self.PlayerRippedOff = false
					victim.RippedOff = false
				end )
		elseif victim:IsRagdoll() then
			local player = self.PlayerRippedOff
			if (player:EntIndex() ~= victim.OwnerINT) then return end
			if (player.IsSleeping and !player.RippedOff) then
				player.RippedOff = true
				--  TODO mettre un son de frappe dans la chair (voir meat/flesh quelques choses)
				self.Owner:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(1,3)..".wav")
				ply:Say('/me commence à récupérer des éléments de chair sur l\'entité.')
				player:SetHealth(player:Health() * 0.1) -- If the player were to wake up, he would be very low in hp.
				self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
			elseif (player.IsSleeping and player.RippedOff) then
				DarkRP.toggleSleep(player,"wake")
				if timer.Exists("unconscious_by_1048_"..ply:SteamID()) then
					timer.Remove("unconscious_by_1048_"..ply:SteamID())
				end
				player:SetModel("models/1048/tdyear/tdybrownearpm.mdl")
				player:SetModelScale(1)
				player:StripWeapons()
				player:SetMaxHealth(150)
				player:SetHealth(150)
				player:Give("1048a_swep")
				player:Say('/rpname SCP 1048-A-'..IncrementNumber(self))
				self.PlayerRippedOff = false
				self.Weapon:SetNextPrimaryFire( CurTime() + 60 )
			end
		end
	end
end

-- TODO Ajouter un clic droit, un son, ou créer une entité de déssin ?
function SWEP:SecondaryAttack()
end

hook.Add("PlayerDeath", "revert_SCP1048a", function(ply)
	ply.RippedOff = false
	if ply.IsSleeping then
		DarkRP.toggleSleep(ply,"wake")
	end
	if timer.Exists("unconscious_by_1048_"..ply:SteamID()) then
		timer.Remove("unconscious_by_1048_"..ply:SteamID())
	end
end)