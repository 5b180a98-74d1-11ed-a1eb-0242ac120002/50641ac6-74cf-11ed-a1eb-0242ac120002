hook.Add("EntityTakeDamage", "process.073_is_hit", function(victim, dmg)
    local attacker = dmg:GetAttacker()
    if IsValid(victim) and victim:IsPlayer() and TEAM_073 == victim:Team() and IsValid(attacker) and (attacker:IsPlayer() or attacker:IsNPC()) and attacker != victim then 
        attacker:TakeDamageInfo( dmg )
    end
end)