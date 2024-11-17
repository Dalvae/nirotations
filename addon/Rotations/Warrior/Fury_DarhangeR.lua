local data = ni.utils.require("DarhangeR");
local popup_shown = false;
local enemies = {};
local build = select(4, GetBuildInfo());
local level = UnitLevel("player");
local function ActiveEnemies()
	table.wipe(enemies);
	enemies = ni.unit.enemiesinrange("target", 7);
	for k, v in ipairs(enemies) do
		if ni.player.threat(v.guid) == -1 then
			table.remove(enemies, k);
		end
	end
	return #enemies;
end
if build == 30300 and level == 80 and data then
	local items = {
		settingsfile = "DarhangeR_Fury.xml",
		{ type = "title",    text = "Fury Warrior by |c0000CED1DarhangeR" },
		{ type = "separator" },
		{ type = "title",    text = "|cffFFFF00Main Settings" },
		{ type = "separator" },
		{ type = "entry",    text = "\124T" .. data.bossIcon() .. ":26:26\124t Boss Detect",              tooltip = "When ON - Auto detect Bosses, when OFF - use CD bottom for Spells", enabled = true,      key = "detect" },
		{ type = "entry",    text = "Auto Stence",                                                        tooltip = "Auto use proper stence",                                            enabled = false,     key = "stence" },
		{ type = "entry",    text = "\124T" .. data.warrior.batIcon() .. ":26:26\124t Battle Shout",      enabled = true,                                                                key = "battleshout" },
		{ type = "entry",    text = "\124T" .. data.warrior.comIcon() .. ":26:26\124t Commanding Shout",  enabled = false,                                                               key = "commandshout" },
		{ type = "entry",    text = "\124T" .. data.warrior.inter1Icon() .. ":26:26\124t Auto Interrupt", tooltip = "Auto check and interrupt all interruptible spells",                 enabled = true,      key = "autointerrupt" },
		{ type = "entry",    text = "\124T" .. data.debugIcon() .. ":26:26\124t Debug Printing",          tooltip = "Enable for debug if you have problems",                             enabled = false,     key = "Debug" },
		{
			type = "entry",
			text = "|cFFFF0000\124T" ..
					GetItemIcon(42641) .. ":26:26\124t Use Bomb|r",
			tooltip = "It will use Bombs on CD!",
			enabled = "bombs",
			key = "bombs"
		},
		{ type = "entry",    text = "Auto Desync Weapons",                                                                                                            tooltip = "Automatically attempt to desync weapons",                  enabled = true,  key = "autodesync" },
		{ type = "separator" },
		{ type = "page",     number = 1,                                                                                                                              text = "|cff00C957Defensive Settings" },
		{ type = "separator" },
		{ type = "entry",    text = "\124T" .. data.warrior.enraIcon() .. ":26:26\124t Enraged Regeneration",                                                         tooltip = "Use spell when player HP < %",                             enabled = true,  value = 37,          key = "regen" },
		{ type = "entry",    text = "\124T" .. data.warrior.bersIcon() .. ":26:26\124t Berserker Rage (Anti-Contol)",                                                 enabled = true,                                                       key = "bersrage" },
		{ type = "entry",    text = "\124T" .. data.stoneIcon() .. ":26:26\124t Healthstone",                                                                         tooltip = "Use Warlock Healthstone (if you have) when player HP < %", enabled = true,  value = 35,          key = "healthstoneuse" },
		{ type = "entry",    text = "\124T" .. data.hpotionIcon() .. ":26:26\124t Heal Potion",                                                                       tooltip = "Use Heal Potions (if you have) when player HP < %",        enabled = true,  value = 30,          key = "healpotionuse" },
		{ type = "separator" },
		{ type = "page",     number = 2,                                                                                                                              text = "|cffEE4000Rotation Settings" },
		{ type = "separator" },
		{ type = "entry",    text = "\124T" .. data.warrior.sundIcon() .. ":26:26\124t Sunder Armor",                                                                 tooltip = "Work only on bosses",                                      enabled = false, key = "sunder" },
		{ type = "entry",    text = "\124T" .. data.warrior.heroIcon() .. ":26:26\124t  /  \124T" .. data.warrior.cleaveIcon() .. ":26:26\124t Heroic Strike/Cleave", tooltip = "Minimal rage threshold for use spells",                    value = 45,      key = "heroiccleave" },
	};
	local function GetSetting(name)
		for k, v in ipairs(items) do
			if v.type == "entry"
					and v.key ~= nil
					and v.key == name then
				return v.value, v.enabled
			end
			if v.type == "dropdown"
					and v.key ~= nil
					and v.key == name then
				for k2, v2 in pairs(v.menu) do
					if v2.selected then
						return v2.value
					end
				end
			end
			if v.type == "input"
					and v.key ~= nil
					and v.key == name then
				return v.value
			end
		end
	end;

	local spells            = {
		heroicStrike = { id = 47450, name = "Heroic Strike" },
		cleave = { id = 47520, name = "Cleave" },
		sunderArmor = { id = 7386, name = "Sunder Armor" },
		shatteringThrow = { id = 64382, name = "Shattering Throw" },
		rend = { id = 47465, name = "Rend" },
		sweepingStrikes = { id = 12328, name = "Sweeping Strikes" },
		thunderClap = { id = 47502, name = "Thunder Clap" },
		overpower = { id = 7384, name = "Overpower" },
		execute = { id = 47471, name = "Execute" },
		hamstring = { id = 1715, name = "Hamstring" },
		mortalStrike = { id = 47486, name = "Mortal Strike" },
		slam = { id = 1464, name = "Slam" },
		berserkRage = { id = 18499, name = "Berserker Rage" },
		victoryRush = { id = 34428, name = "Victory Rush" },
		bladestorm = { id = 46924, name = "Bladestorm" },
		battleShout = { id = 47436, name = "Battle Shout" },
		commandingShout = { id = 47440, name = "Commanding Shout" },
		enragedRegeneration = { id = 55694, name = "Enraged Regeneration" },
		bloodFury = { id = 20572, name = "Blood Fury" },
		bloodRage = { id = 2687, name = "Blood Rage" },
		strCard = { id = 60229, name = "Str CArd" },
		juggernaut = { id = 65156, name = "Juggernaut" },
		recklessness = { id = 1719, name = "Recklessness" },
		charge = { id = 11578, name = "Charge" },
		intercept = { id = 20252, name = "Intercept" },
		intervene = { id = 3411, name = "Intercept" },
		whirlwind = { id = 1680, name = "Whirlwind" },
		heroicthrow = { id = 57755, name = "Heroic Throw" },
		bloodthirst = { id = 23881, name = "Bloodthirst" },


		--Stances
		berserkStance = { id = 2458, name = "Berserk Stance" },
		battleStance = { id = 2457, name = "Battle Stance" },
		defensiveStance = { id = 71, name = "Defensive Stance" },
	}
	--Last Swing
	local lastSwingTime     = GetTime()
	local swingSync         = false
	local inCombat          = false
	local lastDesyncAttempt = 0
	local desyncCooldown    = 5

	local function AttemptDesync()
		local currentTime = GetTime()
		if currentTime - lastDesyncAttempt < desyncCooldown then
			print("Desync on cooldown")
			return
		end

		print("Attempting desync")
		ni.player.runtext("/cleartarget")
		ni.player.runtext("/targetlasttarget")
		ni.player.runtext("/startattack")
		print("Desync attempt executed")
		lastDesyncAttempt = currentTime
	end

	local function CombatEventCatcher(event, ...)
		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = ...
			local playerGUID = UnitGUID("player")
			local currentTime = GetTime()

			if sourceGUID == playerGUID then
				if eventType == "SWING_DAMAGE" or (eventType == "SPELL_DAMAGE" and spellId == 47450) then
					if (currentTime - lastSwingTime) < 0.3 and (currentTime - lastSwingTime) > 0.1 then
						local _, enabled = GetSetting("autodesync")
						if enabled then
							print("Swing sync detected at " .. currentTime)
							ni.C_Timer.After(1.5, AttemptDesync)
						end
					end
					lastSwingTime = currentTime
					print("Player swing occurred at " .. currentTime)
				end
			end
		elseif event == "PLAYER_REGEN_DISABLED" then
			inCombat = true
			lastSwingTime = GetTime()
		elseif event == "PLAYER_REGEN_ENABLED" then
			inCombat = false
		end
	end

	-- DBM PrePull
	local pullInTimer = nil

	local function DBMEventHandler(event, ...)
		local id, msg, duration = ...
		if event == "DBM_TimerStart" and msg == "Pull in" then
			pullInTimer = {
				expirationTime = GetTime() + duration,
				duration = duration
			}
			print("Pull in timer started: " .. duration .. " seconds")
		elseif event == "DBM_TimerStop" and msg == "Pull in" then
			pullInTimer = nil
			print("Pull in timer stopped")
		end
	end

	local function CheckPullInTimer()
		if pullInTimer then
			local remaining = pullInTimer.expirationTime - GetTime()
			if remaining > 0 then
				local _, bombsEnabled = GetSetting("bombs")

				if ni.spell.available(spells.berserkRage.id) then
					ni.spell.cast(spells.berserkRage.id)
				end
				if ni.spell.available(spells.bloodRage.id) then -- Bloodrage
					ni.spell.cast(spells.bloodRage.id)
				end

				if bombsEnabled then
					if remaining <= 61 and remaining > 60 then
						print("61 seconds left, using Armor potion")
						-- Lógica para usar la poción de armadura
						-- ni.player.useitem(4093) -- Descomentar cuando esté listo para usar
					elseif remaining <= 1 and remaining > 0 then
						print("1 second left, using Haste potion")
						-- Lógica para usar la poción de haste
						-- ni.player.useitem(40211) -- Descomentar cuando esté listo para usar
					elseif remaining <= 0 then
						print("Pull timer expired, using Intercept")
						ni.spell.cast(spells.intercept.id, "target")
						ni.spell.cast(spells.heroicthrow.id, "target")
					end
				end
				return remaining
			else
				pullInTimer = nil
			end
		end
		return nil
	end


	local function CheckDBMPullTimer()
		local remaining = CheckPullInTimer()
		if remaining then
			local _, bombsEnabled = GetSetting("bombs")
			return remaining, bombsEnabled
		end
		return nil, false
	end

	local function OnLoad()
		if DBM then
			DBM:RegisterCallback("DBM_TimerStart", DBMEventHandler)
			DBM:RegisterCallback("DBM_TimerStop", DBMEventHandler)
		end
		-- ni.combatlog.registerhandler("Fury_DarhangeR", CombatEventCatcher);
		ni.GUI.AddFrame("Fury_DarhangeR", items);
	end
	local function OnUnLoad()
		-- ni.combatlog.unregisterhandler("Fury_DarhangeR", CombatEventCatcher);
		ni.GUI.DestroyFrame("Fury_DarhangeR");
	end

	local lastGCDStart = 0
	local lastGCDDuration = 1

	local function getGCD()
		local start, duration = GetSpellCooldown(61304) -- 61304 es el ID del hechizo "Global Cooldown"
		if start > 0 and duration > 0 then
			lastGCDStart = start
			lastGCDDuration = duration
		end
		return lastGCDDuration
	end

	SLASH_CHARGEARE1            = "/chargeare"
	SlashCmdList["CHARGEARE"]   = function()
		local currentStance = GetShapeshiftForm()
		local mouseoverUnit = UnitGUID("mouseover")
		local targetUnit = UnitGUID("target")
		if UnitExists(mouseoverUnit) and mouseoverUnit ~= targetUnit then
			ni.player.runtext("/target [@mouseover]")
		end
		if UnitExists("target")
				and ni.unit.distance("player", "target") > 7
				and ni.unit.distance("target", "target") < 26
		then
			if UnitCanAttack("player", "target")
			then
				if ni.spell.cd(spells.intercept.id) == 0
						and ni.player.power() >= 10
				then
					ni.player.lookat("target")
					if currentStance == 3 then
						ni.spell.cast(spells.intercept.id, "target")
					else
						ni.spell.cast(spells.berserkStance.id)
						ni.C_Timer.After(0.1, function()
							ni.spell.cast(spells.intercept.id, "target")
						end)
					end
				end
			else
				if ni.spell.cd(spells.intervene.id) == 0
						and ni.player.power() > 10
				then
					ni.player.lookat("target")
					if currentStance == 2 then
						ni.spell.cast(spells.intervene.id, "target")
					else
						ni.spell.cast(spells.defensiveStance.id)
						ni.C_Timer.After(0.1, function()
							ni.spell.cast(spells.intervene.id, "target")
						end)
					end
				end
			end
		end
	end

	SLASH_STOPGASTING1          = "/stopgasting"
	SlashCmdList["STOPGASTING"] = function()
		ni.rotation.delay(1)
	end



	local function castBattle(spellID, target)
		local currentStance = GetShapeshiftForm()
		if currentStance ~= 1 then -- Not in battle stance
			ni.spell.cast(2457)    --Battlestance
			ni.spell.cast(spellID, target)
		end
		ni.spell.cast(spellID, target)
	end
	local function castBerserker(spellID, target)
		local currentStance = GetShapeshiftForm()
		if currentStance ~= 3 then -- Not in berserker stance
			ni.spell.cast(spells.berserkStance.id)
			ni.spell.cast(spellID, target)
		end
		ni.spell.cast(spellID, target)
	end

	local queue = {
		"Handle DBM Pull Timer",
		"Cache",
		"Universal pause",
		"AutoTarget",
		-- "Desync Weapons",
		"Berserker Stance",
		"Battle Shout",
		"Commanding Shout",
		"Enraged Regeneration",
		"Berserker Rage",
		"Combat specific Pause",
		"Healthstone (Use)",
		"Heal Potions (Use)",
		-- "Racial Stuff",
		"Use enginer gloves",
		"Trinkets",
		"Bombs",
		"Heroic Throw",
		-- "Death Wish",
		-- "Recklessness",
		"Pummel (Interrupt)",
		"AutoAtack",
		"Heroic Strike + Cleave (Filler)",
		"Whirlwind",
		"Bloodthirst",
		"Sunder Armor Refresh",
		"Bloodrage",
		"Berserkrage",
		"Slam",
		"Rend",
		"Execute",
		"Sunder Armor",
		"Victory Rush",
	}
	local cache = {
		battlestance = false,
		berserkstance = false,
		defensivestance = false
	}

	local abilities = {
		-----------------------------------

		["Cache"] = function()
			local currentStance = GetShapeshiftForm()
			cache.battlestance = (currentStance == 1)
			cache.berserkstance = (currentStance == 3)
			cache.defensivestance = (currentStance == 2)
			cache.gcd = getGCD()
		end,
		-----------------------------------
		["Universal pause"] = function()
			if IsMounted()
					or UnitInVehicle("player")
					or UnitIsDeadOrGhost("target")
					or UnitIsDeadOrGhost("player")
					or UnitChannelInfo("player") ~= nil
					or UnitCastingInfo("player") ~= nil
					or ni.vars.combat.casting == true
					or ni.player.islooting()
					or data.PlayerBuffs("player")
					or (not UnitAffectingCombat("player") and ni.vars.followEnabled) then
				return true
			end

			ni.vars.debug = select(2, GetSetting("Debug"));
			return false
		end,
		-----------------------------------
		["Handle DBM Pull Timer"] = function()
			if ni.player.iscasting() or ni.player.ischanneling() or ni.player.buff(57073) or ni.player.buff(57008) then
				return false
			end

			local remaining, bombsEnabled = CheckDBMPullTimer()
			if remaining then
				if ni.spell.available(spells.berserkRage.id) then
					ni.spell.cast(spells.berserkRage.id)
				end
				if ni.spell.available(spells.bloodRage.id) then
					ni.spell.cast(spells.bloodRage.id)
				end

				if remaining <= 61 and remaining > 60 and bombsEnabled then
					print("61 seconds left, using Armor potion")
					ni.player.useitem(40093)
				elseif remaining <= 28 and remaining > 27.5 then
					print("20 seconds left, swapping trinkets")
					-- Obtener el nombre del trinket en el slot 13
					local topTrinketLink = GetInventoryItemLink("player", 13)
					local topTrinketName = topTrinketLink and select(1, GetItemInfo(topTrinketLink)) or nil

					-- Obtener el nombre del trinket en el slot 14
					local bottomTrinketLink = GetInventoryItemLink("player", 14)
					local bottomTrinketName = bottomTrinketLink and select(1, GetItemInfo(bottomTrinketLink)) or nil

					if topTrinketName and bottomTrinketName then
						-- Equipar el trinket de abajo en el slot de arriba
						ni.player.runtext("/equipslot 13 " .. bottomTrinketName)
						-- Equipar el trinket de arriba en el slot de abajo
						ni.player.runtext("/equipslot 14 " .. topTrinketName)
					end
				elseif remaining <= 5 and remaining > 1 then
					print("5 second left, Recklesness")
					ni.spell.cast(spells.recklessness.id)
				elseif remaining <= 1 and remaining > 0 and bombsEnabled then
					print("1 second left, using Haste potion")
					ni.player.useitem(40211)
				elseif remaining <= 0.1 then
					print("Pull timer expired, using Intercept")
					ni.spell.cast(spells.intercept.id, "target")
					-- ni.spell.cast(spells.heroicthrow.id, "target")
				end
				return true
			end
			return false
		end,
		-----------------------------------
		["Desync Weapons"] = function()
			local currentTime = GetTime()
			if not inCombat or currentTime - lastDesyncAttempt < desyncCooldown then
				return false
			end

			if swingSync then
				print("Swing sync detected, attempting desync")
				ni.player.runtext("/cleartarget")
				ni.player.runtext("/targetlasttarget")
				ni.player.runtext("/startattack")
				lastDesyncAttempt = currentTime
				swingSync = false
				return true
			end

			return false
		end,
		-----------------------------------

		["AutoTarget"] = function()
			if UnitAffectingCombat("player")
					and ((ni.unit.exists("target")
							and UnitIsDeadOrGhost("target")
							and not UnitCanAttack("player", "target"))
						or not ni.unit.exists("target")) then
				ni.player.runtext("/targetenemy")
			end
		end,
		-----------------------------------
		["AutoAtack"] = function()
			if UnitAffectingCombat("player")
					and data.warrior.InRange()
					and not IsCurrentSpell(6603)
			then
				ni.player.runtext("/startattack")
			end
		end,
		["Bombs"] = function()
			local _, enabled = GetSetting("bombs")
			if enabled
			then
				if ni.player.hasitem(42641) --Sapper
						and ni.player.itemcd(42641) == 0
				then
					if ni.unit.inmelee("player", "target")
							and ni.unit.isboss("target")
							and UnitCanAttack("player", "target")
							and ni.player.hp() > 40
							and ni.player.power() < 40
					then
						ni.player.useitem(42641)
					end
				else
					if ni.player.hasitem(41119) --Sarobomb
							and UnitCanAttack("player", "target")
							and ni.unit.isboss("target")
							and ni.player.itemcd(41119) == 0
					then
						ni.player.useitem(41119)
						ni.player.clickat("target")
					end
				end
			end
		end,
		-----------------------------------

		["Berserker Stance"] = function()
			local _, enabled = GetSetting("stence")
			if enabled
					and cache.battlestance
					and (ni.unit.debuff("target", 47465, "player")
						or ni.unit.hp("target") < 20)
			-- and ni.player.power() < 25

			then
				if ni.player.power() > 25
						and not IsCurrentSpell(47450)
				then
					ni.spell.cast(47450, "target")
				else
					ni.spell.cast(2458)
					return true
				end
			end
		end,
		-----------------------------------
		["Battle Shout"] = function()
			local _, enabled = GetSetting("battleshout")
			if ni.player.buffs("47436||48932||48934") then
				return false
			end
			if enabled
					and ni.spell.available(47436) then
				ni.spell.cast(47436)
				return true
			end
		end,
		-----------------------------------
		["Commanding Shout"] = function()
			local _, enabled = GetSetting("commandshout")
			if ni.player.buffs("47440||47440") then
				return false
			end
			if enabled
					and ni.spell.available(47440) then
				ni.spell.cast(47440)
				return true
			end
		end,
		-----------------------------------
		["Enraged Regeneration"] = function()
			local value, enabled = GetSetting("regen");
			local enrage = { 18499, 12292, 29131, 14204, 57522 }
			if enabled
					and ni.spell.available(55694)
					and ni.player.hp() < value then
				for i = 1, #enrage do
					if ni.player.buff(enrage[i]) then
						ni.spell.cast(55694)
					else
						if not ni.player.buff(enrage[i])
								and ni.spell.cd(2687) == 0 then
							ni.spell.castspells("2687|55694")
							return true
						end
					end
				end
			end
		end,
		-----------------------------------
		["Berserker Rage"] = function()
			local _, enabled = GetSetting("bersrage")
			if enabled
					and data.warrior.Berserk()
					and ni.spell.available(18499)
					and not ni.player.buff(18499) then
				ni.spell.cast(18499)
				return true
			end
		end,
		-----------------------------------
		["Combat specific Pause"] = function()
			if data.meleeStop("target")
					or data.PlayerDebuffs("player")
					or UnitCanAttack("player", "target") == nil
					or (UnitAffectingCombat("target") == nil
						and ni.unit.isdummy("target") == nil
						and UnitIsPlayer("target") == nil) then
				return true
			end
		end,
		-----------------------------------
		["Healthstone (Use)"] = function()
			local value, enabled = GetSetting("healthstoneuse");
			local hstones = { 36892, 36893, 36894 }
			for i = 1, #hstones do
				if enabled
						and ni.player.hp() < value
						and ni.player.hasitem(hstones[i])
						and ni.player.itemcd(hstones[i]) == 0 then
					ni.player.useitem(hstones[i])
					return true
				end
			end
		end,
		-----------------------------------
		["Heal Potions (Use)"] = function()
			local value, enabled = GetSetting("healpotionuse");
			local hpot = { 33447, 43569, 40087, 41166, 40067 }
			for i = 1, #hpot do
				if enabled
						and ni.player.hp() < value
						and ni.player.hasitem(hpot[i])
						and ni.player.itemcd(hpot[i]) == 0 then
					ni.player.useitem(hpot[i])
					return true
				end
			end
		end,
		-----------------------------------
		["Racial Stuff"] = function()
			local hracial = { 33697, 20572, 33702, 26297 }
			local bloodelf = { 25046, 28730, 50613 }
			local alracial = { 20594, 28880 }
			local _, enabled = GetSetting("detect")
			--- Undead
			if data.forsaken("player")
					and IsSpellKnown(7744)
					and ni.spell.available(7744) then
				ni.spell.cast(7744)
				return true
			end
			--- Horde race
			for i = 1, #hracial do
				if data.CDorBoss("target", 5, 35, 5, enabled)
						and IsSpellKnown(hracial[i])
						and ni.spell.available(hracial[i])
						and data.warrior.InRange() then
					ni.spell.cast(hracial[i])
					return true
				end
			end
			--- Blood Elf
			for i = 1, #bloodelf do
				if data.CDorBoss("target", 5, 35, 5, enabled)
						and ni.player.power() < 60
						and IsSpellKnown(bloodelf[i])
						and ni.spell.available(bloodelf[i])
						and data.warrior.InRange() then
					ni.spell.cast(bloodelf[i])
					return true
				end
			end
			--- Ally race
			for i = 1, #alracial do
				if data.warrior.InRange()
						and ni.player.hp() < 20
						and IsSpellKnown(alracial[i])
						and ni.spell.available(alracial[i]) then
					ni.spell.cast(alracial[i])
					return true
				end
			end
		end,
		-----------------------------------
		["Use enginer gloves"] = function()
			local _, enabled = GetSetting("detect")
			if ni.player.slotcastable(10)
					and ni.player.itemready(44931)
					and ni.spell.cd(12292) > 60
					and ni.player.slotcd(10) == 0
			then
				ni.player.useinventoryitem(10)
				return true
			end
		end,
		-----------------------------------
		["Trinkets"] = function()
			local _, enabled = GetSetting("detect")
			if data.CDorBoss("target", 5, 35, 5, enabled)
					and ni.player.slotcastable(13)
					and ni.player.slotcd(13) == 0
					and data.warrior.InRange() then
				ni.player.useinventoryitem(13)
			else
				if data.CDorBoss("target", 5, 35, 5, enabled)
						and ni.player.slotcastable(14)
						and ni.player.slotcd(14) == 0
						and data.warrior.InRange() then
					ni.player.useinventoryitem(14)
					return true
				end
			end
		end,
		-----------------------------------	
		["Pummel (Interrupt)"] = function()
			local _, enabled = GetSetting("autointerrupt")
			if enabled
					and ni.spell.shouldinterrupt("target")
					and ni.spell.available(6552)
					and GetTime() - data.LastInterrupt > 9
					and ni.spell.valid("target", 6552, true, true)
					and (ni.unit.castingpercent("target") > 80
						or ni.unit.ischanneling("target"))
			then
				ni.spell.castinterrupt("target")
				data.LastInterrupt = GetTime()
				return true
			end
		end,
		-----------------------------------	
		-----------------------------------	
		["Heroic Throw"] = function()
			if not data.warrior.InRange()
					and UnitAffectingCombat("player")
					and ni.spell.cd(spells.heroicthrow.id) == 0
					and ni.spell.valid("target", spells.heroicthrow.id, true, true)
			then
				ni.spell.cast(spells.heroicthrow.id, "target")
			end
		end,

		-----------------------------------	
		["Death Wish"] = function()
			local sunder, _, _, count = ni.unit.debuff("target", 7386)
			local _, enabled = GetSetting("detect")
			if data.CDorBoss("target", 5, 35, 5, enabled)
					and sunder
					and count > 4
					and ni.spell.available(12292)
					and data.warrior.InRange() then
				ni.spell.cast(12292)
				return true
			end
		end,
		-----------------------------------
		["Recklessness"] = function()
			local sunder, _, _, count = ni.unit.debuff("target", 7386)

			local _, enabled = GetSetting("detect")
			if data.CDorBoss("target", 5, 35, 5, enabled)
					and sunder
					and count > 4
					and ni.spell.available(1719)
					and data.warrior.InRange() then
				ni.spell.cast(1719)
				return true
			end
		end,
		-----------------------------------
		["Bloodrage"] = function()
			local _, enabled = GetSetting("detect")
			if ni.unit.isboss("target")
					and cache.berserkstance
					and ni.player.power() < 30
					and ni.spell.available(2687)
					and data.warrior.InRange() then
				ni.spell.cast(2687)
				return true
			end
		end,
		["Berserkrage"] = function()
			local _, enabled = GetSetting("detect")
			if ni.unit.isboss("target")
					and cache.berserkstance
					and ni.player.power() < 30
					and ni.spell.available(18499)
					and data.warrior.InRange() then
				ni.spell.cast(18499)
				return true
			end
		end,
		-----------------------------------
		["Victory Rush"] = function()
			if IsUsableSpell(GetSpellInfo(34428))
					and (not IsUsableSpell(GetSpellInfo(spells.bloodthirst.id))
						or ni.spell.cd(spells.whirlwind.id) > 1
						and ni.spell.cd(spells.bloodthirst.id) > 1)
					and ni.spell.valid("target", 34428, true, true) then
				ni.spell.cast("Victory Rush", "target")
				return true
			end
		end,
		-----------------------------------
		["Execute"] = function()
			if ni.player.power() > 30
					and (ni.unit.hp("target") <= 20
						or IsUsableSpell(GetSpellInfo(47471)))
					and ni.spell.valid("target", 47471, true, true) then
				ni.spell.cast("Execute", "target")

				return true
			end
		end,
		["Rend"] = function()
			local _, enabled = GetSetting("sunder")
			local sunder, _, _, count = ni.unit.debuff("target", 7386)

			if ni.unit.isboss("target")
					and ni.unit.hp("target") >= 20
					and ((ni.spell.cd(spells.whirlwind.id) > 2
							and ni.spell.cd(spells.bloodthirst.id) > 2) or
						cache.battlestance)
					and not ni.unit.debuff("target", spells.rend.id, "player")
					and ni.spell.valid("target", spells.rend.id, true, true)
			then
				local shouldCast = true

				if enabled then
					if not sunder or count < 5 then
						shouldCast = false
					end
				end

				if shouldCast then
					ni.spell.castspells("Battle Stance|Rend", "target")
					return true
					-- ni.player.runtext("/cast [nostance:1]Battle Stance; Rend")
				end
			end
		end,
		-----------------------------------

		["Slam"] = function()
			local sunder, _, _, count = ni.unit.debuff("target", 7386)
			local _, sunderEnabled = GetSetting("sunder")
			local isBoss = ni.unit.isboss("target")

			if cache.berserkstance
					and ni.player.buff(46916)
					and ni.spell.cd(spells.whirlwind.id) > 1
					and ni.spell.cd(spells.bloodthirst.id) > 1
					and ni.spell.valid("target", 47475, true, true)
			then
				local shouldCast = true

				if isBoss and sunderEnabled then
					if not sunder or count < 5 then
						shouldCast = false
					end
				end

				if shouldCast then
					ni.spell.cast(47475, "target") -- ID de Slam
					return true
				end
			end

			return false
		end,
		-----------------------------------
		["Bloodthirst"] = function()
			if cache.berserkstance
					and ni.spell.cd(spells.bloodthirst.id) < 0.4
					and ni.player.power() >= 20
					and ni.spell.valid("target", spells.bloodthirst.id, true, true)
			then
				ni.spell.cast("Bloodthirst", "target")
			end
		end,
		["Whirlwind"] = function()
			if cache.berserkstance
					and ni.spell.cd(spells.whirlwind.id) < 0.4
					and ni.player.power() >= 25
					and ni.player.distance("target") <= 8
					and not IsLeftShiftKeyDown() then
				ni.spell.cast("Whirlwind")
				return true
			end
			return false
		end,
		-----------------------------------	
		["Sunder Armor"] = function()
			local sunder, _, _, count = ni.unit.debuff("target", 7386)
			local _, enabled = GetSetting("sunder")
			if enabled
					and ni.unit.isboss("target")
					and not ni.unit.debuff("target", 8647)
					and (not sunder
						or count < 5 or ni.unit.debuffremaining("target", 7386, "player") < 4)
					and ni.spell.available(7386)
					and ni.spell.valid("target", 7386, true, true) then
				ni.spell.cast(7386, "target")
				return true
			end
		end,
		["Sunder Armor Refresh"] = function()
			local sunder, _, _, count = ni.unit.debuff("target", 7386)
			local _, enabled = GetSetting("sunder")
			if enabled
					and ni.unit.isboss("target")
					and not ni.unit.debuff("target", 8647)
					and ni.unit.debuffremaining("target", 7386, "player") < 5
					and ni.spell.available(7386)
					and ni.spell.valid("target", 7386, true, true) then
				ni.spell.cast(7386, "target")
				return true
			end
		end,
		-----------------------------------
		["Heroic Strike + Cleave (Filler)"] = function()
			local value = GetSetting("heroiccleave");
			if ni.spell.valid("target", 47475) then
				if ni.vars.combat.aoe and ni.player.power() > (value + 8) then
					ni.spell.cast(47520)
				elseif not ni.vars.combat.aoe and ni.player.power() > value then
					ni.spell.cast(47450)
				end
			end
			return false
		end,
		-----------------------------------

	}

	ni.bootstrap.profile("Fury_DarhangeR", queue, abilities, OnLoad, OnUnLoad);
else
	local queue = {
		"Error",
	}
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if build > 30300 then
				ni.frames.floatingtext:message("This profile is meant for WotLK 3.3.5a! Sorry!")
			elseif level < 80 then
				ni.frames.floatingtext:message("This profile is meant for level 80! Sorry!")
			elseif data == nil then
				ni.frames.floatingtext:message("Data file is missing or corrupted!");
			end
		end,
	}
	ni.bootstrap.profile("Fury_DarhangeR", queue, abilities);
end
-- XT
-- Algalon
-- Aureya
-- Thorim
-- Hodir
-- Freya
-- Mimiron
-- Yogg
