-- addon modifié de https://steamcommunity.com/sharedfiles/filedetails/?id=431903148
table.insert(process.credits, "https://steamcommunity.com/sharedfiles/filedetails/?id=431903148")

local cook_here = false
local cooks_list = {}

-- Functions
local function IsCookTeam( Team )
	if RPExtraTeams then
		if Team==TEAM_COOK or ( RPExtraTeams[Team] and RPExtraTeams[Team].cook ) then
			return true
		end
	end
	return false
end

-- Lua refresh
if RPExtraTeams then
	cook_here = false
	for _,pl in ipairs( player.GetAll() ) do
		if IsCookTeam( pl:Team() ) then
			cook_here = true
			cooks_list[pl] = true
		end
	end
end

-- Updater
local function RefreshCookHere()
	local pl = next( cooks_list )
	if pl then
		cook_here = true
	else
		cook_here = false
	end
end
hook.Add( "PlayerDisconnected", "darkrp_no_cook_no_hunger", function( ply )
	cooks_list[ply] = nil
	RefreshCookHere()
end )
hook.Add( "OnPlayerChangedTeam", "darkrp_no_cook_no_hunger", function( ply, oldTeam, newTeam )
	if IsCookTeam( newTeam ) then
		cooks_list[ply] = true
	else
		cooks_list[ply] = nil
	end
	RefreshCookHere()
end )

hook.Add("Initialize", "Process.darkrp.init_hunger_jobs", function ()
	local hunger_jobs = process.to_if_check_table(TEAM_CONTRAVANCE, TEAM_CONTR, TEAM_D)

	timer.Create("HMThink", 15, 0, function () -- override default darkrp timer

		if (!cook_here) then
			return 
		end

		for _, ply in ipairs(player.GetAll()) do
			if not ply:Alive() then continue end

			if (hunger_jobs[ply:Team()]) then
				if ply:GetPos():WithinAABox(Vector(-7957, 13820, -2676),Vector(-4125, 9921, -675)) then
					local energy = ply:getDarkRPVar("Energy")
					ply:setDarkRPVar("Energy", math.Clamp(energy - GAMEMODE.Config.hungerspeed, 0, 100))
				end
			end
		end
	end)
end)
