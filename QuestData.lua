--[[
	TODO: MinLevel
	TODO: Gather remaining quest ID.
	TODO: Locale
]]

require "CraftingLib"
require "GameLib"
require "PlayerPathLib"

-- Professions
local Architect = CraftingLib.CodeEnumTradeskill.Architect
local Armorer = CraftingLib.CodeEnumTradeskill.Armorer
local Outfitter = CraftingLib.CodeEnumTradeskill.Outfitter
local Tailor = CraftingLib.CodeEnumTradeskill.Tailor
local Technologist = CraftingLib.CodeEnumTradeskill.Augmentor
local Weaponsmith = CraftingLib.CodeEnumTradeskill.Weaponsmith

-- Paths
local Explorer = PlayerPathLib.PlayerPathType_Explorer
local Scientist = PlayerPathLib.PlayerPathType_Scientist
local Settler = PlayerPathLib.PlayerPathType_Settler
local Soldier = PlayerPathLib.PlayerPathType_Soldier

-- Factions
local Dominion = Unit.CodeEnumFaction.DominionPlayer
local Exiles = Unit.CodeEnumFaction.ExilesPlayer

local WTD = Apollo.GetPackage("Gemini:Addon-1.1").tPackage:GetAddon("WhatToDo")
WTD.QuestData = {
	-- Reputation dailies
	["Crimson Badlands"] = {
		{ IdD = 7468, IdE = 7464, Name = "HOLDOUT: Stop the Scouts", Path = Soldier },
		{ IdD = 7466, IdE = 7462, Name = "ANALYSIS: Malicious Mutagen", Path = Scientist },
		{ IdD = 7469, IdE = 7465, Name = "OPERATIONS: Covert Monitoring", Path = Explorer },
		{ IdD = 7457, IdE = 7454, Name = "Queen For A Day [GROUP 2+]" },
		{ IdD = 7592, IdE = 7591, Name = "Unexpected Discovery [GROUP 2+]" },
		{ IdD = 7448, IdE = 7449, Name = "Scout the Island" },
		{ IdD = 7456, IdE = 7453, Name = "Slash And Burn" },
		{ IdD = 7481, IdE = 7484, Name = "Scarhide Extermination" },
		{ IdD = 7444, IdE = 7445, Name = "Persistent Problems" },
		{ IdD = 7510, IdE = 7509, Name = "Eater of Dust" },
		{ IdD = 7573, IdE = 7572, Name = "Boulders to Pebbles" },
		{ IdD = 7467, IdE = 7463, Name = "Guarding the Front" },
		{ IdD = 7446, IdE = 7447, Name = "BBQ Blast" },
		{ IdD = 7458, IdE = 7455, Name = "Burning Waters" },
		
		-- Different Quests
		{ IdD = 7496, IdE = -1, Name = "Reclaim the Power", Faction = Dominion },
		{ IdD = 7498, IdE = -1, Name = "Missing Technologies", Faction = Dominion },
		{ IdD = -1, IdE = 7486, Name = "Equipment Under Siege", Faction = Exiles },
		{ IdD = -1, IdE = 7488, Name = "Electrical Disturbance", Faction = Exiles },
	},
	["Northern Wastes"] = {
		{ IdD = 7105, IdE = 7104, Name = "OPERATIONS: Maintaining Communications", Path = Explorer },
		{ IdD = 7092, IdE = 7086, Name = "ANALYSIS: Crystal Healing", Path = Scientist },
		{ IdD = 7102, IdE = 7095, Name = "HOLDOUT: Stolen Supplies", Path = Soldier },
		{ IdD = 7081, IdE = 7082, Name = "Frozen Assets" },
		{ IdD = 7090, IdE = 7091, Name = "Timely Observations" },
		{ IdD = 7094, IdE = 7093, Name = "Stocking Up" },
		{ IdD = 7083, IdE = 7084, Name = "Moodie Mash" },
		{ IdD = 7070, IdE = 7071, Name = "Icy Enlightenment" },
		{ IdD = 7068, IdE = 7069, Name = "Frozen Dinners" },
		{ IdD = 7107, IdE = 7085, Name = "Establising Base Perimeters" },
		{ IdD = 7089, IdE = 7087, Name = "Grim Scavenging" },
		{ IdD = 7103, IdE = 7088, Name = "Rescue Party" },
		{ IdD = 7442, IdE = 7443, Name = "Supply Drop" },
		{ IdD = 7079, IdE = 7080, Name = "Disarming the Enemy" },
		{ IdD = 7113, IdE = 7114, Name = "Tame the Wastes" },
		{ IdD = 7075, IdE = 7076, Name = "They'll thank You Later" },
		{ IdD = 7077, IdE = 7078, Name = "Eldan Eradication" },
		{ IdD = 7072, IdE = 7074, Name = "A New God" },
	},
	["Ilium"] = {
		{ IdD = 9610, IdE = -1, Name = "Torine Tools", Tradeskill = Weaponsmith, Faction = Dominion },
		{ IdD = 9604, IdE = -1, Name = "Pellskinner Blues", Tradeskill = Outfitter, Faction = Dominion },
		{ IdD = 9606, IdE = -1, Name = "Loppstitch Made Easy", Tradeskill = Tailor, Faction = Dominion },
		{ IdD = 9608, IdE = -1, Name = "Techno Toys", Tradeskill = Technologist, Faction = Dominion },
		{ IdD = 9598, IdE = -1, Name = "Style Eye for the Clone Guy", Tradeskill = Architect, Faction = Dominion },
		{ IdD = 9600, IdE = -1, Name = "Dead Man's Vest", Tradeskill = Armorer, Faction = Dominion },
	},
	["Thayd"] = {
		{ IdD = -1, IdE = 9611, Name = "Torine Tools", Tradeskill = Weaponsmith, Faction = Exiles },
		{ IdD = -1, IdE = 9605, Name = "Pellskinner Blues", Tradeskill = Outfitter, Faction = Exiles },
		{ IdD = -1, IdE = 9607, Name = "Loppstitch Made Easy", Tradeskill = Tailor, Faction = Exiles },
		{ IdD = -1, IdE = 9609, Name = "Techno Toys", Tradeskill = Technologist, Faction = Exiles },
		{ IdD = -1, IdE = 9599, Name = "Style Eye for the Clone Guy", Tradeskill = Architect, Faction = Exiles },
		{ IdD = -1, IdE = 9601, Name = "Dead Man's Vest", Tradeskill = Armorer, Faction = Exiles },
	}
}

WTD.QuestDataVersion = 1
