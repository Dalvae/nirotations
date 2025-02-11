local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
local queue = {
	"Pause",
	"Innervate", 
	"Swiftmend",
	"WildGrowth",
	"Tank Heal",
	"RemoveCorruption",
	"Regrowth",
	"Rejuvenation",
	"Nourish"
}

local function GetSetting(name)
	for k, v in ipairs(items) do
		if v.type == "entry" and v.key ~= nil and v.key == name then
			return v.value, v.enabled
		end
		if v.type == "dropdown" and v.key ~= nil and v.key == name then
			for k2, v2 in pairs(v.menu) do
				if v2.selected then
					return v2.value
				end
			end
		end
		if v.type == "input" and v.key ~= nil and v.key == name then
			return v.value
		end
	end
end

local spells = {
	--Restoration
	MarkoftheWild = {id = 1126, name = GetSpellInfo(1126)},
	Nourish = {id = 50464, name = GetSpellInfo(50464)},
	Rebirth = {id = 20484, name = GetSpellInfo(20484)},
	Regrowth = {id = 8936, name = GetSpellInfo(8936)},
	Rejuvenation = {id = 774, name = GetSpellInfo(774)},
	RemoveCorruption = {id = 2782, name = GetSpellInfo(2782)},
	Revive = {id = 50769, name = GetSpellInfo(50769)},
	Swiftmend = {id = 18562, name = GetSpellInfo(18562)},
	WildGrowth = {id = 48438, name = GetSpellInfo(48438)},
	Lifebloom = {id = 33763, name = GetSpellInfo(33763)},
	Tranquility = {id = 740, name = GetSpellInfo(740)},
	HealingTouch = {id = 5185, name = GetSpellInfo(5185)},
	Innervate = {id = 29166, name = GetSpellInfo(29166)}
}

local function GetSetting(name)
	for k, v in ipairs(items) do
		if v.type == "entry" and v.key ~= nil and v.key == name then
			return v.value, v.enabled
		end
		if v.type == "dropdown" and v.key ~= nil and v.key == name then
			for k2, v2 in pairs(v.menu) do
				if v2.selected then
					return v2.value
				end
			end
		end
		if v.type == "input" and v.key ~= nil and v.key == name then
			return v.value
		end
	end
end

local items = {
	settingsfile = "rDruidCata.xml",
	{type = "title", text = "Resto Druid Cata"},
	{type = "separator"},
	{type = "title", text = "Combat Only"},
	{
		type = "entry",
		text = "Combat Only",
		tooltip = "Only let the routine run if your in combat",
		enabled = true,
		key = "CombatOnly"
	},
	{type = "separator"},
	{type = "title", text = "Tank Heal"},
	{
		type = "entry",
		text = "Regrowth Tank HP",
		value = 85,
		enabled = true,
		key = "RegrowthTank"
	},
	{
		type = "entry",
		text = "Rejuvenation Tank HP",
		value = 92,
		enabled = true,
		key = "RejuvenationTank"
	},
	{
		type = "entry",
		text = "Let Lifebloom Expire",
		tooltip = "Allows lifebloom to expire instead of refreshing",
		enabled = false,
		key = "LifebloomExpire"
	},
	{type = "separator"},
	{type = "title", text = "Heals"},
	{
		type = "entry",
		text = "Regrowth HP",
		value = 80,
		key = "RegrowthHp"
	},
	{
		type = "entry",
		text = "Rejuvenation HP",
		value = 90,
		key = "RejuvenationHp"
	},
	{
		type = "entry",
		text = "Wild Growth HP",
		value = 90,
		key = "WildGrowthHp"
	},
	{
		type = "entry",
		text = "Wild Growth AoE count",
		tooltip = "The number of units nearby below set Hp%",
		value = 2,
		key = "WildGrowthAoeCount"
	},
	{
		type = "entry",
		text = "Nourish HP",
		value = 75,
		enabled = true,
		key = "NourishHp"
	},
	{
		type = "entry",
		text = "Swiftmend HP",
		value = 50,
		enabled = true,
		key = "SwiftmendHp"
	},
	{
		type = "entry",
		text = "Innervate Mana%",
		value = 60,
		key = "Innervate"
	},
	{
		type = "entry",
		text = "Enable Dispel",
		enabled = false,
		key = "Dispel"
	},
	{type = "separator"},
	{type = "title", text = "Tank Heal"},
	{type = "title", text = "Lifebloom Target"},
	{
		type = "dropdown",
		menu = {
			{
				selected = true,
				value = 1,
				text = "|cffFFFF33Main Tank"
			},
			{
				selected = false,
				value = 2,
				text = "|cffFF9900Off Tank"
			},
			{
				selected = false,
				value = 3,
				text = "|cff24E0FBFocus"
			}
		},
		key = "LifebloomTar"
	},
	{
		type = "entry",
		text = "Let Lifebloom Expire",
		tooltip = "Allows lifebloom to expire instead of refreshing",
		enabled = false,
		key = "LifebloomExpire"
	}
}
local function LosCast(spell, tar)
	if ni.player.los(tar) and IsSpellInRange(spell, tar) == 1 then
		ni.spell.cast(spell, tar)
		ni.debug.log(string.format("Casting %s on %s", spell, tar))
		return true
	end
	return false
end
local function ValidUsable(id, tar)
	if IsSpellKnown(id) and ni.spell.available(id) and ni.spell.valid(tar, id, false, true, true) then
		return true
	end
	return false
end
local incombat = false
local function CombatEventCatcher(event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = true
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false
	end
end
local function OnLoad()
	ni.combatlog.registerhandler("RestroCata", CombatEventCatcher)
	ni.GUI.AddFrame("RestroCata", items)
end
local function OnUnload()
	ni.combatlog.unregisterhandler("RestroCata")
	ni.GUI.DestroyFrame("RestroCata")
end
local abilities = {
	["Pause"] = function()
		local _, combatOnlyEnabled = GetSetting("CombatOnly")
		if IsMounted() or UnitIsDeadOrGhost("player") or (combatOnlyEnabled and not incombat) then
			return true
		end
	end,
	["Tank Heal"] = function()
		local mainTank, offTank = ni.tanks()
		local lbTar = GetSetting("LifebloomTar")
		local rjTankValue, rjEnabled = GetSetting("RejuvenationTank")
		local rgTankValue, rgEnabled = GetSetting("RegrowthTank")
		--Lifebloom focus
		if lbTar == 3 and ni.unit.exists("focus") then
			local lbftank, _, _, lbftank_count, _, _, lbftank_time = ni.unit.buff("focus", spells.Lifebloom.id, "player")
			if
				(not lbftank or lbftank_count < 3 or lbftank_time - GetTime() < 2) and ValidUsable(spells.Lifebloom.id, "focus") and
					LosCast(spells.Lifebloom.name, "focus")
			 then
				return true
			end
		end
		if mainTank ~= nil and ni.unit.exists(mainTank) then
			-- /dump n.unit.buff("player", 8936, "player")
			local lbtank, _, _, lbtank_count, _, _, lbtank_time = ni.unit.buff(mainTank, spells.Lifebloom.id, "player")
			local rgtank, _, _, _, _, _, rgtank_time = ni.unit.buff(mainTank, spells.Regrowth.id, "player")
			local rjtank, _, _, _, _, _, rjtank_time = ni.unit.buff(mainTank, spells.Rejuvenation.id, "player")
			--Lifebloom mainTank
			if
				(not lbtank or lbtank_count < 3 or lbtank_time - GetTime() < 2) and lbTar == 1 and
					ValidUsable(spells.Lifebloom.id, mainTank) and
					LosCast(spells.Lifebloom.name, mainTank)
			 then
				return true
			end
			--Rejuvenation mainTank
			if
				rjEnabled and (not rjtank or rjtank_time - GetTime() < 2) and ni.unit.hp(mainTank) <= rjTankValue and
					ValidUsable(spells.Rejuvenation.id, mainTank) and
					LosCast(spells.Rejuvenation.name, mainTank)
			 then
				return true
			end
			--Regrowth mainTank
			if
				rgEnabled and (not rgtank or rgtank_time - GetTime() < 2) and ni.unit.hp(mainTank) <= rgTankValue and
					not ni.player.ismoving() and
					ValidUsable(spells.Regrowth.id, mainTank) and
					LosCast(spells.Regrowth.name, mainTank)
			 then
				return true
			end
			--offTank
			if offTank ~= nil and ni.unit.exists(offTank) then
				local lbotank, _, _, lbotank_count, _, _, lbotank_time = ni.unit.buff(mainTank, spells.Lifebloom.id, "player")
				local rgotank, _, _, _, _, _, rgotank_time = ni.unit.buff(offTank, spells.Regrowth.id, "player")
				local rjotank, _, _, _, _, _, rjotank_time = ni.unit.buff(offTank, spells.Rejuvenation.id, "player")
				--Lifebloom offTank
				if
					(not lbotank or lbotank_count < 3 or (not enables["LifebloomExpire"] and lbotank_time - GetTime() < 2)) and
						lbTar == 2 and
						ValidUsable(spells.Lifebloom.id, offTank) and
						LosCast(spells.Lifebloom.name, offTank)
				 then
					return true
				end
				--Rejuvenation offTank
				if
					rjEnabled and (rjotank == nil or not rjotank or rjotank_time - GetTime() < 2) and
						ni.unit.hp(offTank) <= rjTankValue and
						ValidUsable(spells.Rejuvenation.id, offTank) and
						LosCast(spells.Rejuvenation.name, offTank)
				 then
					return true
				end
				--Regrowth offTank
				if
					rgEnabled and (rgotank == nil or not rgotank or rgotank_time - GetTime() < 2) and
						ni.unit.hp(offTank) <= rgTankValue and
						not ni.player.ismoving() and
						ValidUsable(spells.Rejuvenation.id, offTank) and
						LosCast(spells.Rejuvenation.name, offTank)
				 then
					return true
				end
			end
		end
	end,
	["Rejuvenation"] = function()
		local value = GetSetting("RejuvenationHp")
		for i = 1, #ni.members do
			if
				ni.members[i].hp <= value and
					not ni.unit.buff(ni.members[i].unit, spells.Rejuvenation.id, "player") and
					ValidUsable(spells.Rejuvenation.id, ni.members[i].unit) and
					LosCast(spells.Rejuvenation.name, ni.members[i].unit)
			 then
				return true
			end
		end
	end,
	["Regrowth"] = function()
		if not ni.player.ismoving() then
			local value = GetSetting("RegrowthHp")
			for i = 1, #ni.members do
				if
					ni.members[i].hp <= value and not ni.unit.buff(ni.members[i].unit, spells.Regrowth.id, "player") and
						ValidUsable(spells.Regrowth.id, ni.members[i].unit) and
						LosCast(spells.Regrowth.name, ni.members[i].unit)
				 then
					return true
				end
			end
		end
	end,
	["WildGrowth"] = function()
		if ni.spell.available(spells.WildGrowth.id) then
			local hpValue = GetSetting("WildGrowthHp")
			local countValue = GetSetting("WildGrowthAoeCount")
			local members = ni.members.inrangebelow("player", 40, hpValue)
			if
				#members >= countValue and ValidUsable(spells.WildGrowth.id, members[1].unit) and
					LosCast(spells.WildGrowth.name, members[1].unit)
			 then
				return true
			end
		end
	end,
	["Nourish"] = function()
		local value, enabled = GetSetting("NourishHp")
		if enabled and not ni.player.ismoving() then
			for i = 1, #ni.members do
				if
					ni.members[i].hp < value and ValidUsable(spells.Nourish.id, ni.members[i].unit) and
						LosCast(spells.Nourish.name, ni.members[i].unit)
				 then
					return true
				end
			end
		end
	end,
	["Swiftmend"] = function()
		local value, enabled = GetSetting("SwiftmendHp")
		if enabled then
			for i = 1, #ni.members do
				if
					ni.members[i].hp < value and
						(ni.unit.buff(ni.members[i].unit, spells.Regrowth.id, "player") or
							ni.unit.buff(ni.members[i].unit, spells.Rejuvenation.id, "player")) and
						ValidUsable(spells.Swiftmend.id, ni.members[i].unit) and
						LosCast(spells.Swiftmend.name, ni.members[i].unit)
				 then
					return true
				end
			end
		end
	end,
	["Innervate"] = function()
		local value = GetSetting("Innervate")
		if
			ni.player.power("mana") <= value and ValidUsable(spells.Innervate.id, "player") and
				LosCast(spells.Innervate.name, "player")
		 then
			return true
		end
	end,
	["RemoveCorruption"] = function()
		local _, enabled = GetSetting("Dispel")
		if enabled then
			local naturesCure = GetTalentInfo(3, 17)
			for t = 1, #ni.members do
				local tar = ni.members[t].unit
				local i = 1
				local debuff = UnitDebuff(tar, i)
				while debuff do
					local debufftype = select(5, UnitDebuff(tar, i))
					if debufftype == "Curse" or debufftype == "Poison" or (naturesCure == 1 and debufftype == "Magic") then
						if ValidUsable(spells.RemoveCorruption.id, tar) and LosCast(spells.RemoveCorruption.name, tar) then
							return true
						end
					end
					i = i + 1
					debuff = UnitDebuff(t, i)
				end
			end
		end
	end
}
	ni.bootstrap.profile("Resto_Cata", queue, abilities, OnLoad, OnUnload)
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
    ni.bootstrap.profile("Resto_Cata", queue, abilities);
end;
