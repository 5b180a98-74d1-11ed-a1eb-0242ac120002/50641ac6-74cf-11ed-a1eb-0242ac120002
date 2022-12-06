local responsive_factor = math.min(ScrW() / 1920, ScrH() / 1080)

local net_name = process.armor_locker.net_name
local weapon_var = process.armor_locker.var_weapon_class_index
local class_var = process.armor_locker.var_class

local background_mat = Material("armor_locker/background.png")
local return_mat = Material("armor_locker/return.png")
local left_mat = Material("armor_locker/left.png")
local right_mat = Material("armor_locker/right.png")
local selected_mat = Material("armor_locker/selected.png")
local close_mat = Material("armor_locker/close.png")

surface.CreateFont("process.armor_locker", {
    font = "Jura Medium",
    size = 35 * responsive_factor,
    weight = 400 * responsive_factor
})
surface.CreateFont("process.armor_locker_weapon_name", {
    font = "Jura Medium",
    size = 70 * responsive_factor,
    weight = 400 * responsive_factor
})

local background 

hook.Add("Think", "process.armor_locker_escape", function ()
    if (input.IsKeyDown(KEY_ESCAPE)) then
        if (IsValid(background)) then
            background:Remove()
        end
    end
end)

local function get_weapon_image(weapon_name)
    local mat=Material("vgui/entities/process/"..weapon_name..".png","smooth")
    if mat:GetName()=="___error" then mat=Material("entities/"..weapon_name..".png","smooth")end
    if mat:GetName()=="___error" then mat=Material("vgui/entities/"..weapon_name..".png","smooth")end

    return mat
end

net.Receive(net_name, function ()
    process.f4_menu.play_sound("open")
    
    local owned_weapons = {}
    for _, weapon in pairs(LocalPlayer():GetWeapons()) do
        if (weapon:GetNWInt(class_var)) then
            owned_weapons[{weapon:GetNWInt(class_var), weapon:GetNWInt(weapon_var)}] = weapon:GetClass()
        end
    end
    
    local selected_weapon_class_index = 1
    
    background = vgui.Create("DImage")
    background:SetMaterial(background_mat)
    background:SetSize(ScrW(), ScrH())
    background:MakePopup()
    local old_background_paint = background.Paint

    for class_group_index, class_group in pairs(process.armor_locker.weapons) do
        for _, job in pairs(class_group.jobs) do
            if (LocalPlayer():Team() == job) then
                local function class_layout()
                    background:Clear()

                    local job_img = background:Add("DImage")
                    job_img:SetImage(class_group.image)
                    job_img:SetSize(128 * responsive_factor, 128 * responsive_factor)
                    job_img:SetPos(600 * responsive_factor, 20 * responsive_factor)
                    
                    local close_button = background:Add("DButton")
                    close_button:SetMaterial(close_mat)
                    close_button:SetSize(100 * responsive_factor, 100 * responsive_factor)
                    close_button:SetPos(background:GetWide() - 10 * responsive_factor - close_button:GetWide(), 10 * responsive_factor)
                    close_button.Paint = nil
                    close_button:SetText("")
                    function close_button:DoClick()
                        process.f4_menu.play_sound("click")
                        
                        background:Remove()
                    end
                    
                    local container = background:Add("EditablePanel")
                    container:SetPos(164 * responsive_factor, 202 * responsive_factor)
                    container:SetSize(ScrW() - container:GetX() * 2, ScrH() - container:GetY() * 2)
                    container:Clear()
                    
                    local class_button_spacing = 31 * responsive_factor
                    local class_button_width = (container:GetWide() - (#class_group - 1) * 31 * responsive_factor) / #class_group
                    for class_index, class in ipairs(class_group) do
                        local class_button = container:Add("DButton")
                        class_button:SetSize(class_button_width, container:GetTall())
                        class_button:SetPos((class_index - 1) * (class_button_spacing + class_button_width), 0)
                        class_button:SetFont("process.armor_locker")
                        class_button:SetText(class.name)
                        class_button:SetTextColor(Color(255, 255, 255, 255))
                        
                        local start_time = CurTime()
                        function class_button:Paint(w, h)
                            local lerp = Lerp((CurTime() - start_time - (class_index - 1) * 0.2) / 0.3, 0, h)
                            draw.RoundedBox(0, 0, h - lerp, w, lerp, Color(35, 31, 32, 150))
                        end
                        function class_button:DoClick()
                            process.f4_menu.play_sound("click")
                            
                            for _, panel in pairs(container:GetChildren()) do
                                panel:AlphaTo(0, 0.5, 0, function (_, panel)
                                    panel:Remove()
                                end)

                                if (panel.models) then
                                    for _, model in pairs(panel.models) do
                                        model.start_anim = CurTime()
                                    end
                                end
                            end
                            
                            local return_button = background:Add("DButton")
                            return_button:SetSize(198 * responsive_factor, 100 * responsive_factor)
                            return_button:SetPos(background:GetWide() - return_button:GetWide() - 15 * responsive_factor, background:GetTall() - return_button:GetTall() - 15 * responsive_factor)
                            return_button:SetMaterial(return_mat)
                            return_button.Paint = nil
                            function return_button:DoClick()
                                process.f4_menu.play_sound("click")
                                
                                class_layout()
                            end
                            
                            local model_layout = background:Add("DImage")
                            model_layout:SetMaterial(get_weapon_image(class.weapons[1].name))
                            model_layout:SetSize(300 * responsive_factor, 300 * responsive_factor)
                            model_layout:SetPos((background:GetWide() - model_layout:GetWide()) / 2, (background:GetTall() - model_layout:GetTall()) / 2)
                            
                            local start_time = CurTime()
                            function model_layout:Think()
                                self:SetImageColor(Color(255, 255, 255, Lerp((CurTime() - start_time) / 0.5, 0, 255)))
                            end
                            
                            local selected_weapon = 1
                            local select_button = background:Add("DButton")
                            select_button:SetSize(700 * responsive_factor, 60 * responsive_factor)
                            select_button:SetPos((background:GetWide() - select_button:GetWide()) / 2, background:GetTall() - select_button:GetTall() - 30 * responsive_factor)
                            select_button:SetFont("process.armor_locker")
                            select_button:SetTextColor(color_white)
                            function select_button:Paint(w, h)
                                draw.RoundedBox(0, 0, 0, w, h, Color(35, 31, 32, 150))
                                for _, owned_wep in pairs(LocalPlayer():GetWeapons()) do
                                    if (owned_wep:GetClass() == class.weapons[selected_weapon].name) then
                                        select_button:SetText("possédé")
                                        select_button:SetCursor("arrow")
                                        return
                                    end
                                end
                                
                                select_button:SetCursor("hand")

                                if (LocalPlayer():getDarkRPVar("money") < class.weapons[selected_weapon].price) then
                                    select_button:SetText("Vous n'avez pas assez")                                    
                                else
                                    select_button:SetText(class.weapons[selected_weapon].price == 0 and "sélectionner" or  "acheter "..class.weapons[selected_weapon].price.."$")
                                end
                            end
                            function select_button:DoClick()
                                process.f4_menu.play_sound("click")
                                
                                for _, owned_wep in pairs(LocalPlayer():GetWeapons()) do
                                    if (owned_wep:GetClass() == class.weapons[selected_weapon].name) then
                                        return
                                    end
                                end
                                
                                net.Start(net_name)
                                
                                net.WriteUInt(class_group_index, 8)
                                net.WriteUInt(class_index, 8)
                                net.WriteUInt(selected_weapon_class_index, 8)
                                net.WriteUInt(selected_weapon, 8)
                                
                                net.SendToServer()
                                
                                for key, owned_wep in pairs(owned_weapons) do
                                    if (key[1] == class_index and key[2] == selected_weapon_class_index) then
                                        owned_weapons[key] = nil
                                        break
                                    end
                                end
                                owned_weapons[{class_index, selected_weapon_class_index}] = class.weapons[selected_weapon].name
                                
                                class_layout()

                                selected_weapon_class_index = 1
                            end
                            
                            local total_wide = (class.limit - 1) * 10 * responsive_factor + 187 * responsive_factor * class.limit 
                            local start_pos_x = (select_button:GetWide() - total_wide) / 2 + select_button:GetX()
                            for i = 1, class.limit do 
                                local class_weapon = background:Add("DImageButton")
                                class_weapon:SetSize(150 * responsive_factor, 150 * responsive_factor)
                                class_weapon:SetPos(start_pos_x + (i - 1) * (10 * responsive_factor + 187 * responsive_factor), select_button:GetY() - class_weapon:GetTall() - 10 * responsive_factor)

                                for key, owned_wep in pairs(owned_weapons) do
                                    if (key[1] == class_index and key[2] == i) then
                                        class_weapon:SetMaterial(get_weapon_image(owned_wep))
                                        break
                                    end
                                end

                                local old_paint = class_weapon.Paint
                                function class_weapon:Paint(w, h)
                                    draw.RoundedBox(0, 0, 0, w, h, Color(35, 31, 32, 150))
                                    if (selected_weapon_class_index == i) then
                                        surface.SetDrawColor(Color(255, 255, 255, 100))
                                        surface.SetMaterial(selected_mat)
                                        surface.DrawTexturedRect(0, 0, w * 0.8, h)
                                    end
                                    
                                    old_paint(self, w, h)
                                end
                                function class_weapon:DoClick()
                                    process.f4_menu.play_sound("click")
                                    
                                    selected_weapon_class_index = i
                                end
                            end
                            
                            local left = background:Add("DButton")
                            left:SetText("")
                            left:SetSize(40 * responsive_factor, 100 * responsive_factor)
                            left:SetPos(27 * responsive_factor, (background:GetTall() - left:GetTall() * responsive_factor) / 2)
                            left:SetMaterial(left_mat)
                            left.Paint = nil
                            function left:DoClick()
                                process.f4_menu.play_sound("click")
                                
                                selected_weapon = (selected_weapon - 1) % #class.weapons 
                                selected_weapon = selected_weapon == 0 and #class.weapons or selected_weapon
                                model_layout:SetMaterial(get_weapon_image(class.weapons[selected_weapon].name))
                            end
                            
                            local right = background:Add("DButton")
                            right:SetText("")
                            right:SetSize(44 * responsive_factor, 100 * responsive_factor)
                            right:SetPos(background:GetWide() - (left:GetX() + right:GetWide()), (background:GetTall() - right:GetTall()) / 2)
                            right:SetMaterial(right_mat)
                            right.Paint = nil
                            function right:DoClick()
                                process.f4_menu.play_sound("click")
                                
                                selected_weapon = (selected_weapon + 1) % (#class.weapons + 1)
                                selected_weapon = selected_weapon == 0 and 1 or selected_weapon
                                model_layout:SetMaterial(get_weapon_image(class.weapons[selected_weapon].name))
                            end

                            function background:Paint(w, h)
                                old_background_paint(self, w, h)

                                if (IsValid(close_button)) then
                                    draw.SimpleText(process.get_weapon_print_name(class.weapons[selected_weapon].name) or "", "process.armor_locker_weapon_name", close_button:GetX() - 50 * responsive_factor, 10 * responsive_factor, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
                                end
                            end        
                        end

                        class_button.models = {}

                        local model_width = class_button:GetWide() / class.limit / 1.5
                        local start_pos = (class_button:GetWide() - model_width * class.limit) / 2
                        for i = 1, class.limit do
                            local button_model = class_button:Add("DImage")
                            table.insert(class_button.models, button_model) // to remove
                            button_model:SetSize(model_width, model_width)
                            button_model:SetPos(start_pos + (i - 1) * model_width, class_button:GetTall() - button_model:GetTall())
                            function button_model:Think(ent)
                                if (self.start_anim) then
                                    self:SetImageColor(Color(255, 255, 255, Lerp((CurTime() - self.start_anim) / 0.5, 255, 0)))
                                end                                
                            end
                            function button_model:DoClick()
                                process.f4_menu.play_sound("click")
                                
                                self:GetParent():DoClick()
                            end

                            for key, owned_wep in pairs(owned_weapons) do
                                if (key[1] == class_index and key[2] == i) then
                                    button_model:SetMaterial(get_weapon_image(owned_wep))
                                    break
                                end
                            end
                        end
                    end
                end

                class_layout()

                return
            end
        end
    end
end)

