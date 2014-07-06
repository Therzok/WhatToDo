--[[
	TODO: UI for 'finishing' quests.
]]
require "CraftingLib"
require "GameLib"
require "Money"
require "PlayerPathLib"
require "Quest"
require "os"
require "table"

local Debug

local WhatToDo = Apollo.GetPackage("Gemini:Addon-1.1").tPackage:NewAddon("WhatToDo", false, {})
local GeminiGUI

local QuestDaily = 63
local QuestTradeskill = 53

local QuestDailyPath = 12

local cOnlyDiscovered
local cVouchers
local cNoRepWhenMax

local function clone(t) -- deep-copy a table
	if type(t) ~= "table" then return t end
	local meta = getmetatable(t)
	local target = {}
	for k, v in pairs(t) do
		if type(v) == "table" then
			target[k] = clone(v)
		else
			target[k] = v
		end
	end
	setmetatable(target, meta)
	return target
end

local function lastReset()
	local stamp = os.date("!*t")	-- This is the UTC time.
	return stamp.hour >= 10 and stamp.yday or stamp.yday - 1
end

function WhatToDo:ResetDailies()
	self.cfg = {
		last = lastReset(),
		version = self.QuestDataVersion
	}
	self:DigQuests()
end

function WhatToDo:DigQuests()
	self.cfg.dailies = {}
	
	local function createTableItem(category, queQuest)
		if not self.cfg.dailies[category] then self.cfg.dailies[category] = {} end
		local iId = queQuest:GetId()
		self.cfg.dailies[category][iId] = {
			Name = (not self.QuestWhitelist[iId] and "[NEW] " or "") .. (self.QuestZoneExtensions[iId] or "") .. queQuest:GetTitle(),
			Path = self.QuestPathExtensions[iId],
			Tradeskill = self.QuestTradeskillExtensions[iId],
			Whitelisted = self.QuestWhitelist[iId],
			Id = iId
		}
	end
	
	local function storeRelevant(v)
		for _, rew in pairs(v:GetRewardData().arFixedRewards) do
			local category
			if rew.eType == Quest.Quest2RewardType_Reputation then -- Reputation
				category = rew.strFactionName
			elseif rew.eType == Quest.Quest2RewardType_Money and rew.eCurrencyType == Money.CodeEnumCurrencyType.CraftingVouchers and
					v:GetType() == 5 and v:GetSubType() ~= 0 then -- Crafting Vouchers
				category = "Tradeskills - Crafting Vouchers" 
			elseif rew.eType == Quest.Quest2RewardType_Item and rew.itemReward:GetItemId() == 28282 and
					v:GetType() == 5 and v:GetSubType() ~= 0 then -- Daily Data Ration
				category = "Tradeskills - Daily Data Ration"
			end
			if category then createTableItem(category, v) end
		end
	end
	
	for _, qcCategory in pairs(QuestLib.GetKnownCategories()) do
		if qcCategory:GetId() == QuestDaily or qcCategory:GetId() == QuestTradeskill then
			for _, epiEpisode in pairs(qcCategory:GetEpisodes()) do
				if not epiEpisode:IsWorldStory() and not epiEpisode:IsZoneStory() and not epiEpisode:IsRegionalStory() then
					for _, queQuest in pairs(epiEpisode:GetAllQuests(qcCategory:GetId())) do
						storeRelevant(queQuest)
					end
				end
			end
		end
	end
end

function WhatToDo:PurgeInvalid()
	local player = GameLib.GetPlayerUnit()
	local playerPath = player:GetPlayerPathType()
	local playerFaction = player:GetFaction()
	local playerTradeskills = {}
	for _, tTradeskill in ipairs(CraftingLib.GetKnownTradeskills()) do
		local tInfo = CraftingLib.GetTradeskillInfo(tTradeskill.eId)
		playerTradeskills[tTradeskill.eId] = tInfo.bIsActive
	end

	local newDailies = {}
	for k1, v1 in pairs(self.cfg.dailies) do
		local newList = {}
		for _, v2 in pairs(v1) do
			if (not v2.Path or v2.Path == playerPath) and 				-- Check path requirement.
				(not v2.Faction or v2.Faction == playerFaction) and		-- Check faction requirement.
				(not v2.Tradeskill or playerTradeskills[v2.Tradeskill]) -- Check tradeskills.
			then
				table.insert(newList, v2)
			end
		end

		if #newList ~= 0 then newDailies[k1] = newList end
	end

	self.cfg.dailies = newDailies
end

function WhatToDo:OnInitialize()
	-- Get dependency packages.
	GeminiGUI = Apollo.GetPackage("Gemini:GUI-1.0").tPackage

	-- Register slash.
	Apollo.RegisterSlashCommand("wtd", "OnWhatToDoOn", self)
	Apollo.RegisterSlashCommand("whattodo", "OnWhatToDoOn", self)
	Apollo.RegisterSlashCommand("wtdf", "OnWhatToDoFinish", self)

	self.cfg = {}
end

function WhatToDo:OnSave(eLevel)
	if eLevel ~= GameLib.CodeEnumAddonSaveLevel.Character then return nil end
	return self.cfg
end

function WhatToDo:OnRestore(eLevel, tData)
	if eLevel ~= GameLib.CodeEnumAddonSaveLevel.Character then return nil end

	self.cfg = clone(tData)

	-- Test if we're over a daily cycle since last login.
	if self.cfg.last ~= lastReset() or self.cfg.version ~= self.QuestDataVersion then
		self:ResetDailies()
	end
end

function WhatToDo:OnEnable()
	-- Register event for quest completion
	Apollo.RegisterEventHandler("QuestStateChanged", "OnQuestStateChanged", self)

	-- Fix tradeskills changing quests. TradeskillLearnedFromTHOR
	-- Register events for levelup when adding minLevel support.
	
	self:PurgeInvalid()
end

function WhatToDo:OnDisable()
	Apollo.RemoveEventHandler("QuestStateChanged", self)
end

-- Track quest completion.
function WhatToDo:OnQuestStateChanged(queUpdated, eState)
	if eState == Quest.QuestState_Accepted then
		if Debug then Print("Accepted [" .. queUpdated:GetId() .. "]: " .. queUpdated:GetTitle()) end
	elseif eState == Quest.QuestState_Completed then
		if Debug then Print("Completed [" .. queUpdated:GetId() .. "]: " .. queUpdated:GetTitle()) end
		self:FinishQuest(queUpdated:GetId())
	end
end

-- Remove the quest from the dailies list.
function WhatToDo:FinishQuest(iQuestId)
	local zone, index
	for k1, v1 in pairs(self.cfg.dailies) do
		for k2, v2 in pairs(v1) do
			if v2.Id == iQuestId then
				zone, index = k1, k2
				break
			end
		end
	end

	if not zone or not index then return end

	table.remove(self.cfg.dailies[zone], index)
	if #self.cfg.dailies[zone] == 0 then
		self.cfg.dailies[zone] = nil
	end

	self:RedrawTree()
end

-- Tree with items construction.
local function CreateTree()
	return { -- Tree Control
		Name			= "QuestTree",
		WidgetType		= "TreeControl",
		AnchorPoints	= "FILL", -- will be translated to { 0, 0, 1, 1 }
		VScroll			= true,
		Events			= {
			WindowLoad = function(self, wndHandler, wndControl)
				local items = false
				for k, v in pairs(self.cfg.dailies) do
					items = true

					local hParent = 0
					hParent = wndControl:AddNode(hParent, k)
					for k2, v2 in pairs(v) do
						local displayName = Debug and v2.Name .. " [" .. v2.Id .. "]" or v2.Name
						wndControl:AddNode(hParent, displayName)
					end
				end
				if not items then
					wndControl:AddNode(0, "You've already done everything today. Congratulations.")
				end
			end
		}
	}
end

-- Redraws the tree.
function WhatToDo:RedrawTree()
	if not self.wndMain then return end

	local container = self.wndMain:FindChild("QuestWidgetContainer")
	container:DestroyChildren()
	GeminiGUI:Create(CreateTree()):GetInstance(self, container)
end

-- On SlashCommand "/wtdf"
function WhatToDo:OnWhatToDoFinish(strCmd, strArg)
	self:FinishQuest(tonumber(strArg))
end

-- on SlashCommand "/wtd"
function WhatToDo:OnWhatToDoOn()
	if self.wndMain then return end

	local tWndDefinition = {
		Name			= "WhatToDoWindow",
		Template		= "CRB_TooltipSimple",
		UseTemplateBG	= true,
		Picture			= false,
		Moveable		= true,
		Border			= true,
		AnchorCenter	= {500, 460},
		Escapable		= true,

		Pixies = {
			{
				Line			= true,
				AnchorPoints	= "HFILL", -- will be translated to {0,0,1,0},
				AnchorOffsets	= {0,30,0,30},
				Color			= "white",
			},
			{
				Text			= "What To Do - Daily Tracker",
				Font			= "CRB_HeaderHuge",
				TextColor		= "xkcdYellow",
				AnchorPoints	= "HFILL",
				DT_CENTER		= true,
				DT_VCENTER		= true,
				AnchorOffsets	= {0,0,0,20},
			},
		},

		Children = {
			{
				WidgetType		= "PushButton",
				AnchorPoints	= "TOPRIGHT", -- will be translated to { 1, 0, 1, 0 }
				AnchorOffsets	= { -17, -3, 3, 17 },
				Base			= "CRB_Basekit:kitBtn_Holo_Close",
				NoClip			= true,
				Events			= { ButtonSignal = function(_, wndHandler, wndControl) wndControl:GetParent():Close() end, },
			},
			{ 
				Name			= "QuestWidgetContainer", 
				AnchorPoints	= "FILL", -- will be translated to { 0, 0, 1, 1 }
				AnchorOffsets	= {0,40,0,0},
				NoSelection		= true,
			}
		},

		Events = {
			WindowClosed = function(self, wndHandler, wndControl)
				self.wndMain = nil
			end
		}
	}

	self.wndMain = GeminiGUI:Create(tWndDefinition):GetInstance(self)
	self:RedrawTree()
end
