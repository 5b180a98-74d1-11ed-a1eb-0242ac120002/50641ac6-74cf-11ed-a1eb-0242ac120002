local wm = ClientsideModel(SWEP.WorldModel)
wm:SetNoDraw(true)

wm:SetSkin(1)

local offsetvec = Vector( 4, -7, -2)
local offsetang = Angle( 180, -90, 90 )
function SWEP:DrawWorldModel()
    local ply = self:GetOwner()

    if (!IsValid(ply)) then -- if is spawn with tool gun
        wm:SetModelScale(1)
        wm:SetPos( self:GetPos() )
        wm:SetAngles(self:GetAngles())
        wm:SetupBones()
        wm:DrawModel()
        return 
    end

    local boneid = ply:LookupBone( "ValveBiped.Bip01_R_Hand" )
    if (!boneid) then
        return 
    end

    local matrix = ply:GetBoneMatrix(boneid)
    if (!matrix) then
        return 
    end

    local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )

    wm:SetPos( newpos )
    wm:SetAngles( newang )
    wm:SetupBones()
    wm:DrawModel()
end