-------------------
-- Navigation functions for ni
local ni = ...


ni.navigation = {
	status = 0,
	pullDistance = 20,
	nextNavNodeDistance = 5, -- Distance to next nav node in a generatd path before going to next node.
	lastPathIndex = -1,
	navPosition = {},       -- Table: XYZ
	navPathPosition = {},   -- Table: XYZ
	LastPathTime = 0,
	KeyMovement = {
		StrafeLeft = false,
		StrafeRight = false,
		MoveForward = false,
		MoveBackward = false,
		TurnLeft = false,
		TurnRight = false
	}
}

--[[--
Gets a path from start to end point with navigation mesh.

Parameters:
- **x1** `number`
- **y1** `number`
- **z1** `number`
- **x2** `number`
- **y2** `number`
- **z2** `number`
- **includes** `number`
- **excludes** `number`

Returns:
- **path** `xyz table`
@param x1 number
@param y1 number
@param z1 number
@param x2 number
@param y2 number
@param z2 number
@param[opt] includes number
@param[opt] excludes number
]]

ni.navigation.LastPathTime = tonumber(ni.client.get_time())
local cache_path = {}
function ni.navigation.get_path(x1, y1, z1, x2, y2, z2, includes, excludes)
	if ni.navigation.LastPathTime + (500 / 1000) > ni.client.get_time() then
		return cache_path
	end
	cache_path = ni.backend.GetPath(x1, y1, z1, x2, y2, z2, includes, excludes)
	--print(dump(cache_path))
	--print("Path generated!")
	ni.navigation.LastPathTime = ni.client.get_time()
	return cache_path
end

--[[--
Frees the maps loaded in memory.
]]
function ni.navigation.free_maps()
	return ni.backend.FreeMaps()
end

--[[--
Moves the player to the given coordinates.

Parameters:
- **x** `number`
- **y** `number`
- **z** `number`
@param x1 number
@param y1 number
@param z1 number
]]
function ni.navigation.move_to(x, y, z)
	return ni.backend.MoveTo(x, y, z)
end

--[[--
Gets last generated path size.
]]
function ni.navigation:GetPathSize()
	if ni.navigation.navPathPosition then
		return #ni.navigation.navPathPosition
	else
		return 0
	end
end

--[[--
Gets the coordinates from the last generated path at the provided index.

Parameters:
- **index** `number`

Returns:
- **coordinates** `xyz table`
@param x number
@param y number
@param z number
]]
function ni.navigation:GetPathPositionAtIndex(index)
	--print(index)
	if ni.navigation:GetPathSize() ~= 0 and index ~= nil and index <= ni.navigation:GetPathSize() then
		return ni.navigation.navPathPosition[index]['x'], ni.navigation.navPathPosition[index]['y'],
				ni.navigation.navPathPosition[index]['z']
	end
	return false
end

--[[--
Move player to desired location using path generated from meshes. Each call moves the player to next avaible navigation point generated from meshes.

Parameters:
- **x** `number`
- **y** `number`
- **z** `number`

Example:

```lua
if ni.unit.exists("target") then
   local tx, ty, tz = ni.unit.info("target")
   ni.navigation:moveToTarget(tx, ty, tz)
end
```
]]

function ni.navigation.distance_to_point(x, y, z)
	local px, py, pz = ni.player.location()
	return ni.world.get_3d_distance(px, py, pz, x, y, z)
end

function ni.navigation:moveToTarget(_x, _y, _z)
	-- Fetch our current position
	if _x == nil or _y == nil or _z == nil then return ni.navigation.StopMove() end
	local _px, _py, _pz = ni.unit.info("player");

	-- If the target moves more than 5 yard then make a new path
	if ((next(ni.navigation.navPosition) == nil) or (ni.world.get_3d_distance(_x, _y, _z, ni.navigation.navPosition['x'], ni.navigation.navPosition['y'], ni.navigation.navPosition['z']) > 5)) then
		ni.navigation.navPosition['x'] = _x;
		ni.navigation.navPosition['y'] = _y;
		ni.navigation.navPosition['z'] = _z;
		ni.navigation.navPathPosition = ni.navigation.get_path(_px, _py, _pz, _x, _y, _z);
		ni.navigation.lastnavIndex = 1;   -- start at index 1, index 0 is our position

		if (ni.navigation:GetPathSize() ~= 1) then
			ni.navigation.lastnavIndex = ni.navigation.lastnavIndex + 1;   -- start at index +1, as both index 0 and 1 is our position??
		end
	end
	local _ix, _iy, _iz
	-- Wait for path to be generated.
	if (ni.navigation:GetPathSize() ~= 0) then
		_ix, _iy, _iz = ni.navigation:GetPathPositionAtIndex(ni.navigation.lastnavIndex);
	else
		print("Waiting for path...");
		return;
	end

	-- If we are close to the next path node, increase our nav node index
	if (ni.world.get_3d_distance(_px, _py, _pz, _ix, _iy, _iz) < ni.navigation.nextNavNodeDistance) then
		if (ni.navigation:GetPathSize() == self.lastnavIndex) then
			self.lastnavIndex = ni.navigation:GetPathSize();    --We've reached our destination.
			ni.navigation:MoveForward(false)
			return;
		end
		ni.navigation.lastnavIndex = 1 + ni.navigation.lastnavIndex;
	end

	-- Move to the next destination in the path
	--ni.navigation.keyboardMoveTo(_ix, _iy, _iz)
	ni.navigation.move_to(_ix, _iy, _iz);
end

function ni.navigation:StrafeLeft(toggle)
	if toggle then
		ni.backend.CallProtected("StrafeLeftStart")
		self.KeyMovement.StrafeLeft = true;
		return;
	else
		ni.backend.CallProtected("StrafeLeftStop")
		self.KeyMovement.StrafeLeft = false;
		return;
	end
end

function ni.navigation:StrafeRight(toggle)
	if toggle then
		ni.backend.CallProtected("StrafeRightStart")
		self.KeyMovement.StrafeRight = true;
		return;
	else
		ni.backend.CallProtected("StrafeRightStop")
		self.KeyMovement.StrafeRight = false;
		return;
	end
end

function ni.navigation:TurnLeft(toggle)
	if toggle then
		ni.backend.CallProtected("TurnLeftStart")
		self.KeyMovement.TurnLeft = true;
		return;
	else
		ni.backend.CallProtected("TurnLeftStop")
		self.KeyMovement.TurnLeft = false;
		return;
	end
end

function ni.navigation:TurnRight(toggle)
	if toggle then
		ni.backend.CallProtected("TurnRightStart")
		self.KeyMovement.TurnRight = true;
		return;
	else
		ni.backend.CallProtected("TurnRightStop")
		self.KeyMovement.TurnRight = false;
		return;
	end
end

function ni.navigation:MoveForward(toggle)
	if toggle then
		ni.backend.CallProtected("MoveForwardStart")

		self.KeyMovement.MoveForward = true;
		return;
	else
		ni.backend.CallProtected("MoveForwardStop")
		self.KeyMovement.MoveForward = false;
		return;
	end
end

function ni.navigation:MoveBackward(toggle)
	if toggle then
		ni.backend.CallProtected("MoveBackwardStart")
		self.KeyMovement.MoveBackward = true;
		return;
	else
		ni.backend.CallProtected("MoveBackwardStop")
		self.KeyMovement.MoveBackward = false;
		return;
	end
end

function ni.navigation.StopMove()
	--ni.backend.StopMoving()
	ni.navigation:TurnLeft(false)
	ni.navigation:TurnRight(false)
	ni.navigation:MoveForward(false)
	if ni.navigation.KeyMovement.MoveForward then
		ni.navigation:MoveForward(false)
	end
	if ni.navigation.KeyMovement.MoveBackward then
		ni.navigation:MoveBackward(false)
	end
	ni.backend.StopMoving()
end

function ni.navigation.keyboardMoveTo(x, y, z)
	local playerFacing = ni.unit.facing("player")
	local px, py, pz = ni.unit.location("player")
	local tx, ty = x, y
	local atan = math.atan2(ty - py, tx - px)
	local angle = math.fmod(atan - playerFacing - math.pi, 2 * math.pi)
	if (angle < 0) then
		angle = angle + (math.pi * 2)
	end
	angle            = angle - math.pi

	local lx, ly, lz = ni.navigation:GetPathPositionAtIndex(ni.navigation.lastnavIndex - 1)
	local tx, ty, tz = ni.navigation:GetPathPositionAtIndex(ni.navigation.lastnavIndex)

	if ni.navigation.distance_to_point(x, y, z) < ni.navigation.nextNavNodeDistance and ni.navigation.lastnavIndex == ni.navigation.GetPathSize() and ni.world.get_3d_distance(lx, ly, lz, tx, ty, tz) > 2 then
		ni.navigation.StopMove()
		return true
	end

	if angle > -0.5 and angle < 0.5 or (ni.player.is_moving() and angle > -1.5 and angle < 1.5) then
		ni.navigation:MoveForward(true)
	else
		ni.navigation:MoveForward(false)
		ni.navigation.StopMove()
	end
	if angle > -0.1 and angle < 0.1 then
		ni.navigation:TurnLeft(false)
		ni.navigation:TurnRight(false)
	elseif (angle < 0) then
		ni.navigation:TurnLeft(false)
		ni.navigation:TurnRight(true)
	else
		ni.navigation:TurnRight(false)
		ni.navigation:TurnLeft(true)
	end
end

function ni.navigation.InterceptPoint(object)
	local pX, pY, pZ = ni.unit.location("player")
	local oX, oY, oZ = ni.unit.location(object)
	local objectDistance = ni.navigation.distance_to_point(object)
	local objectMovement = ni.unit.facing(object)
	local playerSpeed = GetUnitSpeed("player");
	local objectSpeed = GetUnitSpeed(object);
	if playerSpeed == 0 then
		return false     --oX, oY
	elseif objectSpeed == 0 then
		return oX, oY
	end
	local vXO = objectSpeed * math.cos(objectMovement);
	local vYO = objectSpeed * math.sin(objectMovement);
	local vXPO, vYPO = pX - oX, pY - oY;
	local distanceXY = math.sqrt(vXPO ^ 2 + vYPO ^ 2)
	local A = playerSpeed ^ 2 - objectSpeed ^ 2
	local B = 2 * (vXPO * vXO + vYPO * vYO)
	local C = -(distanceXY ^ 2)
	if B ^ 2 - 4 * A * C < 0 then
		return false     --oX, oY
	end
	local t1 = (-B + math.sqrt(B ^ 2 - 4 * A * C)) / (2 * A)
	local t2 = (-B - math.sqrt(B ^ 2 - 4 * A * C)) / (2 * A)
	if t1 < 0 and t2 < 0 then
		return false     --oX, oY
	elseif (t1 < 0 and t2 > 0) then
		timeTotal = t2
	elseif t2 < 0 and t1 > 0 then
		timeTotal = t1
	elseif t2 > 0 and t2 < t1 then
		timeTotal = t2
	elseif t1 > 0 and t1 < t2 then
		timeTotal = t1
	else
		return false     --oX, oY
	end
	local interceptX = oX + objectSpeed * timeTotal * math.cos(objectMovement);
	local interceptY = oY + objectSpeed * timeTotal * math.sin(objectMovement);
	return interceptX, interceptY
end
