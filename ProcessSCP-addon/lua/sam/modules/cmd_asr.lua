local command = sam.command

command.set_category("Process")

local cmd_name = "freeze_asr"
command.new(cmd_name)
    :SetPermission(cmd_name, "moderator")

    :Help("Gèle la quantité de ravitaillement.")

    :OnExecute(function(calling_ply)
        if (timer.TimeLeft(process.ASR.timer_name) >= 0) then
            timer.Pause(process.ASR.timer_name)
            
            sam.player.send_message(nil, "{A} a gelé la quantité de ravitaillement.", {
                A = calling_ply
            })
        else
            sam.player.send_message(calling_ply, "La quantité de ravitaillement est déjà gelé.", {})
        end
    end)
:End()

cmd_name = "unfreeze_asr"
command.new(cmd_name)
    :SetPermission(cmd_name, "moderator")

    :Help("Dégèle la quantité de ravitaillement.")

    :OnExecute(function(calling_ply)
        if (timer.TimeLeft(process.ASR.timer_name) < 0) then
        timer.UnPause(process.ASR.timer_name)

        sam.player.send_message(nil, "{A} a dégelé la quantité de ravitaillement.", {
                A = calling_ply
            })
        else
            sam.player.send_message(calling_ply, "La quantité de ravitaillement est déjà dégelé.", {})
        end
    end)
:End()

cmd_name = "set_asr"
command.new(cmd_name)
    :SetPermission(cmd_name, "moderator")

    :Help("Définit la quantité de ravitaillement.")

    :AddArg("number", {
        min = 0,
        max = 1,
        hint = "Quantité de ravitaillement",
    })

    :OnExecute(function(calling_ply, asr_filled)
        process.ASR.set_filled(asr_filled)

        sam.player.send_message(nil, "{A} a définit la quantité de ravitaillement à {V_1}.", {
            A = calling_ply, V_1 = asr_filled
        })
    end)
:End()