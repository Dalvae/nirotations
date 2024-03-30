local data = ni.utils.require("DarhangeR");
local popup_shown = false;
local enemies = { };
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
local factionseal = 53736
if UnitFactionGroup("player") == "Alliance" then
  factionseal = 31801
end
local items = {
	settingsfile = "DarhangeR_Retri.xml",
	{ type = "title", text = "Retribution Paladin by |c0000CED1DarhangeR" },
	{ type = "separator" },
	{ type = "title", text = "|cffFFFF00Main Settings" },
	{ type = "separator" },	
	{ type = "entry", text = "\124T"..data.bossIcon()..":26:26\124t Boss Detect", tooltip = "When ON - Auto detect Bosses, when OFF - use CD bottom for Spells", enabled = true, key = "detect" },	
	{ type = "entry", text = "\124T"..data.paladin.pleaIcon()..":26:26\124t Divine Plea", tooltip = "Use spell when player mana < %", enabled = true, value = 60, key = "plea" },
	{ type = "entry", text = "\124T"..data.paladin.sacredIcon()..":26:26\124t Sacred Shield", tooltip = "Enable/Disable spell for cast on player", enabled = true, key = "sacred" },
	{ type = "entry", text = "\124T"..data.debugIcon()..":26:26\124t Debug Printing", tooltip = "Enable for debug if you have problems", enabled = false, key = "Debug" },	
	{ type = "separator" },
	{ type = "page", number = 1, text = "|cff00C957Defensive Settings" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..data.paladin.flashIcon()..":26:26\124t Flash of Light (Self)", tooltip = "Use spell when player HP < %", enabled = true, value = 90, key = "flashoflight" },
	{ type = "entry", text = "\124T"..data.paladin.layIcon()..":26:26\124t Lay on Hands (Self)", tooltip = "Use spell when player HP < %", enabled = true, value = 25, key = "layon" },
	{ type = "entry", text = "\124T"..data.paladin.divineShIcon()..":26:26\124t Divine Shield", tooltip = "Use spell when player HP < %", enabled = true, value = 12, key = "divineshield" },
	{ type = "entry", text = "\124T"..data.paladin.divinePrIcon()..":26:26\124t Divine Protection", tooltip = "Use spell when player HP < %", enabled = true, value = 30, key = "divineprot" },
	{ type = "entry", text = "\124T"..data.paladin.handProIcon()..":26:26\124t Hand of Protection (Member)", tooltip = "Use spell when member HP < %. Work only on caster clases", enabled = true, value = 25, key = "handofprot" },
	{ type = "entry", text = "\124T"..data.paladin.handSalIcon()..":26:26\124t Hand of Salvation (Member)", tooltip = "Auto check member agro and use spell", enabled = true, key = "salva" },
	{ type = "entry", text = "\124T"..data.stoneIcon()..":26:26\124t Healthstone", tooltip = "Use Warlock Healthstone (if you have) when player HP < %", enabled = true, value = 35, key = "healthstoneuse" },
	{ type = "entry", text = "\124T"..data.hpotionIcon()..":26:26\124t Heal Potion", tooltip = "Use Heal Potions (if you have) when player HP < %",  enabled = true, value = 30, key = "healpotionuse" },
	{ type = "entry", text = "\124T"..data.mpotionIcon()..":26:26\124t Mana Potion", tooltip = "Use Mana Potions (if you have) when player mana < %", enabled = true, value = 25, key = "manapotionuse" },
	{ type = "separator" },
	{ type = "page", number = 2, text = "|cffEE4000Rotation Settings" },
	{ type = "separator" },
	{ type = "title", text = "Active Seals" },
    { type = "dropdown", menu = {
        { selected = true, value = factionseal, text = "\124T"..data.paladin.SoCRIcon()..":20:20\124t Seal of Corruption/Vengeance" },
        { selected = false, value = 20375, text = "\124T"..data.paladin.SoCIcon()..":20:20\124t Seal of Command" },
        { selected = false, value = 21084, text = "\124T"..data.paladin.SoRIcon()..":20:20\124t Seal of Righteousness" },
        { selected = false, value = 20166, text = "\124T"..data.paladin.SoWIcon()..":20:20\124t Seal of Wisdom" },
        { selected = false, value = 20164, text = "\124T"..data.paladin.SoJIcon()..":20:20\124t Seal of Justice" },	
    }, key = "CurentSeal" },
	{ type = "separator" },	
	{ type = "entry", text = "AoE (Auto)", tooltip = "When enabled auto detect enemies and use proper seals. Also auto cast Main seal from dropdown menu", enabled = true, key = "AoE" },
	{ type = "entry", text = "\124T"..data.paladin.hamWraIcon()..":26:26\124t Hammer of Wrath", tooltip = "Auto check ''execute'' target in this spell range and use it.", enabled = false, key = "masswrath" },			
	{ type = "entry", text = "\124T"..data.paladin.consIcon()..":26:26\124t Consecration", tooltip = "Enable/Disable spell for using in rotation", enabled = true, key = "concentrat" },
	{ type = "entry", text = "Mana threshold for use", tooltip = "Use Consecration spell when player mana > %", value = 30, key = "concentratmana" },
	{ type = "entry", text = "\124T"..data.paladin.hwrathIcon()..":26:26\124t Holy Wrath (Auto Use)", tooltip = "Auto check and use spell on proper enemies", enabled = false, key = "holywrath" },
	{ type = "entry", text = "\124T"..data.paladin.turnIcon()..":26:26\124t Turn Evil (Auto Use)", tooltip = "Auto check and use spell on proper enemies", enabled = false, key = "turn" },	
	{ type = "entry", text = "\124T"..data.controlIcon()..":26:26\124t Auto Control (Member)", tooltip = "Auto check and control member if he mindcontrolled or etc.", enabled = true, key = "control" },
	{ type = "separator" },
	{ type = "title", text = "Dispel" },
	{ type = "separator" },
	{ type = "entry", text = "\124T"..data.paladin.cleanIcon()..":26:26\124t Cleanse (Self)", tooltip = "Auto dispel debuffs from player", enabled = true, key = "cleans" },
	{ type = "entry", text = "\124T"..data.paladin.cleanIcon()..":26:26\124t Cleanse (Member)", tooltip = "Auto dispel debuffs from members", enabled = false, key = "cleansmemb" },
	{ type = "entry", text = "\124T"..data.paladin.handFreeIcon()..":26:26\124t Hand of Freedom (Self)", tooltip = "Auto cast on player when you have criteria for spell", enabled = true, key = "freedom" },
	{ type = "entry", text = "\124T"..data.paladin.handFreeIcon()..":26:26\124t Hand of Freedom (Member)", tooltip = "Auto cast on member when he have criteria for spell", enabled = false, key = "freedommemb" },
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
local function OnLoad()
	ni.GUI.AddFrame("Retri_DarhangeR", items);
end
local function OnUnLoad()  
	ni.GUI.DestroyFrame("Retri_DarhangeR");
end

local queue = {
	
	"Universal pause",
	"AutoTarget",
	"Main Seal",
	"Seal of Command",
	"Cancel Righteous Fury",
	"Auto Track Undeads",	
	"Combat specific Pause",
	"Healthstone (Use)",
	"Heal Potions (Use)",
	"Mana Potions (Use)",
	"Racial Stuff",
	"Use enginer gloves",
	"Trinkets",
	"Lay on Hands (Self)",
	"Divine Shield",
	"Divine Protection",
	"Flash of Light (Self)",
	"Hand of Protection (Member)",
	"Hand of Salvation (Member)",
	"Hand of Freedom (Member)",
	"Hand of Freedom (Self)",
	"Divine Plea",
	"Sacred Shield",
	"Avenging Wrath",
	"Turn Evil (Auto Use)",
	"Control (Member)",
	"Hammer of Wrath",
	"Hammer of Wrath (Auto Target)",	
	"Judgement of Wisdom",
	"Holy Wrath (Auto Use)",	
	"Divine Storm",
	"Crusader Strike",
	"Cleanse (Member)",	
	"Cleanse (Self)",
	"Consecration",
	"Exorcism",
}
local abilities = {
-----------------------------------
	["Universal pause"] = function()
		if data.UniPause() then
			return true
		end
		ni.vars.debug = select(2, GetSetting("Debug"));
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
	["Auto Track Undeads"] = function()
		if ni.player.hasglyph(57947) then
		 if not UnitAffectingCombat("player") 
		  and GetTime() - data.paladin.LastTrack > 8 then
				SetTracking(nil);	
		 end
			-- Undead --				
		 if UnitAffectingCombat("player")
		  and ni.unit.exists("target")
		  and ni.unit.creaturetype("target") == 6
		  and ni.spell.available(5502) 
		  and GetTime() - data.paladin.LastTrack > 8 then 
				data.paladin.LastTrack = GetTime()		  
				ni.spell.cast(5502)
			end				
		end
	end,
-----------------------------------
	["Main Seal"] = function()
		local _, enabled = GetSetting("AoE")
		local seal = GetSetting("CurentSeal");
		if (ni.vars.combat.aoe == false
		 or (enabled and ActiveEnemies() < 2))
		 and IsSpellKnown(seal)
		 and ni.spell.available(seal) then
		 if not ni.player.buff(seal)
		 and GetTime() - data.paladin.LastSeal > 3 then
			ni.spell.cast(seal)
			data.paladin.LastSeal = GetTime()
			return true
			end
		end
	end,
-----------------------------------
	["Seal of Command"] = function()
		local _, enabled = GetSetting("AoE")
		if (ni.vars.combat.aoe 
		 or (enabled and ActiveEnemies() > 1))
		 and IsSpellKnown(20375)
		 and ni.spell.available(20375)
		 and GetTime() - data.paladin.LastSeal > 3
		 and not ni.player.buff(20375) then 
			ni.spell.cast(20375)
			data.paladin.LastSeal = GetTime()
			return true
		end
	end,
-----------------------------------
	["Cancel Righteous Fury"] = function()
		local p = "player" for i = 1,40 
		do local _,_,_,_,_,_,_,u,_,_,s = UnitBuff(p,i)
			if u == p and s == 25780 then
				CancelUnitBuff(p, i) 
				break;
			end
		end 
	end,
-----------------------------------
	["Combat specific Pause"] = function()
		if data.meleeStop("target")
		 or data.PlayerDebuffs("player")
		 or UnitCanAttack("player","target") == nil
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
	["Mana Potions (Use)"] = function()
		local value, enabled = GetSetting("manapotionuse");
		local mpot = { 33448, 43570, 40087, 42545, 39671 }
		for i = 1, #mpot do
			if enabled
			 and ni.player.power() < value
			 and ni.player.hasitem(mpot[i])
			 and ni.player.itemcd(mpot[i]) == 0 then
				ni.player.useitem(mpot[i])
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
		 and data.paladin.RetriRange() then 
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
		 and data.paladin.RetriRange() then 
					ni.spell.cast(bloodelf[i])
					return true
			end
		end
		--- Ally race
		for i = 1, #alracial do
		if data.paladin.RetriRange()
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
		 and ni.player.slotcd(10) == 0 
		 and data.CDorBoss("target", 5, 35, 5, enabled)
		 and data.paladin.RetriRange() then
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
		 and data.paladin.RetriRange() then
			ni.player.useinventoryitem(13)
		else
		 if data.CDorBoss("target", 5, 35, 5, enabled)
		 and ni.player.slotcastable(14)
		 and ni.player.slotcd(14) == 0 
		 and data.paladin.RetriRange() then
			ni.player.useinventoryitem(14)
			return true
			end
		end
	end,
-----------------------------------
	["Lay on Hands (Self)"] = function()
		local value, enabled = GetSetting("layon");
		local forb = data.paladin.forb()
		if enabled
		 and ni.player.hp() < value
		 and not forb
		 and ni.spell.available(48788) then
			ni.spell.cast(48788)
			return true
		end
	end,
-----------------------------------
	["Divine Shield"] = function()
		local value, enabled = GetSetting("divineshield");
		local forb = data.paladin.forb()
		if enabled
		 and ni.player.hp() < value
		 and not forb
		 and ni.spell.available(642) then
			ni.spell.cast(642)
			return true
		end
	end,
-----------------------------------
	["Divine Protection"] = function()
		local value, enabled = GetSetting("divineprot");
		local forb = data.paladin.forb()
		if enabled
		 and ni.player.hp() < value
		 and not forb
		 and ni.spell.available(498)
		 and not ni.player.buff(498)  then
			ni.spell.cast(498)
			return true
		end
	end,
-----------------------------------
	["Flash of Light (Self)"] = function()
		local value, enabled = GetSetting("flashoflight");
		local aow = data.paladin.aow()
		if enabled
		 and ni.player.hp() < value
		 and aow
		 and ni.spell.isinstant(48785)
		 and not ni.spell.available(48801)
		 and ni.spell.available(48785) then
			ni.spell.cast(48785, "player")
			return true
		end
	end,
-----------------------------------
	["Hand of Salvation (Member)"] = function()
		local _, enabled = GetSetting("salva")
		if enabled
		 and #ni.members > 1		 
		 and ni.spell.available(1038)
		 and data.CombatStart(10) then
		  if ni.members[1].threat >= 2
		   and not ni.members[1].istank
		   and not data.paladin.HandActive(ni.members[1].unit)		    
		   and ni.spell.valid(ni.members[1].unit, 1038, false, true, true) then 
				ni.spell.cast(1038, ni.members[1].unit)
				return true
			end
		end
	end,
-----------------------------------
	["Hand of Protection (Member)"] = function()
		local value, enabled = GetSetting("handofprot");
		if enabled
		 and #ni.members > 1		 
		 and ni.spell.available(10278) then
		  if ni.members[1].range
		  and ni.members[1].hp < value
		  and not ni.members[1].istank
		  and ni.members[1].threat >= 2
		  and ni.members[1].class ~= "DEATHKNIGHT"
		  and not (ni.members[1].class == "DRUID"
		  and ni.unit.buff(ni.members[1].unit, 768))
		  and ni.members[1].class ~= "HUNTER"
		  and ni.members[1].class ~= "PALADIN"
		  and ni.members[1].class ~= "ROGUE"
		  and ni.members[1].class ~= "WARRIOR"
		  and not data.paladin.HandActive(ni.members[1].unit)
		  and not ni.unit.debuff(ni.members[1].unit, 25771)
		  and ni.spell.valid(ni.members[1].unit, 10278, false, true, true) then 
				ni.spell.cast(10278, ni.members[1].unit)
				return true
			end
		end
	end,
-----------------------------------
	["Divine Plea"] = function()
		local value, enabled = GetSetting("plea");
		if enabled 
		 and ni.player.power() < value
		 and not ni.player.buff(54428)		 
		 and ni.spell.available(54428) then
			ni.spell.cast(54428)
			return true
		end
	end,
-----------------------------------
	["Sacred Shield"] = function()
		local _, enabled = GetSetting("sacred")
		if enabled
		 and not ni.player.buff(53601)  
		 and ni.spell.available(53601) then
			ni.spell.cast(53601, "player")
			return true
		end
	end,
-----------------------------------
	["Avenging Wrath"] = function()
		local _, enabled = GetSetting("detect")
		if data.CDorBoss("target", 5, 35, 5, enabled)
		 and ni.spell.available(31884)
		 and GetTime() - data.paladin.LastAven > 30.5
		 and data.paladin.RetriRange() then
			ni.spell.cast(31884)
			data.paladin.LastAven = GetTime()
			return true
		end
	end,
-----------------------------------
	["Judgement of Wisdom"] = function()
		if ni.spell.available(53408)
		 and ni.spell.valid("target", 53408, false, true, true) then
			ni.spell.cast(53408, "target")
			return true
		end
	end,
-----------------------------------
	["Divine Storm"] = function()
		if ni.spell.available(53385)
		 and GetTime() - data.paladin.LastStorm > 1.6 
		 and data.paladin.RetriRange() then
			ni.spell.cast(53385, "target")
			data.paladin.LastStorm = GetTime()
			return true
		end
	end,
-----------------------------------
	["Crusader Strike"] = function()
		if ni.spell.available(35395)
		 and ni.spell.valid("target", 35395, true, true) then
			ni.spell.cast(35395, "target")
			return true
		end
	end,
-----------------------------------
	["Holy Wrath (Auto Use)"] = function()
		local _, enabled = GetSetting("holywrath")
		if enabled
		 and ni.spell.available(48817)
		 and (ni.unit.creaturetype("target") == 3
		 or ni.unit.creaturetype("target") == 6)
		 and ni.player.distance("target") < 5 then
			ni.spell.cast(48817)
			return true
		end
	end,
-----------------------------------
	["Consecration"] = function()
		local _, enabled = GetSetting("concentrat")
		local value = GetSetting("concentratmana") 
		if enabled
		 and ni.player.power() > value
		 and ni.spell.available(48819)
		 and data.paladin.RetriRange() then
			ni.spell.cast(48819)
			return true
		end
	end,
-----------------------------------
	["Exorcism"] = function()
		local aow = data.paladin.aow()
		if aow
		 and ni.spell.isinstant(48801)
		 and ni.spell.available(48801)
		 and ni.spell.valid("target", 48801, true, true) then
			ni.spell.cast(48801, "target")
			return true
		end
	end,
-----------------------------------
	["Hammer of Wrath"] = function()
		if (ni.unit.hp("target") <= 20
		 or IsUsableSpell(GetSpellInfo(48806)))
		 and ni.spell.available(48806)
		 and ni.spell.valid("target", 48806, true, true) then
			ni.spell.cast(48806, "target")
			return true
		end
	end,
-----------------------------------
	["Hammer of Wrath (Auto Target)"] = function()
		local _, enabled = GetSetting("masswrath")
		if enabled
		 and ni.spell.available(48806)
		 and UnitCanAttack("player", "target") then
		 table.wipe(enemies);
		  enemies = ni.unit.enemiesinrange("player", 29)
		  for i = 1, #enemies do
		   local executetar = enemies[i].guid;
		    if ni.unit.hp(executetar) < 20
			and ni.spell.valid(executetar, 48806, true, true) then
					ni.spell.cast(48806, executetar)
					return true
				end
			end					
		end
	end,
-----------------------------------	
	["Hand of Freedom (Self)"] = function()
		local _, enabled = GetSetting("freedom")
		if enabled
		 and ni.player.ismoving()
		 and data.paladin.FreedomUse("player")
		 and not data.paladin.HandActive("player")
		 and ni.spell.available(1044) then
			ni.spell.cast(1044, "player")
			return true
		end
	end,
-----------------------------------
	["Hand of Freedom (Member)"] = function()
		local _, enabled = GetSetting("freedommemb")
		if enabled
		 and ni.spell.available(1044) then
		  for i = 1, #ni.members do
		   local ally = ni.members[i].unit
		    if ni.unit.ismoving(ally)
		     and data.paladin.FreedomUse(ally)
		     and not data.paladin.HandActive(ally)
		     and ni.spell.valid(ally, 1044, false, true, true) then
					ni.spell.cast(1044, ally)
					return true
				end
            end
		end
	end,
-----------------------------------
	["Cleanse (Self)"] = function()
		local _, enabled = GetSetting("cleans")
		if enabled
		 and ni.player.debufftype("Magic|Disease|Poison")
		 and ni.spell.available(4987)
		 and ni.healing.candispel("player")
		 and GetTime() - data.LastDispel > 1.5
		 and ni.spell.valid("player", 4987, false, true, true) then
			ni.spell.cast(4987, "player")
			data.LastDispel = GetTime()
			return true
		end
	end,
-----------------------------------
	["Cleanse (Member)"] = function()
		local _, enabled = GetSetting("cleansmemb")
		if enabled	
		 and ni.spell.available(4987) then
		  for i = 1, #ni.members do
		  if ni.unit.debufftype(ni.members[i].unit, "Magic|Disease|Poison")
		  and ni.healing.candispel(ni.members[i].unit)
		  and GetTime() - data.LastDispel > 1.2
		  and ni.spell.valid(ni.members[i].unit, 4987, false, true, true) then
				ni.spell.cast(4987, ni.members[i].unit)
				data.LastDispel = GetTime()
				return true
				end
			end
		end
	end,
-----------------------------------
	["Turn Evil (Auto Use)"] = function()        
		local _, enabled = GetSetting("turn")
		if enabled 
		 and ni.unit.exists("target")
		 and ni.spell.available(10326)
		 and UnitCanAttack("player", "target") then
		 table.wipe(enemies);
		  enemies = ni.unit.enemiesinrange("player", 25)
		  local dontTurn = false
		  for i = 1, #enemies do
		   local tar = enemies[i].guid; 
		   if (ni.unit.creaturetype(enemies[i].guid) == 3
		    or ni.unit.creaturetype(enemies[i].guid) == 6
		    or ni.unit.aura(enemies[i].guid, 49039))
		    and ni.unit.debuff(tar, 10326, "player") then
			dontTurn = true
			break
		end
        end
		if not dontTurn then
		 for i = 1, #enemies do
		 local tar = enemies[i].guid; 
		  if (ni.unit.creaturetype(enemies[i].guid) == 3
		   or ni.unit.creaturetype(enemies[i].guid) == 6
		   or ni.unit.aura(enemies[i].guid, 49039))
		   and not ni.unit.isboss(tar)
		   and not ni.unit.debuffs(tar, "23920||35399||69056", "EXACT")
		   and not ni.unit.debuff(tar, 10326, "player")
		   and ni.spell.valid(enemies[i].guid, 10326, false, true, true)
		   and GetTime() - data.paladin.LastTurn > 1.5 then
				ni.spell.cast(10326, tar)
				data.paladin.LastTurn = GetTime()
                        return true
					end
				end
			end
		end
	end,
-----------------------------------
	["Control (Member)"] = function()
		local _, enabled = GetSetting("control")
		if enabled
		 and ni.spell.available(20066) then
		  for i = 1, #ni.members do
		   local ally = ni.members[i].unit
		    if data.ControlMember(ally)
			and not data.UnderControlMember(ally)
			and ni.spell.valid(ally, 20066, false, true, true) then
				ni.spell.cast(20066, ally)
				return true
				end
			end
		end
		if not ni.spell.available(20066)
		 and ni.spell.available(10308) then 
		  for i = 1, #ni.members do
		   local ally = ni.members[i].unit
		    if data.ControlMember(ally)
			and not data.UnderControlMember(ally)
			and ni.spell.valid(ally, 10308, false, true, true) then
				ni.spell.cast(10308, ally)
				return true
				end
			end
		end		
	end,
-----------------------------------
	["Window"] = function()
		if not popup_shown then
		 ni.debug.popup("Retribution Paladin by DarhangeR for 3.3.5a", 
		 "Welcome to Retribution Paladin Profile! Support and more in Discord > https://discord.gg/TEQEJYS.\n\n--Profile Function--\n-Watch profile GUI.")
		popup_shown = true;
		end 
	end,
}

	ni.bootstrap.profile("Retri_DarhangeR", queue, abilities, OnLoad, OnUnLoad);
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
    ni.bootstrap.profile("Retri_DarhangeR", queue, abilities);
end