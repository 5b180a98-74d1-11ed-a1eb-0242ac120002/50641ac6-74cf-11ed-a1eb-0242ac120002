sam.command.set_category("Process donateur") -- any new command will be in that category unless the command uses :SetCategory function

local name = "setdonator"
sam.command.new(name)
    :SetPermission(name, "superadmin") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help( "Définit le statut donateur et ça durée.")

    :AddArg("player",{
        hint = "joueur(s)"
    })

	:AddArg("number", {
        min = 0,
        max = 2,
        round = true,
        hint = "Le statut donateur"
    })

    :AddArg("length", {
        min = 0,
        hint = "Durée du statut donateur."
    })
	
    :OnExecute(function(calling_ply, targets, statut, duration)         
        local duration_msg
        if (duration != 0) then
            duration_msg = " pour un temps de {V_2 Green}."
        else
            duration_msg = " pour un temps infinie."
        end

        for i, ply in ipairs(targets) do
            process.sql.donator.set(ply:SteamID(), duration == 0 and 0 or os.time() + duration * 60, statut)

            ply:setDarkRPVar(process.darkrp.vars.donator, statut)
        end

        sam.player.send_message(nil, "{A} a définit le statut donateur à {V_1} pour {T},"..duration_msg, {
			A = calling_ply, T = targets, V_1 = statut, V_2 = sam.reverse_parse_length(duration)
		})
    end)
:End()

name = "getdonator"
sam.command.new(name)
    :SetPermission(name, "superadmin") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Récupère le statut donateur.")

    :AddArg("player",{
        hint = "joueur(s)"
    })
	
    :OnExecute(function(calling_ply, targets)
		for i, ply in ipairs(targets) do
            process.sql.donator.get(ply:SteamID(), function (statut, duration)
                local duration_msg = duration != 0 and " La durée restante du statut est de {S_2 Green}." or ""
    
                sam.player.send_message(calling_ply, "Le statut donateur de {A} est de {S_1 Green}."..duration_msg, {
                    A = ply, S_1 = ply:getDarkRPVar(process.darkrp.vars.donator), S_2 = sam.reverse_parse_length((duration - os.time()) / 60)
                })
            end)
        end
    end)
:End()

local net_name = "Processs.getalldonator"
if (SERVER) then
    util.AddNetworkString(net_name)
else
    net.Receive(net_name, function (len)
        local bytes_amount = net.ReadUInt( 16 ) -- Gets back the amount of bytes our data has
        local compressed_message = net.ReadData( bytes_amount ) -- Gets back our compressed message
        local message = util.Decompress( compressed_message ) -- Decompresses our message

        local result = util.JSONToTable(message)

        for _, value in pairs(result) do
            value.steam_profil_name = steamworks.GetPlayerName(util.SteamIDTo64(value.steamID))
        end

        PrintTable(result)
    end)
end

name = "getalldonator"
sam.command.new(name)
    :SetPermission(name, "superadmin") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Récupère le statut donateur de tout les joueurs si plus grand que 0. Écrit dans la console")
	
    :OnExecute(function(calling_ply)
		local result = process.sql.query("select * from ProcessDonator where statut > 0")
        if (!result) then
            print("Personne n'est donateur.")
        else
            if (calling_ply) then
                local data = util.Compress(util.TableToJSON(result))
                net.Start(net_name)
                net.WriteUInt(#data, 16)
                net.WriteData(data, #data)
                net.Send(calling_ply)
            else // if from console
                PrintTable(result)
            end
        end
    end)
:End()

local name = "setdonatorid"
sam.command.new(name)
    :SetPermission(name, "superadmin") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help( "Définit le statut donateur et ça durée. Fonctionne avec des joueurs qui ne se sont jamais connectés.")

    :AddArg("steamid",{
        single_target = true,
        hint = "joueur(s)"
    })

	:AddArg("number", {
        min = 0,
        max = 2,
        round = true,
        hint = "Le statut donateur"
    })

    :AddArg("length", {
        min = 0,
        hint = "Durée du statut donateur."
    })
	
    :OnExecute(function(calling_ply, target, statut_to_set, duration_to_set)    
        local steamid = target.value[1]
        local connected_ply = target.value[2]

        local duration_to_set = duration_to_set == 0 and 0 or os.time() + duration_to_set * 60

        if (connected_ply) then
            process.sql.donator.set(steamid, duration_to_set, statut_to_set)

            connected_ply:setDarkRPVar(process.darkrp.vars.donator, statut_to_set)
        else
            process.sql.donator.get(steamid, function (statut, duration)
                if (duration) then
                    process.sql.donator.set(steamid, duration_to_set, statut_to_set)
                else
                    process.sql.insert_into(steamid, duration_to_set, statut_to_set)
                end
            end)
        end
    end)
:End()

local name = "adddonatorid"
sam.command.new(name)
    :SetPermission(name, "superadmin") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help( "Définit le statut donateur et ça durée. Fonctionne avec des joueurs qui ne se sont jamais connectés.")

    :AddArg("steamid",{
        single_target = true,
        hint = "joueur(s)"
    })

	:AddArg("number", {
        min = 0,
        max = 2,
        round = true,
        hint = "Le statut donateur"
    })

    :AddArg("length", {
        min = 0,
        hint = "Durée du statut donateur."
    })
	
    :OnExecute(function(calling_ply, target, statut_to_set, duration_to_set)    
        local steamid = target.value[1]
        local connected_ply = target.value[2]

        duration_to_set = duration_to_set == 0 and 0 or os.time() + duration_to_set * 60

        process.sql.donator.get(steamid, function (statut, duration)
            if (duration) then
                local time_left = duration - os.time()
                if (time_left > 0 and statut != 0) then
                    if (statut < statut_to_set) then
                        time_left = time_left / 2
                    end
                    
                    duration_to_set = duration_to_set + time_left
                end

                process.sql.donator.set(steamid, duration_to_set, statut_to_set)

                if (connected_ply) then
                    connected_ply:setDarkRPVar(process.darkrp.vars.donator, statut_to_set)
                end
            else
                process.sql.insert_into(steamid, duration_to_set, statut_to_set)
            end
        end)
    end)
:End()