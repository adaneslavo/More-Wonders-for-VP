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
local tValidBuildingsNoWater = {}
local tValidBuildingsUndergroundBuildings = {}
local tValidBuildingsFarms = {}
local tValidBuildingsVillage = {}
--local tValidBuildingsMineResources = {}
local tValidBuildingsWithProhibitedTerrain = {}
local tProhibitedTerrainForBuilding = {}
local tValidBuildingsMountains = {}
local tValidBuildingsOneTile = {}
local tValidBuildingsPeace = {}

-- checks if city is between LAKE and sea and adds this condition (normally it would be treated like city wothout lake)
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

-- checks if city is NOT near WATER
function CityWithNoWater(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsNoWater[iBuildingType] then return true end
   
	local pPlayer = Players[iPlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(iCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()

	if pCity:IsCoastal(1) then -- city is adjacent to at least one water tile
		return false
	end

	return true
end
GameEvents.CityCanConstruct.Add(CityWithNoWater)

-- looks for MINE or QUARRY inside the city (TERRACOTA)
function CityWithMine(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsUndergroundBuildings[iBuildingType] then return true end
   
	local pPlayer = Players[iPlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(iCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()

	for cityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
		local pSpecificPlot = pCity:GetCityIndexPlot(cityPlot)
		local iImprovement = pSpecificPlot:GetImprovementType()
		local iPlotOwner = pSpecificPlot:GetOwner()
				
		if iPlotOwner == iPlayer and 
			(iImprovement == GameInfoTypes.IMPROVEMENT_MINE or iImprovement == GameInfoTypes.IMPROVEMENT_QUARRY) and
			not pSpecificPlot:IsImprovementPillaged() then
			return true
		end
	end

	return false
end
GameEvents.CityCanConstruct.Add(CityWithMine)

-- looks for 3 FARMS inside the city (ARTEMIS)
function CityWithFarms(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsFarms[iBuildingType] then return true end
   
	local pPlayer = Players[iPlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(iCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()
	local iFarmCount = 0

	for cityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
		local pSpecificPlot = pCity:GetCityIndexPlot(cityPlot)
		local iImprovement = pSpecificPlot:GetImprovementType()
		local iPlotOwner = pSpecificPlot:GetOwner()
				
		if iPlotOwner == iPlayer and iImprovement == GameInfoTypes.IMPROVEMENT_FARM and not pSpecificPlot:IsImprovementPillaged() then
			iFarmCount = iFarmCount + 1
			
			if iFarmCount >= 3 then
				return true
			end
		end
	end

	return false
end
GameEvents.CityCanConstruct.Add(CityWithFarms)

-- looks for VILLAGE inside the city (QALHAT)
function CityWithVillage(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsVillage[iBuildingType] then return true end
   
	local pPlayer = Players[iPlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(iCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()

	for cityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
		local pSpecificPlot = pCity:GetCityIndexPlot(cityPlot)
		local iImprovement = pSpecificPlot:GetImprovementType()
		local iPlotOwner = pSpecificPlot:GetOwner()
				
		if iPlotOwner == iPlayer and iImprovement == GameInfoTypes.IMPROVEMENT_TRADING_POST and not pSpecificPlot:IsImprovementPillaged() then
			return true
		end
	end

	return false
end
GameEvents.CityCanConstruct.Add(CityWithVillage)

-- expands ProhibitedCityTerrain function by tiles around the city
-- adds condition: if not tundra then also not snow
function ProhibitionAround(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsWithProhibitedTerrain[iBuildingType] then return true end
   
	local pPlayer = Players[iPlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(iCity)
	local iCityTerrain = pCity:GetCityIndexPlot(0):GetTerrainType()
	local iProhibitedTerrain = tProhibitedTerrainForBuilding[iBuildingType]
	local iTundra = GameInfoTypes.TERRAIN_TUNDRA
	local iSnow = GameInfoTypes.TERRAIN_SNOW

	-- check city tile
	--[[if iCityTerrain == iProhibitedTerrain then
		return false -- already part of existing functionPRohibitedCityTerrain
	else--]]if iProhibitedTerrain == iTundra and iCityTerrain == iSnow then
		return false
	end
	
	-- check tiles around the city
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()
	
	for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
		local iTerrain = Map.PlotDirection(iCityX, iCityY, dir):GetTerrainType()
		
		if iTerrain == iProhibitedTerrain then
			return false
		elseif iProhibitedTerrain == iTundra and iTerrain == iSnow then
			return false -- if not tundra then also not snow
		end
	end
	
	return true
end
GameEvents.CityCanConstruct.Add(ProhibitionAround)

-- looks for 2 MOUNTAINS in city range (MACHU PICCHU)
function CityOnMountains(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsMountains[iBuildingType] then return true end
   
	local pPlayer = Players[iPlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(iCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()
	local iMountainCount = 0

	for cityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
		local pSpecificPlot = pCity:GetCityIndexPlot(cityPlot)
		local iTerrain = pSpecificPlot:GetTerrainType()
		local iPlotOwner = pSpecificPlot:GetOwner()
				
		if iPlotOwner == iPlayer and iTerrain == GameInfoTypes.TERRAIN_MOUNTAIN then
			iMountainCount = iMountainCount + 1
			
			if iMountainCount >= 2 then
				return true
			end
		end
	end

	return false
end
GameEvents.CityCanConstruct.Add(CityOnMountains)

-- checks if city is ONE-tile (MONT ST MICHELLE, SOLOVIETSKY)
function OneTileCity(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsOneTile[iBuildingType] then return true end
	
	local pPlayer = Players[iPlayer]
	
	if not pPlayer:IsAlive() then return false end
	
	local pCity = pPlayer:GetCityByID(iCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()
	
	-- check all six dir, quit if not water
	for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
		if not Map.PlotDirection(iCityX, iCityY, dir):IsWater() then
			return false
		end
	end
	
	return true
end
GameEvents.CityCanConstruct.Add(OneTileCity)

-- checks if player is at PEACE (BUDDHAS OF BAMYAN)
function PlayerIsNotAtWar(iPlayer, iCity, iBuildingType)
	if not tValidBuildingsPeace[iBuildingType] then return true end
	
	local pPlayer = Players[iPlayer]
	
	if not pPlayer:IsAlive() then return false end
	
	local pTeam = Teams[pPlayer:GetTeam()]
	local iCountWars = pTeam:GetAtWarCount(false)
	print (pTeam:GetName(), iCountWars)
	if iCountWars > 0 then
		return false
	end
	
	return true
end
GameEvents.CityCanConstruct.Add(PlayerIsNotAtWar)

function Initialize()
	-- add lake buildings ==> lake is when: FreshWater = 1, Water = 1, MinAreaSize = 1
	for building in GameInfo.Buildings() do	
		if building.FreshWater and building.Water and building.MinAreaSize == 1 and building.IsCorporation == 0 then
			local iBuilding = GameInfoTypes[building.Type]
			
			dprint("...adding (id,building,requirement)", building.ID, building.Type, "(Building require lake)")
			tValidBuildingsLake[building.ID] = true
		end
	end

	-- add no water buildings
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.ID, GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.Type, "(Building must not be build next to a water)")
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_CHEVALIERS.ID, GameInfo.Buildings.BUILDING_CHEVALIERS.Type, "(Building must not be build next to a water)")
	tValidBuildingsNoWater[GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.ID] = true
	tValidBuildingsNoWater[GameInfo.Buildings.BUILDING_CHEVALIERS.ID] = true

	-- add mine buildings
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.ID, GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.Type, "(Building require mine or quarry)")
	tValidBuildingsUndergroundBuildings[GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.ID] = true

	-- add mining resources (currently unused)
	--[[for improvement in GameInfo.Improvement_ResourceTypes() do
		if improvement.ImprovementType == "IMPROVEMENT_MINE" then
			dprint("...adding (id,resource,requirement)", GameInfo.Resources[improvement.ResourceType].ID, improvement.ResourceType, "(Mining Resource)")
			tValidBuildingsMineResources[GameInfo.Resources[improvement.ResourceType].ID] = true
		end
	end--]]

	-- add farm (x3) buldings
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_TEMPLE_ARTEMIS.ID, GameInfo.Buildings.BUILDING_TEMPLE_ARTEMIS.Type, "(Building require 3 farms)")
	tValidBuildingsFarms[GameInfo.Buildings.BUILDING_TEMPLE_ARTEMIS.ID] = true

	-- add village buldings
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_QALHAT.ID, GameInfo.Buildings.BUILDING_QALHAT.Type, "(Building require village)")
	tValidBuildingsVillage[GameInfo.Buildings.BUILDING_QALHAT.ID] = true

	-- add buildings with prohibited terrain
	for building in GameInfo.Buildings() do
		if building.ProhibitedCityTerrain ~= nil then
			dprint("...adding (id,building,prohibition,terrain)", building.ID, building.Type, "(Building is prohibited on: " .. building.ProhibitedCityTerrain .. ")")
			tValidBuildingsWithProhibitedTerrain[building.ID] = true
			tProhibitedTerrainForBuilding[building.ID] = GameInfo.Terrains[building.ProhibitedCityTerrain].ID
		end
	end

	-- add mountain (x2) buildings
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_MACHU_PICHU.ID, GameInfo.Buildings.BUILDING_MACHU_PICHU.Type, "(Building require 2 mountains)")
	tValidBuildingsMountains[GameInfo.Buildings.BUILDING_MACHU_PICHU.ID] = true

	-- add buildings that require one-tile city
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_MICHEL.ID, GameInfo.Buildings.BUILDING_MICHEL.Type, "(One-tile city)")
	--dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_SOLOVIETSKY.ID, GameInfo.Buildings.BUILDING_SOLOVIETSKY.Type, "(One-tile city)")
	tValidBuildingsOneTile[GameInfo.Buildings.BUILDING_MICHEL.ID] = true
	--tValidBuildingsOneTile[GameInfo.Buildings.BUILDING_SOLOVIETSKY.ID] = true

	-- add buildings that require peace
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_BAMYAN.ID, GameInfo.Buildings.BUILDING_BAMYAN.Type, "(Player may not be at war)")
	tValidBuildingsPeace[GameInfo.Buildings.BUILDING_BAMYAN.ID] = true
end
Initialize()

print("Loaded UniqueWonderRequirements.lua from MWfVP")