local authorized_pins = {}

local model_scale = 0.5
local bone_name = "ValveBiped.Bip01_Spine2"

local offsetvec = Vector( 6, 7.5, 3 )
local offsetang = Angle( 0, 90, 90 )

local selected_pins_model
local remove_button

net.Receive("Process.authorized_pins", function (len, ply)
	authorized_pins = net.ReadTable()
end)

local function enable_remove_button(enable)
	remove_button:SetVisible(enable)
	remove_button:SetEnabled(enable)
end

local function send_model(model_index)
	net.Start("Process.pins")
	net.WriteInt(model_index, 32)
	net.SendToServer()
end

local function is_authorized(model_index)
	if (LocalPlayer():HasPermission("authorize all pins") or process.pins.DONATOR_STATUTS[model_index] <= LocalPlayer():getDarkRPVar(process.darkrp.vars.donator)) then
		return true
	end

	for pins_index, pins in ipairs(authorized_pins) do
		if (model_index == pins) then
			return true
		end
	end

	return false
end

local function get_offset(ply)
	return process.pins.OFFSETS[ply:GetVar("model_group_key")] or Vector(0, 0, 0)
end

-- draw client side models
hook.Add( "PostPlayerDraw" , "Process.pins_draw" , function( ply )
	local model_index = ply:getDarkRPVar(process.darkrp.vars.pins)

	if (model_index == 0 or model_index == nil) then//if has no pins
        return
    end

	local model = process.pins.MODELS[model_index]
	
	local boneid = ply:LookupBone( bone_name )
	
	if not boneid then
		return
	end
	
	local matrix = ply:GetBoneMatrix( boneid )
	
	if not matrix then 
		return 
	end

	local newpos, newang = LocalToWorld( offsetvec + get_offset(ply), offsetang, matrix:GetTranslation(), matrix:GetAngles() )
    local drawed_model = ply:GetVar("pins_model")

    if (!IsValid(drawed_model)) then
        drawed_model = ClientsideModel(model)
        drawed_model:SetNoDraw( true )
		drawed_model:SetModelScale(model_scale)
        ply:SetVar("pins_model", drawed_model)
    end

	if (drawed_model:GetModel() != model) then//when the model is changed
		drawed_model:SetModel(model)
	end
	
	drawed_model:SetPos( newpos )
	drawed_model:SetAngles( newang )
	drawed_model:SetupBones()
	drawed_model:DrawModel()
end)

//add button to choose pins in context menu
list.Set("DesktopWindows", "Pins", {

	title		= "Pins",
	icon		= "context_menu/pins_icon.png",
	width		= 0, -- don't care will be redefined
	height		= 0, -- don't care will be redefined
	onewindow	= true,
	init		= function(icon, frame)
		local hud_size_factor = 1
		local responsive_factor = ScrW() / 1920 * hud_size_factor -- the hud is created for 1080p screen
		local task_bar_height = 25 * responsive_factor
		local icon_size = 64 * responsive_factor
		local spacing = 5 * responsive_factor
		local List_size = {x = icon_size * 4 + spacing * 3, y = icon_size * 2 + spacing}
		local remove_button_height = 20 * responsive_factor
		local DModelPanel_size = 200 * responsive_factor
		local List_pos_y = task_bar_height
		local remove_button_pos_y = 1 + List_pos_y + List_size.y
		local player_model_pos_y = 1 + remove_button_pos_y + remove_button_height

		function frame:Paint(w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color( 36, 37, 38, 171) )
		end
		function frame:OnClose()
			if (IsValid(selected_pins_model)) then
				selected_pins_model:Remove()
			end
		end
		frame:SetTitle( "Choisis ton pins" )
		frame:SetSize( List_size.x, List_size.y + remove_button_height + DModelPanel_size + task_bar_height)
		frame:Center()

		local localPlayer_model_index = LocalPlayer():getDarkRPVar(process.darkrp.vars.pins)

		if (localPlayer_model_index != 0) then//if has no pins
			selected_pins_model = ClientsideModel(process.pins.MODELS[localPlayer_model_index])
			selected_pins_model:SetModelScale(model_scale)
			selected_pins_model:SetNoDraw(true)
		end

		-- layout of the pins
		local List = vgui.Create( "DIconLayout", frame )
		List:SetSpaceY( spacing )
		List:SetSpaceX( spacing )
		List:SetSize(List_size.x, List_size.y)
		List:SetPos(0, List_pos_y)

		for model_index = 1, #process.pins.MODELS do 
			if (is_authorized(model_index)) then
				local model = process.pins.MODELS[model_index]
				
				local icon = List:Add( "SpawnIcon" )
				icon:SetSize(icon_size, icon_size)
				icon:SetModel(model)
				icon:SetTooltip(process.pins.TITLES[model_index])
				
				function icon:DoClick()
					if (!is_authorized(model_index)) then-- if the button still appear because the authorization just changed
						return 
					end

					if (!remove_button:IsEnabled()) then
						enable_remove_button(true)
					end

					if (LocalPlayer():getDarkRPVar(process.darkrp.vars.pins) != model_index) then
						send_model(model_index)
					end

					if (IsValid(selected_pins_model)) then
						if (selected_pins_model:GetModel() != model) then
							selected_pins_model:SetModel(model)
						end
					else
						selected_pins_model = ClientsideModel(model)
						selected_pins_model:SetNoDraw(true)
						selected_pins_model:SetModelScale(model_scale)
					end
				end
			end
		end

		remove_button = frame:Add("DButton")
		remove_button:SetPos(0, remove_button_pos_y)
		remove_button:SetSize(List_size.x, remove_button_height)
		remove_button:SetText("Retirer son pins")
		remove_button.OwnLine = true
		remove_button:SetTextColor(Color(255, 255, 255))
		function remove_button:Paint(w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 161) )
		end
		function remove_button:DoClick()
			enable_remove_button(false)

			send_model(0)

			if (IsValid(selected_pins_model)) then
				selected_pins_model:Remove()
			end
		end

		if (localPlayer_model_index == 0) then
			enable_remove_button(false)
		end

		local player_model = vgui.Create( "DModelPanel", frame )
		player_model:SetSize( DModelPanel_size, DModelPanel_size )
		player_model:SetModel( LocalPlayer():GetModel() )
		player_model:SetPos(0, player_model_pos_y)
		function player_model:LayoutEntity( Entity ) return end -- disables default rotation
		function player_model:LayoutEntity(ent)
				
			-- If ent has been removed somehow then remove screen
			if(!IsValid(ent)) then
				if(player_model:GetParent()) then player_model:GetParent():Remove() end
				return
			end

			local boneid = ent:LookupBone( bone_name )
			
			if not boneid then
				return
			end

			local matrix = ent:GetBoneMatrix( boneid )
			
			if not matrix then 
				return 
			end

			local newpos, newang = LocalToWorld( offsetvec + get_offset(LocalPlayer()), offsetang, matrix:GetTranslation(), matrix:GetAngles() )

			player_model:SetCamPos(newpos + Vector(8, 0, 0))
			player_model:SetLookAt(newpos)
			
			return
		end

		function player_model:PostDrawModel(ent)
			if (!IsValid(selected_pins_model)) then
				return 
			end

			local boneid = ent:LookupBone( bone_name )
			
			if not boneid then
				return
			end
			
			local matrix = ent:GetBoneMatrix( boneid )
			
			if not matrix then 
				return 
			end
			
			local newpos, newang = LocalToWorld( offsetvec + get_offset(LocalPlayer()), offsetang, matrix:GetTranslation(), matrix:GetAngles() )

			selected_pins_model:SetPos( newpos )
			selected_pins_model:SetAngles( newang )
			selected_pins_model:SetupBones()
			selected_pins_model:DrawModel()
		end
	end
})