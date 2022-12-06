local labo_cabinet = process.labo_cabinet
local net_name = labo_cabinet.net_name

util.AddNetworkString(net_name)

net.Receive(net_name, function (len, ply)
    if process.ASR.is_empty(ply) then return end

    for _, ent in pairs(ents.GetAll()) do
        if (ent:GetPos():Distance(ply:GetPos()) < process.config.min_distance_armor_locker) then
            local cabinet_weapon = labo_cabinet.weapons[net.ReadUInt(16)]
            if (!cabinet_weapon) then
                return
            end
            
            local weapon = ply:GetWeapon(cabinet_weapon.weapon)
            if (!IsValid(weapon)) then
                weapon = ply:Give(cabinet_weapon.weapon)

                if (!IsValid(weapon)) then return end // failed to give the weapon
            end

            local ammo_type = weapon:GetPrimaryAmmoType()
            if (ammo_type == -1) then // if weapon has no ammo system
                return
            else
                ply:SetAmmo(cabinet_weapon.max - weapon:GetMaxClip1(), ammo_type)
                weapon:SetClip1(weapon:GetMaxClip1())
            end

            return 
        end
    end
end)

function ENT:Use(ply)
    if ply:IsPlayer() then 
        net.Start(net_name)
        net.Send(ply)
    end
end

function ENT:Initialize()
    self:SetModel( "models/gta_prop_michou/v_med_lab_fridge.mdl" )
    
    self:SetUseType(SIMPLE_USE)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:PhysWake()
end