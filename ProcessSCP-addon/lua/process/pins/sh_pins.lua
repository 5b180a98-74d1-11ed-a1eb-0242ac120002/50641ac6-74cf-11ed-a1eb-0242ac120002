process.pins.MODELS = {}
process.pins.DONATOR_STATUTS = {}
process.pins.TITLES = {}

local function add_pins(name, donator_statut)
    local pins = process.pins

    table.insert(pins.MODELS, "models/pins/"..name.."/pins_"..name..".mdl")

    table.insert(pins.DONATOR_STATUTS, donator_statut or 10) -- 10 if not for donator

    table.insert(process.pins.TITLES, name)
end

add_pins("beta_test")
add_pins("euro", 1)
add_pins("anniversaire")
add_pins("process")
add_pins("ouverture")
add_pins("ameno")

hook.Add("Initialize", "Process.init_pins", function ()
    process.darkrp.vars.pins = "Process.pins_index"

	DarkRP.registerDarkRPVar(process.darkrp.vars.pins, 
        function (val)
            net.WriteInt(val, 32)
        end, 
        function()
            return net.ReadInt(32)
        end
    )

    -- pins offest
    local models = process.darkrp.models // wait jobs.lua

    process.pins.OFFSETS = {
        arcticspet = Vector(-2, 1.5, 1.7),
        spy = Vector(0, -0.5, 0),
        ghilliesuit = Vector(0, 1.8, 0),
    
        D = Vector(0, 0.3, 0),
    
        sdc = Vector(0, 2.8, 0),
    
        supversieur = Vector(0, 1.2, 0),
        superviseur_f = Vector(-1, -0.85, 0),
    
        FIM = Vector(0, 1.1, 0),
        IT = Vector(0, 1.1, 0),
    }
end)