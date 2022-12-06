local lvl = 1

SWEP.Category               = "Process scp"

local swep_print_name = "Keycard_"..lvl
SWEP.PrintName				= swep_print_name
SWEP.Author					= "Zekirax"

SWEP.Instructions			= ""

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Delay          = -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "None"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"

SWEP.HoldType = "slam"

SWEP.Weight					= 1

SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true

SWEP.IdleAnim				= true

SWEP.ViewModel			= "models/keycards/v_keycard.mdl"
SWEP.WorldModel			= "models/keycards/w_keycard.mdl"
SWEP.UseHands           = true


SWEP.GuthSCPLVL = lvl + 1

function SWEP:PrimaryAttack()
	
end

function SWEP:SecondaryAttac()
	
end

if (SERVER) then
	function SWEP:Deploy()
		self:CallOnClient("Deploy")
	end

	function SWEP:Equip()
		self:CallOnClient("Equip")
	end

	function SWEP:OnDrop()
		timer.Simple(0, function ()
			self:CallOnClient("OnDrop")
		end)
	end
end

function SWEP:Initialize()
	self:SetSkin(lvl)
end

if (CLIENT) then	  
	function SWEP:PreDrawViewModel(vm)
		vm:SetSkin(lvl)
	end

	--view model
	local function reset_vm_skin(self)
		local ply = self:GetOwner()
		
		if (IsValid(ply)) then -- to not create error when disconnect
			local view_model = ply:GetViewModel()

			if (IsValid(view_model)) then -- to not create error when disconnect
				view_model:SetSkin(0)
			end
		end

		return true
	end

	SWEP.Holster = reset_vm_skin
	SWEP.OnRemove = reset_vm_skin
	SWEP.OnDrop = reset_vm_skin

	-- world model
	local wm = ClientsideModel(SWEP.WorldModel)
	wm:SetNoDraw(true)
	wm:SetSkin(lvl)

	local offsetvec = Vector( 5, -4, -2.5 )
	local offsetang = Angle( -310, 0, 181.7 )
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

		wm:SetModelScale(1/1.5)

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
end

GuthSCP.registerKeycardSWEP( SWEP )
