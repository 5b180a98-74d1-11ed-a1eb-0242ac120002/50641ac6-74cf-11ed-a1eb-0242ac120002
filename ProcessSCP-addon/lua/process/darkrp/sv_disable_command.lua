local disable_cmds = process.to_if_check_table("advert", "pm", "broadcast", "channel", "radio", "g", 'addagenda', 'addlaw', 'buytbfycomputer', 'buyvehicle', 'check',
'demotelicense', 'givelicense', 'lockdown', 'lottery', 'placelaws', 'removelaw', 'removeletters', 'requestlicense', 'resetlaws', 'setlicense', 'setprice',
'unlockdown', 'unsetlicense', 'unwanted', 'unwarrant', 'wanted', 'warrant', 'arrest', 'forcecancelvote', 'unarrest')

local function disable_cmd_function(ply)
    if (IsValid(ply) and ply:IsPlayer()) then
        DarkRP.notify(ply, 1, 4, "Cette commande a été désactivé.")
    end
end

hook.Add("Initialize", "Process.darkrp.disable_cmd", function ()
    for cmd, cmd_table in pairs(DarkRP.chatCommands) do
        if (disable_cmds[cmd]) then
            cmd_table.callback = disable_cmd_function
        end
    end
end)

/* useful commands
admintell
admintellall

enablestorm
disablestorm
*/