hook.Add("Initialize", "process.change_drop", function ()
    local meta = FindMetaTable("Player")
    function meta:dropDRPWeapon(weapon)
        if GAMEMODE.Config.restrictdrop then
            local found = false
            for k,v in pairs(CustomShipments) do
                if v.entity == weapon:GetClass() then
                    found = true
                    break
                end
            end
    
            if not found then return end
        end
    
        local trace = {}
        trace.start = self:GetShootPos()
        trace.endpos = trace.start + self:GetAimVector() * 50
        trace.filter = {self, weapon, ent}
    
        local tr = util.TraceLine(trace)
    
        local ent = ents.Create(weapon:GetClass())
        ent:SetPos(tr.HitPos)
        ent:Spawn()
    
        weapon:Remove()
    end

    function DarkRP.retrieveRPNames(name, callback)
        for _, ply in pairs(player.GetAll()) do
            if (ply:GetName() == name) then
                callback(true)
                return 
            end
        end

        callback(false)
    end
end)

local disallowedNames = {["ooc"] = true, ["shared"] = true, ["world"] = true, ["world prop"] = true}
hook.Add("CanChangeRPName", "process.darkrp.rpname", function(ply, RPname)
    if disallowedNames[string.lower(RPname)] then return false, "Nom RP refusé." end
    
    local len = string.len(RPname)
    if len > 38 then return false, "(RP Name too long/Nom RP trop long)" end
    if len < 3 then return false, "(RP Name too short/Nom RP trop court)" end
    return true 
end)