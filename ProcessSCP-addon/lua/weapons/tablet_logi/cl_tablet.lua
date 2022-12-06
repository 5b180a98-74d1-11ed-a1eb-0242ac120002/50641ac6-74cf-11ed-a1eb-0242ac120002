local scale_factor = 1.0
local responsive_factor = math.min(ScrW() / 1920, ScrH() / 1080) * scale_factor

local frame_size = { x = 1000 * responsive_factor, y = 700 * responsive_factor }

local logo_size = 200 * responsive_factor
local logo_pos = {x = (frame_size.x - logo_size) / 2, y = 50 * responsive_factor}

local title_pos_y = logo_pos.y + logo_size + 20 * responsive_factor

local bar_size = {x = frame_size.x * 0.75 * responsive_factor, y = 40 * responsive_factor}
local bar_pos = {x = (frame_size.x - bar_size.x) / 2, y = title_pos_y + 100 * responsive_factor}
local bar_thickness = 3 * responsive_factor

local button_size = {x = 380 * responsive_factor, y = 100 * responsive_factor}
local button_pos = {x = (frame_size.x - button_size.x) / 2, y = bar_pos.y + 60 * responsive_factor}

surface.CreateFont( "Process.tablet_logi.title", {
	font = "Arial",
	size = 45 * responsive_factor,
	weight = 400 * responsive_factor,
} )

local next_primary_attack = CurTime()
local ASR = process.ASR
function SWEP:PrimaryAttack() 
    if (CurTime() < next_primary_attack) then
        return
    end
    
    next_primary_attack = CurTime() + 0.5

    local frame = vgui.Create("Process.Frame")
    frame:MakePopup()
    frame:SetPos((ScrW() - frame_size.x) / 2, (ScrH() - frame_size.y) / 2)
    frame:SizeTo(frame_size.x, frame_size.y, 0.5)
    
    local logo_process = frame:AddToBody("DImage")
    logo_process:SetMaterial(process.f4_menu.job_category_material["Staff"])
    logo_process:SetSize(logo_size, logo_size)
    logo_process:SetPos(logo_pos.x, logo_pos.y)

    local title = frame:AddToBody("DLabel")
    title:SetPos(0, title_pos_y)
    title:SetText("Tablette Logistique")
    title:SetSize(frame_size.x, 50)
    title:SetFont("Process.tablet_logi.title")
    title:SetContentAlignment(5)
    title:SetTextColor(process.orange)

    local bar = frame:AddToBody("EditablePanel")
    bar:SetPos(bar_pos.x, bar_pos.y)
    bar:SetSize(bar_size.x, bar_size.y)
    function bar:Paint(w, h)
        surface.SetDrawColor(process.orange)

        surface.DrawOutlinedRect(0, 0, w, h, bar_thickness)

        surface.DrawRect(bar_thickness * 2, bar_thickness * 2, (w - bar_thickness * 4) * ASR.get_filled(), h - bar_thickness * 4)
    end

    local button = frame:AddToBody("DButton")
    button:SetPos((frame_size.x - button_size.x) / 2, button_pos.y)
    button:SetSize(button_size.x, button_size.y)
    button:SetText(process.upper("Demander un ravitaillement"))
    button:SetFont("Process.f4_menu_sub_category")
    button:SetContentAlignment(5)
    function button:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, process.orange)
        
        if (self:IsHovered()) then
            if (ASR.can_call()) then
                self:SetTextColor(color_white)
    
                self:SetCursor("hand")
                
                self:SetTooltip(false)
            else
                self:SetTextColor(process.black)
                
                self:SetCursor("arrow")
    
                self:SetTooltip("Ravitaillement déjà demandé.")
            end
        else
            self:SetTextColor(process.black)
                
            self:SetCursor("arrow")
        end
    end
    function button:DoClick()
        if (!ASR.can_call()) then
            return
        end

        net.Start(ASR.net_name)
        net.SendToServer()
    end
end

net.Receive(ASR.net_name, function ()
    notification.AddLegacy("L'agent du service de ravitaillement est désormais disponible.", NOTIFY_GENERIC, 5)
end)