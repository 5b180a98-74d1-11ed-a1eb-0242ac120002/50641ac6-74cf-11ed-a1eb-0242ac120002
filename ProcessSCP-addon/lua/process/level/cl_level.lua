local last_xp = {level = nil, point = nil}

local hud_size_factor = 1
local responsive_factor = ScrW() / 1920 * hud_size_factor -- the hud is created for 1080p screen

local xp_bar_size = {x = 512 * responsive_factor, y = 32 * responsive_factor}
local space_between_screen_and_xp_bar = 18 * responsive_factor
local xp_bar_pos = { x = (ScrW() - xp_bar_size.x) / 2, y = ScrH() - xp_bar_size.y - space_between_screen_and_xp_bar}

local intern_xp_bar_pos = {x = xp_bar_pos.x + 11 * responsive_factor, y = xp_bar_pos.y + 13 * responsive_factor}
local intern_xp_bar_size = {x = 489 * responsive_factor, y = 10 * responsive_factor}

local function get_xp_bar_size(max_size)
    return last_xp.point / process.get_max_point_per_level(last_xp.level) * max_size
end

local xp_bar_contour = Material("hud/xp_bar.png")
local xp_bar_shape = {
    {x = 9, y = 12},
    {x = 0, y = 12},
    {x = 0, y = 24},
    {x = 15, y = 24}
}
for i, point in ipairs(xp_bar_shape) do
    point.x = point.x * responsive_factor + xp_bar_pos.x
    point.y = point.y * responsive_factor + xp_bar_pos.y
end

surface.CreateFont( "Process.level", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 15 * responsive_factor,
	weight = 1000 * responsive_factor,
} )
surface.CreateFont( "Process.point", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 15 * responsive_factor,
	weight = 1000 * responsive_factor,
} )

local get_hud_color = process.get_hud_color
local white = process.white
hook.Add("HUDPaint", "Process.level_hud", function ()
    local level = LocalPlayer():getDarkRPVar(process.darkrp.vars.level)
    local point = LocalPlayer():getDarkRPVar(process.darkrp.vars.point)

    if (last_xp.point != point or last_xp.level != level) then
        last_xp.level = level
        last_xp.point = point

        xp_bar_shape[2].x = get_xp_bar_size(intern_xp_bar_size.x) + intern_xp_bar_pos.x
        local width = xp_bar_shape[2].x - 6 * responsive_factor
        local min_width = intern_xp_bar_pos.x + 6 * responsive_factor
        xp_bar_shape[3].x = width >= min_width and width or min_width
    end

    if (point != 0) then
        surface.SetDrawColor(get_hud_color(white))
        draw.NoTexture()
        surface.DrawPoly(xp_bar_shape)
    end

    surface.SetDrawColor(get_hud_color(white))
    surface.SetMaterial(xp_bar_contour)
    surface.DrawTexturedRect(xp_bar_pos.x, xp_bar_pos.y, xp_bar_size.x, xp_bar_size.y)

    surface.SetFont( "Process.point" )
	surface.SetTextColor( get_hud_color(process.black))
    local point_text = (last_xp.point or 1).."/"..process.get_max_point_per_level((last_xp.level or 1))
    local point_text_width, point_text_height = surface.GetTextSize(point_text)
	surface.SetTextPos( (intern_xp_bar_size.x - point_text_width ) / 2 + intern_xp_bar_pos.x, (intern_xp_bar_size.y - point_text_height) / 2 + intern_xp_bar_pos.y) 
	surface.DrawText( point_text )

    surface.SetFont( "Process.level" )
	surface.SetTextColor(get_hud_color(white))
	surface.SetTextPos( 55 + xp_bar_pos.x, -3 + xp_bar_pos.y ) 
	surface.DrawText( "NIVEAU : "..(last_xp.level or 1) )
end)