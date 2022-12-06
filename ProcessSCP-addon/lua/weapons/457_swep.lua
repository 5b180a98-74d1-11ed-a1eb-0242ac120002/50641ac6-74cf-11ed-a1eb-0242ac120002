AddCSLuaFile()

SWEP.Author			= "Fred"
SWEP.Purpose		= "Vous etes SCP 457, enflammer les entités autour de vous pour gagner en matière et obtenir une conscience."
SWEP.Instructions	= "Appuyer sur le clic gauche pour tirer un objet enflammé qui explose sur les joueurs touchés.\nAppuyer le clic droit pour enflammer toutes les entités au-delà de votre porté d'ignition naturelle. (60s de CD)"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.PrintName		= "SCP 457"
SWEP.Category 			    = "Process scp"
SWEP.Slot					= 2
SWEP.SlotPos				= 4
SWEP.HoldType		= "normal"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true

SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false

SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
-- SWEP.SnapSound		= Sound( "snap.wav" )

SWEP.AttackDelay	= 0.25
SWEP.ISSCP 			= true
SWEP.droppable		= false
SWEP.NextAttackW	= 0

SWEP.IgniteProps = {}

SWEP.MakeFireBall = 0
SWEP.MakeFireBallDel = CurTime()

SWEP.PhysBall = NULL

SWEP.BallPos   = 0
SWEP.SecDelay  = CurTime()
SWEP.PrimDelay = CurTime()
SWEP.ReloadDelay = CurTime()

SWEP.FireEffect = CurTime()
SWEP.FireDie    = 0

SWEP.ShootFireBall = 0

SWEP.Ball = NULL

SWEP.ColorR = 255
SWEP.ColorG = 255
SWEP.ColorB = 5

SWEP.PlyHealth = NULL
SWEP.WepUse = 1

SWEP.SecAttack = 0

SWEP.FartTrail = CurTime()

SWEP.RangeSetOnFire = 120

function SWEP:Precache()
util.PrecacheSound("ambient/fire/ignite.wav")
util.PrecacheSound("ambient/fire/mtov_flame2.wav")
util.PrecacheSound("fireball/fireball.wav")
end


function SWEP:Deploy()
	
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
	
	self:UpdateNextIdle()
	
	if ( SERVER ) then
		self:SetCombo( 0 )
	end
	
	return true
end
function SWEP:DrawWorldModel()
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end
function SWEP:Holster()
	return false
end
function SWEP:CanPrimaryAttack()
	return false
end
function SWEP:HUDShouldDraw( element )
	local hide = {
		CHudAmmo = true,
		CHudSecondaryAmmo = true,
	}
	if hide[element] then return false end
	return true
end

function SWEP:Think()

	local vm = self:GetOwner():GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()
	
	if ( idletime > 0 && CurTime() > idletime ) then
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )
		self:UpdateNextIdle()
	end


	if self.WepUse == 1 then
		self.Weapon:EmitSound("ambient/fire/ignite.wav")
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetOwner():GetPos() )			
		util.Effect( "FireSpawn", effectdata )
		self.WepUse = 0
	end 
------------GUIDING FIREBALL
	if self:GetOwner():KeyDown(IN_USE) == true and  self.MakeFireBall == 1 then

if (SERVER) then

local trace = {}
trace.start = self:GetOwner():GetShootPos()
trace.endpos = trace.start + (self:GetOwner():GetAimVector() * 99999)
trace.filter = { self:GetOwner(), self.Weaponm,}
local tr = util.TraceLine( trace )
local NotFireball = tr.Entity

if self.Ball ~= NotFireball then


	local tr = util.GetPlayerTrace( self:GetOwner() )
	local trace = util.TraceLine( tr )
	if (!trace.Hit) then return end


			local Vec = trace.HitPos - self.Ball:GetPos()
			Vec:Normalize()

		local speed = self.Ball:GetPhysicsObject():GetVelocity()
			self.Ball:GetPhysicsObject():SetVelocity( (Vec *20) + speed )
end
end
end
------------------------GUIDING FIRE BALL END

	if self.ShootFireBall == 1 and self.MakeFireBallDel < CurTime() then

			self.ShootFireBall = 0
			self.MakeFireBall = 1
				local fball = ents.Create("prop_physics")
				self.Ball = fball
				self.Ball:SetModel("models/dav0r/hoverball.mdl")				
				self.Ball:SetAngles(self:GetOwner():EyeAngles())
				self.Ball:SetPos(self:GetOwner():GetShootPos()+(self:GetOwner():GetAimVector()*20))
				self.Ball:SetOwner(self:GetOwner())
				self.Ball:SetPhysicsAttacker(self:GetOwner())			
				self.Ball:SetMaterial("models/debug/debugwhite")
				self.Ball:Spawn()
					self.PhysBall = self.Ball:GetPhysicsObject()
					self.Ball:EmitSound("fireball/fireball.wav")
					self.PhysBall:SetMass(10)
					self.PhysBall:ApplyForceCenter(self:GetOwner():GetAimVector() * 10000)
					self.Ball:Fire("kill", "", 2)				
					self.FireEffect  = CurTime()+2				
	end
---------
	if (self.FireEffect - 1.8) < CurTime() and self.Ball ~= nil and self.Ball ~= NULL then self.Ball:Ignite( 20, 1000 ) end

	if self.FireEffect > CurTime() then

	self.BallPos = self.PhysBall:GetPos()					
			local effectdata = EffectData()
			effectdata:SetOrigin( self.BallPos )			
			util.Effect( "FireBall", effectdata )
			
			self.Ball:SetColor(Color(255, 153, 0, 0))
			IgniteProps = ents.FindInSphere( self.Ball:GetPos(), 50)

				for i=1,100 do 
				if IgniteProps[i] ~= nil and IgniteProps[i] ~= NULL and IgniteProps[i] ~= self:GetOwner() then
				if string.find(IgniteProps[i]:GetClass(), "prop_physics") or string.find(IgniteProps[i]:GetClass(), "prop_vehicle_*") or string.find(IgniteProps[i]:GetClass(), "prop_ragdoll") or string.find(IgniteProps[i]:GetClass(), "npc_*")then
				IgniteProps[i]:Ignite( 5, 50)
				end
				end
				end
end
-------------
 if CurTime() > (self.FireEffect-0.3) and self.MakeFireBall==1 and self.Ball:IsValid() then self.Ball:Ignite( 10, 1000 ) end
 if CurTime() > (self.FireEffect-0.2) and self.MakeFireBall==1 and self.Ball:IsValid() then self.FireDie = self.FireDie+1 end

			if self.FireDie == 1  and self.Ball ~= nil and self.Ball ~= NULL then			
				
				self.MakeFireBall = 0			
				self.FireDie = 20
				self.Ball:EmitSound("ambient/fire/ignite.wav")

				local effectdata = EffectData()
				effectdata:SetOrigin( self.BallPos )
				util.Effect( "FireDie", effectdata )								

				IgniteProps = ents.FindInSphere( self.Ball:GetPos(), 100)
				for i=1,4 do 
				if IgniteProps[i] ~= nil and IgniteProps[i] ~= NULL then
				IgniteProps[i]:Ignite( 0.3, 10)
				end
				end
							local FireExp = ents.Create("env_physexplosion")
							FireExp:SetPos(self.Ball:GetPos())
							FireExp:SetKeyValue("magnitude", 200)
							FireExp:SetKeyValue("radius", 200)
							FireExp:SetKeyValue("spawnflags", "1")
							FireExp:Spawn()
							FireExp:Fire("Explode", "", 0)
							FireExp:Fire("kill", "", 1)
			end
--------------------
if self.SecAttack == 1 then

			self.SecAttack = 0

			self.Weapon:EmitSound("ambient/fire/ignite.wav")
			local effectdata = EffectData()
			effectdata:SetOrigin( self:GetOwner():GetPos() )			
			util.Effect( "FireExplosion", effectdata )
		
				IgniteProps = ents.FindInSphere( self:GetOwner():GetPos(), 200)
				

			local FireExp = ents.Create("env_physexplosion")
			FireExp:SetPos(self:GetOwner():GetPos())
			FireExp:SetParent(self:GetOwner())
			FireExp:SetKeyValue("magnitude", 200)
			FireExp:SetKeyValue("radius", 500)
			FireExp:SetKeyValue("spawnflags", "1")
			FireExp:Spawn()
			FireExp:Fire("Explode", "", 0)
			FireExp:Fire("kill", "", 2)

				for i=1,100 do 

				if IgniteProps[i] ~= nil and IgniteProps[i] ~= NULL then
				if string.find(IgniteProps[i]:GetClass(), "prop_physics") or string.find(IgniteProps[i]:GetClass(), "prop_vehicle_*") or string.find(IgniteProps[i]:GetClass(), "prop_ragdoll") or string.find(IgniteProps[i]:GetClass(), "npc_*")then
				IgniteProps[i]:Ignite( 20, 10)
				end
				end	
			    end
end
-----------------
if self.FartTrail > CurTime() then
		
			local effectdata = EffectData()
			effectdata:SetOrigin( self:GetOwner():GetPos() )			
			util.Effect( "FireTrail", effectdata )
end
-----------------
	if SERVER then
		if self:GetOwner():HasWeapon("weapon_scp457") then
		self:GetOwner():Ignite(0.1,100) end
		for i,k in pairs(ents.FindInSphere( self:GetOwner():GetPos(), self.RangeSetOnFire )) do
			if k:IsPlayer() then
				local weapon = k:GetActiveWeapon()
				if weapon and weapon.ISSCP then continue end

				k:Ignite(1,50)
			end
		end
	end
end
function SWEP:PreDrawViewModel( vm, wep, ply )

	vm:SetMaterial( "engine/occlusionproxy" ) -- Hide that view model with hacky material

end

SWEP.HitDistance = 48

function SWEP:SetupDataTables()
	
	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )
	self:NetworkVar( "Int", 2, "Combo" )
	
end


function SWEP:UpdateNextIdle()

	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() )
	
end

function SWEP:PrimaryAttack( right )

			self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
			local anim = "fists_left"
	if ( right ) then anim = "fists_right" end
	if ( self:GetCombo() >= 2 ) then
		anim = "fists_uppercut"
	end

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.2 )
	
	self:SetNextPrimaryFire( CurTime() + 2.5 )
	self:SetNextSecondaryFire( CurTime() + 2.5 )

	if self.PrimDelay < CurTime() then		
		self.PrimDelay = CurTime()+2.5


		if SERVER then	
			
			self.Weapon:EmitSound("ambient/fire/mtov_flame2.wav")		
					self.ShootFireBall = 1
					self.FireDie = 0		
					self.MakeFireBallDel = CurTime()+0.3

		end
	end

	local anim = "fists_left"
	if ( right ) then anim = "fists_right" end
	if ( self:GetCombo() >= 2 ) then
		anim = "fists_uppercut"
	end

end

function SWEP:SecondaryAttack()
	self.Weapon:EmitSound("ambient/fire/ignite.wav")
	if SERVER then
		for k, c in pairs(ents.FindInSphere(self:GetOwner():GetPos(), 200)) do
			if c:GetClass() != "func_door" and c != self:GetOwner() and c:GetOwner() != self:GetOwner() then
				self:ShootEffects()
				c:Ignite(1)
			end
		end
		self.Weapon:SetNextSecondaryFire( CurTime() + 60 )
    end
end

function SWEP:Reload()
end 

function SWEP:OnRemove()
	
	if ( IsValid( self:GetOwner() ) ) then
		local vm = self:GetOwner():GetViewModel()
		if ( IsValid( vm ) ) then vm:SetMaterial( "" ) end
	end
	
end

function SWEP:Holster( wep )

	self:OnRemove()

	return true

end



hook.Add("PlayerShouldTakeDamage","Fire dmg prevert",function(victim,att)
	if att and att:GetClass() == "entityflame" and victim:GetActiveWeapon():GetClass() == "weapon_scp457" then
		return false
	end
end)