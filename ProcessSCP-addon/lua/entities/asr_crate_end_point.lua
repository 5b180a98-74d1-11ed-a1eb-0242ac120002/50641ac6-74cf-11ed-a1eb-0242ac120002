AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "asr conteneur"
ENT.Author = "Zekigras"
ENT.Category = "Process"

ENT.Spawnable = true
ENT.AdminSpawnable = true

local ASR = process.ASR // voir weapon tablet_logi

if (SERVER) then
	local models = {
		"models/props_industrial/warehouse_shelf001.mdl", "models/props_industrial/warehouse_shelf002.mdl", "models/props_industrial/warehouse_shelf003.mdl",
		"models/props_industrial/warehouse_shelf004.mdl"
	}
	
	function ENT:Initialize()
		self:SetModel( models[math.random(1, #models)] )
	
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:PhysWake()
	end
end
