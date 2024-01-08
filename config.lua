Config = {}

-- Language setting - English | Portuguese_BR
Config.Lang = 'English'

Config.Job = "doctor"

Config.KeyOpenMedicCabinet = 0xD9D0E1C0 -- [SPACE]
Config.KeyCloseMedicCabinet = 0x4AF4D473 -- [DELETE] -- Not sure if close menu

Config.itemsForRevivePlayer = {
    {
        item = "syringe_steroids",     -- Name of item in DB
        label = "Syringe of Steroids", -- Translate item Name
        amount = 1,                    -- QTD remove of iventory to apply in player
    },
    {
        item = "syringe_adrenalin",     -- Name of item in DB
        label = "Syringe of Adrenalin", -- Translate item Name
        amount = 1,                     -- QTD remove of iventory to apply in player
    },
    -- add more here
}

Config.itemsForHealPlayer = {
    {
        item = "bandage_clean",  -- Name of item in DB
        label = "Bandage Clean", -- Translate item Name
        amount = 1,              -- QTD remove of iventory to apply in player
    },
    {
        item = "bandage_dirty",  -- Name of item in DB
        label = "Bandage Dirty", -- Translate item Name
        amount = 2,              -- QTD remove of iventory to apply in player
    },
    -- add more here
}

Config.itemsForMedic = {
    -- Items for healing
    { item = "bandage_clean", label = "Bandage Clean", givAmount = 5 },
    { item = "bandage_dirty", label = "Bandage Dirty", givAmount = 5 },
    -- Items for reviving
    { item = "syringe_steroids", label = "Syringe of Steroids", givAmount = 5 },
    { item = "syringe_adrenalin", label = "Syringe of Adrenalin", givAmount = 5 },s
    -- add more here
}

Config.MedicLocations = {
    { x = -288.07, y = 804.33,   z = 119.39 },
    { x = 2721.31, y = -1233.65, z = 50.37 }
}
