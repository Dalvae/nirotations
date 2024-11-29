local GetBuildInfo, select, ipairs, pairs, tonumber, GetSpellInfo, IsUsableSpell, GetTime, UnitAffectingCombat, IsMounted, ni_tanks, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, UnitCastingInfo =
		GetBuildInfo, select, ipairs, pairs, tonumber, GetSpellInfo, IsUsableSpell, GetTime, UnitAffectingCombat, IsMounted,
		ni.tanks, UnitInVehicle, UnitIsDeadOrGhost, UnitChannelInfo, UnitCastingInfo
local build = select(4, GetBuildInfo())
local wotlk = build == 30300 or false
if wotlk
then
	local AntiAFKTime = 0
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
	}
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
	end
	local function OnLoad()
		ni.GUI.AddFrame("Wrath_Restoration_DarhangeR", items)
	end
	local function OnUnLoad()
		ni.GUI.DestroyFrame("Wrath_Restoration_DarhangeR")
	end
	local function UsableSilence(spellid, stutter)
		if tonumber(spellid) == nil then
			spellid = ni.spell.id(spellid)
		end
		local result = false
		if spellid == nil or spellid == 0 then
			return false
		end
		local spellName = GetSpellInfo(spellid)
		if not ni.player.isstunned()
				and not ni.player.issilenced()
				and ni.spell.available(spellid, stutter)
				and IsUsableSpell(spellName) then
			result = true
		end
		return result
	end

	SLASH_STOPGASTING1          = "/stopgasting"
	SlashCmdList["STOPGASTING"] = function()
		ni.rotation.delay(1)
	end

	local spells                = {
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
		Dash = GetSpellInfo(33357),
		-- Proc --
		Clearcasting = (16870),
	}

	local cache                 = {
		IsMoving = false,
		PlayerCombat = false,
		SortedMembers = {},
	}
	local queue                 = {
		"Cache",
		"Universal Pause",
		"Gift of the Wild",
		"Thorns",
		"Barkskin",
		"Combat Specific Pause",
		"Tree of Life",
		"Nature's Swiftness",
		"Swiftmend",
		"Infinitemana",
		"Wild Growth",
		"Tank Heal",
		-- "Rejuvenationall",
		-- "RejuvenationallInverse",
		"Rejuvenation",
		"Regrowth",
		"Remove Curse (Ally)",
		"Abolish Poison (Ally)",
		"Nourish",
	}
	local abilities             = {
		-----------------------------------
		["Cache"] = function()
			if GetTime() - AntiAFKTime > 80 then
				ni.utils.resetlasthardwareaction()
				AntiAFKTime = GetTime()
			end
			cache.IsMoving = ni.player.ismoving() or false
			cache.PlayerCombat = UnitAffectingCombat("player") or false
			cache.SortedMembers = ni.members.sort()
			local mainTank, offTank = ni.tanks()
			cache.TankUnits = { mainTank, offTank }
		end,
		-----------------------------------
		["Universal Pause"] = function()
			if IsMounted()
					or UnitInVehicle("player")
					or UnitIsDeadOrGhost("player")
					or UnitChannelInfo("player")
					or UnitCastingInfo("player")
			then
				return true
			end
			ni.vars.debug = select(2, GetSetting("Debug"))
		end,
		-----------------------------------
		["Gift of the Wild"] = function()
			local _, enabled = GetSetting("AutoBuff")
			if not enabled then
				return false
			end
			if cache.PlayerCombat
					or ni.player.buff(spells.MarkOfTheWild)
					or ni.player.buff(spells.GiftOfTheWild) then
				return false
			end
			if UsableSilence(spells.GiftOfTheWild) then
				ni.spell.cast(spells.GiftOfTheWild, "player")
				return true
			end
			if UsableSilence(spells.MarkOfTheWild)
					and not UsableSilence(spells.GiftOfTheWild) then
				ni.spell.cast(spells.MarkOfTheWild, "player")
				return true
			end
		end,
		-----------------------------------
		["Thorns"] = function()
			local _, enabled = GetSetting("AutoBuff")
			if not enabled then
				return false
			end
			if cache.PlayerCombat then
				return false
			end
			if UsableSilence(spells.Thorns)
					and not ni.player.buff(spells.Thorns) then
				ni.spell.cast(spells.Thorns, "player")
				return true
			end
		end,
		-----------------------------------	
		["Tree of Life"] = function()
			local _, enabled = GetSetting("autoform")
			if not enabled then
				return false
			end
			if UsableSilence(spells.TreeOfLife)
					and not ni.unit.buff("player", 33891, "EXACT")
					and not ni.player.buff(spells.Dash)
			then
				ni.spell.cast(spells.TreeOfLife)
				return true
			end
		end,
		-- --------------------- =--------------	
		-- ["Infinitemana"] = function()
		-- 	local mainTank, offTank = ni.tanks()
		-- 	if mainTank then
		-- 		if UnitExists(mainTank.unit) and ni.player.buff(spells.Clearcasting) then
		-- 			if ni.spell.valid(mainTank.unit, spells.Lifebloom, false, true, true)
		-- 					and ni.unit.buffstacks(mainTank.unit, spells.Lifebloom, "player") < 3
		-- 			then
		-- 				ni.spell.cast(spells.Lifebloom, mainTank.unit)
		-- 				return true
		-- 			elseif offTank and UnitExists(offTank.unit)
		-- 					and ni.spell.valid(offTank.unit, spells.Lifebloom, false, true, true)
		-- 					and ni.unit.buffstacks(offTank.unit, spells.Lifebloom, "player") < 3
		-- 			then
		-- 				ni.spell.cast(spells.Lifebloom, offTank.unit)
		-- 				return true
		-- 			else
		-- 				local lowestHPMember = nil
		-- 				local lowestHP = 100

		-- 				for i = 1, #ni.members do
		-- 					local member = ni.members[i]
		-- 					if member:hp() < lowestHP and ni.spell.valid(member.unit, spells.Lifebloom, false, true, true) then
		-- 						lowestHPMember = member
		-- 						lowestHP = member:hp()
		-- 					end
		-- 				end

		-- 				if lowestHPMember then
		-- 					ni.spell.cast(spells.Lifebloom, lowestHPMember.unit)
		-- 					return true
		-- 				end
		-- 			end
		-- 		end
		-- 	end
		-- 	return false
		-- end,
		["Infinitemana"] = function()
			if not ni.player.buff(spells.Clearcasting) then
				return false
			end

			-- Primero, intenta aplicar Lifebloom a los tanques
			for _, tank in ipairs(cache.TankUnits) do
				if tank and UnitExists(tank.unit) and
						ni.spell.valid(tank.unit, spells.Lifebloom, false, true, true) and
						ni.unit.buffstacks(tank.unit, spells.Lifebloom, "player") < 3 then
					ni.spell.cast(spells.Lifebloom, tank.unit)
					return true
				end
			end

			-- Si no se pudo aplicar a los tanques, busca el miembro con menos HP
			for i = 1, #cache.SortedMembers do
				local member = cache.SortedMembers[i]
				if ni.spell.valid(member.unit, spells.Lifebloom, false, true, true) then
					ni.spell.cast(spells.Lifebloom, member.unit)
					return true
				end
			end

			return false
		end,
		["Barkskin"] = function()
			local value, enabled = GetSetting("barkskin")
			if not enabled
					or cache.PlayerCombat then
				return false
			end
			if ni.player.hp() <= value
					and ni.spell.available(spells.Barkskin)
					and not ni.player.buff(spells.Barkskin) then
				ni.spell.cast(spells.Barkskin)
				return true
			end
		end,
		-----------------------------------	
		["Combat Specific Pause"] = function()
			if cache.PlayerCombat then
				return false
			end
			for i = 1, #ni.members do
				local ally = ni.members[i]
				if ally:combat() then
					return false
				end
			end
			return true
		end,
		-----------------------------------
		["Swiftmend"] = function()
			local value, enabled = GetSetting("swift")
			if not enabled or not ni.spell.available(spells.Swiftmend) then
				return false
			end
			for i = 1, #cache.SortedMembers do
				local ally = cache.SortedMembers[i]
				if ally:hp() <= value then
					local hasRejuv = ally:buff(spells.Rejuvenation)
					local hasRegrowth = ally:buff(spells.Regrowth)
					if (hasRejuv or hasRegrowth) and ni.spell.valid(ally.unit, spells.Swiftmend, false, true, true) then
						ni.spell.cast(spells.Swiftmend, ally.unit)
						return true
					end
				end
			end
			return false
		end,

		["Nature's Swiftness"] = function()
			local value, enabled = GetSetting("natureswift")
			if not enabled then
				return false
			end
			if ni.spell.available(spells.NatureSwiftness) and ni.spell.available(spells.HealingTouch) and
					(ni.spell.cd(spells.Swiftmend) ~= 0 and ni.spell.cd(spells.Swiftmend) > 1.5) then
				for i = 1, #cache.SortedMembers do
					local member = cache.SortedMembers[i]
					if member:hp() <= value and ni.spell.valid(member.unit, spells.HealingTouch, false, true) then
						if ni.spell.cast(spells.NatureSwiftness) and ni.spell.cast(spells.HealingTouch, member.unit) then
							return true
						end
					end
				end
			end
			return false
		end,
		-----------------------------------			
		-----------------------------------		

		["Tank Heal"] = function()
			local _, enabled = GetSetting("healtank")
			local _, rejEnable = GetSetting("rejuTanks")
			local nourVal, nourEnable = GetSetting("nouriTanks")
			if not enabled then
				return false
			end

			for _, tank in ipairs(cache.TankUnits) do
				if tank and UnitExists(tank.unit) and ni.spell.valid(tank.unit, spells.HealingTouch, false, true, true) then
					if rejEnable and UsableSilence(spells.Rejuvenation) and not ni.unit.buff(tank.unit, spells.Rejuvenation, "player") then
						ni.spell.cast(spells.Rejuvenation, tank.unit)
						return true
					end

					if not cache.IsMoving and ni.unit.hp(tank.unit) <= 90 and UsableSilence(spells.Regrowth) and not ni.unit.buff(tank.unit, spells.Regrowth, "player") then
						ni.spell.cast(spells.Regrowth, tank.unit)
						return true
					end

					if nourEnable and not cache.IsMoving and ni.unit.hp(tank.unit) <= nourVal and UsableSilence(spells.Nourish) then
						if ni.unit.buff(tank.unit, spells.Rejuvenation) or ni.unit.buff(tank.unit, spells.Regrowth) or ni.unit.buff(tank.unit, spells.WildGrowth) then
							ni.spell.cast(spells.Nourish, tank.unit)
							return true
						end
					end
				end
			end
		end,
		-----------------------------------			
		["Remove Curse (Ally)"] = function()
			local _, enabled = GetSetting("removecurse")
			if not enabled or not UsableSilence(spells.RemoveCurse) then
				return false
			end
			local sortedMembers = ni.members.sort()
			for i = 1, #sortedMembers do
				local ally = sortedMembers[i]
				if ally:debufftype("Curse") then
					if ally:dispel() then
						if ally:valid(spells.RemoveCurse, false, true) then
							ni.spell.cast(spells.RemoveCurse, ally.unit)
							return true
						end
					end
				end
			end
			return false
		end, -----------------------	
		["Abolish Poison (Ally)"] = function()
			local _, enabled = GetSetting("removecurse")
			if not enabled
					or not UsableSilence(spells.AbolishPoison) then
				return false
			end
			for i = 1, #ni.members.sort() do
				local ally = ni.members[i]
				if ally:debufftype("Poison")
						and ally:dispel()
						and not ally:aura(spells.AbolishPoison)
						and ni.spell.lastcast(spells.AbolishPoison, 1.8)
						and ally:valid(spells.AbolishPoison, false, true) then
					ni.spell.cast(spells.AbolishPoison, ally.unit)
					return true
				end
			end
		end,
		-----------------------------------	
		---
		["Rejuvenation"] = function()
			local value, enabled = GetSetting("rejuall")
			if not enabled or not UsableSilence(spells.Rejuvenation) then
				return false
			end
			for i = 1, #cache.SortedMembers do
				local ally = cache.SortedMembers[i]
				if ally:hp() > value then
					break -- Detiene la iteración si el HP del aliado es mayor que el valor umbral
				end
				if not ally:buff(spells.Rejuvenation, "player") and ally:valid(spells.Rejuvenation, false, true) then
					ni.spell.cast(spells.Rejuvenation, ally.unit)
					return true
				end
			end
		end,
		-----------------------------------	
		-- ["Rejuvenationall"] = function()
		-- 	local value, enabled = GetSetting("rejuall")
		-- 	if not enabled then
		-- 		return false
		-- 	end
		-- 	if UsableSilence(spells.Rejuvenation) then
		-- 		-- Revisa miembros desde el grupo 5 al 1 para aplicar Rejuvenation
		-- 		for subgroup = 5, 1, -1 do -- Empieza desde el grupo 5 y ve hacia atrás hasta el 1
		-- 			for i = 1, #ni.members do
		-- 				local member = ni.members[i]
		-- 				if member.subgroup == subgroup and member:hp() <= value and not member:buff(spells.Rejuvenation, "player") and member:valid(spells.Rejuvenation, false, true) then
		-- 					ni.spell.cast(spells.Rejuvenation, member.unit)
		-- 					return true -- Detiene la iteración después de lanzar para asegurar prioridad
		-- 				end
		-- 			end
		-- 		end
		-- 	end
		-- end,

		["Rejuvenationall"] = function()
			local value, enabled = GetSetting("rejuall")
			if not enabled then
				return false
			end
			if not ni.vars.combat.aoe then
				if UsableSilence(spells.Rejuvenation) then
					-- Revisa miembros desde el grupo 1 al 5 pero se salta el grupo 4
					for subgroup = 1, 5 do -- Empieza desde el grupo 1 y avanza hasta el 5
						if subgroup ~= 4 then -- Se salta el grupo 4
							for i = 1, #ni.members do
								local member = ni.members[i]
								if member.subgroup == subgroup and member:hp() <= value and not member:buff(spells.Rejuvenation, "player") and member:valid(spells.Rejuvenation, false, true) then
									ni.spell.cast(spells.Rejuvenation, member.unit)
									return true -- Detiene la iteración después de lanzar para asegurar prioridad
								end
							end
						end
					end
				end
			end
		end,
		["RejuvenationallInverse"] = function()
			local value, enabled = GetSetting("rejuall")

			if not enabled then
				return false
			end

			if ni.vars.combat.aoe then
				if UsableSilence(spells.Rejuvenation) then
					-- Revisa miembros desde el grupo 5 al 1 en orden inverso
					for subgroup = 5, 1, -1 do
						for i = #ni.members, 1, -1 do
							local member = ni.members[i]
							if member.subgroup == subgroup and member:hp() <= value and not member:buff(spells.Rejuvenation, "player") and member:valid(spells.Rejuvenation, false, true) then
								ni.spell.cast(spells.Rejuvenation, member.unit)
								return true -- Detiene la iteración después de lanzar para asegurar prioridad
							end
						end
					end
				end
			end
		end,

		["Nourish"] = function()
			local value, enabled = GetSetting("nourish")
			if not enabled or cache.IsMoving or not UsableSilence(spells.Nourish) or not ni.player.buff(75490) then
				return false
			end
			for i = 1, #cache.SortedMembers do
				local ally = cache.SortedMembers[i]
				if ally:hp() > value then
					break -- Detiene la iteración si el HP del aliado es mayor que el valor umbral
				end
				if ally:auras(spells.Rejuvenation .. "||" .. spells.Regrowth .. "||" .. spells.Lifebloom .. "||" .. spells.WildGrowth)
						and ally:valid(spells.Nourish, false, true) then
					ni.spell.cast(spells.Nourish, ally.unit)
					return true
				end
			end
		end,

		["Regrowth"] = function()
			if UsableSilence(spells.Regrowth) then
				for i = 1, #ni.members do
					local ally = ni.members[i]
					if ally:hp() <= 75
							and not ally:auras(spells.Regrowth)
							and ally:valid(spells.Regrowth, false, true) then
						ni.spell.cast("Regrowth", ally.unit)
						return true
					end
				end
			end
		end,
		-----------------------------------	
		["Wild Growth"] = function()
			local value, enabled = GetSetting("growth")
			if not enabled or not UsableSilence(spells.WildGrowth) then
				return false
			end

			local alliesInRange = 0
			local targetAlly = nil

			for i = 1, #cache.SortedMembers do
				local ally = cache.SortedMembers[i]
				if ally:hp() > value then
					break -- Detiene la iteración si el HP del aliado es mayor que el valor umbral
				end
				if ally:range() and not ally:buff(spells.WildGrowth) then
					alliesInRange = alliesInRange + 1
					if not targetAlly then
						targetAlly = ally
					end
					if alliesInRange >= 3 then
						if targetAlly:valid(spells.WildGrowth, false, true) then
							ni.spell.cast(spells.WildGrowth, targetAlly.unit)
							return true
						end
						break
					end
				end
			end
			return false
		end,

		-- ["Wild Growth"] = function()
		-- 	local value, enabled = GetSetting("growth")
		-- 	if not enabled
		-- 			or not UsableSilence(spells.WildGrowth) then
		-- 		return false
		-- 	end
		-- 	local allyOne = ni.members[1]
		-- 	local ally = ni.members.inrangewithoutbuffbelow(allyOne.unit, 24, spells.WildGrowth, value)
		-- 	if #ally >= 3
		-- 			and allyOne:hp() <= value
		-- 			and allyOne:valid(spells.WildGrowth, false, true) then
		-- 		ni.spell.cast(spells.WildGrowth, allyOne.unit)
		-- 		return true
		-- 	end
		-- end,
	}

	ni.bootstrap.profile("Dalvae-RestoDruid", queue, abilities, OnLoad, OnUnLoad)
else
	local queue = {
		"Error",
	}
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false
			if not wotlk then
				ni.frames.floatingtext:message("This profile for WotLK 3.3.5a!")
			end
		end,
	}
	ni.bootstrap.profile("Dalvae-RestoDruid", queue, abilities)
end
