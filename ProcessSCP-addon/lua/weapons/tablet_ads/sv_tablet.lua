local net_name = SWEP.net_name

util.AddNetworkString(net_name)

function SWEP:SecondaryAttack() end

function SWEP:PrimaryAttack() 
    net.Start(net_name)
    net.Send(self:GetOwner())
end

local tablet = process.tablet

local authorized_jobs 

/*hook.Add("Initialize", "Process.tablet.init_job", function ()
    authorized_jobs = process.to_if_check_table(TEAM_STAFF, TEAM_DDS, TEAM_IAA)
end)*/

local last_sound
local last_loop_sound
net.Receive(net_name, function (len, ply)
    /*if (!authorized_jobs[ply:Team()]) then
        return
    end*/
    
    local index_sound = net.ReadUInt(16)

    if (index_sound == tonumber("0xffff")) then
        process.ReadSound("tablet_ads/fin_dalerte.mp3")

        return 
    end

    if (index_sound == 0) then
        if !last_loop_sound then return end

        last_loop_sound:Stop()
        return
    end

    local sended_sound = tablet.sounds[index_sound]
    if (!sended_sound) then
        print(ply:SteamID().." a envoyé un index d'alarme invalide !!!!")
        return
    end

    if (sended_sound.is_loop) then
        if (last_loop_sound) then last_loop_sound:Stop() end

        last_loop_sound = process.ReadSound(sended_sound.path)
    else
        if (last_sound) then last_sound:Stop() end

        last_sound = process.ReadSound(sended_sound.path)
    end
end)