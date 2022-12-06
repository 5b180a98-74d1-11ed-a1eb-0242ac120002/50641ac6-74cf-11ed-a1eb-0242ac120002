local BlurryVisionTired = "BlurryVisionTired"
local DelayBlurryVision = "DelayBlurryVision"
local ResetBlurryVisionTired = "ResetBlurryVisionTired"

// key = value and value = true to do if(table[key])
function process.to_if_check_table(...)
    local table = {}
    for _, value in pairs({...}) do
        table[value] = true
    end

    return table
end

if (SERVER) then
    util.AddNetworkString( BlurryVisionTired )
    util.AddNetworkString( DelayBlurryVision )
    util.AddNetworkString( ResetBlurryVisionTired )
    
    function process.ReadSound( FileName, volume )
        local sound
        local filter
    
        filter = RecipientFilter()
        filter:AddAllPlayers()
        -- The sound is always re-created serverside because of the RecipientFilter.
        sound = CreateSound( game.GetWorld(), FileName, filter ) -- create the new sound, parented to the worldspawn (which always exists)
        if sound then
            sound:SetSoundLevel( 0 ) -- play everywhere
            sound:ChangeVolume(volume or 1)
        end
    
        if sound then
            sound:Play()
        end
        return sound -- useful if you want to stop the sound yourself
    end

    local armor_var = "Process.last_armor_reload"
    function process.reload_armor(ply)
        local last_reload = ply:GetVar(armor_var)
        if (last_reload and last_reload < SysTime() - process.config.armor_reload_delay) then
            ply:SetVar(armor_var, SysTime())
            ply:SetArmor(ply:GetMaxArmor())
        end
    end
    
    -- Set a player to sleep, index start to 1
    function process.setSleepPlayer(victim, timeToGetTired, timeToSleep, step, tableText, index)
        if (victim:Have_effect("tranquilizer")) then
            return
        end
        
        local effect = {
            timers = {},
            name = "setSleepPlayer",
            tags = {"bad", "tranquilizer"},
            remove_effect = function (victim)
                if (victim.WalkSpeed) then
                    victim:SetWalkSpeed(victim.WalkSpeed)
                    victim:SetRunSpeed(victim.RunSpeed)
                end
                victim.TranquilizedByDart = false
                victim.IsTired = false
                process.SendResetBlurryVisionTired(victim)
            end
        }
        victim:Add_effect(effect)
        
        if (index == 1) then 
            victim.IsTired = true 
            net.Start(DelayBlurryVision)
            net.WriteFloat(timeToGetTired)
            net.Send(victim)
        end

        local timer_name = "getting_tired_"..victim:SteamID()
        table.insert(effect.timers, timer_name)
        timer.Create(timer_name, timeToGetTired/step, 1, function()
            if (!victim.IsTired or !IsValid(victim)) then return end
            net.Start(BlurryVisionTired)
            net.WriteTable({step, index})
            net.Send(victim)
            factorSpeed = (step - index) / step
            if (!victim.WalkSpeed and !victim.RunSpeed) then
                victim.WalkSpeed = victim:GetWalkSpeed()
                victim.RunSpeed = victim:GetRunSpeed()
            end
            victim:SetWalkSpeed(victim.WalkSpeed * factorSpeed )
            victim:SetRunSpeed(victim.RunSpeed * factorSpeed)
            victim:Say("/me "..tableText[index])

            index = index + 1
            if (index <= step) then
                process.setSleepPlayer(victim, timeToGetTired, timeToSleep, step, tableText, index)
            else
                victim.IsTired = false
                victim.TranquilizedByDart = true
                DarkRP.toggleSleep(victim)

                local timer_name = "getting_sleepy_"..victim:SteamID()
                table.insert(effect.timers, timer_name)
                timer.Create("getting_sleepy_"..victim:SteamID(), timeToSleep, 1, function()
                    if victim.TranquilizedByDart and IsValid(victim) then
                        DarkRP.toggleSleep(victim,"wake")
                        victim.TranquilizedByDart = false
                        -- When a player spawns, his movement speed cannot be changed immediately afterwards.
                        timer.Simple(0.1, function ()
                            if !IsValid(victim) then return end
                            victim:Say("/me se réveille et met quelques secondes à reprendre ses esprits.")
                            victim:SetWalkSpeed(1)
                            victim:SetRunSpeed(1)
                            timer.Simple(5, function ()
                                if !IsValid(victim) then return end
                                if (victim.WalkSpeed and victim.RunSpeed) then
                                    victim:SetWalkSpeed(victim.WalkSpeed)
                                    victim:SetRunSpeed(victim.RunSpeed)
                                end
                                victim:Remove_effect(effect)
                            end)
                        end)
                    end
                end)
            end
        end )
    end

        -- Displays a message to the targeted player according to the defined type, some types also change the player's walking/running speed over a period of time.
    function process.AmnesiaEffect(victim, ent, typeAmnesia, delay)
        local ListAmnesiac = {
            [1] = "Vous êtes désorienté et ne vous souvenez plus des dernières heures...",
            [2] = "Vous êtes embrumé et ne vous souvenez plus des derniers jours...",
            [3] = "Vous êtes légèrement paralysé et ne vous souvenez plus des dernières semaines...",
            [4] = "Vous êtes paralysé et ne vous souvenez de rien ni même de votre identité...",
            [5] = "Vous ne vous souvenez de rien, et vous vous prenez pour la personne souhaitez par votre interlocuteur...",
        }
        local ClassAmnesic = {
            [1] = "b",
            [2] = "c",
            [3] = "d",
            [4] = "e",
            [5] = "f",
        }
        if victim:IsPlayer() then
            victim:PrintMessage( HUD_PRINTTALK, "Vous êtes confus et vous vous sentez mal-à-l'aise..." )
            ent:GetOwner():EmitSound( "physics/glass/glass_bottle_break1.wav" )
            ent:DefaultReload( ACT_RELOAD )
            if (typeAmnesia >= 3 or typeAmnesia <= 4) then
                victim.WalkSpeed = victim:GetWalkSpeed()
                victim.RunSpeed = victim:GetRunSpeed()
                if (typeAmnesia == 3) then
                    victim:SetWalkSpeed(victim.WalkSpeed * 0.3)
                    victim:SetRunSpeed(victim.RunSpeed * 0.3)
                elseif (typeAmnesia == 4) then
                    victim:SetWalkSpeed(1)
                    victim:SetRunSpeed(1)
                end
                timer.Create("amnesic_side_effect_"..victim:SteamID(), 20, 1, function()
                    if (victim.WalkSpeed and victim.RunSpeed and IsValid(victim)) then
                        victim:SetWalkSpeed(victim.WalkSpeed)
                        victim:SetRunSpeed(victim.RunSpeed)
                    end
                end )
            end
            timer.Create("amnesia_effect"..victim:SteamID(), delay/2, 1, function()
                if IsValid(victim) then
                    victim:PrintMessage( HUD_PRINTTALK, ListAmnesiac[typeAmnesia] )
                end
            end )
            
            local ammo = ent:GetOwner():GetAmmoCount(ent:GetPrimaryAmmoType())
            ammo = ammo - 1
            if (ammo <= 0) then
                ent:GetOwner():StripWeapon( ent:GetClass() )
            else
                ent:GetOwner():SetAmmo(ammo, ent:GetPrimaryAmmoType())
            end
        end
    end

    -- Returns the player model according to the job.
    function process.getPlayerModel(name)
        local listModels = RPExtraTeams[name].model
        return isstring(listModels) and listModels or listModels[math.random(1, #listModels)]
    end

    -- Return true if the player is close from the entitie.
    function process.CheckDistance(ply, ent, distance)
        local tracePly = ply:GetPos()
        local entsSpherePly = ents.FindInSphere(tracePly, distance)
        for k,v in pairs(entsSpherePly) do
            if v == ent then
                return true
            end
        end
        return false
    end

    -- Function called to remove an blurry vision on the client side.
    function process.SendResetBlurryVisionTired(victim)
        net.Start(ResetBlurryVisionTired)
        net.WriteBool(true)
        net.Send(victim)
    end
end

if CLIENT then
    net.Receive(BlurryVisionTired, function ( )
        ply = LocalPlayer()
        tableData = net.ReadTable()
        ply.Step = tableData[1]
        ply.Index = tableData[2]
        if (tableData[1] == tableData[2]) then
            ply.BlurryShockTired = false
            ply.Step = nil
            ply.Index = nil
        else
            ply.BlurryShockTired = true
        end
    end)

    net.Receive(DelayBlurryVision, function ( )
        ply = LocalPlayer()
        delay = net.ReadFloat()
        timer.Simple(delay, function()
            if !IsValid(ply) then return end
            ply.BlurryShockTired = false
        end)
    end)

    net.Receive(ResetBlurryVisionTired, function ( )
        Check = net.ReadBool()
        local ply = LocalPlayer()
        if (Check and ply.BlurryShockTired) then
            ply.BlurryShockTired = nil
        end
    end)
    
    function ShockEffectTired()
        local ply = LocalPlayer()
        local curTime = FrameTime()
        if !ply.AddAlpha then ply.AddAlpha = 1 end
        if !ply.DrawAlpha then ply.DrawAlpha = 0 end
        if !ply.Delay then ply.Delay = 0 end
            
        if ply.BlurryShockTired then 
            ply.AddAlpha = 0.2 * ply.Index / ply.Step
            ply.DrawAlpha = 0.99 * ply.Index / ply.Step
            ply.Delay = 0.05 * ply.Index / ply.Step
        else
            ply.AddAlpha = math.Clamp(ply.AddAlpha + curTime * 0.4, 0.2, 1)
            ply.DrawAlpha = math.Clamp(ply.DrawAlpha - curTime * 0.4, 0, 0.99)
            ply.Delay = math.Clamp(ply.Delay - curTime * 0.4, 0, 0.05)
        end
        
        DrawMotionBlur( ply.AddAlpha, ply.DrawAlpha, ply.Delay )
    end

    hook.Add("RenderScreenspaceEffects","ShockEffectTired",ShockEffectTired)
end

hook.Add("canSleep", "Process.tranquilizer_dart.can_wake_up", function (ply)
	if (ply.Sleeping and (ply.TranquilizedByDart or ply.IsTired)) then return false, "Tu es sous l'effet d'une drogue." end
end)