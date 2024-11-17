local items = {
	settingsfile = "DalvaeDungeonBot.json",
	{ type = "title",    text = "Dungeon Bot by |c0000CED1Dalvae|r" },
	{ type = "separator" },
	{ type = "title",    text = "|cffFF7C0AProfile version 0.0.2|r" },
	{ type = "separator" },
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(33891) .. " Auto Follow",
		tooltip = "Seguir automaticamente a",
		enabled = true,
		value = 13,
		key =
		"autofollow"
	},
	{ type = "input", value = "", width = 105, height = 25, wordwrap = true, key = "unidad" },
	{
		type = "entry",
		text = ni.spell.icon(52674) .. " Autoloot",
		tooltip =
		"autoloot",
		enabled = true,
		key =
		"autoloot"
	},
	{
		type = "entry",
		text = ni.spell.icon(13262) .. " |cffffa500 Disenchant|r",
		tooltip =
		"Disenchant Items",
		enabled = false,
		key =
		"disenchant"
	},
}

local function GetSetting(name)
	for k, v in ipairs(items) do
		if v.type == "entry"
				and v.key ~= nil
				and v.key == name then
			return v.value, v.enabled;
		end
		if v.type == "dropdown"
				and v.key ~= nil
				and v.key == name then
			for k2, v2 in pairs(v.menu) do
				if v2.selected then
					return v2.value;
				end
			end
		end
		if v.type == "input"
				and v.key ~= nil
				and v.key == name then
			return v.value;
		end
	end
end;

local function OnLoad()
	ni.GUI.AddFrame("DalvaeDungeonBot", items);
end;
local function OnUnLoad()
	ni.GUI.DestroyFrame("DalvaeDungeonBot");
end;


local function BagSpace()
	local c = 0
	for bag = 0, NUM_BAG_SLOTS do
		local freeSlots = GetContainerNumFreeSlots(bag)
		c = c + freeSlots
	end
	return c
end
local lastclick = 0;
local looting
local movingToCorpse
local LootedUnits = {}
local FailedLootAttempts = {}
local LootInProgress = false

function Loot(guid)
	if LootInProgress then
		return false
	end

	if ni.player.distance(guid) < 1 and not ni.player.ismoving() and not movingToCorpse then
		if FailedLootAttempts[guid] and FailedLootAttempts[guid] >= 3 then
			LootedUnits[guid] = true
			FailedLootAttempts[guid] = nil
			return true
		end

		LootInProgress = true
		ni.player.interact(guid)

		ni.C_Timer.After(0.5, function()
			if _G.LootFrame and _G.LootFrame:IsVisible() then
				local bindOnPickup = false
				local numLootItems = GetNumLootItems()
				if numLootItems and numLootItems > 0 then
					local lootedSomething = false
					for i = 1, numLootItems do
						local _, _, _, _, lootQuality = GetLootSlotInfo(i)
						if lootQuality >= 2 then
							LootSlot(i)
							bindOnPickup = true
						end
					end
					if bindOnPickup then
						ni.player.runtext("/click StaticPopup1Button1")
					end

					if not lootedSomething then
						LootedUnits[guid] = true
						FailedLootAttempts[guid] = nil
						CloseLoot()
						LootInProgress = false
						return true
					end
				else
					LootedUnits[guid] = true
					FailedLootAttempts[guid] = nil
					CloseLoot()
					LootInProgress = false
					return true
				end

				LootedUnits[guid] = true
				FailedLootAttempts[guid] = nil
				CloseLoot()
			else
				FailedLootAttempts[guid] = (FailedLootAttempts[guid] or 0) + 1
			end

			LootInProgress = false
		end)

		return true
	end
	return false
end

local Disenchant = GetSpellInfo(13262)

local cache = {
	IsMoving = false,
	PlayerCombat = false,
};

local queue = {
	"AutoLoot",
	"Follow",
	"Disenchant",
};


local abilities = {
	["Follow"] = function()
		local value, enabled = GetSetting("autofollow")
		if not enabled then
			return false;
		end

		local unit = tostring(GetSetting("unidad"));

		if unit == nil or unit == "" then
			return
		end

		if not lastclick then lastclick = 0 end

		local uGUID = UnitGUID(unit) or ni.objectmanager.objectGUID(unit);

		if uGUID == nil then
			return
		end

		local mtime = math.random(0.2, 0.5)
		local followTar = nil;
		local distance = nil;

		if UnitExists(unit) or ni.objectmanager.contains(unit) then
			if UnitAffectingCombat(uGUID) and ni.vars.combat.melee == true then
				print("La unidad está en combate y el combate cuerpo a cuerpo está activado")

				local oTar = select(6, ni.unit.info(uGUID))
				if oTar ~= nil then
					followTar = oTar
					ni.player.lookat(oTar)
				end
			end

			distance = ni.player.distance(uGUID)

			if not IsMounted() then
				if followTar ~= nil and ni.vars.combat.melee == true then
					distance = ni.player.distance(followTar)
					uGUID = followTar
				end
			end

			if followTar ~= nil then
				if not UnitIsUnit("target", followTar) then
					ni.player.target(followTar)
				end
			end

			if not UnitIsDeadOrGhost(uGUID) then
				if not UnitCastingInfo("player")
						and not LootInProgress
						and not movingToCorpse
						and not UnitChannelInfo("player")
						and distance ~= nil and distance > (value + 2) and distance < 45
						and GetTime() - lastclick > tonumber(format("%.1f", mtime)) then
					local px, py, pz = ni.unit.info("player")
					local ox, oy, oz = ni.unit.info(uGUID)
					local dx, dy = ox - px, oy - py
					local dist = math.sqrt(dx ^ 2 + dy ^ 2)
					local moveDist = math.max(0, dist - value)
					if moveDist > 0 then
						local unitX, unitY, unitZ = ni.unit.info(uGUID)
						local moveX, moveY, moveZ = px + dx / dist * moveDist, py + dy / dist * moveDist, pz
						ni.player.moveto(moveX, moveY, moveZ)
					end
					lastclick = GetTime()
				end
			end
		else
			print("La unidad no existe")
		end
	end,

	["AutoLoot"] = function()
		local _, enabled = GetSetting("autoloot");
		if not enabled then
			return false;
		end

		if not looting and BagSpace() > 0 and not ni.player.ismounted() and not ni.player.iscasting() and not ni.player.ischanneling() then
			if not movingToCorpse then
				local tempTbl = {}
				for g, o in pairs(ni.objects) do
					if type(g) ~= "function" and type(g) == "string" and type(o) == "table" then
						if not LootedUnits[g] and o:unit() and UnitIsDead(g) and ni.unit.islootable(g) and o:los("player") then
							table.insert(tempTbl, { guid = g, distance = o:distance() })
						end
					end
				end
				if next(tempTbl) == nil then
					return
				end
				table.sort(tempTbl, function(a, b) return a.distance < b.distance end)
				movingToCorpse = tempTbl[1].guid
				print("Moving to corpse: " .. movingToCorpse)
				ni.player.moveto(movingToCorpse)
				return true
			elseif ni.objects[movingToCorpse] and ni.player.distance(movingToCorpse) < 2 and not ni.player.ismoving() then
				local tmpCorpse = movingToCorpse
				movingToCorpse = nil
				print("Looting corpse: " .. tmpCorpse)
				return Loot(tmpCorpse)
			else
				movingToCorpse = nil
				return false
			end
		end
	end,

	["Disenchant"] = function()
		local _, enabled = GetSetting("disenchant");
		if not enabled then
			return false;
		end
		if (TSMDestroyingFrame ~= nil) then
			if TSMDestroyingFrame:IsVisible() then
				ni.player.runtext("/click TSMDestroyButton")
			end
		end
	end,
};

ni.bootstrap.profile("Dungeonbot", queue, abilities, OnLoad, OnUnLoad)
