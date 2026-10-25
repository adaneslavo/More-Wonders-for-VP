-- Functions replacing default ones from AssignstartingPlots.lua file from VP
-- Author: adan_eslavo
-- DateCreated: 1/1/2024 12:39:17 PM
--------------------------------------------------------------
include("AssignStartingPlots")

function AssignStartingPlots:ExaminePlotForNaturalWondersEligibility(x, y)
	local iW, iH = Map.GetGridSize()
	local iPlotIndex = iW * y + x + 1

	-- adan_eslavo, start	(top and bottom rows are not targetted)
	if (not Map.IsWrapY() and (y == 0 or y == iH - 1)) 
	or (not Map.IsWrapX() and (x == 0 or x == iW - 1)) then
		return false, false
	end
	-- adan_eslavo, end
	
	-- Check for collision with player starts
	if self.impactData[ImpactLayers.LAYER_NATURAL_WONDER][iPlotIndex] > 0 then
		return false, false
	end
	
	-- Must have land in workable range (adan_eslavo: disabled)
	--[[local pPlot = Map.GetPlot(x, y)
	local bHasLand = false
	
	for pNearPlot in Plot_GetPlotsInCircle(pPlot, 1, 3) do
		if pNearPlot:GetPlotType() == PlotTypes.PLOT_LAND then
			bHasLand = true
		end
	end

	if not bHasLand then
		return false, false
	end--]]

	-- adan_eslavo, start	(fertility disabled; was range=3; was 20/28); 
	--						I use different algorithms than Fertility, so it's disabled now (all tiles are taken into account)
	local pPlot = Map.GetPlot(x, y)
	local fFertility = Plot_GetFertilityInRange(pPlot, 1)

	if fFertility < 0 then
		return false, false
	elseif fFertility < 0 then
		return false, true
	end

	return true, true
	-- adan_eslavo, end
end

function AssignStartingPlots:AttemptToPlaceNaturalWonder(kPlacementInfo, tEligibilityList)
	local candidate_plot_list = GetShuffledCopyOfTable(tEligibilityList)
	
	for _, plotIndex in ipairs(candidate_plot_list) do
		if self.impactData[ImpactLayers.LAYER_NATURAL_WONDER][plotIndex] == 0 then
			-- No collision with civ start or other NW, so place wonder here!
			local x, y = GetCoordinatesFromLuaPlotIndex(plotIndex)
			local plot = Map.GetPlot(x, y)

			print("- Placing ".. kPlacementInfo.NaturalWonderType .. " in Plot", x, y)

			-- If called for, force the local terrain to conform to what the wonder needs
			local method_number = kPlacementInfo.TileChangesMethodNumber

			if method_number ~= -1 then
				-- Custom method for tile changes needed by this wonder
				NWCustomPlacement(x, y, kPlacementInfo.ID, method_number)
			else
				-- Check the placement data for any standard type tile changes, execute any that are indicated
				if kPlacementInfo.ChangeCoreTileToMountain then
					plot:SetPlotType(PlotTypes.PLOT_MOUNTAIN, false, false)
				elseif kPlacementInfo.ChangeCoreTileToFlatland then
					plot:SetPlotType(PlotTypes.PLOT_LAND, false, false)
				end

				if kPlacementInfo.ChangeCoreTileTerrainToGrass then
					plot:SetTerrainType(TerrainTypes.TERRAIN_GRASS, false, false)
				elseif kPlacementInfo.ChangeCoreTileTerrainToPlains then
					plot:SetTerrainType(TerrainTypes.TERRAIN_PLAINS, false, false)
				end

				if kPlacementInfo.SetAdjacentTilesToShallowWater then
					for pAdjPlot in Plot_GetPlotsInCircle(plot, 1) do
						pAdjPlot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, false)
					end
				end
			end

			-- Now place this wonder and record the placement
			plot:SetFeatureType(GameInfoTypes[kPlacementInfo.NaturalWonderType])

			-- Natural Wonders shouldn't be too close to each other
			self:PlaceResourceImpact(x, y, ImpactLayers.LAYER_NATURAL_WONDER, 11)

			-- Force no resource on Natural Wonders
			self:PlaceStrategicResourceImpact(x, y, 0);
			self:PlaceResourceImpact(x, y, ImpactLayers.LAYER_LUXURY, 0)
			self:PlaceResourceImpact(x, y, ImpactLayers.LAYER_BONUS, 0)
			self:PlaceResourceImpact(x, y, ImpactLayers.LAYER_FISH, 0)
			self:PlaceResourceImpact(x, y, ImpactLayers.LAYER_MARBLE, 0)
			self:PlaceResourceImpact(x, y, ImpactLayers.LAYER_IVORY, 0)

			-- Keep City States away from Natural Wonders!
			self:PlaceResourceImpact(x, y, ImpactLayers.LAYER_CITY_STATE, 4)

			-- Record exact plot of wonder in the collision list
			self.playerCollisionData[plotIndex] = true

			-- Apply impact values to second and third tile of Natural Wonders
			if kPlacementInfo.NaturalWonderType == "FEATURE_NEW_REEF_A" then
				for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
					local pBarrierPlot = Map.PlotDirection(x, y, i)
					
					if pBarrierPlot:GetFeatureType() == GameInfoTypes.FEATURE_NEW_REEF_B 
					or pBarrierPlot:GetFeatureType() == GameInfoTypes.FEATURE_NEW_REEF_C then	
						local iBarrierX = pBarrierPlot:GetX()
						local iBarrierY = pBarrierPlot:GetY()
					
						self:PlaceStrategicResourceImpact(iBarrierX, iBarrierY, 0)
						
						self:PlaceResourceImpact(iBarrierX, iBarrierY, ImpactLayers.LAYER_LUXURY, 0)
						self:PlaceResourceImpact(iBarrierX, iBarrierY, ImpactLayers.LAYER_BONUS, 0)
						self:PlaceResourceImpact(iBarrierX, iBarrierY, ImpactLayers.LAYER_FISH, 0)
						self:PlaceResourceImpact(iBarrierX, iBarrierY, ImpactLayers.LAYER_MARBLE, 0)
						self:PlaceResourceImpact(iBarrierX, iBarrierY, ImpactLayers.LAYER_IVORY, 0)
					
						local iBarrierPlotIndex = GetLuaPlotIndexFromCoordinates(iBarrierX, iBarrierY)
						
						self.playerCollisionData[iBarrierPlotIndex] = true
					end
				end
			elseif kPlacementInfo.NaturalWonderType == "FEATURE_SALAR_A" then
				for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
					local pSalarPlot = Map.PlotDirection(x, y, i)
					
					if pSalarPlot:GetFeatureType() == GameInfoTypes.FEATURE_SALAR_B then	
						local iSalarX = pSalarPlot:GetX()
						local iSalarY = pSalarPlot:GetY()
					
						self:PlaceStrategicResourceImpact(iSalarX, iSalarY, 0)
						
						self:PlaceResourceImpact(iSalarX, iSalarY, ImpactLayers.LAYER_LUXURY, 0)
						self:PlaceResourceImpact(iSalarX, iSalarY, ImpactLayers.LAYER_BONUS, 0)
						self:PlaceResourceImpact(iSalarX, iSalarY, ImpactLayers.LAYER_FISH, 0)
						self:PlaceResourceImpact(iSalarX, iSalarY, ImpactLayers.LAYER_MARBLE, 0)
						self:PlaceResourceImpact(iSalarX, iSalarY, ImpactLayers.LAYER_IVORY, 0)
					
						local iSalarPlotIndex = GetLuaPlotIndexFromCoordinates(iSalarX, iSalarY)
						
						self.playerCollisionData[iSalarPlotIndex] = true
						break
					end
				end
			elseif kPlacementInfo.NaturalWonderType == "FEATURE_BERMUDA_A" then
				local pBermudaPlotSE = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHEAST)
				local pBermudaPlotSW = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHWEST)
					
				local iBermudaX = pBermudaPlotSE:GetX()
				local iBermudaY = pBermudaPlotSE:GetY()
				
				self:PlaceStrategicResourceImpact(iBermudaX, iBermudaY, 0)
						
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_LUXURY, 0)
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_BONUS, 0)
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_FISH, 0)
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_MARBLE, 0)
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_IVORY, 0)
				
				local iBermudaPlotIndex = GetLuaPlotIndexFromCoordinates(iBermudaX, iBermudaY)
					
				self.playerCollisionData[iBermudaPlotIndex] = true
				
				local iBermudaX = pBermudaPlotSW:GetX()
				local iBermudaY = pBermudaPlotSW:GetY()
				
				self:PlaceStrategicResourceImpact(iBermudaX, iBermudaY, 0);
						
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_LUXURY, 0)
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_BONUS, 0)
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_FISH, 0)
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_MARBLE, 0)
				self:PlaceResourceImpact(iBermudaX, iBermudaY, ImpactLayers.LAYER_IVORY, 0)
				
				local iBermudaPlotIndex = GetLuaPlotIndexFromCoordinates(iBermudaX, iBermudaY)
					
				self.playerCollisionData[iBermudaPlotIndex] = true
			elseif kPlacementInfo.NaturalWonderType == "FEATURE_CAUSEWAY_A" then
				for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
					local pCausewayPlot = Map.PlotDirection(x, y, i)
					
					if pCausewayPlot:GetFeatureType() == GameInfoTypes.FEATURE_CAUSEWAY_B then	
						local iCausewayX = pCausewayPlot:GetX()
						local iCausewayY = pCausewayPlot:GetY()
				
						self:PlaceStrategicResourceImpact(iCausewayX, iCausewayY, 0)
						
						self:PlaceResourceImpact(iCausewayX, iCausewayY, ImpactLayers.LAYER_LUXURY, 0)
						self:PlaceResourceImpact(iCausewayX, iCausewayY, ImpactLayers.LAYER_BONUS, 0)
						self:PlaceResourceImpact(iCausewayX, iCausewayY, ImpactLayers.LAYER_FISH, 0)
						self:PlaceResourceImpact(iCausewayX, iCausewayY, ImpactLayers.LAYER_MARBLE, 0)
						self:PlaceResourceImpact(iCausewayX, iCausewayY, ImpactLayers.LAYER_IVORY, 0)
					
						local iCausewayPlotIndex = GetLuaPlotIndexFromCoordinates(iCausewayX, iCausewayY)
						
						self.playerCollisionData[iCausewayPlotIndex] = true
						break
					end
				end
			elseif kPlacementInfo.NaturalWonderType == "FEATURE_EYE_OF_SAHARA_A" then
				local pEyeOfSaharaPlotSE = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHEAST)
				local pEyeOfSaharaPlotSW = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHWEST)
					
				local iEyeOfSaharaX = pEyeOfSaharaPlotSE:GetX()
				local iEyeOfSaharaY = pEyeOfSaharaPlotSE:GetY()
				
				self:PlaceStrategicResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, 0)
						
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_LUXURY, 0)
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_BONUS, 0)
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_FISH, 0)
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_MARBLE, 0)
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_IVORY, 0)
				
				local iEyeOfSaharaPlotIndex = GetLuaPlotIndexFromCoordinates(iEyeOfSaharaX, iEyeOfSaharaY)
					
				self.playerCollisionData[iEyeOfSaharaPlotIndex] = true
				
				local iEyeOfSaharaX = pEyeOfSaharaPlotSW:GetX()
				local iEyeOfSaharaY = pEyeOfSaharaPlotSW:GetY()
				
				self:PlaceStrategicResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, 0);
						
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_LUXURY, 0)
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_BONUS, 0)
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_FISH, 0)
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_MARBLE, 0)
				self:PlaceResourceImpact(iEyeOfSaharaX, iEyeOfSaharaY, ImpactLayers.LAYER_IVORY, 0)
				
				local iEyeOfSaharaPlotIndex = GetLuaPlotIndexFromCoordinates(iEyeOfSaharaX, iEyeOfSaharaY)
					
				self.playerCollisionData[iEyeOfSaharaPlotIndex] = true
			elseif kPlacementInfo.NaturalWonderType == "FEATURE_GALAPAGOS_A" then
				for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
					local pGalapagosPlot = Map.PlotDirection(x, y, i)
					
					if pGalapagosPlot:GetFeatureType() == GameInfoTypes.FEATURE_GALAPAGOS_B then	
						local iGalapagosX = pGalapagosPlot:GetX()
						local iGalapagosY = pGalapagosPlot:GetY()
					
						self:PlaceStrategicResourceImpact(iGalapagosX, iGalapagosY, 0)
						
						self:PlaceResourceImpact(iGalapagosX, iGalapagosY, ImpactLayers.LAYER_LUXURY, 0)
						self:PlaceResourceImpact(iGalapagosX, iGalapagosY, ImpactLayers.LAYER_BONUS, 0)
						self:PlaceResourceImpact(iGalapagosX, iGalapagosY, ImpactLayers.LAYER_FISH, 0)
						self:PlaceResourceImpact(iGalapagosX, iGalapagosY, ImpactLayers.LAYER_MARBLE, 0)
						self:PlaceResourceImpact(iGalapagosX, iGalapagosY, ImpactLayers.LAYER_IVORY, 0)
					
						local iGalapagosPlotIndex = GetLuaPlotIndexFromCoordinates(iGalapagosX, iGalapagosY)
						
						self.playerCollisionData[iGalapagosPlotIndex] = true
						break
					end
				end
			elseif kPlacementInfo.NaturalWonderType == "FEATURE_HA_LONG_A" then
				for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
					local pHaLongPlot = Map.PlotDirection(x, y, i)
					
					if pHaLongPlot:GetFeatureType() == GameInfoTypes.FEATURE_HA_LONG_B then	
						local iHaLongX = pHaLongPlot:GetX()
						local iHaLongY = pHaLongPlot:GetY()
					
						self:PlaceStrategicResourceImpact(iHaLongX, iHaLongY, 0)
						
						self:PlaceResourceImpact(iHaLongX, iHaLongY, ImpactLayers.LAYER_LUXURY, 0)
						self:PlaceResourceImpact(iHaLongX, iHaLongY, ImpactLayers.LAYER_BONUS, 0)
						self:PlaceResourceImpact(iHaLongX, iHaLongY, ImpactLayers.LAYER_FISH, 0)
						self:PlaceResourceImpact(iHaLongX, iHaLongY, ImpactLayers.LAYER_MARBLE, 0)
						self:PlaceResourceImpact(iHaLongX, iHaLongY, ImpactLayers.LAYER_IVORY, 0)
					
						local iHaLongPlotIndex = GetLuaPlotIndexFromCoordinates(iHaLongX, iHaLongY)
						
						self.playerCollisionData[iHaLongPlotIndex] = true
						break
					end
				end
			elseif kPlacementInfo.NaturalWonderType == "FEATURE_AURORA_A" then
				for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
					local pAuroraPlot = Map.PlotDirection(x, y, i)
					
					if pAuroraPlot:GetFeatureType() == GameInfoTypes.FEATURE_AURORA_B 
					or pAuroraPlot:GetFeatureType() == GameInfoTypes.FEATURE_AURORA_C then	
						local iAuroraX = pAuroraPlot:GetX()
						local iAuroraY = pAuroraPlot:GetY()
					
						self:PlaceStrategicResourceImpact(iAuroraX, iAuroraY, 0)
						
						self:PlaceResourceImpact(iAuroraX, iAuroraY, ImpactLayers.LAYER_LUXURY, 0)
						self:PlaceResourceImpact(iAuroraX, iAuroraY, ImpactLayers.LAYER_BONUS, 0)
						self:PlaceResourceImpact(iAuroraX, iAuroraY, ImpactLayers.LAYER_FISH, 0)
						self:PlaceResourceImpact(iAuroraX, iAuroraY, ImpactLayers.LAYER_MARBLE, 0)
						self:PlaceResourceImpact(iAuroraX, iAuroraY, ImpactLayers.LAYER_IVORY, 0)
					
						local iAuroraPlotIndex = GetLuaPlotIndexFromCoordinates(iAuroraX, iAuroraY)
						
						self.playerCollisionData[iAuroraPlotIndex] = true
					end
				end
			elseif kPlacementInfo.NaturalWonderType == "FEATURE_DANXIA_A" then
				for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
					local pDanxiaPlot = Map.PlotDirection(x, y, i)
					
					if pDanxiaPlot:GetFeatureType() == GameInfoTypes.FEATURE_DANXIA_B then	
						local iDanxiaX = pDanxiaPlot:GetX()
						local iDanxiaY = pDanxiaPlot:GetY()
					
						self:PlaceStrategicResourceImpact(iDanxiaX, iDanxiaY, 0)
						
						self:PlaceResourceImpact(iDanxiaX, iDanxiaY, ImpactLayers.LAYER_LUXURY, 0)
						self:PlaceResourceImpact(iDanxiaX, iDanxiaY, ImpactLayers.LAYER_BONUS, 0)
						self:PlaceResourceImpact(iDanxiaX, iDanxiaY, ImpactLayers.LAYER_FISH, 0)
						self:PlaceResourceImpact(iDanxiaX, iDanxiaY, ImpactLayers.LAYER_MARBLE, 0)
						self:PlaceResourceImpact(iDanxiaX, iDanxiaY, ImpactLayers.LAYER_IVORY, 0)
					
						local iDanxiaPlotIndex = GetLuaPlotIndexFromCoordinates(iDanxiaX, iDanxiaY)
						
						self.playerCollisionData[iDanxiaPlotIndex] = true
						break
					end
				end
			elseif kPlacementInfo.NaturalWonderType == "FEATURE_MARIANA_A" then
				for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
					local pMarianaPlot = Map.PlotDirection(x, y, i)
					
					if pMarianaPlot:GetFeatureType() == GameInfoTypes.FEATURE_MARIANA_B 
					or pMarianaPlot:GetFeatureType() == GameInfoTypes.FEATURE_MARIANA_C then	
						local iMarianaX = pMarianaPlot:GetX()
						local iMarianaY = pMarianaPlot:GetY()
					
						self:PlaceStrategicResourceImpact(iMarianaX, iMarianaY, 0)
						
						self:PlaceResourceImpact(iMarianaX, iMarianaY, ImpactLayers.LAYER_LUXURY, 0)
						self:PlaceResourceImpact(iMarianaX, iMarianaY, ImpactLayers.LAYER_BONUS, 0)
						self:PlaceResourceImpact(iMarianaX, iMarianaY, ImpactLayers.LAYER_FISH, 0)
						self:PlaceResourceImpact(iMarianaX, iMarianaY, ImpactLayers.LAYER_MARBLE, 0)
						self:PlaceResourceImpact(iMarianaX, iMarianaY, ImpactLayers.LAYER_IVORY, 0)
					
						local iMarianaPlotIndex = GetLuaPlotIndexFromCoordinates(iMarianaX, iMarianaY)
						
						self.playerCollisionData[iMarianaPlotIndex] = true
					end
				end
			end

			print("- Placed ".. kPlacementInfo.NaturalWonderType .. " in Plot", x, y)

			return true
		end
	end

	-- If reached here, this wonder was unable to be placed because all candidates are too close to an already-placed NW
	return false
end

function AssignStartingPlots:GetNumNaturalWondersToPlace(iWorldSize)
	local tTarget = {
		[GameInfo.Worlds.WORLDSIZE_DUEL.ID] = 2, -- adan_eslavo
		[GameInfo.Worlds.WORLDSIZE_TINY.ID] = 4,
		[GameInfo.Worlds.WORLDSIZE_SMALL.ID] = 6,
		[GameInfo.Worlds.WORLDSIZE_STANDARD.ID] = 8,
		[GameInfo.Worlds.WORLDSIZE_LARGE.ID] = 10,
		[GameInfo.Worlds.WORLDSIZE_HUGE.ID] = 12,
	}

	return tTarget[iWorldSize]
end