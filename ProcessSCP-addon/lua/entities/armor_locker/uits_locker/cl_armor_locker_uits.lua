local net_name = process.armor_locker.net_name_uits

net.Receive(net_name, function ()
    local scale_factor = 1.0
    local responsive_factor = math.min(ScrW() / 1920, ScrH() / 1080) * scale_factor
    local frame_size = { x = 400 * responsive_factor, y = 900 * responsive_factor }
    
    local frame = vgui.Create("Process.Frame")
    frame:MakePopup()
    frame:SetPos((ScrW() - frame_size.x) / 2, (ScrH() - frame_size.y) / 2)
    frame:SizeTo(frame_size.x, frame_size.y, 0.5)
    
    local class_names = {"paramedic", "explosif", "talos", "mastodonte", "bouclier", "sniper", "lance flamme", "ingénieur"}
    
    local button_height = (frame_size.y - frame.header:GetTall()) / #class_names
    
    for i, class_name in pairs(class_names) do
        local class_button = frame:AddToBody("Process.f4_menu_sub_category")
        class_button.vertical = false
        class_button.thickness = 0
    
        class_button:SetSize(frame_size.x, button_height)
        class_button:SetPos(0, (i - 1) * button_height)
    
        class_button:SetHoverTextColor(process.white)
    
        class_button:SetFont("Process.f4_menu_sub_category")
        class_button:SetText(process.upper(class_name))
        local w, h = class_button:GetTextSize()
        class_button:SetTextPos((frame_size.x - w) / 2, (button_height - h) / 2)
    
        function class_button:DoClick()
            net.Start(net_name)
            net.WriteUInt(i, 8)
            net.SendToServer()
        end
    end
end)