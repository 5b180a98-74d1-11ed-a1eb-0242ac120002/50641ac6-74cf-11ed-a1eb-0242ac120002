function process.set_level(ply, level, point)
	ply:setDarkRPVar(process.darkrp.vars.level, level)
	ply:setDarkRPVar(process.darkrp.vars.point, point)
end

hook.Add("PlayerInitialSpawn", "Process.set_level", function (ply)
	timer.Simple(0, function ()
		process.sql.level.get(ply:SteamID(), function (level, point)
			if (level) then
				process.set_level(ply, level, point)
			else
				process.sql.level.insert_into(ply:SteamID(), 1, 0)
				process.set_level(ply, 1, 0)
			end
		end)
	end)
end)

local donator_factor = {
	[0] = 1,
	[1] = 2,
	[2] = 3,
}

timer.Create("ProcessLevel", process.config.increments_point_delay, 0, function ()
	for i, ply in ipairs(player.GetAll()) do
		if (process.is_afk(ply)) then
			continue
		end

		process.sql.level.get(ply:SteamID(), function (level, point)
			local max_point_per_level = process.get_max_point_per_level(level)
			
			point = point + donator_factor[ply:getDarkRPVar(process.darkrp.vars.donator)]

			if (point > max_point_per_level) then
				point = point - max_point_per_level - 1 -- -1 to begin at 0 point when you have won a point
				level = level + 1
			end

			process.sql.level.set(ply:SteamID(), level, point)
			process.set_level(ply, level, point)
		end)
	end	
end)

