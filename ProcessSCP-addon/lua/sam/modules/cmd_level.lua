sam.command.set_category("Process") -- any new command will be in that category unless the command uses :SetCategory function

local name = "setlevel"
sam.command.new(name)
    :SetPermission(name, "superadmin") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Définit les point et le niveau.")

	:AddArg("player",{
        hint = "joueur(s)"
    })

    :AddArg("number", {
        min = 1,
        hint = "niveau",
        round = true
    })

    :AddArg("number", {
        min = 0,
        hint = "point",
        round = true
    })
	
    :OnExecute(function(calling_ply, targets, level, point)
		for i, ply in ipairs(targets) do
            process.sql.level.set(ply:SteamID(), level, point)
            process.set_level(ply, level, point)
        end

        sam.player.send_message(nil--[[will send to all player]], "{A} a définit le niveau à {V_1} et les point à {V_2} pour {T}", {
			A = calling_ply, T = targets, V_1 = level, V_2 = point
		})
    end)
:End()

name = "getlevel"
sam.command.new(name)
    :SetPermission(name, "user") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Obtient les point et le niveau.")

	:AddArg("player",{
        hint = "joueur(s)"
    })
	
    :OnExecute(function(calling_ply, targets)
		for i, ply in ipairs(targets) do            
            sam.player.send_message(calling_ply, "{A} est niveau {S_1 Green} et a {S_2 Green} point(s) sur {S_3 Black}.", {
                A = calling_ply, S_1 = ply:getDarkRPVar(process.darkrp.vars.level), S_2 = ply:getDarkRPVar(process.darkrp.vars.point), S_3 = process.get_max_point_per_level(ply:getDarkRPVar(process.darkrp.vars.level))
            })
        end
    end)
:End()

local name = "addlevelid"
sam.command.new(name)
    :SetPermission(name, "superadmin") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Ajoute des niveaux. Fonctionne avec des joueurs qui ne se sont jamais connectés.")

	:AddArg("steamid",{
        hint = "joueur",
        single_target = true,
    })

    :AddArg("number", {
        min = 1,
        hint = "niveau",
        round = true
    })
	
    :OnExecute(function(calling_ply, target, level_to_add)
        local steamid = target.value[1]
        local connected_ply = target.value[2]

        if (connected_ply) then
            process.sql.level.get_level(steamid, function (level)
                level = level + level_to_add
                process.sql.level.set_level(steamid, level)
                connected_ply:setDarkRPVar(process.darkrp.vars.level)
            end)
        else
            process.sql.level.get_level(steamid, function (level)
                if (level) then
                    level = level + level_to_add
                    process.sql.level.set_level(steamid, level)
                else
                    process.sql.level.insert_into(steamid, level_to_add, 0)
                end
            end)
        end
    end)
:End()