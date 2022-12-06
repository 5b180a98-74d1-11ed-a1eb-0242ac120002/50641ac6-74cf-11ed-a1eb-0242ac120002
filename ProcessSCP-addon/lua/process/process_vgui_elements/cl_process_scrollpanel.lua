local PANEL = {}

function PANEL:Init()
    self.grip_color = process.orange
    self.back_ground_color = process.black

    local grip_color = self.grip_color
    local back_ground_color = self.back_ground_color

    local sbar = self:GetVBar()
    sbar:SetHideButtons(true)
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, grip_color)
    end

    local bar_panel = self:GetChild(1)
    function bar_panel:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, back_ground_color)
    end
end

vgui.Register("Process.scroll_bar", PANEL, "DScrollPanel")