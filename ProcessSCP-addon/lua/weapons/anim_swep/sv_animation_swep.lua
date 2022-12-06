//-----------------------------------------//
//       VARIABLES INITIALISATION          //
//-----------------------------------------// 

util.AddNetworkString(SWEP.net_name)
local net_name = SWEP.net_name 

//-----------------------------------------//
//           SERVER FUNCTIONS              //
//-----------------------------------------//

// -- Remove the animation if the player switch the swep or if the swep is removed or droped
function removeSwep(self)
    local ply = self:GetOwner()
    if !ply.indexAnimation or ply.indexAnimation == 0 then
        return true
    end
    for aBone,anAngle in pairs(animation_table[ply.indexAnimation]) do
        if ply:LookupBone(aBone) and anAngle then
            ply:ManipulateBoneAngles(ply:LookupBone(aBone), Angle(0,0,0))
        end
    end
end

// -- Animation loader called when the player click on a button of the menu
net.Receive(net_name, function (len, ply)
    // initialisation
    if !IsValid(ply:GetActiveWeapon()) or ply:GetActiveWeapon():GetClass() != "anim_swep" then // check if the player still have the swep in hand
        return 
    end
    removeSwep(ply:GetActiveWeapon()) // reinit the animation
    ply.indexAnimation = net.ReadUInt(16)
    local animationTransitionLoop = 0 // counter of the timer
    local animationLoop = 15 // duration of the animation
    // animation part
    timer.Create(ply:SteamID().."animation_timer", 0.01, animationLoop, function()
        if not ply:Crouching() and ply:GetVelocity():Length() < 5 and not ply:InVehicle() and ply.indexAnimation and ply.indexAnimation >= 1 and ply.indexAnimation <= #animation_table then        
            for aBone,anAngle in pairs(animation_table[ply.indexAnimation]) do
                if ply:LookupBone(aBone) and anAngle then // check if the bone and the angle exist
                    ply:ManipulateBoneAngles(ply:LookupBone(aBone), animation_table[ply.indexAnimation][aBone] / animationLoop * animationTransitionLoop)
                end
            end
            animationTransitionLoop = animationTransitionLoop + 1
        end
    end)
end)

// -- Remove the animation if the player is mooving
hook.Add("Move", "process_animation_move", function (ply, mv)
    if mv:GetVelocity():LengthSqr() > 1 and ply.indexAnimation and ply.indexAnimation != 0 then
        for aBone,anAngle in pairs(animation_table[ply.indexAnimation]) do
            if ply:LookupBone(aBone) and anAngle then
                ply:ManipulateBoneAngles(ply:LookupBone(aBone), Angle(0,0,0))
            end
        end
        ply.indexAnimation = 0
        if timer.Exists(ply:SteamID().."animation_timer") then
            timer.Remove(ply:SteamID().."animation_timer")
        end
    end        
end)


SWEP.OnRemove = removeSwep
SWEP.Holster = removeSwep
