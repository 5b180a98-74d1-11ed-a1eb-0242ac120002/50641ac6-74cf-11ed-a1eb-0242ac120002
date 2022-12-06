-- create an armor system like minecraft and fix hitgroups

// fix hitgroups
local non_formated_hitgroup = {
    //1 HITGROUP_HEAD
    {bones = {'ValveBiped.Bip01_Head1', 'ValveBiped.Bip01_Neck1'}, multiplier = 2},
    
    //2 and 3 HITGROUP_CHEST and HITGROUP_STOMACH
    {bones = {'ValveBiped.Bip01_Spine2', 'ValveBiped.Bip01_L_Clavicle', 'ValveBiped.Bip01_R_Clavicle', 'ValveBiped.Bip01_Pelvis', 'ValveBiped.Bip01_Spine4', 'ValveBiped.Bip01_Spine', 'ValveBiped.Bip01_Spine1', 'ValveBiped.Bip01_Spine2', 'ValveBiped.Bip01_Spine3'}, multiplier = 1},
    
    //4 HITGROUP_LEFTARM
    {
        bones = {'ValveBiped.Bip01_L_UpperArm', 'ValveBiped.Bip01_L_Forearm', 'ValveBiped.Bip01_L_Hand', 'ValveBiped.Bip01_L_Wrist', 'ValveBiped.Bip01_L_Ulna', 'ValveBiped.Bip01_L_Finger02',
        'ValveBiped.Bip01_L_Finger01', 'ValveBiped.Bip01_L_Finger0', 'ValveBiped.Bip01_L_Finger1', 'ValveBiped.Bip01_L_Finger2', 'ValveBiped.Bip01_L_Finger3', 'ValveBiped.Bip01_L_Finger4',
        'ValveBiped.Bip01_L_Finger02', 'ValveBiped.Bip01_L_Finger21', 'ValveBiped.Bip01_L_Finger22', 'ValveBiped.Bip01_L_Finger11', 'ValveBiped.Bip01_L_Finger12'}, 
        multiplier = 0.25
    },
    
    //5 HITGROUP_RIGHTARM
    {
        bones = {'ValveBiped.Bip01_R_UpperArm', 'ValveBiped.Bip01_R_Forearm', 'ValveBiped.Bip01_R_Hand', 'ValveBiped.Bip01_R_Wrist', 'ValveBiped.Bip01_R_Ulna', 'ValveBiped.Bip01_R_Finger02',
        'ValveBiped.Bip01_R_Finger01', 'ValveBiped.Bip01_R_Finger0', 'ValveBiped.Bip01_R_Finger1', 'ValveBiped.Bip01_R_Finger2', 'ValveBiped.Bip01_R_Finger3', 'ValveBiped.Bip01_R_Finger4',
        'ValveBiped.Bip01_R_Finger02', 'ValveBiped.Bip01_R_Finger21', 'ValveBiped.Bip01_R_Finger22', 'ValveBiped.Bip01_R_Finger11', 'ValveBiped.Bip01_R_Finger12'},
        multiplier = 0.25
    },
    
    //6 HITGROUP_LEFTLEG
    {bones = {'ValveBiped.Bip01_L_Thigh', 'ValveBiped.Bip01_L_Calf', 'ValveBiped.Bip01_L_Foot', 'ValveBiped.Bip01_L_Toe0'}, multiplier = 0.25},
    
    //7 HITGROUP_RIGHTLEG
    {bones = {'ValveBiped.Bip01_R_Thigh', 'ValveBiped.Bip01_R_Calf', 'ValveBiped.Bip01_R_Foot', 'ValveBiped.Bip01_R_Toe0'}, multiplier = 0.25},
}

local formated_hitgroup = {}
for _, hitgroup in pairs(non_formated_hitgroup) do
    for _, bone in pairs(hitgroup.bones) do
        formated_hitgroup[bone] = hitgroup.multiplier
    end
end

hook.Add("PlayerTraceAttack", "Process.alternative_armor_system.fix_hitgroup", function (ply, dmg_info, dir, trace)
    if (trace.HitGroup == 0) then // equal 0 when pm has bad hitgroup
        local dmg_scale = formated_hitgroup[ply:GetBoneName(ply:GetHitBoxBone(trace.HitBox, 0))]
        if (dmg_scale) then
            dmg_info:ScaleDamage(dmg_scale)
        end
    end
end)

hook.Add("Initialize", "process.ScalePlayerDamage", function ()
    local model_armor = {
        [process.darkrp.models.talos] = 0.75,
        [process.darkrp.models.uiaa] = 0.75,
        [process.darkrp.models.masto] = 0.35,
        [process.darkrp.models.uiaal] = 0.35,
    }
    
    local living_damage = process.to_if_check_table(DMG_RADIATION, DMG_NERVEGAS, DMG_POISON)
    
    hook.Add("EntityTakeDamage", "process.ScalePlayerDamage", function (ply, dmg_info)
        if (!ply:IsPlayer()) then
            return
        end
        
        if (living_damage[dmg_info:GetDamageType()] and process.darkrp.groups.not_living[ply:Team()]) then
            return true
        end
        
        dmg_info:ScaleDamage(model_armor[ply:GetModel()] or 1)
    end)
end)