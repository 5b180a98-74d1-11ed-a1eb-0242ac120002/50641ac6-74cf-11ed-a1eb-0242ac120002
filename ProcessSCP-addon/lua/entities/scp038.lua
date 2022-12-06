AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "SCP_038"
ENT.Author = "Zekirax"
ENT.Category = "Process scp"

ENT.Spawnable = true
ENT.AdminSpawnable = true

local grow_duration = 180 // 3 minutes

function ENT:Initialize()
	self:SetModel( "models/props/de_inferno/tree_small.mdl" )
    
	if SERVER then
        self:SetUseType(SIMPLE_USE)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self:PhysWake()
    end  
end

local anti_spam = SysTime()
function ENT:Use(ply)
    if anti_spam + 3 > SysTime() then return end
    anti_spam = SysTime()
    
    if(!ply:IsPlayer()) then return end

    local weapon = ply:GetActiveWeapon()
    if(!IsValid(weapon)) then return end

    if GAMEMODE.Config.DisallowDrop[weapon:GetClass()] then return end

    local model = (weapon:GetModel() == "models/weapons/v_physcannon.mdl" and "models/weapons/w_physics.mdl") or weapon:GetModel()
    model = util.IsValidModel(model) and model or "models/weapons/w_rif_ak47.mdl"
    
    local new_fruit = ents.Create("floating_ent")
    new_fruit:SetModel(model)
    new_fruit:SetSkin(weapon:GetSkin() or 0)
    new_fruit:SetPos(self:GetPos() + Vector(math.random(-30, 30), math.random(35, -35), math.random(180, 300)))
    new_fruit.weapon_class = weapon:GetClass()

    new_fruit:SetParent(self)

    new_fruit:SetModelScale(0)
    new_fruit:SetModelScale(1, grow_duration)
    
    timer.Simple(grow_duration, function ()
        if (IsValid(new_fruit)) then
            local fruit = ents.Create(new_fruit.weapon_class)
            fruit:SetPos(new_fruit:GetPos())
            fruit:SetModel(new_fruit:GetModel())
            fruit:SetSkin(new_fruit:GetSkin())
            fruit:Spawn()
            
            new_fruit:Remove()     
        end
    end)
end
