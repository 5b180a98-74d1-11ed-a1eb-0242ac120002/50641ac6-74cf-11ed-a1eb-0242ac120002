AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Armoire Laboratoire"
ENT.Author = "Zekirax"
ENT.Category = "Process"

ENT.Spawnable = true

local labo_cabinet = process.labo_cabinet

labo_cabinet.net_name = "Process.labo_cabinet"

local max_amnesique = 2 
labo_cabinet.weapons = {
    {max = 2, weapon = "amnesique_classe_a_swep"},
    {max = max_amnesique, weapon = "amnesique_classe_b_swep"},
    {max = max_amnesique, weapon = "amnesique_classe_c_swep"},
    {max = max_amnesique, weapon = "amnesique_classe_d_swep"},
    {max = max_amnesique, weapon = "amnesique_classe_e_swep"},
    //{max = max_amnesique, weapon = "amnesique_classe_f_swep"},
    {max = 1, weapon = "cyanide_syringe_swep"},
    {max = 1, weapon = "lavender_spray"},
    {max = 2, weapon = "tranquilizer_syringe_swep"},
    {max = 1, weapon = "rust_syringe"},
    {max = 1, weapon = "opaque_bag_swep"},
    {max = 10, weapon = "tranquilizer_gun_swep"},
}

process.load_script("entities/laboratory_cabinet/sv_laboratory_cabinet.lua", true)
process.load_script("entities/laboratory_cabinet/cl_weapon_button.lua", true)
process.load_script("entities/laboratory_cabinet/cl_laboratory_cabinet.lua", true)