local responsive_factor = process.f4_menu.responsive_factor
local hover_image_size = {x = 299 * responsive_factor.x, y = 484 * responsive_factor.y}

local black = process.black
local orange = process.orange
local white = process.white

local Panel = {}

local hover_alpha_update_delay = 0.005

function Panel:Init()
    self.thickness = 6
    self.image = nil
    self.image_pos = {x = 0, y = 0}
    self.image_size = nil
    self.vertical = true
    self:SetCursor("hand")

    -- text
    self.font = "Process.f4_menu_sub_category"
    self.text = ""
    self.text_pos = { x = 0, y = 0}

    -- animation
    self.hover_material = nil

    self.anim_start = 0
    self.anim_duration = 0

    self.hover_anim_duration = 0.5
    self.hover_alpha_next_update = 0
    self.hover_alpha = 0
end

function Panel:Paint(w, h)    
    if (self.anim_start <= SysTime()) then
        draw.NoTexture()
        local intern_box_size = {x = w - self.thickness * 2, y = h - self.thickness * 2}

        if (SysTime() < self.anim_start + self.anim_duration) then
            local alpha = (SysTime() - self.anim_start) / self.anim_duration * 255
            local anim_orange = Color(orange.r, orange.g, orange.b, alpha)

            draw.RoundedBox(8, 0, 0, w, h, anim_orange)
            draw.RoundedBox(3.5, self.thickness, self.thickness, intern_box_size.x, intern_box_size.y, black)                

            surface.SetTextColor(anim_orange)
            surface.SetTextPos(self.text_pos.x, self.text_pos.y)
            surface.SetFont(self.font)
            surface.DrawText(self.text)

            if (self.image) then
                surface.SetDrawColor(Color(255, 255, 255, alpha))
                surface.SetMaterial(self.image)
                surface.DrawTexturedRect(self.image_pos.x, self.image_pos.y, self.image_size, self.image_size)                  
            end
        else
            draw.RoundedBox(8, 0, 0, w, h, orange)
            draw.RoundedBox(3.5, self.thickness, self.thickness, intern_box_size.x, intern_box_size.y, black)                

            surface.SetTextColor((self:IsHovered() and self.hover_text_color) and self.hover_text_color or orange)
            surface.SetTextPos(self.text_pos.x, self.text_pos.y)
            surface.SetFont(self.font)
            surface.DrawText(self.text)

            -- hover animation
            if (self.hover_alpha_next_update <= SysTime()) then
                self.hover_alpha_next_update = SysTime() + hover_alpha_update_delay

                if (self:IsHovered()) then
                    if (self.hover_alpha < 255) then
                        self.hover_alpha = self.hover_alpha + 255 * (hover_alpha_update_delay /  self.hover_anim_duration)
                    end
                else
                    if (self.hover_alpha > 0) then
                        self.hover_alpha = self.hover_alpha - 255 * (hover_alpha_update_delay /  self.hover_anim_duration)
                    end
                end
            end

            if (self.hover_material) then
                surface.SetDrawColor(Color(255, 255, 255, self.hover_alpha))
                surface.SetMaterial(self.hover_material)
                if (self.vertical) then
                    surface.DrawTexturedRect(self.thickness, self.thickness, intern_box_size.x, hover_image_size.y)                
                else
                    surface.DrawTexturedRect(self.thickness, self.thickness, hover_image_size.x, intern_box_size.y)    
                end
            end

            if (self.image) then
                surface.SetDrawColor(color_white)
                surface.SetMaterial(self.image)
                surface.DrawTexturedRect(self.image_pos.x, self.image_pos.y, self.image_size, self.image_size)                    
            end
        end
    end
end

function Panel:OnMousePressed(keyCode)
    if (self.DoClick and keyCode == MOUSE_LEFT) then
        self:DoClick()
    end
end

function Panel:SetAnim(duration, delay)
    self.anim_start = SysTime() + delay or 0 
    self.anim_duration = duration
end

function Panel:SetText(text)
    self.text = text
end

function Panel:SetHoverTextColor(color)
    self.hover_text_color = color
end

function Panel:SetTextPos(x, y)
    self.text_pos.x = x
    self.text_pos.y = y
end

function Panel:SetImage(material, x, y, size)
    self.image = material
    self.image_pos.x = x
    self.image_pos.y = y
    self.image_size = size
end

function Panel:GetTextSize()
    surface.SetFont(self.font)
    return surface.GetTextSize(self.text)
end

function Panel:SetFont(font)
    self.font = font
end

function Panel:OnCursorEntered()
    process.f4_menu.play_sound("hover")
end

vgui.Register("Process.f4_menu_sub_category", Panel, "EditablePanel")