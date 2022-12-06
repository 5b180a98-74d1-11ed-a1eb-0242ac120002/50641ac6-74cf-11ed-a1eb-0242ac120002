hook.Add("Initialize", "Process.edgescoeboard", function ()
    local not_hidden_teams = process.to_if_check_table(TEAM_IAA, TEAM_UIAA, TEAM_SENTINELLE)

    -- to modify the addon "edgescoreboard"
    function process.edgescoreboard.job_name(default_job_name, ply) -- declared in adddons\edgescoreboard\lua\edgescoreboard\cl_playerrow.lua line 737
        if (IsValid(ply)) then
            return (LocalPlayer():HasPermission("see all jobs in scoreboard") or ply == LocalPlayer() or not_hidden_teams[ply:Team()]) and default_job_name or "???"
        end
    end
    
    function process.edgescoreboard.color(default_color, ply) -- declared in adddons\edgescoreboard\lua\edgescoreboard\cl_playerrow.lua line 1267
        if (IsValid(ply)) then
            return ply:getDarkRPVar(process.darkrp.vars.donator) == 1 and Color(255, 187, 0) or default_color
        end
    end
    
end)
