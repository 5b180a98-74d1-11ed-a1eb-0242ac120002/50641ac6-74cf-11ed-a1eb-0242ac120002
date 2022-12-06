AddCSLuaFile()

ENT.Type                     = "anim"
ENT.Base                     = "base_entity"
ENT.RenderGroup              = RENDERGROUP_TRANSLUCENT

ENT.PrintName                = "Chargeurs de munitions"
ENT.Category                 = "Process"

ENT.Spawnable                = true

function ENT:Initialize()
    self.charge = 5
    self:SetModel("models/items/boxsrounds.mdl")

    if SERVER then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self:PhysWake()
    end
end

if SERVER then
    local exception_ammo = process.config.ammo_crate_exception_ammo // modified by a hook in process_infinite_ammo_box.lua

    function ENT:Use(ply)
        if !ply:IsPlayer() then return end
        
        local wep = ply:GetActiveWeapon()
        if (!IsValid(wep) or wep:GetMaxClip1() == 0) then
            return 
        end
        
        local max_ammo = exception_ammo[wep:GetClass()] or 300
        if (max_ammo == 0) then
            return
        end
        
        local ammotype = wep:GetPrimaryAmmoType()
        local ammo_count = ply:GetAmmoCount(ammotype)

        if ammo_count < max_ammo then
            ply:GiveAmmo(math.Clamp(wep:GetMaxClip1(), 0, max_ammo), ammotype ) -- give ammo play a sound and not setammo
            self.charge = self.charge - 1
            if (self.charge == 0) then
                self:Remove()
            end
        else
            ply:ChatPrint("Vous ne pouvez transporter que "..max_ammo.." munitions de ce type")
        end
    end
else
    function ENT:DrawTranslucent()
        self:Draw()
    end

    function ENT:Draw()
        self:DrawModel()

        if (EyePos() - self:GetPos()):LengthSqr() <= 262144 then -- 512^2
            local ang = LocalPlayer():EyeAngles()

            ang:RotateAroundAxis(ang:Forward(), 180)
            ang:RotateAroundAxis(ang:Right(), 90)
            ang:RotateAroundAxis(ang:Up(), 90)

            cam.Start3D2D(self:WorldSpaceCenter() + Vector(0, 0, (self:OBBMaxs().z - self:OBBMins().z) * 0.5 + 8) , ang, 0.1)
                surface.SetFont("Trebuchet24")

                local w = surface.GetTextSize(self.PrintName)

                surface.SetTextPos(-w / 2, 0)
                surface.SetTextColor(255, 255, 255, 255)
                surface.DrawText(self.PrintName)
            cam.End3D2D()
        end
    end
end