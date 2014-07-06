--[[
	TODO: UI for 'finishing' quests.
]]
require "CraftingLib"
require "GameLib"
require "Money"
require "PlayerPathLib"
require "Quest"

require "math"
require "os"
require "table"

local Debug

-- Quest categories.
local QuestDaily = 63
local QuestTradeskill = 53

-- Configuration settings.
local cShowUndiscovered	= true
local cShowVouchers		= true
local cShowMaxRep		= true
local cShowIds			= true
local cShowWhitelistOnly= true

-- TODO
local cShowForYourLevel = true

-- Cached variables.
local maxRep
local GeminiGUI
local WhatToDo = Apollo.GetPackage("Gemini:Addon-1.1").tPackage:NewAddon("WhatToDo", false, {})

-- Utils
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

local function getMaxRep()
	if maxRep then return maxRep end
	
	maxRep = 0
	for _, v in pairs(GameLib.GetReputationLevels()) do
		maxRep = math.max(maxRep, v.nMax)
	end
end

local function createTableItem(self, category, iId, strTitle, extra)
	if not self.dailiesKnown[category] then self.dailiesKnown[category] = {} end
	if not extra.GameData and self.dailiesKnown[category][iId] then return end
	
	self.dailiesKnown[category][iId] = {
		Name = strTitle,
		Path = self.QuestPathExtensions[iId],
		Tradeskill = self.QuestTradeskillExtensions[iId],
		Whitelisted = self.QuestWhitelist[iId],
		Id = iId,
		Extra = extra
	}
end

local function storeRelevant(self, v)
	for _, rew in pairs(v:GetRewardData().arFixedRewards) do
		local category
		local extra = { GameData = true }
		
		if rew.eType == Quest.Quest2RewardType_Reputation then -- Reputation
			category = rew.strFactionName
			extra.Reputation = true
		elseif rew.eType == Quest.Quest2RewardType_Money and rew.eCurrencyType == Money.CodeEnumCurrencyType.CraftingVouchers and
				v:GetType() == 5 and v:GetSubType() ~= 0 then -- Crafting Vouchers
			category = "Tradeskills - Crafting Vouchers"
			extra.Vouchers = true
		elseif rew.eType == Quest.Quest2RewardType_Item and rew.itemReward:GetItemId() == 28282 and
				v:GetType() == 5 and v:GetSubType() ~= 0 then -- Daily Data Ration
			category = "Tradeskills - Daily Data Ration"
		end

		if category then
			createTableItem(self, category, v:GetId(), v:GetTitle(), extra)
			return
		end
	end
end

-- Called when loading. No magic that makes quests appear except accept.
function WhatToDo:DigQuests()
	for _, qcCategory in pairs(QuestLib.GetKnownCategories()) do
		if qcCategory:GetId() == QuestDaily or qcCategory:GetId() == QuestTradeskill then
			for _, epiEpisode in pairs(qcCategory:GetEpisodes()) do
				if not epiEpisode:IsWorldStory() and not epiEpisode:IsZoneStory() and not epiEpisode:IsRegionalStory() then
					for _, queQuest in pairs(epiEpisode:GetAllQuests(qcCategory:GetId())) do
						storeRelevant(self, queQuest)
					end
				end
			end
		end
	end
	
	-- Add undiscovered quests
	local player = GameLib.GetPlayerUnit()
	local playerFaction = player:GetFaction()
	local playerPath = player:GetPlayerPathType()

	for k, v in pairs(self.QuestsKnown) do
		for k2, v2 in pairs(v) do
			local iId = playerFaction == Unit.CodeEnumFaction.ExilesPlayer and v2.IdE or v2.IdD
			-- Check data which doesn't ever change for a character (Path, Faction).
			if (not self.QuestFactionExtensions[iId] or self.QuestFactionExtensions[iId] == playerFaction) and
				(not self.QuestPathExtensions[iId] or self.QuestPathExtensions[iId] == playerPath)
			then
				createTableItem(self, k, iId, v2.Name, {})
			end
		end
	end
end

function WhatToDo:ResetDailies()
	self.cfg = {
		last = lastReset(),
		finished = {}
	}
end

function WhatToDo:OnInitialize()
	-- Get dependency packages.
	GeminiGUI = Apollo.GetPackage("Gemini:GUI-1.0").tPackage

	-- Register slash.
	Apollo.RegisterSlashCommand("wtd", "OnWhatToDoOn", self)
	Apollo.RegisterSlashCommand("whattodo", "OnWhatToDoOn", self)
	Apollo.RegisterSlashCommand("wtdf", "OnWhatToDoFinish", self)

	self.cfg = {
		finished = {}
	}
	self.dailiesKnown = {}
end

function WhatToDo:OnSave(eLevel)
	if eLevel ~= GameLib.CodeEnumAddonSaveLevel.Character then return nil end
	return self.cfg
end

function WhatToDo:OnRestore(eLevel, tData)
	if eLevel ~= GameLib.CodeEnumAddonSaveLevel.Character then return nil end

	self.cfg = clone(tData)

	-- Test if we're over a daily cycle since last login.
	if self.cfg.last ~= lastReset() then
		self:ResetDailies()
	end
end

function WhatToDo:OnEnable()
	-- Register event for quest completion
	Apollo.RegisterEventHandler("QuestStateChanged", "OnQuestStateChanged", self)

	-- Fix tradeskills changing quests. TradeskillLearnedFromTHOR
	-- Register events for levelup when adding minLevel support.
	
	self:DigQuests()
end

function WhatToDo:OnDisable()
	Apollo.RemoveEventHandler("QuestStateChanged", self)
end

-- Track quest completion.
function WhatToDo:OnQuestStateChanged(queUpdated, eState)
	local store
	if eState == Quest.QuestState_Accepted then
		store = true
	elseif eState == Quest.QuestState_Completed then
		self:FinishQuest(queUpdated:GetId())
		store = true
	end
	if store then storeRelevant(queUpdated) end
end

-- Add the quest to the dailies finished list.
function WhatToDo:FinishQuest(iQuestId)
	self.cfg.finished[iQuestId] = true
	self:RedrawTree()
end

local function repIsMax(strFaction)
	for _, v in pairs(GameLib.GetReputationInfo()) do
		if v.nCurrent == getMaxRep() and v.strName == strFaction then
			return true
		end
	end
	return false
end

function WhatToDo:GetDisplayTable()
	self:DigQuests()
	local toDisplay = {}
	
	-- Check tradeskills in showing.
	local playerTradeskills = {}
	for _, tTradeskill in ipairs(CraftingLib.GetKnownTradeskills()) do
		local tInfo = CraftingLib.GetTradeskillInfo(tTradeskill.eId)
		playerTradeskills[tTradeskill.eId] = tInfo.bIsActive
	end

	for category, quests in pairs(self.dailiesKnown) do
		for _, quest in pairs(quests) do
			if (cShowUndiscovered or quest.Extra.GameData) and						-- Show Undiscovered based on toggle.
				(cShowVouchers or not quest.Extra.Vouchers) and						-- Show Vouchers based on toggle.
				(cShowMaxRep or not repIsMax(category))	and							-- Show Max Reputation based on toggle.
				(not quest.Tradeskill or playerTradeskills[quest.Tradeskill]) and	-- Purge Tradeskills
				(not self.cfg.finished[quest.Id]) and								-- Purge Finished
				(not cShowWhitelistOnly or quest.Whitelisted)						-- Show only whitelisted.
			then
				if not toDisplay[category] then toDisplay[category] = {} end
				table.insert(toDisplay[category], quest)
			end
		end
	end
	return toDisplay
end

local function formatTitle(self, iId, strTitle, extra)
	return (not extra.GameData and "[Undiscovered] " or "") ..	-- Undiscovered quest in QuestsKnown.
		(not self.QuestWhitelist[iId] and "[NEW] " or "") ..	-- GameData quest not in QuestsKnown.
		(self.QuestZoneExtensions[iId] or "") ..				-- Zone extensions for Tradeskills.
		strTitle ..												-- Quest title.
		(cShowIds and " [" .. iId .. "]" or "")					-- Show IDs.
end

-- Tree with items construction.
function WhatToDo:CreateTree()
	return { -- Tree Control
		Name			= "QuestTree",
		WidgetType		= "TreeControl",
		AnchorPoints	= "FILL", -- will be translated to { 0, 0, 1, 1 }
		VScroll			= true,
		Events			= {
			WindowLoad = function(self, wndHandler, wndControl)
				local items = false
				local toDisplay = self:GetDisplayTable()
				
				for k, v in pairs(toDisplay) do
					items = true

					local hParent = 0
					hParent = wndControl:AddNode(hParent, k)
					for k2, v2 in pairs(v) do
						wndControl:AddNode(hParent, formatTitle(self, v2.Id, v2.Name, v2.Extra))
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
	GeminiGUI:Create(self:CreateTree()):GetInstance(self, container)
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
