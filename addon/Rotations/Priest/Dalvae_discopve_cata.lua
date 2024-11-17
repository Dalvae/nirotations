local build = select(4, GetBuildInfo());
local cata = build == 40300 or false;
if cata then
	local spells = {
		Renew = { id = 139, name = GetSpellInfo(139), icon = select(3, GetSpellInfo(139)) },
		Heal = { id = 2050, name = GetSpellInfo(2050), icon = select(3, GetSpellInfo(2050)) },
		HolyWordSerenity = { id = 88684, name = GetSpellInfo(88684), icon = select(3, GetSpellInfo(88684)) },
		FlashHeal = { id = 2061, name = GetSpellInfo(2061), icon = select(3, GetSpellInfo(2061)) },
		GreaterHeal = { id = 2060, name = GetSpellInfo(2060), icon = select(3, GetSpellInfo(2060)) },
		PrayerOfMending = { id = 33076, name = GetSpellInfo(33076), icon = select(3, GetSpellInfo(33076)) },
		Penance = { id = 47540, name = GetSpellInfo(47540), icon = select(3, GetSpellInfo(47540)) },
		PowerWordShield = { id = 17, name = GetSpellInfo(17), icon = select(3, GetSpellInfo(17)) },
		Smite = { id = 585, name = GetSpellInfo(585), icon = select(3, GetSpellInfo(585)) },
		HolyFire = { id = 14914, name = GetSpellInfo(14914), icon = select(3, GetSpellInfo(14914)) },
		PrayerofHealing = { id = 596, name = GetSpellInfo(596), icon = select(3, GetSpellInfo(596)) },
		Archangel = { id = 87151, name = GetSpellInfo(87151), icon = select(3, GetSpellInfo(87151)) },
		InnerFire = { id = 588, name = GetSpellInfo(588), icon = select(3, GetSpellInfo(588)) },
		PowerInfusion = { id = 10060, name = GetSpellInfo(10060), icon = select(3, GetSpellInfo(10060)) },
		PowerWordFortitude = { id = 21562, name = GetSpellInfo(21562), icon = select(3, GetSpellInfo(21562)) },
		PainSuppression = { id = 33206, name = GetSpellInfo(33206), icon = select(3, GetSpellInfo(33206)) },
		MindBlast = { id = 8092, name = GetSpellInfo(8092), icon = select(3, GetSpellInfo(8092)) },
		DesperatePrayer = { id = 19236, name = GetSpellInfo(19236), icon = select(3, GetSpellInfo(19236)) },
		ShadowWordPain = { id = 589, name = GetSpellInfo(589), icon = select(3, GetSpellInfo(589)) },
		HolyNova = { id = 15237, name = GetSpellInfo(15237), icon = select(3, GetSpellInfo(15237)) },
		ShadowWordDeath = { id = 32379, name = GetSpellInfo(32379), icon = select(3, GetSpellInfo(32379)) },
		DevouringPlague = { id = 2944, name = GetSpellInfo(2944), icon = select(3, GetSpellInfo(2944)) },
		PrayerofShadowProtection = { id = 27683, name = GetSpellInfo(27683), icon = select(3, GetSpellInfo(27683)) },
		ShadowFiend = { id = 34433, name = GetSpellInfo(34433), icon = select(3, GetSpellInfo(34433)) },
		FearWard = { id = 6346, name = GetSpellInfo(6346), icon = select(3, GetSpellInfo(6346)) },
		Atonement = { id = 81749, name = GetSpellInfo(81749), icon = select(3, GetSpellInfo(81749)) },
		DispelMagic = { id = 527, name = GetSpellInfo(527), icon = select(3, GetSpellInfo(527)) },
		MassDispel = { id = 32375, name = GetSpellInfo(32375), icon = select(3, GetSpellInfo(32375)) },
		DivineHymn = { id = 64843, name = GetSpellInfo(64843), icon = select(3, GetSpellInfo(64843)) },
		CureDisease = { id = 528, name = GetSpellInfo(528), icon = select(3, GetSpellInfo(528)) },


		--more icons
		TankIcon = { icon = select(3, GetSpellInfo(2565)) },
		BossIcon = { icon = select(3, GetSpellInfo(22888)) },
		DebugIcon = { icon = select(3, GetSpellInfo(2382)) },
		MythicalManaPotion = { icon = select(3, GetItemInfo(57192)) },
		PotionOfConcentration = { icon = select(3, GetItemInfo(57194)) },
		StoneIcon = { icon = select(3, GetSpellInfo(6201)) },
	}
	local items = {
		settingsfile = "Dalvae_discopve_cata.json",
		{ type = "title",    text = "Discipline Priest by |c0000CED1Dalvae" },
		{ type = "separator" },
		{ type = "title",    text = "|cffFFFF00Main Settings" },
		{ type = "separator" },
		{ type = "entry",    text = "\124T" .. spells.BossIcon.icon .. ":26:26\124t Boss Detect",                               tooltip = "When ON - Auto detect Bosses, when OFF - use CD buttom for Spells", enabled = true,  key = "detect" },
		{ type = "entry",    text = "\124T" .. spells.FearWard.icon .. ":26:26\124t Fear Ward (Self)",                          tooltip = "Use spell on player",                                               enabled = false, key = "fearward" },
		{ type = "entry",    text = "\124T" .. spells.FearWard.icon .. ":26:26\124t Fear Ward (Focus)",                         tooltip = "Use spell on focus target",                                         enabled = false, key = "fearwardmemb" },
		{ type = "entry",    text = "\124T" .. spells.DebugIcon.icon .. ":26:26\124t Debug Printing",                           tooltip = "Enable for debug if you have problems",                             enabled = false, key = "Debug" },
		{ type = "entry",    text = "\124T" .. spells.Atonement.icon .. ":26:26\124t Atonement Heal",                           tooltip = "It will focus on do DPS and heal",                                  enabled = true,  key = "atonement" },
		{ type = "separator" },
		{ type = "page",     number = 1,                                                                                        text = "|cff00C957Defensive Settings" },
		{ type = "separator" },
		{ type = "entry",    text = "\124T" .. spells.DesperatePrayer.icon .. ":26:26\124t Desperate Prayer",                   tooltip = "Use spell when player HP < %",                                      enabled = true,  value = 25,             key = "despplayer" },
		{ type = "entry",    text = "\124T" .. spells.StoneIcon.icon .. ":26:26\124t Healthstone",                              tooltip = "Use Warlock Healthstone (if you have) when player HP < %",          enabled = true,  value = 35,             key = "healthstoneuse" },
		{ type = "entry",    text = "\124T" .. spells.MythicalManaPotion.icon .. ":26:26\124t Mana Potion",                     tooltip = "Use Mana Potions (if you have) when player mana < %",               enabled = true,  value = 25,             key = "manapotionuse" },
		{ type = "separator" },
		{ type = "page",     number = 2,                                                                                        text = "|cff95f900CD's and important spells" },
		{ type = "separator" },

		{ type = "entry",    text = "\124T" .. spells.PainSuppression.icon .. ":26:26\124t Pain Suppression",                   tooltip = "Use spell when member HP < %",                                      enabled = true,  value = 20,             key = "painsupp" },

		{ type = "entry",    text = "\124T" .. spells.DivineHymn.icon .. ":26:26\124t  Divine Hymn",                            tooltip = "Enable spell",                                                      enabled = true,  key = "innerhymn" },
		{ type = "entry",    text = " Divine Hymn (Members HP)",                                                                tooltip = "Use spell when member HP < %",                                      value = 35,      key = "innerhymnhp" },
		{ type = "entry",    text = " Divine Hymn (Members Count)",                                                             tooltip = "Use spell when member count in Party/Raid have low hp",             value = 9,       key = "innerhymncount" },
		{ type = "separator" },
		{ type = "title",    text = "Dispel" },
		{ type = "separator" },
		{ type = "entry",    text = "\124T" .. spells.DispelMagic.icon .. ":26:26\124t Dispel Magic (Member)",                  tooltip = "Auto dispel debuffs from members",                                  enabled = true,  key = "dispelmagmemb" },
		{ type = "entry",    text = "\124T" .. spells.CureDisease.icon .. ":26:26\124t Cure Disease (Member)",                  tooltip = "Auto dispel debuffs from members",                                  enabled = true,  key = "abolishmb" },
		{ type = "separator" },
		{ type = "page",     number = 3,                                                                                        text = "|cff95f900Healing spells settings" },
		{ type = "separator" },
		{ type = "entry",    text = "Non Combat Healing",                                                                       tooltip = "Heal members after fight when HP < %",                              enabled = true,  value = 95,             key = "noncombatheal" },
		{ type = "entry",    text = "\124T" .. spells.PowerWordShield.icon .. ":26:26\124t Power Word: Shield (Before Combat)", tooltip = "Cast shield on members before combat",                              enabled = false, key = "pwsbeforecombat" },
		{ type = "entry",    text = "\124T" .. spells.BossIcon.icon .. ":26:26\124t Priority Tank",                             tooltip = "Priority Tank healing first",                                       enabled = true,  key = "healtank" },
		{ type = "entry",    text = "\124T" .. spells.Renew.icon .. ":26:26\124t Renew",                                        tooltip = "Use spell when member HP < %.",                                     enabled = true,  value = 90,             key = "renew" },
		{ type = "entry",    text = "\124T" .. spells.Penance.icon .. ":26:26\124t Penance",                                    tooltip = "Use spell when member HP < %",                                      enabled = true,  value = 83,             key = "penance" },
		{ type = "entry",    text = "\124T" .. spells.FlashHeal.icon .. ":26:26\124t Flash Heal",                               tooltip = "Use spell when member HP < %",                                      enabled = true,  value = 79,             key = "flash" },

		{ type = "entry",    text = "\124T" .. spells.PrayerofHealing.icon .. ":26:26\124t Prayer of Healing",                  tooltip = "Use spell when member HP < %",                                      enabled = true,  value = 75,             key = "prayer" },
	};

	local queue = {
		"StopMovingWhileChanneling",
		"Universal Pause",
		"InnerFire",
		"PowerWordFortitude",
		"PrayerofShadowProtection",
		"FearWard",
		"DesperatePrayer",
		"Archangel",
		"Non Combat Healing",
		"Combat specific Pause",
		"Divine Hymn",
		"POMlow",
		"PenanceLow",
		"ShadowFiend",
		"PrayerOfMending",
		"Burst",
		"Tank Heal",
		"Pain Suppression",
		"Power Word: Shield (Agro)",
		"Power Word: Shield (Target/Agro)",
		"Power Word: Shield (Target)",
		"AttonementHolyFire",
		"PenanceAttornament",
		"AttonementHolySmite",
		"PrayerofHealing",
		"FlashHeal",
		"Power Word: Shield (All)",
		"Abolish Disease (Member)",
		"Dispel Magic (Member)",
		"Penancelowpriority",
		"Renew"
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

	SLASH_STOPGASTING1           = "/stopgasting"
	SlashCmdList["STOPGASTING"]  = function()
		delayrotation(2)
	end

	local GroupCount             = function(gtype, starting, ending, threshold)
		local count = 0;
		for i = starting, ending do
			if UnitExists(gtype .. i)
					and ni.unit.hp(gtype .. i) < threshold then
				count = count + 1
			end
		end
		return count;
	end

	local GroupTotal             = function(grouping, index, threshold)
		local count = 0;
		if index > 0 and index <= 5 then
			count = GroupCount(grouping, 1, 5, threshold)
		elseif index > 5 and index <= 10 then
			count = GroupCount(grouping, 6, 10, threshold)
		elseif index > 10 and index <= 15 then
			count = GroupCount(grouping, 11, 15, threshold)
		elseif index > 15 and index <= 20 then
			count = GroupCount(grouping, 16, 20, threshold)
		elseif index > 20 and index <= 25 then
			count = GroupCount(grouping, 21, 25, threshold)
		elseif index > 25 and index <= 30 then
			count = GroupCount(grouping, 26, 30, threshold)
		elseif index > 30 and index <= 35 then
			count = GroupCount(grouping, 31, 35, threshold)
		elseif index > 35 and index <= 40 then
			count = GroupCount(grouping, 36, 40, threshold)
		end
		return count;
	end
	local GetLowPartyMemberCount = function(unit, threshold)
		local count = 0;
		if unit == "player" then
			count = GroupCount("party", 1, 4, threshold)
		else
			local index = string.sub(unit, -1);
			local grouping = string.sub(unit, 0, 4);
			if grouping == "part" then
				grouping = "party"
			elseif grouping == "raid" then
				grouping = "raid"
			end
			if tonumber(index) ~= nil then
				count = GroupTotal(grouping, tonumber(index), threshold)
			else
				for i = 1, #ni.members do
					if ni.members[i].unit == unit then
						index = string.sub(ni.members[i].unit, -1)
						grouping = string.sub(unit, 0, 4);
						if grouping == "part" then
							grouping = "party"
						elseif grouping == "raid" then
							grouping = "raid"
						end
						break
					end
				end
				count = GroupTotal(grouping, tonumber(index), threshold)
			end
		end
		if grouping == "party" or grouping == "player" then
			if ni.player.hp() < threshold then
				count = count + 1
			end
		end
		return count;
	end



	local LastDispel = 0
	local t, p = "target", "player"

	local channelFrame = nil

	local function CreateChannelFrame()
		if not channelFrame then
			channelFrame = CreateFrame("Frame", "ChannelFrame", UIParent)
			channelFrame:SetSize(200, 50)
			channelFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
			channelFrame:SetFrameStrata("HIGH")
			channelFrame:SetFrameLevel(128)
			channelFrame:Hide()

			local text = channelFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
			text:SetText("CHANNELING DONT MOVE!")
			text:SetTextColor(1, 0, 0)
			text:SetPoint("CENTER", channelFrame, "CENTER", 0, 0)
		end
	end

	local function ShowChannelFrame()
		if channelFrame then
			channelFrame:Show()
		end
	end

	local function HideChannelFrame()
		if channelFrame then
			channelFrame:Hide()
		end
	end
	local function OnLoad()
		ni.combatlog.registerhandler("Dalvae Disco", CombatEventCatcher)
		print("Rotation \124cFF15E615Dalvae Disco pve")
		ni.GUI.AddFrame("Dalvae Disco", items)

		CreateChannelFrame()
	end

	local function OnUnload()
		ni.combatlog.unregisterhandler("Dalvae Disco")
		print("Rotation \124cFFE61515stopped!")
		ni.GUI.DestroyFrame("Dalvae Disco")

		if channelFrame then
			channelFrame:Hide()
		end
	end


	local abilities = {
		["StopMovingWhileChanneling"] = function()
			if UnitChannelInfo("player") then
				ni.player.stopmoving()
				ShowChannelFrame()
				return true
			else
				HideChannelFrame()
			end
		end,
		["InnerFire"] = function()
			if not ni.player.buff(spells.InnerFire.id)
			then
				ni.spell.cast(spells.InnerFire.name)
				return true
			end
		end,
		["DesperatePrayer"] = function()
			local value, enabled = GetSetting("despplayer");
			if enabled then
				if UnitAffectingCombat(p)
						and ni.player.hp() < value
				then
					ni.spell.cast(spells.DesperatePrayer.id)
				end
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
		["FearWard"] = function()
			local _, enabled = GetSetting("fearward")
			local _, enabledM = GetSetting("fearwardmemb")
			if enabled
					and not ni.player.buff(spells.FearWard.id)
					and ni.spell.available(spells.FearWard.id) then
				ni.spell.cast(spells.FearWard.id, "player")
				return true
			end
			if enabledM
					and ni.unit.exists("focus")
					and not ni.unit.buff("focus", spells.FearWard.id)
					and ni.spell.available(spells.FearWard.id)
					and ni.spell.valid("focus", spells.FearWard.id, false, true, true) then
				ni.spell.cast(spells.FearWard.id, "focus")
				return true
			end
		end,
		["Non Combat Healing"] = function()
			local value, enabled = GetSetting("noncombatheal");
			if enabled
					and not UnitAffectingCombat("player")
					and ni.spell.available(spells.Renew.id)
					and ni.spell.available(spells.FlashHeal.id) then
				if ni.members[1].hp() < value
						and not ni.unit.buff(ni.members[1].unit, spells.Renew.id, "player")
						and ni.spell.valid(ni.members[1].unit, spells.Renew.id, false, true, true) then
					ni.spell.cast(spells.Renew.id, ni.members[1].unit)
					return true
				end
				if ni.members[1].hp() < value
						and not ni.player.ismoving()
						and ni.spell.valid(ni.members[1].unit, spells.FlashHeal.id, false, true, true) then
					ni.spell.cast(spells.FlashHeal.id, ni.members[1].unit)
					return true
				end
			end
		end,

		["Divine Hymn"] = function()
			local _, enabled = GetSetting("innerhymn");
			local valueHp = GetSetting("innerhymnhp");
			local valueCount = GetSetting("innerhymncount");

			if enabled
					and ni.members.averageof(valueCount, "player", 40) < valueHp
					and ni.members.below(valueHp) >= valueCount
					and not ni.player.ismoving()
					and ni.spell.available(spells.DivineHymn.id)
					and UnitChannelInfo("player") == nil
			then
				ni.player.stopmoving()
				ni.spell.cast(spells.DivineHymn.id)
				return true
			end
		end,
		["Burst"] = function()
			if ni.vars.combat.cd or
					ni.unit.isboss(t) then
				if ni.spell.cd(spells.PowerInfusion.id) == 0 then
					ni.spell.cast(spells.PowerInfusion.name)
					return true
				end
			end
		end,
		["PenanceAttornament"] = function()
			local _, enabled = GetSetting("atonement")
			if enabled
					and not ni.player.ismoving()
					and ni.spell.cd(spells.Penance.id) == 0
					and ni.spell.valid(t, spells.Penance.id, false, true, false)
					and LosCastStand(spells.Penance.name, t)
			then
				return true
			end
		end,

		["AttonementHolyFire"] = function()
			local _, enabled = GetSetting("atonement")
			if enabled
					and not ni.player.ismoving()
					and ni.spell.cd(spells.HolyFire.id) == 0
					and ni.player.los(t)
					and LosCast(spells.HolyFire.name, t)
			then
				return true
			end
		end,
		["AttonementHolySmite"] = function()
			local _, enabled = GetSetting("atonement")
			if enabled
					and not ni.player.ismoving()
					and ni.player.los(t)
					and LosCast(spells.Smite.name, t)
			then
				return true
			end
		end,


		["POMlow"] = function()
			if ni.spell.cd(spells.PrayerOfMending.id) == 0 then
				for i = 1, #ni.members do
					if ni.members[i]:hp() <= 40 and ni.player.los(ni.members[i].unit)
							and
							ValidUsable(spells.PrayerOfMending.id, ni.members[i].unit)
							and ni.spell.valid(33076, ni.members[i].unit, false, true, true)
					then
						ni.spell.cast(spells.PrayerOfMending.id, ni.members[i].unit)
						return true
					end
				end
			end
		end,
		["Universal Pause"] = function()
			if UnitInVehicle("player")
					or UnitIsDeadOrGhost("target")
					or UnitIsDeadOrGhost("player")
					or UnitChannelInfo("player") ~= nil
					or ni.unit.ischanneling("player")
					or UnitCastingInfo("player") ~= nil
					or ni.vars.combat.casting == true
					or ni.player.islooting()
			then
				return false
			end
		end,
		["Combat specific Pause"] = function()
			if UnitAffectingCombat("player") then
				return false
			end
			for i = 1, #ni.members do
				if UnitAffectingCombat(ni.members[i].unit) then
					return false
				end
			end
			return true
		end,

		["Tank Heal"] = function()
			local tank, offTank = ni.tanks()
			-- Main Tank Heal
			if ni.unit.exists(tank) then
				local rnewtank, _, _, _, _, _, rnewtank_time = ni.unit.buff(tank, spells.Renew.id, "player")
				local pwstank, _, _, _, _, _, pwstank_time = ni.unit.buff(tank, spells.PowerWordShield.id, "player")
				local ws = ni.unit.debuff(tank, 6788)
				-- Heal MT with Renew
				if ni.spell.available(spells.Renew.id)
						and (not rnewtank
							or (rnewtank and rnewtank_time - GetTime() < 2))
						and ni.spell.valid(tank, spells.Renew.id, false, true, true) then
					ni.spell.cast(spells.Renew.id, tank)
					return true
				end
				-- Put PW:S on MT
				if ni.spell.available(spells.PowerWordShield.id)
						and not ws
						and (not pwstank
							or (pwstank and pwstank_time - GetTime() < 0.7))
						and ni.spell.valid(tank, spells.PowerWordShield.id, false, true, true) then
					ni.spell.cast(spells.PowerWordShield.id, tank)
					return true
				end
			end
			-- Off Tank heal
			if offTank ~= nil
					and ni.unit.exists(offTank) then
				local rnewotank, _, _, _, _, _, rnewotank_time = ni.unit.buff(offTank, spells.Renew.id, "player")
				local pwotank, _, _, _, _, _, pwotank_time = ni.unit.buff(offTank, spells.PowerWordShield.id, "player")
				local ws = ni.unit.debuff(offTank, 6788)
				-- Heal OT with Renew
				if ni.spell.available(spells.Renew.id)
						and (not rnewotank
							or (rnewotank and rnewotank_time - GetTime() < 2))
						and ni.spell.valid(offTank, spells.Renew.id, false, true, true) then
					ni.spell.cast(spells.Renew.id, offTank)
					return true
				end
				-- Put PW:S on OT
				if ni.spell.available(spells.PowerWordShield.id)
						and not ws
						and (not pwotank
							or (pwotank and pwotank_time - GetTime() < 0.7))
						and ni.spell.valid(offTank, spells.PowerWordShield.id, false, true, true) then
					ni.spell.cast(spells.PowerWordShield.id, offTank)
					return true
				end
			end
		end,
		["Power Word: Shield (Target/Agro)"] = function()
			if ni.spell.available(spells.PowerWordShield.id) then
				for i = 1, #ni.members do
					if ni.members[i].range
							and not UnitIsDeadOrGhost(ni.members[i].unit) then
						local tarCount = #ni.unit.unitstargeting(ni.members[i].guid)
						local pws, _, _, _, _, _, pwsTime = ni.unit.buff(ni.members[i].unit, 48066, "player")
						local ws = ni.unit.debuff(ni.members[i].unit, 6788)
						if tarCount ~= nil
								and tarCount >= 1
								and not ws
								and not (pws
									or (pws and pwsTime - GetTime() < 0.7))
								and ni.unit.threat(ni.members[i].guid) >= 2
								and ni.spell.valid(ni.members[i].unit, spells.PowerWordShield.id, false, true, true) then
							ni.spell.cast(spells.PowerWordShield.id, ni.members[i].unit)
							return true
						end
					end
				end
			end
		end,
		-----------------------------------
		["Power Word: Shield (Target)"] = function()
			if ni.spell.available(spells.PowerWordShield.id) then
				for i = 1, #ni.members do
					if ni.members[i].range
							and not UnitIsDeadOrGhost(ni.members[i].unit) then
						local tarCount = #ni.unit.unitstargeting(ni.members[i].guid)
						local pws, _, _, _, _, _, pwsTime = ni.unit.buff(ni.members[i].unit, spells.PowerWordShield.id, "player")
						local ws = ni.unit.debuff(ni.members[i].unit, 6788)
						if tarCount ~= nil
								and tarCount >= 1
								and not ws
								and not (pws
									or (pws and pwsTime - GetTime() < 0.7))
								and ni.spell.valid(ni.members[i].unit, spells.PowerWordShield.id, false, true, true) then
							ni.spell.cast(spells.PowerWordShield.id, ni.members[i].unit)
							return true
						end
					end
				end
			end
		end,
		-----------------------------------
		["Power Word: Shield (Agro)"] = function()
			if ni.spell.available(spells.PowerWordShield.id) then
				for i = 1, #ni.members do
					if ni.members[i].range
							and not UnitIsDeadOrGhost(ni.members[i].unit) then
						local pws, _, _, _, _, _, pwsTime = ni.unit.buff(ni.members[i].unit, spells.PowerWordShield.id, "player")
						local ws = ni.unit.debuff(ni.members[i].unit, 6788)
						if not ws
								and not (pws
									or (pws and pwsTime - GetTime() < 0.7))
								and ni.unit.threat(ni.members[i].guid) >= 2
								and ni.spell.valid(ni.members[i].unit, spells.PowerWordShield.id, false, true, true) then
							ni.spell.cast(spells.PowerWordShield.id, ni.members[i].unit)
							return true
						end
					end
				end
			end
		end,
		["FlashHeal"] = function()
			local value, enabled = GetSetting("flash");
			if enabled
					and ni.spell.available(spells.FlashHeal.id)
					and not ni.player.ismoving()
					and ni.members[1].hp() < value
					and ni.spell.valid(ni.members[1].unit, spells.FlashHeal.id, false, true, true) then
				ni.spell.cast(spells.FlashHeal.id, ni.members[1].unit)
				return true
			end
		end,
		["PenanceLow"] = function()
			local value, enabled = GetSetting("penance");
			if enabled
					and not ni.player.ismoving()
					and ni.spell.available(spells.Penance.id) then
				for i = 1, #ni.members do
					if ni.members[i].range then
						local tarCount = #ni.unit.unitstargeting(ni.members[i].guid)
						if (ni.members[i].hp() < value
									or (tarCount ~= nil and tarCount >= 1))
								and ni.spell.valid(ni.members[i].unit, spells.Penance.id, false, true, true)
						then
							ni.player.stopmoving()
							ni.spell.cast(spells.Penance.id, ni.members[i].unit)
							return true
						end
					end
				end
			end
		end,

		["Penancelowpriority"] = function()
			if not ni.player.ismoving()
					and ni.spell.cd(spells.Penance.id) == 0 then
				for i = 1, #ni.members do
					if ni.members[i].hp() <= 80 and
							ValidUsable(spells.Penance.id, ni.members[i].unit) and
							LosCastStand(spells.Penance.name, ni.members[i].unit)
					then
						return true
					end
				end
			end
		end,
		["Power Word: Shield (All)"] = function()
			if ni.spell.available(spells.PowerWordShield.name) then
				for i = 1, #ni.members do
					if ni.members[i].range
							and not UnitIsDeadOrGhost(ni.members[i].unit) then
						local pws, _, _, _, _, _, pwsTime = ni.unit.buff(ni.members[i].unit, spells.PowerWordShield.name, "player")
						local ws = ni.unit.debuff(ni.members[i].unit, 6788)
						if ni.members[i].hp() < 95
								and not ws
								and not (pws
									or (pws and pwsTime - GetTime() < 0.7))
								and ni.spell.valid(ni.members[i].unit, spells.PowerWordShield.name, false, true, true) then
							ni.spell.cast(spells.PowerWordShield.name, ni.members[i].unit)
							return true
						end
					end
				end
			end
		end,

		["PrayerOfMending"] = function()
			if ni.spell.cd(spells.PrayerOfMending.id) == 0
			then
				local renewActive = false
				for i = 1, #ni.members.inrange("player", 40) do
					if ni.unit.buff(ni.members[i].unit, spells.PrayerOfMending.id, "player") then
						renewActive = true
						break
					end
				end
				if not renewActive then
					for i = 1, #ni.members.inrange("player", 40) do
						if ni.members[i].hp() < 99
								and not ni.unit.buff(ni.members[i].unit, spells.PrayerOfMending.id, "player")
								and ni.spell.valid(ni.members[i].unit, spells.PrayerOfMending.id, false, true, true) then
							ni.spell.cast(spells.PrayerOfMending.id, ni.members[i].unit)
							return true
						end
					end
				end
			end
		end,

		["PrayerofHealing"] = function()
			local value, enabled = GetSetting("prayer");
			if enabled
					and ni.spell.available(spells.PrayerofHealing.id)
					and not ni.player.ismoving() then
				-- Heal party with Prayer
				if ni.members[1].hp() < value
						and GetLowPartyMemberCount(ni.members[1].unit, value) >= 2
						and ni.spell.valid(ni.members[1].unit, spells.PrayerofHealing.id, false, true, true) then
					ni.spell.cast(spells.PrayerofHealing.id, ni.members[1].unit)
					return true
				end
				-- Heal raid with Prayer
				if ni.members[1].hp() < value
						and #ni.members > 5
						and GetLowPartyMemberCount(ni.members[1].unit, value) >= 3
						and ni.spell.valid(ni.members[1].unit, spells.PrayerofHealing.id, false, true, true) then
					ni.spell.cast(spells.PrayerofHealing.id, ni.members[1].unit)
					return true
				end
			end
		end,
		["Abolish Disease (Member)"] = function()
			local _, enabled = GetSetting("abolishmb")
			if enabled
					and ni.spell.available(spells.CureDisease) then
				for i = 1, #ni.members do
					if ni.unit.debufftype(ni.members[i].unit, "Disease")
							and ni.healing.candispel(ni.members[i].unit)
							and GetTime() - LastDispel > 1.2
							and not ni.unit.buff(ni.members[i].unit, spells.CureDisease)
							and ni.spell.valid(ni.members[i].unit, spells.CureDisease, false, true, true) then
						ni.spell.cast(spells.CureDisease, ni.members[i].unit)
						LastDispel = GetTime()
						return true
					end
				end
			end
		end,
		-----------------------------------
		["Dispel Magic (Member)"] = function()
			local _, enabled = GetSetting("dispelmagmemb")
			if enabled
					and ni.spell.available(spells.DispelMagic.id) then
				for i = 1, #ni.members do
					if ni.unit.debufftype(ni.members[i].unit, "Magic")
							and ni.healing.candispel(ni.members[i].unit)
							and GetTime() - LastDispel > 1.2
							and ni.spell.valid(ni.members[i].unit, spells.DispelMagic.id, false, true, true) then
						ni.spell.cast(spells.DispelMagic.id, ni.members[i].unit)
						LastDispel = GetTime()
						return true
					end
				end
			end
		end,

		["Pain Suppression"] = function()
			local value, enabled = GetSetting("painsupp");
			if enabled
					and ni.spell.available(spells.PainSuppression.id)
					and ni.members[1].hp() < value
					and ni.spell.valid(ni.members[1].unit, spells.PainSuppression.id, false, true, true) then
				ni.spell.cast(spells.PainSuppression.id, ni.members[1].unit)
				return true
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
			if ni.player.power() < 37
					and ni.spell.cd(spells.ShadowFiend.id) == 0
					and ni.player.los("target")
			then
				ni.spell.cast(spells.ShadowFiend.id, "target")
				return true
			end
		end,

		["Renew"] = function()
			local value, enabled = GetSetting("renew");
			if enabled
					and ni.spell.available(spells.Renew.id) then
				for i = 1, #ni.members do
					if ni.members[i].hp() < value
							and not ni.unit.buff(ni.members[i].unit, spells.Renew.id, "player")
							and ni.spell.valid(ni.members[i].unit, spells.Renew.id, false, true, true) then
						ni.spell.cast(spells.Renew.id, ni.members[i].unit)
						return true
					end
				end
			end
		end,
	}


	ni.bootstrap.profile("Dalvae_discopve_cata", queue, abilities, OnLoad, OnUnload)
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
	ni.bootstrap.profile("Dalvae_discopve_cata", queue, abilities);
end
;
