/*
SCP-682 - Advanced SWEP fait par Veeds et Feeps ont une bonne addon qui besoin d'un fix d'une ligne. ils m'ont dis d'aller me faire enculé. Donc je le fix
*/
hook.Add("Initialize", "Process.fix_swep_682", function ()
    hook.Add("PlayerDeath", "FV:SCP682", function(ply, inflictor, attacker)
        if !IsValid(attacker) or !attacker:IsPlayer() then return end
        local wep = attacker:GetActiveWeapon() -- Actually equals to inflictor, but not using it for rare cases
        if not wep:IsValid() or wep:GetClass() ~= "fv_scp682" then return end
        
        wep:SetSCPSize(wep:GetSCPSize() + weapons.Get("fv_scp682").SizeGainCVAR:GetFloat())
    end)
end)