// fait par rimura qui est mauvais en dév. Donc Zekigras est repassé dessus. y'a moyen que ça soit illisible

// sql setup for checking warning
local sql_table_name = "Process_motd_warning"
if (!sql.TableExists(sql_table_name)) then
	sql.Query( "CREATE TABLE "..sql_table_name.." ( checked BOOLEAN )" )
	sql.Query("INSERT INTO "..sql_table_name.."(checked) VALUES(0)")
end

local scale_factor = 1.0
local responsive_factor = math.min(ScrW() / 1920, ScrH() / 1080) * scale_factor

surface.CreateFont( "process_font1", {
	font = "Montserrat",
	size = 30 * responsive_factor, 
	weight = 0, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )

surface.CreateFont( "process_font2", {
	font = "Montserrat",
	size = 70 * responsive_factor, 
	weight = 10, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )

surface.CreateFont( "process_font3", {
	font = "Montserrat",
	size = 100 * responsive_factor, 
	weight = 10, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )

// enter screen
local enter_screen_living_duration = 3
local enter_screen_disapear_animation_duration = 1

// backgrounds image
local time_repaint = 3.5 --temps entre changement d'images
local transition_time = 1.2

local backgrounds_path = "motd/backgrounds/"
local files = file.Find( "materials/"..backgrounds_path.."*", "GAME" )

local backgrounds = {}
for i = 1, table.Count(files) do
	local value, key = table.Random(files)
	files[key] = nil // remove by index

	local mat = Material(backgrounds_path..value)
	table.insert(backgrounds, mat)
end

-- Musique
local MusicURL = "https://airborne-gmod.ouiweb.eu/musique/black_mesa_OST_-_end_credit_2_remix.mp3"

local MusicVolume = 2

local music_fade_out_duration = 3

-- DLabel
local orange = process.orange

local BackgroundLabel = Color( 0, 0, 0, 100)

local CreditsLabel = [[
・Fondateur :

AurélienJeCrois - Zekirax
	
・Visuels Designs ・ Sound Designer ・ Développement ・ Map ・ Posing ・ Voix ・ Models : 

Lux - Zekirax - Endrow - B1B1 - Rimura - Jesse - Mensions - Hina
David avec un grand D - Maillard - will - Sombre Nuit - Willy Wood 
Hiroshmit - McKenzie - Black - Zekirax - Lucie.

・Map Originale : site 27 [veeds - feeds].

・Vous : Force du projet]]

local DiscordURL = "https://discord.gg/process"

local WebSiteURL = "https://process.noclip.me"

local processtheme

local frame_image
hook.Add("InitPostEntity", "Process.motd", function ()	
	sound.PlayURL( MusicURL, "noblock", function( processtheme_callback ) // flag noclock to EnableLooping
		processtheme = processtheme_callback
		if ( IsValid( processtheme ) ) then
			processtheme:SetVolume( MusicVolume )
			processtheme:EnableLooping(true)
		end
	end )
	
	// background
	frame_image = vgui.Create( "DImage" )
	frame_image:SetSize(ScrW() * scale_factor, ScrH() * scale_factor)
	// transition image background
	local time_to_change = SysTime() + time_repaint
	local background_to_paint_last_index
	local background_to_paint_index = 1
	local in_transition = false

	function frame_image:Paint(w, h)
		if (in_transition) then
			surface.SetDrawColor(color_white)
			surface.SetMaterial(backgrounds[background_to_paint_last_index])
			surface.DrawTexturedRect(0, 0, w, h)
			
			local alpha = (SysTime() - time_to_change) / transition_time * 255
			surface.SetDrawColor(Color(255, 255, 255, alpha))
			surface.SetMaterial(backgrounds[background_to_paint_index])
			surface.DrawTexturedRect(0, 0, w, h)

			if (alpha >= 255) then
				time_to_change = SysTime() + time_repaint
				in_transition = false				
			end
		else
			surface.SetDrawColor(color_white)
			surface.SetMaterial(backgrounds[background_to_paint_index])
			surface.DrawTexturedRect(0, 0, w, h)

			if (SysTime() > time_to_change) then
				background_to_paint_last_index = background_to_paint_index
				background_to_paint_index = background_to_paint_index == #backgrounds and 1 or background_to_paint_index + 1
	
				in_transition = true
			end
		end
	end

	gui.EnableScreenClicker(true)
		
	-- Check SQL le warning photosensible
	if (!tobool(sql.QueryValue( "SELECT checked FROM "..sql_table_name))) then
		// warning
		local frame_warning_labelframe = vgui.Create("DFrame")
		frame_warning_labelframe:SetDraggable( false )
		frame_warning_labelframe:ShowCloseButton( false )
		frame_warning_labelframe:SetTitle("")
		frame_warning_labelframe:SetPos( ScrH() / 6 * scale_factor, 250 * responsive_factor)					
		frame_warning_labelframe:SetSize( 1500 * responsive_factor, 600 * responsive_factor )
		frame_warning_labelframe.Paint = function(self,w,h)
			draw.RoundedBox(0, 0, 0, w, h, BackgroundLabel )
		end
		
		local frame_warning_labeltitle = vgui.Create("DLabel")
		frame_warning_labeltitle:SetText( "Avertissement de saisie photosensible" )	
		frame_warning_labeltitle:SetContentAlignment(5)
		frame_warning_labeltitle:SetPos( ScrH() / 2.7 * scale_factor, 100 * responsive_factor)					
		frame_warning_labeltitle:SetSize( 1000 * responsive_factor, 100 * responsive_factor )
		frame_warning_labeltitle:SetTextColor( orange )
		frame_warning_labeltitle:SetFont( "process_font1" )
		frame_warning_labeltitle.Paint = function(self,w,h)
			draw.RoundedBox(0, 0, 0, w, h, BackgroundLabel )
		end
		
		local frame_warning_label1 = vgui.Create("DLabel")
		frame_warning_label1:SetText( [[Un faible pourcentage de personnes peut avoir une crise d'épilepsie lorsqu'elles s'exposent à certaines images visuelles, notamment des voyants ou des motifs clignotants qui s'affichent dans les jeux vidéo. Les personnes qui n'ont jamais eu de crise d'épilepsie peuvent également être sujets à des « crises d'épilepsie photosensibles » en jouant à des jeux vidéo. 
		 
		Cessez de jouer immédiatement et consultez un médecin si vous souffrez de l'un de ces symptômes. Ces crises d'épilepsie se traduisent par différents symptômes, notamment des étourdissements, une vision altérée, des contractions oculaires ou faciales, des secousses dans les bras ou les jambes, la désorientation, la confusion ou la perte de conscience momentanée. Des crises d'épilepsie peuvent également entraîner des blessures provoquées par une chute ou un choc sur des objets à proximité après une perte de connaissance ou des convulsions.]] )	
		frame_warning_label1:SetContentAlignment(7)
		frame_warning_label1:SetWrap(true)
		frame_warning_label1:SetPos( ScrH() / 5.8 * scale_factor, ScrH() / 4.1 * scale_factor )					
		frame_warning_label1:SetSize( 1500 * responsive_factor, 600 * responsive_factor )
		frame_warning_label1:SetTextColor( orange )
		frame_warning_label1:SetFont( "process_font1" )
		
		local frame_warning_label2 = vgui.Create("DLabel")
		frame_warning_label2:SetText( [[Les parents doivent surveiller ou interroger leurs enfants concernant l’apparition des symptômes susmentionnés. Les enfants et les adolescents sont plus sujets à ces types de crises que les adultes. Vous pouvez limiter les risques de crises d'épilepsie photosensibles en prenant les précautions suivantes : 
		 
		· Jouez dans une pièce bien éclairée. 
		· Ne jouez pas si vous êtes somnolent ou fatigué. 
		 
		Si l'un des membres de votre famille ou vous-même avez déjà eu des crises d'épilepsie, consultez un médecin avant de jouer à des jeux vidéo.]] )	
		frame_warning_label2:SetContentAlignment(7)
		frame_warning_label2:SetWrap(true)
		frame_warning_label2:SetPos( ScrH() / 5.8 * scale_factor, ScrH() / 1.9 * scale_factor )					
		frame_warning_label2:SetSize( 1500 * responsive_factor, 600 * responsive_factor )
		frame_warning_label2:SetTextColor( orange )
		frame_warning_label2:SetFont( "process_font1" )
		
		local frame_warning_label5 = vgui.Create("DLabel")
		frame_warning_label5:SetText( "" )	
		frame_warning_label5:SetContentAlignment(7)
		frame_warning_label5:SetWrap(true)
		frame_warning_label5:SetPos( ScrH() / 5.8 * scale_factor, ScrH() / 1.9 * scale_factor )					
		frame_warning_label5:SetSize( 1500, 600 )
		frame_warning_label5:SetTextColor( orange )
		frame_warning_label5:SetFont( "process_font1" )
		
		local frame_warning_agree = vgui.Create("DButton")
		frame_warning_agree:SetText( "Acceptez vous les termes ?" )					
		frame_warning_agree:SetPos( ScrW() / 2.7 * scale_factor, 925 * responsive_factor)				
		frame_warning_agree:SetSize( 500 * responsive_factor, 75 * responsive_factor )
		frame_warning_agree:SetTextColor( orange )
		frame_warning_agree:SetFont( "process_font1" )
		frame_warning_agree.Paint = function(self,w,h)
			draw.RoundedBox(0, 0, 0, w, h, BackgroundLabel )
		end
		frame_warning_agree.DoClick = function()
			surface.PlaySound( "motd/SFX_PROCESS_agree_.wav" )
			frame_warning_labeltitle:Remove()
			frame_warning_labelframe:Remove()
			frame_warning_label1:Remove()
			frame_warning_label2:Remove()
			frame_warning_agree:Remove()
			process_motd2()

			sql.Query("UPDATE "..sql_table_name.." SET checked = 1;")
		end
		frame_warning_agree.OnCursorEntered = function()
			surface.PlaySound("f4_menu/hover.mp3")
		end
	else
		process_motd2()
	end

	// enter screen. will be on everything
	local enter_screen = vgui.Create("DImage")
	enter_screen:SetMaterial(Material("motd/enter.png"))
	enter_screen:SetSize(ScrW(), ScrH())
	enter_screen:AlphaTo(0, enter_screen_disapear_animation_duration, enter_screen_living_duration, function (_, pnl)
		pnl:Remove()
	end)
end)

// main frame
function process_motd2()
	local frame_logo = vgui.Create("DImage", frame_image)
	frame_logo:SetSize(1080 * responsive_factor,250 * responsive_factor)
	frame_logo:SetMaterial("motd/process.png")
	frame_logo:SetPos(100 * responsive_factor, 100 * responsive_factor)
	
	local link_margin = 10 * responsive_factor
	local links_pos = {x = 1485, y = 792}
	local links_panel = vgui.Create("EditablePanel")
	links_panel:SetPos(links_pos.x, links_pos.y)

	local frame_discord_button = links_panel:Add("DButton")
	frame_discord_button:SetText( "Discord" )				
	frame_discord_button:SetFont( "process_font1" )
	local discord_link_w, discord_link_h = frame_discord_button:GetTextSize()
	frame_discord_button:SetPos(0, 0)					
	frame_discord_button:SetTextColor( orange )
	function frame_discord_button:Paint(w, h)
		draw.RoundedBox(0,0,0, w, h, BackgroundLabel)
	end
	frame_discord_button.DoClick = function() 
		gui.OpenURL(DiscordURL)
	end

	local frame_website_button = links_panel:Add("DButton")
	frame_website_button:SetText( "Site Internet" )				
	frame_website_button:SetFont( "process_font1" )
	frame_website_button:SetPos(0, link_margin * 3 + discord_link_h)					
	local link_website_w = frame_website_button:GetTextSize()
	frame_website_button:SetTextColor( orange )
	function frame_website_button:Paint(w, h)
		draw.RoundedBox(0,0,0, w, h, BackgroundLabel)
	end
	frame_website_button.DoClick = function() 
		gui.OpenURL(WebSiteURL)
	end

	local links_weight = link_margin * 2 + math.max(discord_link_w, link_website_w)
	links_panel:SetSize(links_weight, discord_link_h * 2 + link_margin * 5)

	frame_discord_button:SetSize(links_weight, discord_link_h + link_margin * 2)
	frame_website_button:SetSize(links_weight, discord_link_h + link_margin * 2)

	local frame_play_button
	local frame_settings_button
	local frame_credits_button
	
	frame_play_button = vgui.Create("DButton")
	frame_play_button:SetText( "JOUER" )					
	frame_play_button:SetPos( 200 * responsive_factor, 500 * responsive_factor )					
	frame_play_button:SetSize( 500 * responsive_factor, 75 * responsive_factor )
	frame_play_button:SetTextColor( orange )
	frame_play_button:SetFont( "process_font2" )
	frame_play_button.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, BackgroundLabel )
	end
	frame_play_button.DoClick = function()
		surface.PlaySound( "f4_menu/click.mp3" )
		frame_image:Remove()
		links_panel:Remove()
		frame_play_button:Remove()
		frame_settings_button:Remove()
		frame_credits_button:Remove()

		local fade_out_end = SysTime() + music_fade_out_duration
		local timer_name = "Process.motd_sound_fade_out"
		timer.Create(timer_name, 0, 0, function ()
			if (IsValid(processtheme)) then
				local volume = (fade_out_end - SysTime()) / music_fade_out_duration * MusicVolume
				if (volume < 0) then
					processtheme:Stop()
					timer.Stop(timer_name)
				else
					processtheme:SetVolume(volume)
				end
			else
				timer.Stop(timer_name)
			end
		end)

		gui.EnableScreenClicker(false)
	end
	frame_play_button.OnCursorEntered = function()
		surface.PlaySound("f4_menu/hover.mp3")
	end
	
	frame_settings_button = vgui.Create("DButton")
	frame_settings_button:SetText( "PARAMÈTRES" )				
	frame_settings_button:SetPos( 200 * responsive_factor, 600 * responsive_factor )					
	frame_settings_button:SetSize( 500 * responsive_factor, 75 * responsive_factor )
	frame_settings_button:SetTextColor( orange )
	frame_settings_button:SetFont( "process_font2" )
	frame_settings_button.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, BackgroundLabel )
	end
	frame_settings_button.DoClick = function()
		surface.PlaySound( "f4_menu/click.mp3" )
		RunConsoleCommand("showconsole")
		RunConsoleCommand( "gamemenucommand", "OpenOptionsDialog" )
	end
	frame_settings_button.OnCursorEntered = function()
		surface.PlaySound("f4_menu/hover.mp3")
	end
	
	frame_credits_button = vgui.Create("DButton")
	frame_credits_button:SetText( "CRÉDITS" )					
	frame_credits_button:SetPos( 200 * responsive_factor, 700 * responsive_factor )					
	frame_credits_button:SetSize( 500 * responsive_factor, 75 * responsive_factor )
	frame_credits_button:SetTextColor( orange )
	frame_credits_button:SetFont( "process_font2" )
	frame_credits_button.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, BackgroundLabel )
	end
	frame_credits_button.DoClick = function()
		surface.PlaySound( "motd/SFX_PROCESS_ouverture.wav" )
		frame_logo:Remove()
		links_panel:Remove()
		frame_play_button:Remove()
		frame_settings_button:Remove()
		frame_credits_button:Remove()
		process_motd3()
	end
	frame_credits_button.OnCursorEntered = function()
		surface.PlaySound("f4_menu/hover.mp3")
	end
end

-- Frame Credits
function process_motd3()
	local frame_credits = vgui.Create("DFrame")
	frame_credits:SetDraggable( false )
	frame_credits:ShowCloseButton( false )
	frame_credits:SetTitle("")
	frame_credits:SetPos( ScrH() / 6 * scale_factor, 250 * responsive_factor )					
	frame_credits:SetSize( 1500 * responsive_factor, 660 * responsive_factor )
	frame_credits.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), BackgroundLabel )
	end

	local frame_credits_label1 = vgui.Create("DLabel")
	frame_credits_label1:SetText( "CRÉDITS" )	
	frame_credits_label1:SetFont( "process_font3" )
	frame_credits_label1:SetContentAlignment(5)
	frame_credits_label1:SetPos( ScrH() / 5.8 * scale_factor, 100 * responsive_factor )
	local w = frame_credits_label1:GetTextSize()					
	frame_credits_label1:SetSize( w, 100 * responsive_factor )
	frame_credits_label1:SetTextColor( orange )
	frame_credits_label1.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, BackgroundLabel )
	end

	local frame_credits_label2 = vgui.Create("DLabel")
	frame_credits_label2:SetText( CreditsLabel )	
	frame_credits_label2:SetContentAlignment(7)
	frame_credits_label2:SetWrap(true)
	frame_credits_label2:SetPos( ScrH() / 5.8 * scale_factor, ScrH() / 4.1 * scale_factor )					
	frame_credits_label2:SetSize( 1500 * responsive_factor, 700 * responsive_factor )
	frame_credits_label2:SetWrap(true)			
	frame_credits_label2:SetTextColor( orange )
	frame_credits_label2:SetFont( "process_font1" )

	local frame_credits_return = vgui.Create("DButton")
	frame_credits_return:SetText( "Retour" )					
	frame_credits_return:SetPos(  ScrW() / 2.7 * scale_factor, 925 * responsive_factor )					
	frame_credits_return:SetSize( 500 * responsive_factor, 75 * responsive_factor )
	frame_credits_return:SetTextColor( orange )
	frame_credits_return:SetFont( "process_font1" )
	frame_credits_return.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, BackgroundLabel )
	end
	frame_credits_return.DoClick = function()
		surface.PlaySound( "f4_menu/click.mp3" )
		frame_credits:Remove()
		frame_credits_label1:Remove()
		frame_credits_label2:Remove()
		frame_credits_return:Remove()
		process_motd2()
	end
	frame_credits_return.OnCursorEntered = function()
		surface.PlaySound("f4_menu/hover.mp3")
	end
end