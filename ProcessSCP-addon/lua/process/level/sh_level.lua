function process.get_max_point_per_level(level)
	return math.Round(level ^ 1.58)
end

hook.Add("Initialize", "Process.init_level", function ()
	process.darkrp.vars.level = "Process.level"
    process.darkrp.vars.point = "Process.point"

	DarkRP.registerDarkRPVar(process.darkrp.vars.level, 
        function (val)
            net.WriteInt(val, 32)
        end, 
        function()
            return net.ReadInt(32)
        end
    )
	DarkRP.registerDarkRPVar(process.darkrp.vars.point, 
        function (val)
            net.WriteInt(val, 32)
        end, 
        function()
            return net.ReadInt(32)
        end
    )
end)