local AFK_TIME = 300
local AFK_DISTANCE = 250

local var_last_keypress_time = "Process.anti_afk.last_keypress"
local var_last_pos = "Process.anti_afk.last_pos"
local var_last_pos_time = "Process.anti_afk.last_pos_time"

function process.is_afk(ply)
	return ply:GetVar(var_last_keypress_time) + AFK_TIME < CurTime() or ply:GetVar(var_last_pos_time) + AFK_TIME < CurTime()
end

hook.Add("PlayerInitialSpawn", "Process.afk.set_next_afk", function(ply)
	ply:SetVar(var_last_keypress_time, CurTime())

	ply:SetVar(var_last_pos, ply:GetPos())
	ply:SetVar(var_last_pos_time, CurTime())
end)

hook.Add("KeyPress", "Process.afk.keypress", function(ply)
	ply:SetVar(var_last_keypress_time, CurTime())
end)

timer.Create("Process.anti_afk.pos", 3, 0, function ()
	for ply_key, ply in pairs(player.GetAll()) do
		if (ply:GetVar(var_last_pos):Distance(ply:GetPos()) > AFK_DISTANCE) then
			ply:SetVar(var_last_pos, ply:GetPos())
			ply:SetVar(var_last_pos_time, CurTime())
		end
	end
end)

hook.Add("playerGetSalary", "Process.afk_no_salary", function (ply)
	if (process.is_afk(ply)) then
		return true, nil, 0
	end
end)