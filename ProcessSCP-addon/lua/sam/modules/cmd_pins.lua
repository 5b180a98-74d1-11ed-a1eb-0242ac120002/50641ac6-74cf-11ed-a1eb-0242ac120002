sam.command.set_category("Process pins") -- any new command will be in that category unless the command uses :SetCategory function

local name = "authorizepins"
sam.command.new(name)
    :SetPermission(name, "superadmin") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Définit les point et le niveau.")

	:AddArg("player",{
        hint = "joueur(s)"
    })

    :AddArg("number", {
        min = 1,
        hint = "pins",
        round = true
    })

    :AddArg("number", {
        min = 0,
        max = 1,
        hint = "autorisation",
        round = true
    })
	
    :OnExecute(function(calling_ply, targets, pins_to_update, authorize)
        if (authorize == 1) then
            sam.player.send_message(nil--[[will send to all player]], "{A} a autorisé le pins "..pins_to_update.." pour {T}", {
                A = calling_ply, T = targets
            })
        else
            sam.player.send_message(nil--[[will send to all player]], "{A} a retiré l'autorisation du pins "..pins_to_update.." pour {T}", {
                A = calling_ply, T = targets
            })
        end

		for _, ply in ipairs(targets) do
            process.sql.pins.get_authorized_pins(ply:SteamID(), function (authorized_pins)
                local authorized_pins = util.JSONToTable(authorized_pins)

                if (authorize == 0) then
                    if (table.HasValue(authorized_pins, pins_to_update)) then
                        table.remove(authorized_pins, pins_to_update)
                    end
                else
                    if (!table.HasValue(authorized_pins, pins_to_update)) then
                        table.insert(authorized_pins, pins_to_update)
                    end
                end

                process.send_authorized_pins(ply, authorized_pins)
                process.sql.pins.set_authorized_pins(ply:SteamID(), util.TableToJSON(authorized_pins))
            end)
        end        
    end)
:End()

name = "getpinsauthorization"
sam.command.new(name)
    :SetPermission(name, "moderator") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Récupère l'autorisation pour porter les pins.")

	:AddArg("player",{
        hint = "joueur(s)"
    })
	
    :OnExecute(function(calling_ply, targets)
		for ply_index, ply in ipairs(targets) do
            process.sql.pins.get_authorized_pins(calling_ply:SteamID(), function (authorized_pins)
                sam.player.send_message(calling_ply, "{A} : "..authorized_pins, {
                    A = ply
                })
            end)
        end
    end)
:End()