
local menu_size_factor = process.f4_menu.size_factor
local responsive_factor = process.f4_menu.responsive_factor

local black = process.black
local orange = process.orange
local white = process.white

-- define size and position
local category_size = process.f4_menu.category_size
local category_shape = {
	{x = category_size.x, y = 0},
	{x = 310 * responsive_factor.x, y = category_size.y},
	{x = 52 * responsive_factor.x, y = category_size.y},
	{x = 0, y = 0}
}

-- create the vgui element
local Panel = {}

function Panel:Init()
    self:SetSize(category_size.x, category_size.y)
    self:SetFont("Process.f4_menu_category") 

    -- paint shape and do animation
    self.anim_start = 0
    self.anim_duration = 0
end

function Panel:Paint(w, h)
    if (self.anim_start <= SysTime()) then
        draw.NoTexture()

        if (SysTime() < self.anim_start + self.anim_duration) then
            surface.SetDrawColor(Color(orange.r, orange.g, orange.b, (SysTime() - self.anim_start) / self.anim_duration * 255))
            self:SetTextColor(Color(black.r, black.g, black.b, (SysTime() - self.anim_start) / self.anim_duration * 255))
        else
            if (self:IsHovered()) then
                self:SetTextColor(white)
            else
                self:SetTextColor(black)
            end

            surface.SetDrawColor(orange)
        end

        surface.DrawPoly(category_shape)
    else
        self:SetTextColor(Color(0, 0, 0, 0))
    end
end

function Panel:SetAnim(duration, delay)
    self.anim_start = SysTime() + delay or 0 
    self.anim_duration = duration
end

function Panel:OnCursorEntered()
    process.f4_menu.play_sound("hover")
end

vgui.Register("Process.f4_menu_category", Panel, "DButton")