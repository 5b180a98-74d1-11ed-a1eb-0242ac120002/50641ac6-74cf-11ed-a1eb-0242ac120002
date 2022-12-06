local Panel = {}

local responsive_factor = process.f4_menu.responsive_factor
local menu_size_factor = process.f4_menu.size_factor
local label_size = process.f4_menu.label_size
local space_between_frame_and_label = (ScrH() * menu_size_factor - label_size.y) / 2
local orange = process.orange
local black = process.black

local label_shape = {
    {x = 0, y = 47 * responsive_factor.y + space_between_frame_and_label},
    {x = label_size.x, y = 90 * responsive_factor.y + space_between_frame_and_label},
    {x = label_size.x, y = 926 * responsive_factor.y + space_between_frame_and_label},
    {x = 0, y = label_size.y + space_between_frame_and_label},
}

function Panel:Init()
    self:Dock(FILL)
    self.text = ""

    self.anim_start = 0
    self.anim_duration = 0
end

function Panel:Paint()
    -- draw shape
    if (self.anim_start <= SysTime()) then
        if (SysTime() < self.anim_start + self.anim_duration) then
            surface.SetDrawColor(orange.r, orange.g, orange.b, (SysTime() - self.anim_start) / self.anim_duration * 255)
            surface.SetTextColor(black.r, black.g, black.b, (SysTime() - self.anim_start) / self.anim_duration * 255)
        else
            surface.SetDrawColor(orange)
            surface.SetTextColor(black)
        end
    end

    draw.NoTexture()
    surface.DrawPoly(label_shape)

    -- draw text
    surface.SetFont("Process.f4_menu_category")
    local text = self.text
    local w, h = surface.GetTextSize(text)
    draw.RotatedText(text, (label_size.x - h) / 2 + h, (label_size.y - w) / 2 + space_between_frame_and_label, 90, self )
end

function Panel:SetAnim(duration, delay)
    self.anim_start = SysTime() + delay or 0 
    self.anim_duration = duration
end

vgui.Register("Process.f4_menu_label", Panel, "Panel")