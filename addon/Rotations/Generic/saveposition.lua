local waypoints = {}
local lastPosition = { x = 0, y = 0, z = 0 }
local saveDistance = 5 -- Distancia mínima para guardar un nuevo punto

local function savePosition()
	-- Obtener la posición actual del jugador
	local px, py, pz = ni.unit.info("player")
	-- Calcular la distancia recorrida desde el último punto guardado
	local distance = math.sqrt((px - lastPosition.x) ^ 2 + (py - lastPosition.y) ^ 2 + (pz - lastPosition.z) ^ 2)
	if distance >= saveDistance then
		-- Añadir la nueva posición a la lista de waypoints
		table.insert(waypoints, { x = px, y = py, z = pz })
		lastPosition = { x = px, y = py, z = pz }
	end
end

local function saveWaypointsToFile()
	-- Crear el nombre del archivo
	local mapName = GetRealZoneText()
	local fileName = mapName .. ".json"
	local dir = ni.functions.getbasefolder()
	-- Convertir la tabla a JSON
	local jsonData = ni.utils.json.encode(waypoints)
	-- Guardar el archivo
	ni.functions.savecontent(dir .. "addon\\Waypoints\\" .. fileName, jsonData)
end
local function onLoad()
	print("guardando")
end
local function onunload()
	-- Guardar los waypoints al finalizar el perfil
	print("dejar de guardar")
	saveWaypointsToFile()
end


local queue = {
	"RecordPosition"
}

local abilities = {
	["RecordPosition"] = function()
		savePosition()
	end,
}


ni.bootstrap.profile("saveposition", queue, abilities, onLoad, onunload)
