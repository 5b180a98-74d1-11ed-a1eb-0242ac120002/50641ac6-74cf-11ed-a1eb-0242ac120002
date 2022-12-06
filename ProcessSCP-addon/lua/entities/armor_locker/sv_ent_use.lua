local anti_spam = SysTime()
function ENT:Use(ply)
    if anti_spam + process.config.anti_spam_delay > SysTime() then return end
    anti_spam = SysTime()

    if !ply:IsPlayer() then return end

    if process.ASR.is_empty(ply) then return end

    if (ply:Team() == TEAM_UITS) then
        process.reload_armor(ply)
    
        net.Start(process.armor_locker.net_name_uits)
        net.Send(ply)

        goto have_acess
    end

    for _, class_group in pairs(process.armor_locker.weapons) do
        for _, job in pairs(class_group.jobs) do
            if (job == ply:Team()) then
                process.reload_armor(ply)

                net.Start(process.armor_locker.net_name)
                net.Send(ply)

                goto have_acess 
            end
        end
    end

    sam.player.send_message(ply, "{A} {red n'as pas accès à l'armurerie !}", {
        A = ply
    })
    if true then return end

    ::have_acess::
    if (!ply.process_armor_delay or ply.process_armor_delay < CurTime()) then
        ply:SetArmor(ply:GetMaxArmor())
        ply.process_armor_delay = CurTime() + process.config.armor_delay
    end
end