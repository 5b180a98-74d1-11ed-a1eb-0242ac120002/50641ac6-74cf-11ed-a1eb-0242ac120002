// created by mtk. un dev payer par pocess quand zeki était pas la

local function ScaleX(val)
	return (val*ScrW())/1920
end
local function ScaleY(val)
	return (val*ScrH())/1080
end
    
surface.CreateFont("MTKDEV.HUDPROCESS:Font", {
    font = "Montserrat Classic",
    size = ScreenScale(15 / 3),
    width = 1000,
    extended = true
})
surface.CreateFont("MTKDEV.HUDPROCESS:Font2", {
    font = "Montserrat Classic",
    size = ScreenScale(26 / 3),
    width = 1000,
    extended = true
})
surface.CreateFont("MTKDEV.HUDPROCESS:Font2.5", {
    font = "Montserrat Classic",
    size = ScreenScale(22 / 3),
    width = 1000,
    extended = true
})
surface.CreateFont("MTKDEV.HUDPROCESS:Font3", {
    font = "Montserrat Classic",
    size = ScreenScale(25 / 3),
    width = 1000,
    extended = true
})
surface.CreateFont("MTKDEV.HUDPROCESS:Font4", {
    font = "Montserrat Classic",
    size = ScreenScale(30 / 3),
    width = 1000,
    extended = true
})

local oldhp, newhp, start = -1, -1, 0
local oldarmor, newarmor, startarmor = -1, -1, 0
local animationTime = 0.5

hook.Add("HUDPaint", "MTKDEV.HUDPROCESS:Main", function()
    if not LocalPlayer():Alive() then return end
    if not IsValid(LocalPlayer()) then return end

    local hp = LocalPlayer():Health()
	local maxhp = LocalPlayer():GetMaxHealth()

	if ( oldhp == -1 and newhp == -1 ) then
		oldhp = hp
		newhp = hp
	end

    if newhp > maxhp then newhp = maxhp end

    local smoothHP = Lerp( ( SysTime() - start ) / animationTime, oldhp, newhp )

    if newhp ~= hp then
		if ( smoothHP ~= hp ) then
			newhp = smoothHP
		end

		oldhp = newhp
		start = SysTime()
		newhp = hp
	end

    surface.SetDrawColor(44, 47, 51, 255)
    surface.DrawRect(ScaleX(10), ScaleY(975), ScaleX(math.max( 0, smoothHP ) / maxhp * 320), ScaleY(28))

    if LocalPlayer():Armor() ~= 0 then

        local armor = LocalPlayer():Armor()
        local maxarmor = LocalPlayer():GetMaxArmor()
    
        if ( oldarmor == -1 and nexarmor == -1 ) then
            oldarmor = armor
            newarmor = armor
        end
    
        if newarmor > maxarmor then newarmor = maxarmor end
    
        local smootharmor = Lerp( ( SysTime() - startarmor ) / animationTime, oldarmor, newarmor )
    
        if newarmor ~= armor then
            if ( smootharmor ~= armor ) then
                newarmor = smootharmor
            end
    
            oldarmor = newarmor
            startarmor = SysTime()
            newarmor = armor
        end

        surface.DrawRect(ScaleX(10), ScaleY(1015), ScaleX(math.max( 0, smootharmor ) / maxarmor * 320), ScaleY(28))

        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( Material("materials/mtk/hudprocess/armor.png") )
        surface.DrawTexturedRect( ScaleX(20), ScaleY(1020), 15, 15 ) 

        draw.SimpleText("ARMURE", "MTKDEV.HUDPROCESS:Font",ScaleX(50), ScaleY(1021), Color( 255, 255, 255, 255 ), 0, 0)
    end

    surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("materials/mtk/hudprocess/vie.png") )
	surface.DrawTexturedRect( ScaleX(20), ScaleY(980), 15, 15 ) 

    draw.SimpleText("SANTÉ", "MTKDEV.HUDPROCESS:Font",ScaleX(50), ScaleY(981), Color( 255, 255, 255, 255 ), 0, 0)
    
    if LocalPlayer():GetActiveWeapon() ~= nil then 
        if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

        if LocalPlayer():GetActiveWeapon():Clip1() == nil or LocalPlayer():GetActiveWeapon():Clip1() == -1 then return end

        local text = string.upper(LocalPlayer():GetActiveWeapon():GetPrintName()) .. " | " .. LocalPlayer():GetActiveWeapon():Clip1()
        local textlength = string.len(text)

        if textlength < 10 then textlength = textlength - 7
        elseif textlength < 30 and textlength > 20 then textlength = textlength + 10
        elseif textlength > 30 then textlength = textlength + 20
        end

        local frame = {
            {x = ScaleX(1795 - textlength * 6), y = ScaleY(980)}, -- bouger
            {x = ScaleX(1930), y = ScaleY(980)},
            {x = ScaleX(1930), y = ScaleY(1018)},
            {x = ScaleX(1810 - textlength * 6), y = ScaleY(1018)}, -- bouger
            {x = ScaleX(1795 - textlength * 6), y = ScaleY(1005)} -- bouger
        }

        surface.SetDrawColor(44, 47, 51, 255)
        draw.NoTexture()
        surface.DrawPoly(frame)


        surface.SetDrawColor(color_white)
        surface.SetMaterial( Material("materials/mtk/hudprocess/amo.png") )
        surface.DrawTexturedRect( ScaleX(1805 - textlength * 5.5), ScaleY(988), ScaleX(18.75), ScaleY(22.5) ) 
        
        draw.SimpleText(text, "MTKDEV.HUDPROCESS:Font2.5",ScaleX(1872) - textlength * 3, ScaleY(988), color_white, 1, 0)

        local ammos = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())

        surface.SetDrawColor(44,47,51, 255)
        surface.DrawRect(ScaleX(1850 - (string.len(ammos) * 4)), ScaleY(1021), ScaleX(70  + (string.len(ammos) * 4)), ScaleY(33))

        surface.SetDrawColor(color_white)
        surface.SetMaterial(Material("materials/mtk/hudprocess/chargeur.png"))
        surface.DrawTexturedRect(ScaleX(1858 - (string.len(ammos) * 4)), ScaleY(1026), ScaleX(18.75), ScaleY(22.5))
        
        draw.SimpleText(ammos, "MTKDEV.HUDPROCESS:Font3",ScaleX(1896 - (string.len(ammos) * 1.9)), ScaleY(1024), color_white, 1, 0)
    end
end)