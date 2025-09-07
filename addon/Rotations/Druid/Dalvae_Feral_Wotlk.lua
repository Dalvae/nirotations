local build = select(4, GetBuildInfo())
local wotlk = build == 30300 or false

if wotlk then
	-- ===================================================================================
	-- CONFIGURATION
	-- ===================================================================================
	local Config = {
		-- General Toggles
		autoFormEnabled = true,
		autoProwlEnabled = true,
		huntForClearcasting = true,
		useOffensivePrePot = true,
		useCombatPotions = true,
		autoInterrupt = true,

		-- Tanking
		isMainTank = true,

		-- Smart Ability Toggles
		berserkOnFear = false,
		autoDispelEnabled = true,

		-- Health Thresholds
		survivalInstinct = 30,
		barkskin = 50,
		healthstonePotion = 20,
		frenziedRegen = 20,
		autoDispelHealth = 60,

		-- Combat Thresholds
		threatWarning = 90,
		aoeEnemyCount = 3,
	}

	-- ===================================================================================
	-- LIBRARIES & STATE
	-- ===================================================================================
	local dalvae = ni.utils.require("Dalvae")
	local SPELLS = dalvae.spells.druid
	local ITEMS = dalvae.items
	local FORMS = dalvae.forms

	local PlayerSpec = "DPS"
	local DBM_Timers = {}
	local Cache = {
		playerHP = 0,
		inCombat = false,
		isMounted = false,
		isDead = false,
		isChanneling = false,
		currentForm = nil,
		enemies_in_range = {},
		targetExists = false,
		targetHP = 0,
		targetTTD = 0,
		targetIsBehind = false,
		targetInMelee = false,
		targetIsUntouchable = false,
		energy = 0,
		comboPoints = 0,
		savageRoarRemains = 0,
		ripRemains = 0,
		rakeRemains = 0,
		mangleRemains = 0,
		threatStatus = { percent = 0 },
		hasClearcasting = false,
		hasBloodlust = false,
		rage = 0,
		lacerateStacks = 0,
		lacerateRemains = 0,
		tigersFuryRemains = 0, -- <-- AÑADE ESTO
		demoRoarActive = false,
		availableConsumables = { healthstone = nil, potion = nil },
	}

	-- ===================================================================================
	-- ABILITIES LOGIC (El "qué hacer")
	-- ===================================================================================
	local abilities = {}

	abilities["ScanConsumables"] = function()
		Cache.availableConsumables.healthstone = dalvae.findBestItem(ITEMS.healthstones)
		Cache.availableConsumables.potion = dalvae.findBestItem(ITEMS.health_potions)
		return false
	end

	abilities["CacheUpdate"] = function()
		Cache.inCombat = UnitAffectingCombat("player")
		Cache.isMounted = IsMounted()
		Cache.isDead = UnitIsDeadOrGhost("player")
		Cache.isChanneling = UnitChannelInfo("player")
		Cache.currentForm = GetShapeshiftForm()
		Cache.enemies_in_range = ni.unit.enemiesinrange("player", 30)
		Cache.targetExists = ni.unit.exists("target")
		Cache.hasBloodlust = ni.player.buff(2825) or ni.player.buff(32182)

		Cache.playerHP = ni.player.hp()
		if not Cache.targetExists or not UnitCanAttack("player", "target") then
			return false
		end
		Cache.targetHP = ni.unit.hp("target")
		Cache.targetTTD = ni.unit.ttd("target")
		Cache.targetIsBehind = ni.unit.isbehind("player", "target")
		Cache.targetInMelee = ni.unit.inmelee("player", "target")
		Cache.targetIsUntouchable = dalvae.isUnitUntouchable("target")

		if PlayerSpec == "DPS" and Cache.currentForm == FORMS.cat then
			Cache.energy = ni.player.powerraw("energy")
			Cache.comboPoints = GetComboPoints("player", "target")
			Cache.savageRoarRemains = ni.player.buffremaining(SPELLS.SavageRoar.id)
			Cache.ripRemains = ni.unit.debuffremaining("target", SPELLS.Rip.id, "player")
			Cache.rakeRemains = ni.unit.debuffremaining("target", SPELLS.Rake.id, "player")
			Cache.mangleRemains = ni.unit.debuffremaining("target", SPELLS.MangleCat.id)
			local threatValue = ni.unit.threat("target") or 0
			Cache.threatStatus = { percent = threatValue }
			Cache.hasClearcasting = ni.player.buff(SPELLS.Clearcasting.id)
			Cache.tigersFuryRemains = ni.player.buffremaining(SPELLS.TigersFury.id)
		elseif PlayerSpec == "TANK" and Cache.currentForm == FORMS.bear then
			Cache.rage = ni.player.powerraw("rage")
			Cache.lacerateStacks = ni.unit.debuffstacks("target", SPELLS.Lacerate.id, "player")
			Cache.lacerateRemains = ni.unit.debuffremaining("target", SPELLS.Lacerate.id, "player")
			Cache.demoRoarActive = ni.unit.debuff("target", SPELLS.DemoralizingRoar.id)
		end

		-- --- CAMBIO CLAVE 2 ---
		-- Devolvemos 'false' para indicar que la actualización ha terminado
		-- y que el motor debe continuar con la siguiente habilidad en la cola.
		return false
	end

	abilities["StopConditions"] = function()
		if Cache.isMounted or Cache.isDead or Cache.isChanneling or ni.player.buff("Drink") then
			return true
		end
		return false
	end

	abilities["AutoCatFormOOC"] = function()
		if
			Config.autoFormEnabled
			and not Cache.inCombat
			and Cache.currentForm == FORMS.humanoid
			and PlayerSpec == "DPS"
		then
			return dalvae.cast(SPELLS.CatForm)
		end
		return false
	end

	abilities["AutoProwl"] = function()
		if
			Config.autoProwlEnabled
			and not Cache.inCombat
			and Cache.currentForm == FORMS.cat
			and not ni.player.buff(SPELLS.Prowl.id)
		then
			return dalvae.cast(SPELLS.Prowl)
		end
		return false
	end

	abilities["PreCombatHandler"] = function()
		for _, t in pairs(DBM_Timers) do
			if t.message == "Pull in" then
				local r = t.expirationTime - GetTime()
				if r > 0 then
					if r < 8 and r > 2 and Config.huntForClearcasting and not Cache.hasClearcasting then
						dalvae.cast(SPELLS.MarkoftheWild, "player")
					end
					if r < 1.6 and r > 1.4 and Config.useOffensivePrePot then
						local pot = dalvae.findBestItem(ITEMS.speed_potions)
						if pot then
							return ni.player.useitem(pot)
						end
					end
				end
			end
		end
		return false
	end

	abilities["TargetSwapHandler"] = function()
		if Cache.targetIsUntouchable then
			for _, enemy in ipairs(Cache.enemies_in_range) do
				if
					enemy.guid ~= UnitGUID("target")
					and UnitCanAttack("player", enemy.guid)
					and not dalvae.isUnitUntouchable(enemy.guid)
				then
					ni.unit.settarget(enemy.guid)
					return true
				end
			end
			return true
		end
		return false
	end

	abilities["Defensives"] = function()
		-- Supervivencia (Survival Instincts)
		if Cache.playerHP < Config.survivalInstinct then
			if dalvae.spellUsable(SPELLS.SurvivalInstincts) then
				return dalvae.cast(SPELLS.SurvivalInstincts)
			end
		end

		-- Piel de corteza (Barkskin)
		if Cache.playerHP < Config.barkskin then
			if dalvae.spellUsable(SPELLS.Barkskin) then
				return dalvae.cast(SPELLS.Barkskin)
			end
		end

		-- Pociones y Piedras de Vida
		if Cache.playerHP < Config.healthstonePotion then
			if
				Cache.availableConsumables.healthstone
				and ni.player.itemcd(Cache.availableConsumables.healthstone) == 0
			then
				return ni.player.useitem(Cache.availableConsumables.healthstone)
			end
			if Cache.availableConsumables.potion and GetItemCooldown(Cache.availableConsumables.potion) == 0 then
				return ni.player.useitem(Cache.availableConsumables.potion)
			end
		end

		-- Gestión de Amenaza (Shadowmeld)
		if
			PlayerSpec == "DPS"
			and select(2, UnitRace("player")) == "NightElf"
			and Cache.threatStatus.percent >= Config.threatWarning
		then
			if dalvae.cast(SPELLS.Shadowmeld) then
				return true
			elseif Cache.currentForm ~= FORMS.bear then
				return dalvae.cast(SPELLS.BearForm)
			end
		end

		-- Regeneración Frenética (Tanque)
		if
			PlayerSpec == "TANK"
			and Cache.playerHP < Config.frenziedRegen
			and dalvae.spellUsable(SPELLS.FrenziedRegeneration)
		then
			return dalvae.cast(SPELLS.FrenziedRegeneration)
		end

		return false
	end

	abilities["AutoDispel"] = function()
		if Config.autoDispelEnabled and Cache.playerHP < Config.autoDispelHealth then
			local p, c = false, false
			for i = 1, 40 do
				local _, _, _, _, t = UnitDebuff("player", i)
				if not t then
					break
				end
				if t == "Poison" then
					p = true
				end
				if t == "Curse" then
					c = true
				end
			end
			if p and dalvae.cast(SPELLS.AbolishPoison, "player") then
				return true
			elseif c and dalvae.cast(SPELLS.RemoveCurse, "player") then
				return true
			end
		end
		return false
	end

	abilities["BerserkOnFear"] = function()
		if
			Config.berserkOnFear
			and dalvae.spellUsable(SPELLS.Berserk)
			and (ni.player.debuff(5782) or ni.player.debuff(17928))
		then
			return dalvae.cast(SPELLS.Berserk)
		end
		return false
	end

	abilities["AutoForm"] = function()
		if not Config.autoFormEnabled or (Cache.currentForm == FORMS.cat or Cache.currentForm == FORMS.bear) then
			return false
		end
		if PlayerSpec == "DPS" then
			return dalvae.cast(SPELLS.CatForm)
		elseif PlayerSpec == "TANK" then
			return dalvae.cast(SPELLS.BearForm)
		end
		return false
	end

	abilities["AutoAttack"] = function()
		if
			Cache.targetExists
			and UnitCanAttack("player", "target")
			and not IsCurrentSpell(SPELLS.Attack.name)
			and not Cache.targetIsUntouchable
			and (Cache.currentForm == FORMS.cat or Cache.currentForm == FORMS.bear)
		then
			return dalvae.cast(SPELLS.Attack.id)
		end
		return false
	end

	abilities["Opener"] = function()
		if ni.player.buff(SPELLS.Prowl.id) then
			if dalvae.spellUsable(SPELLS.Pounce) then
				return dalvae.cast(SPELLS.Pounce, "target")
			elseif dalvae.spellUsable(SPELLS.MangleCat) then
				return dalvae.cast(SPELLS.MangleCat, "target")
			end
		end
		return false
	end

	abilities["UseClearcastingFinisher"] = function()
		if
			Cache.hasClearcasting
			and Cache.comboPoints == 5
			and Cache.ripRemains > 7
			and Cache.savageRoarRemains > 7
		then
			return dalvae.cast(SPELLS.FerociousBite, "target")
		end
		return false
	end

	abilities["UseClearcastingShred"] = function()
		if Cache.hasClearcasting and Cache.targetIsBehind and dalvae.spellUsable(SPELLS.Shred) then
			return dalvae.cast(SPELLS.Shred, "target")
		end
		return false
	end

	abilities["AlignCooldowns"] = function()
		if not ni.vars.combat.cd or not dalvae.spellUsable(SPELLS.Berserk) then
			return false
		end
		if Cache.tigersFuryRemains > 0 then
			dalvae.cast(SPELLS.Berserk)
			if Config.useCombatPotions then
				local pot = Cache.hasBloodlust and dalvae.findBestItem(ITEMS.strength_potions)
					or dalvae.findBestItem(ITEMS.speed_potions)
				if pot then
					ni.player.useitem(pot)
				end
			end
			ni.player.runtext("/use 10")
			return true
		end
		return false
	end

	abilities["UseEngineeringGloves"] = function()
		if not ni.vars.combat.cd or ni.spell.cd(SPELLS.Berserk.id) < 60 then
			return false
		end
		ni.player.runtext("/use 10")
		return true
	end

	abilities["MaintainSavageRoar"] = function()
		if Cache.comboPoints > 0 then
			if Cache.savageRoarRemains == 0 then
				return dalvae.cast(SPELLS.SavageRoar)
			end
			if Cache.savageRoarRemains < 5 and math.abs(Cache.savageRoarRemains - Cache.ripRemains) < 3 then
				return dalvae.cast(SPELLS.SavageRoar)
			end
		end
		return false
	end

	abilities["MaintainRip"] = function()
		if Cache.comboPoints >= 5 and Cache.ripRemains < 2 and Cache.savageRoarRemains > 2 and Cache.targetTTD > 10 then
			return dalvae.cast(SPELLS.Rip, "target")
		end
		return false
	end

	abilities["MaintainRake"] = function()
		if Cache.rakeRemains < 2 and Cache.comboPoints < 5 then
			return dalvae.cast(SPELLS.Rake, "target")
		end
		return false
	end

	abilities["MaintainMangle"] = function()
		if ni.unit.debuffremaining("target", SPELLS.MangleCat.id) < 2 then
			return dalvae.cast(SPELLS.MangleCat, "target")
		end
		return false
	end

	abilities["FerociousBiteExecute"] = function()
		if
			Cache.comboPoints >= 5
			and Cache.ripRemains > 7
			and Cache.savageRoarRemains > 10
			and (Cache.targetTTD < 12 or Cache.targetHP < 25)
		then
			return dalvae.cast(SPELLS.FerociousBite, "target")
		end
		return false
	end

	abilities["BuildComboPoints"] = function()
		if Cache.currentForm ~= FORMS.cat or Cache.comboPoints >= 5 then
			return false
		end
		if Cache.targetIsBehind and dalvae.spellUsable(SPELLS.Shred) then
			return dalvae.cast(SPELLS.Shred, "target")
		end
		if dalvae.spellUsable(SPELLS.MangleCat) then
			return dalvae.cast(SPELLS.MangleCat, "target")
		end
		return false
	end

	abilities["UseTigersFury"] = function()
		if Cache.energy < 40 and dalvae.spellUsable(SPELLS.TigersFury) then
			return dalvae.cast(SPELLS.TigersFury)
		end
		return false
	end

	abilities["Powershift"] = function()
		if
			Config.huntForClearcasting
			and Cache.energy < 35
			and not Cache.hasClearcasting
			and ni.spell.cd(SPELLS.TigersFury.id) > 2
		then
			ni.player.runtext("/cast !Cat Form")
			return true
		end
		return false
	end

	abilities["SelectHighestHealthTarget"] = function()
		if Cache.comboPoints > 0 then
			return false
		end
		local h, t = 0, nil
		for _, u in ipairs(Cache.enemies_in_range) do
			if u.distance < 9 then
				local uh = ni.unit.hp(u.guid)
				if uh > h then
					h, t = uh, u.guid
				end
			end
		end
		if t and not UnitIsUnit("target", t) then
			ni.unit.settarget(t)
			return true
		end
		return false
	end

	abilities["SpamSwipe"] = function()
		if
			#Cache.enemies_in_range >= Config.aoeEnemyCount
			and dalvae.spellUsable(SPELLS.SwipeCat)
			and Cache.savageRoarRemains > 2
		then
			return dalvae.cast(SPELLS.SwipeCat)
		end
		return false
	end

	abilities["BuildComboPointsForAoE"] = function()
		if Cache.savageRoarRemains < 5 and Cache.comboPoints < 3 then
			if not ni.unit.debuff("target", SPELLS.MangleCat.id) then
				return dalvae.cast(SPELLS.MangleCat, "target")
			end
			if not ni.unit.debuff("target", SPELLS.Rake.id, "player") then
				return dalvae.cast(SPELLS.Rake, "target")
			end
			return dalvae.cast(SPELLS.MangleCat, "target")
		end
		return false
	end

	abilities["ManageThreat"] = function()
		if not Config.isMainTank then
			return false
		end
		for i = 1, #ni.members do
			local member = ni.members[i]
			if not member.isTank then
				local targetGUID = UnitGUID(member.unit .. "target")
				if targetGUID and ni.unit.threat(targetGUID).isTanking then
					if ni.unit.distance(targetGUID) < 30 and dalvae.cast(SPELLS.Growl, targetGUID) then
						return true
					end
				end
			end
		end
		return false
	end

	abilities["MaintainDemoralizingRoar"] = function()
		if not Cache.demoRoarActive and dalvae.spellUsable(SPELLS.DemoralizingRoar) and Cache.targetInMelee then
			return dalvae.cast(SPELLS.DemoralizingRoar)
		end
		return false
	end

	abilities["MaintainMangleBear"] = function()
		if dalvae.spellUsable(SPELLS.MangleBear) then
			return dalvae.cast(SPELLS.MangleBear, "target")
		end
		return false
	end

	abilities["MaintainLacerate"] = function()
		if
			(Cache.lacerateStacks < 5 or (Cache.lacerateStacks == 5 and Cache.lacerateRemains < 3))
			and dalvae.spellUsable(SPELLS.Lacerate)
		then
			return dalvae.cast(SPELLS.Lacerate, "target")
		end
		return false
	end

	abilities["MaulRageDump"] = function()
		if Cache.rage > 60 and dalvae.spellUsable(SPELLS.Maul) then
			return dalvae.cast(SPELLS.Maul, "target")
		end
		return false
	end

	abilities["SpamSwipeBear"] = function()
		if #Cache.enemies_in_range >= Config.aoeEnemyCount and dalvae.spellUsable(SPELLS.SwipeBear) then
			return dalvae.cast(SPELLS.SwipeBear)
		end
		return false
	end

	abilities["SpamMaul"] = function()
		if dalvae.spellUsable(SPELLS.Maul) and Cache.rage > 30 then
			return dalvae.cast(SPELLS.Maul, "target")
		end
		return false
	end

	-- ===================================================================================
	-- DYNAMIC QUEUES - El "cuándo hacer"
	-- ===================================================================================
	local OutOfCombatQueue = {
		"CacheUpdate",
		"StopConditions",
		"AutoCatFormOOC",
		"AutoProwl",
		"PreCombatHandler",
		"Opener",
	}

	local DpsSingleTargetQueue = {
		"CacheUpdate",
		"StopConditions",
		"Defensives",
		"TargetSwapHandler",
		"BerserkOnFear",
		"AutoDispel",
		"AutoForm",
		"AutoAttack",
		"Opener",
		"UseClearcastingFinisher",
		"UseClearcastingShred",
		"UseEngineeringGloves",
		"AlignCooldowns",
		"MaintainSavageRoar",
		"MaintainRip",
		"MaintainRake",
		"MaintainMangle",
		"FerociousBiteExecute",
		"UseTigersFury",
		"BuildComboPoints",
		"Powershift",
	}

	local DpsAoEQueue = {
		"CacheUpdate",
		"StopConditions",
		"Defensives",
		"TargetSwapHandler",
		"BerserkOnFear",
		"AutoDispel",
		"AutoForm",
		"AutoAttack",
		"Opener",
		"UseClearcastingShred",
		"UseEngineeringGloves",
		"AlignCooldowns",
		"SelectHighestHealthTarget",
		"MaintainSavageRoar",
		"SpamSwipe",
		"BuildComboPointsForAoE",
		"UseTigersFury",
		"Powershift",
	}

	local TankSingleTargetQueue = {
		"CacheUpdate",
		"StopConditions",
		"Defensives",
		"AutoForm",
		"AutoAttack",
		"ManageThreat",
		"MaintainDemoralizingRoar",
		"MaintainMangleBear",
		"MaintainLacerate",
		"MaulRageDump",
	}
	local TankAoEQueue = {
		"CacheUpdate",
		"StopConditions",
		"Defensives",
		"AutoForm",
		"AutoAttack",
		"ManageThreat",
		"MaintainDemoralizingRoar",
		"SpamSwipeBear",
		"SpamMaul",
	}

	-- ===================================================================================
	-- CORE LOGIC - El Selector de Cola Dinámico
	-- ===================================================================================
	local function DynamicQueueSelector()
		if not UnitAffectingCombat("player") then
			return OutOfCombatQueue
		end

		local useAoE = #ni.unit.enemiesinrange("player", 10) >= Config.aoeEnemyCount and ni.vars.combat.aoe
		if PlayerSpec == "TANK" then
			return useAoE and TankAoEQueue or TankSingleTargetQueue
		else -- DPS
			return useAoE and DpsAoEQueue or DpsSingleTargetQueue
		end
	end

	-- ===================================================================================
	-- EVENT HANDLING & INITIALIZATION
	-- ===================================================================================
	local function updatePlayerSpec()
		local _, _, _, _, rank = GetTalentInfo(2, 22)
		PlayerSpec = (rank and rank >= 3) and "TANK" or "DPS"
		print("Dalvae Feral: Specialization set to " .. PlayerSpec)
	end

	local function DBMEventHandler(event, id, msg, duration)
		if event == "DBM_TimerStart" then
			DBM_Timers[id] = { message = msg, expirationTime = GetTime() + duration }
		elseif event == "DBM_TimerStop" then
			DBM_Timers[id] = nil
		end
	end

	SLASH_SHRED1 = "/shred"
	SlashCmdList["SHRED"] = function()
		if GetShapeshiftForm() ~= FORMS.cat then
			dalvae.cast(SPELLS.CatForm)
		else
			if ni.unit.isbehind("player", "target") then
				dalvae.cast(SPELLS.Shred)
			else
				dalvae.cast(SPELLS.MangleCat)
			end
		end
	end
	SLASH_CHARGES1 = "/charges"
	SlashCmdList["CHARGES"] = function()
		if GetShapeshiftForm() ~= FORMS.bear then
			dalvae.cast(SPELLS.BearForm)
		else
			ni.player.lookat("mouseover")
			dalvae.cast(SPELLS.FeralChargeBear, "mouseover")
		end
	end
	SLASH_STOPCASTING1 = "/stopcasting"
	SlashCmdList["STOPCASTING"] = function()
		ni.rotation.delay(1)
	end

	local function onload()
		ni.listener:add("DalvaeFeral", "PLAYER_ENTERING_WORLD", updatePlayerSpec)
		ni.listener:add("DalvaeFeral", "ACTIVE_TALENT_GROUP_CHANGED", updatePlayerSpec)
		ni.listener:add("DalvaeFeralConsumables", "BAG_UPDATE", abilities.ScanConsumables)
		ni.listener:add("DalvaeFeralConsumables", "PLAYER_REGEN_ENABLED", abilities.ScanConsumables)
		if DBM then
			DBM:RegisterCallback("DBM_TimerStart", DBMEventHandler)
			DBM:RegisterCallback("DBM_TimerStop", DBMEventHandler)
		end
		updatePlayerSpec()
		abilities.ScanConsumables()
		print("Dalvae Feral Druid profile loaded.")
	end

	local function onunload()
		ni.listener:remove("DalvaeFeral", "PLAYER_ENTERING_WORLD")
		ni.listener:remove("DalvaeFeral", "ACTIVE_TALENT_GROUP_CHANGED")
		ni.listener:remove("DalvaeFeralConsumables", "BAG_UPDATE")
		ni.listener:remove("DalvaeFeralConsumables", "PLAYER_REGEN_ENABLED")
		if DBM then
			DBM:UnregisterCallback("DBM_TimerStart")
			DBM:UnregisterCallback("DBM_TimerStop")
		end
		print("Dalvae Feral Druid profile unloaded.")
	end

	-- ===================================================================================
	-- BOOTSTRAP - Conectamos todo al motor de "ni"
	-- ===================================================================================
	ni.bootstrap.profile("Dalvae_Feral_Wotlk", DynamicQueueSelector, abilities, onload, onunload)
end
