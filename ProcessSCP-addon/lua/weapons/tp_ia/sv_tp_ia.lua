//-----------------------------------------//
//       VARIABLES INITIALISATION          //
//-----------------------------------------// 

util.AddNetworkString(SWEP.net_name)
local net_name = SWEP.net_name 


net.Receive(net_name, function (len, ply)
    // initialisation
    if !IsValid(ply:GetActiveWeapon()) or ply:GetActiveWeapon():GetClass() != "tp_ia" then // check if the player still have the swep in hand
        return 
    end
    ply.indexTP = net.ReadUInt(16)
    ply:SetPos(tp_list[ply.indexTP])
end)