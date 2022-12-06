sam.command.set_category("Process") -- any new command will be in that category unless the command uses :SetCategory function

local function send_msg(ply, msg)
    net.Start("squad_msg")
    net.WriteInt(ply:EntIndex(), 32)
    net.WriteString(msg)
    net.Send(ply)
end

sam.command.set_category("Process") -- any new command will be in that category unless the command uses :SetCategory function

local name = "em"
sam.command.new(name)
    :SetPermission(name, "confirmed_moderator") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Envoie un message à l'escouade.")

    :AddArg("text",{
        hint = "text"
    })

	:GetRestArgs(true)
	
    :OnExecute(function(calling_ply, msg)
        local calling_ply_squad_name = calling_ply:getDarkRPVar(process.darkrp.vars.squad_name)
		if (calling_ply_squad_name == "") then
            sam.player.send_message(calling_ply, "{A} n'es dans aucune escouade !", {
                A = calling_ply
            })
            return 
        end
        
        for i, ply in ipairs(player.GetAll()) do
            local ply_squad_group_index = ply:getDarkRPVar(process.darkrp.vars.group_index)
    
            if (calling_ply:getDarkRPVar(process.darkrp.vars.group_index) == ply_squad_group_index) then
                if (calling_ply_squad_name == ply:getDarkRPVar(process.darkrp.vars.squad_name)) then
                    sam.player.send_message(ply, "[{S_1 Green}] {A} : {S_2}", {
                        A = calling_ply, S_1 = calling_ply_squad_name, S_2 = msg
                    })
                else
                    for allowed_job_to_manage_index, allowed_job_to_manage in ipairs(process.squad_group[ply_squad_group_index].allowed_jobs_to_manage) do
                        if (ply:Team() == allowed_job_to_manage) then
                            sam.player.send_message(ply, "[{S_1 Green}] {A} : {S_2}", {
                                A = calling_ply, S_1 = calling_ply_squad_name, S_2 = msg
                            })
                            break  
                        end
                    end
                end
            end
        end
    end)
:End()