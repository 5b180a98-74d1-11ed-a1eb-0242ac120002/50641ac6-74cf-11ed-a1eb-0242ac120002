sam.command.set_category("Process") -- any new command will be in that category unless the command uses :SetCategory function

local name = "setuser"
sam.command.new(name)
    :SetPermission(name, "confirmed_moderator") -- OR "superadmin" OR "user" OR remove the second argument for no default access OR just remove that line to make it for everyone!

    :Help("Défnit le rang du joueur à user.")

	:AddArg("player", {
        hint = "joueur(s)",
        cant_target_self = true -- disallow the player who is calling to target himself
    })
	
    :OnExecute(function(calling_ply, targets)
		for i = 1, #targets do
			local target = targets[i]
            if (sam.ranks.get_immunity(target:GetUserGroup()) < sam.ranks.get_immunity(calling_ply:GetUserGroup())) then
                target:SetUserGroup("user")
            else
                sam.player.send_message(calling_ply, "Vous ne pouvez pas définir le rang à user pour {T}.", {
                    A = calling_ply, T = target
                })
            end
		end

        sam.player.send_message(nil--[[will send to all player]], "{A} a définit le rang à user pour {T}.", {
			A = calling_ply, T = targets
		})
    end)
:End()

sam.command.new("dropnvg")
    :Help("Drop les lunettes.")
	
    :OnExecute(function(calling_ply)
		if calling_ply:GetNWInt("nvg", 0) != 0 then
            -- drop the old ones
            local drop = (ArcticNVGs[calling_ply:GetNWInt("nvg", 0)] or {}).Entity
    
            if drop then
                local ent = ents.Create(drop)
                ent:SetPos(calling_ply:EyePos())
                ent:SetAngles(calling_ply:EyeAngles())
                ent:SetOwner(calling_ply)
                ent:Spawn()

                calling_ply:SetNWInt("nvg", 0)

                sam.player.send_message(calling_ply, "{A} a enlevé vos lunettes.", {
                    A = calling_ply
                })
            end
        else
            sam.player.send_message(calling_ply, "{A} n'a pas de lunettes à enlever.", {
                A = calling_ply
            })
        end        
    end)
:End()

sam.command.new('explode')
    :SetPermission('explode', "superadmin")

    :Help( "Explose un joueur")

    :AddArg("player",{
        hint = "joueur(s)"
    })
	
    :OnExecute(function(calling_ply, targets)
        
        for k, v in pairs( targets ) do	
            if (k != 1) then return end
            local playerpos = v:GetPos()
            
            timer.Simple( 0.1, function()				
                local traceworld = {}				
                    traceworld.start = playerpos					
                    traceworld.endpos = traceworld.start + ( Vector( 0,0,-1 ) * 250 )					
                    local trw = util.TraceLine( traceworld )					
                    local worldpos1 = trw.HitPos + trw.HitNormal					
                    local worldpos2 = trw.HitPos - trw.HitNormal				
                util.Decal( "Scorch",worldpos1,worldpos2 )				
            end )		
            
            v:Kill()	
            
            util.ScreenShake( playerpos, 5, 5, 1.5, 200 )
            
            local vPoint = playerpos + Vector( 0,0,10 )				
            local effectdata = EffectData()					
            effectdata:SetStart( vPoint )					
            effectdata:SetOrigin( vPoint )					
            effectdata:SetScale( 1 )					
            util.Effect( "HelicopterMegaBomb", effectdata )				
            v:EmitSound( Sound ("ambient/explosions/explode_4.wav") )		
        end	
    end)
:End()

sam.command.set_category("Fun")
sam.command.new('walkspeed')
    :SetPermission('walkspeed', "superadmin")

    :Help( "Min : 1")

    :AddArg("player",{
        hint = "joueur(s)"
    })

    :AddArg("number", {
        min = 0,
        max = 100,
        round = true,
        hint = "La vitesse de marche"
    })

    :OnExecute(function(calling_ply, targets, number)
        for i = 1, #targets do
			local target = targets[i]
            target:SetWalkSpeed( number )
        end
    end)
:End()

sam.command.set_category("Process SCP")
sam.command.new("drop427")
    :Help("Drop 427.")
	
    :OnExecute(function(calling_ply)        
        process.scp.Drop427(calling_ply)
    end)
:End()

sam.command.new("drop714")
    :Help("Drop scp 714.")
	
    :OnExecute(function(calling_ply)
		if calling_ply.HasScp714 == true then
            calling_ply.HasScp714  = false
            -- Player will be vulnerable to SCP 035 from this addon :
            -- https://steamcommunity.com/sharedfiles/filedetails/?id=1359851484
            calling_ply.MaskControl = false
            -- IsSleeping is a value from DarkRP, you can find it in : DarkRP/gamemode/modules/sleep/sv_sleep.lua
            if calling_ply.IsSleeping then
                DarkRP.toggleSleep(calling_ply,"wake")
            end
            local ent = ents.Create("scp714")
            ent:SetPos( calling_ply:GetShootPos() + (calling_ply:GetAimVector() * 50) )
            ent:SetAngles( calling_ply:GetAngles() )
            ent:Spawn()
            calling_ply:Say("/me se sent reposé et en pleine forme.")
            calling_ply:SetWalkSpeed(calling_ply.WalkSpeed)
            calling_ply:SetRunSpeed(calling_ply.RunSpeed)
            process.scp.StopTimerSleeping(calling_ply)
            sam.player.send_message(calling_ply, "{A} a enlevé SCP 714", {
                A = calling_ply
            })
        else
            sam.player.send_message(calling_ply, "{A} n'a pas SCP 714.", {
                A = calling_ply
            })
        end
    end)
:End()

sam.command.new("dropdisguise")
    :Help("Drop current disguise wear by player if he is disguise, set model from his job.")
	
    :OnExecute(function(calling_ply)
		if calling_ply.IsDisguise == true then
            calling_ply.IsDisguise  = false

            local ent = ents.Create("disguise_civil")
            ent:SetPos( calling_ply:GetShootPos() + (calling_ply:GetAimVector() * 50) )
            ent:SetAngles( calling_ply:GetAngles() )
            ent:Spawn()
            ent.DisguiseModel = calling_ply:GetModel()
            ent.DisguiseJob = calling_ply.typeDisguise
            
            calling_ply:SetModel(process.getPlayerModel( calling_ply:Team() ))

            sam.player.send_message(calling_ply, "{A} enlève son déguisement.", {
                A = calling_ply
            })
        else
            sam.player.send_message(calling_ply, "{A} n'a pas de déguisement.", {
                A = calling_ply
            })
        end
    end)
:End()

sam.command.new("drophazmat")
    :Help("Drop current hazmat wear by player, set model from his job.")
	
    :OnExecute(function(calling_ply)
		if calling_ply.WearHazmat == true then
            calling_ply.WearHazmat  = false

            local ent = ents.Create("hazmat_suit")
            calling_ply:SetModel(process.getPlayerModel( calling_ply:Team() ))
            ent:SetPos( calling_ply:GetShootPos() + (calling_ply:GetAimVector() * 50) )
            ent:SetAngles( calling_ply:GetAngles() )
            ent:Spawn()

            sam.player.send_message(calling_ply, "{A} enlève son Hazmat.", {
                A = calling_ply
            })
        else
            sam.player.send_message(calling_ply, "{A} n'a pas de tenue Hazmat.", {
                A = calling_ply
            })
        end
    end)
:End()

sam.command.new("scanbio")
    :Help("Lance un scan biométrique.")
    
    :OnExecute(process.scan_bio_sam_OnExecute)
:End()

sam.command.set_category("Fun")

sam.command.new("roll")
    :Help("Joue un nombre aléatoire.")
	
    :OnExecute(function(calling_ply)
        local plys  = {}
        for _, ply in pairs(player.GetAll()) do
            if (ply:GetPos():Distance(calling_ply:GetPos()) < 1000) then
                table.insert(plys, ply)
            end
        end
        
        sam.player.send_message(plys, "{A} a joué le nombre {V_1}.", {
            A = calling_ply, V_1 = math.random(0, 100)
        })
    end)
:End()

sam.command.new("na")
    :Help("Fait une narration.")
    :AddArg("text", {hint = "message de narration"})
    :GetRestArgs()
	
    :OnExecute(function(calling_ply, msg)
        sam.player.send_message(player.GetAll(), "*NA* {S_1}", {
            S_1 = msg
        })
    end)
:End()

local function have_radio(ply)
    for _, weapon in pairs(ply:GetWeapons()) do
        if (weapon:GetClass() == "weapon_rdo_radio") then
            return true
        end
    end

    return false 
end
sam.command.new("rg")
    :Help("Message radio à tout le monde.")
    :AddArg("text", {hint = "message radio"})
    :GetRestArgs()
	
    :OnExecute(function(calling_ply, msg)
        if (!have_radio(calling_ply)) then
            sam.player.send_message(calling_ply, "Tu n'as pas de radio.")
            return
        end

        local plys  = {}
        for _, ply in pairs(player.GetAll()) do
            if (have_radio(ply)) then
                table.insert(plys, ply)
            end
        end
        
        sam.player.send_message(plys, "{orange (Radio global)} {A} {S}", {
            A = calling_ply, S = msg
        })
    end)
:End()

local name = "playsound"
sam.command.new(name)
    :SetPermission(name)
    :Help("Drop current hazmat wear by player, set model from his job.")

    :AddArg("text", {
        hint = "chemin du son"
    })
    
    :AddArg("number", {
        hint = "volume du son",
        optional = true,
        default = 1,
    })
	
    :OnExecute(function(calling_ply, sound_path, volume)
		process.ReadSound(sound_path, volume)
    end)
:End()