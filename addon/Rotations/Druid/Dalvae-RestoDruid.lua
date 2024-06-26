local GetBuildInfo, select, ipairs, pairs, tonumber, GetSpellInfo, IsUsableSpell, GetTime, UnitAffectingCombat, IsMounted, ni_tanks, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, UnitCastingInfo =
		GetBuildInfo, select, ipairs, pairs, tonumber, GetSpellInfo, IsUsableSpell, GetTime, UnitAffectingCombat, IsMounted,
		ni.tanks, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, UnitCastingInfo
local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk
then
	local AntiAFKTime = 0;
	local items = {
		settingsfile = "Dalvae-RestoDruid.json",
		{ type = "title",    text = "Restoration Druid by |c0000CED1Dalvae|r" },
		{ type = "separator" },
		{ type = "title",    text = "|cffFF7C0AProfile version 0.0.2|r" },
		{ type = "separator" },
		{ type = "page",     number = 1,                                      text = "|cffFFFF00Main Settings" },
		{ type = "separator" },
		{
			type = "entry",
			text = ni.spell.icon(33891) .. " Auto Forma",
			tooltip = "Usar la forma automatica.",
			enabled = true,
			key =
			"autoform"
		},
		{
			type = "entry",
			text = ni.spell.icon(52674) .. " Auto Buff",
			tooltip =
			"Enable auto bufos",
			enabled = true,
			key =
			"AutoBuff"
		},
		{
			type = "entry",
			text = ni.spell.icon(2382) .. " |cffffa500Debug Printing|r",
			tooltip =
			"Enable for debug if you have problems.",
			enabled = false,
			key =
			"Debug"
		},
		{
			type = "page",
			number = 2,
			text =
			"|cff95f900CD's y hechizos importante|r"
		},
		{ type = "separator" },
		{
			type = "entry",
			text = ni.spell.icon(18562) .. " Swiftmend",
			tooltip =
			"Usar spell cuando un aliado |cff00D700HP|r < %.",
			enabled = true,
			value = 60,
			min = 10,
			max = 100,
			step = 1,
			width = 40,
			key =
			"swift"
		},
		{
			type = "entry",
			text = ni.spell.icon(17116) .. " Nature's Swiftness",
			tooltip =
			"Usar spell cuando el procentaje|cff00D700HP|r < %.\n se usara h[Healing Touch].",
			enabled = true,
			value = 40,
			min = 10,
			max = 100,
			step = 1,
			width = 40,
			key =
			"natureswift"
		},
		{ type = "separator" },
		{
			type = "entry",
			text = ni.spell.icon(48447) .. " Tranquility",
			tooltip =
			"Spell se usara cuando el hp |cff00D700HP|r\nde un especifico numero de aliados < %.",
			enabled = true,
			key =
			"tranquil"
		},
		{
			type = "entry",
			text = "Tranquility (Ally HP)",
			tooltip =
			"Adjust ally average |cff00D700HP|r < %.",
			value = 37,
			min = 25,
			max = 100,
			step = 1,
			width = 40,
			key =
			"tranquilhp"
		},
		{
			type = "entry",
			text = "Tranquility (Ally Count)",
			tooltip =
			"Ajustar el numero de aliados en tu party",
			value = 4,
			min = 2,
			max = 5,
			step = 1,
			width = 40,
			key =
			"tranquilcount"
		},
		{ type = "separator" },
		{ type = "title",    text = "Dispel" },
		{ type = "separator" },
		{
			type = "entry",
			text = ni.spell.icon(2782) .. " Remove Curse (Ally)",
			tooltip =
			"Auto dispel debuffs de los aliados",
			enabled = true,
			key =
			"removecurse"
		},
		{
			type = "entry",
			text = ni.spell.icon(2893) .. " Abolish Poison (Ally)",
			tooltip =
			"Auto dispel debuffs de los aliado.",
			enabled = true,
			key =
			"ambolishpoison"
		},
		{
			type = "page",
			number = 3,
			text =
			"|cff95f900Party/Raid Healing Settings|r"
		},
		{ type = "separator" },
		{
			type = "entry",
			text = ni.spell.icon(48441) .. " Rejuvenation",
			tooltip =
			"Usar hechizo cuando el aliado|cff00D700HP|r < %.",
			enabled = true,
			value = 100,
			min = 10,
			max = 100,
			step = 1,
			width = 40,
			key =
			"rejuall"
		},
		{
			type = "entry",
			text = ni.spell.icon(48438) .. " Wild Growth",
			tooltip =
			"Usar hechizo cuando el aliado |cff00D700HP|r < %.",
			enabled = true,
			value = 100,
			min = 10,
			max = 100,
			step = 1,
			width = 40,
			key =
			"growth"
		},
		{
			type = "entry",
			text = ni.spell.icon(50464) .. " Nourish",
			tooltip =
			"Usar hechizo cuando el aliado|cff00D700HP|r < %.",
			enabled = true,
			value = 99,
			min = 10,
			max = 100,
			step = 1,
			width = 40,
			key =
			"nourish"
		},
		{ type = "page",     number = 4, text = "|cff95f900Tank Settings|r" },
		{ type = "separator" },
		{
			type = "entry",
			text = ni.spell.icon(2565) .. " Auto Track Tank",
			tooltip =
			"Auto track tank y principalmente curarlo.\nDruid support MAIN TANK y OFF TANK.",
			enabled = true,
			key =
			"healtank"
		},
		{
			type = "entry",
			text = ni.spell.icon(48441) .. " Rejuvenation",
			tooltip =
			"Siempre tener [Rejuvenation] en el maintank u offtank",
			enabled = true,
			key =
			"rejuTanks"
		},
		{
			type = "entry",
			text = ni.spell.icon(50464) .. " Nourish",
			tooltip =
			"Usar hechizo cuando los tankes |cff00D700HP|r < %.",
			enabled = true,
			value = 70,
			min = 10,
			max = 100,
			step = 1,
			width = 40,
			key =
			"nouriTanks"
		},
		{ type = "page",     number = 5, text = "|cff00C957Defensivo Settings" },
		{ type = "separator" },
		{
			type = "entry",
			text = ni.spell.icon(22812) .. " Barkskin",
			tooltip =
			"Usar el hechizo ccuando |cff00D700HP|r < %.",
			enabled = true,
			value = 40,
			min = 15,
			max = 100,
			step = 1,
			width = 40,
			key =
			"barkskin"
		},
	};
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
		ni.GUI.AddFrame("Wrath_Restoration_DarhangeR", items);
	end;
	local function OnUnLoad()
		ni.GUI.DestroyFrame("Wrath_Restoration_DarhangeR");
	end;
	local function UsableSilence(spellid, stutter)
		if tonumber(spellid) == nil then
			spellid = ni.spell.id(spellid)
		end
		local result = false;
		if spellid == nil or spellid == 0 then
			return false;
		end
		local spellName = GetSpellInfo(spellid);
		if not ni.player.isstunned()
				and not ni.player.issilenced()
				and ni.spell.available(spellid, stutter)
				and IsUsableSpell(spellName) then
			result = true;
		end
		return result;
	end;
	local spells = {
		MarkOfTheWild = GetSpellInfo(48469),
		GiftOfTheWild = GetSpellInfo(48470),
		TreeOfLife = GetSpellInfo(33891),
		Thorns = GetSpellInfo(53307),
		Innervate = GetSpellInfo(29166),
		Barkskin = GetSpellInfo(22812),
		Lifebloom = GetSpellInfo(48451),
		Rejuvenation = GetSpellInfo(48441),
		Regrowth = GetSpellInfo(48443),
		Nourish = GetSpellInfo(50464),
		WildGrowth = GetSpellInfo(53251),
		Tranquility = GetSpellInfo(48447),
		HealingTouch = GetSpellInfo(48378),
		NatureSwiftness = GetSpellInfo(17116),
		Swiftmend = GetSpellInfo(18562),
		RemoveCurse = GetSpellInfo(2782),
		AbolishPoison = GetSpellInfo(2893),
		Cyclone = GetSpellInfo(33786),
		-- Proc --
		Clearcasting = GetSpellInfo(16870),
	};
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
	function Loot(guid)
		if ni.player.distance(guid) < 1
				and not ni.player.ismoving()
				and not movingToCorpse
		then
			ni.player.interact(guid)
			if _G.LootFrame:IsShown() then
				for i = 1, GetNumLootItems() do
					looting = true
					LootSlot(i)
				end
				if looting then
					ni.delayfor(1, function()
						looting = false
						LootedUnits[guid] = true
						CloseLoot()
					end)
				end
			end
			return true -- Devuelve true para indicar que la función está en proceso de saqueo
		end
		return false -- Devuelve false si no se cumplieron las condiciones para saquear
	end

	local cache = {
		IsMoving = false,
		PlayerCombat = false,
	};
	local queue = {
		"Cache",
		"AutoLoot",
		-- "Jump",
		"Follow",
		"Universal Pause",
		"Gift of the Wild",
		"Thorns",
		"Barkskin",
		"Combat Specific Pause",
		"Tree of Life",
		-- "Nature's Swiftness",
		"Swiftmend",
		"Wild Growth",
		-- "Tank Heal",
		-- "Infinitemana",
		-- "Regrowth",
		"Rejuvenationall",
		-- "Rejuvenation",
		-- "Remove Curse (Ally)",
		-- "Abolish Poison (Ally)",
		"Nourish",
	};
	local abilities = {
		-----------------------------------
		["Cache"] = function()
			if GetTime() - AntiAFKTime > 80 then
				ni.utils.resetlasthardwareaction();
				AntiAFKTime = GetTime();
			end
			cache.IsMoving = ni.player.ismoving() or false;
			cache.PlayerCombat = UnitAffectingCombat("player") or false;
		end,
		-----------------------------------
		["Universal Pause"] = function()
			if IsMounted()
					or UnitInVehicle("player")
					or UnitIsDeadOrGhost("player")
					or UnitChannelInfo("player")
					or UnitCastingInfo("player")
			then
				return true;
			end
			ni.vars.debug = select(2, GetSetting("Debug"));
		end,
		-----------------------------------
		["Jump"] = function()
			if not looting
					and not movingToCorpse
			then
				if cache.PlayerCombat
				then
					if ni.spell.gcd()
							and not UnitCastingInfo("player")
					then
						ni.functions.callprotected("JumpOrAscendStart");
					end
				else
					ni.functions.callprotected("JumpOrAscendStart");
				end
			end
		end,

		["AutoLoot"] = function()
			if not looting
					and BagSpace() > 0
					and not ni.player.ismounted()
					and not ni.player.iscasting()
					and not ni.player.ischanneling()
			then
				if not movingToCorpse then
					local tempTbl = {}
					for g, o in pairs(ni.objects) do
						if type(g) ~= "function" and type(g) == "string" and type(o) == "table" then
							if not LootedUnits[g] and o:unit() and UnitIsDead(g) and ni.unit.islootable(g) and o:los("player") then
								table.insert(tempTbl, { guid = g, distance = o:distance() })
							end
						end
					end
					if next(tempTbl) == nil
					then
						return
					end
					table.sort(tempTbl, function(a, b) return a.distance < b.distance end)
					movingToCorpse = tempTbl[1].guid
					ni.player.moveto(movingToCorpse)
					return true
				elseif ni.player.distance(movingToCorpse) < 2
						and not ni.player.ismoving()
				then
					local tmpCorpse = movingToCorpse
					movingToCorpse = nil
					return Loot(tmpCorpse)
				end
			end
		end,
		["Follow"] = function()
			if not lastclick then lastclick = 0 end

			local unit = ni.vars.units.follow
			if unit == nil or unit == "" then
				return
			end
			local uGUID = UnitGUID(unit) or ni.objectmanager.objectGUID(unit);
			local mtime = math.random(0.2, 0.5)
			local followTar = nil;
			local distance = nil;
			if UnitExists(unit)
					and not looting
					and not movingToCorpse then
				if UnitAffectingCombat(uGUID)
						and ni.vars.combat.melee == true then
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
							and not movingToCorpse
							and not UnitChannelInfo("player")
							and distance ~= nil and distance > 10 and distance < 45
							and GetTime() - lastclick > tonumber(format("%.1f", mtime)) then
						ni.player.moveto(uGUID)
						lastclick = GetTime()
					end
				end

				if not looting
						and not movingToCorpse
						and distance ~= nil and distance <= 10 and ni.player.ismoving() then
					ni.player.stopmoving()
				end
			end
		end,


		["Gift of the Wild"] = function()
			local _, enabled = GetSetting("AutoBuff");
			if not enabled then
				return false;
			end
			if cache.PlayerCombat
					or ni.player.buff(spells.MarkOfTheWild)
					or ni.player.buff(spells.GiftOfTheWild) then
				return false;
			end
			if UsableSilence(spells.GiftOfTheWild) then
				ni.spell.cast(spells.GiftOfTheWild, "player")
				return true;
			end
			if UsableSilence(spells.MarkOfTheWild)
					and not UsableSilence(spells.GiftOfTheWild) then
				ni.spell.cast(spells.MarkOfTheWild, "player")
				return true;
			end
		end,
		-----------------------------------
		["Thorns"] = function()
			local _, enabled = GetSetting("AutoBuff");
			if not enabled then
				return false;
			end
			if cache.PlayerCombat then
				return false;
			end
			if UsableSilence(spells.Thorns)
					and not ni.player.buff(spells.Thorns) then
				ni.spell.cast(spells.Thorns, "player")
				return true;
			end
		end,
		-----------------------------------	
		["Tree of Life"] = function()
			local _, enabled = GetSetting("autoform");
			if not enabled then
				return false;
			end
			if UsableSilence(spells.TreeOfLife)
					and not ni.unit.buff("player", 33891, "EXACT")
			then
				ni.spell.cast(spells.TreeOfLife)
				return true;
			end
		end,
		--------------------- =--------------	
		["Infinitemana"] = function()
			if ni.player.power("mana") < 76
					and ni.player.buff(spells.Clearcasting)
			then
				for i = 1, #ni.members.sort() do
					local ally = ni.members[i];
					if not ally:buff(spells.Lifebloom)
							and ally:valid(spells.Lifebloom, false, true)
					then
						ni.spell.cast(spells.Lifebloom, ally.unit)
					end
				end
			end
		end,
		["Barkskin"] = function()
			local value, enabled = GetSetting("barkskin");
			if not enabled
					or cache.PlayerCombat then
				return false;
			end
			if ni.player.hp() <= value
					and ni.spell.available(spells.Barkskin)
					and not ni.player.buff(spells.Barkskin) then
				ni.spell.cast(spells.Barkskin)
				return true;
			end
		end,
		-----------------------------------	
		["Combat Specific Pause"] = function()
			if cache.PlayerCombat then
				return false;
			end
			for i = 1, #ni.members do
				local ally = ni.members[i];
				if ally:combat() then
					return false;
				end
			end
			return true;
		end,
		-----------------------------------
		["Swiftmend"] = function()
			local value, enabled = GetSetting("swift");
			if not enabled or not ni.spell.available(spells.Swiftmend) then
				return false;
			end
			for i = 1, #ni.members do
				local ally = ni.members[i];
				if ally:hp() <= value then
					local hasRejuv = ally:buff(spells.Rejuvenation);
					local hasRegrowth = ally:buff(spells.Regrowth);
					-- if ally.auras(spells.Rejuvenation .. "||" .. spells.Regrowth)
					if (hasRejuv or hasRegrowth)
							and ni.spell.valid(ally.unit, spells.Swiftmend, false, true, true)
					then
						print("Casting Swiftmend on", ally.unit) -- Para fines de depuración
						ni.spell.cast(spells.Swiftmend, ally.unit)
						return true;
					end
				end
			end
		end,


		-----------------------------------
		["Nature's Swiftness"] = function()
			local value, enabled = GetSetting("natureswift");
			if not enabled then
				return false;
			end
			if UsableSilence(spells.NatureSwiftness)
					and UsableSilence(spells.HealingTouch)
					and (ni.spell.cd(spells.Swiftmend) ~= 0
						and ni.spell.cd(spells.Swiftmend) > 1.5) then
				local allyOne = ni.members[1];
				if allyOne:hp() <= value
						and allyOne:valid(allyOne, spells.HealingTouch, false, true) then
					ni.spell.cast(spells.NatureSwiftness)
					ni.spell.cast(spells.HealingTouch, allyOne.unit)
					return true;
				end
			end
		end,
		-----------------------------------			
		["Tranquility"] = function()
			if not ui("tranquil")[2]
					or cache.IsMoving then
				return false;
			end
			local value = ui("tranquilhp")[1];
			local total = members.subgroupbelow(value, 30, true);
			if total >= ui("tranquilcount")[1]
					and usableSilence(spells.Tranquility) then
				spellCast(spells.Tranquility)
				return true;
			end
		end,
		-----------------------------------		
		["Tank Heal"] = function()
			local mainTank, offTank = ni.tanks();
			local _, enabled = GetSetting("healtank");
			local _, rejEnable = GetSetting("rejuTanks");
			local nourVal, nourEnable = GetSetting("nouriTanks");
			if not enabled then
				return false;
			end
			if mainTank then
				if UnitExists(mainTank.unit)
						and ni.spell.valid(mainTank.unit, spells.HealingTouch, false, true, true) then
					if nourEnable then
						if not cache.IsMoving
								and ni.unit.hp(mainTank.unit) <= nourVal
								and UsableSilence(spells.Nourish) then
							if (ni.unit.buff(mainTank.unit, spells.Rejuvenation)
										or ni.unit.buff(mainTank.unit, spells.WildGrowth)) then
								ni.spell.cast(spells.Nourish, mainTank.unit)
								return true;
							end
						end
					end
					if rejEnable then
						if UsableSilence(spells.Rejuvenation)
								and not ni.unit.buff(mainTank.unit, spells.Rejuvenation, "player") then
							ni.spell.cast(spells.Rejuvenation, mainTank.unit)
							return true;
						end
					end
				end
			end
			if offTank then
				if UnitExists(offTank.unit)
						and ni.spell.valid(offTank.unit, spells.HealingTouch, false, true, true) then
					if nourEnable then
						if not cache.IsMoving
								and ni.unit.hp(offTank.unit) <= nourVal
								and UsableSilence(spells.Nourish) then
							if (ni.unit.buff(offTank.unit, spells.Rejuvenation)
										or ni.unit.buff(offTank.unit, spells.WildGrowth)) then
								ni.spell.cast(spells.Nourish, offTank.unit)
								return true;
							end
						end
					end
					if rejEnable then
						if UsableSilence(spells.Rejuvenation)
								and not ni.unit.buff(offTank.unit, spells.Rejuvenation, "player") then
							ni.spell.cast(spells.Rejuvenation, offTank.unit)
							return true;
						end
					end
				end
			end
		end,
		-----------------------------------			
		["Remove Curse (Ally)"] = function()
			local _, enabled = GetSetting("removecurse");
			if not enabled
					or not UsableSilence(spells.RemoveCurse) then
				return false;
			end
			for i = 1, #ni.members.sort() do
				local ally = ni.members[i];
				if ally:debufftype("Curse")
						and ally:dispel()
						and ni.spell.lastcast(spells.RemoveCurse, 1.8)
						and ally:valid(spells.RemoveCurse, false, true) then
					ni.spell.cast(spells.RemoveCurse, ally.unit)
					return true;
				end
			end
		end,
		-----------------------------------	
		["Abolish Poison (Ally)"] = function()
			local _, enabled = GetSetting("removecurse");
			if not enabled
					or not UsableSilence(spells.AbolishPoison) then
				return false;
			end
			for i = 1, #ni.members.sort() do
				local ally = ni.members[i];
				if ally:debufftype("Poison")
						and ally:dispel()
						and not ally:aura(spells.AbolishPoison)
						and ni.spell.lastcast(spells.AbolishPoison, 1.8)
						and ally:valid(spells.AbolishPoison, false, true) then
					ni.spell.cast(spells.AbolishPoison, ally.unit)
					return true;
				end
			end
		end,
		-----------------------------------	
		["Rejuvenation"] = function()
			local value, enabled = GetSetting("rejuall");
			if not enabled then
				return false;
			end
			if UsableSilence(spells.Rejuvenation) then
				for i = 1, #ni.members do
					local ally = ni.members[i];
					if ally:hp() <= value
							and not ally:buff(spells.Rejuvenation, "player")
							and ally:valid(spells.Rejuvenation, false, true) then
						ni.spell.cast(spells.Rejuvenation, ally.unit)
						return true;
					end
				end
			end
		end,
		-----------------------------------	
		-- ["Rejuvenationall"] = function()
		-- 	local value, enabled = GetSetting("rejuall");
		-- 	if not enabled then
		-- 		return false;
		-- 	end
		-- 	if UsableSilence(spells.Rejuvenation) then
		-- 		-- Revisa miembros desde el grupo 5 al 1 para aplicar Rejuvenation
		-- 		for subgroup = 5, 1, -1 do -- Empieza desde el grupo 5 y ve hacia atrás hasta el 1
		-- 			for i = 1, #ni.members do
		-- 				local member = ni.members[i];
		-- 				if member.subgroup == subgroup and member:hp() <= value and not member:buff(spells.Rejuvenation, "player") and member:valid(spells.Rejuvenation, false, true) then
		-- 					ni.spell.cast(spells.Rejuvenation, member.unit);
		-- 					return true; -- Detiene la iteración después de lanzar para asegurar prioridad
		-- 				end
		-- 			end
		-- 		end
		-- 	end
		-- end,

		["Rejuvenationall"] = function()
			local value, enabled = GetSetting("rejuall");
			if not enabled then
				return false;
			end
			if UsableSilence(spells.Rejuvenation) then
				-- Revisa miembros desde el grupo 1 al 5 pero se salta el grupo 4
				for subgroup = 1, 5 do -- Empieza desde el grupo 1 y avanza hasta el 5
					if subgroup ~= 4 then -- Se salta el grupo 4
						for i = 1, #ni.members do
							local member = ni.members[i];
							if member.subgroup == subgroup and member:hp() <= value and not member:buff(spells.Rejuvenation, "player") and member:valid(spells.Rejuvenation, false, true) then
								ni.spell.cast(spells.Rejuvenation, member.unit);
								return true; -- Detiene la iteración después de lanzar para asegurar prioridad
							end
						end
					end
				end
			end
		end,


		["Nourish"] = function()
			local value, enabled = GetSetting("nourish");
			if not enabled
					or cache.IsMoving then
				return false;
			end
			if UsableSilence(spells.Nourish)
					and ni.player.buff(75490) --scale active
			then
				for i = 1, #ni.members do
					local ally = ni.members[i];
					if ally:hp() <= value
							and ally:auras(spells.Rejuvenation .. "||" .. spells.Regrowth .. "||" .. spells.Lifebloom .. "||" .. spells.WildGrowth)
							and ally:valid(spells.Nourish, false, true) then
						ni.spell.cast(spells.Nourish, ally.unit)
						return true;
					end
				end
			end
		end,

		["Regrowth"] = function()
			if UsableSilence(spells.Regrowth) then
				for i = 1, #ni.members do
					local ally = ni.members[i];
					if ally:hp() <= 85
							and not ally:auras(spells.Regrowth)
							and ally:valid(spells.Regrowth, false, true) then
						ni.spell.cast("Regrowth", ally.unit)
						return true;
					end
				end
			end
		end,
		-----------------------------------	
		["Wild Growth"] = function()
			if not UsableSilence(spells.WildGrowth) then
				return false;
			end
			-- Encuentra el mejor objetivo para Wild Growth
			local target = ni.members.sort(function(a, b) return a.hp < b.hp end)[1];
			if target and target:valid(spells.WildGrowth, false, true) then
				ni.spell.cast(spells.WildGrowth, target.unit)
				return true;
			end
		end,
	};


	ni.bootstrap.profile("Dalvae-RestoDruid", queue, abilities, OnLoad, OnUnLoad);
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not wotlk then
				ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
			end
		end,
	};
	ni.bootstrap.profile("Dalvae-RestoDruid", queue, abilities);
end;
