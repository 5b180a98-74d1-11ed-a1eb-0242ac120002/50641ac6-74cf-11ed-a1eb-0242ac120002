if jit.arch != "x86" then return end

require('microphone')

// call function from module
Process_microphone_set_clamp(0, 1000)
Process_microphone_set_noise(10)
Process_microphone_set_sound_quality(30)
Process_microphone_set_reverb(13, 3, 1)

local microphones = {}
function ENT:Initialize()
    self:SetModel( "models/microphone/microphone.mdl" )
    
    self:SetUseType(SIMPLE_USE)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:PhysWake()

    table.insert(microphones, self)
end

function ENT:OnRemove()
    table.RemoveByValue(microphones, self)
end

local microphone_sound
function ENT:Use()
    if (microphone_sound) then microphone_sound:Stop() end

    if (self.is_active) then
        self:SetBodygroup(1, 0)
        
        self.is_active = false

        microphone_sound = process.ReadSound("microphone/intercom_micro_fin.mp3")
    else
        self:SetBodygroup(1, 1)

        self.is_active = true

        microphone_sound = process.ReadSound("microphone/intercom_micro_debut.mp3")
    end
end

process.config.microphone_distance = math.pow(process.config.microphone_distance, 2)

// add effect for ply in range of an active microphone
timer.Create("Process.microphone", 1, 0, function ()
    for _, microphone in pairs(microphones) do
        for _, ply in pairs(player.GetAll()) do
            if (microphone.is_active and microphone:GetPos():DistToSqr(ply:GetPos()) < process.config.microphone_distance) then
                Process_microphone_add_user_id(ply:UserID())    
            else
                Process_microphone_remove_user_id(ply:UserID())    
            end
        end
    end
end)

hook.Add("PlayerDisconnected", "Process.microphone_remove_disconnected", function (ply)
    Process_microphone_remove_user_id(ply:UserID())        
end)