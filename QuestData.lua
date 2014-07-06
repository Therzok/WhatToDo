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
WTD.QuestsKnown = {
	-- Reputation dailies
	["MISSION: Crimson Badlands"] = {
		{ IdD = 7468, IdE = 7464, Name = "HOLDOUT: Stop the Scouts" },
		{ IdD = 7466, IdE = 7462, Name = "ANALYSIS: Malicious Mutagen" },
		{ IdD = 7469, IdE = 7465, Name = "OPERATIONS: Covert Monitoring" },
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
		{ IdD = 7496, IdE = 7496, Name = "Reclaim the Power" },
		{ IdD = 7498, IdE = 7498, Name = "Missing Technologies" },
		{ IdD = 7486, IdE = 7486, Name = "Equipment Under Siege" },
		{ IdD = 7488, IdE = 7488, Name = "Electrical Disturbance" },
	},
	["MISSION: Northern Wastes"] = {
		{ IdD = 7105, IdE = 7104, Name = "OPERATIONS: Maintaining Communications" },
		{ IdD = 7092, IdE = 7086, Name = "ANALYSIS: Crystal Healing" },
		{ IdD = 7102, IdE = 7095, Name = "HOLDOUT: Stolen Supplies" },
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
	["Tradeskills - Daily Data Ration"] = {
		{ IdD = 9610, IdE = 9611, Name = "Torine Tools" },
		{ IdD = 9604, IdE = 9605, Name = "Pellskinner Blues" },
		{ IdD = 9606, IdE = 9607, Name = "Loppstitch Made Easy" },
		{ IdD = 9608, IdE = 9609, Name = "Techno Toys" },
		{ IdD = 9598, IdE = 9599, Name = "Style Eye for the Clone Guy" },
		{ IdD = 9600, IdE = 9601, Name = "Dead Man's Vest" },
	}
}

WTD.QuestDataBlacklist = {
	-- Empty for now.
}

WTD.QuestWhitelist = {
	-- Crimson Badlands.
	[7468] = true, [7464] = true,	-- "HOLDOUT: Stop the Scouts"
	[7466] = true, [7462] = true,	-- "ANALYSIS: Malicious Mutagen"
	[7469] = true, [7465] = true,	-- "OPERATIONS: Covert Monitoring"
	[7457] = true, [7454] = true,	-- "Queen For A Day [GROUP 2+]"
	[7592] = true, [7591] = true,	-- "Unexpected Discovery [GROUP 2+]"
	[7448] = true, [7449] = true,	-- "Scout the Island"
	[7456] = true, [7453] = true,	-- "Slash And Burn"
	[7481] = true, [7484] = true,	-- "Scarhide Extermination"
	[7444] = true, [7445] = true,	-- "Persistent Problems"
	[7510] = true, [7509] = true,	-- "Eater of Dust"
	[7573] = true, [7572] = true,	-- "Boulders to Pebbles"
	[7467] = true, [7463] = true,	-- "Guarding the Front"
	[7446] = true, [7447] = true,	-- "BBQ Blast"
	[7458] = true, [7455] = true,	-- "Burning Waters"
	[7496] = true, [7488] = true,	-- "Reclaim the Power" / "Electrical Disturbance"
	[7498] = true, [7486] = true,	-- "Missing Technologies" / "Equipment Under Siege"

	-- Northern Wastes
	[7102] = true, [7095] = true,	-- "HOLDOUT: Stolen Supplies"
	[7092] = true, [7086] = true,	-- "ANALYSIS: Crystal Healing"
	[7105] = true, [7104] = true,	-- "OPERATIONS: Maintaining Communications"
	[7081] = true, [7082] = true,	-- "Frozen Assets"
	[7090] = true, [7091] = true,	-- "Timely Observations"
	[7094] = true, [7093] = true,	-- "Stocking Up"
	[7083] = true, [7084] = true,	-- "Moodie Mash"
	[7070] = true, [7071] = true,	-- "Icy Enlightenment"
	[7068] = true, [7069] = true,	-- "Frozen Dinners"
	[7107] = true, [7085] = true,	-- "Establising Base Perimeters"
	[7089] = true, [7087] = true,	-- "Grim Scavenging"
	[7103] = true, [7088] = true,	-- "Rescue Party"
	[7442] = true, [7443] = true,	-- "Supply Drop"
	[7079] = true, [7080] = true,	-- "Disarming the Enemy"
	[7113] = true, [7114] = true,	-- "Tame the Wastes"
	[7075] = true, [7076] = true,	-- "They'll thank You Later"
	[7077] = true, [7078] = true,	-- "Eldan Eradication"
	[7072] = true, [7074] = true,	-- "A New God"

	-- Tradeskills
	[9610] = true, [9611] = true,	-- "Torine Tools"
	[9604] = true, [9605] = true,	-- "Pellskinner Blues"
	[9606] = true, [9607] = true,	-- "Loppstitch Made Easy"
	[9608] = true, [9609] = true,	-- "Techno Toys"
	[9598] = true, [9599] = true,	-- "Style Eye for the Clone Guy"
	[9600] = true, [9601] = true,	-- "Dead Man's Vest"
}

WTD.QuestFactionExtensions = {
	-- Crimson Badlands
	[7496] = Dominion, [7488] = Exiles,	-- "Reclaim the Power" / "Electrical Disturbance"
	[7498] = Dominion, [7486] = Exiles,	-- "Missing Technologies" / "Equipment Under Siege"

	-- Tradeskills
	[9610] = Dominion, [9611] = Exiles,	-- "Torine Tools"
	[9604] = Dominion, [9605] = Exiles,	-- "Pellskinner Blues"
	[9606] = Dominion, [9607] = Exiles, -- "Loppstitch Made Easy"
	[9608] = Dominion, [9609] = Exiles,	-- "Techno Toys"
	[9598] = Dominion, [9599] = Exiles, -- "Style Eye for the Clone Guy"
	[9600] = Dominion, [9601] = Exiles, -- "Dead Man's Vest"
}

WTD.QuestPathExtensions = {
	-- Crimson Badlands
	[7468] = Soldier,	[7464] = Soldier,	-- "HOLDOUT: Stop the Scouts"
	[7466] = Scientist, [7462] = Scientist,	-- "ANALYSIS: Malicious Mutagen"
	[7469] = Explorer,	[7465] = Explorer,	-- "OPERATIONS: Covert Monitoring"

	-- Northern Wastes
	[7102] = Soldier, 	[7095] = Soldier,	-- "HOLDOUT: Stolen Supplies"
	[7105] = Explorer, 	[7104] = Explorer,	-- "OPERATIONS: Maintaining Communications"
	[7092] = Scientist,	[7086] = Scientist,	-- "ANALYSIS: Crystal Healing"
}

WTD.QuestZoneExtensions = {
	-- Tradeskills
	[9610] = "(Illium) ", [9611] = "(Thayd) ",	-- "Torine Tools"
	[9604] = "(Illium) ", [9605] = "(Thayd) ",	-- "Pellskinner Blues"
	[9606] = "(Illium) ", [9607] = "(Thayd) ", 	-- "Loppstitch Made Easy"
	[9608] = "(Illium) ", [9609] = "(Thayd) ",	-- "Techno Toys"
	[9598] = "(Illium) ", [9599] = "(Thayd) ",	-- "Style Eye for the Clone Guy"
	[9600] = "(Illium) ", [9601] = "(Thayd) ",	-- "Dead Man's Vest"
}

WTD.QuestTradeskillExtensions = {
	-- Tradeskills
	[9610] = Weaponsmith,	[9611] = Weaponsmith,	-- "Torine Tools"
	[9604] = Outfitter, 	[9605] = Outfitter,		-- "Pellskinner Blues"
	[9606] = Tailor, 		[9607] = Tailor, 		-- "Loppstitch Made Easy"
	[9608] = Technologist, 	[9609] = Technologist,	-- "Techno Toys"
	[9598] = Architect, 	[9599] = Architect,		-- "Style Eye for the Clone Guy"
	[9600] = Armorer, 		[9601] = Armorer,		-- "Dead Man's Vest"
}
