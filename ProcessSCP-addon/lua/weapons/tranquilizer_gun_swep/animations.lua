AddCSLuaFile()

SWEP.Animations = {
    ["Idle"] = {--idle is a special animation index, movement animations are played when this is on
        Sequences = {"idle"},
        Fps = 30,
        Events = {
        {Time = 0, Callback = function(self) self:EnableGrip() end},
        {Time = 0, Callback = function(self) self:EnableGrip2() end},
    }
        --does not need NextSequence to loop, it's an exception to the rule
    },

    ["Draw"] = {
        Sequences = {"draw"},
        Length = 0.85,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0.067, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_raise_01")) end},
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
            {Time = 0, Callback = function(self) self:EnableGrip() end},
        }
    },

    ["draw_grip"] = {
        Sequences = {"draw_grip"},
        Length = 0.85,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0.067, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_raise_01")) end},
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
            {Time = 0, Callback = function(self) self:EnableGrip() end},
        }
    },

    ["Holster"] = {
        Sequences = {"holster"},
        Length = 0.6,
        Fps = 30,
        Events = {
            {Time = 0.067, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_drop_01")) end},
        }
    },

    ["Equip"] = {
        Sequences = {"draw_First"},
        Length = 1.25,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0.7, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_raise_first_03")) end},
            {Time = 0.033, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_raise_first_01")) end},
            {Time = 0.8, Callback = function(self) self:EnableGrip2() end},
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0.133, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_raise_first_02")) end},
            {Time = 0.0, Callback = function(self) self:DisableGrip2() end},
        }
    },

    ["draw_first_grip"] = {
        Sequences = {"draw_first_grip"},
        Length = 1.25,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0.7, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_raise_first_03")) end},
            {Time = 0.033, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_raise_first_01")) end},
            {Time = 0.8, Callback = function(self) self:EnableGrip2() end},
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0.133, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_raise_first_02")) end},
            {Time = 0.0, Callback = function(self) self:DisableGrip2() end},
        }
    },

    ["Reload"] = {
        Sequences = {"reload"},
        Length = 2.83,
        MagLength = 2.06,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 2.333, Callback = function(self) self:EnableGrip2() end},
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 2.067, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_05")) end},
            {Time = 2.0, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_04")) end},
            {Time = 0.1, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_01")) end},
            {Time = 1.5, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_03")) end},
            {Time = 0.433, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_02")) end},
            {Time = 0.133, Callback = function(self) self:DisableGrip2() end},
        
        }
    },

    ["Reload_Fast"] = {
        Sequences = {"reload_fast"},
        Length = 2,
        MagLength = 1.4,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 1.4, Callback = function(self) self:DoSpatialSound(Sound("MW_MagazineDrop.AR.Metal"), Vector(-10, 0, 40)) end},
            {Time = 0.033, Callback = function(self) self:DisableGrip() end},
            {Time = 1.333, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_04")) end},
            {Time = 0.633, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_02")) end},
            {Time = 0.0, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_01")) end},
            {Time = 0.833, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_03")) end},
            {Time = 1.567, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_05")) end},
            {Time = 1.6, Callback = function(self) self:EnableGrip() end},
        
        }
    },

    ["Reload_Xmag"] = {
        Sequences = {"Reload_Xmag"},
        Length = 2.83,
        MagLength = 2.06,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0.167, Callback = function(self)  end},
            {Time = 0.167, Callback = function(self) self:DisableGrip2() end},
            {Time = 2.533, Callback = function(self) self:EnableGrip2() end},
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0.033, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_xmags_01")) end},
            {Time = 0.367, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_xmags_02")) end},
            {Time = 1.5, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_xmags_03")) end},
            {Time = 2.367, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_xmags_05")) end},
            {Time = 2.1, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_xmags_04")) end},
        
        }
    },

    ["Reload_Xmag_Fast"] = {
        Sequences = {"Reload_Xmag_Fast"},
        Length = 2,
        MagLength = 1.4,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 1.4, Callback = function(self) self:DoSpatialSound(Sound("MW_MagazineDrop.AR.Metal"), Vector(-10, 0, 40)) end},
            {Time = 1.6, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_xmags_05")) end},
            {Time = 0.033, Callback = function(self) self:DisableGrip() end},
            {Time = 1.733, Callback = function(self) self:EnableGrip() end},
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 1.433, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_xmags_04")) end},
            {Time = 0.5, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_xmags_02")) end},
            {Time = 1.133, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_xmags_03")) end},
            {Time = 0.133, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_fast_xmags_01")) end},
        
        }
    },

    ["Reload_Empty"] = {
        Sequences = {"Reload_Empty"},
        Length = 3.8,
        MagLength = 2.5,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {
                Time = 0.6, 
                Callback = function(self) 
                    self:DoEjection("shell_eject")
                    self:DoParticle("Ejection", "shell_eject")
                end
            },
            {Time = 1.8, Callback = function(self) self:DoSpatialSound(Sound("MW_MagazineDrop.AR.Metal"), Vector(30, 0, 40)) end},
            {Time = 1.0, Callback = function(self) end},
            {Time = 1.0, Callback = function(self) end},
            {Time = 1.0, Callback = function(self) end},
            {Time = 1.0, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_02")) end},
            {Time = 2.633, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_05")) end},
            {Time = 2.467, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_04")) end},
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 3.5, Callback = function(self) self:EnableGrip2() end},
            {Time = 0.067, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_01")) end},
            {Time = 0.1, Callback = function(self) self:DisableGrip2() end},
            {Time = 3.133, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_06")) end},
            {Time = 1.567, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_03")) end},
        }
    },

    ["Reload_Empty_Fast"] = {
        Sequences = {"Reload_Empty_Fast"},
        Length = 2.8,
        MagLength = 1.43,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {
                Time = 2.06, 
                Callback = function(self) 
                    self:DoEjection("shell_eject")
                    self:DoParticle("Ejection", "shell_eject")
                end
            },
            {Time = 1.4, Callback = function(self) self:DoSpatialSound(Sound("MW_MagazineDrop.AR.Metal"), Vector(-10, 0, 40)) end},
            {Time = 0.033, Callback = function(self) self:DisableGrip() end},
            {Time = 1.7, Callback = function(self) end},
            {Time = 1.7, Callback = function(self) self:DisableGrip2() end},
            {Time = 1.6, Callback = function(self) self:EnableGrip() end},
            {Time = 2.7, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_07")) end},
            {Time = 2.2, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_06")) end},
            {Time = 1.7, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_05")) end},
            {Time = 1.3, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_04")) end},
            {Time = 1.033, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_03")) end},
            {Time = 0.633, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_02")) end},
            {Time = 0.0, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_01")) end},
            {Time = 2.6, Callback = function(self) self:EnableGrip2() end},
        }
    },

    ["Reload_Empty_Xmag"] = {
        Sequences = {"Reload_Empty_Xmag"},
        Length = 3.8,
        MagLength = 2.5,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {
                Time = 0.6, 
                Callback = function(self) 
                    self:DoEjection("shell_eject")
                    self:DoParticle("Ejection", "shell_eject")
                end
            },
            {Time = 1.8, Callback = function(self) self:DoSpatialSound(Sound("MW_MagazineDrop.AR.Metal"), Vector(30, 0, 40)) end},
            {Time = 1.7, Callback = function(self) end},
            {Time = 1.7, Callback = function(self) end},
            {Time = 1.7, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_xmags_04")) end},
            {Time = 0.433, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_xmags_02")) end},
            {Time = 1.033, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_xmags_03")) end},
            {Time = 2.567, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_xmags_05")) end},
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 3.767, Callback = function(self) self:EnableGrip2() end},
            {Time = 0.033, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_xmags_01")) end},
            {Time = 0.1, Callback = function(self) self:DisableGrip2() end},
            {Time = 3.9, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_xmags_07")) end},
            {Time = 2.8, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_xmags_06")) end},
        }
    },

    ["Reload_Empty_Xmag_Fast"] = {
        Sequences = {"Reload_Empty_Xmag_Fast"},
        Length = 2.8,
        MagLength = 1.43,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {
                Time = 2.06, 
                Callback = function(self) 
                    self:DoEjection("shell_eject")
                    self:DoParticle("Ejection", "shell_eject")
                end
            },
            {Time = 1.4, Callback = function(self) self:DoSpatialSound(Sound("MW_MagazineDrop.AR.Metal"), Vector(-10, 0, 40)) end},
            {Time = 0.0, Callback = function(self) self:DisableGrip() end},
            {Time = 1.7, Callback = function(self) end},
            {Time = 2.8, Callback = function(self) self:EnableGrip2() end},
            {Time = 1.867, Callback = function(self) self:DisableGrip2() end},
            {Time = 0.633, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_xmags_02")) end},
            {Time = 1.133, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_xmags_03")) end},
            {Time = 0.0, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_xmags_01")) end},
            {Time = 2.067, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_xmags_06")) end},
            {Time = 2.933, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_xmags_07")) end},
            {Time = 1.433, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_xmags_04")) end},
            {Time = 1.867, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_reload_empty_fast_xmags_05")) end},
            {Time = 1.7, Callback = function(self) self:EnableGrip() end},
        }
    },

    ["Rechamber"] = {
        Sequences = {"rechamber"},
        Length = 1,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {
                Time = 0.5, 
                Callback = function(self) 
                    self:DoEjection("shell_eject")
                    self:DoParticle("Ejection", "shell_eject")
                end
            },
            {Time = 1.033, Callback = function(self) self:EnableGrip2() end},
            {Time = 1.1, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_rechamber_02")) end},
            {Time = 0.0, Callback = function(self) self:DisableGrip2() end},
            {Time = 0.0, Callback = function(self) 
                if (self:HasAttachment("attachment_vm_sn_romeo700_perk_bolt")) then
                    self:DoSound(Sound("wfoly_plr_sn_romeo700_rechamber_01_fast")) 
                else
                    self:DoSound(Sound("wfoly_plr_sn_romeo700_rechamber_01")) 
                end
            end},
        }
    },

    ["rechamber_bolthvy"] = {
        Sequences = {"rechamber_bolthvy"},
        Length = 1,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {
                Time = 0.5, 
                Callback = function(self) 
                    self:DoEjection("shell_eject")
                    self:DoParticle("Ejection", "shell_eject")
                end
            },
            {Time = 1.267, Callback = function(self) self:EnableGrip2() end},
            {Time = 0.167, Callback = function(self) 
                if (self:HasAttachment("attachment_vm_sn_romeo700_perk_bolt")) then
                    self:DoSound(Sound("wfoly_plr_sn_romeo700_rechamber_bolthvy_01_fast")) 
                else
                    self:DoSound(Sound("wfoly_plr_sn_romeo700_rechamber_bolthvy_01")) 
                end 
            end},
            {Time = 0.0, Callback = function(self) self:DisableGrip2() end},
            {Time = 1.3, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_rechamber_bolthvy_02")) end},
        }
    },

    ["rechamber_boltl"] = {
        Sequences = {"rechamber_boltl"},
        Length = 1,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {
                Time = 0.5, 
                Callback = function(self) 
                    self:DoEjection("shell_eject")
                    self:DoParticle("Ejection", "shell_eject")
                end
            },
            {Time = 0.9, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_rechamber_boltl_02")) end},
            {Time = 0.067, Callback = function(self) 
                if (self:HasAttachment("attachment_vm_sn_romeo700_perk_bolt")) then
                    self:DoSound(Sound("wfoly_plr_sn_romeo700_rechamber_boltl_01_fast")) 
                else
                    self:DoSound(Sound("wfoly_plr_sn_romeo700_rechamber_boltl_01"))
                end 
            end},
            {Time = 0.867, Callback = function(self) self:EnableGrip2() end},
            {Time = 0.0, Callback = function(self) self:DisableGrip2() end},
        }
    },

    ["Fire"] = {
        Sequences = {"fire"},
        Fps = 60,
        NextSequence = "Idle",
        Events = {
            {
                Time = 0, 
                Callback = function(self) 
                    self:DoParticle("MuzzleFlash", "muzzle")
                end
            },
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
        }
    },

    ["Fire_Last"] = {
        Sequences = {"fire"},
        Fps = 60,
        NextSequence = "Idle",
        Events = {
            {
                Time = 0, 
                Callback = function(self) 
                    self:DoParticle("MuzzleFlash", "muzzle")
                end
            },
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
        }
    },

    ["Ads_In"] = {
        Sequences = {"ads_in"},
        Length = 0.33,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0, Callback = function(self) self:EnableGrip() end}, 
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
            {Time = 0, Callback = function(self) self:DoSound(Sound("mw19.sksierra.ads.up")) end},
        }
    },

    ["Ads_Out"] = {
        Sequences = {"ads_out"},
        Length = 0.33,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0, Callback = function(self) self:EnableGrip() end}, 
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
            {Time = 0, Callback = function(self) self:DoSound(Sound("mw19.sksierra.ads.down")) end},
        }
    },

    ["Sprint_In"] = {
        Sequences = {"sprint_in"},
        Fps = 24,
        Events = {
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
        }
        --NextSequence = "Sprint_Loop",
    },

    ["Sprint_Loop"] = {
        Sequences = {"sprint_loop"},
        Fps = 30,
        NextSequence = "Sprint_Loop", --make our state loop
        --while sprinting, the playback rate of the viewmodel is scaled with velocity (cod-like behaviour)
        Events = {
        {Time = 0, Callback = function(self) self:EnableGrip() end},
        {Time = 0, Callback = function(self) self:EnableGrip2() end},
        }
    },

    ["Sprint_Out"] = {
        Sequences = {"sprint_out"},
        Length = 0.3,
        Fps = 24,
        NextSequence = "Idle",
        Events = {
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
        }
    },

    ["Inspect"] = {
        Sequences = {"inspect"},
        Length = 5,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0.133, Callback = function(self) self:DisableGrip() end},
            {Time = 2.633, Callback = function(self) self:DisableGrip2() end},
            {Time = 2.4, Callback = function(self) self:EnableGrip() end},
            {Time = 3.9, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_07")) end},
            {Time = 2.933, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_06")) end},
            {Time = 2.267, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_05")) end},
            {Time = 1.433, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_03")) end},
            {Time = 0.367, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_02")) end},
            {Time = 0.067, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_01")) end},
            {Time = 4.2, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_08")) end},
            {Time = 4.4, Callback = function(self) self:EnableGrip2() end},
            {Time = 2.133, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_04")) end},
        }
    },

    ["inspect_xmag"] = {
        Sequences = {"inspect_xmag"},
        Length = 5,
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0.133, Callback = function(self) self:DisableGrip() end},
            {Time = 2.633, Callback = function(self) self:DisableGrip2() end},
            {Time = 2.4, Callback = function(self) self:EnableGrip() end},
            {Time = 3.9, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_07")) end},
            {Time = 2.933, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_06")) end},
            {Time = 2.267, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_05")) end},
            {Time = 1.433, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_03")) end},
            {Time = 0.367, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_02")) end},
            {Time = 0.067, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_01")) end},
            {Time = 4.2, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_08")) end},
            {Time = 4.4, Callback = function(self) self:EnableGrip2() end},
            {Time = 2.133, Callback = function(self) self:DoSound(Sound("wfoly_plr_sn_romeo700_inspect_04")) end},
        }
    },

    ["Jog_Out"] = {
        Sequences = {"jog_out"},
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
        }
    },

    ["Jump"] = {
        Sequences = {"jump"},
        Fps = 15,
        NextSequence = "Idle",
        Events = {
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
        }
    },

    ["Land"] = {
        Sequences = {"jump_land"},
        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0, Callback = function(self) self:EnableGrip2() end},
        }
    },

    ["HybridOn"] = {
        Sequences = {"hybrid_toggle_off"},
        Fps = 30,
        Length = 0.9,
        NextSequence = "Idle",
        Events = {
            {Time = 0.15, Callback = function(self) self:DoSound(Sound("Flipsight.Up")) end},	
            {Time = 0, Callback = function(self) self:EnableGrip() end},
            {Time = 0, Callback = function(self) self:DisableGrip2() end},
            {Time = 0.833, Callback = function(self) self:EnableGrip2() end},
        }
    },

    ["HybridOff"] = {
        Sequences = {"hybrid_toggle_on"},
        Fps = 30,
        Length = 0.9,
        NextSequence = "Idle",
        Events = {
            {Time = 0.1, Callback = function(self) self:DoSound(Sound("Flipsight.Down")) end},
            {Time = 0, Callback = function(self) self:DisableGrip() end},
            {Time = 0.767, Callback = function(self) self:EnableGrip() end},
        }
    },

    ["Melee"] = {
        Sequences = {"melee_miss_01", "melee_miss_02", "melee_miss_03"},
        Length = 0.6, --if melee misses

        Size = 15,
        Range = 40,

        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0, Callback = function(self) self:DisableGrip() end},
            {Time = 0, Callback = function(self) self:DoSound(Sound("MW_Melee.Miss_Medium")) end},
            {Time = 0.8, Callback = function(self) self:EnableGrip() end},
        }
    },

    ["Melee_Hit"] = {
        Sequences = {"melee_hit_01", "melee_hit_02", "melee_hit_03"},
        Length = 0.3, --if melee hits

        Damage = 45,

        Fps = 30,
        NextSequence = "Idle",
        Events = {
            {Time = 0, Callback = function(self) self:DisableGrip() end},
            {Time = 0, Callback = function(self) self:DoSound(Sound("MW_Melee.Flesh_Medium")) end},
            {Time = 0.8, Callback = function(self) self:EnableGrip() end},
        }
    },
}