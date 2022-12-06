local halo_color = Color( 173, 69, 0)

hook.Add("Initialize", "Process.scan_bio", function ()
    hook.Add( "PreDrawHalos", "Process.scan_bio", function()
        local player_with_halos = {}
        for _, ply in pairs(player.GetAll()) do
            if (ply:getDarkRPVar(process.darkrp.vars.scan_bio) == 1) then
                table.insert(player_with_halos, ply)
            end
        end
    
        halo.Add(player_with_halos, halo_color, 1, 1)
    end )
end)