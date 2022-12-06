process.f4_menu.size_factor = 1
process.f4_menu.responsive_factor = {x = ScrW() / 1920 * process.f4_menu.size_factor, y = ScrH() / 1080 * process.f4_menu.size_factor} -- the hud is created for 1080p screen
local responsive_factor = process.f4_menu.responsive_factor
process.f4_menu.min_responsive_factor = math.min(responsive_factor.x, responsive_factor.y)
local min_responsive_factor = process.f4_menu.min_responsive_factor

process.f4_menu.label_size = {x = 77 * responsive_factor.x, y = 970 * responsive_factor.y}
process.f4_menu.category_size = {x = 363 * responsive_factor.x, y = 92 * responsive_factor.y}
process.f4_menu.return_buttton = {x = 100 * responsive_factor.x, y = 10 * responsive_factor.y}

surface.CreateFont( "Process.f4_menu_name", {
	font = "Arial",
	size = 65 * min_responsive_factor,
	weight = 1000 * min_responsive_factor,
} )
surface.CreateFont( "Process.f4_menu_category", {
	font = "Arial",
	size = 45 * min_responsive_factor,
	weight = 750 * min_responsive_factor,
} )
surface.CreateFont( "Process.f4_menu_money_lvl", {
	font = "Arial",
	size = 30 * min_responsive_factor,
	weight = 500 * min_responsive_factor,
} )
surface.CreateFont( "Process.f4_menu_sub_category", {
	font = "Arial",
	size = 25 * min_responsive_factor,
	weight = 400 * min_responsive_factor,
} )

process.f4_menu.hover_horizontal_material = Material("f4_menu/hover_horizontal.png")
process.f4_menu.hover_vertical_material = Material("f4_menu/hover_vertical.png")
process.f4_menu.list_material = Material("f4_menu/list.png")

process.f4_menu.job_category_material = {
	["Civil"] = Material("f4_menu/civil.png"),
	["Scientifique"] = Material("f4_menu/scientifique.png"),
	["Sécurité"] = Material("f4_menu/securite.png"),
	["Administration"] = Material("f4_menu/administration.png"),
	["Logistique"] = Material("f4_menu/logistique.png"),
	["Logistique"] = Material("f4_menu/logistique.png"),
	["SCP"] = Material("f4_menu/scp.png"),
	["Staff"] = Material("f4_menu/staff.png"),
}

process.f4_menu.job_sub_category_material = {
	// sécu
	["forces d'Intervention Mobiles"] = Material("f4_menu/FIM.png"),
	["agent de Sécurité"] = Material("f4_menu/securite.png"),
	["agent d'Intervention Tactique"] = Material("f4_menu/AIT.png"),
	["garde rapprochée et sentinelles"] = Material("f4_menu/surveillance rapprochee et sentinelles.png"),
	// civil
	["class renouvelable"] = Material("f4_menu/class renouvelable.png"),
	["groupe d'intérêt"] = Material("f4_menu/groupe d'interet.png"),
	// SCP
	["safe"] = Material("f4_menu/safe.png"),
	["euclide"] = Material("f4_menu/euclide.png"),
	["keter"] = Material("f4_menu/keter.png"),
}

process.f4_menu.sounds = {
	open = Sound("f4_menu/ouverture.mp3"),
	click = Sound("f4_menu/click.mp3"),
	hover = Sound("f4_menu/hover.mp3"),
}

function process.f4_menu.play_sound(sound)
	surface.PlaySound(process.f4_menu.sounds[sound])
end