-- NaturalWondersCustomMethods.lua
-- Author: Leo
-- DateCreated: 3/13/2016 9:58:45 AM
--------------------------------------------------------------
------------------------------------------------------------------------------
--	MODDER:   Barathor
--  THANKS:	  whoward69
--  MODDER2	  adan_eslavo
------------------------------------------------------------------------------
-- MOD: * Great Barrier Reef (1):	3-tile wonder (in-line, any direction); much closer to land; surrounded by coast and atols;
--		* Rock of Gibraltar (2):	one land adjacent (preferred flat grass);
--		* Krakatoa (3):				near islands and smaller landmasses;
--		* Lake Victoria (4):		looks for a river surrounded by bunch of hills and mountains;
--		* Giant's Causeway (5):		2-tile wonder; custom method similar to Rock of Gibraltar; prefers tundra;
--		* Salar de Uyuni (6):		2-tile wonder; has only tile changes method; flattens, clears features and changes adjacent tiles to desert;
--		* Mt. Kailash (7):			has only tile changes method; adds mountains; changes adjacent to tundra;
--		* Sri Pada (8):				has only tile changes method; changes adjacent to grass;
--		* Mt. Everest (9):			has only tile changes method; adds mountains; changes adjacent to tundra or snow;
--		* Lake Retba (10):			must be on solid terrain with coast;
--		* Eye of the Sahara (11):	3-tile wonder; creates more desert and mountains;
--		* Bermuda Triangle (12):	3-tile wonder; set between 3-4 tiles of land on 3 corners separated by water;
--		* Dallol (13):				has only tile changes method; all tiles around are clered from features;
--		* Bioluminescent Bay (14):	surrounded by jungle and grassland;
--		* Mt. Paektu (15):			has only tile changes method; changes core tile to flat and tundra, creates 3 new rivers;
--		* Uluru (16):				has only tile changes method; makes surrounding flat;
--		* Barringer Crater (17):	has only tile changes method; makes surroundings flat;
--		* Old Faithful (18):		changes core tile to hill;
--		
--		* Adds a latitude check for all water-based natural wonders in this function. Unlike land-based NW's, these are too flexible and need more restrictions.
--		  (With the new latitude check keeping them away from the polar areas, the ice checks aren't really needed anymore, but I kept them in for modders.)
--
--		* (Still trying to get this to work here in this file.) Fixes a rare bug with the Reef which would cause resources to sometimes be placed on top of its lower half (now around center).
------------------------------------------------------------------------------
--	FILE:	  NaturalWondersCustomMethods.lua
--	AUTHOR:   Bob Thomas
--	PURPOSE:  Functions designed to support custom natural wonder placement.
------------------------------------------------------------------------------
--	Copyright (c) 2011 Firaxis Games, Inc. All rights reserved.
------------------------------------------------------------------------------

--[[ -------------------------------------------------------------------------
NOTE: This file is an essential component of the Start Plot System. I have
separated out the functions in this file to permit more convenient operation
for modders wishing to add new natural wonders or modify existing ones. If
you are supplying new custom methods, you will not have to supply an updated
version of AssignStartingPlots with your mod instead, you only have to supply
an update of this file along with your updated Civ5Features.xml file.

CONTENTS OF THIS FILE:

* NWCustomEligibility(x, y, method_number)
* NWCustomPlacement(x, y, row_number, method_number)
------------------------------------------------------------------------- ]]--

include("MapmakerUtilities")

------------------------------------------------------------------------------
function NWCustomEligibility(x, y, method_number)
	local ePlotOcean = PlotTypes.PLOT_OCEAN
	local ePlotFlat = PlotTypes.PLOT_LAND
	local ePlotHill = PlotTypes.PLOT_HILLS
	local ePlotMountain = PlotTypes.PLOT_MOUNTAIN
	local eTerrainCoast = TerrainTypes.TERRAIN_COAST
	local eTerrainGrass = TerrainTypes.TERRAIN_GRASS	
	local eTerrainPlains = TerrainTypes.TERRAIN_PLAINS
	local eTerrainDesert = TerrainTypes.TERRAIN_DESERT
	local eTerrainTundra = TerrainTypes.TERRAIN_TUNDRA
	local eTerrainSnow = TerrainTypes.TERRAIN_SNOW
	local eFeatureNo = FeatureTypes.NO_FEATURE
	local eFeatureForest = FeatureTypes.FEATURE_FOREST
	local eFeatureJungle = FeatureTypes.FEATURE_JUNGLE

	local tDirectionTypes = {
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_NORTHWEST
	}

	local iW, iH = Map.GetGridSize()
	print("NWCE", method_number, x, y)
	if method_number == 1 then
		-- GREAT BARRIER REEF
		-- MOD: Now 3 tile wonder - long shape;
		-- MOD: Area checked is better to handle all 3 main directions: E-W, NW-SE, NE-SW;
		-- MOD: Latitude to prevent it from spawning in polar regions;
		if (y >= (iH/2)) then	
			-- Upper half of map;
			if (math.abs((iH/2) - y)/(iH/2)) > 0.4 then
				return false
			end
		else
			-- Lower half of map;
			if (math.abs((iH/2) - y + 1)/(iH/2)) > 0.4 then
				return false
			end
		end 
		
		local pMainPlot = Map.GetPlot(x, y)		
		
		if pMainPlot == nil then return false end
		if pMainPlot:IsWater() == false then return false end
		if pMainPlot:IsLake() then return false end
		if pMainPlot:IsAdjacentToLand() then return false end

		local iNumLand, iNumCoast = 0, 0
		
		local tDirectionsNE = {
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST
		}
		local tDirectionsE = {
			DirectionTypes.DIRECTION_EAST
		}
		local tDirectionsSE = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST
		}
		local tDirectionsSW = {
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST
		}
		local tDirectionsW = {
			DirectionTypes.DIRECTION_WEST
		}
		local tDirectionsNW = {
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST,
			DirectionTypes.DIRECTION_NORTHEAST
		}
		
		local tSubdirections = {
			tDirectionsNE,
			tDirectionsE,
			tDirectionsSE,
			tDirectionsSW,
			tDirectionsW,
			tDirectionsNW
		}

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if pAdjacentPlot == nil then return false end
			
			local iX = pAdjacentPlot:GetX()
			local iY = pAdjacentPlot:GetY()
				
			for j, subdirection in ipairs(tSubdirections[i]) do
				local pDistantPlot = Map.PlotDirection(iX, iY, subdirection)

				if pDistantPlot == nil then return false end

				if pDistantPlot:GetTerrainType() == eTerrainCoast then
					iNumCoast = iNumCoast + 1
				end

				if pDistantPlot:IsAdjacentToLand() then
					iNumLand = iNumLand + 1
				end

			end
		end
		
		if iNumCoast < 7 or iNumLand < 5 then return false end
		
		return true
	elseif method_number == 2 then
		-- ROCK OF GIBRALTAR
		local pPlot = Map.GetPlot(x, y)
		
		if pPlot == nil then return false end
		if pPlot:IsWater() == false then return false end
		if pPlot:IsLake() then return false end
		if pPlot:GetFeatureType() ~= eFeatureNo then return false end
		if pPlot:GetTerrainType() == eTerrainTundra or pPlot:GetTerrainType() == eTerrainSnow then return false end

		local iNumLand = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
		
			local sAdjacentPlotType = pAdjacentPlot:GetPlotType()
			local sAdjacentTerrainType = pAdjacentPlot:GetTerrainType()
			local sAdjacentFeatureType = pAdjacentPlot:GetFeatureType()
			
			-- MOD: Don't permit small landmasses especially those single-tile islands!
			-- MOD: Avoid mountains
			if sAdjacentPlotType ~= ePlotOcean then
				if pAdjacentPlot:Area():GetNumTiles() < 40
				or sAdjacentPlotType == ePlotMountain or sAdjacentPlotType == ePlotHill
				or sAdjacentFeatureType ~= eFeatureNo
				or sAdjacentTerrainType == eTerrainTundra or sAdjacentTerrainType == eTerrainSnow or sAdjacentTerrainType == eTerrainGrass then return false end
				
				iNumLand = iNumLand + 1
				
				if iNumLand > 1 then return false end
			end
		end

		if iNumLand ~= 1 then return false end
		
		return true
	elseif method_number == 3 then
		-- KRAKATOA
		local pMainPlot = Map.GetPlot(x, y)
		
		if pMainPlot == nil then return false end
		if pMainPlot:IsWater() == false then return false end
		if pMainPlot:IsLake() then return false end
		if pMainPlot:GetFeatureType() ~= eFeatureNo then return false end
		
		local bBigIsland = false
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
			if pAdjacentPlot:GetFeatureType() ~= eFeatureNo then return false end
		
			local iX = pAdjacentPlot:GetX()
			local iY = pAdjacentPlot:GetY()
			
			for j, subdirection in ipairs(tDirectionTypes) do
				local pDistantPlot = Map.PlotDirection(iX, iY, subdirection)
				
				if pDistantPlot == nil then return false end
		
				local sDistantPlotType = pDistantPlot:GetPlotType()
				local sDistantAreaNear = pDistantPlot:Area():GetNumTiles()
				
				if sDistantPlotType ~= ePlotOcean then
					if sDistantAreaNear > 25 then return false end
					
					if sDistantAreaNear >= 10 and sDistantAreaNear <= 25 then
						bBigIsland = true
					end
				end
			end
		end
		
		if not bBigIsland then return false end
		
		return true
	elseif method_number == 4 then
		-- LAKE VICTORIA
		local pMainPlot = Map.GetPlot(x, y)
		
		if pMainPlot == nil then return false end
		if pMainPlot:IsAdjacentToShallowWater() then return false end
		if not pMainPlot:IsRiver() then return false end
		if pMainPlot:GetTerrainType() == eTerrainSnow then return false end
		
		local iNumHillsAndMountains = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
			if pAdjacentPlot:GetTerrainType() == eTerrainSnow then return false end
			
			local sPlotType = pAdjacentPlot:GetPlotType()

			if sPlotType == ePlotHill or sPlotType == ePlotMountain then
				iNumHillsAndMountains = iNumHillsAndMountains + 1
			end
		end
		
		if iNumHillsAndMountains < 3 then return false end

		return true
	elseif method_number == 5 then
		-- GIANT'S CAUSEWAY
		local pPlot = Map.GetPlot(x, y)
		
		if pPlot == nil then return false end
		if pPlot:IsWater() == false then return false end
		if pPlot:IsLake() then return false end

		local iNumLand = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
		
			local sAdjacentPlotType = pAdjacentPlot:GetPlotType()
			local sAdjacentTerrainType = pAdjacentPlot:GetTerrainType()
			local sAdjacentFeatureType = pAdjacentPlot:GetFeatureType()
			
			if sAdjacentPlotType ~= ePlotOcean then
				if pAdjacentPlot:Area():GetNumTiles() < 5 or pAdjacentPlot:Area():GetNumTiles() > 30 
				or not (sAdjacentTerrainType == eTerrainTundra or sAdjacentTerrainType == eTerrainSnow or sAdjacentTerrainType == eTerrainPlains)
				or sAdjacentFeatureType ~= eFeatureNo then return false end
				
				iNumLand = iNumLand + 1
				
				if iNumLand > 2 then return false end
			end
		end
		
		if iNumLand < 1 then return false end
		
		return true
	elseif method_number == 6 then
		-- reserved: Salar de Uyuni
	elseif method_number == 7 then
		-- reserved: Mt. Kailash
	elseif method_number == 8 then
		-- reserved: Sri Pada
	elseif method_number == 9 then
		-- reserved: Mt. Everest
	elseif method_number == 10 then
		-- LAKE RETBA
		local pMainPlot = Map.GetPlot(x, y)
		
		if pMainPlot == nil then return false end
		if not pMainPlot:IsAdjacentToShallowWater() then return false end
		if pMainPlot:IsRiver() then return false end
		if pMainPlot:GetPlotType() ~= ePlotFlat then return false end
		
		local pMainTerrainType = pMainPlot:GetTerrainType()

		if pMainTerrainType == eTerrainTundra or pMainTerrainType == eTerrainSnow then return false end
		
		local pMainAreaNear = pMainPlot:Area():GetNumTiles()

		if pMainAreaNear < 6 or pMainAreaNear > (3 * iH) then return false end 

		local bIsHasSeaTiles = false
		local iNumLandTiles = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
		
			local sAdjacentTerrainType = pAdjacentPlot:GetTerrainType()

			if sAdjacentTerrainType == eTerrainGrass or sAdjacentTerrainType == eTerrainTundra or sAdjacentTerrainType == eTerrainSnow then return false end

			local sAdjacentPlotType = pAdjacentPlot:GetPlotType()
			
			if sAdjacentPlotType == ePlotMountain then return false end

			if sAdjacentPlotType == ePlotOcean then
				if pAdjacentPlot:IsLake() then return false end
				
				bIsHasSeaTiles = true
			end

			if sAdjacentPlotType ~= ePlotOcean then
				iNumLandTiles = iNumLandTiles + 1
			end
		end

		if not bIsHasSeaTiles or iNumLandTiles ~= 4 then return false end

		return true
	elseif method_number == 11 then
		-- reserved: Eye of the Sahara
	elseif method_number == 12 then
		-- BERMUDA TRIANGLE
		local pMainPlot = Map.GetPlot(x, y)		
		
		if pMainPlot == nil then return false end
		if pMainPlot:IsWater() == false then return false end
		if pMainPlot:IsLake() then return false end

		local pSEPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHEAST)
		
		if pSEPlot == nil then return false end
		if pSEPlot:IsWater() == false then return false end
		
		local pSWPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHWEST)

		if pSWPlot == nil then return false end
		if pSWPlot:IsWater() == false then return false end
		
		local iNumLandN, iNumLandSE, iNumLandSW = 0, 0, 0
		
		local tDirectionsTop = {
			DirectionTypes.DIRECTION_NORTHWEST,
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_EAST
		}
		local tDirectionsBottomRight = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST
		}
		local tDirectionsBottomLeft = {
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST
		}

		for i, direction in ipairs(tDirectionsTop) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if pAdjacentPlot == nil then return false end

			if pAdjacentPlot:GetPlotType() ~= ePlotOcean then
				iNumLandN = iNumLandN + 1
			end
		end

		local iSEX = pSEPlot:GetX()
		local iSEY = pSEPlot:GetY()

		for i, direction in ipairs(tDirectionsBottomRight) do
			local pAdjacentPlot = Map.PlotDirection(iSEX, iSEY, direction)

			if pAdjacentPlot == nil then return false end
			
			if pAdjacentPlot:GetPlotType() ~= ePlotOcean  then
				iNumLandSE = iNumLandSE + 1
			end
		end

		local iSWX = pSWPlot:GetX()
		local iSWY = pSWPlot:GetY()

		for i, direction in ipairs(tDirectionsBottomLeft) do
			local pAdjacentPlot = Map.PlotDirection(iSWX, iSWY, direction)

			if pAdjacentPlot == nil then return false end
			
			if pAdjacentPlot:GetPlotType() ~= ePlotOcean then
				iNumLandSW = iNumLandSW + 1
			end
		end
		
		if iNumLandN < 1 or iNumLandSE < 1 or iNumLandSW < 1 then return false end

		local iNumLandSum = iNumLandN + iNumLandSE + iNumLandSW
		
		if iNumLandSum < 3 or iNumLandSum > 4 then return false end
		
		return true
	elseif method_number == 13 then
		-- reserved: Dallol
	elseif method_number == 14 then
		-- BIOLUMINESCENT BAY
		local pPlot = Map.GetPlot(x, y)
		
		if pPlot == nil then return false end
		if pPlot:IsWater() == false then return false end
		if pPlot:IsLake() then return false end
		if pPlot:GetTerrainType() ~= eTerrainCoast then return false end
		
		local iNumCoast, iNumJungle, iNumGrass = 0, 0, 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot == nil then return false end
		
			local sAdjacentPlotType = pAdjacentPlot:GetPlotType()
			local sAdjacentFeatureType = pAdjacentPlot:GetFeatureType()
			
			if sAdjacentPlotType ~= ePlotOcean then
				if sAdjacentFeatureType == eFeatureJungle then
					iNumJungle = iNumJungle + 1
				end
			else
				iNumCoast = iNumCoast + 1
			end
		end
		
		if iNumCoast < 1 or iNumCoast > 2 or iNumJungle < 2 then return false end
		
		return true
	elseif method_number == 15 then
		-- reserved: Mt. Paektu
	elseif method_number == 16 then
		-- reserved: Uluru
	elseif method_number == 17 then
		-- reserved: Barringer
	elseif method_number == 18 then
		-- reserved: Old Faithful
	elseif method_number == 100 then
		-- dummy
		return false
	else
		-- unidentified method number;
		return false
	end
end
------------------------------------------------------------------------------
function NWCustomPlacement(x, y, row_number, method_number)
	local ePlotOcean = PlotTypes.PLOT_OCEAN
	local ePlotFlat = PlotTypes.PLOT_LAND
	local ePlotHill = PlotTypes.PLOT_HILLS
	local ePlotMountain = PlotTypes.PLOT_MOUNTAIN
	local eTerrainCoast = TerrainTypes.TERRAIN_COAST
	local eTerrainGrass = TerrainTypes.TERRAIN_GRASS	
	local eTerrainPlains = TerrainTypes.TERRAIN_PLAINS
	local eTerrainDesert = TerrainTypes.TERRAIN_DESERT
	local eTerrainTundra = TerrainTypes.TERRAIN_TUNDRA
	local eTerrainSnow = TerrainTypes.TERRAIN_SNOW
	local eTerrainMountain = TerrainTypes.TERRAIN_MOUNTAIN
	local eFeatureNo = FeatureTypes.NO_FEATURE
	local eFeatureForest = FeatureTypes.FEATURE_FOREST
	local eFeatureJungle = FeatureTypes.FEATURE_JUNGLE
	local eFeatureAtoll = GameInfoTypes.FEATURE_ATOLL
	local eResourceCoral = GameInfoTypes.RESOURCE_CORAL
	local eResourceTropicalFish = GameInfoTypes.RESOURCE_TROPICAL_FISH

	local tDirectionTypes = {
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_NORTHWEST
	}

	local tDirectionsTop = {
		DirectionTypes.DIRECTION_NORTHWEST,
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_EAST
	}
	local tDirectionsBottomRight = {
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST
	}
	local tDirectionsBottomLeft = {
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST
	}
	
	local eDirW = DirectionTypes.DIRECTION_WEST
	local eDirNE = DirectionTypes.DIRECTION_NORTHEAST
	local eDirNW = DirectionTypes.DIRECTION_NORTHWEST
	local eDirE = DirectionTypes.DIRECTION_EAST
	local eDirSE = DirectionTypes.DIRECTION_SOUTHEAST
	local eDirSW = DirectionTypes.DIRECTION_SOUTHWEST

	local eFlowN = FlowDirectionTypes.FLOWDIRECTION_NORTH
	local eFlowNE = FlowDirectionTypes.FLOWDIRECTION_NORTHEAST
	local eFlowNW = FlowDirectionTypes.FLOWDIRECTION_NORTHWEST
	local eFlowS = FlowDirectionTypes.FLOWDIRECTION_SOUTH
	local eFlowSE = FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST
	local eFlowSW = FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST

	local iW, iH = Map.GetGridSize()
	
	print("NWCP", method_number, x, y)
	if method_number == 1 then
		-- GREAT BARRIER REEF
		-- Totally new method;
		-- Randomizer chooses one of main 3 directions: E-W, NE-SW, NW-SE;
		local iMainDirectionA = math.random(3)
		local iMainDirectionB = iMainDirectionA + 3
		local pMainPlot = Map.GetPlot(x, y)
		
		if pMainPlot:GetTerrainType() ~= eTerrainCoast then
			pMainPlot:SetTerrainType(eTerrainCoast, false, false)
		end
		
		local tDirectionsNE = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_NORTHWEST
		}
		local tDirectionsE = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_NORTHEAST
		}
		local tDirectionsSE = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST
		}
		local tDirectionsSW = {
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_SOUTHEAST
		}
		local tDirectionsW = {
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST,
			DirectionTypes.DIRECTION_SOUTHWEST
		}
		local tDirectionsNW = {
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST,
			DirectionTypes.DIRECTION_NORTHEAST
		}
		
		local tSubDirections = {
			tDirectionsNE,
			tDirectionsE,
			tDirectionsSE,
			tDirectionsSW,
			tDirectionsW,
			tDirectionsNW
		}

		local tPossibleFeaturesOrResources = {}
		local iNumFeaturesOrResources = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetTerrainType() ~= eTerrainCoast then
				pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
			end

			if pAdjacentPlot:GetFeatureType() == eFeatureNo and pAdjacentPlot:GetResourceType() == -1 
				and i ~= iMainDirectionA and i ~= iMainDirectionB then
				table.insert(tPossibleFeaturesOrResources, pAdjacentPlot)
			else
				iNumFeaturesOrResources = iNumFeaturesOrResources + 1
			end

			-- setting REEF
			if i == iMainDirectionA or i == iMainDirectionB then
				local iX = pAdjacentPlot:GetX()
				local iY = pAdjacentPlot:GetY()

				for j, subdirection in ipairs(tSubDirections[i]) do
					local pDistantPlot = Map.PlotDirection(iX, iY, subdirection)

					if pDistantPlot:GetTerrainType() ~= eTerrainCoast then
						pDistantPlot:SetTerrainType(eTerrainCoast, false, false)
					end

					if pDistantPlot:GetFeatureType() == eFeatureNo and pDistantPlot:GetResourceType() == -1 then
						table.insert(tPossibleFeaturesOrResources, pDistantPlot)
					else
						iNumFeaturesOrResources = iNumFeaturesOrResources + 1
					end

					if i == iMainDirectionA then
						pAdjacentPlot:SetFeatureType(GameInfoTypes.FEATURE_NEW_REEF_B)
					elseif i == iMainDirectionB then
						pAdjacentPlot:SetFeatureType(GameInfoTypes.FEATURE_NEW_REEF_C)
					end
				end
			end
		end
		
		local pRandomPlot
		local iRandomNumber
		
		iNumFeaturesOrResources = iNumFeaturesOrResources - 2 -- correction factor for GBR plots counted in
		
		if #tPossibleFeaturesOrResources > 0 then
			repeat
				pRandomPlot = table.remove(tPossibleFeaturesOrResources, math.random(#tPossibleFeaturesOrResources))
				iRandomNumber = math.random(10)
				
				if iRandomNumber == 1 then
					pRandomPlot:SetFeatureType(eFeatureAtoll)
				elseif iRandomNumber >= 2 and iRandomNumber <= 3 then
					pRandomPlot:SetPlotType(ePlotFlat, false, false)
					pRandomPlot:SetTerrainType(eTerrainGrass, false, false)
					pRandomPlot:SetFeatureType(eFeatureJungle)
				elseif iRandomNumber >= 4 and iRandomNumber <= 6 then
					pRandomPlot:SetResourceType(eResourceCoral, 1)
				else
					pRandomPlot:SetResourceType(eResourceTropicalFish, 1)
				end

				iNumFeaturesOrResources = iNumFeaturesOrResources + 1
			until(iNumFeaturesOrResources >= 5 or #tPossibleFeaturesOrResources == 0)
		end

		-- MOD: This second plot of the Reef was missing impact values. This would cause resources to spawn on top of it sometimes.
		--[[ MOD: I don't know how to get this to work yet within this file.  I can fix it in the main AssignStartingPlots file, but I don't want to include the whole thing in this mod.--]]
		--[[AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 1, 1)		-- Strategic layer
		AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 2, 1)		-- Luxury layer
		AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 3, 1)		-- Bonus layer--]]
	elseif method_number == 2 then
		-- ROCK OF GIBRALTAR
		-- MOD: Removed Mountain change;
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotHill, false, false)
		pPlot:SetTerrainType(eTerrainPlains, false, false)
		
		-- setting Coast around
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotOcean then
				pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
			end
		end
	elseif method_number == 3 then
		-- KRAKATOA
		local pPlot = Map.GetPlot(x, y)
		local tAdjacentPlots, tPotentialLand = {}, {}

		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainGrass, false, false)
		table.insert(tAdjacentPlots, pPlot)

		-- setting up Coasts around
		local pAdjacentPlot

		for i, direction in ipairs(tDirectionTypes) do
			pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			pAdjacentPlot:SetPlotType(ePlotOcean, false, false)
			pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
			table.insert(tAdjacentPlots, pAdjacentPlot)
		end

		-- setting up few random islands
		for i, direction in ipairs(tDirectionTypes) do
			pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			for i, direction in ipairs(tDirectionTypes) do
				local pDistantPlot = Map.PlotDirection(pAdjacentPlot:GetX(), pAdjacentPlot:GetY(), direction)
				local bIsNearKrakatoa = false

				for i, plot in ipairs(tAdjacentPlots) do
					if plot == pDistantPlot then
						bIsNearKrakatoa = true
						break
					end
				end

				if not bIsNearKrakatoa then
					local bIsAlreadyInTable = false

					for i, potentialPlot in ipairs(tPotentialLand) do
						if potentialPlot == pDistantPlot then
							bIsAlreadyInTable = true
							break
						end
					end

					if not bIsAlreadyInTable then
						if not pDistantPlot:IsAdjacentToLand() and pDistantPlot:GetPlotType() == ePlotOcean and pDistantPlot:GetFeatureType() == eFeatureNo and pDistantPlot:GetResourceType() == -1 then
							table.insert(tPotentialLand, pDistantPlot)
						end
					end
				end
			end
		end

		local pChosenPlot
		local iIslands = 0
		local iIslandsToPlace = 3

		repeat
			pChosenPlot = table.remove(tPotentialLand, math.random(#tPotentialLand))
			pChosenPlot:SetPlotType(ePlotHill, false, false)
			pChosenPlot:SetTerrainType(eTerrainGrass, false, false)
			
			iIslands = iIslands + 1
		until(iIslands >= iIslandsToPlace or #tPotentialLand == 0)
	elseif method_number == 4 then
		-- LAKE VICTORIA
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotOcean, false, false)
		pPlot:SetTerrainType(eTerrainCoast, false, false)
	elseif method_number == 5 then
		-- GIANT'S CAUSEWAY
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotOcean, false, false)
		pPlot:SetTerrainType(eTerrainCoast, false, false)
		
		-- finding suitable places for CAUSEWAY
		local tPossibleSpots = {}
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotOcean then
				pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
			else
				table.insert(tPossibleSpots, pAdjacentPlot)
			end
		end
		
		pChosenPlot = table.remove(tPossibleSpots, math.random(#tPossibleSpots))
		pChosenPlot:SetPlotType(ePlotFlat, false, false)
		pChosenPlot:SetTerrainType(eTerrainTundra, false, false)
		pChosenPlot:SetFeatureType(GameInfoTypes.FEATURE_CAUSEWAY_B)
	elseif method_number == 6 then
		-- SALAR DE UYUNI
		local pPlot = Map.GetPlot(x, y)

		pPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainDesert, false, false)
		
		local iRandomMountain, iRandomOasis

		-- making Desert and cleaning Features and Hills around
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			pAdjacentPlot:SetTerrainType(eTerrainDesert, false, false)
			
			if pAdjacentPlot:GetPlotType() == ePlotHill then
				iRandomMountain = math.random(4)
				
				if iRandomMountain ~= 1 then
					pAdjacentPlot:SetPlotType(ePlotMountain, false, false)
				end
				
				pAdjacentPlot:SetFeatureType(eFeatureNo)
			elseif pAdjacentPlot:GetPlotType() == ePlotFlat then
				iRandomOasis = math.random(4)
				
				if iRandomOasis == 1 then
					pAdjacentPlot:SetFeatureType(eFeatureOasis)
				else
					pAdjacentPlot:SetFeatureType(eFeatureNo)
				end
			end	
		end

		-- finding suitable places for SALAR
		local tPossibleSpots = {}
		local pAdjacentPlot

		-- 4 loops to check the hardest condition first
		for j = 1, 4 do
			for i, direction in ipairs(tDirectionTypes) do
				pAdjacentPlot = Map.PlotDirection(x, y, direction)

				if j == 1 then
					if not pAdjacentPlot:IsAdjacentToShallowWater() and not pAdjacentPlot:IsRiver() then
						table.insert(tPossibleSpots, pAdjacentPlot)
					end
				elseif j == 2 then
					if not pAdjacentPlot:IsAdjacentToShallowWater() then	
						table.insert(tPossibleSpots, pAdjacentPlot)
					end
				elseif j == 3 then
					if not pAdjacentPlot:IsRiver() then	
						table.insert(tPossibleSpots, pAdjacentPlot)
					end
				elseif j == 4 then
					table.insert(tPossibleSpots, pAdjacentPlot)
				end		
			end
			print("Possible spots for Salar", "iteration #", j, "Spots:", #tPossibleSpots)
			if #tPossibleSpots > 0 then break end
		end
		
		-- choosing plot for SALAR
		pChosenPlot = table.remove(tPossibleSpots, math.random(#tPossibleSpots))

		local pChosenPlotX = pChosenPlot:GetX()
		local pChosenPlotY = pChosenPlot:GetY()

		-- cleaning up Hills and Features and setting up Desert
		for j, subdirection in ipairs(tDirectionTypes) do
			local pSecondAdjacentPlot = Map.PlotDirection(pChosenPlotX, pChosenPlotY, subdirection)
			
			pSecondAdjacentPlot:SetTerrainType(eTerrainDesert, false, false)
	
			if pSecondAdjacentPlot:GetFeatureType() ~= GameInfoTypes.FEATURE_SALAR_A then
				if pSecondAdjacentPlot:GetPlotType() == ePlotHill then
					iRandomMountain = math.random(2)

					if iRandomMountain ~= 1 then
						pSecondAdjacentPlot:SetPlotType(ePlotMountain, false, false)
					end
				elseif pAdjacentPlot:GetPlotType() == ePlotFlat or pAdjacentPlot:GetPlotType() == ePlotOcean then
					pSecondAdjacentPlot:SetPlotType(ePlotFlat, false, false)
					iRandomOasis = math.random(3)

					if iRandomOasis == 1 then
						pSecondAdjacentPlot:SetFeatureType(eFeatureOasis)
					else
						pSecondAdjacentPlot:SetFeatureType(eFeatureNo)
					end
				end	
			end
		end				

		pChosenPlot:SetPlotType(ePlotFlat, false, false)	
		pChosenPlot:SetFeatureType(GameInfoTypes.FEATURE_SALAR_B)
	elseif method_number == 7 then
		-- MT. KAILASH
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainTundra, false, false)
		
		-- making Mountains and Tundra around
		local iNumMountains = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotMountain then
				iNumMountains = iNumMountains + 1
			end	
		end

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if (pAdjacentPlot:GetPlotType() == ePlotHill or pAdjacentPlot:GetPlotType() == ePlotFlat) and iNumMountains < 3 then
				pAdjacentPlot:SetPlotType(ePlotMountain, false, false)
				iNumMountains = iNumMountains + 1
			end	
			
			if pAdjacentPlot:GetTerrainType() == eTerrainDesert or pAdjacentPlot:GetTerrainType() == eTerrainGrass then
				pAdjacentPlot:SetTerrainType(eTerrainTundra, false, false)
			end
		end
	elseif method_number == 8 then
		-- SRI PADA
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainGrass, false, false)
		
		-- making Grass around
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			pAdjacentPlot:SetTerrainType(eTerrainGrass, false, false)
		end
	elseif method_number == 9 then
		-- MT. EVEREST
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainSnow, false, false)
		
		-- creating Mountains around
		local iNumMountains = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotMountain then
				iNumMountains = iNumMountains + 1
			end	
		end

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if (pAdjacentPlot:GetPlotType() == ePlotHill or pAdjacentPlot:GetPlotType() == ePlotFlat) and iNumMountains < 4 then
				pAdjacentPlot:SetPlotType(ePlotMountain, false, false)
				iNumMountains = iNumMountains + 1
			end	
			
			if pAdjacentPlot:GetTerrainType() == eTerrainGrass then
				pAdjacentPlot:SetTerrainType(eTerrainTundra, false, false)
			end

			if pAdjacentPlot:GetTerrainType() == eTerrainDesert or pAdjacentPlot:GetTerrainType() == eTerrainPlains then
				pAdjacentPlot:SetTerrainType(eTerrainSnow, false, false)
			end
		end
	elseif method_number == 10 then
		-- LAKE RETBA
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainPlains, false, false)

		-- setting up Plains around and cleaning Forests and Jungles
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if pAdjacentPlot:GetPlotType() ~= ePlotOcean then
				pAdjacentPlot:SetTerrainType(eTerrainPlains, false, false)
				
				if pAdjacentPlot:GetFeatureType() == eFeatureForest or pAdjacentPlot:GetFeatureType() == eFeatureJungle then
					pAdjacentPlot:SetFeatureType(eFeatureNo)
				end
			end
		end
	elseif method_number == 11 then
		-- EYE OF THE SAHARA
		local pPlot = Map.GetPlot(x, y)
		local pSEPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHEAST)
		local pSWPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHWEST)

		pPlot:SetPlotType(ePlotFlat, false, false)
		pSEPlot:SetPlotType(ePlotFlat, false, false)
		pSWPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainDesert, false, false)
		pSEPlot:SetTerrainType(eTerrainDesert, false, false)
		pSWPlot:SetTerrainType(eTerrainDesert, false, false)

		pSEPlot:SetFeatureType(GameInfoTypes.FEATURE_EYE_OF_SAHARA_B)
		pSWPlot:SetFeatureType(GameInfoTypes.FEATURE_EYE_OF_SAHARA_C)

		-- setting up additional Mountains around
		local tPossibleMountains = {}
		local iNumberMountains = 0
		local pAdjacentPlot

		for i, direction in ipairs(tDirectionsTop) do
			pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetFeatureType() ~= eFeatureNo then
				table.insert(tPossibleMountains, pAdjacentPlot)
			end

			if pAdjacentPlot:GetPlotType() == ePlotMountain then
				iNumberMountains = iNumberMountains + 1
			end
		end

		local iSEX = pSEPlot:GetX()
		local iSEY = pSEPlot:GetY()

		for i, direction in ipairs(tDirectionsBottomRight) do
			pAdjacentPlot = Map.PlotDirection(iSEX, iSEY, direction)
			
			if pAdjacentPlot:GetFeatureType() ~= eFeatureNo then
				table.insert(tPossibleMountains, pAdjacentPlot)
			end

			if pAdjacentPlot:GetPlotType() == ePlotMountain then
				iNumberMountains = iNumberMountains + 1
			end
		end

		local iSWX = pSWPlot:GetX()
		local iSWY = pSWPlot:GetY()

		for i, direction in ipairs(tDirectionsBottomLeft) do
			pAdjacentPlot = Map.PlotDirection(iSWX, iSWY, direction)
			
			if pAdjacentPlot:GetFeatureType() ~= eFeatureNo then
				table.insert(tPossibleMountains, pAdjacentPlot)
			end

			if pAdjacentPlot:GetPlotType() == ePlotMountain then
				iNumberMountains = iNumberMountains + 1
			end
		end

		local pChosenPlot

		repeat
			if iNumberMountains < 2 then
				pChosenPlot = table.remove(tPossibleMountains, math.random(#tPossibleMountains))
				pChosenPlot:SetPlotType(ePlotMountain, false, false)

				iNumberMountains = iNumberMountains + 1
			end
		until(iNumberMountains >= 2 or #tPossibleMountains == 0)
	elseif method_number == 12 then
		-- BERMUDA TRIANGLE
		local pPlot = Map.GetPlot(x, y)
		local pSEPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHEAST)
		local pSWPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHWEST)

		pPlot:SetTerrainType(eTerrainCoast, false, false)
		pSEPlot:SetTerrainType(eTerrainCoast, false, false)
		pSWPlot:SetTerrainType(eTerrainCoast, false, false)

		pSEPlot:SetFeatureType(GameInfoTypes.FEATURE_BERMUDA_B)
		pSWPlot:SetFeatureType(GameInfoTypes.FEATURE_BERMUDA_C)
	elseif method_number == 13 then
		-- DALLOL
		local pPlot = Map.GetPlot(x, y)

		pPlot:SetTerrainType(eTerrainDesert, false, false)

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			-- cleaning all features around
			pAdjacentPlot:SetTerrainType(eTerrainDesert, false, false)
			pAdjacentPlot:SetFeatureType(eFeatureNo)
		end
	elseif method_number == 14 then
		-- BIOLUMINESCENT BAY
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			local pAdjacentTerrainType = pAdjacentPlot:GetTerrainType()

			-- making Grass on all lands around
			if pAdjacentPlot:GetPlotType() ~= ePlotOcean then
				pAdjacentPlot:SetTerrainType(eTerrainGrass, false, false)
			end
		end
	elseif method_number == 15 then
		-- MT. PAEKTU
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainTundra, false, false)

		local pNEPlot = Map.PlotDirection(x, y, eDirNE)
		local pNWPlot = Map.PlotDirection(x, y, eDirNW)
		local pWPlot = Map.PlotDirection(x, y, eDirW)
		
		-- creating 3 random Rivers with start around MT. PAEKTU
		local iRandomRiverTurn, iCase
		local bIsMetRiver = false
		local bIsMetSeaOrLake = false
		local bIsEndOfTheMap = false
		local pCurrentPlot, pSupportPlot, pUltraSupportPlot
		local iNormalCorrection = -4 -- to even out chances for CW and CCW movement (depends on math.random values inside)
		local iNormalCorrectionToMathRandom = math.abs(iNormalCorrection) * 2
		local iHandicapCorrection = 2 -- for some preferred direction choices
		local iAdditionalOneWayCorrection = 0 -- negative values for constant CW choices, and positive values for CCW choices (to prevent spiraling)
		
		-- NORTH RIVER (SONGHUA)
		pNWPlot:SetWOfRiver(true, eFlowN)
		
		pCurrentPlot = Map.PlotDirection(pNWPlot:GetX(), pNWPlot:GetY(), eDirNE)
		pSupportPlot = nil
		pUltraSupportPlot = nil

		iCase = 1

		repeat
			if iCase == 1 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsNWOfRiver() or pCurrentPlot:IsNEOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 6
						
						pCurrentPlot:SetNEOfRiver(true, eFlowNW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A1")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 2
						
						pCurrentPlot:SetNWOfRiver(true, eFlowNE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A2")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end
			elseif iCase == 2 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsNEOfRiver() or pSupportPlot:IsWOfRiver() then	bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn - iHandicapCorrection <= 0 then
						iCase = 1
						
						pSupportPlot:SetWOfRiver(true, eFlowN)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A3")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 3
						
						pCurrentPlot:SetNEOfRiver(true, eFlowSE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A4")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end		
			elseif iCase == 3 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pSupportPlot:IsNWOfRiver() or pUltraSupportPlot:IsWOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn - iHandicapCorrection <= 0 then
						iCase = 2
						
						pSupportPlot:SetNWOfRiver(true, eFlowNE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A5")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 4
						
						pUltraSupportPlot:SetWOfRiver(true, eFlowS)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSW)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A6")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 4 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pSupportPlot:IsNEOfRiver() or pUltraSupportPlot:IsNWOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 3
						
						pSupportPlot:SetNEOfRiver(true, eFlowSE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A7")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 5
						
						pUltraSupportPlot:SetNWOfRiver(true, eFlowSW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A8")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 5 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsWOfRiver() or pSupportPlot:IsNEOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 4
						
						pCurrentPlot:SetWOfRiver(true, eFlowS)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A9")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn + iHandicapCorrection > 0 then
						iCase = 6
						
						pSupportPlot:SetNEOfRiver(true, eFlowNW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A10")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 6 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsWOfRiver() or pCurrentPlot:IsNWOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 5
						
						pCurrentPlot:SetNWOfRiver(true, eFlowSW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSW)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A11")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn + iHandicapCorrection > 0 then
						iCase = 1
						
						pCurrentPlot:SetWOfRiver(true, eFlowN)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map A12")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			end
		until(bIsMetSeaOrLake or bIsMetRiver or bIsEndOfTheMap)
		
		-- NORTHEAST RIVER (TUMEN)
		bIsMetRiver = false
		bIsMetSeaOrLake = false
		iAdditionalOneWayCorrection = 0

		pNEPlot:SetNWOfRiver(true, eFlowNE)
		
		pCurrentPlot = Map.PlotDirection(pNEPlot:GetX(), pNEPlot:GetY(), eDirE)
		pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
		pUltraSupportPlot = nil
		
		iCase = 2

		repeat
			if iCase == 1 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsNWOfRiver() or pCurrentPlot:IsNEOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 6
						
						pCurrentPlot:SetNEOfRiver(true, eFlowNW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B1")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn + iHandicapCorrection > 0 then
						iCase = 2
						
						pCurrentPlot:SetNWOfRiver(true, eFlowNE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B2")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 2 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsNEOfRiver() or pSupportPlot:IsWOfRiver() then	bIsMetRiver = true end
				
				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 1
						
						pSupportPlot:SetWOfRiver(true, eFlowN)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B3")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn + iHandicapCorrection > 0 then
						iCase = 3
						
						pCurrentPlot:SetNEOfRiver(true, eFlowSE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B4")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end		
			elseif iCase == 3 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pSupportPlot:IsNWOfRiver() or pUltraSupportPlot:IsWOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn - iHandicapCorrection <= 0 then
						iCase = 2
						
						pSupportPlot:SetNWOfRiver(true, eFlowNE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B5")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 4
						
						pUltraSupportPlot:SetWOfRiver(true, eFlowS)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSW)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B6")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 4 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pSupportPlot:IsNEOfRiver() or pUltraSupportPlot:IsNWOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn - iHandicapCorrection <= 0 then
						iCase = 3
						
						pSupportPlot:SetNEOfRiver(true, eFlowSE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B7")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 5
						
						pUltraSupportPlot:SetNWOfRiver(true, eFlowSW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B8")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 5 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsWOfRiver() or pSupportPlot:IsNEOfRiver() then bIsMetRiver = true end
				
				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 4
						
						pCurrentPlot:SetWOfRiver(true, eFlowS)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B9")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 6
						
						pSupportPlot:SetNEOfRiver(true, eFlowNW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B10")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 6 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsWOfRiver() or pCurrentPlot:IsNWOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 5
						
						pCurrentPlot:SetNWOfRiver(true, eFlowSW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSW)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B11")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 1
						
						pCurrentPlot:SetWOfRiver(true, eFlowN)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map B12")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			end
		until(bIsMetSeaOrLake or bIsMetRiver or bIsEndOfTheMap)
		
		-- SOUTHWEST RIVER (YALU)
		bIsMetRiver = false
		bIsMetSeaOrLake = false
		iAdditionalOneWayCorrection = 0

		pWPlot:SetNWOfRiver(true, eFlowSW)

		pCurrentPlot = Map.PlotDirection(pWPlot:GetX(), pWPlot:GetY(), eDirSW)
		pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
		pUltraSupportPlot = nil

		iCase = 5

		repeat
			if iCase == 1 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsNWOfRiver() or pCurrentPlot:IsNEOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn - iHandicapCorrection <= 0 then
						iCase = 6
						
						pCurrentPlot:SetNEOfRiver(true, eFlowNW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C1")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 2
						
						pCurrentPlot:SetNWOfRiver(true, eFlowNE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C2")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 2 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsNEOfRiver() or pSupportPlot:IsWOfRiver() then	bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 1
						
						pSupportPlot:SetWOfRiver(true, eFlowN)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C3")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 3
						
						pCurrentPlot:SetNEOfRiver(true, eFlowSE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C4")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end		
			elseif iCase == 3 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pSupportPlot:IsNWOfRiver() or pUltraSupportPlot:IsWOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 2
						
						pSupportPlot:SetNWOfRiver(true, eFlowNE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C5")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn + iHandicapCorrection > 0 then
						iCase = 4
						
						pUltraSupportPlot:SetWOfRiver(true, eFlowS)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSW)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C6")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 4 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pSupportPlot:IsNEOfRiver() or pUltraSupportPlot:IsNWOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 3
						
						pSupportPlot:SetNEOfRiver(true, eFlowSE)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C7")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn + iHandicapCorrection > 0 then
						iCase = 5
						
						pUltraSupportPlot:SetNWOfRiver(true, eFlowSW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirW)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C8")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 5 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsWOfRiver() or pSupportPlot:IsNEOfRiver() then bIsMetRiver = true end
				
				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn <= 0 then
						iCase = 4
						
						pCurrentPlot:SetWOfRiver(true, eFlowS)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSE)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)

						if pCurrentPlot == nil or pSupportPlot == nil or pUltraSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C9")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 6
						
						pSupportPlot:SetNEOfRiver(true, eFlowNW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNW)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C10")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			elseif iCase == 6 then
				if pCurrentPlot:GetPlotType() == ePlotOcean then bIsMetSeaOrLake = true	end
				if pCurrentPlot:IsWOfRiver() or pCurrentPlot:IsNWOfRiver() then bIsMetRiver = true end

				if not bIsMetSeaOrLake and not bIsMetRiver then
					iRandomRiverTurn = math.random(iNormalCorrectionToMathRandom) + iNormalCorrection + iAdditionalOneWayCorrection
					
					if iRandomRiverTurn - iHandicapCorrection <= 0 then
						iCase = 5
						
						pCurrentPlot:SetNWOfRiver(true, eFlowSW)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirSW)
						pSupportPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pUltraSupportPlot = nil

						if pCurrentPlot == nil or pSupportPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C11")
						end

						if iAdditionalOneWayCorrection >= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection + 1
						else
							iAdditionalOneWayCorrection = 0
						end
					elseif iRandomRiverTurn > 0 then
						iCase = 1
						
						pCurrentPlot:SetWOfRiver(true, eFlowN)
						
						pCurrentPlot = Map.PlotDirection(pCurrentPlot:GetX(), pCurrentPlot:GetY(), eDirNE)
						pSupportPlot = nil
						pUltraSupportPlot = nil

						if pCurrentPlot == nil then
							bIsEndOfTheMap = true
							print("Paketu river at the end of the map C12")
						end

						if iAdditionalOneWayCorrection <= 0 then
							iAdditionalOneWayCorrection = iAdditionalOneWayCorrection - 1
						else
							iAdditionalOneWayCorrection = 0
						end
					end
				end	
			end
		until(bIsMetSeaOrLake or bIsMetRiver or bIsEndOfTheMap)
	elseif method_number == 16 then
		-- ULURU
		local tPlotsWithFeatures = {}
		local iFeatures = 0
		local pChosenPlot
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			-- checking features
			if pAdjacentPlot:GetFeatureType() ~= eFeatureNo then
				table.insert(tPlotsWithFeatures, pAdjacentPlot)
				iFeatures = iFeatures + 1
			end
			
			-- setting flat
			pAdjacentPlot:SetPlotType(ePlotFlat, false, false)
		end
		
		-- deleting features
		repeat
			if #tPlotsWithFeatures <= 1 then break end
			pChosenPlot = table.remove(tPlotsWithFeatures, math.random(#tPlotsWithFeatures))
			pChosenPlot:SetFeatureType(eFeatureNo)
			iFeatures = iFeatures - 1
		until(iFeatures <= 1)
	elseif method_number == 17 then
		-- BARRINGER CRATER
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			-- setting flat
			pAdjacentPlot:SetPlotType(ePlotFlat, false, false)
		end
	elseif method_number == 18 then
		-- OLD FAITHFUL
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotHill, false, false)
	end
end
------------------------------------------------------------------------------
