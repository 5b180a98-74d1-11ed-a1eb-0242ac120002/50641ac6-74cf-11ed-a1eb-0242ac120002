function SWEP:Initialize()
	self:SetHoldType('slam')
end

function SWEP:SecondaryAttack() end

local ASR = process.ASR

function ASR.set_filled(filled_amount)
    game.GetWorld():SetNWFloat(process.ASR.net_var_filled, filled_amount)
end

function ASR.set_can_call(can_call)
	game.GetWorld():SetNWBool(ASR.net_var_can_call_asr, can_call)
end

hook.Add("Initialize", "Process.asr.init", function ()
	timer.Simple(40,  function () // to be sur game.GetWorld() exist
		ASR.set_filled(1)
		ASR.set_can_call(true)
	end)
end)

local timer_execution_count_before_empty = process.config.ASR_timer_execution_count_before_empty
ASR.timer_name = "Process.ASR_filling_decrease"
timer.Create(ASR.timer_name, process.config.ASR_empty_delay / timer_execution_count_before_empty, 0, function ()
	if (table.Count(player.GetAll()) < process.config.ASR_min_player) then return end

	if (ASR.get_filled() - 1 / timer_execution_count_before_empty < 0) then
		ASR.set_filled(0)
	else
		ASR.set_filled(ASR.get_filled() - 1 / timer_execution_count_before_empty)
	end
end)

util.AddNetworkString(ASR.net_name)
net.Receive(ASR.net_name, function (len, ply)
	if (!ASR.can_call()) then
		return
	end

	local weapon = ply:GetActiveWeapon()
	if (IsValid(weapon) and weapon:GetClass() == "tablet_logi") then
		ASR.set_can_call(false)

		net.Start(ASR.net_name)
		net.Broadcast() // will run client side : notification.AddLegacy
		sam.player.send_message(player.GetAll(), "{yellow L'agent du service de ravitaillement est désormais disponible.}")
		process.ReadSound("ARS_en_approche.mp3")

		timer.Simple(process.config.ASR_delay_to_call_asr, function ()
			ASR.set_can_call(true)
		end)
	end
end)