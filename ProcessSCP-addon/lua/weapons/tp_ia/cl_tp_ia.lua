//-----------------------------------------//
//      MENU VARIABLES INITIALISATION      //
//-----------------------------------------//

local net_name = SWEP.net_name 
local scale_factor = 1
local responsive_factor = math.min(ScrW() / 1920, ScrH() / 1080) * scale_factor
local frame_size = {x = 1200 * responsive_factor, y = 800 * responsive_factor }

local button_size = {x = 50 * responsive_factor, y = 50 * responsive_factor}

local button_orange = Color(255, 183, 77, 120)

surface.CreateFont( "Process.animation_swep_button", {
	font = "Arial",
	size = 45 * responsive_factor,
	weight = 400 * responsive_factor,
} )

//-----------------------------------------//
//            UI USAGE DEFINITION          //
//-----------------------------------------//

local next_primary_attack = CurTime()

function SWEP:PrimaryAttack()
    if (CurTime() < next_primary_attack) then
        return
    end
    next_primary_attack = CurTime() + 0.5
    // -- frame initialisation
    local frame = vgui.Create("Process.Frame")
    frame:MakePopup()
    frame:SetPos((ScrW() - frame_size.x) / 2, (ScrH() - frame_size.y) / 2)
    frame:SizeTo(frame_size.x, frame_size.y, 0.3)
    frame:SetAlpha(230)
    // -- IMG initialisation
    local img = vgui.Create("DImage", frame)
    img:SetImage("materials/tp_ia/background.jpg")
    img:SetSize(1200 * scale_factor,800 * scale_factor)
    img:SetPos(0, 22 * scale_factor)
    // -- Button D initialisation
    local button_classD = vgui.Create("DImageButton", frame)
    button_classD:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_classD:SetSize(button_size.x, button_size.y)
    button_classD:SetPos(1030,450)
    function button_classD:DoClick()
        net.Start(net_name)
        net.WriteUInt(1,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button Scientist initialisation
    local button_scientist = vgui.Create("DImageButton", frame)
    button_scientist:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_scientist:SetSize(button_size.x, button_size.y)
    button_scientist:SetPos(910,365)
    function button_scientist:DoClick()
        net.Start(net_name)
        net.WriteUInt(2,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button Guard initialisation
    local button_guard = vgui.Create("DImageButton", frame)
    button_guard:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_guard:SetSize(button_size.x, button_size.y)
    button_guard:SetPos(895,458)
    function button_guard:DoClick()
        net.Start(net_name)
        net.WriteUInt(3,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button stockage initialisation
    local button_stockage = vgui.Create("DImageButton", frame)
    button_stockage:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_stockage:SetSize(button_size.x, button_size.y)
    button_stockage:SetPos(910,570)
    function button_stockage:DoClick()
        net.Start(net_name)
        net.WriteUInt(4,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button bunker initialisation
    local button_bunker = vgui.Create("DImageButton", frame)
    button_bunker:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_bunker:SetSize(button_size.x, button_size.y)
    button_bunker:SetPos(780,397)
    function button_bunker:DoClick()
        net.Start(net_name)
        net.WriteUInt(5,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button button_checkpointLCZ initialisation
    local button_checkpointLCZ = vgui.Create("DImageButton", frame)
    button_checkpointLCZ:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_checkpointLCZ:SetSize(button_size.x, button_size.y)
    button_checkpointLCZ:SetPos(690,458)
    function button_checkpointLCZ:DoClick()
        net.Start(net_name)
        net.WriteUInt(6,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button Generateur initialisation
    local button_generator = vgui.Create("DImageButton", frame)
    button_generator:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_generator:SetSize(button_size.x, button_size.y)
    button_generator:SetPos(632,528)
    function button_generator:DoClick()
        net.Start(net_name)
        net.WriteUInt(7,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button 035 initialisation
    local button_035 = vgui.Create("DImageButton", frame)
    button_035:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_035:SetSize(button_size.x, button_size.y)
    button_035:SetPos(590,495)
    function button_035:DoClick()
        net.Start(net_name)
        net.WriteUInt(8,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button 096 initialisation
    local button_096 = vgui.Create("DImageButton", frame)
    button_096:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_096:SetSize(button_size.x, button_size.y)
    button_096:SetPos(592,180)
    function button_096:DoClick()
        net.Start(net_name)
        net.WriteUInt(9,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button 008 initialisation
    local button_008 = vgui.Create("DImageButton", frame)
    button_008:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_008:SetSize(button_size.x, button_size.y)
    button_008:SetPos(430,250)
    function button_008:DoClick()
        net.Start(net_name)
        net.WriteUInt(10,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button checkpointHCZ initialisation
    local button_checkpointHCZ = vgui.Create("DImageButton", frame)
    button_checkpointHCZ:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_checkpointHCZ:SetSize(button_size.x, button_size.y)
    button_checkpointHCZ:SetPos(430,370)
    function button_checkpointHCZ:DoClick()
        net.Start(net_name)
        net.WriteUInt(11,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button Serveurs IA initialisation
    local button_serverIA = vgui.Create("DImageButton", frame)
    button_serverIA:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_serverIA:SetSize(button_size.x, button_size.y)
    button_serverIA:SetPos(130,375)
    function button_serverIA:DoClick()
        net.Start(net_name)
        net.WriteUInt(12,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button bureau administrator initialisation
    local button_bureauadmin = vgui.Create("DImageButton", frame)
    button_bureauadmin:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_bureauadmin:SetSize(button_size.x, button_size.y)
    button_bureauadmin:SetPos(120,445)
    function button_bureauadmin:DoClick()
        net.Start(net_name)
        net.WriteUInt(13,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button QGIT initialisation
    local button_qgit = vgui.Create("DImageButton", frame)
    button_qgit:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_qgit:SetSize(button_size.x, button_size.y)
    button_qgit:SetPos(158,490)
    function button_qgit:DoClick()
        net.Start(net_name)
        net.WriteUInt(14,16)
        net.SendToServer()
        frame:Remove()
    end
    // -- Button bureau administrator initialisation
    local button_gateA = vgui.Create("DImageButton", frame)
    button_gateA:SetImage("materials/ath_ia_swep/i_visibility.png")
    button_gateA:SetSize(button_size.x, button_size.y)
    button_gateA:SetPos(150,660)
    function button_gateA:DoClick()
        net.Start(net_name)
        net.WriteUInt(15,16)
        net.SendToServer()
        frame:Remove()
    end
end