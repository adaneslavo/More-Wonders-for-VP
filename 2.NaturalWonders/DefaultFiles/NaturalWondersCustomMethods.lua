-- NaturalWondersCustomMethods.lua
-- Author: Leo
-- DateCreated: 3/13/2016 9:58:45 AM
--------------------------------------------------------------
------------------------------------------------------------------------------
--	MODDER:   Barathor
--  THANKS:	  whoward69
--  MODDER2	  adan_eslavo
------------------------------------------------------------------------------
-- MOD: * Great Barrier Reef (1):	3-tile wonder (in-line, any direction); much closer to land; surrounded by coast;
--		* Rock of Gibraltar (2):	one land adjacent (preferred flat grass);
--		* Krakatoa (3):				near islands and smaller landmasses;
--		* Lake Victoria (4):		looks for a river surrounded by bunch of hills and mountains;
--		* Giant's Causeway (5):		custom method similar to Rock of Gibraltar; prefers tundra;
--		* Salar de Uyuni (6):		has only tile changes method; flattens, clears features and changes adjacent tiles to desert; 2-tiles;
--		* Mt. Kailash (7):			has only tile changes method; adds mountains; changes adjacent to tundra;
--		* Sri Pada (8):				has only tile changes method; changes adjacent to grass;
--		* Mt. Everest (9):			has only tile changes method; adds mountains; changes adjacent to tundra or snow;
--		* Lake Retba (10):			plants forest around, and must be on solid terrain with coast;
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

	local tDirectionTypes = {
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_NORTHWEST
	}

	local iW, iH = Map.GetGridSize()

	if method_number == 1 then
		-- Great Barrier Reef
		-- MOD: Now 3 tile wonder - long shape;
		-- MOD: Area checked is better to handle all 3 main directions: E-W, NW-SE, NE-SW;
		-- MOD: All tiles check for any features, nil tiles, lakes;
		-- MOD: GBR tiles check for land (they must be surrounded by water;
		-- MOD: Increased land andcoast limits;

		local pMainPlot = Map.GetPlot(x, y)		
		-- MOD: Latitude to prevent it from spawning in polar regions;
		-- MOD: I prefer symmetrical latitudes, and my map script is generated in this way, which is why the check is split in two below;
		if (y >= (iH/2)) then	
			-- Upper half of map;
			if (math.abs((iH/2) - y)/(iH/2)) > 0.5 then
				return false
			end
		else
			-- Lower half of map;
			if (math.abs((iH/2) - (y + 1))/(iH/2)) > 0.5 then
				return false
			end
		end 

		if pMainPlot == nil then return false end -- MOD: check for no-nil;
		if pMainPlot:GetFeatureType() ~= eFeatureNo then return false end -- MOD: check for no-feature;
		if pMainPlot:IsWater() == false then return false end -- MOD: added this to check to make sure core tile is water so it doesn't trigger land check later;
		if pMainPlot:IsLake() then return false end
		if pMainPlot:IsAdjacentToLand() then return false end -- MOD: want to make sure the core tile isn't and no other GBR tile too;

		-- MOD: We DO care now, otherwise the adjacent land check may just keep adding the center tile if it's land before it's converted;
		local iNumLand, iNumCoast = 0, 0 -- MOD: added iNumLand to check for land two tiles from the reef;
		
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

			if pAdjacentPlot == nil then return false end -- MOD: check for no-nil;
			if pAdjacentPlot:GetFeatureType() ~= eFeatureNo then return false end -- MOD: check for no-feature;
			if pAdjacentPlot:IsAdjacentToLand() then return false end
			
			local iX = pAdjacentPlot:GetX()
			local iY = pAdjacentPlot:GetY()
				
			for j, subdirection in ipairs(tSubdirections[i]) do -- MOD: loop for distant plots checks (plots 2 and more tiles off center);
				local pDistantPlot = Map.PlotDirection(iX, iY, subdirection)

				if pDistantPlot == nil then return false end
				if pDistantPlot:GetFeatureType() ~= eFeatureNo then return false end

				if pDistantPlot:GetTerrainType() == eTerrainCoast then
					iNumCoast = iNumCoast + 1
				end

				if pDistantPlot:IsAdjacentToLand() then	-- MOD: added a check for land;
					iNumLand = iNumLand + 1
				end

			end
		end

		-- if not enough coasts, reject this site;
		-- MOD: If not enough land nearby, reject this site;
		-- MOD: I want it tucked more against the land, not just off the tip of a piece of land branching out;
		-- MOD: Also, 4 doesn't necessarily mean three individual land tiles, since half the time they're double counted. It just ensures it's more than one;
		if iNumCoast < 4 or iNumLand < 5 then return false end

		return true
	elseif method_number == 2 then
		-- Rock of Gibraltar
		
		local pPlot = Map.GetPlot(x, y)
		local sFeatureType = pPlot:GetFeatureType()
		
		if pPlot:IsWater() == false and AdjacentToSaltWater(x, y) == false then return false end
		if sFeatureType ~= eFeatureNo then return false end

		if (y >= (iH/2)) then	
			if (math.abs((iH/2) - y)/(iH/2)) > 0.6 then
				return false
			end
		else
			if (math.abs((iH/2) - (y + 1))/(iH/2)) > 0.6 then
				return false
			end
		end 
		
		local iNumLand, iNumCoast = 0, 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			local sPlotType = pAdjacentPlot:GetPlotType()
			local sFeatureType = pAdjacentPlot:GetFeatureType()
			local sTerrainType = pAdjacentPlot:GetTerrainType()
			
			-- MOD: Don't permit small landmasses especially those single-tile islands!
			-- MOD: Avoid mountains;
			if sPlotType ~= ePlotOcean then
				if pAdjacentPlot:Area():GetNumTiles() < 11 
				or pAdjacentPlot:GetPlotType() == ePlotMountain or pAdjacentPlot:GetPlotType() == ePlotHill
				or (sTerrainType ~= eTerrainDesert and sTerrainType ~= eTerrainPlains)
				or sFeatureType ~= eFeatureNo then return false end
			
				iNumLand = iNumLand + 1
			end

			if sTerrainType == eTerrainCoast and pPlot:IsLake() == false and sFeatureType == eFeatureNo then
				iNumCoast = iNumCoast + 1
			end
		end
		
		if iNumLand ~= 1 or iNumCoast < 5 then return false end

		return true
	elseif method_number == 3 then
		-- MOD: Krakatoa

		local pMainPlot = Map.GetPlot(x, y)
		
		if (y >= (iH/2)) then	
			if (math.abs((iH/2) - y)/(iH/2)) > 0.5 then
				return false
			end
		else
			if (math.abs((iH/2) - (y + 1))/(iH/2)) > 0.5 then
				return false
			end
		end 

		local iNumLand, iNumBigIsland = 0, 0
		
		if pMainPlot == nil then return false end
		if pMainPlot:IsWater() == false then return false end
		if pMainPlot:IsLake() then return false end
		if pMainPlot:GetFeatureType() ~= eFeatureNo then return false end
		if pMainPlot:IsAdjacentToLand() then return false end
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			local iX = pAdjacentPlot:GetX()
			local iY = pAdjacentPlot:GetY()
			
			if pAdjacentPlot == nil then return false end
			if pAdjacentPlot:IsWater() == false then return false end
			if pAdjacentPlot:GetFeatureType() ~= eFeatureNo then return false end

			for j, subdirection in ipairs(tDirectionTypes) do
				local pDistantPlot = Map.PlotDirection(iX, iY, subdirection)
				local sPlotType = pDistantPlot:GetPlotType()
				
				if sPlotType ~= ePlotOcean then
					-- MOD: Don't permit on larger landmasses;
					if pDistantPlot:Area():GetNumTiles() > iH/2 then return false end
					-- MOD: Want it near at least one slightly larger island, not just single-tile islands;
					if pDistantPlot:Area():GetNumTiles() > 3 then
						iNumBigIsland = iNumBigIsland + 1  
					end

					iNumLand = iNumLand + 1
				end
			end
		end
		
		-- MOD: Want it tucked more near the land, not just off the tip of a piece of land branching out;
		if iNumLand < 3 or iNumBigIsland < 1 then return false end

		return true
	elseif method_number == 4 then
		-- MOD: Lake Victoria

		local pMainPlot = Map.GetPlot(x, y)
		
		if pMainPlot == nil then return false end
		if pMainPlot:IsAdjacentToShallowWater() then return false end
		if not pMainPlot:IsRiver() then return false end
		if pMainPlot:GetTerrainType() == eTerrainSnow then return false end
		
		local iNumHillsAndMountains = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetTerrainType() == eTerrainSnow then return false end
			
			local sPlotType = pAdjacentPlot:GetPlotType()

			if sPlotType == ePlotHill or sPlotType == ePlotMountain then
				iNumHillsAndMountains = iNumHillsAndMountains + 1
			end
		end
		
		if iNumHillsAndMountains < 3 then return false end

		return true
	elseif method_number == 5 then
		-- Giant's Causeway

		local pPlot = Map.GetPlot(x, y)
		local sFeatureType = pPlot:GetFeatureType()
		
		if pPlot:IsWater() == false then return false end
		if sFeatureType ~= eFeatureNo then return false end
		
		local iNumLand, iNumCoast = 0, 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			local sPlotType = pAdjacentPlot:GetPlotType()
			local sFeatureType = pAdjacentPlot:GetFeatureType()
			local sTerrainType = pAdjacentPlot:GetTerrainType()
			
			if sPlotType ~= ePlotOcean then
				if pAdjacentPlot:Area():GetNumTiles() < 5 
				or pAdjacentPlot:GetPlotType() ~= ePlotHill
				or sTerrainType ~= eTerrainTundra
				or sFeatureType ~= eFeatureNo then return false end
			
				iNumLand = iNumLand + 1
			end

			if sTerrainType == eTerrainCoast and pPlot:IsLake() == false and sFeatureType == eFeatureNo then
				iNumCoast = iNumCoast + 1
			end
		end
		
		if iNumLand < 1 or iNumLand > 2 or iNumCoast < 3 then return false end
		
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
		-- Lake Retba

		local pMainPlot = Map.GetPlot(x, y)

		if pMainPlot == nil then return false end
		if not pMainPlot:IsAdjacentToShallowWater() then return false end
		if pMainPlot:IsRiver() then return false end
		if pMainPlot:GetTerrainType() ~= eTerrainGrass and pMainPlot:GetTerrainType() ~= eTerrainPlains then return false end

		local bIsHasSeaTiles = false
		local iNumLandTiles = 0

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			local sTerrainType = pAdjacentPlot:GetTerrainType()

			if sTerrainType == eTerrainDesert or sTerrainType == eTerrainTundra or sTerrainType == eTerrainSnow then return false end

			local sPlotType = pAdjacentPlot:GetPlotType()
			
			if sPlotType == ePlotMountain then return false end

			if sPlotType == ePlotOcean then
				if pAdjacentPlot:IsLake() then return false end
				bIsHasSeaTiles = true
			end

			if sPlotType ~= ePlotOcean then
				iNumLandTiles = iNumLandTiles + 1
			end
		end

		if not bIsHasSeaTiles or iNumLandTiles ~= 4 then return false end

		return true
	else
		-- Unidentified Method Number;
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
	local eFeatureNo = FeatureTypes.NO_FEATURE
	local eFeatureForest = FeatureTypes.FEATURE_FOREST

	local tDirectionTypes = {
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_NORTHWEST
	}

	local iW, iH = Map.GetGridSize()
	
	if method_number == 1 then
		-- Great Barrier Reef
		-- Totally new method;
		-- Randomizer chooses one of main 3 directions: E-W, NE-SW, NW-SE;

		iMainDirectionA = math.random(2) + 1
		iMainDirectionB = iMainDirectionA + 3

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

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetTerrainType() ~= eTerrainCoast then
				pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
			end

			if i == iMainDirectionA or i == iMainDirectionB then
				local iX = pAdjacentPlot:GetX()
				local iY = pAdjacentPlot:GetY()

				for j, subdirection in ipairs(tSubDirections[i]) do
					local pDistantPlot = Map.PlotDirection(iX, iY, subdirection)

					if pDistantPlot:GetTerrainType() ~= eTerrainCoast then
						pDistantPlot:SetTerrainType(eTerrainCoast, false, false)
					end

					pAdjacentPlot:SetFeatureType(GameInfoTypes.FEATURE_REEF)
				end
			end
		end
		
		-- MOD: This second plot of the Reef was missing impact values. This would cause resources to spawn on top of it sometimes.
		--[[ MOD: I don't know how to get this to work yet within this file.  I can fix it in the main AssignStartingPlots file, but I don't want to include the whole thing in this mod.--]]
		--[[AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 1, 1)		-- Strategic layer
		AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 2, 1)		-- Luxury layer
		AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 3, 1)		-- Bonus layer--]]
	elseif method_number == 2 then
		-- Rock of Gibraltar
		-- MOD: Removed mountain change;

		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotHill, false, false)
		pPlot:SetTerrainType(eTerrainPlains, false, false)
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotOcean then
				if pAdjacentPlot:GetTerrainType() ~= eTerrainCoast then
					pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
				end
			end
		end
	elseif method_number == 3 then
		-- MOD: Krakatoa
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainGrass, false, false)
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotOcean then
				if pAdjacentPlot:GetTerrainType() ~= eTerrainCoast then
					pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
				end
			end
		end
	elseif method_number == 4 then
		-- MOD: Lake Victoria
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotOcean, false, false)
		pPlot:SetTerrainType(eTerrainCoast, false, false)
	elseif method_number == 5 then
		-- Giant's Causeway
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotOcean, false, false)
		pPlot:SetTerrainType(eTerrainCoast, false, false)
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotOcean then
				if pAdjacentPlot:GetTerrainType() ~= eTerrainCoast then
					pAdjacentPlot:SetTerrainType(eTerrainCoast, false, false)
				end
			end
		end
	elseif method_number == 6 then
		-- Salar de Uyuni
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainDesert, false, false)
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotHill then
				pAdjacentPlot:SetPlotType(ePlotFlat, false, false)
			end	
			
			pAdjacentPlot:SetTerrainType(eTerrainDesert, false, false)
			pAdjacentPlot:SetFeatureType(eFeatureNo)
		end

		local tPossibleSpots = {}
		local pAdjacentPlot

		for i, direction in ipairs(tDirectionTypes) do
			pAdjacentPlot = Map.PlotDirection(x, y, direction)
			
			if pAdjacentPlot:GetPlotType() == ePlotFlat and not pAdjacentPlot:IsAdjacentToShallowWater() and not pAdjacentPlot:IsRiver() then	
				table.insert(tPossibleSpots, pAdjacentPlot)
			end
		end

		pChosenPlot = table.remove(tPossibleSpots, math.random(#tPossibleSpots))
			
		local pChosenPlotX = pChosenPlot:GetX()
		local pChosenPlotY = pChosenPlot:GetY()

		for j, subdirection in ipairs(tDirectionTypes) do
			local pSecondAdjacentPlot = Map.PlotDirection(pChosenPlotX, pChosenPlotY, subdirection)
			
			if pSecondAdjacentPlot:GetPlotType() == ePlotHill then
				pSecondAdjacentPlot:SetPlotType(ePlotFlat, false, false)
			end	
			
			pSecondAdjacentPlot:SetTerrainType(eTerrainDesert, false, false)
					
			if pSecondAdjacentPlot:GetFeatureType() ~= GameInfoTypes.FEATURE_SALAR_A then
				pSecondAdjacentPlot:SetFeatureType(eFeatureNo)
			end
		end				
				
		pChosenPlot:SetFeatureType(GameInfoTypes.FEATURE_SALAR_B)
	elseif method_number == 7 then
		-- Mt. Kailash
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainTundra, false, false)
		
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
		-- Sri Pada
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainGrass, false, false)
		
		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			pAdjacentPlot:SetTerrainType(eTerrainGrass, false, false)
		end
	elseif method_number == 9 then
		-- Mt. Everest
		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotMountain, false, false)
		pPlot:SetTerrainType(eTerrainTundra, false, false)
		
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
		-- Lake Retba

		local pPlot = Map.GetPlot(x, y)
		
		pPlot:SetPlotType(ePlotFlat, false, false)
		pPlot:SetTerrainType(eTerrainPlains, false, false)

		for i, direction in ipairs(tDirectionTypes) do
			local pAdjacentPlot = Map.PlotDirection(x, y, direction)

			if pAdjacentPlot:GetPlotType() ~= ePlotOcean then
				pAdjacentPlot:SetTerrainType(eTerrainPlains, false, false)
				pAdjacentPlot:SetFeatureType(eFeatureForest)
			end
		end
	end
end
------------------------------------------------------------------------------
