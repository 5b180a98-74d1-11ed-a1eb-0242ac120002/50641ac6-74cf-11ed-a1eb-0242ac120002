if (CLIENT) then
    local upper_char = {
        ["é"] = "É",
        ["ê"] = "Ê",
        ["à"] = "À",
        ["î"] = "Î",
        ["è"] = "È",
        ["ç"] = "Ç",
        ["â"] = "Â",
        ["ô"] = "Ô",
        ["û"] = "Û",
    }
    
    function process.upper(text)
        for low_char, up_char in pairs(upper_char) do
            text = string.Replace(text, low_char, up_char)
        end
    
        return string.upper(text)
    end

    -- to modifi alpha with process.hud_alpha
    function process.get_hud_color(color) 
        local alpha = process.hud_alpha - ( 255 - color.a )

        return {r = color.r, g = color.g, b = color.b, a = alpha > 0 and alpha or 0 }
    end

    function process.get_weapon_print_name(weapon_name)
        return process.upper(weapons.Get(weapon_name) and weapons.Get(weapon_name).PrintName or weapon_name)
    end
end