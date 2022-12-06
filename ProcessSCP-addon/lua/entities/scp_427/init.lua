// decompiled addon 

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/scp_427_model/scp_427.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, c)
    if not c:GetNWBool("IsWearing427") then
        self:Remove()
        c:SetNWBool("IsWearing427", true)
		activator:ChatPrint("Vous portez maintenant SCP-427.")
        activator:EmitSound("scp_427/drop.mp3")
		activator:EmitSound("scp_427/scp_427_loop.wav", 45, 100, 1, CHAN_AUTO)
--- events
        if not timer.Exists( "427Event_1_".. activator:SteamID() ) and c.Event1_finished ~= true then
			timer.Create( "427Event_1_".. activator:SteamID(), 100, 1, function()
				activator:ChatPrint("Vous vous sentez rafraîchi et énergique.")
		        activator:SetWalkSpeed( activator:GetWalkSpeed() + 30 )
		        activator:SetRunSpeed( activator:GetRunSpeed() + 30 )
		        c.Event1_finished = true
			end )
		else
			timer.UnPause( "427Event_1_".. activator:SteamID() )
		end
        if not timer.Exists( "427Event_2_".. activator:SteamID() ) and c.Event2_finished ~= true then
			timer.Create( "427Event_2_".. activator:SteamID(), 200, 1, function()
				activator:ChatPrint("Vous ressentez de légers spasmes musculaires dans tout votre corps.")
		        c.Event2_finished = true
			end )
		else
			timer.UnPause( "427Event_2_".. activator:SteamID() )
		end
        if not timer.Exists( "427Event_3_".. activator:SteamID() ) and c.Event3_finished ~= true then
			timer.Create( "427Event_3_".. activator:SteamID(), 350, 1, function()
				activator:ChatPrint("Vos muscles gonflent. Vous vous sentez plus puissant que jamais.")
				activator:Say("/me Les muscles deviennent si grand que les habits se déchire.")
				activator:SetColor(Color(255, 155, 155))
		        c.Event3_finished = true
			end )
		else
			timer.UnPause( "427Event_3_".. activator:SteamID() )
		end
        if not timer.Exists( "427Event_4_".. activator:SteamID() ) and c.Event4_finished ~= true then
			timer.Create( "427Event_4_".. activator:SteamID(), 500, 1, function()
				activator:ChatPrint("Vous ne pouvez pas sentir vos jambes. Mais tu n'as plus besoin de jambes.")
		        activator:Say("/me Des excroissances commencent à pousser, ce qui amène vos muscles à se déchirer et libère des éclaboussures de sang et vous rende méconnaissable.")
				activator:SetMaterial("models/flesh")
				
		        activator:ConCommand( "+duck" )
				activator:EmitSound("scp_427/scp_427_transform.mp3", 45, 100, 1, CHAN_AUTO)
		        c.Event4_finished = true
			end )
		else
			timer.UnPause( "427Event_4_".. activator:SteamID() )
		end
        if not timer.Exists( "427Event_5_".. activator:SteamID() ) then
			timer.Create( "427Event_5_".. activator:SteamID(), 600, 1, function()
				activator:ConCommand( "-duck" )
				activator:SetRunSpeed(500)
				activator:SetModel("models/salty/massif.mdl")
				activator:SetHealth(2000)
				activator:StripWeapons()
				activator:Give("427_swep")
				activator:SetColor(Color(255, 255, 255))
				activator:SetMaterial("")

				activator:ChatPrint("Vous êtes devenu un amas de chair. Tuez tous les être vivant autour de vous le plus vite possible.")
				activator:ChatPrint("Vous êtes devenu un amas de chair. Tuez tous les être vivant autour de vous le plus vite possible.")
				
		        c.Event1_finished = false
		        c.Event2_finished = false
		        c.Event3_finished = false
		        c.Event4_finished = false
			end )
		else
			timer.UnPause( "427Event_5_".. activator:SteamID() )
		end
---- regen
	    timer.Create( "scp427_regen".. activator:SteamID(), 1, 0, function()
	        activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 2 ) )
	    end )
    end
end

local function Drop427(ply, normal)
    if ply:GetNWBool("IsWearing427") then
        ply:ChatPrint("Vous avez enlevé SCP-427")
        local ent = ents.Create("scp_427")
        if not ent:IsValid() then return end
        ent:SetPos(ply:GetPos() + Vector(0, 0, 0))
        ent:SetAngles(Angle(0, math.random(0, 359)))
        ent:Spawn()
        ent:Activate()
        ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        ply:EmitSound("scp_427/drop.mp3")
        ply:SetNWBool("IsWearing427", false)
        timer.Pause( "427Event_1_".. ply:SteamID() )
        timer.Pause( "427Event_2_".. ply:SteamID() )
        timer.Pause( "427Event_3_".. ply:SteamID() )
        timer.Pause( "427Event_4_".. ply:SteamID() )
        timer.Pause( "427Event_5_".. ply:SteamID() )
		ply:StopSound("scp_427/scp_427_loop.wav")
		ply:StopSound("scp_427/scp_427_transform.mp3")
        if timer.Exists( "scp427_regen".. ply:SteamID() ) then
        	timer.Stop( "scp427_regen".. ply:SteamID() )
        end
    end
end
process.scp.Drop427 = Drop427

function scp427death(victim, weapon, killer)
    if victim:GetNWBool("IsWearing427") then
        local ent = ents.Create("scp_427")
        if not ent:IsValid() then return end
        ent:SetPos(victim:GetPos() + Vector(0, 0, 0))
        ent:SetAngles(Angle(0, math.random(0, 359)))
        ent:Spawn()
        ent:Activate()
        ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        victim:SetNWBool("IsWearing427", false)
        if timer.Exists( "427Event_1_".. victim:SteamID() ) then
       		timer.Stop( "427Event_1_".. victim:SteamID() )
    	end
        if timer.Exists( "427Event_2_".. victim:SteamID() ) then
        	timer.Stop( "427Event_2_".. victim:SteamID() )
        end
        if timer.Exists( "427Event_3_".. victim:SteamID() ) then
        	timer.Stop( "427Event_3_".. victim:SteamID() )
    	end
    	if timer.Exists( "427Event_4_".. victim:SteamID() ) then
        	timer.Stop( "427Event_4_".. victim:SteamID() )
    	end
		victim:StopSound("scp_427/scp_427_loop.wav")
		victim:StopSound("scp_427/scp_427_transform.mp3")
        if timer.Exists( "scp427_regen".. victim:SteamID() ) then
        	timer.Stop( "scp427_regen".. victim:SteamID() )
        end
    end
end

hook.Add("PlayerDeath", "scp427death", scp427death)

hook.Add("PlayerSay", "SCP427ChatCommand", function(ply, str)
    if str == "!drop427" then
        Drop427(ply, true)
        return
    end
end)

function scp427disconnect( ply )
    if ply:GetNWBool("IsWearing427") then
    	Drop427(ply, true)
    end
end

hook.Add("PlayerDisconnected", "scp427leave", scp427disconnect)