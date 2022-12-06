hook.Add("Initialize", "Process.last_model_init", function ()
    local function set_model(ply, new_model)
        ply:SetVar("last_model", new_model)
    
        for model_group_key, model_group in pairs(process.darkrp.models) do
            for model_key, model in pairs( istable(model_group) and model_group or {model_group} ) do
                if (string.lower(model) == string.lower(new_model)) then
                    ply:SetVar("model_group_key", model_group_key)
                    return
                end
            end
        end
    end
    
    timer.Create("Process.change_model", 1, 0, function ()
        for _, ply in pairs(player.GetAll()) do
            local last_model = ply:GetVar("last_model")
            local model = ply:GetModel()
    
            if (!last_model) then
                set_model(ply, model)
                continue 
            end

            if (model != last_model) then
                set_model(ply, model)
            end
        end
    end)
end)