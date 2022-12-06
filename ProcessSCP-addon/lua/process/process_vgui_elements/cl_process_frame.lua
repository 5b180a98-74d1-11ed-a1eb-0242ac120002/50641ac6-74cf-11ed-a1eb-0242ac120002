local PANEL = {}

function PANEL:SetHeaderHeight(header_height)
    local w, h = self:GetSize()
    self.header:SetSize(w, header_height)

    self.body:SetSize(w, h - header_height)
    self.body:SetPos(0, header_height)
end

function PANEL:SetHeaderBackground(color)
    self.header.color = color or Color(32, 33, 34)
end

function PANEL:SetBodyBackground(color)
    self.body.color = color or process.black
end

function PANEL:SetCornerRadius(corner_radius)
    self.body.corner_radius = corner_radius or 0
    self.header.corner_radius = corner_radius or 0
end

function PANEL:SetCloseButtonMargin(left, right, top, bottom)
    self.close_button:DockMargin(left or 3, right or 3, top or 3, bottom or 3)
end

function PANEL:AddToBody(panel)
    return self.body:Add(panel)
end

function PANEL:Init()
    local old_set_size = self.SetSize
    function self:SetSize(w, h)
        old_set_size(self, w, h)
        
        self.header:SetSize(w, self.header:GetTall())
        self.body:SetSize(w, h - self.header:GetTall())
    end
    
    // header
    self.header = self:Add("EditablePanel")
    self:SetHeaderBackground()
    function self.header:Paint(w, h)
        draw.RoundedBoxEx(self.corner_radius, 0, 0, w, h, self.color, true, true)
    end
    
    // body
    self.body = self:Add("EditablePanel")
    function self.body:Paint(w, h)
        draw.RoundedBoxEx(self.corner_radius, 0, 0, w, h, self.color, false , false, true, true)
    end
    self:SetBodyBackground(process.black)
    
    self:SetCornerRadius()
    
    self:SetHeaderHeight(24)

    //close button
    self.close_button = self.header:Add("DButton")
    self.close_button:Dock(RIGHT)
    self:SetCloseButtonMargin()
    self.close_button:SetText("×")
    self.close_button:SetSize(20, 0)
    self.close_button:SetFont("Trebuchet24")
    function self.close_button:Paint(w, h)
        if (self:IsHovered()) then
            self:SetTextColor(process.white)
        else
            self:SetTextColor(process.black)
        end
        
        draw.RoundedBox(3, 0, 0, w, h, process.orange)
    end
    function self.close_button:DoClick()
        self:GetParent():GetParent():Remove()
    end
end

vgui.Register("Process.Frame", PANEL, "EditablePanel")