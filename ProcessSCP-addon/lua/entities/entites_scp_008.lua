AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "SCP 008 Activator"
ENT.Author = "BIBI"
ENT.Category = "Process scp"

ENT.Spawnable = true
ENT.AdminSpawnable = true

local timer_infection_name = "008_check_infection"

function ENT:Initialize()
	self:SetModel( "models/hunter/plates/plate075x075.mdl" )

	self:SetRenderMode(4)
	self:SetColor( Color( 0, 0, 0, 0 ) )

	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end

	if CLIENT then return end

	local scp008_door
	for _, ent in pairs(ents.GetAll()) do
		if (ent:GetInternalVariable("m_iName") == "008_containment_door") then
			scp008_door = ent
			break 
		end
	end

	timer.Create(timer_infection_name, 2, 0, function ()
		if (scp008_door:GetInternalVariable("m_toggle_state") == 0) then // 0 : open, 1 : closed, other : in animation
			for _, ent in pairs(ents.FindInSphere(self:GetPos(), 120)) do
				if (ent:IsPlayer()) then
					if !process.scp.is_impervious_to_disease(ent) and !ent.IsTurningZombie then
						process.TimerCreateTurning(0, ent)
					end
				end
			end
		end
	end)
end

function ENT:OnRemove()
	timer.Remove(timer_infection_name)
end