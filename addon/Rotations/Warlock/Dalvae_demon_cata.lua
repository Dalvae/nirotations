local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
	local queue = {
		"Soul Harvest",
		"Pause",
		"Cache",
		"SoulShatter",
		"WaitForChannel",
		"Pet Twisting",
		"SummonDemon",
		"Pet Management",
		"FelArmor",
		"Demon Soul",
		"LifeTap",
		"Metamorphosis",
		"Summon Doomguard/Infernal",
		"FelStorm",
		"Hellfire",
		"Shadowflame",
		"Corruption AoE",
		"Immolate AoE",
		"Bane of Agony AoE",
		"Shadow Bolt AoE",
		"Immolate",
		"BaneofDoom",
		"Corruption",
		"HandofGuldan",
		"ShadowFlame",
		"IncinerateMoltenCore",
		"SoulFire",
		"Incinerate",
		"ShadowBolt"
	}

	local spells = {
		--build == 40300
		--General icon = select(2, GetSpellTabInfo(1))
		AutoAttack = { id = 6603, name = GetSpellInfo(6603), icon = select(3, GetSpellInfo(6603)) },
		Shoot = { id = 5019, name = GetSpellInfo(5019), icon = select(3, GetSpellInfo(5019)) },
		--Affliction icon = select(2, GetSpellTabInfo(2))
		Corruption = { id = 172, name = GetSpellInfo(172), icon = select(3, GetSpellInfo(172)) },
		DrainLife = { id = 689, name = GetSpellInfo(689), icon = select(3, GetSpellInfo(689)) },
		LifeTap = { id = 1454, name = GetSpellInfo(1454), icon = select(3, GetSpellInfo(1454)) },
		DrainSoul = { id = 1120, name = GetSpellInfo(1120), icon = select(3, GetSpellInfo(1120)) },
		BaneofAgony = { id = 980, name = GetSpellInfo(980), icon = select(3, GetSpellInfo(980)) },
		Fear = { id = 5782, name = GetSpellInfo(5782), icon = select(3, GetSpellInfo(5782)) },
		CurseofWeakness = { id = 702, name = GetSpellInfo(702), icon = select(3, GetSpellInfo(702)) },
		BaneofDoom = { id = 603, name = GetSpellInfo(603), icon = select(3, GetSpellInfo(603)) },
		CurseofTongues = { id = 1714, name = GetSpellInfo(1714), icon = select(3, GetSpellInfo(1714)) },
		DeathCoil = { id = 6789, name = GetSpellInfo(6789), icon = select(3, GetSpellInfo(6789)) },
		HowlofTerror = { id = 5484, name = GetSpellInfo(5484), icon = select(3, GetSpellInfo(5484)) },
		CurseoftheElements = { id = 1490, name = GetSpellInfo(1490), icon = select(3, GetSpellInfo(1490)) },
		SeedofCorruption = { id = 27243, name = GetSpellInfo(27243), icon = select(3, GetSpellInfo(27243)) },
		DarkIntent = { id = 80398, name = GetSpellInfo(80398), icon = select(3, GetSpellInfo(80398)) },
		--Demonology icon = select(2, GetSpellTabInfo(3))
		DemonArmor = { id = 687, name = GetSpellInfo(687), icon = select(3, GetSpellInfo(687)) },
		DemonicKnowledge = { id = 84740, name = GetSpellInfo(84740), icon = select(3, GetSpellInfo(84740)) },
		SummonImp = { id = 688, name = GetSpellInfo(688), icon = select(3, GetSpellInfo(688)) },
		SummonVoidwalker = { id = 697, name = GetSpellInfo(697), icon = select(3, GetSpellInfo(697)) },
		SummonFelhunter = { id = 691, name = GetSpellInfo(691), icon = select(3, GetSpellInfo(691)) },
		SummonSuccubus = { id = 712, name = GetSpellInfo(712), icon = select(3, GetSpellInfo(712)) },
		SummonFelguard = { id = 30146, name = GetSpellInfo(30146), icon = select(3, GetSpellInfo(30146)) },
		CreateHealthstone = { id = 6201, name = GetSpellInfo(6201), icon = select(3, GetSpellInfo(6201)) },
		ControlDemon = { id = 93375, name = GetSpellInfo(93375), icon = select(3, GetSpellInfo(93375)) },
		Soulburn = { id = 74434, name = GetSpellInfo(74434), icon = select(3, GetSpellInfo(74434)) },
		HealthFunnel = { id = 755, name = GetSpellInfo(755), icon = select(3, GetSpellInfo(755)) },
		SoulHarvest = { id = 79268, name = GetSpellInfo(79268), icon = select(3, GetSpellInfo(79268)) },
		UnendingBreath = { id = 5697, name = GetSpellInfo(5697), icon = select(3, GetSpellInfo(5697)) },
		CreateSoulstone = { id = 693, name = GetSpellInfo(693), icon = select(3, GetSpellInfo(693)) },
		SoulLink = { id = 19028, name = GetSpellInfo(19028), icon = select(3, GetSpellInfo(19028)) },
		EyeofKilrogg = { id = 126, name = GetSpellInfo(126), icon = select(3, GetSpellInfo(126)) },
		EnslaveDemon = { id = 1098, name = GetSpellInfo(1098), icon = select(3, GetSpellInfo(1098)) },
		Banish = { id = 710, name = GetSpellInfo(710), icon = select(3, GetSpellInfo(710)) },
		ShadowWard = { id = 6229, name = GetSpellInfo(6229), icon = select(3, GetSpellInfo(6229)) },
		RitualofSummoning = { id = 698, name = GetSpellInfo(698), icon = select(3, GetSpellInfo(698)) },
		SummonInfernal = { id = 1122, name = GetSpellInfo(1122), icon = select(3, GetSpellInfo(1122)) },
		SummonDoomguard = { id = 18540, name = GetSpellInfo(18540), icon = select(3, GetSpellInfo(18540)) },
		FelArmor = { id = 28176, name = GetSpellInfo(28176), icon = select(3, GetSpellInfo(28176)) },
		Soulshatter = { id = 29858, name = GetSpellInfo(29858), icon = select(3, GetSpellInfo(29858)) },
		RitualofSouls = { id = 29893, name = GetSpellInfo(29893), icon = select(3, GetSpellInfo(29893)) },
		DemonicCircleSummon = { id = 48018, name = GetSpellInfo(48018), icon = select(3, GetSpellInfo(48018)) },
		DemonicCircleTeleport = { id = 48020, name = GetSpellInfo(48020), icon = select(3, GetSpellInfo(48020)) },
		DemonSoul = { id = 77801, name = GetSpellInfo(77801), icon = select(3, GetSpellInfo(77801)) },
		HandofGuldan = { id = 71521, name = GetSpellInfo(71521), icon = select(3, GetSpellInfo(71521)) },
		FelStorm = { id = 89751, name = GetSpellInfo(89751), icon = select(3, GetSpellInfo(89751)) },
		Metamorphosis = { id = 47241, name = GetSpellInfo(47241), icon = select(3, GetSpellInfo(47241)) },
		--Destruction icon = select(2, GetSpellTabInfo(4))
		Immolate = { id = 348, name = GetSpellInfo(348), icon = select(3, GetSpellInfo(348)) },
		ShadowBolt = { id = 686, name = GetSpellInfo(686), icon = select(3, GetSpellInfo(686)) },
		RainofFire = { id = 5740, name = GetSpellInfo(5740), icon = select(3, GetSpellInfo(5740)) },
		SearingPain = { id = 5676, name = GetSpellInfo(5676), icon = select(3, GetSpellInfo(5676)) },
		SoulFire = { id = 6353, name = GetSpellInfo(6353), icon = select(3, GetSpellInfo(6353)) },
		Hellfire = { id = 1949, name = GetSpellInfo(1949), icon = select(3, GetSpellInfo(1949)) },
		Incinerate = { id = 29722, name = GetSpellInfo(29722), icon = select(3, GetSpellInfo(29722)) },
		Shadowflame = { id = 47897, name = GetSpellInfo(47897), icon = select(3, GetSpellInfo(47897)) },
		FelFlame = { id = 77799, name = GetSpellInfo(77799), icon = select(3, GetSpellInfo(77799)) }
	}

	local IsSpellInRange, IsMounted, UnitIsDeadOrGhost, UnitExists, UnitCanAttack, IsUsableSpell =
			IsSpellInRange,
			IsMounted,
			UnitIsDeadOrGhost,
			UnitExists,
			UnitCanAttack,
			IsUsableSpell

	local enables = {
		["Summon"] = true,
		["IncinerateFiller"] = true
	}
	local values = {}
	local inputs = {}
	local menus = {
		["Summon"] = 1
	}

	local function GUICallback(key, item_type, value)
		if item_type == "enabled" then
			enables[key] = value
		elseif item_type == "value" then
			values[key] = value
		elseif item_type == "input" then
			inputs[key] = value
		elseif item_type == "menu" then
			menus[key] = value
		end
	end

	local Summon = {
		SummonImp = 1,
		SummonVoidwalker = 2,
		SummonFelhunter = 3,
		SummonFelguard = 4
	}

	local items = {
		settingsfile = "demon_cata.xml",
		callback = GUICallback,
		{ type = "title",    text = "\124T" .. select(2, GetSpellTabInfo(3)) .. ":20:20\124t Demonology Cata" },
		{ type = "separator" },
		{ type = "title",    text = "Summon Selection" },
		{
			type = "entry",
			text = "Summon Demon",
			tooltip = "Enables Summoning Demons",
			enabled = enables["Summon"],
			key = "Summon"
		},
		{
			type = "dropdown",
			menu = {
				{
					selected = (menus["Summon"] == Summon.SummonImp),
					value = Summon.SummonImp,
					text = "\124T" .. spells.SummonImp.icon .. ":20:20\124t " .. spells.SummonImp.name
				},
				{
					selected = (menus["Summon"] == Summon.SummonVoidwalker),
					value = Summon.SummonVoidwalker,
					text = "\124T" .. spells.SummonVoidwalker.icon .. ":20:20\124t " .. spells.SummonVoidwalker.name
				},
				{
					selected = (menus["Summon"] == Summon.SummonFelhunter),
					value = Summon.SummonFelhunter,
					text = "\124T" .. spells.SummonFelhunter.icon .. ":20:20\124t " .. spells.SummonFelhunter.name
				},
				{
					selected = (menus["Summon"] == Summon.SummonFelguard),
					value = Summon.SummonFelguard,
					text = "\124T" .. spells.SummonFelguard.icon .. ":20:20\124t " .. spells.SummonFelguard.name
				}
			},
			key = "Summon"
		},
		{ type = "separator" },
		{
			type = "dropdown",
			menu = {
				{
					selected = true,
					value = 1,
					text = "\124T" .. spells.SummonDoomguard.icon .. ":20:20\124t " .. spells.SummonDoomguard.name
				},
				{
					selected = false,
					value = 2,
					text = "\124T" .. spells.SummonInfernal.icon .. ":20:20\124t " .. spells.SummonInfernal.name
				}
			},
			key = "GuardianChoice"
		},
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.Incinerate.icon .. ":20:20\124t " .. spells.Incinerate.name .. " Filler",
			tooltip = "Use Incinerate as the filler spell, will use shadowbolt if diabled",
			enabled = enables["IncinerateFiller"],
			key = "IncinerateFiller"
		}
	}

	local incombat = false
	local function CombatEventCatcher(event, ...)
		if event == "PLAYER_REGEN_DISABLED" then
			incombat = true
		elseif event == "PLAYER_REGEN_ENABLED" then
			incombat = false
		end
	end
	local function OnLoad()
		ni.combatlog.registerhandler("d-Cata", CombatEventCatcher)
		ni.GUI.AddFrame("d-Cata", items)
	end
	local function OnUnload()
		ni.combatlog.unregisterhandler("d-Cata")
		ni.GUI.DestroyFrame("d-Cata")
	end

	local enemies = {}

	local function ActiveEnemies()
		table.wipe(enemies)
		enemies = ni.player.enemiesinrange(40)
		for k, v in ipairs(enemies) do
			if ni.player.threat(v.guid) == -1 then
				table.remove(enemies, k)
			end
		end
		return #enemies
	end

	local function FacingLosCast(spell, tar)
		if ni.player.isfacing(tar, 145) and ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
			ni.spell.cast(spell, tar)
			ni.debug.log(string.format("Casting %s on %s", spell, tar))
			return true
		end
		return false
	end

	local function ValidUsable(id, tar)
		if ni.spell.available(id) and ni.spell.valid(tar, id, true, true) then
			return true
		end
		return false
	end

	local soulShards = 0

	local function CanUseSoulburn()
		return soulShards > 0
	end
	local cache = {
		targets = nil,
		moving = ni.player.ismoving(),
		curchannel = nil,
		iscasting = nil
	}

	local t, p = "target", "player"

	local MoltenCore, Decimation = GetSpellInfo(71165), GetSpellInfo(63167)

	local abilities = {
		["Pause"] = function()
			if
					IsMounted() or not UnitAffectingCombat("player") or UnitIsDeadOrGhost(p) or not UnitExists(t) or UnitIsDeadOrGhost(t) or
					(UnitExists(t) and not UnitCanAttack(p, t))
			then
				return true
			end
		end,
		["Cache"] = function()
			cache.targets = ActiveEnemies()
			cache.moving = ni.player.ismoving()
			cache.curchannel = UnitChannelInfo(p)
			cache.iscasting = UnitCastingInfo(p)
		end,
		["WaitForChannel"] = function()
			if cache.curchannel == spells.DrainLife.name or cache.curchannel == spells.DrainSoul.name then
				return true
			end
		end,
		["SummonDemon"] = function()
			if (not (UnitExists("pet") == 1) or UnitIsDeadOrGhost("pet")) and not cache.moving then
				if menus["Summon"] == Summon.SummonImp and ni.spell.available(spells.SummonImp.name) then
					ni.spell.cast(spells.SummonImp.name)
					return true
				elseif menus["Summon"] == Summon.SummonVoidwalker and ni.spell.available(spells.SummonVoidwalker.name) then
					ni.spell.cast(spells.SummonVoidwalker.name)
					return true
				elseif menus["Summon"] == Summon.SummonFelguard and ni.spell.available(spells.SummonFelguard.name) then
					ni.spell.cast(spells.SummonFelguard.name)
					return true
				end
			end
		end,
		["FelArmor"] = function()
			if ni.spell.available(spells.FelArmor.id) and not ni.player.buff(spells.FelArmor.id) then
				ni.spell.cast(spells.FelArmor.id)
				return true
			end
		end,
		["ShadowBolt"] = function()
			if not cache.moving and ValidUsable(spells.ShadowBolt.id, t) and FacingLosCast(spells.ShadowBolt.name, t) then
				return true
			end
		end,
		["Immolate"] = function()
			if
					not cache.moving and ValidUsable(spells.Immolate.id, t) and ni.unit.debuffremaining(t, spells.Immolate.id, p) < 1 and
					FacingLosCast(spells.Immolate.name, t)
			then
				return true
			end
		end,
		["Corruption"] = function()
			if
					ValidUsable(spells.Corruption.id, t) and ni.unit.debuffremaining(t, spells.Corruption.id, p) < 1 and
					FacingLosCast(spells.Corruption.name, t)
			then
				return true
			end
		end,
		["BaneofDoom"] = function()
			if ValidUsable(spells.BaneofDoom.id, t) and ni.unit.debuffremaining(t, spells.BaneofDoom.id, p) < 1 and not ni.unit.debuff(t, spells.BaneofAgony.id, p) and FacingLosCast(spells.BaneofDoom.name, t) then
				return true
			end

			if cache.targets > 1 then
				for i = 1, #enemies do
					local unit = enemies[i].guid
					if ni.unit.exists(unit) and not UnitIsUnit(unit, t) and not ni.unit.debuff(unit, spells.BaneofDoom.id, p) and not ni.unit.debuff(unit, spells.BaneofAgony.id, p) then
						ni.spell.cast(spells.BaneofDoom.name, unit)
						return true
					end
				end
			end
		end,
		["Bane of Agony AoE"] = function()
			if cache.targets >= 2 then
				for i = 1, #enemies do
					local unit = enemies[i].guid
					if ni.unit.exists(unit) and not UnitIsUnit(unit, t) and not ni.unit.debuff(unit, spells.BaneofAgony.id, p) and not ni.unit.debuff(unit, spells.BaneofDoom.id, p) then
						ni.spell.cast(spells.BaneofAgony.name, unit)
						return true
					end
				end
			end
		end,
		["HandofGuldan"] = function()
			if
					not cache.moving and ValidUsable(spells.HandofGuldan.id, t) and
					ni.unit.debuffremaining(t, spells.HandofGuldan.id, p) < 2 and
					FacingLosCast(spells.HandofGuldan.name, t)
			then
				return true
			end
		end,
		["IncinerateMoltenCore"] = function()
			if ValidUsable(spells.Incinerate.id, t) and ni.player.buff(MoltenCore) and FacingLosCast(spells.Incinerate.name, t) then
				return true
			end
		end,
		["Incinerate"] = function()
			if enables["IncinerateFiller"] then
				if not cache.moving and ValidUsable(spells.Incinerate.id, t) and FacingLosCast(spells.Incinerate.name, t) then
					return true
				end
			end
		end,
		["SoulFire"] = function()
			if
					not cache.moving and ValidUsable(spells.SoulFire.id, t) and ni.player.buff(Decimation) and
					FacingLosCast(spells.SoulFire.name, t)
			then
				return true
			end
		end,
		["Metamorphosis"] = function()
			if ni.vars.combat.cd then
				if ni.spell.available(spells.Metamorphosis.name) then
					ni.spell.cast(spells.Metamorphosis.name)
					return true
				end
			end
		end,
		["FelStorm"] = function()
			if ni.vars.combat.cd then
				local petType = UnitCreatureFamily("pet")
				if petType == "Felguard" and ni.spell.cd(spells.FelStorm.id) == 0 and ni.unit.exists("pet")
						and ni.unit.inmelee("pet", t)
				then
					ni.player.runtext("/cast Felstorm")
					return true
				end
			end
		end,

		["LifeTap"] = function()
			if ni.player.power() < 15 and ni.player.hp() > 50 then
				ni.spell.cast(spells.LifeTap.name)
				return true
			end
		end,
		["Soulshatter"] = function()
			if #ni.members > 1
					and ni.unit.threat("player") >= 2
					and ni.spell.cd(spells.Soulshatter.id) == 0
					and IsUsableSpell(GetSpellInfo(spells.Soulshatter.id)) then
				ni.spell.cast(spells.Soulshatter.id)
				return true
			end
		end,
		["Summon Doomguard/Infernal"] = function()
			if ni.vars.combat.cd then
				local guardianChoice = menus["GuardianChoice"]
				if guardianChoice == 1 and ni.spell.available(spells.SummonDoomguard.name) then
					ni.spell.cast(spells.SummonDoomguard.name)
					return true
				elseif guardianChoice == 2 and ni.spell.available(spells.SummonInfernal.name) then
					ni.spell.cast(spells.SummonInfernal.name)
					return true
				end
			end
		end,
		["Shadowflame"] = function()
			if ni.spell.available(spells.Shadowflame.name)
					and ni.unit.inmelee(p, t)
					and ni.player then
				ni.spell.cast(spells.Shadowflame.name)
				return true
			end
		end,
		--AOE Section
		["Hellfire"] = function()
			if ni.vars.combat.aoe then
				if cache.targets >= 4 and ni.spell.available(spells.Hellfire.name) then
					ni.spell.cast(spells.Hellfire.name)
					return true
				end
			end
		end,
		["Corruption AoE"] = function()
			if ni.vars.combat.aoe then
				if cache.targets >= 2 and cache.targets <= 5 then
					for i = 1, #enemies do
						local unit = enemies[i].guid
						if ni.unit.exists(unit) and not ni.unit.debuff(unit, spells.Corruption.id, "player") then
							ni.spell.cast(spells.Corruption.name, unit)
							return true
						end
					end
				end
			end
		end,

		["Immolate AoE"] = function()
			if ni.vars.combat.aoe then
				if cache.targets >= 2 and cache.targets <= 5 then
					for i = 1, #enemies do
						local unit = enemies[i].guid
						if ni.unit.exists(unit) and not ni.unit.debuff(unit, spells.Immolate.id, "player") then
							ni.spell.cast(spells.Immolate.name, unit)
							return true
						end
					end
				end
			end
		end,
		["Shadow Bolt AoE"] = function()
			if ni.vars.combat.aoe then
				if cache.targets >= 2 and cache.targets <= 3 then
					for i = 1, #enemies do
						local unit = enemies[i].guid
						if ni.unit.exists(unit) and not ni.unit.debuff(unit, 17800, "player") then -- 17800 is the ID for Shadow and Flame debuff
							ni.spell.cast(spells.ShadowBolt.name, unit)
							return true
						end
					end
				end
			end
		end,
		--- Hard mecanics section
		["Pet Management"] = function()
			local pet = ni.unit.exists("pet")

			if pet then
				if ni.unit.hp("pet") < 20 and UnitIsUnit("target", "pettarget") and not UnitIsDeadOrGhost("pet") then
					ni.player.runtext("/petfollow")
				else
					if UnitAffectingCombat("player") and ni.unit.hp("pet") > 60 and not UnitIsUnit("target", "pettarget") and not UnitIsDeadOrGhost("pet") then
						ni.player.runtext("/petattack")
					end
				end
			end
		end,
		["Demon Soul"] = function()
			if ni.spell.available(spells.DemonSoul.name) then
				if ni.player.power(7) > 0 then -- Verificar si tenemos al menos 1 Soul Shard
					ni.spell.cast(spells.Soulburn.name)
				end
				ni.spell.cast(spells.DemonSoul.name)
				return true
			end
		end,
		["Pet Twisting"] = function()
			if not ni.unit.exists("pet") or UnitIsDeadOrGhost("pet") then
				if ni.spell.available(spells.SummonFelguard.name) then
					ni.spell.cast(spells.SummonFelguard.name)
					return true
				end
			else
				local felstormCD = ni.spell.cd(spells.FelStorm.id)
				if felstormCD > 0 and felstormCD < 39 and ni.player.power(7) > 0 then
					if UnitCreatureFamily("pet") == "Felguard" then
						if ni.unit.buff("player", spells.DemonSoul.name) and ni.unit.buffremaining("player", spells.DemonSoul.name) < 2 then
							if ni.spell.cd(spells.FelStorm.name) == 0 and ni.unit.inmelee("pet", t) then
								ni.spell.cast(spells.FelStorm.name)
								return true
							end
						end
					else
						ni.spell.cast(spells.Soulburn.name)
						print("sacando el eva")
						ni.spell.cast(spells.SummonFelguard.name)
						return true
					end

					if UnitCreatureFamily("pet") == "Felhunter" then
						return false
					else
						ni.spell.cast(spells.Soulburn.name)
						print("sacando el mono")
						ni.spell.cast(spells.SummonFelhunter.name)
						return true
					end
				end
			end
		end,
		["Soul Harvest"] = function()
			if not UnitAffectingCombat("player") then
				if not ni.unit.exists("target") and ni.spell.available(spells.SoulHarvest.name) and ni.player.power(7) < 3 then
					ni.spell.cast(spells.SoulHarvest.name)
					return true
				end
			end
		end,
	}
	ni.bootstrap.profile("Dalvae_demon_cata", queue, abilities, OnLoad, OnUnload)
else
	local queue = {
		"Error",
	};
	local abilities = {
		["Error"] = function()
			ni.vars.profiles.enabled = false;
			if not cata then
				ni.frames.floatingtext:message("This profile for Cata!")
			end
		end,
	};
	ni.bootstrap.profile("Demonology - Cata", queue, abilities);
end;
