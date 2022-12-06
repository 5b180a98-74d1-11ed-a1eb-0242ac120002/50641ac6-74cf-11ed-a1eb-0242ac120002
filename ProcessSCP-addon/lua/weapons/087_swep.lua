
-----------------------------------------------------
SWEP.Category 			    = "SCP RP"
SWEP.PrintName				= "SCP-Screamer"			
SWEP.Author					= "TomGeek"
SWEP.Instructions			= "Left click to scream the player | Right click to self scream"
SWEP.ViewModelFOV = 56
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Delay          = 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "None"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 1
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 0
SWEP.SlotPos				= 2
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true
SWEP.IdleAnim				= true
SWEP.ViewModel				= ""
SWEP.WorldModel				= ""
 
SWEP.HoldType 				= ""


function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
end


local attente = 1
function SWEP:PrimaryAttack()
	if not SERVER then return end
	if attente == 0 then return end
	attente = 0
	timer.Simple(0.3, function() attente = 1 end)

	trace = self:GetOwner():GetEyeTrace()
	if trace.Entity:IsPlayer() then
		trace.Entity:SetNWBool("draw087", true)
		trace.Entity:TakeDamage( 40, "SCP-087", "SCP-087" )
		trace.Entity:ConCommand("play scprp/horror"..math.random(1,4)..".wav")
		timer.Simple(0.3, function() trace.Entity:SetNWBool("draw087", false) end)
	end

end

function SWEP:SecondaryAttack()
	
end


if CLIENT then
	local function draw087()	
		if LocalPlayer():GetNWBool("draw087") then
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( Material("scprp/pic"..math.random(1,6)..".jpg"))
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		end
	end

	hook.Add("HUDPaint", "draw087", draw087)
end
	
	
if SERVER then	
	hook.Add("PlayerDeath", "removedraw087", function(ply)
		ply:SetNWBool("draw087", false)
	end)
end