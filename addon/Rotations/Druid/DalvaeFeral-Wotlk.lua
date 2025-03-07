local build = select(4, GetBuildInfo());
local wotlk = build == 30300 or false;
if wotlk then
	local spells = {
		--Cat
		CatForm = { id = 768, name = GetSpellInfo(768), icon = select(3, GetSpellInfo(768)) },
		Manglecat = { id = 48566, name = GetSpellInfo(48566), icon = select(3, GetSpellInfo(48566)) },
		Rip = { id = 49800, name = GetSpellInfo(49800), icon = select(3, GetSpellInfo(49800)) },
		Rake = { id = 48574, name = GetSpellInfo(48574), icon = select(3, GetSpellInfo(48574)) },
		SavageRoar = { id = 52610, name = GetSpellInfo(52610), icon = select(3, GetSpellInfo(52610)) },
		Prowl = { id = 5215, name = GetSpellInfo(5215), icon = select(3, GetSpellInfo(5215)) },
		TigersFury = { id = 50213, name = GetSpellInfo(50213), icon = select(3, GetSpellInfo(50213)) },
		Maim = { id = 49802, name = GetSpellInfo(49802), icon = select(3, GetSpellInfo(49802)) },
		InstantCast = { id = 69369, name = GetSpellInfo(69369), icon = select(3, GetSpellInfo(69369)) },
		FerociusBite = { id = 48577, name = GetSpellInfo(48577), icon = select(3, GetSpellInfo(48577)) },
		Pounce = { id = 49803, name = GetSpellInfo(49803), icon = select(3, GetSpellInfo(49803)) },
		FaerieFire = { id = 16857, name = GetSpellInfo(16857), icon = select(3, GetSpellInfo(16857)) },
		Shred = { id = 48572, name = GetSpellInfo(48572), icon = select(3, GetSpellInfo(48572)) },
		SurvivalInstinct = { id = 61336, name = GetSpellInfo(61336), icon = select(3, GetSpellInfo(61336)) },
		Barkskin = { id = 22812, name = GetSpellInfo(22812), icon = select(3, GetSpellInfo(22812)) },
		Berserk = { id = 50334, name = GetSpellInfo(50334), icon = select(3, GetSpellInfo(50334)) },
		--Bear
		BearForm = { id = 9634, name = GetSpellInfo(9634), icon = select(3, GetSpellInfo(9634)) },
		MangleBear = { id = 48564, name = GetSpellInfo(48564), icon = select(3, GetSpellInfo(48564)) },
		Maul = { id = 48480, name = GetSpellInfo(48480), icon = select(3, GetSpellInfo(48480)) },
		Lacerate = { id = 48568, name = GetSpellInfo(48568), icon = select(3, GetSpellInfo(48568)) },
		Demoralazing = { id = 48560, name = GetSpellInfo(48560), icon = select(3, GetSpellInfo(48560)) },
		Enrage = { id = 5229, name = GetSpellInfo(5229), icon = select(3, GetSpellInfo(5229)) },
		FrenziedRegeneration = { id = 22842, name = GetSpellInfo(22842), icon = select(3, GetSpellInfo(22842)) },
		Charge = { id = 16979, name = GetSpellInfo(16979), icon = select(3, GetSpellInfo(16979)) },
		Bash = { id = 8983, name = GetSpellInfo(8983), icon = select(3, GetSpellInfo(8983)) },
		SwipeBear = { id = 48562, name = GetSpellInfo(48562), icon = select(3, GetSpellInfo(48562)) },
		-- Resto
		Rejuv = { id = 48441, name = GetSpellInfo(48441), icon = select(3, GetSpellInfo(48441)) },
		Lifebloom = { id = 48451, name = GetSpellInfo(48451), icon = select(3, GetSpellInfo(48451)) },
		Regrowth = { id = 48443, name = GetSpellInfo(48443), icon = select(3, GetSpellInfo(48443)) },
		Nourish = { id = 50464, name = GetSpellInfo(50464), icon = select(3, GetSpellInfo(50464)) },
		HealingTouch = { id = 48378, name = GetSpellInfo(48378), icon = select(3, GetSpellInfo(48378)) },
		GOTW = { id = 48470, name = GetSpellInfo(48470), icon = select(3, GetSpellInfo(48470)) },
		Thorns = { id = 26992, name = GetSpellInfo(26992), icon = select(3, GetSpellInfo(26992)) },
		AbolishPoison = { id = 2893, name = GetSpellInfo(2893), icon = select(3, GetSpellInfo(2893)) },
		RemoveCurse = { id = 2782, name = GetSpellInfo(2782), icon = select(3, GetSpellInfo(2782)) },
		Tranquility = { id = 48447, name = GetSpellInfo(48447), icon = select(3, GetSpellInfo(48447)) },
		-- Balance
		Moonfire = { id = 8921, name = GetSpellInfo(8921), icon = select(3, GetSpellInfo(8921)) },
		Inervate = { id = 29166, name = GetSpellInfo(29166), icon = select(3, GetSpellInfo(29166)) },
		Roots = { id = 26989, name = GetSpellInfo(26989), icon = select(3, GetSpellInfo(26989)) },
		Cyclone = { id = 33786, name = GetSpellInfo(33786), icon = select(3, GetSpellInfo(33786)) },
		SoothePet = { id = 588, name = GetSpellInfo(588), icon = select(3, GetSpellInfo(588)) },
		Hibernate = { id = 18658, name = GetSpellInfo(18658), icon = select(3, GetSpellInfo(18658)) },
		ClearCast = { id = 16870, name = GetSpellInfo(16870), icon = select(3, GetSpellInfo(16870)) },
		NatureGrasp = { id = 27009, name = GetSpellInfo(27009), icon = select(3, GetSpellInfo(27009)) },
	}
	local enables = {
		["CatForm"] = true,
		["Invi"] = false,
		["CCBuff"] = true,
		["Automated"] = true,
		["BerserkFear"] = false,
		["ChargeBear"] = true,
		["Interrupts"] = false,
		["CycloneInterupt"] = true,
		["CycloneFocus"] = true,
		["Bombs"] = false,

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
		settingsfile = "DalvaeFeral.json",
		callback = GUICallback,
		{ type = "title",    text = "|cff00ccffFeral-Dalvae" },
		{ type = "separator" },
		{ type = "separator" },
		{
			type = "entry",
			text = "\124T" .. ":26:26\124t Auto pause when not in Combat",
			tooltip = "It going to auto start a fight if not enable",
			enabled = true,
			key = "getSetting_Pause"
		},
		{
			type = "separator",
		},
		{
			type = "title",
			text = "|cff71C671Cat Settings",
		},
		{
			type = "separator",
		},
		{ type = "page", number = 1, text = "General Settings" },
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.CatForm.id)) .. ":26:26\124t Auto Cat form",
			tooltip = "It will be in catform if its in combat",
			enabled = enables["CatForm"],
			key = "CatForm"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Prowl.id)) .. ":26:26\124t Auto Invi",
			tooltip = "It will be using Prowl when possible",
			enabled = enables["Invi"],
			key = "Invi"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.GOTW.id)) .. ":26:26\124t Hunt for clearcasting",
			tooltip = "It will Buff for cc",
			enabled = enables["CCBuff"],
			key = "CCBuff"
		},
		{
			type = "entry",
			text = "|cFFFF0000\124T" ..
					select(3, GetSpellInfo(spells.FerociusBite.id)) .. ":26:26\124t Full Automated rotation|r",
			tooltip = "It will be automatically do Rip, FB, Savage Roar NOT OPTIMAL!",
			enabled = enables["Automated"],
			key = "Automated"
		},
		{
			type = "entry",
			text = "|cFFFF0000\124T" ..
					GetItemIcon(42641) .. ":26:26\124t Use Bomb|r",
			tooltip = "It will use Bombs on CD!",
			enabled = enables["Bombs"],
			key = "Bombs"
		},
		{
			type = "separator",
		},
		{ type = "page", number = 2, text = "Pvp Setting" },

		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Berserk.id)) .. ":26:26\124t Berserk Fear",
			tooltip = "Auto Berserk when feared",
			enabled = enables["BerserkFear"],
			key = "BerserkFear"
		},

		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Charge.id)) .. ":26:26\124t Charge interupt",
			tooltip = "Will Auto use feral chare on any in range target that is casting",
			enabled = enables["ChargeBear"],
			key = "ChargeBear"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(20549)) .. ":26:26\124t interupt",
			tooltip = "It will use all ways of interupts",
			enabled = enables["Interrupts"],
			key = "Interrupts"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Cyclone.id)) .. ":26:26\124t Cyclone interupt",
			tooltip = "Will Auto use cyclone instant cast if someone is casting",
			enabled = enables["CycloneInterupt"],
			key = "CycloneInterupt"
		},
		{
			type = "entry",
			text = "\124T" .. select(3, GetSpellInfo(spells.Cyclone.id)) .. ":26:26\124t Cyclone Focus",
			tooltip = "Will Auto use instant cast to cyclone focus target",
			enabled = enables["CycloneFocus"],
			key = "CycloneFocus"
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
	;
	local DBM_Timers = {}
	local nextExpire  -- tiempo del próximo temporizador que expira
	local recheckTimer -- manejar del temporizador

	local function recheckDBMTimers()
		local now = GetTime()
		nextExpire = nil
		for id, timer in pairs(DBM_Timers) do
			if timer.expirationTime < now then
				-- El temporizador ha expirado
				DBM_Timers[id] = nil
				print("DBM Timer Stopped: ", timer.message)
			else
				if not nextExpire or timer.expirationTime < nextExpire then
					nextExpire = timer.expirationTime
				end
			end
		end
		if nextExpire then
			-- Revisar nuevamente en el momento en que el próximo temporizador expire
			recheckTimer = C_Timer.NewTimer(nextExpire - now, recheckDBMTimers)
		end
	end

	local function UpdateDBMTimers(event, id, msg, duration)
		if event == "DBM_TimerStart" then
			local startTime = GetTime()
			local expirationTime = startTime + duration
			DBM_Timers[id] = { message = msg, duration = duration, startTime = startTime, expirationTime = expirationTime }
			print("DBM Timer Started: ", msg, " Duration: ", duration)
			-- Cancelar y reprogramar la revisión de temporizadores si este temporizador expira antes que el próximo conocido
			if not nextExpire or expirationTime < nextExpire then
				if recheckTimer then
					recheckTimer:Cancel()
				end
				nextExpire = expirationTime
				recheckTimer = C_Timer.NewTimer(duration, recheckDBMTimers)
			end
		elseif event == "DBM_TimerStop" then
			DBM_Timers[id] = nil
		end
	end

	local function DBMEventHandler(event, ...)
		local id, msg, duration, icon, timerType, spellId, dbmType = ...
		if event == "DBM_TimerStart" then
			UpdateDBMTimers(event, id, msg, duration)
		elseif event == "DBM_TimerStop" then
			UpdateDBMTimers(event, id)
		end
	end

	local function CheckPullInTimerRemaining()
		for id, timer in pairs(DBM_Timers) do
			if timer.message == "Pull in" then -- Asegúrate de que este mensaje coincida exactamente con lo que DBM usa
				local now = GetTime()
				local remaining = timer.expirationTime - now
				return remaining
			end
		end
		return nil -- El temporizador "Pull in" no está activo o no se encontró
	end

	local function onload()
		ni.GUI.AddFrame("Feral Dalvae", items)
		print("Rotation \124cFF15E615Fera Dalvae")
		if DBM then
			DBM:RegisterCallback("DBM_TimerStart", DBMEventHandler)
			DBM:RegisterCallback("DBM_TimerStop", DBMEventHandler)
			-- Opcional: Si quieres mostrar el tiempo restante cada segundo
			-- C_Timer.NewTicker(1, ShowRemainingTimeForPullIn)
		end
	end



	local function onunload()
		ni.GUI.DestroyFrame("Feral Dalvae")
		print("Rotation \124cFFE61515stopped!")
	end


	-- Slashcommands
	SLASH_STUNT1                = "/STUNT"
	SlashCmdList["STUNT"]       = function(msg)
		if ni.spell.cd(spells.Bash.id) == 0
		then
			ni.spell.castqueue(spells.Bash.id, "target")
		end
	end

	SLASH_SHRED1                = "/shred"
	SlashCmdList["SHRED"]       = function(msg)
		if not ni.player.buff(spells.CatForm.id) then
			ni.spell.cast(spells.CatForm.id)
		else
			ni.player.lookat("target")
			if ni.unit.isbehind("player", "target")
					and (GetComboPoints("player", "target") < 5
						or ni.player.buff(spells.ClearCast.id))
			then
				ni.spell.cast(spells.Shred.id)
				ni.player.lookat("target")
			elseif not ni.unit.isbehind("player", "target")
					and GetComboPoints("player", "target") < 5
					and ni.player:powerraw("energy") >= 45 then
				ni.player.lookat("target")
				ni.spell.cast(spells.Manglecat.id, "target")
			end
		end
	end

	SLASH_CHARGES1              = "/charges"
	SlashCmdList["CHARGES"]     = function(msg)
		if ni.spell.cd(spells.Charge.id) == 0
		then
			if not ni.player.buff(spells.BearForm.id)
			then
				ni.spell.cast(spells.BearForm.id)
			else
				ni.player.lookat("mouseover")
				ni.spell.cast(spells.Charge.id, "mouseover")
			end
		end
	end

	SLASH_STOPGASTING1          = "/stopgasting"
	SlashCmdList["STOPGASTING"] = function()
		ni.rotation.delay(1)
	end


	SLASH_HEAL1 = "/heal"
	SlashCmdList["HEAL"] = function(msg)
		if ni.player.hp() < 80 then
			if not ni.player.buff(spells.Regrowth.id) then
				ni.spell.cast(spells.Regrowth.id, "player")
			end
			if not ni.player.buff(spells.Rejuv.id) then
				ni.spell.cast(spells.Rejuv.id, "player")
			end
			if not ni.player.buff(spells.Lifebloom.id) then
				ni.spell.cast(spells.Lifebloom.id, "player")
			end
			if ni.player.hp() < 80 then
				ni.spell.cast(spells.Nourish.id, "player")
			end
		end
		return false
	end

	local t, p = "target", "player"
	local cat = ni.player.buff(spells.CatForm.id)
	local bear = ni.player.buff(spells.BearForm.id)
	local savagertimer = ni.player.buffremaining(spells.SavageRoar.id)
	local riptimer = ni.unit.debuffremaining("target", "49800", "player")

	local Cache = {
		targets = nil,
		curchannel = nil,
		iscasting = nil,
		moving = ni.player.ismoving(),
		enemies = ni.unit.enemiesinrange(p, 25),
		riptimer = ni.unit.debuffremaining("target", spells.Rip.id, "player"),
		savagertimer = ni.player.buffremaining(spells.SavageRoar.id),
		cat = ni.player.buff(spells.CatForm.id),
		bear = ni.player.buff(spells.BearForm.id)

	}


	local queue = {
		--buffs
		"Cache",
		-- "switchweapon",
		-- "Test",
		-- "GOTW",
		-- "Thorns",
		"PrePull",
		"Pounce",
		"INVI",
		"Pause Rotation",
		"Catform",
		"Berserk",
		"Start Attack",
		"Auto Target",
		"Barkskin",
		"Survival",
		"Tigers Fury",
		"Bombs",
		"Interrupter",
		"FeralCharge",
		"Berserkfear",
		-- "Antireflect",
		-- "Cycloneinterupt",
		"CycloneFocus",
		"Swipe",
		"Antislow",
		-- "DispelHEX",
		-- "AbolishPoison",
		"Ferocious Bite",
		-- "Ferocious Bite1",
		-- "Ferocious Bite2",
		"Shreadcc",
		"Faerie fire",
		"WILD",
		"Shred100",
		"SavageRoar",
		"Ingrediente Secreto",
		"MangleDebuff",
		"Rake",
		"Shredauto",
		"Rip",
		--bear
		"FrenziedRegeneration",
		"Maul",
		"SwipeBear",
		"MangleBear",
		-- "Demoralazing",
		"Enrage",
		"FaerieFirebear",
		"Lacerate",
		"Laceratestack",
		"InervateHealer",
		"Hibernate",
	}



	local abilities = {
		["Cache"] = function()
			Cache.moving = ni.player.ismoving()
			Cache.curchannel = UnitChannelInfo(p)
			Cache.enemies = ni.unit.enemiesinrange(p, 25)
			Cache.iscasting = UnitCastingInfo(p)
			Cache.riptimer = ni.unit.debuffremaining("target", spells.Rip.id, "player")
			Cache.savagertimer = ni.player.buffremaining(spells.SavageRoar.id)
			Cache.cat = ni.player.buff(spells.CatForm.id)
			Cache.bear = ni.player.buff(spells.BearForm.id)
			Cache.berserk = ni.player.buff(50334) --Berserk rage the ulti
		end,

		["Pounce"] = function()
			if ni.spell.available(spells.Pounce.id)
					and UnitCanAttack("player", "target")
					and ni.unit.buff("player", spells.Prowl.id, "player")
			then
				ni.spell.cast(spells.Pounce.id)
			end
		end,

		["Pause Rotation"] = function()
			if IsMounted()
					or Cache.curchannel
					or UnitIsDeadOrGhost("player")
					or not UnitAffectingCombat("player")
					or ni.unit.buff("player", "Drink") then
				return true;
			end
		end,
		["Catform"] = function()
			if enables["CatForm"] and not IsMounted() then
				local hasProtectorTalent = select(5, GetTalentInfo(2, 22))

				-- Si tiene 2 o más puntos en Protector of the Pack
				if hasProtectorTalent >= 2 then
					-- Si no está en ninguna forma, ir a forma de oso
					if not Cache.bear and not Cache.cat then
						ni.spell.cast(spells.BearForm.id)
						return true
					end
					-- Si está en forma de gato y la salud es baja, cambiar a oso
					if Cache.cat and ni.player.hp() < 60 then
						ni.spell.cast(spells.BearForm.id)
						return true
					end
				else
					-- Si no tiene el talento defensivo
					-- Mantener forma de gato si la salud está bien
					if not Cache.cat and not Cache.bear and ni.player.hp() > 65 then
						ni.spell.cast(spells.CatForm.id)
						return true
					end
					-- Si está en forma de oso y la salud se recuperó, volver a gato
					if Cache.bear and ni.player.hp() > 80 then
						ni.spell.cast(spells.CatForm.id)
						return true
					end
				end
			end
			return false
		end,

		["INVI"] = function()
			if enables["Invi"] then
				if not UnitAffectingCombat("player")
						and Cache.cat
						and ni.spell.available(spells.Prowl.id)
						and not ni.unit.buff("player", spells.Prowl.id, "player")
				then
					ni.spell.cast(spells.Prowl.id)
				end
			end
		end,

		["Auto Target"] = function()
			if UnitAffectingCombat("player")
					and not ni.unit.exists("target")
					and not UnitIsDeadOrGhost("target")
					and not UnitCanAttack("player", "target")
			then
				ni.player.runtext("/targetenemy")
				return true;
			end
		end,

		["Start Attack"] = function()
			if ni.unit.exists("target")
					and UnitCanAttack("player", "target")
					and not UnitIsDeadOrGhost("target")
					and UnitAffectingCombat("player")
					and (cat
						or bear)
					and not ni.unit.buff("player", spells.Prowl.id)
					and not IsCurrentSpell(6603) then
				ni.spell.cast(6603)
			end
		end,

		["Barkskin"] = function()
			if ni.spell.available(spells.Barkskin.id)
					and UnitAffectingCombat("player")
					and ni.player.hp() <= 50 then
				ni.spell.cast(spells.Barkskin.id)
			end
		end,

		["Survival"] = function()
			if ni.spell.available(spells.SurvivalInstinct.id)
					and UnitAffectingCombat("player")
					and ni.player.hp() <= 30 then
				ni.spell.cast(spells.SurvivalInstinct.id)
			end
		end,

		["Shreadcc"] = function()
			if Cache.cat
					and ni.unit.buffremaining(p, spells.ClearCast.id, p) >= 1
					and ni.unit.isbehind(p, t)
			then
				ni.spell.cast(spells.Shred.id)
			end
		end,

		["Shred100"] = function()
			if Cache.cat
					and ni.spell.available(spells.Shred.id)
					and ni.player:powerraw("energy") >= 99
					and Cache.riptimer >= 3
					and ni.unit.isbehind("player", "target")
			then
				ni.spell.cast(spells.Shred.id)
			end
		end,

		["Tigers Fury"] = function()
			if Cache.cat
					and ni.spell.cd(spells.TigersFury.id) == 0
					and ni.player:powerraw("energy") < 35 then
				ni.spell.cast(spells.TigersFury.id)
			end
		end,
		["Berserk"] = function()
			if ni.vars.combat.cd
					and ni.spell.cd(spells.Berserk.id) == 0
			then
				if Cache.cat
						and ni.unit.isboss(t)
						and ni.player.buffremaining(spells.TigersFury.id) > 4
						and ni.player.powerraw() > 70
				then
					ni.spell.cast(spells.Berserk.id)
					-- ni.player.useitem(40211)
					ni.player.runtext("/use 10")
				end
			end
		end,

		["Faerie fire"] = function()
			if Cache.cat
					and ni.spell.available(spells.FaerieFire.id)
					-- and not (ni.unit.debuff(t, spells.FaerieFire.id) or ni.unit.debuff(t, "770") or ni.unit.debuff(t, "16857"))
					and ni.player:power() < 17
			then
				print("fuego ferico")
				ni.spell.cast(spells.FaerieFire.id, t)
				return true;
			end
		end,

		["switchweapon"] = function()
			local itemLink = GetInventoryItemLink("player", 16)
			local enchantId = itemLink and itemLink:match("Hitem:%d+:(%d+)")
			if enchantId == 33790
					and ni.player.buff(59626)
			then
				ni.player.runtext("/equip Fin del viaje")
			end
		end,


		["Rake"] = function()
			if not ni.unit.debuff("target", spells.Rake.id, "player")
					and ni.unit.inmelee(p, t)
			then
				if GetComboPoints("player", "target") < 5
				then
					ni.spell.cast(spells.Rake.id)
				else
					if Cache.riptimer > 4
							and Cache.savagertimer > 4
					then
						ni.spell.cast(spells.Rake.id, t)
					end
				end
			end
		end,

		["MangleDebuff"] = function()
			-- if enables["Automated"] then
			if Cache.cat
					and ni.unit.inmelee(p, t)
					and ni.unit.debuffremaining(t, spells.Manglecat.id) < 3
					and ni.unit.debuffremaining(t, 48563) < 3
					and ni.unit.debuffremaining(t, 46856) < 1
					and ni.unit.debuffremaining(t, 46857) < 1
					and ni.unit.debuffremaining(t, 55218) < 1
			then
				ni.spell.cast(spells.Manglecat.id)
			end
			-- end
		end,

		-- ["InervateHealer"] = function()
		-- 	for i = 1, #ni.members do
		-- 		if ni.members[i].name == "Tapto" --values["Healer"]
		-- 		then
		-- 			ni.spell.cast(spells.Inervate.id, ni.members[i].unit)
		-- 		end
		-- 	end
		-- end,

		["Interrupter"] = function()
			if enables["Interrupts"]
			then
				for i = 1, #Cache.enemies do
					local target = Cache.enemies[i].guid
					local name = Cache.enemies[i].name
					local distance = Cache.enemies[i].distance
					if (ni.unit.iscasting(target)
								or ni.unit.ischanneling(target))
					then
						if Cache.bear
						then
							if distance >= 8
									and ni.spell.cd(spells.Charge.id) == 0
									and (ni.unit.castingpercent(target) >= 70
										or ni.unit.ischanneling(target))
									and ni.spell.valid(target, spells.Charge.id, false, true)
							then
								ni.player.lookat(target)
								ni.spell.cast(spells.Charge.id, target)
								print("charge" .. name)
							else
								if distance <= 4
										and ni.spell.cd(spells.Bash.id) == 0
										and (ni.unit.castingpercent(target) >= 50
											or ni.unit.ischanneling(target))
								then
									ni.player.lookat(target)
									ni.spell.cast(spells.Bash.id, target)
								else
									if ni.spell.cd(20549) == 0
											and distance <= 8
											and (ni.unit.castingpercent(target) >= 50
												or ni.unit.ischanneling(target))
									then
										ni.spell.cast(20549)
									end
								end
							end
						else
							if Cache.cat
							then
								if GetComboPoints("player", target) > 1
										and ni.spell.cd(spells.Maim.id) == 0
										and ni.drtracker.get(target, "Controlled Stuns") > 0
										and (ni.unit.castingpercent(target) >= 90
											or ni.unit.ischanneling(target))
										and distance <= 4
								then
									ni.spell.cast(spells.Maim.id, target)
								else
									if ni.spell.cd(20549) == 0
											and distance <= 8
											and (ni.unit.castingpercent(target) >= 50
												or ni.unit.ischanneling(target))
									then
										ni.spell.cast(20549)
									end
								end
							end
						end
					end
				end
			end
		end,

		["Cycloneinterupt"] = function()
			if enables["CycloneInterupt"] then
				if ni.player.buff(spells.InstantCast.id) then
					local enemies = ni.unit.enemiesinrange("player", 20)
					for i = 1, #enemies do
						local target = enemies[i].guid
						local name = enemies[i].name
						local distance = enemies[i].distance
						if ni.unit.iscasting(target)
								and ni.drtracker.get(target, "Cyclone") > 0
								and ni.spell.valid("focus", spells.Cyclone.id, false, true)
								and (ni.unit.castingpercent(target) >= 80
									or ni.unit.ischanneling(target))
						then
							ni.spell.cast(spells.Cyclone.id, target)
						end
					end
				end
			end
		end,
		["CycloneFocus"] = function()
			if enables["CycloneFocus"]
			then
				if ni.player.buff(spells.InstantCast.id)
						and ni.unit.exists("focus")
						and not ni.unit.isstunned("focus")
						and not ni.unit.debuff("focus", spells.Cyclone.id)
						and not ni.unit.debuff("focus", 10890)
						and ni.drtracker.get("focus", "Cyclone") > 0
						and ni.spell.valid("focus", spells.Cyclone.id, false, true)
				then
					print("cyclone on focus")
					ni.spell.cast(spells.Cyclone.id, "focus")
				end
			end
		end,

		["FeralCharge"] = function()
			if enables["ChargeBear"] then
				if ni.spell.cd(spells.Charge.id) == 0
						and not ni.player.buff(spells.Prowl.id) then
					local enemies = ni.unit.enemiesinrange("player", 25)
					for i = 1, #enemies do
						local target = enemies[i].guid
						local name = enemies[i].name
						local distance = enemies[i].distance
						if distance >= 8
								and ni.spell.valid(target, spells.Charge.id, false, true)
								and #enemies < 4
								and (ni.unit.castingpercent(target) >= 5
									or ni.unit.ischanneling(target))

						then
							ni.spell.cast(spells.BearForm.id)
							ni.player.lookat(target)
							ni.spell.cast(spells.Charge.id, target)
							print(name)
						end
					end
				end
			end
		end,
		["Swipe"] = function()
			if ni.vars.combat.aoe and cat then
				local enemies = ni.unit.enemiesinrange("player", 8)
				if Cache.savagertimer > 2 and #enemies >= 3 then
					ni.spell.cast(62078)
					return true
				end
			end
			return false
		end,
		["Bombs"] = function()
			if enables["Bombs"]
			then
				if ni.player.hasitem(42641) --Sapper
						and ni.player.itemcd(42641) == 0
				then
					if ni.unit.inmelee(p, t)
							and UnitCanAttack("player", "target")
							and ni.player.hp() > 40
					then
						ni.player.useitem(42641)
					end
				else
					if ni.player.hasitem(41119) --Sarobomb
							and UnitCanAttack("player", "target")
							and ni.player.itemcd(41119) == 0
					then
						ni.player.useitem(41119)
						ni.player.clickat(t)
					end
				end
			end
		end,

		["Berserkfear"] = function()
			if enables["BerserkFear"] then
				local fears = { 10890, 20511, 6215, 17928 }
				if ni.spell.cd(spells.Berserk.id) == 0
						and cat then
					for d = 1, #fears do
						if ni.player.debuff(fears[d]) then
							ni.spell.cast(spells.Berserk.id)
						end
					end
				end
			end
		end,
		["Ferocious Bite"] = function()
			if GetComboPoints("player", "target") == 5
					and ni.spell.available(spells.FerociusBite.id)
			then
				if ni.player.buff(50334, "EXACT") --Berserk
						and Cache.savagertimer >= 4
						and Cache.riptimer >= 4 then
					ni.spell.cast(spells.FerociusBite.id)
				else
					if Cache.savagertimer >= 8
							and Cache.riptimer >= 10 then
						ni.spell.cast(spells.FerociusBite.id)
					end
				end
			end
		end,

		["Ferocious Bite1"] = function()
			if ni.spell.available(spells.FerociusBite.id)
					and ni.unit.hp(t) < 30
					and not ni.unit.isboss(t)
					and GetComboPoints("player", "target") >= 4 then
				ni.spell.cast(spells.FerociusBite.id)
				return true;
			end
		end,

		["Ferocious Bite2"] = function()
			if Cache.cat and ni.spell.available(spells.FerociusBite.id)
					and ni.unit.hp("target") < 20
					and not ni.unit.isboss(t)
					and GetComboPoints("player", "target") >= 3 then
				ni.spell.cast(spells.FerociusBite.id)
				return true;
			end
		end,
		["Antislow"] = function()
			local slows = { 45524, 1715, 3408, 59638, 20164, 25809, 31589, 51585, 50040, 50041, 31126, 31124, 122, 44614, 1604,
				45524, 50040, 339, 45334, 58179, 61391, 19306, 19185, 35101, 5116, 61394, 2974, 54644, 50245, 50271, 54706, 4167,
				33395, 55080, 11113, 6136, 120, 116, 44614, 31589, 63529, 20170, 31125, 3409, 26679, 64695, 63685, 8056, 8034,
				18118, 18223, 23694, 12323, 55536, 13099, 29703 }
			if ni.player.buff(spells.CatForm.id)
					and not ni.unit.inmelee("player", "target") then
				for d = 1, #slows do
					if ni.player.debuff(slows[d])
					then
						ni.spell.cast(spells.CatForm.id)
					end
				end
			end
		end,
		["Antireflect"] = function()
			if Cache.cat
					and ni.unit.buff("target", 23920) then
				ni.spell.cast(spells.Moonfire.id)
			end
		end,
		["DispelHEX"] = function()
			for i = 1, #ni.members do
				if ni.unit.debuff(ni.members[i].unit, 51514)
				then
					ni.spell.cast(spells.RemoveCurse.id, ni.members[i].unit)
				end
			end
		end,
		["Hibernate"] = function()
			local furrys = { 768, 9634, 2645 }
			if ni.player.buff(spells.InstantCast.id) then
				local enemies = ni.unit.enemiesinrange("player", 25)
				for i = 1, #enemies do
					local target = enemies[i].guid
					local name = enemies[i].name
					local distance = enemies[i].distance
					if ni.unit.buffs(target, 769 or 9634 or 26445)
					then
						ni.spell.cast(spells.Hibernate.id, target)
					end
				end
			end
		end,
		["Shredauto"] = function()
			if enables["Automated"] and Cache.cat then
				if ni.player.buff(spells.CatForm.id)
						and GetComboPoints("player", "target") < 5
				then
					if ni.unit.isbehind("player", "target")
					-- and IsUsableSpell(spells.Shred.id)
					then
						ni.spell.cast(spells.Shred.id, "target")
					elseif ni.spell.available(spells.Manglecat.id)
							and ni.player:powerraw("energy") >= 50
					then
						ni.spell.cast(spells.Manglecat.id, "target")
					end
				end
			end
		end,

		["SavageRoar"] = function()
			if enables["Automated"] then
				if Cache.cat
						and Cache.savagertimer == 0
						and GetComboPoints("player", "target") > 2
				then
					ni.spell.cast(spells.SavageRoar.id, "target")
				end
			end
		end,
		["Ingrediente Secreto"] = function()
			if enables["Automated"] then
				if Cache.cat then
					if GetComboPoints("player", "target") >= 2
							and Cache.savagertimer <= 9
							and math.abs(Cache.savagertimer - Cache.riptimer) < 4
							and Cache.riptimer >= 5 then
						ni.spell.cast(spells.SavageRoar.id, "target")
						return true;
					end
				end
			end
		end,

		["WILD"] = function()
			if enables["CCBuff"] then
				if Cache.cat
						and not ni.spell.gcd()
						and ni.player:power(3) < 30
						and ni.spell.cd(spells.TigersFury.id) > 3
						-- and not ni.player.buff(53909)
						-- and not ni.player.buff(54758)
						and not ni.player.buff(50334, "EXACT") --Berserk
						and not ni.player.buff(16870)    -- Clear casting
						and GetComboPoints("player", "target") < 5
						and ni.player.power("mana") >= 40
				then
					ni.spell.cast(spells.GOTW.id)
					ni.player.runtext("/stopattack")
					local _, gcdDuration = GetSpellCooldown(61304)
					ni.player.runtext("/use !cat form")
					return true;
				end
			end
		end,

		["Rip"] = function()
			if enables["Automated"] then
				if Cache.cat
						and GetComboPoints("player", "target") > 4
				then
					if not Cache.berserk
							and Cache.riptimer == 0
					then
						ni.spell.cast(spells.Rip.id, t)
					else
						if Cache.riptimer < 0.3
						then
							ni.spell.cast(spells.Rip.id, t)
						end
					end
				end
			end
		end,
		["SwipeBear"] = function()
			if ni.vars.combat.aoe then
				local enemies = ni.unit.enemiesinrange("player", 8)
				if ni.player.buff(spells.BearForm.id)
						and ni.player:power("rage") > 10
						and #enemies > 2
				then
					ni.spell.cast(spells.SwipeBear.id)
				end
			end
		end,

		["FrenziedRegeneration"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.player.hp() < 30
			then
				ni.spell.cast(spells.FrenziedRegeneration.id)
			end
		end,
		["MangleBear"] = function()
			if ni.player.buff(spells.BearForm.id)
					and ni.spell.available(spells.MangleBear.id)
			then
				ni.spell.cast(spells.MangleBear.id, "Target")
			end
		end,
		["Demoralazing"] = function()
			if Cache.bear
					and UnitCanAttack("player", "target")
					and ni.unit.inmelee("player", "target")
					and ni.spell.available(spells.Demoralazing.id)
					and not ni.unit.debuff(t, spells.Demoralazing.id)
					and not ni.unit.debuff(t, 62102)
					and not ni.unit.debuff(t, 16862)
					and not ni.unit.debuff(t, 702)
					and not ni.unit.debuff(t, 18179)
					and not ni.unit.debuff(t, 67)
					and not ni.unit.debuff(t, 12879)
			then
				ni.spell.cast(spells.Demoralazing.id)
			end
		end,
		["Maul"] = function()
			if Cache.bear
					and ni.spell.available(spells.Maul.id)
					and ni.player:power("rage") > 10
					and not IsCurrentSpell(spells.Maul.id)
			then
				ni.spell.cast(spells.Maul.id)
			end
		end,
		["Lacerate"] = function()
			if Cache.bear
					and ni.spell.available(spells.Lacerate.id)
					and ni.unit.debuffremaining("target", spells.Lacerate.id, "player") <= 3 then
				ni.spell.cast(spells.Lacerate.id, "target")
			end
		end,

		["Laceratestack"] = function()
			if Cache.bear
					and ni.spell.available(spells.Lacerate.id)
					and ni.unit.debuffstacks(t, spells.Lacerate.id, p) < 5 then
				ni.spell.cast(spells.Lacerate.id, p)
			end
		end,
		["FaerieFirebear"] = function()
			if Cache.bear
					and ni.spell.available(spells.FaerieFire.id)
					and ni.unit.exists(t)
					and UnitCanAttack(p, t)
			then
				ni.spell.cast(spells.FaerieFire.id, t)
			end
		end,
		["PrePull"] = function()
			if enables["CCBuff"] then
				local remainingTime = CheckPullInTimerRemaining()
				if remainingTime and remainingTime < 8
						and remainingTime > 2 then
					if not ni.player.buff(16870)
					then
						ni.spell.cast(spells.GOTW.id)
					else
						if not Cache.cat then
							ni.spell.cast(spells.CatForm.id)
						end
					end
				end
			end
		end
	}

	ni.bootstrap.profile("DalvaeFeral-Wotlk", queue, abilities, onload, onunload)
end

-- #showtooltip Feral Charge
-- /cast [noform:1] Dire Bear Form
-- /cast [@mouseover,harm,nodead][]Feral Charge - Bear()

-----------------------------------------------------------------
-- TOdO
-----------------------------------------------------------------
--Gui
-- Crear la rotacion de Burst y GG
-- Mejorar Feral Charge, hacer un interrupter
-- Auto matar snakes.
-- Auto sacar venenos cuando este en 50% o menos
-- Tranquility
--
--
