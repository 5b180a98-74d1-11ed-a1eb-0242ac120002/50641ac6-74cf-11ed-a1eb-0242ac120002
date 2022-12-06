//-----------------------------------------//
//      MENU VARIABLES INITIALISATION      //
//-----------------------------------------//

local net_name = SWEP.net_name 
local scale_factor = 0.6
local responsive_factor = math.min(ScrW() / 1920, ScrH() / 1080) * scale_factor
local frame_size = { x = 1000 * responsive_factor, y = 600 * responsive_factor }

local button_size = {x = 460 * responsive_factor, y = 150 * responsive_factor}

local button_orange = Color(255, 183, 77, 120)

surface.CreateFont( "Process.animation_swep_button", {
	font = "Arial",
	size = 45 * responsive_factor,
	weight = 400 * responsive_factor,
} )


//-----------------------------------------//
//            UI USAGE DEFINITION          //
//-----------------------------------------//

local next_primary_attack = CurTime()
function SWEP:PrimaryAttack()   
    if (CurTime() < next_primary_attack) then
        return
    end
    
    next_primary_attack = CurTime() + 0.5

    // -- frame initialisation
    local frame = vgui.Create("Process.Frame")
    frame:MakePopup()
    frame:SetPos((ScrW() - frame_size.x) / 1.1, (ScrH() - frame_size.y) / 2)
    frame:SizeTo(frame_size.x, frame_size.y, 0.3)
    frame:SetAlpha(230)
    // -- hand behind button
    local button_animation1 = frame:AddToBody("DButton")
    button_animation1:SetPos(25 * responsive_factor, 30 * responsive_factor)
    button_animation1:SetSize(button_size.x, button_size.y)
    button_animation1:SetText("Bras dans le dos")
    button_animation1:SetFont("Process.animation_swep_button")
    button_animation1:SetContentAlignment(5)
    function button_animation1:Paint(w, h)
        draw.RoundedBox(15, 0, 0, w, h, button_orange)
        if (self:IsHovered()) then
            self:SetTextColor(color_white)
            self:SetCursor("hand")
            self:SetTooltip(false)
        else
            self:SetTextColor(process.black)
            self:SetCursor("arrow")
        end
    end
    function button_animation1:DoClick()
        net.Start(net_name)
        net.WriteUInt(1,16)
        net.SendToServer()
        frame:Remove()
    end

    // -- hand bellow button
    local button_animation2 = frame:AddToBody("DButton")
    button_animation2:SetPos(25 * responsive_factor, button_size.y + 60 * responsive_factor)
    button_animation2:SetSize(button_size.x, button_size.y)
    button_animation2:SetText("Bras croisés")
    button_animation2:SetFont("Process.animation_swep_button")
    button_animation2:SetContentAlignment(5)
    function button_animation2:Paint(w, h)
        draw.RoundedBox(15, 0, 0, w, h, button_orange)
        if (self:IsHovered()) then
            self:SetTextColor(color_white)
            self:SetCursor("hand")
            self:SetTooltip(false)
        else
            self:SetTextColor(process.black)
            self:SetCursor("arrow")
        end
    end
    function button_animation2:DoClick()
        net.Start(net_name)
        net.WriteUInt(2,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- salute button
    local button_animation3 = frame:AddToBody("DButton")
    button_animation3:SetPos(25 * responsive_factor, button_size.y * 2 + 90 * responsive_factor)
    button_animation3:SetSize(button_size.x, button_size.y)
    button_animation3:SetText("Salut militaire")
    button_animation3:SetFont("Process.animation_swep_button")
    button_animation3:SetContentAlignment(5)
    function button_animation3:Paint(w, h)
        draw.RoundedBox(15, 0, 0, w, h, button_orange)
        if (self:IsHovered()) then
            self:SetTextColor(color_white)
            self:SetCursor("hand")
            self:SetTooltip(false)
        else
            self:SetTextColor(process.black)
            self:SetCursor("arrow")
        end
    end
    function button_animation3:DoClick()
        net.Start(net_name)
        net.WriteUInt(3,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- surrender button
    local button_animation4 = frame:AddToBody("DButton")
    button_animation4:SetPos(frame_size.x - (25 * responsive_factor + button_size.x), 30 * responsive_factor)
    button_animation4:SetSize(button_size.x, button_size.y)
    button_animation4:SetText("Se rendre")
    button_animation4:SetFont("Process.animation_swep_button")
    button_animation4:SetContentAlignment(5)
    function button_animation4:Paint(w, h)
        draw.RoundedBox(15, 0, 0, w, h, button_orange)
        if (self:IsHovered()) then
            self:SetTextColor(color_white)
            self:SetCursor("hand")
            self:SetTooltip(false)
        else
            self:SetTextColor(process.black)
            self:SetCursor("arrow")
        end
    end
    function button_animation4:DoClick()
        net.Start(net_name)
        net.WriteUInt(4,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- middlefinger button
    local button_animation5 = frame:AddToBody("DButton")
    button_animation5:SetPos(frame_size.x - (25 * responsive_factor + button_size.x), button_size.y + 60 * responsive_factor)
    button_animation5:SetSize(button_size.x, button_size.y)
    button_animation5:SetText("Doigt d'honneur")
    button_animation5:SetFont("Process.animation_swep_button")
    button_animation5:SetContentAlignment(5)
    function button_animation5:Paint(w, h)
        draw.RoundedBox(15, 0, 0, w, h, button_orange)
        if (self:IsHovered()) then
            self:SetTextColor(color_white)
            self:SetCursor("hand")
            self:SetTooltip(false)
        else
            self:SetTextColor(process.black)
            self:SetCursor("arrow")
        end
    end
    function button_animation5:DoClick()
        net.Start(net_name)
        net.WriteUInt(5,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- middlefinger button
    local button_animation6 = frame:AddToBody("DButton")
    button_animation6:SetPos(frame_size.x - (25 * responsive_factor + button_size.x), button_size.y * 2 + 90 * responsive_factor)
    button_animation6:SetSize(button_size.x, button_size.y)
    button_animation6:SetText("Lever la main")
    button_animation6:SetFont("Process.animation_swep_button")
    button_animation6:SetContentAlignment(5)
    function button_animation6:Paint(w, h)
        draw.RoundedBox(15, 0, 0, w, h, button_orange)
        if (self:IsHovered()) then
            self:SetTextColor(color_white)
            self:SetCursor("hand")
            self:SetTooltip(false)
        else
            self:SetTextColor(process.black)
            self:SetCursor("arrow")
        end
    end
    function button_animation6:DoClick()
        net.Start(net_name)
        net.WriteUInt(6,16)
        net.SendToServer()
        frame:Remove()
    end
end
