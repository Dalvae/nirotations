-------------------
-- Navigation functions for ni


local navigation = {
	nextNavNodeDistance = 5, -- Distance to next nav node in a generatd path before going to next node.
	lastPathIndex = -1,
	navPosition = {},       -- Table: XYZ
	navPathPosition = {},   -- Table: XYZ
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
function navigation.get_path(x1, y1, z1, x2, y2, z2, includes, excludes)
	return ni.functions.getpath(x1, y1, z1, x2, y2, z2, includes, excludes)
end

--[[--
Frees the maps loaded in memory.
]]
function navigation.free_maps()
	return ni.functions.freemaps()
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
function navigation.move_to(x, y, z)
	return ni.functions.moveto(x, y, z)
end

--[[--
Gets last generated path size.
]]
function navigation:GetPathSize()
	if self.navPathPosition ~= nil then
		return #self.navPathPosition
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
function navigation:GetPathPositionAtIndex(index)
	return self.navPathPosition[index]['x'], self.navPathPosition[index]['y'], self.navPathPosition[index]['z']
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
function navigation:moveToTarget(_x, _y, _z)
	-- Fetch our current position
	local _px, _py, _pz = ni.unit.info("player");

	-- If the target moves more than 2 yard then make a new path
	if ((next(self.navPosition) == nil) or (ni.world.get_3d_distance(_x, _y, _z, self.navPosition['x'], self.navPosition['y'], self.navPosition['z']) > 2)) then
		self.navPosition['x'] = _x;
		self.navPosition['y'] = _y;
		self.navPosition['z'] = _z;
		self.navPathPosition = navigation.get_path(_px, _py, _pz, _x, _y, _z);
		self.lastnavIndex = 1;                   -- start at index 1, index 0 is our position
		if (navigation:GetPathSize() ~= 1) then
			self.lastnavIndex = self.lastnavIndex + 1; -- start at index +1, as both index 0 and 1 is our position??
		end
	end

	-- Wait for path to be generated.
	if (navigation:GetPathSize() ~= 0) then
		_ix, _iy, _iz = navigation:GetPathPositionAtIndex(self.lastnavIndex);
	else
		print("Waiting for path...");
		return;
	end

	-- If we are close to the next path node, increase our nav node index
	if (ni.world.get_3d_distance(_px, _py, _pz, _ix, _iy, _iz) < self.nextNavNodeDistance) then
		if (navigation:GetPathSize() == self.lastnavIndex) then
			self.lastnavIndex = navigation:GetPathSize(); --We've reached our destination.
			return;
		end
		self.lastnavIndex = 1 + self.lastnavIndex;
	end

	-- Move to the next destination in the path
	navigation.move_to(_ix, _iy, _iz);
end

return navigation;
