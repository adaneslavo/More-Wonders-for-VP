print("Loading UniqueWonderRequirements.lua from MWfVP")
--------------------------------------------------------------
-- Support for true Lake locations for Wonders and Buildings using CityCanConstruct event
-- Lake is when: FreshWater = 1, Water = 1, MinAreaSize = 1
-- The game allows for building on the Coast with River in that situation - the script removes that possibility
-- Dec 15, 2017: Created, Infixo
-- Jan 7, 2020: Improved, adan_eslavo
--------------------------------------------------------------

-- debug output routine
function dprint(sStr,p1,p2,p3,p4,p5,p6)
	local sOutStr = sStr
	if p1 ~= nil then sOutStr = sOutStr.." [1] "..tostring(p1) end
	if p2 ~= nil then sOutStr = sOutStr.." [2] "..tostring(p2) end
	if p3 ~= nil then sOutStr = sOutStr.." [3] "..tostring(p3) end
	if p4 ~= nil then sOutStr = sOutStr.." [4] "..tostring(p4) end
	if p5 ~= nil then sOutStr = sOutStr.." [5] "..tostring(p5) end
	if p6 ~= nil then sOutStr = sOutStr.." [6] "..tostring(p6) end
	print(sOutStr)
end

local tValidBuildingsLake = {}
local tValidBuildingsMineBuildings = {}
local tValidBuildingsMineResources = {}
local tValidBuildingsWithProhibitedTerrain = {}
local tProhibitedTerrainForBuilding = {}

-- checks if city is between lake and sea and adds this condition (normally it would be treated like city wothout lake)
function LakeWithOcean(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsLake[iBuildingType] then return true end
   
	local pPlayer = Players[iPlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(iCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()

	if pCity:IsCoastal(1) then -- city is adjacent to at least one water tile
		for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
			if Map.PlotDirection(iCityX, iCityY, dir):IsLake() then
				return true
			end
		end
	end

	return false
end
GameEvents.CityCanConstruct.Add(LakeWithOcean)

-- looks for mine in the city terrain
function CityWithMine(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsMineBuildings[iBuildingType] then return true end
   
	local pPlayer = Players[iPlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(iCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()

	--[[for resource in tValidBuildingsMineResources() do
		if pCity:IsHasResourceLocal(resource) then
			return true
		end
	end--]]

	for cityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
		local pSpecificPlot = pCity:GetCityIndexPlot(cityPlot)
		local iPlotOwner = pSpecificPlot:GetOwner()
				
		if iPlotOwner == iPlayer and pSpecificPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_MINE then
			return true
		end
	end

	return false
end
GameEvents.CityCanConstruct.Add(CityWithMine)

-- expands ProhibitedCityTerrain function by tiles around the city
-- adds condition: if not tundra then also not snow
-- 0 Grass, 1 Plains, 2 Desert, 3 Tundra, 4 Snow, 5 Coast, 6 Ocean, 7 Mountain, 8 Hill
function ProhibitionAround(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsWithProhibitedTerrain[iBuildingType] then return true end
   
	local pPlayer = Players[iPlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(iCity)
	local iCityTerrain = pCity:GetCityIndexPlot(0):GetTerrainType()
	local iProhibitedTerrain = tProhibitedTerrainForBuilding[iBuildingType]
	
	--[[if iCityTerrain == iProhibitedTerrain then
		return false -- already part of existing functionPRohibitedCityTerrain
	else--]]if iProhibitedTerrain == 3 and iCityTerrain == 4 then
		return false
	end
	
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()
	
	for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
		local iTerrain = Map.PlotDirection(iCityX, iCityY, dir):GetTerrainType()
		
		if iTerrain == iProhibitedTerrain then
			return false
		elseif iProhibitedTerrain == 3 and iTerrain == 4 then
			return false
		end
	end
	
	return true
end
GameEvents.CityCanConstruct.Add(ProhibitionAround)

function Initialize()
	-- add lake buildings ==> lake is when: FreshWater = 1, Water = 1, MinAreaSize = 1
	for building in GameInfo.Buildings() do	
		if building.FreshWater and building.Water and building.MinAreaSize == 1 and building.IsCorporation == 0 then
			local iBuilding = GameInfoTypes[building.Type]
			
			dprint("...adding (id,building,requirement)", building.ID, building.Type, "(Building require lake)")
			tValidBuildingsLake[building.ID] = true
		end
	end

	-- add mine buildings
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.ID, GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.Type, "(Building require mine)")
	tValidBuildingsMineBuildings[GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.ID] = true

	-- add mining resources (currently unused)
	for improvement in GameInfo.Improvement_ResourceTypes() do
		if improvement.ImprovementType == "IMPROVEMENT_MINE" then
			dprint("...adding (id,resource,requirement)", GameInfo.Resources[improvement.ResourceType].ID, improvement.ResourceType, "(Mining Resource)")
			tValidBuildingsMineResources[GameInfo.Resources[improvement.ResourceType].ID] = true
		end
	end

	-- add buildings with prohibited terrain
	for building in GameInfo.Buildings() do
		if building.ProhibitedCityTerrain ~= nil then
			dprint("...adding (id,building,prohibition,terrain)", building.ID, building.Type, "(Building is prohibited on: " .. building.ProhibitedCityTerrain .. ")")
			tValidBuildingsWithProhibitedTerrain[building.ID] = true
			tProhibitedTerrainForBuilding[building.ID] = GameInfo.Terrains[building.ProhibitedCityTerrain].ID
		end
	end
end
Initialize()

print("Loaded UniqueWonderRequirements.lua from MWfVP")