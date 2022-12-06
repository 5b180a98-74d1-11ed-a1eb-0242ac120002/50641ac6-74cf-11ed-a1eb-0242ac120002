hook.Add("Initialize", "process.roguescoreboard_get_job", function ()
    local valid_jobs = process.to_if_check_table(TEAM_IAA, TEAM_STAFF)
    
    function process.roguescoreboard_get_job(ply)
        if (sam.ranks.get_immunity(LocalPlayer():GetUserGroup()) < 10 and ply != LocalPlayer()) then
            if (valid_jobs[ply:Team()]) then
                return ply:getDarkRPVar("job") or "???"
            end
    
            return "???"
        end
    
        return ply:getDarkRPVar("job") or "???"
    end
end)