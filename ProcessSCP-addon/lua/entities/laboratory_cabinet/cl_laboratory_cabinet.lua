local labo_cabinet = process.labo_cabinet
local net_name = labo_cabinet.net_name

local scale_factor = 1.0
local responsive_factor = math.min(ScrW() / 1920, ScrH() / 1080) * scale_factor

local frame_size = { x = 500 * responsive_factor, y = 700 * responsive_factor }

local button_margin = 10 * responsive_factor
local button_size = {x = frame_size.x - button_margin * 2, y = 100}

net.Receive(net_name, function ()
    local frame = vgui.Create("Process.Frame")
    frame:MakePopup()
    frame:SetPos((ScrW() - frame_size.x) / 2, (ScrH() - frame_size.y) / 2)
    frame:SizeTo(frame_size.x, frame_size.y, 0.5)

    local scroll_bar = frame:AddToBody("Process.scroll_bar")
    scroll_bar:Dock(FILL)

    local layout = scroll_bar:Add("DIconLayout")
    layout:Dock(FILL)
    layout:SetSpaceY(button_margin)

    for weapon_info_index, weapon_info in pairs(process.labo_cabinet.weapons) do
        local weapon_button = layout:Add("Process.armor_locker_button")
        weapon_button:SetSize(button_size.x, button_size.y)
        weapon_button:SetFont("Process.armor_locker_label")

        local weapon = LocalPlayer():GetWeapon(weapon_info.weapon)
        local ammo_count
        if (IsValid(weapon)) then
            local ammo_type = weapon:GetPrimaryAmmoType()
            if (ammo_type == -1) then // if no ammo
                ammo_count = 1
                weapon_button.too_expensive = true
            else
                ammo_count = LocalPlayer():GetAmmoCount(ammo_type) + weapon:Clip1()
                weapon_button.too_expensive = ammo_count >= weapon_info.max
            end
        else
            ammo_count = 0
        end

        function weapon_button:DoClick()
            if (!weapon_button.too_expensive) then
                net.Start(net_name)
                net.WriteUInt(weapon_info_index, 16)
                net.SendToServer()

                weapon_button:SetText(process.get_weapon_print_name(weapon_info.weapon).." "..weapon_info.max.."/"..weapon_info.max)
                weapon_button.too_expensive = true
            end
        end

        weapon_button:SetText(process.get_weapon_print_name(weapon_info.weapon).." "..ammo_count.."/"..weapon_info.max)
    end
end)

function ENT:Draw()
    self:DrawModel()

    if (EyePos() - self:GetPos()):LengthSqr() <= 262144 then -- 512^2
        local ang = LocalPlayer():EyeAngles()

        ang:RotateAroundAxis(ang:Forward(), 180)
        ang:RotateAroundAxis(ang:Right(), 90)
        ang:RotateAroundAxis(ang:Up(), 90)

        local text = "Armoire laboratoire"
        local text_weight = surface.GetTextSize(text)


        local min, max = self:OBBMins(), self:OBBMaxs()
        local center = min + max * 0.5
        local test = LocalToWorld(center + Vector(max.x - min.x, 10, 20), Angle(0,0,0), self:GetPos(), self:GetAngles())
        cam.Start3D2D(test, ang, 0.2)
            surface.SetFont("Trebuchet24")

            surface.SetTextColor(color_white)
            
            surface.SetTextPos(-text_weight/2, 0)
            surface.DrawText(text)
        cam.End3D2D()
    end
end
