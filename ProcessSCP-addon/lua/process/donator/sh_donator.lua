hook.Add("Initialize", "Process.init_donator", function ()
	process.darkrp.vars.donator = "Process.donator"

	DarkRP.registerDarkRPVar(process.darkrp.vars.donator, 
        function (val)
            net.WriteInt(val, 32)
        end, 
        function()
            return net.ReadInt(32)
        end
    )
end)