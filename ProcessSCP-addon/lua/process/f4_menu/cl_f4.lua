local black = process.black
local orange = process.orange

local menu_size_factor = process.f4_menu.size_factor
local responsive_factor = process.f4_menu.responsive_factor
local min_responsive_factor = process.f4_menu.min_responsive_factor

local space_between_category = 9 * responsive_factor.x
local space_betwwen_category_and_frame = 87 * responsive_factor.x
local category_size = process.f4_menu.category_size
local frame_size = {x = ScrW() * menu_size_factor, y = ScrH() * menu_size_factor}
local label_size = process.f4_menu.label_size
local container_pos = {x = label_size.x + 15 * responsive_factor.x, y = 145 * responsive_factor.y}
local container_size = {x = frame_size.x - container_pos.x - space_between_category, y = 838 * responsive_factor.y}
local space_between_sub_category = 8 * responsive_factor.x
local image_size = 127 * min_responsive_factor  // image size for sub_category
local space_between_infra_category_and_image = 30 * responsive_factor.x
local space_between_infra_category_and_text = 200 * responsive_factor.x
local sub_category_height = 220 * responsive_factor.y
-- player infos
local player_infos_pos = {x = 109 * responsive_factor.x, y = 41 * responsive_factor.y}
local space_between_name_and_money = 35 * responsive_factor.x

local is_key_down = false
local frame
local anim_duration = 0.5

-- vgui
local label
local jobs_button
local container
local function reset_container()
	if (IsValid(container)) then
		container:Remove()
	end

	container = frame:Add("EditablePanel")
	container:SetSize(container_size.x, container_size.y)
	container:SetPos(container_pos.x,container_pos.y)	
end

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
	local x, y = panel:LocalToScreen(0, 0) 
	local scrW, scrH = ScrW(), ScrH() 

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)

	blur:SetFloat("$blur", amount)
	blur:Recompute()
	
	render.UpdateScreenEffectTexture()
	surface.DrawTexturedRect(x, y, scrW, scrH)
end

local function is_allowed(category_name)
	return category_name != "Staff" or sam.ranks.get_immunity(LocalPlayer():GetUserGroup()) >= 15
end

local upper = process.upper
local function set_label(text)
	label.text = upper(text)
end

local categories
hook.Add("Initialize", "Process.f4_menu.init_job_categories", function ()
	categories = { // to defines sub categories for some DarkRP.getCategories().jobs
		["Civil"] = {
			{name = "classes renouvelable", teams = {TEAM_D, TEAM_CONTR, TEAM_CONTRAVANCE, TEAM_RAT}},
			{name = "groupe d'intérêt", teams = {TEAM_SOLDAT, TEAM_MASTOGDI, TEAM_SERGENT, TEAM_BRASDROIT, TEAM_CHEFTINTERET}},
		},
		["Sécurité"] = {
			{name = "agent de Sécurité", teams = {TEAM_CADETSECU,TEAM_SURVEILLANT, TEAM_OFC, TEAM_AE, TEAM_UIAA, TEAM_UIAAL, TEAM_OFCSGT, TEAM_OFCLTN, TEAM_CPT}},
			{name = "agent d'Intervention Tactique", teams = {TEAM_RCTIT, TEAM_AIT, TEAM_UITS, TEAM_CPLIT, TEAM_SGTIT, TEAM_LTNIT, TEAM_CMDIT}},
			{name = "garde rapprochée et sentinelles", teams = {TEAM_CHIEN, TEAM_GE, TEAM_SENTINELLE,}},
			{name = "forces d'Intervention Mobiles", teams = {TEAM_SOLDATFIM, TEAM_MASTOFIM, TEAM_LTNFIM, TEAM_CMDFIM}},
		},
		["SCP"] = {
			{name = "safe", teams = {TEAM_131, TEAM_202, TEAM_999}},
			{name = "euclide", teams = {TEAM_006fr, TEAM_049, TEAM_073, TEAM_079, TEAM_096, TEAM_173, TEAM_457, TEAM_527, TEAM_966}},
			{name = "keter", teams = {TEAM_SCP106, TEAM_682, TEAM_939, TEAM_1983pro, TEAM_1048}},
		},
	}
end)

local hidden_categories = process.to_if_check_table(
	"Other",
	"Gangsters",
	"Civil Protection",
	"Citizens",
	"Donator Jobs"
)

local function open_category(category)
	reset_container()

	local category_name = category.name
	set_label(category_name)

	if (!categories[category_name]) then -- when no sub category
		process.f4_menu.play_sound("click")

		reset_container()

		container:Add("Process.f4_menu_list"):SetList(category)
	else
		-- create DScrollPanel
		local scroll_panel = container:Add("DScrollPanel")
		scroll_panel:Dock(FILL)

		local bar_panel = scroll_panel:GetChild(1)
		function bar_panel:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, black)
		end
		local bar_w = bar_panel:GetSize()

		local sbar = scroll_panel:GetVBar()
		sbar:SetHideButtons(true)
		function sbar.btnGrip:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, orange)
		end

		-- create all sub_category
		local sub_category_index = 0

		for _, sub_category_info in pairs(categories[category_name]) do
			local sub_category_name = sub_category_info.name

			local sub_category = scroll_panel:Add("Process.f4_menu_sub_category")
			sub_category:SetFont("Process.f4_menu_category")
			sub_category:SetSize(container_size.x - bar_w - space_between_sub_category, sub_category_height)
			sub_category:SetPos(0, (sub_category_height + space_between_sub_category) * sub_category_index)
			sub_category.hover_material = process.f4_menu.hover_vertical_material
			sub_category:SetImage(process.f4_menu.job_sub_category_material[sub_category_name], space_between_infra_category_and_image, (sub_category_height - image_size) / 2, image_size)
			sub_category.vertical = false
			sub_category:SetAnim(anim_duration * 1.5, 0.1 * sub_category_index + 0.2)
			-- text
			sub_category:SetText( upper(sub_category_name) )
			local w, h = sub_category:GetTextSize()
			sub_category:SetTextPos(space_between_infra_category_and_text, (sub_category_height - h) / 2)

			function sub_category:DoClick()
				process.f4_menu.play_sound("click")

				reset_container()
				
				container:Add("Process.f4_menu_list"):SetList(sub_category_info.teams)
				set_label(sub_category_name)
			end

			sub_category_index = sub_category_index + 1
		end
	end
end

-- wait the key to open the menu
hook.Add( "Think", "process.f4_menu", function()
    if (input.IsKeyDown( KEY_F4 )) then
		-- open or close menu		
		if (is_key_down) then
			return 
		end
		is_key_down = true

		if (IsValid(frame)) then
			frame:Remove()

			process.hud_alpha = 255

			return
		end

		process.f4_menu.play_sound("open")

		-- create parent of all panel
		frame = vgui.Create("Panel")
		frame:SetSize(frame_size.x, frame_size.y)
		frame:SetVisible(true)
		frame:MakePopup()
		frame:Center()
		-- frame appear anim
		local anim_start = SysTime()
		local frame_max_alpha = 200
		function frame:Paint(w, h)
			draw.NoTexture()

			DrawBlur(self, 2)

			local player_infos_color

			if (SysTime() < anim_start + anim_duration) then
				local alpha = (SysTime() - anim_start) / anim_duration * frame_max_alpha

				process.hud_alpha = 255 - alpha

				draw.RoundedBox(0, 0, 0, w, h, Color(black.r, black.g, black.b, alpha))

				player_infos_color = Color(orange.r, orange.g, orange.b, (SysTime() - anim_start) / anim_duration * 255)
			else
				draw.RoundedBox(0, 0, 0, w, h, Color(black.r, black.g, black.b, frame_max_alpha))

				player_infos_color = orange

				process.hud_alpha = 0
			end

			-- player infos
				surface.SetTextColor(player_infos_color)

				-- name
				surface.SetFont("Process.f4_menu_name")
				surface.SetTextPos(player_infos_pos.x, player_infos_pos.y)
				local name_text = upper(LocalPlayer():Name())
				surface.DrawText( name_text )
				local name_w = surface.GetTextSize(name_text)
				
				-- money
				surface.SetFont("Process.f4_menu_money_lvl")
				local money_and_lvl_x = player_infos_pos.x + name_w + space_between_name_and_money
				surface.SetTextPos(money_and_lvl_x, player_infos_pos.y)
				local money_text = LocalPlayer():getDarkRPVar("money").."$"
				surface.DrawText(money_text)
				local _, money_h = surface.GetTextSize(money_text)

				-- lvl
				surface.SetFont("Process.f4_menu_money_lvl")
				surface.SetTextPos(money_and_lvl_x, player_infos_pos.y + money_h)
				surface.DrawText("LVL "..LocalPlayer():getDarkRPVar("Process.level"))
		end
		function frame:OnRemove()
			process.hud_alpha = 255
		end

		-- label on the left to se see where we are
		label = frame:Add("Process.f4_menu_label")
		label:SetAnim(anim_duration, 0.8)

		-- job category
		jobs_button = frame:Add("Process.f4_menu_category")
		jobs_button:SetPos(frame_size.x - (space_betwwen_category_and_frame + category_size.x), 0)
		jobs_button:SetText("PROFESSIONS")
		jobs_button:SetAnim(anim_duration, 0.4)
		function jobs_button:DoClick(open_menu)
			if (!open_menu) then
				process.f4_menu.play_sound("click")				
			end

			reset_container()

			set_label(jobs_button:GetText())

			local allowed_categories = {}
			for _, job_categorie in pairs(DarkRP.getCategories().jobs) do
				if (!hidden_categories[job_categorie.name] and is_allowed(job_categorie.name)) then
					table.insert(allowed_categories, job_categorie)
				end
			end

			local sub_category_width = container_size.x / #allowed_categories - (space_between_sub_category - space_between_sub_category / #allowed_categories) -- <=> space_between_sub_category * (nb_job_categories - 1) / nb_job_categories
			for job_category_index, job_category in pairs(allowed_categories) do
				local name_job_category = job_category.name

				local job_button = container:Add("Process.f4_menu_sub_category")
				job_button:SetSize(sub_category_width, container_size.y)
				job_button:SetPos((sub_category_width + space_between_sub_category) * (job_category_index - 1), 0)
				job_button:SetAnim(anim_duration, 0.1 * job_category_index)
				job_button.hover_material = process.f4_menu.hover_horizontal_material
				-- text
				job_button:SetImage(process.f4_menu.job_category_material[name_job_category], (sub_category_width - image_size) / 2, (container_size.y - image_size) / 2, image_size)
				job_button:SetText( upper(name_job_category) )
				local w, h = job_button:GetTextSize()
				job_button:SetTextPos((sub_category_width - w) / 2, (container_size.y - h) / 2 - image_size / 1.3)
				function job_button:DoClick()
					process.f4_menu.play_sound("click")

					open_category(job_category)
				end
			end	
		end

		-- shippment category
		local allowed_shipment = {}

		for _, shipment in pairs(CustomShipments) do
			if ( table.HasValue(shipment.allowed, LocalPlayer():Team()) ) then
				table.insert(allowed_shipment, shipment)					
			end
		end

		for _, ent in pairs(DarkRPEntities) do
			if (istable(ent.allowed) and table.HasValue(ent.allowed, LocalPlayer():Team()) ) then
				table.insert(allowed_shipment, ent)					
			end
		end

		if (#allowed_shipment > 0) then
			local entities_button = frame:Add("Process.f4_menu_category")
			entities_button:SetPos(frame_size.x - (space_betwwen_category_and_frame + category_size.x * 2 + space_between_category), 0)
			entities_button:SetText("OBJETS")
			entities_button:SetAnim(anim_duration, 0.6)
			function entities_button:DoClick()
				if (!open_menu) then
					process.f4_menu.play_sound("click")				
				end
	
				reset_container()
	
				container:Add("Process.f4_menu_list"):SetList(allowed_shipment)
			end
		end

		-- active a category
		timer.Simple(label.anim_start - SysTime(), function ()
			if (IsValid(jobs_button)) then
				jobs_button:DoClick(true)				
			end
		end)
    elseif (!input.IsKeyDown(KEY_F4)) then
		is_key_down = false
	end
end )