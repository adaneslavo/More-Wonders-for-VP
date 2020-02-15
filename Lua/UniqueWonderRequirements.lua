print("Loading UniqueWonderRequirements.lua from MWfVP")
--------------------------------------------------------------
-- CityCanConstruct event expansion
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

local tValidIsMaxEra = {}
----
local tValidIsLake = {}
local tValidIsNoCoast = {} -- temporary?
local tValidIsMountains = {}
local tValidIsProhibitedTerrain = {}
----
local tValidIsHasImprovement = {}
----
local tValidIsOneTile = {}
----
local tValidIsAtPeace = {}
local tValidIsMajorApproach = {}


local bReachedMaxEra

-- IsMaxEra
--[[function IsMaxEra(ePlayer, eCity, eBuilding)
	if not tValidIsMaxEra[eBuilding] then 
		bReachedMaxEra = false 
		return true
	end
	
	local pPlayer = Players[ePlayer]
	
	if not pPlayer:IsAlive() then return false end

	local pTeam = Teams[pPlayer:GetTeam()]
	local eCurrentEra = pTeam:GetCurrentEra()
	local eMaxStartEra = tValidIsMaxEra[eBuilding]
	local pCity = pPlayer:GetCityByID(eCity)
	local iReturnProduction = pCity:GetBuildingProduction(eBuilding)
		
	if eCurrentEra <= eMaxStartEra then 
		bReachedMaxEra = false
		return true 
	end

	bReachedMaxEra = true

	if pPlayer:IsHuman() and pPlayer:IsTurnActive() and iReturnProduction > 0 then
		for building in GameInfo.Buildings() do
			if building.ID == eBuilding then
				local sWonderName = Locale.ConvertTextKey(building.Description)
					
				for era in GameInfo.Eras() do
					if era.ID == eCurrentEra then
						local sEraName = Locale.ConvertTextKey(era.Description)
						local sCityName = pCity:GetName()
						local iCultureReturn = math.ceil(0.33 * iReturnProduction)

						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_BEATEN, 
							'It is too late for building [COLOR_CYAN]' .. sWonderName .. '[ENDCOLOR] Wonder in [COLOR_CYAN]' .. sCityName .. '[ENDCOLOR], because Player has just entered [COLOR_CYAN]' .. sEraName .. '[ENDCOLOR]. Player will receive ' .. iCultureReturn .. '[ICON_CULTURE] Culture in return.', -- use TXT_KEY_ here
							'[COLOR_CYAN]' .. sWonderName .. '[ENDCOLOR] cannot be built anymore',
							pCity:GetX(), pCity:GetY(), building.ID)
						
						pPlayer:ChangeJONSCulture(iCultureReturn)
						pCity:SetBuildingProduction(eBuilding, 0)
						break
					end
				end

				break
			end
		end
	end
		
	return false
end
GameEvents.CityCanConstruct.Add(IsMaxEra)--]]

-- checks if city is between River and Sea and adds this condition (normally it would be treated like city with Lake)
-- Sea and Lake		=	FreshWater == true, 	Water>1 == true		true
-- Lake and River	=	FreshWater == true, 	Water>1 == true		true
-- Sea and River	=	FreshWater == true, 	Water>1 == true		true? should be false
-- Sea			=	FreshWater == false, 	Water>1 == true		false
-- Lake			=	FreshWater == true, 	Water>1 == true		true
-- River		=	FreshWater == true, 	Water>1 == false	false
function IsLakeWithOcean(ePlayer, eCity, eBuilding)
	if not tValidIsLake[eBuilding] then return true end
	if bReachedMaxEra then return false end

	local pPlayer = Players[ePlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(eCity)
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
GameEvents.CityCanConstruct.Add(IsLakeWithOcean)

-- checks if city is NOT near COAST
function IsNoCoast(ePlayer, eCity, eBuilding)
	if not tValidIsNoCoast[eBuilding] then return true end
	if bReachedMaxEra then return false end

	local pPlayer = Players[ePlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(eCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()

	if pCity:IsCoastal(10) then
		return false
	end

	return true
end
GameEvents.CityCanConstruct.Add(IsNoCoast)

-- looks for 2 MOUNTAINS in city range (MACHU PICCHU, BUDDHAS OF BAMYAN)
function IsMountains(ePlayer, eCity, eBuilding)
	if not tValidIsMountains[eBuilding] then return true end
	if bReachedMaxEra then return false end

	local pPlayer = Players[ePlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(eCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()
	local iMountainCount = 0

	for cityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
		local pSpecificPlot = pCity:GetCityIndexPlot(cityPlot)
		
		if pSpecificPlot then
			local eTerrain = pSpecificPlot:GetTerrainType()
			local ePlotOwner = pSpecificPlot:GetOwner()
			local eMountain = GameInfoTypes.TERRAIN_MOUNTAIN
				
			if ePlotOwner == ePlayer and eTerrain == eMountain then
				iMountainCount = iMountainCount + 1
			
				if iMountainCount >= 2 then
					return true
				end
			end
		end
	end

	return false
end
GameEvents.CityCanConstruct.Add(IsMountains)

-- expands ProhibitedCityTerrain function by tiles around the city
-- adds condition: if not tundra then also not snow
function IsProhibitedTerrainExpanded(ePlayer, eCity, eBuilding)
	if not tValidIsProhibitedTerrain[eBuilding] then return true end
	if bReachedMaxEra then return false end

	local pPlayer = Players[ePlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(eCity)
	local eCityTerrain = pCity:GetCityIndexPlot(0):GetTerrainType()
	local eProhibitedTerrain = tValidIsProhibitedTerrain[eBuilding]
	local eTundra = GameInfoTypes.TERRAIN_TUNDRA
	local eSnow = GameInfoTypes.TERRAIN_SNOW

	-- check city tile
	if eProhibitedTerrain == eTundra and eCityTerrain == eSnow then
		return false
	end
	
	-- check tiles around the city
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()
	
	for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1 do
		local eTerrain = Map.PlotDirection(iCityX, iCityY, dir):GetTerrainType()
		
		if eTerrain == eProhibitedTerrain then
			return false
		elseif eProhibitedTerrain == eTundra and eTerrain == eSnow then
			return false -- if not tundra then also not snow
		end
	end

	return true
end
GameEvents.CityCanConstruct.Add(IsProhibitedTerrainExpanded)

-- looks for IMPROVEMENTS
function IsHasImprovement(ePlayer, eCity, eBuilding)
	if not tValidIsHasImprovement[eBuilding] then return true end
	if bReachedMaxEra then return false end

	local pPlayer = Players[ePlayer]
   
	if not pPlayer:IsAlive() then return false end

	local pCity = pPlayer:GetCityByID(eCity)
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()
	
	for id, building in pairs(tValidIsHasImprovement) do
		if id == eBuilding then
			local eRequiredImprovement1 = building.eRequiredImprovement1
			local eRequiredImprovement2 = building.eRequiredImprovement2
			local iRequiredImprovements = tValidIsHasImprovement[eBuilding].iRequiredImprovements or 0
			local iRequiredRoads = tValidIsHasImprovement[eBuilding].iRequiredRoads or 0
			
			local iCurrentImprovements = 0
			local iCurrentRoads = 0
			
			for cityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
				local pSpecificPlot = pCity:GetCityIndexPlot(cityPlot)
				
				if pSpecificPlot then
					local ePlotOwner = pSpecificPlot:GetOwner()
				
					if ePlotOwner == ePlayer then
						if iRequiredRoads > 0 then
							local eRoute = pSpecificPlot:GetRouteType()
							local eRoad = GameInfoTypes.ROUTE_ROAD
						
							if eRoute == eRoad and not pSpecificPlot:IsRoutePillaged() then
								iCurrentRoads = iCurrentRoads + 1
							end
						end

						if iRequiredImprovements > 0 then
							local eImprovement = pSpecificPlot:GetImprovementType()
				
							if (eImprovement == eRequiredImprovement1 or eImprovement == eRequiredImprovement2) and not pSpecificPlot:IsImprovementPillaged() then
								iCurrentImprovements = iCurrentImprovements + 1
							end
						end
					end
					
					if iCurrentRoads >= iRequiredRoads and iCurrentImprovements >= iRequiredImprovements then
						return true
					end
				end
			end

			return false
		end
	end
end
GameEvents.CityCanConstruct.Add(IsHasImprovement)

-- checks if city is ONE-tile (MONT ST MICHELLE, SOLOVIETSKY)
function IsOneTile(ePlayer, eCity, eBuilding)
	if not tValidIsOneTile[eBuilding] then return true end
	if bReachedMaxEra then return false end

	local pPlayer = Players[ePlayer]
	
	if not pPlayer:IsAlive() then return false end
	
	local pCity = pPlayer:GetCityByID(eCity)
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
GameEvents.CityCanConstruct.Add(IsOneTile)

-- checks if player is at PEACE (BUDDHAS OF BAMYAN)
function IsAtPeace(ePlayer, eCity, eBuilding)
	if not tValidIsAtPeace[eBuilding] then return true end
	if bReachedMaxEra then return false end

	local pPlayer = Players[ePlayer]
	
	if not pPlayer:IsAlive() then return false end
	
	local pTeam = Teams[pPlayer:GetTeam()]
	local iCountWars = pTeam:GetAtWarCount(false)
	
	if iCountWars > 0 then
		return false
	end
	
	return true
end
GameEvents.CityCanConstruct.Add(IsAtPeace)

-- checks if other player's APPROACHES (STATUE OF ZEUS, GREAT WALL)
function IsMajorApproach(ePlayer, eCity, eBuilding)
	if not tValidIsMajorApproach[eBuilding] then return true end
	if bReachedMaxEra then return false end

	local pPlayer = Players[ePlayer]
	
	if not pPlayer:IsAlive() then return false end
	
	for id, building in pairs(tValidIsMajorApproach) do
		if id == eBuilding then
			local eRequiredApproach1 = building.eRequiredApproach1
			local eRequiredApproach2 = building.eRequiredApproach2
			local eRequiredApproach3 = building.eRequiredApproach3
			local eRequiredApproach4 = building.eRequiredApproach4
			
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				local pTargetPlayer = Players[i]
				
				if not pTargetPlayer:IsEverAlive() then break end

				local eApproachTrue = pPlayer:GetMajorCivApproach(i)
				local eApproachGuess = pPlayer:GetApproachTowardsUsGuess(i)
				print("approach:", pPlayer:GetName(), pTargetPlayer:GetName(), pPlayer:GetMajorCivApproach(i), pPlayer:GetApproachTowardsUsGuess(i), pPlayer:GetMajorCivApproach(i, false), pPlayer:GetMajorCivApproach(i, true))
				if eApproachTrue == eRequiredApproach1 or eApproachTrue == eRequiredApproach2 or eApproachTrue == eRequiredApproach3 or eApproachTrue == eRequiredApproach4 or
				   eApproachGuess == eRequiredApproach1 or eApproachGuess == eRequiredApproach2 or eApproachGuess == eRequiredApproach3 or eApproachGuess == eRequiredApproach4 then
					print("approach-match!")
					return true
				end
			end
			print("approach-notmuch")
			return false
		end
	end
end
GameEvents.CityCanConstruct.Add(IsMajorApproach)
-------------------------------------------------------------------------------------------------------------------------
function Initialize()
	-- IsMaxEra
	for building in GameInfo.Buildings() do
		if building.MaxStartEra ~= nil and building.WonderSplashImage ~= nil then
			dprint("...adding (id,building,era)", building.ID, building.Type, "(Building can be constructed up to: " .. building.MaxStartEra .. ")")
			tValidIsMaxEra[building.ID] = GameInfo.Eras[building.MaxStartEra].ID
		end
	end
	
	-- IsLake
	-- add lake buildings ==> lake is when: FreshWater = 1, Water = 1, MinAreaSize = 1
	for building in GameInfo.Buildings() do	
		if building.FreshWater and building.Water and building.MinAreaSize == 1 and building.IsCorporation == 0 then
			local eBuilding = GameInfoTypes[building.Type]
			
			dprint("...adding (id,building,requirement)", building.ID, building.Type, "(IsLake)")
			tValidIsLake[building.ID] = true
		end
	end

	-- IsNoCoast
	tValidIsNoCoast[GameInfo.Buildings.BUILDING_MAJORVILLE.ID] = true
	tValidIsNoCoast[GameInfo.Buildings.BUILDING_HANGING_GARDEN.ID] = true
	tValidIsNoCoast[GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.ID] = true
	tValidIsNoCoast[GameInfo.Buildings.BUILDING_ETCHMIADZIN.ID] = true
	tValidIsNoCoast[GameInfo.Buildings.BUILDING_NABAWI.ID] = true
	tValidIsNoCoast[GameInfo.Buildings.BUILDING_GREAT_ZIMBABWE.ID] = true
	tValidIsNoCoast[GameInfo.Buildings.BUILDING_CHEVALIERS.ID] = true
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_MAJORVILLE.ID, GameInfo.Buildings.BUILDING_MAJORVILLE.Type, "(IsNoCoast)")
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_HANGING_GARDEN.ID, GameInfo.Buildings.BUILDING_HANGING_GARDEN.Type, "(IsNoCoast)")
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.ID, GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.Type, "(IsNoCoast)")
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_ETCHMIADZIN.ID, GameInfo.Buildings.BUILDING_ETCHMIADZIN.Type, "(IsNoCoast)")
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_NABAWI.ID, GameInfo.Buildings.BUILDING_NABAWI.Type, "(IsNoCoast)")
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_GREAT_ZIMBABWE.ID, GameInfo.Buildings.BUILDING_GREAT_ZIMBABWE.Type, "(IsNoCoast)")
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_CHEVALIERS.ID, GameInfo.Buildings.BUILDING_CHEVALIERS.Type, "(IsNoCoast)")
	
	-- IsMountains
	tValidIsMountains[GameInfo.Buildings.BUILDING_MACHU_PICHU.ID] = true
	tValidIsMountains[GameInfo.Buildings.BUILDING_BAMYAN.ID] = true
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_MACHU_PICHU.ID, GameInfo.Buildings.BUILDING_MACHU_PICHU.Type, "(IsMountains)")
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_BAMYAN.ID, GameInfo.Buildings.BUILDING_BAMYAN.Type, "(IsMountains)")
	
	-- IsProhibitedTerrain
	for building in GameInfo.Buildings() do
		if building.ProhibitedCityTerrain ~= nil then
			dprint("...adding (id,building,prohibition,terrain)", building.ID, building.Type, "(Building is prohibited on: " .. building.ProhibitedCityTerrain .. ")")
			tValidIsProhibitedTerrain[building.ID] = GameInfo.Terrains[building.ProhibitedCityTerrain].ID
		end
	end

	-- IsHasImprovement
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_GGANTIJA.ID] = {
		sType = "BUILDING_GGANTIJA",
		eRequiredImprovement1 = GameInfoTypes.IMPROVEMENT_FARM,
		iRequiredImprovements = 2
	}
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_STONEHENGE.ID] = {
		sType = "BUILDING_STONEHENGE",
		iRequiredRoads = 2
	}
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_NAZCA.ID] = {
		sType = "BUILDING_NAZCA",
		eRequiredImprovement1 = GameInfoTypes.IMPROVEMENT_CAMP,
		iRequiredImprovements = 1
	}
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_TEMPLE_ARTEMIS.ID] = {
		sType = "BUILDING_TEMPLE_ARTEMIS",
		eRequiredImprovement1 = GameInfoTypes.IMPROVEMENT_CAMP,
		iRequiredImprovements = 1
	}
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_MAUSOLEUM_HALICARNASSUS.ID] = {
		sType = "BUILDING_MAUSOLEUM_HALICARNASSUS",
		eRequiredImprovement1 = GameInfoTypes.IMPROVEMENT_QUARRY,
		iRequiredImprovements = 1
	}
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_TERRACOTTA_ARMY.ID] = {
		sType = "BUILDING_TERRACOTTA_ARMY",
		eRequiredImprovement1 = GameInfoTypes.IMPROVEMENT_MINE,
		eRequiredImprovement2 = GameInfoTypes.IMPROVEMENT_QUARRY,
		iRequiredImprovements = 1
	}
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_GREAT_ZIMBABWE.ID] = {
		sType = "BUILDING_GREAT_ZIMBABWE",
		eRequiredImprovement1 = GameInfoTypes.IMPROVEMENT_MINE,
		eRequiredImprovement2 = GameInfoTypes.IMPROVEMENT_CAMP,
		iRequiredImprovements = 2
	}
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_FALUN.ID] = {
		sType = "BUILDING_FALUN",
		eRequiredImprovement1 = GameInfoTypes.IMPROVEMENT_MINE,
		iRequiredImprovements = 4
	}
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_DAMASCUS.ID] = {
		sType = "BUILDING_DAMASCUS",
		eRequiredImprovement1 = GameInfoTypes.IMPROVEMENT_LUMBERMILL,
		eRequiredImprovement2 = GameInfoTypes.IMPROVEMENT_LUMBERMILL_JUNGLE,
		iRequiredImprovements = 2
	}
	tValidIsHasImprovement[GameInfo.Buildings.BUILDING_NOTRE_DAME.ID] = {
		sType = "BUILDING_NOTRE_DAME",
		eRequiredImprovement1 = GameInfoTypes.IMPROVEMENT_LUMBERMILL,
		eRequiredImprovement2 = GameInfoTypes.IMPROVEMENT_LUMBERMILL_JUNGLE,
		iRequiredImprovements = 2
	}
	for id, building in pairs(tValidIsHasImprovement) do
		dprint("...adding (id,building,requirement1,requirement2,count,roads)", id, building.sType, building.eRequiredImprovement1, building.eRequiredImprovement2, building.iRequiredImprovements, building.iRequiredRoads)
	end

	-- IsOneTile
	tValidIsOneTile[GameInfo.Buildings.BUILDING_MICHEL.ID] = true
	--tValidIsOneTile[GameInfo.Buildings.BUILDING_SOLOVIETSKY.ID] = true
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_MICHEL.ID, GameInfo.Buildings.BUILDING_MICHEL.Type, "(IsOneTile)")
	--dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_SOLOVIETSKY.ID, GameInfo.Buildings.BUILDING_SOLOVIETSKY.Type, "(One-tile city)")
	
	-- IsAtPeace
	tValidIsAtPeace[GameInfo.Buildings.BUILDING_BAMYAN.ID] = true
	dprint("...adding (id,building,requirement)", GameInfo.Buildings.BUILDING_BAMYAN.ID, GameInfo.Buildings.BUILDING_BAMYAN.Type, "(IsAtPeace)")
	
	-- IsMajorApproach
	tValidIsMajorApproach[GameInfo.Buildings.BUILDING_STATUE_ZEUS.ID] = {
		sType = "BUILDING_STATUE_ZEUS",
		eRequiredApproach1 = GameInfoTypes.MAJOR_CIV_APPROACH_WAR,
		eRequiredApproach2 = GameInfoTypes.MAJOR_CIV_APPROACH_HOSTILE,
		eRequiredApproach3 = GameInfoTypes.MAJOR_CIV_APPROACH_GUARDED,
		eRequiredApproach4 = GameInfoTypes.MAJOR_CIV_APPROACH_AFRAID
	}
	tValidIsMajorApproach[GameInfo.Buildings.BUILDING_GREAT_WALL.ID] = {
		sType = "BUILDING_GREAT_WALL",
		eRequiredApproach1 = GameInfoTypes.MAJOR_CIV_APPROACH_WAR,
		eRequiredApproach2 = GameInfoTypes.MAJOR_CIV_APPROACH_HOSTILE,
		eRequiredApproach3 = GameInfoTypes.MAJOR_CIV_APPROACH_DECEPTIVE
	}
	for id, building in pairs(tValidIsMajorApproach) do
		dprint("...adding (id,building,approach1,approach2,approach3)", id, building.sType, building.eRequiredApproach1, building.eRequiredApproach2, building.eRequiredApproach3, building.eRequiredApproach4)
	end
end
Initialize()
--------------------------------------------------------------
--------------------------------------------------------------
print("Loaded UniqueWonderRequirements.lua from MWfVP")
--------------------------------------------------------------
--------------------------------------------------------------
