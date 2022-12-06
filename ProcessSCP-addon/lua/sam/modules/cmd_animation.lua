-- DONT EVER TALK TO ME ABOUT THIS CODE (from BK)
table.insert(process.credits, "Bk for event action")

local sam, command = sam, sam.command

command.set_category("Animateurs")

command.new("activer_events")
    :SetPermission("activer_events", "admin")

    :Help("Cette commande permet l'activation des events imposant. Il faut l'exécuter avant tout autres commandes suivantes.")

    :OnExecute(function(ply)
        RunConsoleCommand('event_process_actif', 1)
    end)
:End()

command.new("désactiver_events")
    :SetPermission("activer_events", "admin")

    :Help("Cette commande permet la désactivation des events imposant. Il faut l'exécuter avant tout autres commandes suivantes.")

    :OnExecute(function(ply)
        RunConsoleCommand('event_process_actif', 0)
    end)
:End()

local name = "ic_bombardement"
command.new(name)
    :SetPermission(name, "admin") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Permet de lancer un event IC bombardement. Ne peut pas être arrété ! ! !")

    :OnExecute(function(calling_ply)
        RunConsoleCommand('event_process_ic_bombardement')
    end)
:End()