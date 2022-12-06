local meta = FindMetaTable("Player")
meta.process_effects = {}
/* effect strucutre
{
    timers = {"timer name"}, 
    name = "",
    tags = {""} // disease, bad, good, 
    remove_effect = function(ply) self:SetWalkSpeed(222) end
}
*/

function meta:Add_effect(effect)
    table.insert(self.process_effects, effect)
end

function meta:Remove_effect(key_or_effect)
    local effect = istable(key_or_effect) and key_or_effect or self.process_effects[key_or_effect]
    effect.remove_effect(self)
    for _, effect_timer in pairs(effect.timers) do
        timer.Remove(effect_timer)
    end
    
    if (istable(key_or_effect)) then
        table.RemoveByValue(self.process_effects, key_or_effect)
    else
        self.process_effects[key_or_effect] = nil
    end
end

function meta:Remove_effects(...)
    local tags = {...}

    if (#tags > 0) then
        for _, tag in pairs({...}) do
            for key, effect in pairs(self.process_effects) do
                if (table.HasValue(effect.tags, tag)) then
                    self:Remove_effect(key)
                end
            end
        end
    else
        for key, effect in pairs(self.process_effects) do
            self:Remove_effect(key)
        end 
    end
end

function meta:Have_effect(...)
    for _, tag in pairs({...}) do
        for _, effect in pairs(self.process_effects) do
            if (table.HasValue(effect.tags, tag)) then
                return true
            end
        end
    end

    return false
end

local function die(ply)
    ply:Remove_effects()
end

hook.Add( "PlayerDeath", "process.remove_effects", die )
hook.Add( "PlayerChangedTeam", "process.remove_effects", die )