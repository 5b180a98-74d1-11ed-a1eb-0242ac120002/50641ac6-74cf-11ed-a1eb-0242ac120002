--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP ent, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the ent to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]

DarkRP.createEntity("Caisse de ravitaillment", {
    category = "Other",
    ent = "asr_crate",
    model = "models/props_blackmesa/bms_metalcrate_48x48.mdl",
    price = 0,
    max = 4,
    cmd = "buyasrcrate",
    allowed = {TEAM_ASR},
    description = [[Caisse de ravitaillment.]]
})

DarkRP.createEntity("Mk19", {
    category = "Other",
    ent = "ent_mk19",
    model = "models/props_tse/props_basement/mk19.mdl",
    price = 0,
    max = 4,
    cmd = "buymk19",
    allowed = {TEAM_UITS},
    description = [[Tourelle mk19.]],
    customCheck = function(ply) 
        if (ply:GetNWInt("Process.uits_class_index") == 8) then
            return true
        end

        return false
    end,
	CustomCheckFailMsg = "Vous n'êtes pas ingégnieur !"
})

DarkRP.createEntity("Détonateur", {
    category = "Other",
    ent = "ent_blasting_machine",
    model = "models/props_equipment/blastingkit01_blastingmachine.mdl",
    price = 0,
    max = 1,
    cmd = "buyent_blasting_machine",
    allowed = {TEAM_UITS},
    description = [[Détonateur.]],
    customCheck = function(ply) 
        if (ply:GetNWInt("Process.uits_class_index") == 2) then
            return true
        end

        return false
    end,
	CustomCheckFailMsg = "Vous n'êtes pas expert en explosif !"
})

DarkRP.createEntity("Charge explosive", {
    category = "Other",
    ent = "ent_blasting_charge",
    model = "models/props_equipment/blastingkit01_c4.mdl",
    price = 0,
    max = 4,
    cmd = "buyent_blasting_charge",
    allowed = {TEAM_UITS},
    description = [[Charge explosive.]],
    customCheck = function(ply) 
        if (ply:GetNWInt("Process.uits_class_index") == 2) then
            return true
        end

        return false
    end,
	CustomCheckFailMsg = "Vous n'êtes pas expert en explosif !"
})

hook.Add("Initialize", "Process.darkrp.ent", function ()
    for _, ent in pairs(DarkRPEntities) do
        ent.getPrice = function (ply, price)
            return ply:Team() == TEAM_STAFF and 0 or price
        end
        
        if (ent.allowed) then
            table.insert(ent.allowed, TEAM_STAFF)
        end
    end
end)