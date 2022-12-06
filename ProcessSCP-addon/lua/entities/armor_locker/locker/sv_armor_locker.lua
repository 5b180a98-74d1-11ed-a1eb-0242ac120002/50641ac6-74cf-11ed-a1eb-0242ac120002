local net_name = process.armor_locker.net_name
util.AddNetworkString(net_name)

local var_weapon_class_index = process.armor_locker.var_weapon_class_index 
local var_class = process.armor_locker.var_class

net.Receive(net_name, function (len, ply)
    if process.ASR.is_empty() then return end
    
    local class_group = process.armor_locker.weapons[net.ReadUInt(8)]
    if !class_group then
        print(ply:SteamID().." a envoyé un group de class invalide")
        return
    end

    for _, ent in pairs(ents.GetAll()) do
        if (ent:GetClass() == "armor_locker" and ent:GetPos():Distance(ply:GetPos()) < process.config.min_distance_armor_locker) then
            for _, job in pairs(class_group.jobs) do
                if (ply:Team() == job) then
                    local class_index = net.ReadUInt(8)
                    local class = class_group[class_index]
                    if (!class) then
                        print(ply:SteamID().." a envoyé une class invalide")
                        return
                    end
        
                    local weapon_class_index = net.ReadUInt(8)
                    if (!weapon_class_index or weapon_class_index > class.limit) then
                        print(ply:SteamID().." tente de prendre plus d'arme qu'autorisé !!!!")
                        return
                    end
        
                    local weapon = class.weapons[net.ReadUInt(8)] // class but for class = weapon:GetClass()
                    if (!weapon) then
                        print(ply:SteamID().." a envoyé une arme invalide")
                        return
                    end
        
                    if (ply:getDarkRPVar("money") < weapon.price) then
                        return
                    end
        
                    for _, owned_weapon in pairs(ply:GetWeapons()) do
                        if (owned_weapon:GetNWInt(var_class) == class_index and owned_weapon:GetNWInt(var_weapon_class_index) == weapon_class_index) then
                            ply:StripWeapon(owned_weapon:GetClass())
                            break
                        end
                    end
        
                    local new_weapon = ply:Give(weapon.name)
                    if (IsValid(new_weapon)) then
                        new_weapon:SetNWInt(var_class, class_index)
                        new_weapon:SetNWInt(var_weapon_class_index, weapon_class_index)
        
                        ply:addMoney(-weapon.price)
                    end
        
                    return 
                end
            end
        end
    end

    print(ply:SteamID().." a tenter d'utilisé l'armurie sans autorisation !!!")
end)