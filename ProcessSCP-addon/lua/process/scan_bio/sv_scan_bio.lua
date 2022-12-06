local scan_bio_authorized_jobs 
hook.Add("Initialize", "Process.scan_bio.init_job", function ()
    scan_bio_authorized_jobs = process.to_if_check_table(TEAM_STAFF, TEAM_DDS, TEAM_IAA, TEAM_DIRSCT)
end)

local scan_delay = process.config.scan_bio_delay
local last_scan = -scan_delay

local pos_a = Vector(-1404, -8984, 2823)
local pos_b = Vector(-14131, 21780, -4100)

local timer_name = "Process.scan_bio"
local scan_bio_delay_between_info = process.config.scan_bio_duration / 20
local scan_bio_percentage = 0
local function scan_bio()
    scan_bio_percentage = scan_bio_percentage + scan_bio_delay_between_info / process.config.scan_bio_duration * 100

    if (scan_bio_percentage >= 100) then
        sam.player.send_message(player.GetAll(), "Scan biométrique complet.")

        last_scan = SysTime()

        for _, ply in pairs(player.GetAll()) do
            if (ply:GetPos():WithinAABox(pos_a, pos_b) and ply:getJobTable().category == "Civil") then
                ply:setDarkRPVar(process.darkrp.vars.scan_bio, 1)
            end
        end

        return
    end

    sam.player.send_message(player.GetAll(), "Scan biométrique "..scan_bio_percentage.."%")

    timer.Create(timer_name, scan_bio_delay_between_info, 1, scan_bio)
end

process.scan_bio_sam_OnExecute = function (calling_ply)
    if (scan_bio_authorized_jobs[calling_ply:Team()] and !timer.Exists(timer_name) and last_scan + scan_delay < SysTime()) then
        process.ReadSound("scan_biometrique.wav")

        scan_bio_percentage = 0
        timer.Create(timer_name, scan_bio_delay_between_info, 1, scan_bio)
    else
        sam.player.send_message(calling_ply, "{A} es pas autorisé à lancer un scan biométrique !", {
            A = calling_ply
        })
    end
end

hook.Add("PlayerSpawn", "Process.scan_bio", function (ply)
    ply:setDarkRPVar(process.darkrp.vars.scan_bio, 0)
end)