AddCSLuaFile()

ENT.Type                     = "anim"
ENT.Base                     = "base_entity"
ENT.RenderGroup              = RENDERGROUP_TRANSLUCENT

ENT.PrintName                = "Caisse de Munition infinie"
ENT.Category                 = "Process"

ENT.Spawnable                = true

function ENT:Initialize()
    self:SetModel("models/items/ammocrate_smg1.mdl")

    if SERVER then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self:PhysWake()
    end
end

if SERVER then
    local exception_ammo = process.config.ammo_crate_exception_ammo

    hook.Add("Initialize", "Process.ammo_box_disable_weapons_ammo_in_labo_cabinet", function ()
        for _, weapon_info in pairs(process.labo_cabinet.weapons) do
            exception_ammo[weapon_info.weapon] = 0
        end

        for _, weapon in pairs(GAMEMODE.Config.DefaultWeapons) do
            exception_ammo[weapon] = 0
        end
    end)

    function ENT:Use(ply)
        if !ply:IsPlayer() then return end

        if process.ASR.is_empty(ply) then return end
        
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
            ply:GiveAmmo(math.Clamp(max_ammo - ammo_count, 0, max_ammo), ammotype ) -- give ammo play a sound and not setammo
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

                local ammo = max_ammo
                if ammo then
                    w = surface.GetTextSize("×" .. ammo)
                    surface.SetTextPos(-w / 2, 25)
                    surface.DrawText("×" .. ammo)
                end
            cam.End3D2D()
        end
    end
end