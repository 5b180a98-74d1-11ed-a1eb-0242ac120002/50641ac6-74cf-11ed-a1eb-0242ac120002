local Panel = {}

local responsive_factor = process.f4_menu.responsive_factor
local menu_size_factor = process.f4_menu.size_factor

local list_element_size = 200 * responsive_factor.y
local list_element_spacing = 19 * responsive_factor.y
local space_between_image_and_border = 56 * responsive_factor.x
local select_button_height = 50 * responsive_factor.y
local space_category_element_list = 10 * responsive_factor.x
local space_between_category_element_name_and_under_info = 6 * responsive_factor.y

local orange = process.orange
local black = process.black
local white = process.white

local upper = process.upper
local empty_func = function() end

local model_shape = {
    {x = 53, y = 17}, --
    {x = 147, y = 17},
    {x = 195, y = 100},
    {x = 147, y = 183},
    {x = 53, y = 183},
    {x = 5, y = 100},
}
for point_key, point in pairs(model_shape) do
    point.x = point.x * responsive_factor.x + space_between_image_and_border
    point.y = point.y * responsive_factor.y
end

local offsetvec = Vector( 4, -10, 0 )
local offsetang = Angle( 0, 90, 90 )

local function layout_model(self, ent)
    -- If ent has been removed somehow then remove screen
    if(!IsValid(ent)) then
        if(self:GetParent()) then self:GetParent():Remove() end
        return
    end

    local boneid = ent:LookupBone( "ValveBiped.Bip01_Head1" )
    
    if not boneid then
        local min, max = ent:GetModelBounds()

        max:Div(2)

        self:SetCamPos(max + Vector(5 * max.x, 0, 0))
        self:SetLookAt(max)

        return
    end

    local matrix = ent:GetBoneMatrix( boneid )
    
    if not matrix then 
        return 
    end

    local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )

    self:SetCamPos(newpos + Vector(8, 0, 0))
    self:SetLookAt(newpos)
    
    return
end

function Panel:Init()
    self:Dock(FILL)

    local sbar = self:GetVBar()
    sbar:SetHideButtons(true)
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, orange)
    end

    local bar_panel = self:GetChild(1)
    function bar_panel:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, black)
    end
    self.bar_w = bar_panel:GetSize()

    self.anim_start = 0
    self.anim_duration = 0
end

function Panel:SetList(category_or_category_jobs)
    local container_w, container_h = self:GetParent():GetSize()
    
    -- label for description
    local infos_label_w = container_w / 2 - self.bar_w - space_category_element_list
    local infos_label = vgui.Create("DLabel", self:GetParent())
    infos_label:SetSize(infos_label_w, container_h)
    infos_label:SetPos(container_w / 2 + space_category_element_list, 0)
    infos_label:SetContentAlignment(7)
    infos_label:SetWrap(true)
    infos_label:SetFont("Process.f4_menu_sub_category")
    infos_label:SetColor(orange)
    infos_label:SetText("")
    function infos_label:OnCursorEntered()
        process.f4_menu.play_sound("hover")
    end

    -- first process logo. will be removed when a sub_category is clicked
    local process_logo_size = math.min(infos_label_w, container_h) / 3
    local is_logo_painted = true

    function infos_label:Paint(w, h)
        if (is_logo_painted) then
            surface.SetDrawColor(color_white)
            surface.SetMaterial(process.f4_menu.job_category_material["Staff"])
            surface.DrawTexturedRect((infos_label_w - process_logo_size) / 2, (container_h - process_logo_size) / 2, process_logo_size, process_logo_size)
        end
    end

    -- button to choose the job
    local select_button = vgui.Create("DButton", self:GetParent())
    select_button:SetSize(infos_label_w, select_button_height)
    select_button:SetPos(container_w / 2 + space_category_element_list, container_h - select_button_height)
    select_button:SetFont("Process.f4_menu_sub_category")
    select_button:SetVisible(false)
    function select_button:Paint(w, h)
        if (select_button:IsHovered() and self.DoClick != empty_func) then
            select_button:SetTextColor(white)
        else
            select_button:SetTextColor(black)
        end

        draw.RoundedBox(3, 0, 0, w, h, orange)
    end
    function select_button:OnCursorEntered()
        process.f4_menu.play_sound("hover")
    end

    -- see if it's a table of job or shipment
    local is_job
    local category_elements = category_or_category_jobs.members or category_or_category_jobs 
    if (!isnumber(category_elements[1]) and category_elements[1].level) then
        is_job = true
    elseif( !isnumber(category_elements[1]) ) then 
        is_job = false
    else // job but with subcategory
        is_job = true 

        category_elements = {}
        for key, value in ipairs(category_or_category_jobs) do
            category_elements[key] = RPExtraTeams[value]
        end
    end

    -- sort by level for job or price for shipment
    table.SortByMember(category_elements, is_job and "level" or "price", true)

    -- create all sub_category for each element in category_elements
    for category_element_index, category_element in ipairs(category_elements) do
        local sub_category = self:Add("Process.f4_menu_sub_category")
        sub_category:SetPos(0, (list_element_size + list_element_spacing) * (category_element_index - 1))
        sub_category:SetSize(container_w / 2, list_element_size)
        sub_category.vertical = false
        sub_category.thickness = 0
        sub_category.hover_material = process.f4_menu.hover_vertical_material
        sub_category:SetImage(process.f4_menu.list_material, space_between_image_and_border, 0, list_element_size)
        sub_category:SetAnim(0.3, category_element_index * 0.1)
        -- sub_category text 
        sub_category:SetFont("Process.f4_menu_sub_category")
        sub_category:SetText(upper(category_element.name))
        local _, category_element_name_text_h = sub_category:GetTextSize()
        local category_element_name_text_pos = {x = space_between_image_and_border * 2 + list_element_size, y = (list_element_size - category_element_name_text_h) / 2}
        sub_category:SetTextPos(category_element_name_text_pos.x, category_element_name_text_pos.y)

        -- model layout
        local player_model = sub_category:Add("DModelPanel")
		player_model:SetSize( list_element_size, list_element_size )
		player_model:SetModel(istable(category_element.model) and category_element.model[math.random(1, #category_element.model)] or category_element.model)
		player_model:SetPos(space_between_image_and_border, 0) -- same pos as image
        player_model:SetPaintedManually(true)
		player_model.LayoutEntity = layout_model

        local old_paint = sub_category.Paint
        function sub_category:Paint(w, h)
            old_paint(self, w, h)

            draw.NoTexture()

            if (self.anim_start <= SysTime()) then
                -- paint player_model
                EZMASK.DrawWithMask(
                    function ()
                        surface.SetDrawColor(color_white)
                        surface.DrawPoly(model_shape)
                    end,
                    function ()
                        player_model:PaintManual()
                    end
                )

                if (!is_job) then
                    return 
                end 

                surface.SetFont("Process.f4_menu_sub_category")

                local color

                if (SysTime() < self.anim_start + self.anim_duration) then
                    color = Color(white.r, white.g, white.b, (SysTime() - self.anim_start) / self.anim_duration * 255)
                else
                    color = white
                end

                surface.SetTextColor(color)

                local under_info_text_y = category_element_name_text_pos.y + category_element_name_text_h + space_between_category_element_name_and_under_info

                -- level
                surface.SetTextPos(category_element_name_text_pos.x, under_info_text_y)
                local text_level = "NIVEAU "..category_element.level.."  "
                surface.DrawText(text_level)

                -- donator or whitelist
                local text = category_element.donator > 0 and (category_element.donator == 1 and "Donateur" or "Parrain") or (category_element.whitelist and "list blanche "..category_element.whitelist)

                if (text) then
                    local text_level_w = surface.GetTextSize(text_level)

                    surface.SetTextPos(category_element_name_text_pos.x + text_level_w, under_info_text_y)
                    surface.DrawText(upper(text))
                end
            end
        end
        function sub_category:DoClick()
            process.f4_menu.play_sound("click")

            is_logo_painted = false 

            local text = "Description : \n"..category_element.description.."\n\n"

            if (is_job) then
                text = text.."Niveau : "..category_element.level
                if (category_element.donator == 1) then
                    text = text.."\nDonateur : Oui"
                elseif (category_element.donator == 2) then
                    text = text.."\nParrain : Oui"
                else
                    text = text.."\nDonateur : Non"
                end                
            else
                text = text.."Prix : "..category_element.price
                if (LocalPlayer():Team() == TEAM_STAFF) then
                    text = text.." (Toi qui est staff ne payeras rien. Utilise cette richesse qui vient de la communauté que vous connaissez bien.)"
                end
            end

            infos_label:SetText(text)

            local can_category_element

            if(is_job) then
                can_category_element = category_element.customCheck(LocalPlayer())

                select_button:SetText( upper( can_category_element and "Devenir "..category_element.name or category_element.CustomCheckFailMsg(LocalPlayer()) ) )
            else
                can_category_element = true

                select_button:SetText(upper("acheter "..category_element.name))
            end

            select_button:SetVisible(true)

            if (can_category_element) then
                select_button:SetCursor("hand")

                function select_button:DoClick()
                    process.f4_menu.play_sound("click")

                    if(is_job) then
                        RunConsoleCommand("darkrp", category_element.command)

                        self:GetParent():GetParent():Remove() -- remove f4 menu frame          
                    elseif(category_element.cmd) then // if entity
                        RunConsoleCommand("darkrp", category_element.cmd)
                    else
                        RunConsoleCommand("darkrp", "buyshipment", category_element.name)
                    end
                end
            else
                select_button:SetCursor("arrow")

                select_button.DoClick = empty_func
            end
        end
    end
end

function Panel:SetAnim(duration, delay)
    self.anim_start = SysTime() + delay or 0 
    self.anim_duration = duration
end

vgui.Register("Process.f4_menu_list", Panel, "DScrollPanel")