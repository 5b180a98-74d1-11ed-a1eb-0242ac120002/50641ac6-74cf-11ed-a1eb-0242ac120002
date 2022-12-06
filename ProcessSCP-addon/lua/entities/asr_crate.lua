AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "asr caisse"
ENT.Author = "Zekigras"
ENT.Category = "Process"

ENT.Spawnable = true
ENT.AdminSpawnable = true

if (SERVER) then
	local ASR = process.ASR // voir weapon tablet_logi

	local models = {
		"models/props_blackmesa/bms_metalcrate_48x48.mdl",
		"models/props_junk/warehouse_pallet02_static.mdl"
	}
	
	function ENT:Initialize()
		self:SetModel( models[math.random(1, #models)] )
	
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:PhysWake()
	end
	
	function ENT:Touch(ent) // will be called a few times before self:Remove() is effective so I add self.touched
		if (ent:GetClass() == "asr_crate_end_point" and !self.touched and ASR.get_filled() != 100) then
			local filled = ASR.get_filled() + process.config.ASR_crate_filling_amount

			local gain
			if (filled > 1) then
				gain = (1 - ASR.get_filled()) * process.config.ASR_gain

				ASR.set_filled(1)
			else
				gain = process.config.ASR_crate_filling_amount * process.config.ASR_gain

				ASR.set_filled(filled)
			end

			for _, ply in pairs(player.GetAll()) do
				if (ply:Team() == TEAM_ASR) then
					ply:addMoney(gain)
				end
			end

			self.touched = true
			self:Remove()
		end
	end
end
