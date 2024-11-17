local items = {
	settingsfile = "navbot.json",
	{ type = "title",    text = "Gather Bot by |c0000CED1Dalvae|r" },
	{ type = "separator" },
	{ type = "title",    text = "|cffFF7C0AGatherBot Profile version 0.0.1|r" },
	{ type = "separator" },
	{ type = "separator" },
	{
		type = "entry",
		text = ni.spell.icon(2656) .. " Auto Gather",
		tooltip = "Gather herbs or ores automatically",
		enabled = true,
		key = "autogather"
	},
	{
		type = "entry",
		text = "Grind all mobs",
		tooltip = "Attack all nearby enemies",
		enabled = true,
		key = "grindall"
	},
	{
		type = "entry",
		text = "Combat Range",
		tooltip = "Set to 'melee' for melee combat or 'ranged' for ranged combat",
		enabled = true,
		key = "combatrange"
	},
}

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

local function loadWaypointsFromFile()
	local mapName = GetRealZoneText()
	local fileName = mapName .. ".json"
	local dir = ni.functions.getbasefolder()
	local filePath = dir .. "addon\\Waypoints\\" .. fileName

	local fileContent = ni.functions.loadcontent(filePath)
	if fileContent then
		return ni.utils.json.decode(fileContent)
	else
		print("No waypoints found for the current map.")
		return {}
	end
end

local waypoints = {}

local function Gather()
	local _, enabled = GetSetting("autogather")
	if not enabled then return end

	local objects = ni.objects
	for guid, object in pairs(objects) do
		if type(guid) == "string" and type(object) == "table" then
			local objectType = object.type
			local objectName = object.name
			local objectX, objectY, objectZ = object:location()

			if objectType == 11 or objectType == 12 then
				ni.navigation.move_to(objectX, objectY, objectZ)

				while ni.player.distance(objectX, objectY, objectZ) > 3 do
					ni.functions.moveto(objectX, objectY, objectZ)
					ni.utils.wait(0.1)
				end

				ni.player.interact(guid)
				ni.utils.wait(2)

				return true
			end
		end
	end

	return false
end

local function Grind()
	local _, enabled = GetSetting("grindall")
	if not enabled then return end

	local combatRange, _ = GetSetting("combatrange")
	local attackRange = combatRange == "melee" and 5 or 30

	local enemies = ni.player.enemiesinrange(60)
	for guid, enemy in pairs(enemies) do
		if type(guid) == "string" and type(enemy) == "table" then
			local enemyX, enemyY, enemyZ = enemy:location()

			if ni.player.distance(enemyX, enemyY, enemyZ) <= attackRange and ni.player.inlos(enemyX, enemyY, enemyZ) then
				ni.navigation.move_to(enemyX, enemyY, enemyZ)

				while ni.player.distance(enemyX, enemyY, enemyZ) > attackRange do
					ni.functions.moveto(enemyX, enemyY, enemyZ)
					ni.utils.wait(0.1)
				end

				ni.player.attack(guid)
				ni.utils.wait(2)

				return true
			end
		end
	end

	return false
end

local function Autocollect()
	if vars.farm then
		if funcs.unit_ismoving("player") == false and IsFalling() == nil then
			if funcs.cast_queue() then
				for k, v in pairs(dev.objects) do
					if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
						if dev.nodes[v.name] then
							local node_guid = v.guid;
							local node_name = v.name;

							if v:distance() < 5.5 then
								dev.run.interact(node_guid);
								printf('grabing ' .. node_name);
							end
						end
					end
				end
			end
		end
	end
end


local function OnLoad()
	ni.GUI.AddFrame("navbot", items)
	print("GatherBot profile loaded")
	waypoints = loadWaypointsFromFile()
end

local function OnUnLoad()
	ni.GUI.DestroyFrame("navbot")
end


local currentWaypointIndex = 1

local function path()
	local _, enabled = GetSetting("autogather")
	if not enabled then return end

	if #waypoints == 0 then
		print("No waypoints available. Please record waypoints first.")
		return
	end

	-- Obtener la posición actual del jugador
	local px, py, pz = ni.unit.info("player")
	local waypoint = waypoints[currentWaypointIndex]

	-- Moverse al siguiente waypoint
	ni.navigation.move_to(waypoint.x, waypoint.y, waypoint.z)

	-- Verificar si se ha llegado al waypoint actual
	if ni.world.get_3d_distance(px, py, pz, waypoint.x, waypoint.y, waypoint.z) < 5 then
		-- Incrementar el índice del waypoint
		currentWaypointIndex = currentWaypointIndex % #waypoints + 1
		print("Reached waypoint: " .. currentWaypointIndex)
	end

	-- Imprimir la posición actual del jugador y el índice del waypoint
	print(string.format("Player position: (%.2f, %.2f, %.2f)", px, py, pz))
	print(string.format("Moving to waypoint %d: (%.2f, %.2f, %.2f)", currentWaypointIndex, waypoint.x, waypoint.y,
		waypoint.z))
end

local abilities = {
	["Gather"] = function()
		if not ni.player.incombat() then
			return Gather()
		end
	end,
	["Grind"] = function()
		if not ni.player.incombat() then
			return Grind()
		end
	end,
	["Path"] = function()
		if not ni.player.incombat() and not Gather() and not Grind() then
			path()
		end
	end,
}

local queue = {
	"Gather",
	"Grind",
	"Path",
}

ni.bootstrap.profile("navbot", queue, abilities, OnLoad, OnUnLoad)
