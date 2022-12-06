-- hide hud to replace or just hid
local hide = {
    -- default HUD
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
    -- DarkRP HUD
    ["DarkRP_LocalPlayerHUD"] = true,
    ["DarkRP_Hungermod"] = true,
    ["DarkRP_ChatReceivers"] = true, -- hud that says who can hear you
}
hook.Add( "HUDShouldDraw", "Process.hide_default_hud", function( name )
    if ( hide[ name ] ) then
		return false
	end
end)