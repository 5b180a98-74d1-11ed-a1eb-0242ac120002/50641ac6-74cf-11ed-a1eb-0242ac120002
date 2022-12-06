local net_name = process.armor_locker.net_name_uits
util.AddNetworkString(net_name)

local class_var_name = "Process.uits_class_index"

net.Receive(net_name, function (len, ply)   
    if process.ASR.is_empty() then return end

    local class_index = net.ReadUInt(8)
    local class = process.armor_locker.uits_classes[class_index] // TODO check if nil index create an error

    if (!class) then
        print(ply:SteamID().." a envoyé un class d'uits invalide !!!")
        return 
    end

    for _, ent in pairs(ents.GetAll()) do
        if (ent:GetClass() == "armor_locker" and ent:GetPos():Distance(ply:GetPos()) < process.config.min_distance_armor_locker) then
            if (ply:Team() != TEAM_UITS) then
                return 
            end
            
            ply:SetNWInt(class_var_name, class_index)
            
            ply:SetModel(class.model or process.darkrp.models.UITS[1])

            ply:SetRunSpeed(ply:getJobTable().runspeed * class.force)
            ply:SetJumpPower(ply:getJobTable().jumppower * class.force)

            if (class.bodygroups) then
                for _, bodygroup in pairs(class.bodygroups) do
                    ply:SetBodygroup(bodygroup.id, bodygroup.values[1])
                end
            end

            if (class.skin) then
                ply:SetSkin(class.skin)
            end
            
            for _, weapon in pairs(ply:GetWeapons()) do
                if (weapon.is_uits_weapon) then
                    weapon:Remove()
                end
            end

            for _, weapon in pairs(class.weapons) do
                ply:Give(weapon).is_uits_weapon = true
            end
            
            return 
        end
    end
end)

local function remove_class(ply)
    ply:SetNWInt(class_var_name, 0)
end

hook.Add("PlayerDeath", "Process.uits_locker.player_die", remove_class)
hook.Add("PlayerChangedTeam", "Process.uits_locker.PlayerChangedTeam", remove_class)

hook.Add("is_model_modification_blocked", "Process.uits_locker.is_model_modification_blocked", function (ply)
    local class = process.armor_locker.uits_classes[ply:GetNWInt(class_var_name)]
    if (class and class.model) then
        return true
    end
end)

hook.Add("is_skin_modification_blocked", "Process.uits_locker.is_skin_modification_blocked", function (ply)
    local class = process.armor_locker.uits_classes[ply:GetNWInt(class_var_name)]
    if (class and class.skin) then
        return true
    end
end)

hook.Add("is_bg_modification_blocked", "Process.uits_locker.is_bg_modification_blocked", function (ply, data)
    local class = process.armor_locker.uits_classes[ply:GetNWInt(class_var_name)]
    if (class) then
        if (class.bodygroups) then
            for _, bodygroup in pairs(class.bodygroups) do
                if (data[1] == bodygroup.id) then
                    return !table.HasValue(bodygroup.values, data[2])
                end
            end
        end
    end
end)