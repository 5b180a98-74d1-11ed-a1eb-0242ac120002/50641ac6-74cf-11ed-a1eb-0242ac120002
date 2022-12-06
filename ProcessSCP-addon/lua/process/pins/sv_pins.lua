local net_name_pins = "Process.pins"
local net_name_authorized_pins = "Process.authorized_pins"

util.AddNetworkString(net_name_pins)
util.AddNetworkString(net_name_authorized_pins)

function process.send_authorized_pins(ply, authorized_pins)
    net.Start(net_name_authorized_pins)
    net.WriteTable(authorized_pins)
    net.Send(ply)
end

net.Receive(net_name_pins, function (len, ply)
    local model_index = net.ReadInt(32)

    if (model_index == 0) then
        ply:setDarkRPVar(process.darkrp.vars.pins, model_index)

        return 
    end

    local model = process.pins.MODELS[model_index]

    if (model == nil) then

        print(ply:Name().." has sent a model that wasn't allowed for a pins (maybe a cheater). | steamID : ", ply:SteamID())
        return

    end

    if (process.pins.DONATOR_STATUTS[model_index] <= ply:getDarkRPVar(process.darkrp.vars.donator) or ply:HasPermission("authorize all pins") ) then
        ply:setDarkRPVar(process.darkrp.vars.pins, model_index)
        return
    end

    process.sql.pins.get_authorized_pins(ply:SteamID(), function (authorized_pins)
        for authorized_pins_index, authorized_pins in ipairs(util.JSONToTable(authorized_pins)) do
            if (authorized_pins == model_index) then
                ply:setDarkRPVar(process.darkrp.vars.pins, model_index)
                return
            end
        end
    
        print(ply:Name().." a pris un pins qu'il n'a pas le droit | "..ply:SteamID())
    end)
end)

//load pins when connected
hook.Add("PlayerInitialSpawn", "Process.add_all_pins", function (ply)
    timer.Simple(0, function ()
        process.sql.pins.get(ply:SteamID(), function (authorized_pins, pins)
            if (pins) then
                if (authorized_pins != "[]") then
                    process.send_authorized_pins(ply, util.JSONToTable(authorized_pins))    
                end

                ply:setDarkRPVar(process.darkrp.vars.pins, pins)
            else
                process.sql.pins.insert_into(ply:SteamID(), 0, "[]")
                ply:setDarkRPVar(process.darkrp.vars.pins, 0)
            end
        end)
	end)
end)

//save pins when disconnected
hook.Add("PlayerDisconnected", "Process.pins_disconnected", function (ply)
    process.sql.pins.set_pins(ply:SteamID(), ply:getDarkRPVar(process.darkrp.vars.pins))
end)