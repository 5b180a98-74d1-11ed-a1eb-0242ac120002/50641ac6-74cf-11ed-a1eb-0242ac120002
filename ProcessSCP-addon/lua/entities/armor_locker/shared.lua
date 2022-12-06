AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Armurerie"
ENT.Author = "Zekirax"
ENT.Category = "Process"

ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel( "models/craphead_scripts/armory_robbery2/armory.mdl" )
    
	if SERVER then
        self:SetUseType(SIMPLE_USE)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self:PhysWake()
    end 
end

process.load_script("entities/armor_locker/locker/sh_armor_locker.lua", true)

process.load_script("entities/armor_locker/uits_locker/sh_armor_locker_uits.lua", true)

process.load_script("entities/armor_locker/sv_ent_use.lua", true)