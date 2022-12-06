hook.Add("PlayerInitialSpawn", "Process.set_donator_statut", function (ply)
	timer.Simple(0, function ()
		process.sql.donator.get(ply:SteamID(), function (statut, duration)
			if (duration) then
				if (duration < os.time() and duration != 0) then -- remove donator when time is left
					process.sql.donator.set_statut(ply:SteamID(), 0)
					ply:setDarkRPVar(process.darkrp.vars.donator, 0)
				else
					ply:setDarkRPVar(process.darkrp.vars.donator, statut)
				end	
			else
				process.sql.donator.insert_into(ply:SteamID(), 0, 0)
	
				ply:setDarkRPVar(process.darkrp.vars.donator, 0)
			end
		end)
	end)
end)