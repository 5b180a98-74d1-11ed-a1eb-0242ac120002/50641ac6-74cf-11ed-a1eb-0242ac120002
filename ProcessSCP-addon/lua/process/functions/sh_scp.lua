if (SERVER) then
-- Turns a player into an instance of SCP 008 from a multi-step via timer that triggers the next step in the disease.
function process.TimerCreateTurning(i, ply)
        ply.IsTurningZombie = true
        local TimerCheckTurning = {
            [0] = 15,
            [1] = 15,
            [2] = 10,
            [3] = 10,
            [4] = 15,
            [5] = 60,
        
        }
        if (i <= 4) then
            timer.Create("turning_zombie_" .. i .. "_" .. ply:SteamID(), TimerCheckTurning[i], 1, function()
                if !IsValid(ply) then return end
                if (i == 0) then
                    ply:Say("/me se sent nauséeux.")
                    ply:SetWalkSpeed(150)
                    ply:SetRunSpeed(230)
                end
                if (i == 1) then
                    ply:Say("/me sue abondamment.")
                    ply:SetWalkSpeed(140)
                    ply:SetRunSpeed(220)
                    ply:EmitSound("vo/npc/male01/moan0" .. math.random(5, 5) .. ".wav")
                end
                if (i == 2) then
                    ply:EmitSound("vo/npc/male01/moan0" .. math.random(1, 5) .. ".wav")
                    ply:Say("/me commence à divaguer.")
                    ply:SetWalkSpeed(130)
                    ply:SetRunSpeed(210)
                end
                if (i == 3) then
                    ply:EmitSound("npc/zombie/zombie_pain" .. math.random(1, 6) .. ".wav")
                end
                if (i == 4) then
                    ply:StripWeapons()
                    ply:Give("008_swep")
                    ply:SetWalkSpeed(180)
                    ply:SetRunSpeed(260)
                    ply:SetMaxHealth(350)
                    ply:SetHealth(350)
                    ply:SetArmor(0)
                    ply:SetColor(Color(255, 255, 255, 255))
                    -- Go check model zombie declare on job.lua
                    ply:SetModel(ply:getJobTable().model_zombie or "models/player/zombie_fast.mdl")
                    ply:SetBodygroup( 0, 1 )
                end
                process.TimerCreateTurning(i + 1, ply)
            end)
        end
    end

    
    -- Function called to remove all effect on death or changed team
    function RemoveEffect008(victim)
        for i=0,8 do
            if timer.Exists("turning_zombie_"..i.."_"..victim:SteamID()) then
                timer.Remove("turning_zombie_"..i.."_"..victim:SteamID())
            end
        end
        victim.IsTurningZombie = false
    end
    
    hook.Add( "PlayerDeath", "Zombie_timer_remove_death", RemoveEffect008 )
    hook.Add( "PlayerChangedTeam", "Zombie_timer_remove_team_change", RemoveEffect008 )
end

hook.Add("Initialize", "process.create_is_impervious_to_disease_func", function ()
    local models = process.darkrp.models
    local hazmat_models = process.add_tables(models.sdc, models.talos, models.masto, models.masto_gdi, {"models/nada/male/MedicalHazmat.mdl", "models/nada/male/IDMROfficer.mdl", "models/nada/male/factoryworker.mdl", "models/nada/male/IDMRWorker.mdl"})
    
    function process.scp.is_impervious_to_disease(ply) // not immune. some direct attack like 008_swep must not use this function. Use this only for remote infection. like 008_ent or 217
        if (!process.can_have_effect(ply) or table.HasValue(hazmat_models, ply:GetModel())) then
            return true
        end

        return false
    end

    function process.darkrp.has_hazmat_model(ply)
        for _, model in pairs(ply:getJobTable().model) do
            if (table.HasValue(hazmat_models, model)) then
                return true
            end
        end

        return false
    end
end)

function process.is_scp(ply)
    return GuthSCP.Config.guthscpbase.scp_teams[GuthSCP.getTeamKeyname( ply:Team() )]  
end

function process.can_have_effect(ply)
    if (process.is_scp(ply) or process.darkrp.groups.not_living[ply:Team()]) then
        return false
    end
    
    return true
end        
