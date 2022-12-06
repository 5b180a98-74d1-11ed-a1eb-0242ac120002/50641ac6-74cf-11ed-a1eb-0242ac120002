local responsive_factor = math.min(ScrW() / 1920, ScrH() / 1080)

surface.CreateFont("Process.armor_locker",{
    font = "CloseCaption_Normal",
	size = 36 * responsive_factor,
	weight = 600 * responsive_factor,
})

surface.CreateFont("Process.armor_locker_label",{
    font = "CloseCaption_Normal",
	size = 32 * responsive_factor,
	weight = 1 * responsive_factor,
})

local PANEL = {}

function PANEL:Init()
    self:SetFont("Process.armor_locker")
    self:SetTextColor(process.white)
end

function PANEL:Paint(w, h)
    if (self.too_expensive) then
        surface.SetDrawColor(Color(219, 38, 38))
        self:SetCursor("arrow")
    else
        if (self.selected) then
            surface.SetDrawColor(process.orange)
            self:SetCursor("arrow")
        else
            surface.SetDrawColor(Color(134, 146, 154))
            self:SetCursor("hand")
        end

    end

    surface.DrawOutlinedRect(0, 0, w, h, 5)
end

vgui.Register("Process.armor_locker_button", PANEL, "DButton")