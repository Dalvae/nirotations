local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
	local queue = {
		-- "SomeSpell",
		"InnerFire",
		"Cache",
		"ShieldSelf",
		"PowerWordFortitude",
		"PrayerofShadowProtection",
		"Drink",
		"Antiinvi",
		"Showinvis",
		"DesesperatePrayer",
		"KS",
		-- "PainSupression",
		"Archangel",
		"ShieldLow",
		"POMlow",
		"PenanceLow",
		"FlashHealLow",
		"MassDispel",
		"PriorityDispel",
		"DefensiveDispelpriority",
		"ShieldEveryone", --Aoe toggler
		"Lookatcasting",
		"PrayerOfMendingMyself",
		"ShadowFiend",
		"ShieldMe",
		"HealOutOfCombat",
		"Pause Rotation",
		"PrayerOfMending",
		"Shackle Gargoyle",
		"Burst", -- CD Toggller
		"Shield",
		"Penance",
		"FlashHeal",
		"MovingDispel",
		"AttonementHolyFire", --CD Toggller
		"PenanceAttornament", -- CD Toggller
		"PenanceOnTank",
		"ShieldOnTank",
		"AttonementHolySmite", -- CD toggler
		"PrayerofHealing",
		"AttonementMindBlast", --CD Toggllwer
		"Renew",
		"RenewMe",
		"Penancelowpriority",
		"Heal",
		"DOTS",
		"ManaBurn",
	}

	local spells = {
		Renew = {
			id = 139,
			name = select(1, GetSpellInfo(139)),
			icon = select(3, GetSpellInfo(139))
		},
		Heal = {
			id = 2050,
			name = select(1, GetSpellInfo(2050)),
			icon = select(3, GetSpellInfo(2050))
		},
		HolyWordSerenity = {
			id = 88684,
			name = select(1, GetSpellInfo(88684)),
			icon = select(3, GetSpellInfo(88684))
		},
		FlashHeal = {
			id = 2061,
			name = select(1, GetSpellInfo(2061)),
			icon = select(3, GetSpellInfo(2061))
		},
		GreaterHeal = {
			id = 2060,
			name = select(1, GetSpellInfo(2060)),
			icon = select(3, GetSpellInfo(2060))
		},
		PrayerOfMending = {
			id = 33076,
			name = select(1, GetSpellInfo(33076)),
			icon = select(3, GetSpellInfo(33076))
		},
		Penance = {
			id = 47540,
			name = select(1, GetSpellInfo(47540)),
			icon = select(3, GetSpellInfo(47540))
		},
		PowerWordShield = {
			id = 17,
			name = select(1, GetSpellInfo(17)),
			icon = select(3, GetSpellInfo(17))
		},
		Smite = {
			id = 585,
			name = select(1, GetSpellInfo(585)),
			icon = select(3, GetSpellInfo(585))
		},
		HolyFire = {
			id = 14914,
			name = select(1, GetSpellInfo(14914)),
			icon = select(3, GetSpellInfo(14914))
		},
		PrayerofHealing = {
			id = 596,
			name = select(1, GetSpellInfo(596)),
			icon = select(3, GetSpellInfo(596))
		},
		Archangel = {
			id = 87151,
			name = select(1, GetSpellInfo(87151)),
			icon = select(3, GetSpellInfo(87151))
		},
		InnerFire = {
			id = 588,
			name = select(1, GetSpellInfo(588)),
			icon = select(3, GetSpellInfo(588))
		},
		PowerInfusion = {
			id = 10060,
			name = select(1, GetSpellInfo(10060)),
			icon = select(3, GetSpellInfo(10060))
		},
		PowerWordFortitude = {
			id = 21562,
			name = select(1, GetSpellInfo(21562)),
			icon = select(3, GetSpellInfo(21562))
		},
		PainSuprersion = {
			id = 21562,
			name = select(1, GetSpellInfo(21562)),
			icon = select(3, GetSpellInfo(21562))
		},
		MindBlast = {
			id = 8092,
			name = select(1, GetSpellInfo(8092)),
			icon = select(3, GetSpellInfo(8092))
		},
		DesesperatePrayer = {
			id = 19236,
			name = select(1, GetSpellInfo(19236)),
			icon = select(3, GetSpellInfo(19236))
		},
		ShadowWordPain = {
			id = 589,
			name = select(1, GetSpellInfo(589)),
			icon = select(3, GetSpellInfo(589))
		},
		HolyNova = {
			id = 15237,
			name = select(1, GetSpellInfo(15237)),
			icon = select(3, GetSpellInfo(15237))
		},
		ShadowWordDeath = {
			id = 32379,
			name = select(1, GetSpellInfo(32379)),
			icon = select(3, GetSpellInfo(32379))
		},
		DevouringPlague = {
			id = 2944,
			name = select(1, GetSpellInfo(2944)),
			icon = select(3, GetSpellInfo(2944))
		},
		PrayerofShadowProtection = {
			id = 27683,
			name = select(1, GetSpellInfo(27683)),
			icon = select(3, GetSpellInfo(27683))
		},
		ShadowFiend = {
			id = 34433,
			name = select(1, GetSpellInfo(34433)),
			icon = select(3, GetSpellInfo(34433))
		},
		MassDispel = {
			id = 32375,
			name = select(1, GetSpellInfo(32375)),
			icon = select(3, GetSpellInfo(32375))
		},
		ShackleUndead = {
			id = 9484,
			name = select(1, GetSpellInfo(9484)),
			icon = select(3, GetSpellInfo(9484))
		},
		Dispel = {
			id = 527,
			name = select(1, GetSpellInfo(527)),
			icon = select(3, GetSpellInfo(527))
		},
		ManaBurn = {
			id = 8129,
			name = select(1, GetSpellInfo(8129)),
			icon = select(3, GetSpellInfo(8129))
		}
	}



	local enables = {
		["DefensiveDispel"] = true,
		["OffensiveDispel"] = true,
		["PriorityDispel"] = true,
		["MassDispel"] = true,
		["RenewSelf"] = true,
		["DotsOnTarget"] = true,
		["ShieldSelf"] = true,
		["ManaBurn"] = true,
	}
	local values = {
	}
	local inputs = {}
	local menus = {}

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

	local items = {
		settingsfile = "dalvae_discopvp_cata.xml",
		callback = GUICallback,
		{ type = "title",    text = "|cff00ccffDalvae Disco PvP" },
		{ type = "separator" },
		{ type = "title",    text = "|cffFFFF00Dispel Settings|r" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.Dispel.icon .. ":26:26\124t Defensive Dispel",
			tooltip = "Auto dispel harmful effects on allies",
			enabled = enables["DefensiveDispel"],
			key = "DefensiveDispel"
		},
		{
			type = "entry",
			text = "\124T" .. spells.Dispel.icon .. ":26:26\124t Offensive Dispel",
			tooltip = "Auto dispel beneficial effects on enemies",
			enabled = enables["OffensiveDispel"],
			key = "OffensiveDispel"
		},
		{
			type = "entry",
			text = "\124T" .. spells.Dispel.icon .. ":26:26\124t Priority Offensive Dispel",
			tooltip = "Auto dispel high priority buffs (Bloodlust, Wings, etc)",
			enabled = enables["PriorityDispel"],
			key = "PriorityDispel"
		},
		{ type = "entry",    text = "|cffFFFF00CD Toggle|r - Enables offensive spells (Smite, Holy Fire, etc)" },
		{ type = "entry",    text = "|cffFFFF00AoE Toggle|r - Enables Shield Everyone ability" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. spells.Renew.icon .. ":26:26\124t Auto Renew Self",
			tooltip = "Keep Renew on yourself",
			enabled = enables["RenewSelf"],
			key = "RenewSelf"
		},
		{
			type = "entry",
			text = "\124T" .. spells.ShadowWordPain.icon .. ":26:26\124t DoTs on Target",
			tooltip = "Maintain DoTs on current target",
			enabled = enables["DotsOnTarget"],
			key = "DotsOnTarget"
		},
		{
			type = "entry",
			text = "\124T" .. spells.PowerWordShield.icon .. ":26:26\124t Shield Self",
			tooltip = "Keep Power Word: Shield on yourself",
			enabled = enables["ShieldSelf"],
			key = "ShieldSelf"
		},
		{
			type = "entry",
			text = "\124T" .. spells.ManaBurn.icon .. ":26:26\124t Mana Burn",
			tooltip = "Use Mana Burn on enemy healers",
			enabled = enables["ManaBurn"],
			key = "ManaBurn"
		},
	}
	local function LosCast(spell, tar)
		if ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
			ni.spell.cast(spell, tar)
			return true
		end
		return false
	end
	local function LosCastStand(spell, tar)
		if ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
			ni.player.lookat(tar)
			ni.player.stopmoving()
			ni.spell.cast(spell, tar)
			return true
		end
		return false
	end
	local function CombatEventCatcher(event, ...)
		if event == "PLAYER_REGEN_DISABLED" then
			incombat = true
		elseif event == "PLAYER_REGEN_ENABLED" then
			incombat = false
		end
	end
	local function ValidUsable(id, tar)
		if IsSpellKnown(id) and ni.spell.available(id) and ni.spell.valid(tar, id, false, true, true) then
			return true
		end
		return false
	end
	local function OnLoad()
		ni.combatlog.registerhandler("Dalvae Disco", CombatEventCatcher)
		print("Rotation \124cFF15E615Dalvae Disco pvp")
		ni.GUI.AddFrame("Dalvae Disco PvP", items)
	end

	local function OnUnload()
		ni.combatlog.unregisterhandler("Dalvae Disco")
		print("Rotation \124cFFE61515stopped!")
		ni.GUI.DestroyFrame("Dalvae Disco PvP")
	end

	local t, p = "target", "player"

	local prioritydispellbufs = {
		-- Shaman
		2825, -- Bloodlust
		32182, -- Heroism
		16166, -- Elemental Mastery

		-- Paladin
		1038, -- Hand of Salvation (NO - es physical)
		1044, -- Hand of Freedom (NO - es physical)
		54428, -- Divine Plea
		31884, -- Avenging Wrath (Wings)

		-- Priest
		33206, -- Pain Suppression
		6346, -- Fear Ward
		47585, -- Dispersion

		-- Death Knight
		48792, -- Icebound Fortitude (NO - es physical)

		-- Mage
		12472, -- Icy Veins
		12042, -- Arcane Power
		12043, -- Presence of Mind
		48108, -- Hot Streak

		-- Druid
		29166, -- Innervate
		50334, -- Berserk (NO - es physical)
		48505 -- Starfall
	}

	local dispelableBuffs = {
		-- Paladin
		79062, -- Blessing of Kings
		79101, -- Blessing of Might
		53563, -- Beacon of Light
		1022, -- Hand of Protection

		-- Priest
		17,  -- Power Word: Shield
		139, -- Renew
		6346, -- Fear Ward
		79104, -- Power Word Fortitude
		79106, -- Shadow Protection
		41635, -- Prayer of Mending

		-- Shaman
		52127, -- Water Shield
		974, -- Earth Shield
		324, -- Lightning Shield

		-- Druid
		1126, -- Mark of the Wild
		774, -- Rejuvenation
		467, -- Thorns

		-- Mage
		1459, -- Arcane Brilliance
		7302, -- Ice Armor
		30482, -- Molten Armor

		-- Warlock
		687 -- Demon Armor
	}

	local priorityccbuffs = {
		-- Paladin
		853, -- Hammer of Justice

		-- Rogue
		2094, -- Blind

		-- Mage
		11129, -- Combustion
		118, -- Polymorph (Sheep)
		28272, -- Polymorph (Pig)
		61305, -- Polymorph (Black Cat)
		61721, -- Polymorph (Rabbit)
		61025, -- Polymorph (Serpent)
		61780, -- Polymorph (Turkey)
		28271, -- Polymorph (Turtle)

		-- Priest
		34914, -- Vampiric Touch

		-- Warlock
		6789, -- Death Coil (NO - es horror effect, no se puede dispellear)
		5484, -- Fear
		5782, -- Fear
		34914 -- Vampiric Touch (duplicado, ya está en la sección de Priest)
	}
	local Cache = {
		moving = false,
		members = {},
		targets = {}
	}
	-- Helper for  isHealer
	local function IsHealer(unit)
		if not UnitExists(unit) then return false end

		local _, class = UnitClass(unit)
		local maxMana = UnitPowerMax(unit, 0) -- 0 is for mana

		-- Check if unit is a healer class with high mana pool
		if (class == "PRIEST" or class == "DRUID" or class == "SHAMAN" or class == "PALADIN")
				and maxMana > 82000 then
			return true
		end

		return false
	end
	local function IsBeingTargeted(unit)
		for i = 1, #Cache.targets do
			local enemyTarget = ni.unit.target(Cache.targets[i].guid)
			if enemyTarget == unit then
				return true
			end
		end
		return false
	end

	local abilities = {
		["DebugHealer"] = function()
			if UnitExists("target") then
				local isHealer = IsHealer("target")
				local maxMana = UnitPowerMax("target", 0)
				local _, class = UnitClass("target")
				if isHealer then
					print("Target is a healer: " .. class .. " with " .. maxMana .. " max mana")
				end
			end
		end,
		["SomeSpell"] = function()
			for i = 1, #Cache.members do
				for k, v in pairs(Cache.members[i]) do
					print(i .. " - " .. k .. ": " .. tostring(v))
				end
			end
		end,

		["Cache"] = function()
			Cache.targets = ni.unit.enemiesinrange("player", 30)
			Cache.moving = ni.player.ismoving()
			Cache.members = ni.members.sort()
		end,


		["Antiinvi"] = function()
			if ni.player.hp() > 50 then
				for i = 1, #Cache.targets do
					local target = Cache.targets[i].guid
					if ni.player.los(target)
							and (select(2, UnitClass(Cache.targets[i].guid)) == "DRUID" or
								select(2, UnitClass(Cache.targets[i].guid)) == "ROGUE")
							and not ni.unit.debuff(target, spells.ShadowWordPain.id, "player")
					then
						ni.spell.cast(spells.ShadowWordPain.id, target)
					end
				end
			end
		end,
		["Showinvis"] = function()
			local invisibledet = { 1784, 5215, 58984 }
			for d = 1, #invisibledet do
				for i = 1, #Cache.targets do
					if ni.unit.buff(Cache.targets[i].guid, invisibledet[d])
							and ni.player.los(Cache.targets[i].guid) then
						ni.spell.cast(48078) -- Holy nova
					end
				end
			end
		end,
		["Lookatcasting"] = function()
			if ni.player.iscasting()
					or ni.unit.ischanneling("player") then
				ni.player.stopmoving()
				ni.player.lookat("target")
				return false
			end
		end,

		["InnerFire"] = function()
			if not ni.player.buff(spells.InnerFire.id)
					and ni.player.hp() then
				ni.spell.cast(spells.InnerFire.name)
				return true
			end
		end,
		["DesesperatePrayer"] = function()
			if UnitAffectingCombat(p)
					and ni.spell.cd(spells.DesesperatePrayer.id) == 0
					and ni.player.hp() <= 20
			then
				ni.spell.cast(spells.DesesperatePrayer.id)
			end
		end,

		["PowerWordFortitude"] = function()
			if not UnitAffectingCombat("player")
					and not ni.player.buff(spells.PowerWordFortitude.id) then
				ni.spell.cast(spells.PowerWordFortitude.name)
				return true
			end
		end,
		["PrayerofShadowProtection"] = function()
			if not ni.player.buff(spells.PrayerofShadowProtection.id)
					and not UnitAffectingCombat("player")
					and ni.player.power("mana") > 80
			then
				ni.spell.cast(spells.PrayerofShadowProtection.id)
			end
		end,

		["Burst"] = function()
			if ni.vars.combat.cd
					and ni.spell.cd(spells.PowerInfusion.id) == 0 then
				ni.spell.cast(spells.PowerInfusion.name)
				return true
			end
		end,
		["PenanceAttornament"] = function()
			if ni.vars.combat.cd
					and not Cache.moving
					and ni.spell.cd(spells.Penance.id) < 0.2
					and UnitExists(t)
					and UnitCanAttack("player", t)
					and ni.spell.valid(t, spells.Penance.id, false, true, false)
					and LosCastStand(spells.Penance.name, t)
			then
				return true
			end
		end,
		["Drink"] = function()
			if ni.player.power("mana") < 95
					and not UnitAffectingCombat("player")
					and not IsMounted()
					and not ni.unit.ischanneling("player")
					and not ni.unit.buff("player", 25990)
					and not ni.unit.ischanneling("player")
			then
				ni.player.useitem(101001)
			end
		end,

		["AttonementHolyFire"] = function()
			if ni.vars.combat.cd
					and not ni.player.ismoving()
					and ni.spell.cd(spells.HolyFire.id) == 0
					and ni.player.los(t)
					and UnitExists(t)
					and UnitCanAttack("player", t)
					and LosCast(spells.HolyFire.name, t)
			then
				return true
			end
		end,
		["AttonementHolySmite"] = function()
			if ni.vars.combat.cd
					and not ni.player.ismoving()
					and ni.player.los(t)
					and UnitExists(t)
					and UnitCanAttack("player", t)
					and LosCast(spells.Smite.name, t)
			then
				return true
			end
		end,
		["AttonementMindBlast"] = function()
			if ni.vars.combat.cd
					and not ni.player.ismoving()
					and ni.player.los(t)
					and UnitExists(t)
					and UnitCanAttack("player", t)
					and LosCast(spells.MindBlast.name, t)
			then
				return true
			end
		end,
		["KS"] = function()
			if ni.spell.cd(spells.ShadowWordDeath.id) == 0 then
				for i = 1, #Cache.targets do
					local target = Cache.targets[i].guid
					-- if ni.spell.valid(spells.ShadowWordDeath.id, target, false, true, false)
					if ni.player.los(target)
							and ni.unit.isplayer(target)
							and ni.unit.hp(target) <= 10
					then
						ni.spell.cast(spells.ShadowWordDeath.id, target)
					end
				end
			end
		end,
		["MovingDispel"] = function()
			if enables["OffensiveDispel"] and ni.player.ismoving() then
				for d = 1, #dispelableBuffs do
					if ni.unit.buff(t, dispelableBuffs[d])
							and ni.spell.valid(t, 527) then
						ni.spell.cast(527, t)
					end
				end
			end
		end,
		["POMlow"] = function()
			if ni.spell.cd(spells.PrayerOfMending.id) == 0 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 40 and ni.player.los(Cache.members[i].unit)
							and
							ValidUsable(spells.PrayerOfMending.id, Cache.members[i].unit)
					then
						ni.spell.cast(spells.PrayerOfMending.id, Cache.members[i].unit)
						return true
					end
				end
			end
		end,
		["Pause Rotation"] = function()
			if IsMounted()
					or UnitIsDeadOrGhost("player")
					or ni.unit.buff("player", "Drink")
					or ni.unit.ischanneling("player") then
				return true
			end

			if not UnitAffectingCombat("player") then
				for i = 1, #Cache.members do
					local ally = Cache.members[i]
					if ally:combat() then
						return false
					end
				end
				return true
			end

			return false
		end,


		["MassDispel"] = function()
			if enables["MassDispel"] then
				local buffdispe = { 642, 45438 } -- Divine Shield, Ice Block
				for d = 1, #buffdispe do
					for i = 1, #Cache.targets do
						if ni.unit.buff(Cache.targets[i].guid, buffdispe[d])
								and not ni.player.ismoving()
						then
							ni.spell.castat(spells.MassDispel.id, Cache.targets[i].guid)
							return true
						end
					end
				end
			end
		end,


		-- ["PainSupression"] = function ()
		--     local friends = ni.unit.friendsinrange("player", 30)
		--     if ni spell.available(spells.PainSuprersion.id) then

		["PenanceOnTank"] = function()
			if ni.spell.cd(spells.Penance.id) < 0.1 then
				for i = 1, #Cache.members do
					if Cache.members[i]:istank() and
							Cache.members[i].hp() <= 90 and
							ValidUsable(spells.Penance.id, Cache.members[i].unit) and
							LosCast(spells.Penance.name, Cache.members[i].unit)
					then
						return true
					end
				end
			end
		end,

		["DefensiveDispelpriority"] = function()
			if enables["DefensiveDispel"] then
				for i = 1, #Cache.members do
					for _, v in pairs(priorityccbuffs) do
						if ni.player.los(Cache.members[i].guid) and
								ni.unit.debuff(Cache.members[i].guid, v)
						then
							ni.spell.cast(527, Cache.members[i].guid)
						end
					end
				end
			end
		end,
		["HealOutOfCombat"] = function()
			if not UnitAffectingCombat("player") then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 95
							and not ni.player.ismoving()
							and ValidUsable(spells.Heal.id, Cache.members[i].unit)
							and LosCast(spells.Heal.name, Cache.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["PriorityDispel"] = function()
			if enables["PriorityDispel"] then
				for i = 1, #Cache.targets do
					local target = Cache.targets[i].guid
					if ni.player.los(target) then
						for _, buffId in ipairs(prioritydispellbufs) do
							if ni.unit.buff(target, buffId) then
								-- Verificamos que podemos dispellear
								if ni.spell.valid(target, 527, false, true, true) then
									ni.spell.cast(527, target)
									return true
								end
							end
						end
					end
				end
			end
		end,

		["Heal"] = function()
			if not ni.player.ismoving()
					and not ni.player.ismoving() then
				for i = 1, #Cache.members do
					if
							Cache.members[i].hp() <= 80 and
							ValidUsable(spells.Heal.id, Cache.members[i].unit) and
							LosCast(spells.Heal.name, Cache.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["FlashHeal"] = function()
			if not ni.player.ismoving() then
				for i = 1, #Cache.members do
					if
							Cache.members[i].hp() <= 70 and
							ValidUsable(spells.FlashHeal.id, Cache.members[i].unit) and
							LosCast(spells.FlashHeal.name, Cache.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["FlashHealLow"] = function()
			if not ni.player.ismoving() then
				for i = 1, #Cache.members do
					if
							Cache.members[i].hp() <= 40 and
							ValidUsable(spells.FlashHeal.id, Cache.members[i].unit) and
							LosCast(spells.FlashHeal.name, Cache.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["PenanceLow"] = function()
			if not ni.player.ismoving()
					and ni.spell.cd(spells.Penance.id) == 0 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 30 and
							ValidUsable(spells.Penance.id, Cache.members[i].unit) and
							LosCastStand(spells.Penance.name, Cache.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["Penance"] = function()
			if not ni.player.ismoving()
					and ni.spell.cd(spells.Penance.id) == 0 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 69 and
							ValidUsable(spells.Penance.id, Cache.members[i].unit) and
							LosCastStand(spells.Penance.name, Cache.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["Penancelowpriority"] = function()
			if not ni.player.ismoving() and ni.spell.cd(spells.Penance.id) == 0 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 80 and
							ValidUsable(spells.Penance.id, Cache.members[i].unit) and
							LosCastStand(spells.Penance.name, Cache.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["Shield"] = function()
			for i = 1, #Cache.members do
				local ally = Cache.members[i]
				if ally.hp() <= 94
						and ally:combat()
						and IsBeingTargeted(ally.guid)
						and not ni.unit.debuff(ally.unit, 6788, t) -- Weakened Soul
						and ValidUsable(spells.PowerWordShield.id, ally.unit)
						and LosCast(spells.PowerWordShield.name, ally.unit)
				then
					return true
				end
			end
		end,

		["ShieldLow"] = function()
			for i = 1, #Cache.members do
				local ally = Cache.members[i]
				if ally.hp() <= 40
						and ally:combat()
						and IsBeingTargeted(ally.guid)
						and not ni.unit.debuff(ally.unit, 6788, t)
						and ValidUsable(spells.PowerWordShield.id, ally.unit)
						and LosCast(spells.PowerWordShield.name, ally.unit)
				then
					return true
				end
			end
		end,

		["ShieldOnTank"] = function()
			if ni.spell.cd(spells.Penance.id) < 0.1 then
				for i = 1, #Cache.members do
					local ally = Cache.members[i]
					if ally:istank()
							and ally:combat()
							and ally.hp() <= 100
							and not ni.unit.debuff(ally.unit, 6788, t)
							and ValidUsable(spells.PowerWordShield.id, ally.unit)
							and LosCast(spells.PowerWordShield.name, ally.unit)
					then
						return true
					end
				end
			end
		end,
		["Renew"] = function()
			if ni.player.power("mana") > 65 then
				for i = 1, #Cache.members do
					if Cache.members[i].hp() <= 95 and
							not ni.unit.buff(Cache.members[i].unit, 139, p) and
							ValidUsable(spells.Renew.id, Cache.members[i].unit) and
							LosCast(spells.Renew.name, Cache.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["RenewMe"] = function()
			if enables["RenewSelf"] then
				if ni.player.power("mana") > 45
						and ni.player.hp() <= 80
						and not ni.player.buff(139)
				then
					ni.spell.cast(139, p)
				end
			end
		end,

		["ShieldMe"] = function()
			if ni.vars.combat.cd then
				if ni.spell.cd(spells.PowerWordShield.id) == 0
						and not ni.player.debuff(6788)
						and not ni.player.buff(17)
						and LosCast(spells.PowerWordShield.id, "player")
				then
					return true
				end
			end
		end,

		["ShieldEveryone"] = function()
			if ni.vars.combat.aoe then
				for i = 1, #Cache.members do
					local ally = Cache.members[i]
					if not ni.unit.debuff(ally.guid, 6788, "player") and
							ValidUsable(spells.PowerWordShield.id, ally.guid) and
							LosCast(spells.PowerWordShield.name, ally.guid)
					then
						return true
					end
				end
			end
		end,
		["PrayerOfMending"] = function()
			if ni.spell.cd(spells.PrayerOfMending.id) == 0 then
				local renewActive = false
				for i = 1, #Cache.members do
					if ni.unit.buff(Cache.members[i].unit, spells.PrayerOfMending.id, "player") then
						renewActive = true
						break
					end
				end
				if not renewActive then
					for i = 1, #Cache.members do
						if Cache.members[i].hp() < 99 and
								not ni.unit.buff(Cache.members[i].unit, spells.PrayerOfMending.id, "player") and
								ni.spell.valid(Cache.members[i].unit, spells.PrayerOfMending.id, false, true, true)
						then
							ni.spell.cast(spells.PrayerOfMending.id, Cache.members[i].unit)
							return true
						end
					end
				end
			end
		end,

		["PrayerOfMendingMyself"] = function()
			if ni.spell.cd(spells.PrayerOfMending.id) == 0
					and ni.player.hp() <= 60
			then
				ni.spell.cast(spells.PrayerOfMending.id, "player")
			end
		end,
		["PrayerofHealing"] = function()
			local lowMembers = {}
			for i = 1, #Cache.members do
				if Cache.members[i].hp() <= 50 then
					table.insert(lowMembers, Cache.members[i])
				end
			end
			if #lowMembers >= 4 and ValidUsable(spells.PrayerofHealing.id, lowMembers[1].unit) and
					LosCast(spells.PrayerofHealing.name, lowMembers[1].unit)
			then
				return true
			end
		end,
		["GreaterHeal"] = function()
			for i = 1, #Cache.members do
				if Cache.members[i].hp() <= 70 and
						ValidUsable(spells.GreaterHeal.id, Cache.members[i].unit) and
						LosCast(spells.GreaterHeal.name, Cache.members[i].unit)
				then
					return true
				end
			end
		end,
		["Archangel"] = function()
			if ni.player.buffstacks(81661) == 5      -- Evangelism
					and ni.spell.cd(spells.Archangel.id) == 0 -- Arcangel
			then
				ni.spell.cast(87151)
				return true
			end
		end,
		["ShadowFiend"] = function()
			if ni.vars.combat.cd
					and ni.spell.cd(spells.ShadowFiend.id) == 0
					and ni.player.los("target")
			then
				ni.spell.cast(spells.ShadowFiend.id, "target")
				return true
			end
		end,
		["ShieldSelf"] = function()
			if enables["ShieldSelf"] then
				if not ni.player.debuff(6788) -- Weakened Soul
						and not ni.player.buff(17) -- Power Word: Shield
						and ni.spell.available(spells.PowerWordShield.id) then
					ni.spell.cast(spells.PowerWordShield.id, "player")
					return true
				end
			end
		end,

		["ManaBurn"] = function()
			if enables["ManaBurn"] then
				if ni.spell.available(8129) and not Cache.moving then
					for i = 1, #Cache.targets do
						local target = Cache.targets[i].guid
						if ni.unit.isplayer(target)
								and (IsHealer(target) or ni.unit.creaturetype(target) == "Mage")
								and ni.unit.power(target, "mana") > 10
								and ni.spell.valid(target, 8129, false, true, true) then
							ni.spell.cast(8129, target)
							return true
						end
					end
				end
			end
		end,

		["DOTS"] = function()
			if enables["DotsOnTarget"] then
				if ni.player.los(t) then
					if not ni.unit.debuff("target", spells.ShadowWordPain.id, "player") then
						ni.spell.cast(spells.ShadowWordPain.id, "target")
					else
						if not ni.unit.debuff("target", spells.DevouringPlague.id, "player") then
							ni.spell.cast(spells.DevouringPlague.id, "target")
						end
					end
				end
			end
		end,
		["Shackle Gargoyle"] = function()
			for i = 1, #Cache.targets do
				local target = Cache.targets[i].guid
				local name = Cache.targets[i].name
				if name == "Ebon Gargoyle"
						and not ni.unit.debuff(target, spells.ShackleUndead.id)
						and ni.spell.valid(target, spells.ShackleUndead.id, false, true, true)
				then
					ni.spell.cast(spells.ShackleUndead.id, target)
					return true
				end
			end
		end

	}

	ni.bootstrap.profile("Dalvae_discopvp_cata", queue, abilities, OnLoad, OnUnload)
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
	ni.bootstrap.profile("Dalvae_discopvp_cata", queue, abilities);
end
;

--- 40 yards Radians Los escudos
--Renew
-- Dispel Defensivo
--Combustion
-- Fear
---ONplayer buff
-- Anarphet - Chest

-- pantalones, hacer la quest https://cata-twinhead.twinstar.cz/?quest=28133
-- En gim battol cae de trash
-- Isseset bota unos



--Hands

-- --     Magos:
-- Polymorph (Polimorfia): 118, 12824, 12825, 12826, 28271, 28272, 61025
-- Slow (Lentitud): 31589

-- Brujos:
-- Fear (Miedo): 5782, 6213, 6215, 5484, 17928
-- Howl of Terror (Aullido de terror): 5484

-- Cazadores:
-- Freezing Trap (Trampa congelante): 3355, 14309, 14310
-- Wyvern Sting (Picadura de víbora): 19386, 24132, 24133
-- Scatter Shot (Disparo disperso): 19503

-- Caballeros de la Muerte:
-- Mind Freeze (Congelación mental): 47528

-- Paladines:
-- Repentance (Arrepentimiento): 20066
-- Hammer of Justice (Martillo de justicia): 853, 5588, 5589, 10308, 10326

-- Sacerdotes:
-- Psychic Scream (Grito psíquico): 8122, 8124, 10888, 10890
-- Silence (Silencio): 15487, 19985, 19989

-- Ladrones:
-- Sap (Seducción): 6770, 2070, 11297
