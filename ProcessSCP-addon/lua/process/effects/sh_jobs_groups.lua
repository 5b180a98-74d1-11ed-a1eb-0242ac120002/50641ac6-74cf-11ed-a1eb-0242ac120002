hook.Add("Initialize", "process.effetc.groups", function ()
    process.darkrp.groups = {
        not_living = process.to_if_check_table(TEAM_IAA, TEAM_UIAA, TEAM_UIAAL, TEAM_173, TEAM_1048, TEAM_STAFF)
    }
end)

