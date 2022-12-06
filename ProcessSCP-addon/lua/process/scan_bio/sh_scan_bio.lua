hook.Add("Initialize", "Process.init_scan_bio", function ()
	process.darkrp.vars.scan_bio = "Process.scan_bio"

	DarkRP.registerDarkRPVar(process.darkrp.vars.scan_bio, 
        function (val)
            net.WriteInt(val, 32)
        end, 
        function()
            return net.ReadInt(32)
        end
    )
end)