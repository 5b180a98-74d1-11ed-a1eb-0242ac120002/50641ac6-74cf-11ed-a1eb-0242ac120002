DarkRP.createShipment("matraque", {
    model = "models/weapons/tfa_l4d_mw2019/melee/w_baton.mdl", -- The model of the item that hovers above the shipment
    entity = "tfa_mw2019_baton", -- the ent that comes out of the shipment
    price = 500, -- the price of one shipment
    amount = 1, -- how many of the item go in one purchased shipment
    separate = false,

    -- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
    allowed = {TEAM_CONTR, TEAM_CONTRAVANCE}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
    category = "Other", -- The name of the category it is in. Note: the category must be created!
    description = "",
    noship = false,
})

DarkRP.createShipment("couteau", {
    model = "models/weapons/tfa_l4d_mw2019/melee/w_knife.mdl", -- The model of the item that hovers above the shipment
    entity = "tfa_mw2019_knife", -- the ent that comes out of the shipment
    price = 750, -- the price of one shipment
    amount = 1, -- how many of the item go in one purchased shipment
    separate = false,

    -- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
    allowed = {TEAM_CONTR, TEAM_CONTRAVANCE}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
    category = "Other", -- The name of the category it is in. Note: the category must be created!
    description = "",
    noship = false,
})

DarkRP.createShipment("colson/serflex", {
    model = "models/tobadforyou/flexcuffs_deployed.mdl", -- The model of the item that hovers above the shipment
    entity = "weapon_r_restrains", -- the ent that comes out of the shipment
    price = 1500, -- the price of one shipment
    amount = 1, -- how many of the item go in one purchased shipment
    separate = false,

    -- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
    allowed = {TEAM_CONTR, TEAM_CONTRAVANCE}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
    category = "Other", -- The name of the category it is in. Note: the category must be created!
    description = "",
    noship = false,
})

DarkRP.createShipment("carte d'accès niveau 0", {
    model = "models/keycards/w_keycard.mdl", -- The model of the item that hovers above the shipment
    entity = "process_keycard_lvl_0", -- the ent that comes out of the shipment
    price = 5000, -- the price of one shipment
    amount = 1, -- how many of the item go in one purchased shipment
    separate = false,

    -- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
    allowed = {TEAM_CONTR, TEAM_CONTRAVANCE}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
    category = "Other", -- The name of the category it is in. Note: the category must be created!
    description = "",
    noship = false,
})

DarkRP.createShipment("Chargeurs de munitions", {
    model = "models/items/boxsrounds.mdl", -- The model of the item that hovers above the shipment
    entity = "process_ammo_box", -- the ent that comes out of the shipment
    price = 600, -- the price of one shipment
    amount = 1, -- how many of the item go in one purchased shipment
    separate = false,

    -- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
    allowed = {TEAM_CONTR, TEAM_CONTRAVANCE}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
    category = "Other", -- The name of the category it is in. Note: the category must be created!
    description = "",
    noship = false,
})

DarkRP.createShipment("M17", {
    model = "models/viper/mw/weapons/w_p320.mdl", -- The model of the item that hovers above the shipment
    entity = "mg_p320", -- the ent that comes out of the shipment
    price = 1500, -- the price of one shipment
    amount = 1, -- how many of the item go in one purchased shipment
    separate = false,

    -- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
    allowed = {TEAM_CONTR, TEAM_CONTRAVANCE}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
    category = "Other", -- The name of the category it is in. Note: the category must be created!
    description = "",
    noship = false,
})

DarkRP.createShipment("MP7", {
    model = "models/viper/mw/weapons/w_mpapa7.mdl", -- The model of the item that hovers above the shipment
    entity = "mg_mpapa7", -- the ent that comes out of the shipment
    price = 1500, -- the price of one shipment
    amount = 1, -- how many of the item go in one purchased shipment
    separate = false,

    -- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
    allowed = {TEAM_CONTRAVANCE}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
    category = "Other", -- The name of the category it is in. Note: the category must be created!
    description = "",
    noship = false,
})

DarkRP.createShipment("Colt Anaconda", {
    model = "models/viper/mw/weapons/w_357.mdl", -- The model of the item that hovers above the shipment
    entity = "mg_357", -- the ent that comes out of the shipment
    price = 1500, -- the price of one shipment
    amount = 1, -- how many of the item go in one purchased shipment
    separate = false,

    -- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
    allowed = {TEAM_CONTRAVANCE}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
    category = "Other", -- The name of the category it is in. Note: the category must be created!
    description = "",
    noship = false,
})

hook.Add("Initialize", "Process.darkrp.shipment", function ()
    for _, shipment in pairs(CustomShipments) do
        shipment.getPrice = function (ply, price)
            return ply:Team() == TEAM_STAFF and 0 or price
        end
        
        table.insert(shipment.allowed, TEAM_STAFF)
    end
end)