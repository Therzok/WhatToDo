--[[
	TODO: UI for 'finishing' quests.
]]
require "CraftingLib"
require "GameLib"
require "PlayerPathLib"
require "os"
require "table"

local Debug

local WhatToDo = Apollo.GetPackage("Gemini:Addon-1.1").tPackage:NewAddon("WhatToDo", false, {})
local GeminiGUI

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
		dailies = clone(self.QuestData),
		last = lastReset(),
		version = self.QuestDataVersion
	}
end

function WhatToDo:PurgeInvalid()
	local newDailies = {}
	for k1, v1 in pairs(self.cfg.dailies) do
		local newList = {}
		for _, v2 in ipairs(v1) do
			if (not v2.Path or v2.Path == self.playerPath) and 					-- Check path requirement.
				(not v2.Faction or v2.Faction == self.playerFaction) and		-- Check faction requirement
				(not v2.Tradeskill or self.playerTradeskills[v2.Tradeskill]) 	-- Check Tradeskills
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
	
	self:ResetDailies()
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
	
	self:PurgeInvalid()
end

function WhatToDo:OnEnable()
	-- Register event for quest completion
	Apollo.RegisterEventHandler("QuestStateChanged", "OnQuestStateChanged", self)

	-- Register events for switching tradeskills.
	-- Register events for levelup when adding minLevel support.

	local player = GameLib.GetPlayerUnit()
	self.playerPath = player:GetPlayerPathType()
	self.playerFaction = player:GetFaction()
	self.playerTradeskills = {}
	for _, tTradeskill in ipairs(CraftingLib.GetKnownTradeskills()) do
		local tInfo = CraftingLib.GetTradeskillInfo(tTradeskill.eId)
		if tInfo.bIsActive then
			self.playerTradeskills[tTradeskill.eId] = true
		end
	end
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
		for k2, v2 in ipairs(v1) do
			if v2.IdD == iQuestId or v2.IdE == iQuestId then
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
					for _, v2 in ipairs(v) do
						local displayName = Debug and v2.Name .. " [" .. v2.IdD .. "," .. v2.IdE .."]" or v2.Name
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
