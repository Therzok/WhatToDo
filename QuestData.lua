--[[
	TODO: MinLevel
	TODO: Gather remaining quest IDs (Galeras).
	TODO: Locale for Reputation and quest names.
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

-- Zones
local ZoneName = {}
local Zone = GameLib.MapZone
Zone.Farside = 28 -- Dunno why this doesn't exist. -.o

for k, v in pairs(GameLib.GetAllZoneCompletionMapZones()) do
	ZoneName[v.nMapZoneId] = "(" .. v.strName .. ") "
end

local WTD = Apollo.GetPackage("Gemini:Addon-1.1").tPackage:GetAddon("WhatToDo")

-- Key = ID, Value = { IdD = DominionId, IdE = ExilesId, Name = Quest name }
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
		{ IdD = 7442, IdE = 7443, Name = "Supply Drop" },

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
	},
	["Tradeskills - Crafting Vouchers"] = {
		-- Tradeskills - Crafting Vouchers - Outfitter
		{ IdD = 5983, IdE = 5983, Name = "How's the Leather?" },
		{ IdD = 5986, IdE = 5986, Name = "Class V Logistics: Medium Armor" },
		{ IdD = 5990, IdE = 5990, Name = "Medium Armor Contract: Algoroc" },
		{ IdD = 7271, IdE = 7271, Name = "The Look and Feel of Hand-Tooled Leather" },
		{ IdD = 7272, IdE = 7272, Name = "Fine Celestion Leather" },
		{ IdD = 7273, IdE = 7273, Name = "Leatherweight Champ" },
		{ IdD = 7274, IdE = 7274, Name = "Fine Leathered Friend" },
		{ IdD = 7275, IdE = 7275, Name = "Leatherweight Champions" },
		{ IdD = 7276, IdE = 7276, Name = "Fine Cassian Leather" },
		{ IdD = 7277, IdE = 7277, Name = "About the Leather" },
		{ IdD = 7278, IdE = 7278, Name = "Leather of Intent" },
		{ IdD = 7279, IdE = 7279, Name = "To the Leather" },
		{ IdD = 8286, IdE = 8286, Name = "Lovely Leather, Isn't It?" },
		{ IdD = 8287, IdE = 8287, Name = "Forester's Delight" },
		{ IdD = 8288, IdE = 8288, Name = "Take Them to the Foresters" },
		{ IdD = 8226, IdE = 8226, Name = "You Can Do Leather, If You Try" },
		{ IdD = 8227, IdE = 8227, Name = "Gotta Get That Leather, Man" },
		{ IdD = 8228, IdE = 8228, Name = "Never Say Leather" },
		{ IdD = 9236, IdE = 9236, Name = "Isigrol-Bent for Leather" },
		{ IdD = 9237, IdE = 9237, Name = "Augmented Leather Hunters" },
		{ IdD = 9238, IdE = 9238, Name = "Ultimate Augmented Leather" },
		{ IdD = 9219, IdE = 9219, Name = "Isigrol-Bent for Leather" },
		{ IdD = 9220, IdE = 9220, Name = "Tempered Leather Hunters" },
		{ IdD = 9221, IdE = 9221, Name = "Ultimate Augmented Leather Hunters" },
		{ IdD = 7283, IdE = 7283, Name = "Leather Report" },
		{ IdD = 7284, IdE = 7284, Name = "Full Leather Jacket" },
		{ IdD = 7285, IdE = 7285, Name = "Leather or Not...." },
		{ IdD = 8422, IdE = 8422, Name = "Big Game Hunter's Armor" },
		{ IdD = 8423, IdE = 8423, Name = "Leather Hunters" },
		{ IdD = 8424, IdE = 8424, Name = "Hard as Rockhide" },
		{ IdD = 8432, IdE = 8432, Name = "Eye Spy a Camera" },
		{ IdD = 8341, IdE = 8341, Name = "Big Game Hunter's Armor" },
		{ IdD = 8342, IdE = 8342, Name = "Leather Hunters" },
		{ IdD = 8343, IdE = 8343, Name = "Hard as Rockhide" },
		{ IdD = 7280, IdE = 7280, Name = "Getting Back to Leather" },
		{ IdD = 7281, IdE = 7281, Name = "Stormy Leather" },
		{ IdD = 7282, IdE = 7282, Name = "A Man of Leathers" },
		{ IdD = 7289, IdE = 7289, Name = "Getting Back to Leather" },
		{ IdD = 7290, IdE = 7290, Name = "Stormy Leather" },
		{ IdD = 7291, IdE = 7291, Name = "A Man of Leathers" },
		{ IdD = 7286, IdE = 7286, Name = "Leather Bound" },
		{ IdD = 7287, IdE = 7287, Name = "The Leather Regions" },
		{ IdD = 7288, IdE = 7288, Name = "Hell-Bent for Leather" },
		{ IdD = 8322, IdE = 8322, Name = "You Can Do Leather, If You Try" },
		{ IdD = 8323, IdE = 8323, Name = "Gotta Get That Leather, Man" },
		{ IdD = 8324, IdE = 8324, Name = "Never Say Leather" },
		{ IdD = 8304, IdE = 8304, Name = "Lovely Leather, Isn't It?" },
		{ IdD = 8305, IdE = 8305, Name = "Forester's Delight" },
		{ IdD = 8306, IdE = 8306, Name = "Take Them to the Foresters" },

		-- Tradeskills - Crafting Vouchers - Armorer
		{ IdD = 5774, IdE = 5774, Name = "Steel Your Heart" },
		{ IdD = 5779, IdE = 5779, Name = "Class V Logistics: Steel Weave Armor" },
		{ IdD = 5782, IdE = 5782, Name = "Steel Armor Contract: Algoroc" },
		{ IdD = 7259, IdE = 7259, Name = "Steel Yourself Exile" },
		{ IdD = 7260, IdE = 7260, Name = "Beg, Borrow, and Steel" },
		{ IdD = 7261, IdE = 7261, Name = "Steel Crazy After All These Years" },
		{ IdD = 7262, IdE = 7262, Name = "Steel of Approval" },
		{ IdD = 7263, IdE = 7263, Name = "Gladiatorial Intentions" },
		{ IdD = 7264, IdE = 7264, Name = "The Art of the Steel" },
		{ IdD = 7265, IdE = 7265, Name = "Timing and Steeling" },
		{ IdD = 7266, IdE = 7266, Name = "Steel's the One" },
		{ IdD = 7267, IdE = 7267, Name = "Cold, Hard Steel" },
		{ IdD = 8283, IdE = 8283, Name = "Plat On Your Back" },
		{ IdD = 8284, IdE = 8284, Name = "Heart of Platinum" },
		{ IdD = 8285, IdE = 8285, Name = "Good as Platinum" },
		{ IdD = 8223, IdE = 8223, Name = "Striking Platinum" },
		{ IdD = 8224, IdE = 8224, Name = "It Won't Ever Rust" },
		{ IdD = 8225, IdE = 8225, Name = "Platinum P.I." },
		{ IdD = 9233, IdE = 9233, Name = "Getting Started with Galacium" },
		{ IdD = 9234, IdE = 9234, Name = "The Armorer's Guide to Galactium" },
		{ IdD = 9235, IdE = 9235, Name = "Galactium-Grade Stopping Power" },
		{ IdD = 9216, IdE = 9216, Name = "Guardians of Galacium" },
		{ IdD = 9217, IdE = 9217, Name = "The Armorer's Guide to Galactium" },
		{ IdD = 9218, IdE = 9218, Name = "Galactium-Grade Stopping Power" },
		{ IdD = 7268, IdE = 7268, Name = "Titanium? I Just Met 'Em!" },
		{ IdD = 7269, IdE = 7269, Name = "Raise the Titanium" },
		{ IdD = 7270, IdE = 7270, Name = "In Titanium We Trust" },
		{ IdD = 8419, IdE = 8419, Name = "Legionnaire in Glowing Armor" },
		{ IdD = 8420, IdE = 8420, Name = "Powered by Xenocite" },
		{ IdD = 8421, IdE = 8421, Name = "Heavy Xenocite Plate" },
		{ IdD = 8338, IdE = 8338, Name = "Knight In Glowing Armor" },
		{ IdD = 8339, IdE = 8339, Name = "Powered by Xenocite" },
		{ IdD = 8340, IdE = 8340, Name = "Heavy Xenocite Plate" },
		{ IdD = 6381, IdE = 6381, Name = "Titanium for All" },
		{ IdD = 6382, IdE = 6382, Name = "A Titanic Effort" },
		{ IdD = 6383, IdE = 6383, Name = "Titanium Protoweaving" },
		{ IdD = 7236, IdE = 7236, Name = "Proud Titanium" },
		{ IdD = 7237, IdE = 7237, Name = "A Titanic Sheet" },
		{ IdD = 7238, IdE = 7238, Name = "Titanium of War" },
		{ IdD = 6216, IdE = 6216, Name = "Titanium on My Mind" },
		{ IdD = 6217, IdE = 6217, Name = "The Titanium Special" },
		{ IdD = 6218, IdE = 6218, Name = "Providing Armor Afield" },
		{ IdD = 8319, IdE = 8319, Name = "Striking Platinum" },
		{ IdD = 8320, IdE = 8320, Name = "It Won't Ever Rust" },
		{ IdD = 8321, IdE = 8321, Name = "Platinum P.I." },
		{ IdD = 8301, IdE = 8301, Name = "Plat On Your Back" },
		{ IdD = 8302, IdE = 8302, Name = "Heart of Platinum" },
		{ IdD = 8303, IdE = 8303, Name = "Good as Platinum" },

		-- Tradeskills - Crafting Vouchers - Weaponsmith
		{ IdD = 5171, IdE = 5171, Name = "Keeping It Steel" },
		{ IdD = 5178, IdE = 5178, Name = "Class V Logistics: Weapons" },
		{ IdD = 5209, IdE = 5209, Name = "Steel Weapons Contract: Algoroc" },
		{ IdD = 7241, IdE = 7241, Name = "Arms for Arboria" },
		{ IdD = 7242, IdE = 7242, Name = "Arms for The XAS" },
		{ IdD = 7243, IdE = 7243, Name = "Arms for the Exiles" },
		{ IdD = 7244, IdE = 7244, Name = "Helping the Hunters" },
		{ IdD = 7245, IdE = 7245, Name = "Monkey Mayhem" },
		{ IdD = 7246, IdE = 7246, Name = "Keys to the Empire" },
		{ IdD = 7247, IdE = 7247, Name = "Wild Arms" },
		{ IdD = 7248, IdE = 7248, Name = "A Legion's Need" },
		{ IdD = 7249, IdE = 7249, Name = "Looking Past the Wilds" },
		{ IdD = 8280, IdE = 8280, Name = "Silver Linings" },
		{ IdD = 8281, IdE = 8281, Name = "Platinum If You Got 'Em" },
		{ IdD = 8282, IdE = 8282, Name = "Comfortably Platinum" },
		{ IdD = 8205, IdE = 8205, Name = "You Platinum, You Bought 'Em" },
		{ IdD = 8206, IdE = 8206, Name = "Platinum Crisis" },
		{ IdD = 8207, IdE = 8207, Name = "A Heart of Platinum" },
		{ IdD = 9225, IdE = 9225, Name = "Battle-Strain Galactium" },
		{ IdD = 9226, IdE = 9226, Name = "The Weaponsmith's Guide to Galactium" },
		{ IdD = 9228, IdE = 9228, Name = "Galactium-Grade Firepower" },
		{ IdD = 9213, IdE = 9213, Name = "Battle-Strain Galactium" },
		{ IdD = 9214, IdE = 9214, Name = "The Weaponsmith's Guide to Galactium" },
		{ IdD = 9215, IdE = 9215, Name = "Galactium-Grade Firepower" },
		{ IdD = 7250, IdE = 7250, Name = "Do As I Ask" },
		{ IdD = 7251, IdE = 7251, Name = "There Is No Try" },
		{ IdD = 7252, IdE = 7252, Name = "The Tools of the Empire" },
		{ IdD = 8416, IdE = 8416, Name = "At First Xenocite" },
		{ IdD = 8417, IdE = 8417, Name = "Xenocite Package" },
		{ IdD = 8418, IdE = 8418, Name = "Xenocite Fight" },
		{ IdD = 8334, IdE = 8334, Name = "At First Xenocite" },
		{ IdD = 8335, IdE = 8335, Name = "Xenocite Package" },
		{ IdD = 8337, IdE = 8337, Name = "Xenocite Fight" },
		{ IdD = 5240, IdE = 5240, Name = "A Vendor in Need" },
		{ IdD = 5241, IdE = 5241, Name = "Coordinating for Shortfalls" },
		{ IdD = 5242, IdE = 5242, Name = "High Expectations" },
		{ IdD = 7256, IdE = 7256, Name = "Mighty Metal" },
		{ IdD = 7257, IdE = 7257, Name = "Blood and Titanium" },
		{ IdD = 7258, IdE = 7258, Name = "Staying on Target" },
		{ IdD = 7253, IdE = 7253, Name = "Titanium Shaper" },
		{ IdD = 7254, IdE = 7254, Name = "Titanium Weapons" },
		{ IdD = 7255, IdE = 7255, Name = "Forging Forward" },
		{ IdD = 8316, IdE = 8316, Name = "You Platinum, You Bought 'Em" },
		{ IdD = 8317, IdE = 8317, Name = "Platinum Crisis" },
		{ IdD = 8318, IdE = 8318, Name = "A Heart of Platinum" },
		{ IdD = 8298, IdE = 8298, Name = "Silver Linings" },
		{ IdD = 8299, IdE = 8299, Name = "Platinum If You Got 'Em" },
		{ IdD = 8300, IdE = 8300, Name = "Comfortably Platinum" },

		-- Tradeskills - Crafting Vouchers - Technologist
		{ IdD = 6097, IdE = 6097, Name = "Medishot Madness" },
		{ IdD = 6098, IdE = 6098, Name = "Class VIII Logistics: Medical Supplies" },
		{ IdD = 6099, IdE = 6099, Name = "Medical Supply Contract: Algoroc" },
		{ IdD = 7310, IdE = 7310, Name = "Fruit of the Spirovine" },
		{ IdD = 7311, IdE = 7311, Name = "Frontier Medicine" },
		{ IdD = 7312, IdE = 7312, Name = "Club Meds" },
		{ IdD = 7313, IdE = 7313, Name = "The Legend of Spirovine" },
		{ IdD = 7314, IdE = 7314, Name = "Medical Herbology" },
		{ IdD = 7315, IdE = 7315, Name = "Get Medicated" },
		{ IdD = 7316, IdE = 7316, Name = "Through the Spirovine" },
		{ IdD = 7317, IdE = 7317, Name = "Making Medicine" },
		{ IdD = 7318, IdE = 7318, Name = "Herbal Shots" },
		{ IdD = 8292, IdE = 8292, Name = "Scaling Up" },
		{ IdD = 8293, IdE = 8293, Name = "Coralscale Values" },
		{ IdD = 8294, IdE = 8294, Name = "Coral History" },
		{ IdD = 8274, IdE = 8274, Name = "Shot Caller" },
		{ IdD = 8275, IdE = 8275, Name = "Sending Priority Coralscale" },
		{ IdD = 8276, IdE = 8276, Name = "Give It Your Best Medishot" },
		{ IdD = 9242, IdE = 9242, Name = "A Quick Shot of Mourningstar" },
		{ IdD = 9243, IdE = 9243, Name = "Mourningstar Medispray" },
		{ IdD = 9244, IdE = 9244, Name = "A Mourningstar Restorative" },
		{ IdD = 9249, IdE = 9249, Name = "A Quick Shot of Mourningstar" },
		{ IdD = 9250, IdE = 9250, Name = "Mourning Medispray" },
		{ IdD = 9251, IdE = 9251, Name = "A Mourningstar Restorative" },
		{ IdD = 7319, IdE = 7319, Name = "Laced with Serpentlily" },
		{ IdD = 7320, IdE = 7320, Name = "A Shot of Something Good" },
		{ IdD = 7321, IdE = 7321, Name = "Dedicated and Medicated" },
		{ IdD = 8428, IdE = 8428, Name = "Fruit of the Faerybloom" },
		{ IdD = 8429, IdE = 8429, Name = "Mixing It Up" },
		{ IdD = 8430, IdE = 8430, Name = "The Purest of Omni-Plasm" },
		{ IdD = 8347, IdE = 8347, Name = "Fruit of the Faerybloom" },
		{ IdD = 8348, IdE = 8348, Name = "Mixing It Up" },
		{ IdD = 8349, IdE = 8349, Name = "The Purest of Omni-Plasm" },
		{ IdD = 6114, IdE = 6114, Name = "How Stimulating" },
		{ IdD = 6115, IdE = 6115, Name = "Two Medishots a Day" },
		{ IdD = 6116, IdE = 6116, Name = "Shotdoctor" },
		{ IdD = 7325, IdE = 7325, Name = "Serpentlilies of the Field" },
		{ IdD = 7326, IdE = 7326, Name = "Talking Shot" },
		{ IdD = 7327, IdE = 7327, Name = "Long-Distance Medication" },
		{ IdD = 7322, IdE = 7322, Name = "Secrets of the Serpentlily" },
		{ IdD = 7323, IdE = 7323, Name = "Somebody Get Me a Shot" },
		{ IdD = 7324, IdE = 7324, Name = "Better Keep 'Em Medicated" },
		{ IdD = 8328, IdE = 8328, Name = "Shot Caller" },
		{ IdD = 8329, IdE = 8329, Name = "Sending Priority Coralscale" },
		{ IdD = 8330, IdE = 8330, Name = "Give It your Best Medishot" },
		{ IdD = 8310, IdE = 8310, Name = "Scaling Up" },
		{ IdD = 8311, IdE = 8311, Name = "Coralscale Values" },
		{ IdD = 8312, IdE = 8312, Name = "Coral History" },

		-- Tradeskills - Crafting Vouchers - Tailor
		{ IdD = 5996, IdE = 5996, Name = "Rugged and Ready" },
		{ IdD = 5999, IdE = 5999, Name = "Class V Logistics: Light Armor" },
		{ IdD = 6002, IdE = 6002, Name = "Canvas Armor Contract: Algoroc" },
		{ IdD = 7292, IdE = 7292, Name = "Canvas for Support" },
		{ IdD = 7293, IdE = 7293, Name = "Catch as Catch Canvas" },
		{ IdD = 7294, IdE = 7294, Name = "The Grand Canvas" },
		{ IdD = 7295, IdE = 7295, Name = "Canvas Ain't Easy" },
		{ IdD = 7296, IdE = 7296, Name = "Catch Me If You Canvas" },
		{ IdD = 7297, IdE = 7297, Name = "Yes, We Canvas" },
		{ IdD = 7298, IdE = 7298, Name = "Can You Canvas?" },
		{ IdD = 7299, IdE = 7299, Name = "Blank Canvas" },
		{ IdD = 7300, IdE = 7300, Name = "The Canvas Man Can" },
		{ IdD = 8289, IdE = 8289, Name = "Retaining Whimfiber" },
		{ IdD = 8290, IdE = 8290, Name = "An Allowance of Fiber" },
		{ IdD = 8291, IdE = 8291, Name = "One Hundred Percent Whimfiber" },
		{ IdD = 8229, IdE = 8229, Name = "Threading On a Whim" },
		{ IdD = 8230, IdE = 8230, Name = "Filled to the Whim" },
		{ IdD = 8231, IdE = 8231, Name = "Four Sheets to the Whim" },
		{ IdD = 9239, IdE = 9239, Name = "Starting with Starloom" },
		{ IdD = 9240, IdE = 9240, Name = "Tailored on a Starloom" },
		{ IdD = 9241, IdE = 9241, Name = "Reach for the Starloom" },
		{ IdD = 9222, IdE = 9222, Name = "Wish Upon a Starloom" },
		{ IdD = 9223, IdE = 9223, Name = "Wishin' on a Starloom" },
		{ IdD = 9224, IdE = 9224, Name = "Reach for the Starloom" },
		{ IdD = 7301, IdE = 7301, Name = "Follow the Silk Road" },
		{ IdD = 7302, IdE = 7302, Name = "You're Really Silking It" },
		{ IdD = 7303, IdE = 7303, Name = "Silk Really Suits You" },
		{ IdD = 8425, IdE = 8425, Name = "Terminal Manaweave" },
		{ IdD = 8426, IdE = 8426, Name = "Weaving In and Out of Focus" },
		{ IdD = 8427, IdE = 8427, Name = "Moxie Magnification" },
		{ IdD = 8344, IdE = 8344, Name = "Terminal Manaweave" },
		{ IdD = 8345, IdE = 8345, Name = "Weaving In and Out of Focus" },
		{ IdD = 8346, IdE = 8346, Name = "Moxie Magnification" },
		{ IdD = 6022, IdE = 6022, Name = "Custom Tailored" },
		{ IdD = 6023, IdE = 6023, Name = "Tailor to Communicate" },
		{ IdD = 6024, IdE = 6024, Name = "Hot Cup of Tailor" },
		{ IdD = 7307, IdE = 7307, Name = "The Road to Silk" },
		{ IdD = 7308, IdE = 7308, Name = "Silking It for All It's Worth" },
		{ IdD = 7309, IdE = 7309, Name = "Silk-Suited" },
		{ IdD = 7304, IdE = 7304, Name = "Shear Silk" },
		{ IdD = 7305, IdE = 7305, Name = "Silk Stalking" },
		{ IdD = 7306, IdE = 7306, Name = "Of the Finest Silk" },
		{ IdD = 8325, IdE = 8325, Name = "Threading on a Whim" },
		{ IdD = 8326, IdE = 8326, Name = "Filled to the Whim" },
		{ IdD = 8327, IdE = 8327, Name = "Four Sheets to the Whim" },
		{ IdD = 8307, IdE = 8307, Name = "Retaining Whimfiber" },
		{ IdD = 8308, IdE = 8308, Name = "An Allowance of Fiber" },
		{ IdD = 8308, IdE = 8308, Name = "100% Whimfiber" },

		-- Tradeskills - Crafting Vouchers - Architect
		{ IdD = 6107, IdE = 6107, Name = "Architectural Aptitude" },
		{ IdD = 6108, IdE = 6108, Name = "Bramble Basics" },
		{ IdD = 6109, IdE = 6109, Name = "Housing Supply Contract: Algoroc" },
		{ IdD = 7642, IdE = 7642, Name = "Feeding Time" },
		{ IdD = 7643, IdE = 7643, Name = "Bramble Blast" },
		{ IdD = 7644, IdE = 7644, Name = "Picket Fences" },
		{ IdD = 7645, IdE = 7645, Name = "Metal Heads" },
		{ IdD = 7646, IdE = 7646, Name = "Bramble Blast" },
		{ IdD = 7647, IdE = 7647, Name = "Practical Architecture" },
		{ IdD = 7648, IdE = 7648, Name = "An Assessment of Ability" },
		{ IdD = 7649, IdE = 7649, Name = "Bramble Ramble" },
		{ IdD = 7650, IdE = 7650, Name = "Fenced In" },
		{ IdD = 8295, IdE = 8295, Name = "Pillow Talk" },
		{ IdD = 8296, IdE = 8296, Name = "Generator Interest" },
		{ IdD = 8297, IdE = 8297, Name = "Pumped Up!" },
		{ IdD = 8277, IdE = 8277, Name = "Purple-Star-Pillow-Piler" },
		{ IdD = 8278, IdE = 8278, Name = "Generator Interest" },
		{ IdD = 8279, IdE = 8279, Name = "Get Pumped!" },
		{ IdD = 9245, IdE = 9245, Name = "Tiki Torches" },
		{ IdD = 9246, IdE = 9246, Name = "Nautical Wheel" },
		{ IdD = 9247, IdE = 9247, Name = "Freebot Surge Protector" },
		{ IdD = 9252, IdE = 9252, Name = "Tiki Torches" },
		{ IdD = 9253, IdE = 9253, Name = "Nautical Wheel" },
		{ IdD = 9254, IdE = 9254, Name = "Freebot Surge Protector" },
		{ IdD = 8540, IdE = 8540, Name = "In Glad Company" },
		{ IdD = 8541, IdE = 8541, Name = "The Architect's Burden" },
		{ IdD = 8542, IdE = 8542, Name = "Torch Lights" },
		{ IdD = 8432, IdE = 8432, Name = "Eye Spy a Camera" },
		{ IdD = 8433, IdE = 8433, Name = "Table This for Now" },
		{ IdD = 8431, IdE = 8431, Name = "Shiny Storage" },
		{ IdD = 8350, IdE = 8350, Name = "Shiny Storage" },
		{ IdD = 8351, IdE = 8351, Name = "Eye Spy a Camera" },
		{ IdD = 8352, IdE = 8352, Name = "Table This for Now" },
		{ IdD = 6123, IdE = 6123, Name = "Local Architecture" },
		{ IdD = 6124, IdE = 6124, Name = "Crate Expectations" },
		{ IdD = 6125, IdE = 6125, Name = "Firestarter" },
		{ IdD = 9431, IdE = 9431, Name = "Whitevale Traction" },
		{ IdD = 9432, IdE = 9432, Name = "It's a Trap" },
		{ IdD = 9433, IdE = 9433, Name = "I Love Lamp" },
		{ IdD = 9391, IdE = 9391, Name = "Whitevale Traction" },
		{ IdD = 9392, IdE = 9392, Name = "It's a Trap" },
		{ IdD = 9429, IdE = 9429, Name = "I Love Lamp" },
		{ IdD = 8331, IdE = 8331, Name = "Locker Stocker" },
		{ IdD = 8332, IdE = 8332, Name = "A Place to Lay One's Cards" },
		{ IdD = 8333, IdE = 8333, Name = "The Great Divider" },
		{ IdD = 8313, IdE = 8313, Name = "Ready, Set, Locker" },
		{ IdD = 8314, IdE = 8314, Name = "Fancy Dresser" },
		{ IdD = 8315, IdE = 8315, Name = "The Great Divider" },
	}
}

-- Key = ID, Value = true.
WTD.QuestDataBlacklist = {
	-- Empty for now.
}

-- Quests which are known.
-- Key = ID, Value = true.
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
	[7442] = true, [7443] = true,	-- "Supply Drop"

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
	[7079] = true, [7080] = true,	-- "Disarming the Enemy"
	[7113] = true, [7114] = true,	-- "Tame the Wastes"
	[7075] = true, [7076] = true,	-- "They'll thank You Later"
	[7077] = true, [7078] = true,	-- "Eldan Eradication"
	[7072] = true, [7074] = true,	-- "A New God"

	-- Tradeskills - Data Ration
	[9610] = true, [9611] = true,	-- "Torine Tools"
	[9604] = true, [9605] = true,	-- "Pellskinner Blues"
	[9606] = true, [9607] = true,	-- "Loppstitch Made Easy"
	[9608] = true, [9609] = true,	-- "Techno Toys"
	[9598] = true, [9599] = true,	-- "Style Eye for the Clone Guy"
	[9600] = true, [9601] = true,	-- "Dead Man's Vest"

	-- Tradeskills - Crafting Vouchers - Outfitter
	[5983] = true,					-- "How's the Leather?"
	[5986] = true,					-- "Class V Logistics: Medium Armor"
	[5990] = true,					-- "Medium Armor Contract: Algoroc"
	[7271] = true,					-- "The Look and Feel of Hand-Tooled Leather"
	[7272] = true,					-- "Fine Celestion Leather"
	[7273] = true,					-- "Leatherweight Champ"
	[7274] = true,					-- "Fine Leathered Friend"
	[7275] = true,					-- "Leatherweight Champions"
	[7276] = true,					-- "Fine Cassian Leather"
	[7277] = true,					-- "About the Leather"
	[7278] = true,					-- "Leather of Intent"
	[7279] = true,					-- "To the Leather"
	[8286] = true,					-- "Lovely Leather, Isn't It?"
	[8287] = true,					-- "Forester's Delight"
	[8288] = true,					-- "Take Them to the Foresters"
	[8226] = true,					-- "You Can Do Leather, If You Try"
	[8227] = true,					-- "Gotta Get That Leather, Man"
	[8228] = true,					-- "Never Say Leather"
	[9236] = true,					-- "Isigrol-Bent for Leather"
	[9237] = true,					-- "Augmented Leather Hunters"
	[9238] = true,					-- "Ultimate Augmented Leather"
	[9219] = true,					-- "Isigrol-Bent for Leather"
	[9220] = true,					-- "Tempered Leather Hunters"
	[9221] = true,					-- "Ultimate Augmented Leather Hunters"
	[7283] = true,					-- "Leather Report"
	[7284] = true,					-- "Full Leather Jacket"
	[7285] = true,					-- "Leather or Not...."
	[8422] = true,					-- "Big Game Hunter's Armor"
	[8423] = true,					-- "Leather Hunters"
	[8424] = true,					-- "Hard as Rockhide"
	[8341] = true,					-- "Big Game Hunter's Armor"
	[8342] = true,					-- "Leather Hunters"
	[8343] = true,					-- "Hard as Rockhide"
	[7280] = true,					-- "Getting Back to Leather"
	[7281] = true,					-- "Stormy Leather"
	[7282] = true,					-- "A Man of Leathers"
	[7289] = true,					-- "Getting Back to Leather"
	[7290] = true,					-- "Stormy Leather"
	[7291] = true,					-- "A Man of Leathers"
	[7286] = true,					-- "Leather Bound"
	[7287] = true,					-- "The Leather Regions"
	[7288] = true,					-- "Hell-Bent for Leather"
	[8322] = true,					-- "You Can Do Leather, If You Try"
	[8323] = true,					-- "Gotta Get That Leather, Man"
	[8324] = true,					-- "Never Say Leather"
	[8304] = true,					-- "Lovely Leather, Isn't It?"
	[8305] = true,					-- "Forester's Delight"
	[8306] = true,					-- "Take Them to the Foresters"

	-- Tradeskills - Crafting Vouchers - Armorer
	[5774] = true,					-- "Steel Your Heart"
	[5779] = true,					-- "Class V Logistics: Steel Weave Armor"
	[5782] = true,					-- "Steel Armor Contract: Algoroc"
	[7259] = true,					-- "Steel Yourself Exile"
	[7260] = true,					-- "Beg, Borrow, and Steel"
	[7261] = true,					-- "Steel Crazy After All These Years"
	[7262] = true,					-- "Steel of Approval"
	[7263] = true,					-- "Gladiatorial Intentions"
	[7264] = true,					-- "The Art of the Steel"
	[7265] = true,					-- "Timing and Steeling"
	[7266] = true,					-- "Steel's the One"
	[7267] = true,					-- "Cold, Hard Steel"
	[8283] = true,					-- "Plat On Your Back"
	[8284] = true,					-- "Heart of Platinum"
	[8285] = true,					-- "Good as Platinum"
	[8223] = true,					-- "Striking Platinum"
	[8224] = true,					-- "It Won't Ever Rust"
	[8225] = true,					-- "Platinum P.I."
	[9233] = true,					-- "Getting Started with Galacium"
	[9234] = true,					-- "The Armorer's Guide to Galactium"
	[9235] = true,					-- "Galactium-Grade Stopping Power"
	[9216] = true,					-- "Guardians of Galacium"
	[9217] = true,					-- "The Armorer's Guide to Galactium"
	[9218] = true,					-- "Galactium-Grade Stopping Power"
	[7268] = true,					-- "Titanium? I Just Met 'Em!"
	[7269] = true,					-- "Raise the Titanium"
	[7270] = true,					-- "In Titanium We Trust"
	[8419] = true,					-- "Legionnaire in Glowing Armor"
	[8420] = true,					-- "Powered by Xenocite"
	[8421] = true,					-- "Heavy Xenocite Plate"
	[8338] = true,					-- "Knight In Glowing Armor"
	[8339] = true,					-- "Powered by Xenocite"
	[8340] = true,					-- "Heavy Xenocite Plate"
	[6381] = true,					-- "Titanium for All"
	[6382] = true,					-- "A Titanic Effort"
	[6383] = true,					-- "Titanium Protoweaving"
	[7236] = true,					-- "Proud Titanium"
	[7237] = true,					-- "A Titanic Sheet"
	[7238] = true,					-- "Titanium of War"
	[6216] = true,					-- "Titanium on My Mind"
	[6217] = true,					-- "The Titanium Special"
	[6218] = true,					-- "Providing Armor Afield"
	[8319] = true,					-- "Striking Platinum"
	[8320] = true,					-- "It Won't Ever Rust"
	[8321] = true,					-- "Platinum P.I."
	[8301] = true,					-- "Plat On Your Back"
	[8302] = true,					-- "Heart of Platinum"
	[8303] = true,					-- "Good as Platinum"

	-- Tradeskills - Crafting Vouchers - Weaponsmith
	[5171] = true,					-- "Keeping It Steel"
	[5178] = true,					-- "Class V Logistics: Weapons"
	[5209] = true,					-- "Steel Weapons Contract: Algoroc"
	[7241] = true,					-- "Arms for Arboria"
	[7242] = true,					-- "Arms for The XAS"
	[7243] = true,					-- "Arms for the Exiles"
	[7244] = true,					-- "Helping the Hunters"
	[7245] = true,					-- "Monkey Mayhem"
	[7246] = true,					-- "Keys to the Empire"
	[7247] = true,					-- "Wild Arms"
	[7248] = true,					-- "A Legion's Need"
	[7249] = true,					-- "Looking Past the Wilds"
	[8280] = true,					-- "Silver Linings"
	[8281] = true,					-- "Platinum If You Got 'Em"
	[8282] = true,					-- "Comfortably Platinum"
	[8205] = true,					-- "You Platinum, You Bought 'Em"
	[8206] = true,					-- "Platinum Crisis"
	[8207] = true,					-- "A Heart of Platinum"
	[9225] = true,					-- "Battle-Strain Galactium"
	[9226] = true,					-- "The Weaponsmith's Guide to Galactium"
	[9228] = true,					-- "Galactium-Grade Firepower"
	[9213] = true,					-- "Battle-Strain Galactium"
	[9214] = true,					-- "The Weaponsmith's Guide to Galactium"
	[9215] = true,					-- "Galactium-Grade Firepower"
	[7250] = true,					-- "Do As I Ask"
	[7251] = true,					-- "There Is No Try"
	[7252] = true,					-- "The Tools of the Empire"
	[8416] = true,					-- "At First Xenocite"
	[8417] = true,					-- "Xenocite Package"
	[8418] = true,					-- "Xenocite Fight"
	[8334] = true,					-- "At First Xenocite"
	[8335] = true,					-- "Xenocite Package"
	[8337] = true,					-- "Xenocite Fight"
	[5240] = true,					-- "A Vendor in Need"
	[5241] = true,					-- "Coordinating for Shortfalls"
	[5242] = true,					-- "High Expectations"
	[7256] = true,					-- "Mighty Metal"
	[7257] = true,					-- "Blood and Titanium"
	[7258] = true,					-- "Staying on Target"
	[7253] = true,					-- "Titanium Shaper"
	[7254] = true,					-- "Titanium Weapons"
	[7255] = true,					-- "Forging Forward"
	[8316] = true,					-- "You Platinum, You Bought 'Em"
	[8317] = true,					-- "Platinum Crisis"
	[8318] = true,					-- "A Heart of Platinum"
	[8298] = true,					-- "Silver Linings"
	[8299] = true,					-- "Platinum If You Got 'Em"
	[8300] = true,					-- "Comfortably Platinum"

	-- Tradeskills - Crafting Vouchers - Technologist
	[6097] = true,					-- "Medishot Madness"
	[6098] = true,					-- "Class VIII Logistics: Medical Supplies"
	[6099] = true,					-- "Medical Supply Contract: Algoroc"
	[7310] = true,					-- "Fruit of the Spirovine"
	[7311] = true,					-- "Frontier Medicine"
	[7312] = true,					-- "Club Meds"
	[7313] = true,					-- "The Legend of Spirovine"
	[7314] = true,					-- "Medical Herbology"
	[7315] = true,					-- "Get Medicated"
	[7316] = true,					-- "Through the Spirovine"
	[7317] = true,					-- "Making Medicine"
	[7318] = true,					-- "Herbal Shots"
	[8292] = true,					-- "Scaling Up"
	[8293] = true,					-- "Coralscale Values"
	[8294] = true,					-- "Coral History"
	[8274] = true,					-- "Shot Caller"
	[8275] = true,					-- "Sending Priority Coralscale"
	[8276] = true,					-- "Give It Your Best Medishot"
	[9242] = true,					-- "A Quick Shot of Mourningstar"
	[9243] = true,					-- "Mourningstar Medispray"
	[9244] = true,					-- "A Mourningstar Restorative"
	[9249] = true,					-- "A Quick Shot of Mourningstar"
	[9250] = true,					-- "Mourning Medispray"
	[9251] = true,					-- "A Mourningstar Restorative"
	[7319] = true,					-- "Laced with Serpentlily"
	[7320] = true,					-- "A Shot of Something Good"
	[7321] = true,					-- "Dedicated and Medicated"
	[8428] = true,					-- "Fruit of the Faerybloom"
	[8429] = true,					-- "Mixing It Up"
	[8430] = true,					-- "The Purest of Omni-Plasm"
	[8347] = true,					-- "Fruit of the Faerybloom"
	[8348] = true,					-- "Mixing It Up"
	[8349] = true,					-- "The Purest of Omni-Plasm"
	[6114] = true,					-- "How Stimulating"
	[6115] = true,					-- "Two Medishots a Day"
	[6116] = true,					-- "Shotdoctor"
	[7325] = true,					-- "Serpentlilies of the Field"
	[7326] = true,					-- "Talking Shot"
	[7327] = true,					-- "Long-Distance Medication"
	[7322] = true,					-- "Secrets of the Serpentlily"
	[7323] = true,					-- "Somebody Get Me a Shot"
	[7324] = true,					-- "Better Keep 'Em Medicated"
	[8328] = true,					-- "Shot Caller"
	[8329] = true,					-- "Sending Priority Coralscale"
	[8330] = true,					-- "Give It your Best Medishot"
	[8310] = true,					-- "Scaling Up"
	[8311] = true,					-- "Coralscale Values"
	[8312] = true,					-- "Coral History"

	-- Tradeskills - Crafting Vouchers - Tailor
	[5996] = true,					-- "Rugged and Ready"
	[5999] = true,					-- "Class V Logistics: Light Armor"
	[6002] = true,					-- "Canvas Armor Contract: Algoroc"
	[7292] = true,					-- "Canvas for Support"
	[7293] = true,					-- "Catch as Catch Canvas"
	[7294] = true,					-- "The Grand Canvas"
	[7295] = true,					-- "Canvas Ain't Easy"
	[7296] = true,					-- "Catch Me If You Canvas"
	[7297] = true,					-- "Yes, We Canvas"
	[7298] = true,					-- "Can You Canvas?"
	[7299] = true,					-- "Blank Canvas"
	[7300] = true,					-- "The Canvas Man Can"
	[8289] = true,					-- "Retaining Whimfiber"
	[8290] = true,					-- "An Allowance of Fiber"
	[8291] = true,					-- "One Hundred Percent Whimfiber"
	[8229] = true,					-- "Threading On a Whim"
	[8230] = true,					-- "Filled to the Whim"
	[8231] = true,					-- "Four Sheets to the Whim"
	[9239] = true,					-- "Starting with Starloom"
	[9240] = true,					-- "Tailored on a Starloom"
	[9241] = true,					-- "Reach for the Starloom"
	[9222] = true,					-- "Wish Upon a Starloom"
	[9223] = true,					-- "Wishin' on a Starloom"
	[9224] = true,					-- "Reach for the Starloom"
	[7301] = true,					-- "Follow the Silk Road"
	[7302] = true,					-- "You're Really Silking It"
	[7303] = true,					-- "Silk Really Suits You"
	[8425] = true,					-- "Terminal Manaweave"
	[8426] = true,					-- "Weaving In and Out of Focus"
	[8427] = true,					-- "Moxie Magnification"
	[8344] = true,					-- "Terminal Manaweave"
	[8345] = true,					-- "Weaving In and Out of Focus"
	[8346] = true,					-- "Moxie Magnification"
	[6022] = true,					-- "Custom Tailored"
	[6023] = true,					-- "Tailor to Communicate"
	[6024] = true,					-- "Hot Cup of Tailor"
	[7307] = true,					-- "The Road to Silk"
	[7308] = true,					-- "Silking It for All It's Worth"
	[7309] = true,					-- "Silk-Suited"
	[7304] = true,					-- "Shear Silk"
	[7305] = true,					-- "Silk Stalking"
	[7306] = true,					-- "Of the Finest Silk"
	[8325] = true,					-- "Threading on a Whim"
	[8326] = true,					-- "Filled to the Whim"
	[8327] = true,					-- "Four Sheets to the Whim"
	[8307] = true,					-- "Retaining Whimfiber"
	[8308] = true,					-- "An Allowance of Fiber"
	[8308] = true,					-- "100% Whimfiber"

	-- Tradeskills - Crafting Vouchers - Architect
	[6107] = true,					-- "Architectural Aptitude"
	[6108] = true,					-- "Bramble Basics"
	[6109] = true,					-- "Housing Supply Contract: Algoroc"
	[7642] = true,					-- "Feeding Time"
	[7643] = true,					-- "Bramble Blast"
	[7644] = true,					-- "Picket Fences"
	[7645] = true,					-- "Metal Heads"
	[7646] = true,					-- "Bramble Blast"
	[7647] = true,					-- "Practical Architecture"
	[7648] = true,					-- "An Assessment of Ability"
	[7649] = true,					-- "Bramble Ramble"
	[7650] = true,					-- "Fenced In"
	[8295] = true,					-- "Pillow Talk"
	[8296] = true,					-- "Generator Interest"
	[8297] = true,					-- "Pumped Up!"
	[8277] = true,					-- "Purple-Star-Pillow-Piler"
	[8278] = true,					-- "Generator Interest"
	[8279] = true,					-- "Get Pumped!"
	[9245] = true,					-- "Tiki Torches"
	[9246] = true,					-- "Nautical Wheel"
	[9247] = true,					-- "Freebot Surge Protector"
	[9252] = true,					-- "Tiki Torches"
	[9253] = true,					-- "Nautical Wheel"
	[9254] = true,					-- "Freebot Surge Protector"
	[8540] = true,					-- "In Glad Company"
	[8541] = true,					-- "The Architect's Burden"
	[8542] = true,					-- "Torch Lights"
	[8432] = true,					-- "Eye Spy a Camera"
	[8433] = true,					-- "Table This for Now"
	[8431] = true,					-- "Shiny Storage"
	[8350] = true,					-- "Shiny Storage"
	[8351] = true,					-- "Eye Spy a Camera"
	[8352] = true,					-- "Table This for Now"
	[6123] = true,					-- "Local Architecture"
	[6124] = true,					-- "Crate Expectations"
	[6125] = true,					-- "Firestarter"
	[9431] = true,					-- "Whitevale Traction"
	[9432] = true,					-- "It's a Trap"
	[9433] = true,					-- "I Love Lamp"
	[9391] = true,					-- "Whitevale Traction"
	[9392] = true,					-- "It's a Trap"
	[9429] = true,					-- "I Love Lamp"
	[8331] = true,					-- "Locker Stocker"
	[8332] = true,					-- "A Place to Lay One's Cards"
	[8333] = true,					-- "The Great Divider"
	[8313] = true,					-- "Ready, Set, Locker"
	[8314] = true,					-- "Fancy Dresser"
	[8315] = true,					-- "The Great Divider"
}

-- This is used to check what faction is necessary for the quest.
-- Key = ID, Value = Faction enum value.
WTD.QuestFactionExtensions = {
	-- Crimson Badlands
	[7496] = Dominion, [7488] = Exiles,	-- "Reclaim the Power" / "Electrical Disturbance"
	[7498] = Dominion, [7486] = Exiles,	-- "Missing Technologies" / "Equipment Under Siege"

	-- Tradeskills - Data Ration
	[9610] = Dominion, [9611] = Exiles,	-- "Torine Tools"
	[9604] = Dominion, [9605] = Exiles,	-- "Pellskinner Blues"
	[9606] = Dominion, [9607] = Exiles,	-- "Loppstitch Made Easy"
	[9608] = Dominion, [9609] = Exiles,	-- "Techno Toys"
	[9598] = Dominion, [9599] = Exiles,	-- "Style Eye for the Clone Guy"
	[9600] = Dominion, [9601] = Exiles,	-- "Dead Man's Vest"

	-- Tradeskills - Crafting Vouchers - Outfitter
	[5983] = Exiles,					-- "How's the Leather?"
	[5986] = Exiles,					-- "Class V Logistics: Medium Armor"
	[5990] = Exiles,					-- "Medium Armor Contract: Algoroc"
	[7271] = Exiles,					-- "The Look and Feel of Hand-Tooled Leather"
	[7272] = Exiles,					-- "Fine Celestion Leather"
	[7273] = Exiles,					-- "Leatherweight Champ"
	[7274] = Dominion,					-- "Fine Leathered Friend"
	[7275] = Dominion,					-- "Leatherweight Champions"
	[7276] = Dominion,					-- "Fine Cassian Leather"
	[7277] = Dominion,					-- "About the Leather"
	[7278] = Dominion,					-- "Leather of Intent"
	[7279] = Dominion,					-- "To the Leather"
	[8286] = Dominion,					-- "Lovely Leather, Isn't It?"
	[8287] = Dominion,					-- "Forester's Delight"
	[8288] = Dominion,					-- "Take Them to the Foresters"
	[8226] = Exiles,					-- "You Can Do Leather, If You Try"
	[8227] = Exiles,					-- "Gotta Get That Leather, Man"
	[8228] = Exiles,					-- "Never Say Leather"
	[9236] = Dominion,					-- "Isigrol-Bent for Leather"
	[9237] = Dominion,					-- "Augmented Leather Hunters"
	[9238] = Dominion,					-- "Ultimate Augmented Leather"
	[9219] = Exiles,					-- "Isigrol-Bent for Leather"
	[9220] = Exiles,					-- "Tempered Leather Hunters"
	[9221] = Exiles,					-- "Ultimate Augmented Leather Hunters"
	[7283] = Dominion,					-- "Leather Report"
	[7284] = Dominion,					-- "Full Leather Jacket"
	[7285] = Dominion,					-- "Leather or Not...."
	[8422] = Dominion,					-- "Big Game Hunter's Armor"
	[8423] = Dominion,					-- "Leather Hunters"
	[8424] = Dominion,					-- "Hard as Rockhide"
	[8341] = Exiles,					-- "Big Game Hunter's Armor"
	[8342] = Exiles,					-- "Leather Hunters"
	[8343] = Exiles,					-- "Hard as Rockhide"
	[7280] = Exiles,					-- "Getting Back to Leather"
	[7281] = Exiles,					-- "Stormy Leather"
	[7282] = Exiles,					-- "A Man of Leathers"
	[7289] = Dominion,					-- "Getting Back to Leather"
	[7290] = Dominion,					-- "Stormy Leather"
	[7291] = Dominion,					-- "A Man of Leathers"
	[7286] = Exiles,					-- "Leather Bound"
	[7287] = Exiles,					-- "The Leather Regions"
	[7288] = Exiles,					-- "Hell-Bent for Leather"
	[8322] = Dominion,					-- "You Can Do Leather, If You Try"
	[8323] = Dominion,					-- "Gotta Get That Leather, Man"
	[8324] = Dominion,					-- "Never Say Leather"
	[8304] = Exiles,					-- "Lovely Leather, Isn't It?"
	[8305] = Exiles,					-- "Forester's Delight"
	[8306] = Exiles,					-- "Take Them to the Foresters"

	-- Tradeskills - Crafting Vouchers - Armorer
	[5774] = Exiles,					-- "Steel Your Heart"
	[5779] = Exiles,					-- "Class V Logistics: Steel Weave Armor"
	[5782] = Exiles,					-- "Steel Armor Contract: Algoroc"
	[7259] = Exiles,					-- "Steel Yourself Exile"
	[7260] = Exiles,					-- "Beg, Borrow, and Steel"
	[7261] = Exiles,					-- "Steel Crazy After All These Years"
	[7262] = Dominion,					-- "Steel of Approval"
	[7263] = Dominion,					-- "Gladiatorial Intentions"
	[7264] = Dominion,					-- "The Art of the Steel"
	[7265] = Dominion,					-- "Timing and Steeling"
	[7266] = Dominion,					-- "Steel's the One"
	[7267] = Dominion,					-- "Cold, Hard Steel"
	[8283] = Dominion,					-- "Plat On Your Back"
	[8284] = Dominion,					-- "Heart of Platinum"
	[8285] = Dominion,					-- "Good as Platinum"
	[8223] = Exiles,					-- "Striking Platinum"
	[8224] = Exiles,					-- "It Won't Ever Rust"
	[8225] = Exiles,					-- "Platinum P.I."
	[9233] = Dominion,					-- "Getting Started with Galacium"
	[9234] = Dominion,					-- "The Armorer's Guide to Galactium"
	[9235] = Dominion,					-- "Galactium-Grade Stopping Power"
	[9216] = Exiles,					-- "Guardians of Galacium"
	[9217] = Exiles,					-- "The Armorer's Guide to Galactium"
	[9218] = Exiles,					-- "Galactium-Grade Stopping Power"
	[7268] = Dominion,					-- "Titanium? I Just Met 'Em!"
	[7269] = Dominion,					-- "Raise the Titanium"
	[7270] = Dominion,					-- "In Titanium We Trust"
	[8419] = Dominion,					-- "Legionnaire in Glowing Armor"
	[8420] = Dominion,					-- "Powered by Xenocite"
	[8421] = Dominion,					-- "Heavy Xenocite Plate"
	[8338] = Exiles,					-- "Knight In Glowing Armor"
	[8339] = Exiles,					-- "Powered by Xenocite"
	[8340] = Exiles,					-- "Heavy Xenocite Plate"
	[6381] = Exiles,					-- "Titanium for All"
	[6382] = Exiles,					-- "A Titanic Effort"
	[6383] = Exiles,					-- "Titanium Protoweaving"
	[7236] = Dominion,					-- "Proud Titanium"
	[7237] = Dominion,					-- "A Titanic Sheet"
	[7238] = Dominion,					-- "Titanium of War"
	[6216] = Exiles,					-- "Titanium on My Mind"
	[6217] = Exiles,					-- "The Titanium Special"
	[6218] = Exiles,					-- "Providing Armor Afield"
	[8319] = Dominion,					-- "Striking Platinum"
	[8320] = Dominion,					-- "It Won't Ever Rust"
	[8321] = Dominion,					-- "Platinum P.I."
	[8301] = Exiles,					-- "Plat On Your Back"
	[8302] = Exiles,					-- "Heart of Platinum"
	[8303] = Exiles,					-- "Good as Platinum"

	-- Tradeskills - Crafting Vouchers - Weaponsmith
	[5171] = Exiles,					-- "Keeping It Steel"
	[5178] = Exiles,					-- "Class V Logistics: Weapons"
	[5209] = Exiles,					-- "Steel Weapons Contract: Algoroc"
	[7241] = Exiles,					-- "Arms for Arboria"
	[7242] = Exiles,					-- "Arms for The XAS"
	[7243] = Exiles,					-- "Arms for the Exiles"
	[7244] = Dominion,					-- "Helping the Hunters"
	[7245] = Dominion,					-- "Monkey Mayhem"
	[7246] = Dominion,					-- "Keys to the Empire"
	[7247] = Dominion,					-- "Wild Arms"
	[7248] = Dominion,					-- "A Legion's Need"
	[7249] = Dominion,					-- "Looking Past the Wilds"
	[8280] = Dominion,					-- "Silver Linings"
	[8281] = Dominion,					-- "Platinum If You Got 'Em"
	[8282] = Dominion,					-- "Comfortably Platinum"
	[8205] = Exiles,					-- "You Platinum, You Bought 'Em"
	[8206] = Exiles,					-- "Platinum Crisis"
	[8207] = Exiles,					-- "A Heart of Platinum"
	[9225] = Dominion,					-- "Battle-Strain Galactium"
	[9226] = Dominion,					-- "The Weaponsmith's Guide to Galactium"
	[9228] = Dominion,					-- "Galactium-Grade Firepower"
	[9213] = Exiles,					-- "Battle-Strain Galactium"
	[9214] = Exiles,					-- "The Weaponsmith's Guide to Galactium"
	[9215] = Exiles,					-- "Galactium-Grade Firepower"
	[7250] = Dominion,					-- "Do As I Ask"
	[7251] = Dominion,					-- "There Is No Try"
	[7252] = Dominion,					-- "The Tools of the Empire"
	[8416] = Dominion,					-- "At First Xenocite"
	[8417] = Dominion,					-- "Xenocite Package"
	[8418] = Dominion,					-- "Xenocite Fight"
	[8334] = Exiles,					-- "At First Xenocite"
	[8335] = Exiles,					-- "Xenocite Package"
	[8337] = Exiles,					-- "Xenocite Fight"
	[5240] = Exiles,					-- "A Vendor in Need"
	[5241] = Exiles,					-- "Coordinating for Shortfalls"
	[5242] = Exiles,					-- "High Expectations"
	[7256] = Dominion,					-- "Mighty Metal"
	[7257] = Dominion,					-- "Blood and Titanium"
	[7258] = Dominion,					-- "Staying on Target"
	[7253] = Exiles,					-- "Titanium Shaper"
	[7254] = Exiles,					-- "Titanium Weapons"
	[7255] = Exiles,					-- "Forging Forward"
	[8316] = Dominion,					-- "You Platinum, You Bought 'Em"
	[8317] = Dominion,					-- "Platinum Crisis"
	[8318] = Dominion,					-- "A Heart of Platinum"
	[8298] = Exiles,					-- "Silver Linings"
	[8299] = Exiles,					-- "Platinum If You Got 'Em"
	[8300] = Exiles,					-- "Comfortably Platinum"

	-- Tradeskills - Crafting Vouchers - Technologist
	[6097] = Exiles,					-- "Medishot Madness"
	[6098] = Exiles,					-- "Class VIII Logistics: Medical Supplies"
	[6099] = Exiles,					-- "Medical Supply Contract: Algoroc"
	[7310] = Exiles,					-- "Fruit of the Spirovine"
	[7311] = Exiles,					-- "Frontier Medicine"
	[7312] = Exiles,					-- "Club Meds"
	[7313] = Dominion,					-- "The Legend of Spirovine"
	[7314] = Dominion,					-- "Medical Herbology"
	[7315] = Dominion,					-- "Get Medicated"
	[7316] = Dominion,					-- "Through the Spirovine"
	[7317] = Dominion,					-- "Making Medicine"
	[7318] = Dominion,					-- "Herbal Shots"
	[8292] = Dominion,					-- "Scaling Up"
	[8293] = Dominion,					-- "Coralscale Values"
	[8294] = Dominion,					-- "Coral History"
	[8274] = Exiles,					-- "Shot Caller"
	[8275] = Exiles,					-- "Sending Priority Coralscale"
	[8276] = Exiles,					-- "Give It Your Best Medishot"
	[9242] = Dominion,					-- "A Quick Shot of Mourningstar"
	[9243] = Dominion,					-- "Mourningstar Medispray"
	[9244] = Dominion,					-- "A Mourningstar Restorative"
	[9249] = Exiles,					-- "A Quick Shot of Mourningstar"
	[9250] = Exiles,					-- "Mourning Medispray"
	[9251] = Exiles,					-- "A Mourningstar Restorative"
	[7319] = Dominion,					-- "Laced with Serpentlily"
	[7320] = Dominion,					-- "A Shot of Something Good"
	[7321] = Dominion,					-- "Dedicated and Medicated"
	[8428] = Dominion,					-- "Fruit of the Faerybloom"
	[8429] = Dominion,					-- "Mixing It Up"
	[8430] = Dominion,					-- "The Purest of Omni-Plasm"
	[8347] = Exiles,					-- "Fruit of the Faerybloom"
	[8348] = Exiles,					-- "Mixing It Up"
	[8349] = Exiles,					-- "The Purest of Omni-Plasm"
	[6114] = Exiles,					-- "How Stimulating"
	[6115] = Exiles,					-- "Two Medishots a Day"
	[6116] = Exiles,					-- "Shotdoctor"
	[7325] = Dominion,					-- "Serpentlilies of the Field"
	[7326] = Dominion,					-- "Talking Shot"
	[7327] = Dominion,					-- "Long-Distance Medication"
	[7322] = Exiles,					-- "Secrets of the Serpentlily"
	[7323] = Exiles,					-- "Somebody Get Me a Shot"
	[7324] = Exiles,					-- "Better Keep 'Em Medicated"
	[8328] = Dominion,					-- "Shot Caller"
	[8329] = Dominion,					-- "Sending Priority Coralscale"
	[8330] = Dominion,					-- "Give It your Best Medishot"
	[8310] = Exiles,					-- "Scaling Up"
	[8311] = Exiles,					-- "Coralscale Values"
	[8312] = Exiles,					-- "Coral History"

	-- Tradeskills - Crafting Vouchers - Tailor
	[5996] = Exiles,					-- "Rugged and Ready"
	[5999] = Exiles,					-- "Class V Logistics: Light Armor"
	[6002] = Exiles,					-- "Canvas Armor Contract: Algoroc"
	[7292] = Exiles,					-- "Canvas for Support"
	[7293] = Exiles,					-- "Catch as Catch Canvas"
	[7294] = Exiles,					-- "The Grand Canvas"
	[7295] = Dominion,					-- "Canvas Ain't Easy"
	[7296] = Dominion,					-- "Catch Me If You Canvas"
	[7297] = Dominion,					-- "Yes, We Canvas"
	[7298] = Dominion,					-- "Can You Canvas?"
	[7299] = Dominion,					-- "Blank Canvas"
	[7300] = Dominion,					-- "The Canvas Man Can"
	[8289] = Dominion,					-- "Retaining Whimfiber"
	[8290] = Dominion,					-- "An Allowance of Fiber"
	[8291] = Dominion,					-- "One Hundred Percent Whimfiber"
	[8229] = Exiles,					-- "Threading On a Whim"
	[8230] = Exiles,					-- "Filled to the Whim"
	[8231] = Exiles,					-- "Four Sheets to the Whim"
	[9239] = Dominion,					-- "Starting with Starloom"
	[9240] = Dominion,					-- "Tailored on a Starloom"
	[9241] = Dominion,					-- "Reach for the Starloom"
	[9222] = Exiles,					-- "Wish Upon a Starloom"
	[9223] = Exiles,					-- "Wishin' on a Starloom"
	[9224] = Exiles,					-- "Reach for the Starloom"
	[7301] = Dominion,					-- "Follow the Silk Road"
	[7302] = Dominion,					-- "You're Really Silking It"
	[7303] = Dominion,					-- "Silk Really Suits You"
	[8344] = Exiles,					-- "Terminal Manaweave"
	[8345] = Exiles,					-- "Weaving In and Out of Focus"
	[8346] = Exiles,					-- "Moxie Magnification"
	[6022] = Exiles,					-- "Custom Tailored"
	[6023] = Exiles,					-- "Tailor to Communicate"
	[6024] = Exiles,					-- "Hot Cup of Tailor"
	[7307] = Dominion,					-- "The Road to Silk"
	[7308] = Dominion,					-- "Silking It for All It's Worth"
	[7309] = Dominion,					-- "Silk-Suited"
	[7304] = Exiles,					-- "Shear Silk"
	[7305] = Exiles,					-- "Silk Stalking"
	[7306] = Exiles,					-- "Of the Finest Silk"
	[8325] = Dominion,					-- "Threading on a Whim"
	[8326] = Dominion,					-- "Filled to the Whim"
	[8327] = Dominion,					-- "Four Sheets to the Whim"
	[8307] = Exiles,					-- "Retaining Whimfiber"
	[8308] = Exiles,					-- "An Allowance of Fiber"
	[8308] = Exiles,					-- "100% Whimfiber"

	-- Tradeskills - Crafting Vouchers - Architect
	[6107] = Exiles,					-- "Architectural Aptitude"
	[6108] = Exiles,					-- "Bramble Basics"
	[6109] = Exiles,					-- "Housing Supply Contract: Algoroc"
	[7642] = Exiles,					-- "Feeding Time"
	[7643] = Exiles,					-- "Bramble Blast"
	[7644] = Exiles,					-- "Picket Fences"
	[7645] = Dominion,					-- "Metal Heads"
	[7646] = Dominion,					-- "Bramble Blast"
	[7647] = Dominion,					-- "Practical Architecture"
	[7648] = Dominion,					-- "An Assessment of Ability"
	[7649] = Dominion,					-- "Bramble Ramble"
	[7650] = Dominion,					-- "Fenced In"
	[8295] = Dominion,					-- "Pillow Talk"
	[8296] = Dominion,					-- "Generator Interest"
	[8297] = Dominion,					-- "Pumped Up!"
	[8277] = Exiles,					-- "Purple-Star-Pillow-Piler"
	[8278] = Exiles,					-- "Generator Interest"
	[8279] = Exiles,					-- "Get Pumped!"
	[9245] = Dominion,					-- "Tiki Torches"
	[9246] = Dominion,					-- "Nautical Wheel"
	[9247] = Dominion,					-- "Freebot Surge Protector"
	[9252] = Exiles,					-- "Tiki Torches"
	[9253] = Exiles,					-- "Nautical Wheel"
	[9254] = Exiles,					-- "Freebot Surge Protector"
	[8540] = Dominion,					-- "In Glad Company"
	[8541] = Dominion,					-- "The Architect's Burden"
	[8542] = Dominion,					-- "Torch Lights"
	[8432] = Dominion,					-- "Eye Spy a Camera"
	[8433] = Dominion,					-- "Table This for Now"
	[8431] = Dominion,					-- "Shiny Storage"
	[8350] = Exiles,					-- "Shiny Storage"
	[8351] = Exiles,					-- "Eye Spy a Camera"
	[8352] = Exiles,					-- "Table This for Now"
	[6123] = Exiles,					-- "Local Architecture"
	[6124] = Exiles,					-- "Crate Expectations"
	[6125] = Exiles,					-- "Firestarter"
	[9431] = Dominion,					-- "Whitevale Traction"
	[9432] = Dominion,					-- "It's a Trap"
	[9433] = Dominion,					-- "I Love Lamp"
	[9391] = Exiles,					-- "Whitevale Traction"
	[9392] = Exiles,					-- "It's a Trap"
	[9429] = Exiles,					-- "I Love Lamp"
	[8331] = Dominion,					-- "Locker Stocker"
	[8332] = Dominion,					-- "A Place to Lay One's Cards"
	[8333] = Dominion,					-- "The Great Divider"
	[8313] = Exiles,					-- "Ready, Set, Locker"
	[8314] = Exiles,					-- "Fancy Dresser"
	[8315] = Exiles,					-- "The Great Divider"
}

-- This is used to check what path is necessary for the quest.
-- Key = ID, Value = Path enum value.
WTD.QuestPathExtensions = {
	-- Crimson Badlands
	[7468] = Soldier,	[7464] = Soldier,	-- "HOLDOUT: Stop the Scouts"
	[7466] = Scientist,	[7462] = Scientist,	-- "ANALYSIS: Malicious Mutagen"
	[7469] = Explorer,	[7465] = Explorer,	-- "OPERATIONS: Covert Monitoring"

	-- Northern Wastes
	[7102] = Soldier,	[7095] = Soldier,	-- "HOLDOUT: Stolen Supplies"
	[7105] = Explorer,	[7104] = Explorer,	-- "OPERATIONS: Maintaining Communications"
	[7092] = Scientist,	[7086] = Scientist,	-- "ANALYSIS: Crystal Healing"
}

-- This text is prepended to the beginning of a non-zone quest.
-- Key = ID, Value = String to prepend.
WTD.QuestZoneExtensions = {
	-- Tradeskills - Data Ration
	[9610] = ZoneName[Zone.Illium], [9611] = ZoneName[Zone.Thayd],	-- "Torine Tools"
	[9604] = ZoneName[Zone.Illium], [9605] = ZoneName[Zone.Thayd],	-- "Pellskinner Blues"
	[9606] = ZoneName[Zone.Illium], [9607] = ZoneName[Zone.Thayd],	-- "Loppstitch Made Easy"
	[9608] = ZoneName[Zone.Illium], [9609] = ZoneName[Zone.Thayd],	-- "Techno Toys"
	[9598] = ZoneName[Zone.Illium], [9599] = ZoneName[Zone.Thayd],	-- "Style Eye for the Clone Guy"
	[9600] = ZoneName[Zone.Illium], [9601] = ZoneName[Zone.Thayd],	-- "Dead Man's Vest"

	-- Tradeskills - Crafting Vouchers - Outfitter
	[5983] = ZoneName[Zone.Algoroc],				-- "How's the Leather?"
	[5986] = ZoneName[Zone.Algoroc],				-- "Class V Logistics: Medium Armor"
	[5990] = ZoneName[Zone.Algoroc],				-- "Medium Armor Contract: Algoroc"
	[7271] = ZoneName[Zone.Celestion],				-- "The Look and Feel of Hand-Tooled Leather"
	[7272] = ZoneName[Zone.Celestion],				-- "Fine Celestion Leather"
	[7273] = ZoneName[Zone.Celestion],				-- "Leatherweight Champ"
	[7274] = ZoneName[Zone.Deradune],				-- "Fine Leathered Friend"
	[7275] = ZoneName[Zone.Deradune],				-- "Leatherweight Champions"
	[7276] = ZoneName[Zone.Deradune],				-- "Fine Cassian Leather"
	[7277] = ZoneName[Zone.Ellevar],				-- "About the Leather"
	[7278] = ZoneName[Zone.Ellevar],				-- "Leather of Intent"
	[7279] = ZoneName[Zone.Ellevar],				-- "To the Leather"
	[8286] = ZoneName[Zone.Farside],				-- "Lovely Leather, Isn't It?"
	[8287] = ZoneName[Zone.Farside],				-- "Forester's Delight"
	[8288] = ZoneName[Zone.Farside],				-- "Take Them to the Foresters"
	[8226] = ZoneName[Zone.Farside],				-- "You Can Do Leather, If You Try"
	[8227] = ZoneName[Zone.Farside],				-- "Gotta Get That Leather, Man"
	[8228] = ZoneName[Zone.Farside],				-- "Never Say Leather"
	[9236] = ZoneName[Zone.Grimvault],				-- "Isigrol-Bent for Leather"
	[9237] = ZoneName[Zone.Grimvault],				-- "Augmented Leather Hunters"
	[9238] = ZoneName[Zone.Grimvault],				-- "Ultimate Augmented Leather"
	[9219] = ZoneName[Zone.Grimvault],				-- "Isigrol-Bent for Leather"
	[9220] = ZoneName[Zone.Grimvault],				-- "Tempered Leather Hunters"
	[9221] = ZoneName[Zone.Grimvault],				-- "Ultimate Augmented Leather Hunters"
	[7283] = ZoneName[Zone.Illium],					-- "Leather Report"
	[7284] = ZoneName[Zone.Illium],					-- "Full Leather Jacket"
	[7285] = ZoneName[Zone.Illium],					-- "Leather or Not...."
	[8422] = ZoneName[Zone.Malgrave],				-- "Big Game Hunter's Armor"
	[8423] = ZoneName[Zone.Malgrave],				-- "Leather Hunters"
	[8424] = ZoneName[Zone.Malgrave],				-- "Hard as Rockhide"
	[8432] = ZoneName[Zone.Malgrave],				-- "Eye Spy a Camera"
	[8341] = ZoneName[Zone.Malgrave],				-- "Big Game Hunter's Armor"
	[8342] = ZoneName[Zone.Malgrave],				-- "Leather Hunters"
	[8343] = ZoneName[Zone.Malgrave],				-- "Hard as Rockhide"
	[7280] = ZoneName[Zone.Thayd],					-- "Getting Back to Leather"
	[7281] = ZoneName[Zone.Thayd],					-- "Stormy Leather"
	[7282] = ZoneName[Zone.Thayd],					-- "A Man of Leathers"
	[7289] = ZoneName[Zone.Whitevale],				-- "Getting Back to Leather"
	[7290] = ZoneName[Zone.Whitevale],				-- "Stormy Leather"
	[7291] = ZoneName[Zone.Whitevale],				-- "A Man of Leathers"
	[7286] = ZoneName[Zone.Whitevale],				-- "Leather Bound"
	[7287] = ZoneName[Zone.Whitevale],				-- "The Leather Regions"
	[7288] = ZoneName[Zone.Whitevale],				-- "Hell-Bent for Leather"
	[8322] = ZoneName[Zone.Wilderrun],				-- "You Can Do Leather, If You Try"
	[8323] = ZoneName[Zone.Wilderrun],				-- "Gotta Get That Leather, Man"
	[8324] = ZoneName[Zone.Wilderrun],				-- "Never Say Leather"
	[8304] = ZoneName[Zone.Wilderrun],				-- "Lovely Leather, Isn't It?"
	[8305] = ZoneName[Zone.Wilderrun],				-- "Forester's Delight"
	[8306] = ZoneName[Zone.Wilderrun],				-- "Take Them to the Foresters"

	-- Tradeskills - Crafting Vouchers - Armorer
	[5774] = ZoneName[Zone.Algoroc],				-- "Steel Your Heart"
	[5779] = ZoneName[Zone.Algoroc],				-- "Class V Logistics: Steel Weave Armor"
	[5782] = ZoneName[Zone.Algoroc],				-- "Steel Armor Contract: Algoroc"
	[7259] = ZoneName[Zone.Celestion],				-- "Steel Yourself Exile"
	[7260] = ZoneName[Zone.Celestion],				-- "Beg, Borrow, and Steel"
	[7261] = ZoneName[Zone.Celestion],				-- "Steel Crazy After All These Years"
	[7262] = ZoneName[Zone.Deradune],				-- "Steel of Approval"
	[7263] = ZoneName[Zone.Deradune],				-- "Gladiatorial Intentions"
	[7264] = ZoneName[Zone.Deradune],				-- "The Art of the Steel"
	[7265] = ZoneName[Zone.Ellevar],				-- "Timing and Steeling"
	[7266] = ZoneName[Zone.Ellevar],				-- "Steel's the One"
	[7267] = ZoneName[Zone.Ellevar],				-- "Cold, Hard Steel"
	[8283] = ZoneName[Zone.Farside],				-- "Plat On Your Back"
	[8284] = ZoneName[Zone.Farside],				-- "Heart of Platinum"
	[8285] = ZoneName[Zone.Farside],				-- "Good as Platinum"
	[8223] = ZoneName[Zone.Farside],				-- "Striking Platinum"
	[8224] = ZoneName[Zone.Farside],				-- "It Won't Ever Rust"
	[8225] = ZoneName[Zone.Farside],				-- "Platinum P.I."
	[9233] = ZoneName[Zone.Grimvault],				-- "Getting Started with Galacium"
	[9234] = ZoneName[Zone.Grimvault],				-- "The Armorer's Guide to Galactium"
	[9235] = ZoneName[Zone.Grimvault],				-- "Galactium-Grade Stopping Power"
	[9216] = ZoneName[Zone.Grimvault],				-- "Guardians of Galacium"
	[9217] = ZoneName[Zone.Grimvault],				-- "The Armorer's Guide to Galactium"
	[9218] = ZoneName[Zone.Grimvault],				-- "Galactium-Grade Stopping Power"
	[7268] = ZoneName[Zone.Illium],					-- "Titanium? I Just Met 'Em!"
	[7269] = ZoneName[Zone.Illium],					-- "Raise the Titanium"
	[7270] = ZoneName[Zone.Illium],					-- "In Titanium We Trust"
	[8419] = ZoneName[Zone.Malgrave],				-- "Legionnaire in Glowing Armor"
	[8420] = ZoneName[Zone.Malgrave],				-- "Powered by Xenocite"
	[8421] = ZoneName[Zone.Malgrave],				-- "Heavy Xenocite Plate"
	[8338] = ZoneName[Zone.Malgrave],				-- "Knight In Glowing Armor"
	[8339] = ZoneName[Zone.Malgrave],				-- "Powered by Xenocite"
	[8340] = ZoneName[Zone.Malgrave],				-- "Heavy Xenocite Plate"
	[6381] = ZoneName[Zone.Thayd],					-- "Titanium for All"
	[6382] = ZoneName[Zone.Thayd],					-- "A Titanic Effort"
	[6383] = ZoneName[Zone.Thayd],					-- "Titanium Protoweaving"
	[7236] = ZoneName[Zone.Whitevale],				-- "Proud Titanium"
	[7237] = ZoneName[Zone.Whitevale],				-- "A Titanic Sheet"
	[7238] = ZoneName[Zone.Whitevale],				-- "Titanium of War"
	[6216] = ZoneName[Zone.Whitevale],				-- "Titanium on My Mind"
	[6217] = ZoneName[Zone.Whitevale],				-- "The Titanium Special"
	[6218] = ZoneName[Zone.Whitevale],				-- "Providing Armor Afield"
	[8319] = ZoneName[Zone.Wilderrun],				-- "Striking Platinum"
	[8320] = ZoneName[Zone.Wilderrun],				-- "It Won't Ever Rust"
	[8321] = ZoneName[Zone.Wilderrun],				-- "Platinum P.I."
	[8301] = ZoneName[Zone.Wilderrun],				-- "Plat On Your Back"
	[8302] = ZoneName[Zone.Wilderrun],				-- "Heart of Platinum"
	[8303] = ZoneName[Zone.Wilderrun],				-- "Good as Platinum"

	-- Tradeskills - Crafting Vouchers - Weaponsmith
	[5171] = ZoneName[Zone.Algoroc],				-- "Keeping It Steel"
	[5178] = ZoneName[Zone.Algoroc],				-- "Class V Logistics: Weapons"
	[5209] = ZoneName[Zone.Algoroc],				-- "Steel Weapons Contract: Algoroc"
	[7241] = ZoneName[Zone.Celestion],				-- "Arms for Arboria"
	[7242] = ZoneName[Zone.Celestion],				-- "Arms for The XAS"
	[7243] = ZoneName[Zone.Celestion],				-- "Arms for the Exiles"
	[7244] = ZoneName[Zone.Deradune],				-- "Helping the Hunters"
	[7245] = ZoneName[Zone.Deradune],				-- "Monkey Mayhem"
	[7246] = ZoneName[Zone.Deradune],				-- "Keys to the Empire"
	[7247] = ZoneName[Zone.Ellevar],				-- "Wild Arms"
	[7248] = ZoneName[Zone.Ellevar],				-- "A Legion's Need"
	[7249] = ZoneName[Zone.Ellevar],				-- "Looking Past the Wilds"
	[8280] = ZoneName[Zone.Farside],				-- "Silver Linings"
	[8281] = ZoneName[Zone.Farside],				-- "Platinum If You Got 'Em"
	[8282] = ZoneName[Zone.Farside],				-- "Comfortably Platinum"
	[8205] = ZoneName[Zone.Farside],				-- "You Platinum, You Bought 'Em"
	[8206] = ZoneName[Zone.Farside],				-- "Platinum Crisis"
	[8207] = ZoneName[Zone.Farside],				-- "A Heart of Platinum"
	[9225] = ZoneName[Zone.Grimvault],				-- "Battle-Strain Galactium"
	[9226] = ZoneName[Zone.Grimvault],				-- "The Weaponsmith's Guide to Galactium"
	[9228] = ZoneName[Zone.Grimvault],				-- "Galactium-Grade Firepower"
	[9213] = ZoneName[Zone.Grimvault],				-- "Battle-Strain Galactium"
	[9214] = ZoneName[Zone.Grimvault],				-- "The Weaponsmith's Guide to Galactium"
	[9215] = ZoneName[Zone.Grimvault],				-- "Galactium-Grade Firepower"
	[7250] = ZoneName[Zone.Illium],					-- "Do As I Ask"
	[7251] = ZoneName[Zone.Illium],					-- "There Is No Try"
	[7252] = ZoneName[Zone.Illium],					-- "The Tools of the Empire"
	[8416] = ZoneName[Zone.Malgrave],				-- "At First Xenocite"
	[8417] = ZoneName[Zone.Malgrave],				-- "Xenocite Package"
	[8418] = ZoneName[Zone.Malgrave],				-- "Xenocite Fight"
	[8334] = ZoneName[Zone.Malgrave],				-- "At First Xenocite"
	[8335] = ZoneName[Zone.Malgrave],				-- "Xenocite Package"
	[8337] = ZoneName[Zone.Malgrave],				-- "Xenocite Fight"
	[5240] = ZoneName[Zone.Thayd],					-- "A Vendor in Need"
	[5241] = ZoneName[Zone.Thayd],					-- "Coordinating for Shortfalls"
	[5242] = ZoneName[Zone.Thayd],					-- "High Expectations"
	[7256] = ZoneName[Zone.Whitevale],				-- "Mighty Metal"
	[7257] = ZoneName[Zone.Whitevale],				-- "Blood and Titanium"
	[7258] = ZoneName[Zone.Whitevale],				-- "Staying on Target"
	[7253] = ZoneName[Zone.Whitevale],				-- "Titanium Shaper"
	[7254] = ZoneName[Zone.Whitevale],				-- "Titanium Weapons"
	[7255] = ZoneName[Zone.Whitevale],				-- "Forging Forward"
	[8316] = ZoneName[Zone.Wilderrun],				-- "You Platinum, You Bought 'Em"
	[8317] = ZoneName[Zone.Wilderrun],				-- "Platinum Crisis"
	[8318] = ZoneName[Zone.Wilderrun],				-- "A Heart of Platinum"
	[8298] = ZoneName[Zone.Wilderrun],				-- "Silver Linings"
	[8299] = ZoneName[Zone.Wilderrun],				-- "Platinum If You Got 'Em"
	[8300] = ZoneName[Zone.Wilderrun],				-- "Comfortably Platinum"

	-- Tradeskills - Crafting Vouchers - Technologist
	[6097] = ZoneName[Zone.Algoroc],				-- "Medishot Madness"
	[6098] = ZoneName[Zone.Algoroc],				-- "Class VIII Logistics: Medical Supplies"
	[6099] = ZoneName[Zone.Algoroc],				-- "Medical Supply Contract: Algoroc"
	[7310] = ZoneName[Zone.Celestion],				-- "Fruit of the Spirovine"
	[7311] = ZoneName[Zone.Celestion],				-- "Frontier Medicine"
	[7312] = ZoneName[Zone.Celestion],				-- "Club Meds"
	[7313] = ZoneName[Zone.Deradune],				-- "The Legend of Spirovine"
	[7314] = ZoneName[Zone.Deradune],				-- "Medical Herbology"
	[7315] = ZoneName[Zone.Deradune],				-- "Get Medicated"
	[7316] = ZoneName[Zone.Ellevar],				-- "Through the Spirovine"
	[7317] = ZoneName[Zone.Ellevar],				-- "Making Medicine"
	[7318] = ZoneName[Zone.Ellevar],				-- "Herbal Shots"
	[8292] = ZoneName[Zone.Farside],				-- "Scaling Up"
	[8293] = ZoneName[Zone.Farside],				-- "Coralscale Values"
	[8294] = ZoneName[Zone.Farside],				-- "Coral History"
	[8274] = ZoneName[Zone.Farside],				-- "Shot Caller"
	[8275] = ZoneName[Zone.Farside],				-- "Sending Priority Coralscale"
	[8276] = ZoneName[Zone.Farside],				-- "Give It Your Best Medishot"
	[9242] = ZoneName[Zone.Grimvault],				-- "A Quick Shot of Mourningstar"
	[9243] = ZoneName[Zone.Grimvault],				-- "Mourningstar Medispray"
	[9244] = ZoneName[Zone.Grimvault],				-- "A Mourningstar Restorative"
	[9249] = ZoneName[Zone.Grimvault],				-- "A Quick Shot of Mourningstar"
	[9250] = ZoneName[Zone.Grimvault],				-- "Mourning Medispray"
	[9251] = ZoneName[Zone.Grimvault],				-- "A Mourningstar Restorative"
	[7319] = ZoneName[Zone.Illium],					-- "Laced with Serpentlily"
	[7320] = ZoneName[Zone.Illium],					-- "A Shot of Something Good"
	[7321] = ZoneName[Zone.Illium],					-- "Dedicated and Medicated"
	[8428] = ZoneName[Zone.Malgrave],				-- "Fruit of the Faerybloom"
	[8429] = ZoneName[Zone.Malgrave],				-- "Mixing It Up"
	[8430] = ZoneName[Zone.Malgrave],				-- "The Purest of Omni-Plasm"
	[8347] = ZoneName[Zone.Malgrave],				-- "Fruit of the Faerybloom"
	[8348] = ZoneName[Zone.Malgrave],				-- "Mixing It Up"
	[8349] = ZoneName[Zone.Malgrave],				-- "The Purest of Omni-Plasm"
	[6114] = ZoneName[Zone.Thayd],					-- "How Stimulating"
	[6115] = ZoneName[Zone.Thayd],					-- "Two Medishots a Day"
	[6116] = ZoneName[Zone.Thayd],					-- "Shotdoctor"
	[7325] = ZoneName[Zone.Whitevale],				-- "Serpentlilies of the Field"
	[7326] = ZoneName[Zone.Whitevale],				-- "Talking Shot"
	[7327] = ZoneName[Zone.Whitevale],				-- "Long-Distance Medication"
	[7322] = ZoneName[Zone.Whitevale],				-- "Secrets of the Serpentlily"
	[7323] = ZoneName[Zone.Whitevale],				-- "Somebody Get Me a Shot"
	[7324] = ZoneName[Zone.Whitevale],				-- "Better Keep 'Em Medicated"
	[8328] = ZoneName[Zone.Wilderrun],				-- "Shot Caller"
	[8329] = ZoneName[Zone.Wilderrun],				-- "Sending Priority Coralscale"
	[8330] = ZoneName[Zone.Wilderrun],				-- "Give It your Best Medishot"
	[8310] = ZoneName[Zone.Wilderrun],				-- "Scaling Up"
	[8311] = ZoneName[Zone.Wilderrun],				-- "Coralscale Values"
	[8312] = ZoneName[Zone.Wilderrun],				-- "Coral History"

	-- Tradeskills - Crafting Vouchers - Tailor
	[5996] = ZoneName[Zone.Algoroc],				-- "Rugged and Ready"
	[5999] = ZoneName[Zone.Algoroc],				-- "Class V Logistics: Light Armor"
	[6002] = ZoneName[Zone.Algoroc],				-- "Canvas Armor Contract: Algoroc"
	[7292] = ZoneName[Zone.Celestion],				-- "Canvas for Support"
	[7293] = ZoneName[Zone.Celestion],				-- "Catch as Catch Canvas"
	[7294] = ZoneName[Zone.Celestion],				-- "The Grand Canvas"
	[7295] = ZoneName[Zone.Deradune],				-- "Canvas Ain't Easy"
	[7296] = ZoneName[Zone.Deradune],				-- "Catch Me If You Canvas"
	[7297] = ZoneName[Zone.Deradune],				-- "Yes, We Canvas"
	[7298] = ZoneName[Zone.Ellevar],				-- "Can You Canvas?"
	[7299] = ZoneName[Zone.Ellevar],				-- "Blank Canvas"
	[7300] = ZoneName[Zone.Ellevar],				-- "The Canvas Man Can"
	[8289] = ZoneName[Zone.Farside],				-- "Retaining Whimfiber"
	[8290] = ZoneName[Zone.Farside],				-- "An Allowance of Fiber"
	[8291] = ZoneName[Zone.Farside],				-- "One Hundred Percent Whimfiber"
	[8229] = ZoneName[Zone.Farside],				-- "Threading On a Whim"
	[8230] = ZoneName[Zone.Farside],				-- "Filled to the Whim"
	[8231] = ZoneName[Zone.Farside],				-- "Four Sheets to the Whim"
	[9239] = ZoneName[Zone.Grimvault],				-- "Starting with Starloom"
	[9240] = ZoneName[Zone.Grimvault],				-- "Tailored on a Starloom"
	[9241] = ZoneName[Zone.Grimvault],				-- "Reach for the Starloom"
	[9222] = ZoneName[Zone.Grimvault],				-- "Wish Upon a Starloom"
	[9223] = ZoneName[Zone.Grimvault],				-- "Wishin' on a Starloom"
	[9224] = ZoneName[Zone.Grimvault],				-- "Reach for the Starloom"
	[7301] = ZoneName[Zone.Illium],					-- "Follow the Silk Road"
	[7302] = ZoneName[Zone.Illium],					-- "You're Really Silking It"
	[7303] = ZoneName[Zone.Illium],					-- "Silk Really Suits You"
	[8425] = ZoneName[Zone.Malgrave],				-- "Terminal Manaweave"
	[8426] = ZoneName[Zone.Malgrave],				-- "Weaving In and Out of Focus"
	[8427] = ZoneName[Zone.Malgrave],				-- "Moxie Magnification"
	[8344] = ZoneName[Zone.Malgrave],				-- "Terminal Manaweave"
	[8345] = ZoneName[Zone.Malgrave],				-- "Weaving In and Out of Focus"
	[8346] = ZoneName[Zone.Malgrave],				-- "Moxie Magnification"
	[6022] = ZoneName[Zone.Thayd],					-- "Custom Tailored"
	[6023] = ZoneName[Zone.Thayd],					-- "Tailor to Communicate"
	[6024] = ZoneName[Zone.Thayd],					-- "Hot Cup of Tailor"
	[7307] = ZoneName[Zone.Whitevale],				-- "The Road to Silk"
	[7308] = ZoneName[Zone.Whitevale],				-- "Silking It for All It's Worth"
	[7309] = ZoneName[Zone.Whitevale],				-- "Silk-Suited"
	[7304] = ZoneName[Zone.Whitevale],				-- "Shear Silk"
	[7305] = ZoneName[Zone.Whitevale],				-- "Silk Stalking"
	[7306] = ZoneName[Zone.Whitevale],				-- "Of the Finest Silk"
	[8325] = ZoneName[Zone.Wilderrun],				-- "Threading on a Whim"
	[8326] = ZoneName[Zone.Wilderrun],				-- "Filled to the Whim"
	[8327] = ZoneName[Zone.Wilderrun],				-- "Four Sheets to the Whim"
	[8307] = ZoneName[Zone.Wilderrun],				-- "Retaining Whimfiber"
	[8308] = ZoneName[Zone.Wilderrun],				-- "An Allowance of Fiber"
	[8308] = ZoneName[Zone.Wilderrun],				-- "100% Whimfiber"

	-- Tradeskills - Crafting Vouchers - Architect
	[6107] = ZoneName[Zone.Algoroc],				-- "Architectural Aptitude"
	[6108] = ZoneName[Zone.Algoroc],				-- "Bramble Basics"
	[6109] = ZoneName[Zone.Algoroc],				-- "Housing Supply Contract: Algoroc"
	[7642] = ZoneName[Zone.Celestion],				-- "Feeding Time"
	[7643] = ZoneName[Zone.Celestion],				-- "Bramble Blast"
	[7644] = ZoneName[Zone.Celestion],				-- "Picket Fences"
	[7645] = ZoneName[Zone.Deradune],				-- "Metal Heads"
	[7646] = ZoneName[Zone.Deradune],				-- "Bramble Blast"
	[7647] = ZoneName[Zone.Deradune],				-- "Practical Architecture"
	[7648] = ZoneName[Zone.Ellevar],				-- "An Assessment of Ability"
	[7649] = ZoneName[Zone.Ellevar],				-- "Bramble Ramble"
	[7650] = ZoneName[Zone.Ellevar],				-- "Fenced In"
	[8295] = ZoneName[Zone.Farside],				-- "Pillow Talk"
	[8296] = ZoneName[Zone.Farside],				-- "Generator Interest"
	[8297] = ZoneName[Zone.Farside],				-- "Pumped Up!"
	[8277] = ZoneName[Zone.Farside],				-- "Purple-Star-Pillow-Piler"
	[8278] = ZoneName[Zone.Farside],				-- "Generator Interest"
	[8279] = ZoneName[Zone.Farside],				-- "Get Pumped!"
	[9245] = ZoneName[Zone.Grimvault],				-- "Tiki Torches"
	[9246] = ZoneName[Zone.Grimvault],				-- "Nautical Wheel"
	[9247] = ZoneName[Zone.Grimvault],				-- "Freebot Surge Protector"
	[9252] = ZoneName[Zone.Grimvault],				-- "Tiki Torches"
	[9253] = ZoneName[Zone.Grimvault],				-- "Nautical Wheel"
	[9254] = ZoneName[Zone.Grimvault],				-- "Freebot Surge Protector"
	[8540] = ZoneName[Zone.Illium],					-- "In Glad Company"
	[8541] = ZoneName[Zone.Illium],					-- "The Architect's Burden"
	[8542] = ZoneName[Zone.Illium],					-- "Torch Lights"
	[8432] = ZoneName[Zone.Malgrave],				-- "Eye Spy a Camera"
	[8433] = ZoneName[Zone.Malgrave],				-- "Table This for Now"
	[8431] = ZoneName[Zone.Malgrave],				-- "Shiny Storage"
	[8350] = ZoneName[Zone.Malgrave],				-- "Shiny Storage"
	[8351] = ZoneName[Zone.Malgrave],				-- "Eye Spy a Camera"
	[8352] = ZoneName[Zone.Malgrave],				-- "Table This for Now"
	[6123] = ZoneName[Zone.Thayd],					-- "Local Architecture"
	[6124] = ZoneName[Zone.Thayd],					-- "Crate Expectations"
	[6125] = ZoneName[Zone.Thayd],					-- "Firestarter"
	[9431] = ZoneName[Zone.Whitevale],				-- "Whitevale Traction"
	[9432] = ZoneName[Zone.Whitevale],				-- "It's a Trap"
	[9433] = ZoneName[Zone.Whitevale],				-- "I Love Lamp"
	[9391] = ZoneName[Zone.Whitevale],				-- "Whitevale Traction"
	[9392] = ZoneName[Zone.Whitevale],				-- "It's a Trap"
	[9429] = ZoneName[Zone.Whitevale],				-- "I Love Lamp"
	[8331] = ZoneName[Zone.Wilderrun],				-- "Locker Stocker"
	[8332] = ZoneName[Zone.Wilderrun],				-- "A Place to Lay One's Cards"
	[8333] = ZoneName[Zone.Wilderrun],				-- "The Great Divider"
	[8313] = ZoneName[Zone.Wilderrun],				-- "Ready, Set, Locker"
	[8314] = ZoneName[Zone.Wilderrun],				-- "Fancy Dresser"
	[8315] = ZoneName[Zone.Wilderrun],				-- "The Great Divider"
}

-- This is used to check what tradeskill is necessary for the quest.
-- Key = ID, Value = Tradeskill enum value.
WTD.QuestTradeskillExtensions = {
	-- Tradeskills - Data Ration
	[9610] = Weaponsmith,	[9611] = Weaponsmith,	-- "Torine Tools"
	[9604] = Outfitter,		[9605] = Outfitter,		-- "Pellskinner Blues"
	[9606] = Tailor,		[9607] = Tailor,		-- "Loppstitch Made Easy"
	[9608] = Technologist,	[9609] = Technologist,	-- "Techno Toys"
	[9598] = Architect,		[9599] = Architect,		-- "Style Eye for the Clone Guy"
	[9600] = Armorer,		[9601] = Armorer,		-- "Dead Man's Vest"

	-- Tradeskills - Crafting Vouchers - Outfitter
	[5983] = Outfitter,				-- "How's the Leather?"
	[5986] = Outfitter,				-- "Class V Logistics: Medium Armor"
	[5990] = Outfitter,				-- "Medium Armor Contract: Algoroc"
	[7271] = Outfitter,				-- "The Look and Feel of Hand-Tooled Leather"
	[7272] = Outfitter,				-- "Fine Celestion Leather"
	[7273] = Outfitter,				-- "Leatherweight Champ"
	[7274] = Outfitter,				-- "Fine Leathered Friend"
	[7275] = Outfitter,				-- "Leatherweight Champions"
	[7276] = Outfitter,				-- "Fine Cassian Leather"
	[7277] = Outfitter,				-- "About the Leather"
	[7278] = Outfitter,				-- "Leather of Intent"
	[7279] = Outfitter,				-- "To the Leather"
	[8286] = Outfitter,				-- "Lovely Leather, Isn't It?"
	[8287] = Outfitter,				-- "Forester's Delight"
	[8288] = Outfitter,				-- "Take Them to the Foresters"
	[8226] = Outfitter,				-- "You Can Do Leather, If You Try"
	[8227] = Outfitter,				-- "Gotta Get That Leather, Man"
	[8228] = Outfitter,				-- "Never Say Leather"
	[9236] = Outfitter,				-- "Isigrol-Bent for Leather"
	[9237] = Outfitter,				-- "Augmented Leather Hunters"
	[9238] = Outfitter,				-- "Ultimate Augmented Leather"
	[9219] = Outfitter,				-- "Isigrol-Bent for Leather"
	[9220] = Outfitter,				-- "Tempered Leather Hunters"
	[9221] = Outfitter,				-- "Ultimate Augmented Leather Hunters"
	[7283] = Outfitter,				-- "Leather Report"
	[7284] = Outfitter,				-- "Full Leather Jacket"
	[7285] = Outfitter,				-- "Leather or Not...."
	[8422] = Outfitter,				-- "Big Game Hunter's Armor"
	[8423] = Outfitter,				-- "Leather Hunters"
	[8424] = Outfitter,				-- "Hard as Rockhide"
	[8432] = Outfitter,				-- "Eye Spy a Camera"
	[8341] = Outfitter,				-- "Big Game Hunter's Armor"
	[8342] = Outfitter,				-- "Leather Hunters"
	[8343] = Outfitter,				-- "Hard as Rockhide"
	[7280] = Outfitter,				-- "Getting Back to Leather"
	[7281] = Outfitter,				-- "Stormy Leather"
	[7282] = Outfitter,				-- "A Man of Leathers"
	[7289] = Outfitter,				-- "Getting Back to Leather"
	[7290] = Outfitter,				-- "Stormy Leather"
	[7291] = Outfitter,				-- "A Man of Leathers"
	[7286] = Outfitter,				-- "Leather Bound"
	[7287] = Outfitter,				-- "The Leather Regions"
	[7288] = Outfitter,				-- "Hell-Bent for Leather"
	[8322] = Outfitter,				-- "You Can Do Leather, If You Try"
	[8323] = Outfitter,				-- "Gotta Get That Leather, Man"
	[8324] = Outfitter,				-- "Never Say Leather"
	[8304] = Outfitter,				-- "Lovely Leather, Isn't It?"
	[8305] = Outfitter,				-- "Forester's Delight"
	[8306] = Outfitter,				-- "Take Them to the Foresters"

	-- Tradeskills - Crafting Vouchers - Armorer
	[5774] = Armorer,				-- "Steel Your Heart"
	[5779] = Armorer,				-- "Class V Logistics: Steel Weave Armor"
	[5782] = Armorer,				-- "Steel Armor Contract: Algoroc"
	[7259] = Armorer,				-- "Steel Yourself Exile"
	[7260] = Armorer,				-- "Beg, Borrow, and Steel"
	[7261] = Armorer,				-- "Steel Crazy After All These Years"
	[7262] = Armorer,				-- "Steel of Approval"
	[7263] = Armorer,				-- "Gladiatorial Intentions"
	[7264] = Armorer,				-- "The Art of the Steel"
	[7265] = Armorer,				-- "Timing and Steeling"
	[7266] = Armorer,				-- "Steel's the One"
	[7267] = Armorer,				-- "Cold, Hard Steel"
	[8283] = Armorer,				-- "Plat On Your Back"
	[8284] = Armorer,				-- "Heart of Platinum"
	[8285] = Armorer,				-- "Good as Platinum"
	[8223] = Armorer,				-- "Striking Platinum"
	[8224] = Armorer,				-- "It Won't Ever Rust"
	[8225] = Armorer,				-- "Platinum P.I."
	[9233] = Armorer,				-- "Getting Started with Galacium"
	[9234] = Armorer,				-- "The Armorer's Guide to Galactium"
	[9235] = Armorer,				-- "Galactium-Grade Stopping Power"
	[9216] = Armorer,				-- "Guardians of Galacium"
	[9217] = Armorer,				-- "The Armorer's Guide to Galactium"
	[9218] = Armorer,				-- "Galactium-Grade Stopping Power"
	[7268] = Armorer,				-- "Titanium? I Just Met 'Em!"
	[7269] = Armorer,				-- "Raise the Titanium"
	[7270] = Armorer,				-- "In Titanium We Trust"
	[8419] = Armorer,				-- "Legionnaire in Glowing Armor"
	[8420] = Armorer,				-- "Powered by Xenocite"
	[8421] = Armorer,				-- "Heavy Xenocite Plate"
	[8338] = Armorer,				-- "Knight In Glowing Armor"
	[8339] = Armorer,				-- "Powered by Xenocite"
	[8340] = Armorer,				-- "Heavy Xenocite Plate"
	[6381] = Armorer,				-- "Titanium for All"
	[6382] = Armorer,				-- "A Titanic Effort"
	[6383] = Armorer,				-- "Titanium Protoweaving"
	[7236] = Armorer,				-- "Proud Titanium"
	[7237] = Armorer,				-- "A Titanic Sheet"
	[7238] = Armorer,				-- "Titanium of War"
	[6216] = Armorer,				-- "Titanium on My Mind"
	[6217] = Armorer,				-- "The Titanium Special"
	[6218] = Armorer,				-- "Providing Armor Afield"
	[8319] = Armorer,				-- "Striking Platinum"
	[8320] = Armorer,				-- "It Won't Ever Rust"
	[8321] = Armorer,				-- "Platinum P.I."
	[8301] = Armorer,				-- "Plat On Your Back"
	[8302] = Armorer,				-- "Heart of Platinum"
	[8303] = Armorer,				-- "Good as Platinum"

	-- Tradeskills - Crafting Vouchers - Weaponsmith
	[5171] = Weaponsmith,				-- "Keeping It Steel"
	[5178] = Weaponsmith,				-- "Class V Logistics: Weapons"
	[5209] = Weaponsmith,				-- "Steel Weapons Contract: Algoroc"
	[7241] = Weaponsmith,				-- "Arms for Arboria"
	[7242] = Weaponsmith,				-- "Arms for The XAS"
	[7243] = Weaponsmith,				-- "Arms for the Exiles"
	[7244] = Weaponsmith,				-- "Helping the Hunters"
	[7245] = Weaponsmith,				-- "Monkey Mayhem"
	[7246] = Weaponsmith,				-- "Keys to the Empire"
	[7247] = Weaponsmith,				-- "Wild Arms"
	[7248] = Weaponsmith,				-- "A Legion's Need"
	[7249] = Weaponsmith,				-- "Looking Past the Wilds"
	[8280] = Weaponsmith,				-- "Silver Linings"
	[8281] = Weaponsmith,				-- "Platinum If You Got 'Em"
	[8282] = Weaponsmith,				-- "Comfortably Platinum"
	[8205] = Weaponsmith,				-- "You Platinum, You Bought 'Em"
	[8206] = Weaponsmith,				-- "Platinum Crisis"
	[8207] = Weaponsmith,				-- "A Heart of Platinum"
	[9225] = Weaponsmith,				-- "Battle-Strain Galactium"
	[9226] = Weaponsmith,				-- "The Weaponsmith's Guide to Galactium"
	[9228] = Weaponsmith,				-- "Galactium-Grade Firepower"
	[9213] = Weaponsmith,				-- "Battle-Strain Galactium"
	[9214] = Weaponsmith,				-- "The Weaponsmith's Guide to Galactium"
	[9215] = Weaponsmith,				-- "Galactium-Grade Firepower"
	[7250] = Weaponsmith,				-- "Do As I Ask"
	[7251] = Weaponsmith,				-- "There Is No Try"
	[7252] = Weaponsmith,				-- "The Tools of the Empire"
	[8416] = Weaponsmith,				-- "At First Xenocite"
	[8417] = Weaponsmith,				-- "Xenocite Package"
	[8418] = Weaponsmith,				-- "Xenocite Fight"
	[8334] = Weaponsmith,				-- "At First Xenocite"
	[8335] = Weaponsmith,				-- "Xenocite Package"
	[8337] = Weaponsmith,				-- "Xenocite Fight"
	[5240] = Weaponsmith,				-- "A Vendor in Need"
	[5241] = Weaponsmith,				-- "Coordinating for Shortfalls"
	[5242] = Weaponsmith,				-- "High Expectations"
	[7256] = Weaponsmith,				-- "Mighty Metal"
	[7257] = Weaponsmith,				-- "Blood and Titanium"
	[7258] = Weaponsmith,				-- "Staying on Target"
	[7253] = Weaponsmith,				-- "Titanium Shaper"
	[7254] = Weaponsmith,				-- "Titanium Weapons"
	[7255] = Weaponsmith,				-- "Forging Forward"
	[8316] = Weaponsmith,				-- "You Platinum, You Bought 'Em"
	[8317] = Weaponsmith,				-- "Platinum Crisis"
	[8318] = Weaponsmith,				-- "A Heart of Platinum"
	[8298] = Weaponsmith,				-- "Silver Linings"
	[8299] = Weaponsmith,				-- "Platinum If You Got 'Em"
	[8300] = Weaponsmith,				-- "Comfortably Platinum"

	-- Tradeskills - Crafting Vouchers - Technologist
	[6097] = Technologist,				-- "Medishot Madness"
	[6098] = Technologist,				-- "Class VIII Logistics: Medical Supplies"
	[6099] = Technologist,				-- "Medical Supply Contract: Algoroc"
	[7310] = Technologist,				-- "Fruit of the Spirovine"
	[7311] = Technologist,				-- "Frontier Medicine"
	[7312] = Technologist,				-- "Club Meds"
	[7313] = Technologist,				-- "The Legend of Spirovine"
	[7314] = Technologist,				-- "Medical Herbology"
	[7315] = Technologist,				-- "Get Medicated"
	[7316] = Technologist,				-- "Through the Spirovine"
	[7317] = Technologist,				-- "Making Medicine"
	[7318] = Technologist,				-- "Herbal Shots"
	[8292] = Technologist,				-- "Scaling Up"
	[8293] = Technologist,				-- "Coralscale Values"
	[8294] = Technologist,				-- "Coral History"
	[8274] = Technologist,				-- "Shot Caller"
	[8275] = Technologist,				-- "Sending Priority Coralscale"
	[8276] = Technologist,				-- "Give It Your Best Medishot"
	[9242] = Technologist,				-- "A Quick Shot of Mourningstar"
	[9243] = Technologist,				-- "Mourningstar Medispray"
	[9244] = Technologist,				-- "A Mourningstar Restorative"
	[9249] = Technologist,				-- "A Quick Shot of Mourningstar"
	[9250] = Technologist,				-- "Mourning Medispray"
	[9251] = Technologist,				-- "A Mourningstar Restorative"
	[7319] = Technologist,				-- "Laced with Serpentlily"
	[7320] = Technologist,				-- "A Shot of Something Good"
	[7321] = Technologist,				-- "Dedicated and Medicated"
	[8428] = Technologist,				-- "Fruit of the Faerybloom"
	[8429] = Technologist,				-- "Mixing It Up"
	[8430] = Technologist,				-- "The Purest of Omni-Plasm"
	[8347] = Technologist,				-- "Fruit of the Faerybloom"
	[8348] = Technologist,				-- "Mixing It Up"
	[8349] = Technologist,				-- "The Purest of Omni-Plasm"
	[6114] = Technologist,				-- "How Stimulating"
	[6115] = Technologist,				-- "Two Medishots a Day"
	[6116] = Technologist,				-- "Shotdoctor"
	[7325] = Technologist,				-- "Serpentlilies of the Field"
	[7326] = Technologist,				-- "Talking Shot"
	[7327] = Technologist,				-- "Long-Distance Medication"
	[7322] = Technologist,				-- "Secrets of the Serpentlily"
	[7323] = Technologist,				-- "Somebody Get Me a Shot"
	[7324] = Technologist,				-- "Better Keep 'Em Medicated"
	[8328] = Technologist,				-- "Shot Caller"
	[8329] = Technologist,				-- "Sending Priority Coralscale"
	[8330] = Technologist,				-- "Give It your Best Medishot"
	[8310] = Technologist,				-- "Scaling Up"
	[8311] = Technologist,				-- "Coralscale Values"
	[8312] = Technologist,				-- "Coral History"

	-- Tradeskills - Crafting Vouchers - Tailor
	[5996] = Tailor,				-- "Rugged and Ready"
	[5999] = Tailor,				-- "Class V Logistics: Light Armor"
	[6002] = Tailor,				-- "Canvas Armor Contract: Algoroc"
	[7292] = Tailor,				-- "Canvas for Support"
	[7293] = Tailor,				-- "Catch as Catch Canvas"
	[7294] = Tailor,				-- "The Grand Canvas"
	[7295] = Tailor,				-- "Canvas Ain't Easy"
	[7296] = Tailor,				-- "Catch Me If You Canvas"
	[7297] = Tailor,				-- "Yes, We Canvas"
	[7298] = Tailor,				-- "Can You Canvas?"
	[7299] = Tailor,				-- "Blank Canvas"
	[7300] = Tailor,				-- "The Canvas Man Can"
	[8289] = Tailor,				-- "Retaining Whimfiber"
	[8290] = Tailor,				-- "An Allowance of Fiber"
	[8291] = Tailor,				-- "One Hundred Percent Whimfiber"
	[8229] = Tailor,				-- "Threading On a Whim"
	[8230] = Tailor,				-- "Filled to the Whim"
	[8231] = Tailor,				-- "Four Sheets to the Whim"
	[9239] = Tailor,				-- "Starting with Starloom"
	[9240] = Tailor,				-- "Tailored on a Starloom"
	[9241] = Tailor,				-- "Reach for the Starloom"
	[9222] = Tailor,				-- "Wish Upon a Starloom"
	[9223] = Tailor,				-- "Wishin' on a Starloom"
	[9224] = Tailor,				-- "Reach for the Starloom"
	[7301] = Tailor,				-- "Follow the Silk Road"
	[7302] = Tailor,				-- "You're Really Silking It"
	[7303] = Tailor,				-- "Silk Really Suits You"
	[8425] = Tailor,				-- "Terminal Manaweave"
	[8426] = Tailor,				-- "Weaving In and Out of Focus"
	[8427] = Tailor,				-- "Moxie Magnification"
	[8344] = Tailor,				-- "Terminal Manaweave"
	[8345] = Tailor,				-- "Weaving In and Out of Focus"
	[8346] = Tailor,				-- "Moxie Magnification"
	[6022] = Tailor,				-- "Custom Tailored"
	[6023] = Tailor,				-- "Tailor to Communicate"
	[6024] = Tailor,				-- "Hot Cup of Tailor"
	[7307] = Tailor,				-- "The Road to Silk"
	[7308] = Tailor,				-- "Silking It for All It's Worth"
	[7309] = Tailor,				-- "Silk-Suited"
	[7304] = Tailor,				-- "Shear Silk"
	[7305] = Tailor,				-- "Silk Stalking"
	[7306] = Tailor,				-- "Of the Finest Silk"
	[8325] = Tailor,				-- "Threading on a Whim"
	[8326] = Tailor,				-- "Filled to the Whim"
	[8327] = Tailor,				-- "Four Sheets to the Whim"
	[8307] = Tailor,				-- "Retaining Whimfiber"
	[8308] = Tailor,				-- "An Allowance of Fiber"
	[8308] = Tailor,				-- "100% Whimfiber"

	-- Tradeskills - Crafting Vouchers - Architect
	[6107] = Architect,				-- "Architectural Aptitude"
	[6108] = Architect,				-- "Bramble Basics"
	[6109] = Architect,				-- "Housing Supply Contract: Algoroc"
	[7642] = Architect,				-- "Feeding Time"
	[7643] = Architect,				-- "Bramble Blast"
	[7644] = Architect,				-- "Picket Fences"
	[7645] = Architect,				-- "Metal Heads"
	[7646] = Architect,				-- "Bramble Blast"
	[7647] = Architect,				-- "Practical Architecture"
	[7648] = Architect,				-- "An Assessment of Ability"
	[7649] = Architect,				-- "Bramble Ramble"
	[7650] = Architect,				-- "Fenced In"
	[8295] = Architect,				-- "Pillow Talk"
	[8296] = Architect,				-- "Generator Interest"
	[8297] = Architect,				-- "Pumped Up!"
	[8277] = Architect,				-- "Purple-Star-Pillow-Piler"
	[8278] = Architect,				-- "Generator Interest"
	[8279] = Architect,				-- "Get Pumped!"
	[9245] = Architect,				-- "Tiki Torches"
	[9246] = Architect,				-- "Nautical Wheel"
	[9247] = Architect,				-- "Freebot Surge Protector"
	[9252] = Architect,				-- "Tiki Torches"
	[9253] = Architect,				-- "Nautical Wheel"
	[9254] = Architect,				-- "Freebot Surge Protector"
	[8540] = Architect,				-- "In Glad Company"
	[8541] = Architect,				-- "The Architect's Burden"
	[8542] = Architect,				-- "Torch Lights"
	[8432] = Architect,				-- "Eye Spy a Camera"
	[8433] = Architect,				-- "Table This for Now"
	[8431] = Architect,				-- "Shiny Storage"
	[8350] = Architect,				-- "Shiny Storage"
	[8351] = Architect,				-- "Eye Spy a Camera"
	[8352] = Architect,				-- "Table This for Now"
	[6123] = Architect,				-- "Local Architecture"
	[6124] = Architect,				-- "Crate Expectations"
	[6125] = Architect,				-- "Firestarter"
	[9431] = Architect,				-- "Whitevale Traction"
	[9432] = Architect,				-- "It's a Trap"
	[9433] = Architect,				-- "I Love Lamp"
	[9391] = Architect,				-- "Whitevale Traction"
	[9392] = Architect,				-- "It's a Trap"
	[9429] = Architect,				-- "I Love Lamp"
	[8331] = Architect,				-- "Locker Stocker"
	[8332] = Architect,				-- "A Place to Lay One's Cards"
	[8333] = Architect,				-- "The Great Divider"
	[8313] = Architect,				-- "Ready, Set, Locker"
	[8314] = Architect,				-- "Fancy Dresser"
	[8315] = Architect,				-- "The Great Divider"
}

-- This is used to check whether it's a Crafting Voucher quest when not discovered
-- Key = ID, Value = Tradeskill enum value.
WTD.QuestCraftingVouchersExtensions = {
	-- Tradeskills - Crafting Vouchers - Outfitter
	[5983] = true,				-- "How's the Leather?"
	[5986] = true,				-- "Class V Logistics: Medium Armor"
	[5990] = true,				-- "Medium Armor Contract: Algoroc"
	[7271] = true,				-- "The Look and Feel of Hand-Tooled Leather"
	[7272] = true,				-- "Fine Celestion Leather"
	[7273] = true,				-- "Leatherweight Champ"
	[7274] = true,				-- "Fine Leathered Friend"
	[7275] = true,				-- "Leatherweight Champions"
	[7276] = true,				-- "Fine Cassian Leather"
	[7277] = true,				-- "About the Leather"
	[7278] = true,				-- "Leather of Intent"
	[7279] = true,				-- "To the Leather"
	[8286] = true,				-- "Lovely Leather, Isn't It?"
	[8287] = true,				-- "Forester's Delight"
	[8288] = true,				-- "Take Them to the Foresters"
	[8226] = true,				-- "You Can Do Leather, If You Try"
	[8227] = true,				-- "Gotta Get That Leather, Man"
	[8228] = true,				-- "Never Say Leather"
	[9236] = true,				-- "Isigrol-Bent for Leather"
	[9237] = true,				-- "Augmented Leather Hunters"
	[9238] = true,				-- "Ultimate Augmented Leather"
	[9219] = true,				-- "Isigrol-Bent for Leather"
	[9220] = true,				-- "Tempered Leather Hunters"
	[9221] = true,				-- "Ultimate Augmented Leather Hunters"
	[7283] = true,				-- "Leather Report"
	[7284] = true,				-- "Full Leather Jacket"
	[7285] = true,				-- "Leather or Not...."
	[8422] = true,				-- "Big Game Hunter's Armor"
	[8423] = true,				-- "Leather Hunters"
	[8424] = true,				-- "Hard as Rockhide"
	[8432] = true,				-- "Eye Spy a Camera"
	[8341] = true,				-- "Big Game Hunter's Armor"
	[8342] = true,				-- "Leather Hunters"
	[8343] = true,				-- "Hard as Rockhide"
	[7280] = true,				-- "Getting Back to Leather"
	[7281] = true,				-- "Stormy Leather"
	[7282] = true,				-- "A Man of Leathers"
	[7289] = true,				-- "Getting Back to Leather"
	[7290] = true,				-- "Stormy Leather"
	[7291] = true,				-- "A Man of Leathers"
	[7286] = true,				-- "Leather Bound"
	[7287] = true,				-- "The Leather Regions"
	[7288] = true,				-- "Hell-Bent for Leather"
	[8322] = true,				-- "You Can Do Leather, If You Try"
	[8323] = true,				-- "Gotta Get That Leather, Man"
	[8324] = true,				-- "Never Say Leather"
	[8304] = true,				-- "Lovely Leather, Isn't It?"
	[8305] = true,				-- "Forester's Delight"
	[8306] = true,				-- "Take Them to the Foresters"

	-- Tradeskills - Crafting Vouchers - Armorer
	[5774] = true,				-- "Steel Your Heart"
	[5779] = true,				-- "Class V Logistics: Steel Weave Armor"
	[5782] = true,				-- "Steel Armor Contract: Algoroc"
	[7259] = true,				-- "Steel Yourself Exile"
	[7260] = true,				-- "Beg, Borrow, and Steel"
	[7261] = true,				-- "Steel Crazy After All These Years"
	[7262] = true,				-- "Steel of Approval"
	[7263] = true,				-- "Gladiatorial Intentions"
	[7264] = true,				-- "The Art of the Steel"
	[7265] = true,				-- "Timing and Steeling"
	[7266] = true,				-- "Steel's the One"
	[7267] = true,				-- "Cold, Hard Steel"
	[8283] = true,				-- "Plat On Your Back"
	[8284] = true,				-- "Heart of Platinum"
	[8285] = true,				-- "Good as Platinum"
	[8223] = true,				-- "Striking Platinum"
	[8224] = true,				-- "It Won't Ever Rust"
	[8225] = true,				-- "Platinum P.I."
	[9233] = true,				-- "Getting Started with Galacium"
	[9234] = true,				-- "The Armorer's Guide to Galactium"
	[9235] = true,				-- "Galactium-Grade Stopping Power"
	[9216] = true,				-- "Guardians of Galacium"
	[9217] = true,				-- "The Armorer's Guide to Galactium"
	[9218] = true,				-- "Galactium-Grade Stopping Power"
	[7268] = true,				-- "Titanium? I Just Met 'Em!"
	[7269] = true,				-- "Raise the Titanium"
	[7270] = true,				-- "In Titanium We Trust"
	[8419] = true,				-- "Legionnaire in Glowing Armor"
	[8420] = true,				-- "Powered by Xenocite"
	[8421] = true,				-- "Heavy Xenocite Plate"
	[8338] = true,				-- "Knight In Glowing Armor"
	[8339] = true,				-- "Powered by Xenocite"
	[8340] = true,				-- "Heavy Xenocite Plate"
	[6381] = true,				-- "Titanium for All"
	[6382] = true,				-- "A Titanic Effort"
	[6383] = true,				-- "Titanium Protoweaving"
	[7236] = true,				-- "Proud Titanium"
	[7237] = true,				-- "A Titanic Sheet"
	[7238] = true,				-- "Titanium of War"
	[6216] = true,				-- "Titanium on My Mind"
	[6217] = true,				-- "The Titanium Special"
	[6218] = true,				-- "Providing Armor Afield"
	[8319] = true,				-- "Striking Platinum"
	[8320] = true,				-- "It Won't Ever Rust"
	[8321] = true,				-- "Platinum P.I."
	[8301] = true,				-- "Plat On Your Back"
	[8302] = true,				-- "Heart of Platinum"
	[8303] = true,				-- "Good as Platinum"

	-- Tradeskills - Crafting Vouchers - Weaponsmith
	[5171] = true,				-- "Keeping It Steel"
	[5178] = true,				-- "Class V Logistics: Weapons"
	[5209] = true,				-- "Steel Weapons Contract: Algoroc"
	[7241] = true,				-- "Arms for Arboria"
	[7242] = true,				-- "Arms for The XAS"
	[7243] = true,				-- "Arms for the Exiles"
	[7244] = true,				-- "Helping the Hunters"
	[7245] = true,				-- "Monkey Mayhem"
	[7246] = true,				-- "Keys to the Empire"
	[7247] = true,				-- "Wild Arms"
	[7248] = true,				-- "A Legion's Need"
	[7249] = true,				-- "Looking Past the Wilds"
	[8280] = true,				-- "Silver Linings"
	[8281] = true,				-- "Platinum If You Got 'Em"
	[8282] = true,				-- "Comfortably Platinum"
	[8205] = true,				-- "You Platinum, You Bought 'Em"
	[8206] = true,				-- "Platinum Crisis"
	[8207] = true,				-- "A Heart of Platinum"
	[9225] = true,				-- "Battle-Strain Galactium"
	[9226] = true,				-- "The Weaponsmith's Guide to Galactium"
	[9228] = true,				-- "Galactium-Grade Firepower"
	[9213] = true,				-- "Battle-Strain Galactium"
	[9214] = true,				-- "The Weaponsmith's Guide to Galactium"
	[9215] = true,				-- "Galactium-Grade Firepower"
	[7250] = true,				-- "Do As I Ask"
	[7251] = true,				-- "There Is No Try"
	[7252] = true,				-- "The Tools of the Empire"
	[8416] = true,				-- "At First Xenocite"
	[8417] = true,				-- "Xenocite Package"
	[8418] = true,				-- "Xenocite Fight"
	[8334] = true,				-- "At First Xenocite"
	[8335] = true,				-- "Xenocite Package"
	[8337] = true,				-- "Xenocite Fight"
	[5240] = true,				-- "A Vendor in Need"
	[5241] = true,				-- "Coordinating for Shortfalls"
	[5242] = true,				-- "High Expectations"
	[7256] = true,				-- "Mighty Metal"
	[7257] = true,				-- "Blood and Titanium"
	[7258] = true,				-- "Staying on Target"
	[7253] = true,				-- "Titanium Shaper"
	[7254] = true,				-- "Titanium Weapons"
	[7255] = true,				-- "Forging Forward"
	[8316] = true,				-- "You Platinum, You Bought 'Em"
	[8317] = true,				-- "Platinum Crisis"
	[8318] = true,				-- "A Heart of Platinum"
	[8298] = true,				-- "Silver Linings"
	[8299] = true,				-- "Platinum If You Got 'Em"
	[8300] = true,				-- "Comfortably Platinum"

	-- Tradeskills - Crafting Vouchers - Technologist
	[6097] = true,				-- "Medishot Madness"
	[6098] = true,				-- "Class VIII Logistics: Medical Supplies"
	[6099] = true,				-- "Medical Supply Contract: Algoroc"
	[7310] = true,				-- "Fruit of the Spirovine"
	[7311] = true,				-- "Frontier Medicine"
	[7312] = true,				-- "Club Meds"
	[7313] = true,				-- "The Legend of Spirovine"
	[7314] = true,				-- "Medical Herbology"
	[7315] = true,				-- "Get Medicated"
	[7316] = true,				-- "Through the Spirovine"
	[7317] = true,				-- "Making Medicine"
	[7318] = true,				-- "Herbal Shots"
	[8292] = true,				-- "Scaling Up"
	[8293] = true,				-- "Coralscale Values"
	[8294] = true,				-- "Coral History"
	[8274] = true,				-- "Shot Caller"
	[8275] = true,				-- "Sending Priority Coralscale"
	[8276] = true,				-- "Give It Your Best Medishot"
	[9242] = true,				-- "A Quick Shot of Mourningstar"
	[9243] = true,				-- "Mourningstar Medispray"
	[9244] = true,				-- "A Mourningstar Restorative"
	[9249] = true,				-- "A Quick Shot of Mourningstar"
	[9250] = true,				-- "Mourning Medispray"
	[9251] = true,				-- "A Mourningstar Restorative"
	[7319] = true,				-- "Laced with Serpentlily"
	[7320] = true,				-- "A Shot of Something Good"
	[7321] = true,				-- "Dedicated and Medicated"
	[8428] = true,				-- "Fruit of the Faerybloom"
	[8429] = true,				-- "Mixing It Up"
	[8430] = true,				-- "The Purest of Omni-Plasm"
	[8347] = true,				-- "Fruit of the Faerybloom"
	[8348] = true,				-- "Mixing It Up"
	[8349] = true,				-- "The Purest of Omni-Plasm"
	[6114] = true,				-- "How Stimulating"
	[6115] = true,				-- "Two Medishots a Day"
	[6116] = true,				-- "Shotdoctor"
	[7325] = true,				-- "Serpentlilies of the Field"
	[7326] = true,				-- "Talking Shot"
	[7327] = true,				-- "Long-Distance Medication"
	[7322] = true,				-- "Secrets of the Serpentlily"
	[7323] = true,				-- "Somebody Get Me a Shot"
	[7324] = true,				-- "Better Keep 'Em Medicated"
	[8328] = true,				-- "Shot Caller"
	[8329] = true,				-- "Sending Priority Coralscale"
	[8330] = true,				-- "Give It your Best Medishot"
	[8310] = true,				-- "Scaling Up"
	[8311] = true,				-- "Coralscale Values"
	[8312] = true,				-- "Coral History"

	-- Tradeskills - Crafting Vouchers - Tailor
	[5996] = true,				-- "Rugged and Ready"
	[5999] = true,				-- "Class V Logistics: Light Armor"
	[6002] = true,				-- "Canvas Armor Contract: Algoroc"
	[7292] = true,				-- "Canvas for Support"
	[7293] = true,				-- "Catch as Catch Canvas"
	[7294] = true,				-- "The Grand Canvas"
	[7295] = true,				-- "Canvas Ain't Easy"
	[7296] = true,				-- "Catch Me If You Canvas"
	[7297] = true,				-- "Yes, We Canvas"
	[7298] = true,				-- "Can You Canvas?"
	[7299] = true,				-- "Blank Canvas"
	[7300] = true,				-- "The Canvas Man Can"
	[8289] = true,				-- "Retaining Whimfiber"
	[8290] = true,				-- "An Allowance of Fiber"
	[8291] = true,				-- "One Hundred Percent Whimfiber"
	[8229] = true,				-- "Threading On a Whim"
	[8230] = true,				-- "Filled to the Whim"
	[8231] = true,				-- "Four Sheets to the Whim"
	[9239] = true,				-- "Starting with Starloom"
	[9240] = true,				-- "Tailored on a Starloom"
	[9241] = true,				-- "Reach for the Starloom"
	[9222] = true,				-- "Wish Upon a Starloom"
	[9223] = true,				-- "Wishin' on a Starloom"
	[9224] = true,				-- "Reach for the Starloom"
	[7301] = true,				-- "Follow the Silk Road"
	[7302] = true,				-- "You're Really Silking It"
	[7303] = true,				-- "Silk Really Suits You"
	[8425] = true,				-- "Terminal Manaweave"
	[8426] = true,				-- "Weaving In and Out of Focus"
	[8427] = true,				-- "Moxie Magnification"
	[8344] = true,				-- "Terminal Manaweave"
	[8345] = true,				-- "Weaving In and Out of Focus"
	[8346] = true,				-- "Moxie Magnification"
	[6022] = true,				-- "Custom Tailored"
	[6023] = true,				-- "Tailor to Communicate"
	[6024] = true,				-- "Hot Cup of Tailor"
	[7307] = true,				-- "The Road to Silk"
	[7308] = true,				-- "Silking It for All It's Worth"
	[7309] = true,				-- "Silk-Suited"
	[7304] = true,				-- "Shear Silk"
	[7305] = true,				-- "Silk Stalking"
	[7306] = true,				-- "Of the Finest Silk"
	[8325] = true,				-- "Threading on a Whim"
	[8326] = true,				-- "Filled to the Whim"
	[8327] = true,				-- "Four Sheets to the Whim"
	[8307] = true,				-- "Retaining Whimfiber"
	[8308] = true,				-- "An Allowance of Fiber"
	[8308] = true,				-- "100% Whimfiber"

	-- Tradeskills - Crafting Vouchers - Architect
	[6107] = true,				-- "Architectural Aptitude"
	[6108] = true,				-- "Bramble Basics"
	[6109] = true,				-- "Housing Supply Contract: Algoroc"
	[7642] = true,				-- "Feeding Time"
	[7643] = true,				-- "Bramble Blast"
	[7644] = true,				-- "Picket Fences"
	[7645] = true,				-- "Metal Heads"
	[7646] = true,				-- "Bramble Blast"
	[7647] = true,				-- "Practical Architecture"
	[7648] = true,				-- "An Assessment of Ability"
	[7649] = true,				-- "Bramble Ramble"
	[7650] = true,				-- "Fenced In"
	[8295] = true,				-- "Pillow Talk"
	[8296] = true,				-- "Generator Interest"
	[8297] = true,				-- "Pumped Up!"
	[8277] = true,				-- "Purple-Star-Pillow-Piler"
	[8278] = true,				-- "Generator Interest"
	[8279] = true,				-- "Get Pumped!"
	[9245] = true,				-- "Tiki Torches"
	[9246] = true,				-- "Nautical Wheel"
	[9247] = true,				-- "Freebot Surge Protector"
	[9252] = true,				-- "Tiki Torches"
	[9253] = true,				-- "Nautical Wheel"
	[9254] = true,				-- "Freebot Surge Protector"
	[8540] = true,				-- "In Glad Company"
	[8541] = true,				-- "The Architect's Burden"
	[8542] = true,				-- "Torch Lights"
	[8432] = true,				-- "Eye Spy a Camera"
	[8433] = true,				-- "Table This for Now"
	[8431] = true,				-- "Shiny Storage"
	[8350] = true,				-- "Shiny Storage"
	[8351] = true,				-- "Eye Spy a Camera"
	[8352] = true,				-- "Table This for Now"
	[6123] = true,				-- "Local Architecture"
	[6124] = true,				-- "Crate Expectations"
	[6125] = true,				-- "Firestarter"
	[9431] = true,				-- "Whitevale Traction"
	[9432] = true,				-- "It's a Trap"
	[9433] = true,				-- "I Love Lamp"
	[9391] = true,				-- "Whitevale Traction"
	[9392] = true,				-- "It's a Trap"
	[9429] = true,				-- "I Love Lamp"
	[8331] = true,				-- "Locker Stocker"
	[8332] = true,				-- "A Place to Lay One's Cards"
	[8333] = true,				-- "The Great Divider"
	[8313] = true,				-- "Ready, Set, Locker"
	[8314] = true,				-- "Fancy Dresser"
	[8315] = true,				-- "The Great Divider"
}

-- This is used to add daily quests which award no rep.
-- Key = ID, Value = Faction name.
WTD.QuestNoRepExtensions = {
	-- Northern Wastes
	[7070] = "MISSION: Northern Wastes", [7071] = "MISSION: Northern Wastes",	-- "Icy Enlightenment"
	[7068] = "MISSION: Northern Wastes", [7069] = "MISSION: Northern Wastes",	-- "Frozen Dinners"
	[7094] = "MISSION: Northern Wastes", [7093] = "MISSION: Northern Wastes",	-- "Stocking Up"
}

