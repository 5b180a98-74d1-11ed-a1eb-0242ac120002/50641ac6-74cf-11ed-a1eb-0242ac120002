local BlurryVision = "BlurryVision"
local ResetBlurryVision = "ResetBlurryVision"

if (SERVER) then
    util.AddNetworkString( ResetBlurryVision )
end

if CLIENT then
    net.Receive(BlurryVision, function ( )
        ply = LocalPlayer()
        delay = net.ReadFloat()
        ply.BlurryShock = true
        ply:EmitSound( "amnesique/tinnitus_amnesia.mp3" )
        timer.Simple(delay, function()
            if !IsValid(ply) then return end
            ply.BlurryShock = false
        end)
    end)

    net.Receive(ResetBlurryVision, function ( )
        Check = net.ReadBool()
        local ply = LocalPlayer()
        if Check and ply.BlurryShock then
            ply.BlurryShock = false
        end
    end)
    
    function ShockEffectAmnesia()
        local ply = LocalPlayer()
        local curTime = FrameTime()
        if !ply.AddAlpha then ply.AddAlpha = 1 end
        if !ply.DrawAlpha then ply.DrawAlpha = 0 end
        if !ply.Delay then ply.Delay = 0 end
        --if !ply.ColorDrain then ply.ColorDrain = 1 end
            
        if ply.BlurryShock then 
            ply.AddAlpha = 0.2
            ply.DrawAlpha = 0.99
            ply.Delay = 0.05
            --ply.ColorDrain = 0.66
        else
            ply.AddAlpha = math.Clamp(ply.AddAlpha + curTime * 0.4, 0.2, 1)
            ply.DrawAlpha = math.Clamp(ply.DrawAlpha - curTime * 0.4, 0, 0.99)
            ply.Delay = math.Clamp(ply.Delay - curTime * 0.4, 0, 0.05)
            --ply.ColorDrain = math.Clamp(ply.ColorDrain + curTime * 0.4, 0.66, 1)
        end
        
        DrawMotionBlur( ply.AddAlpha, ply.DrawAlpha, ply.Delay )
        
        -- local Color = {}
        -- Color[ "$pp_colour_addr" ] = 0
        -- Color[ "$pp_colour_brightness" ] = 0
        -- Color[ "$pp_colour_mulg" ] = 0
        -- Color[ "$pp_colour_colour" ] = ply.ColorDrain
        -- Color[ "$pp_colour_addg" ] = 0
        -- Color[ "$pp_colour_addb" ] = 0
        -- Color[ "$pp_colour_mulr" ] = 0
        -- Color[ "$pp_colour_mulb" ] = 0
        -- Color[ "$pp_colour_contrast" ] = 1
        -- DrawColorModify( Color )
    end

    hook.Add("RenderScreenspaceEffects","ShockEffectAmnesia",ShockEffectAmnesia)
end

-- To remove all the effects on the client side.
local function SendResetBlurryVision(victim)
	net.Start(ResetBlurryVision)
	net.WriteBool(true)
	net.Send(victim)
end

-- Function called to remove all effect on death or changed team
function RemoveEffectAmnesia(victim)
	if timer.Exists("amnesia_effect"..victim:SteamID()) then
		timer.Remove("amnesia_effect"..victim:SteamID())
	end
    if timer.Exists("amnesic_side_effect_"..victim:SteamID()) then
		timer.Remove("amnesic_side_effect_"..victim:SteamID())
	end
    victim:StopSound( "amnesique/tinnitus_amnesia.mp3" )
    SendResetBlurryVision(victim)
end

hook.Add( "PlayerDeath", "remove_effect_amnesia", RemoveEffectAmnesia )
hook.Add( "PlayerChangedTeam", "PlayerChangedTeam_remove_effect_amnesia", RemoveEffectAmnesia )
