print("Loading WonderAbilityDummyBuilding.lua from MWfVP");
--------------------------------------------------------------
-- Orginal script for Kronborg was created by LeeS 
-- Dec 13, 2017: Retrofitted for Vox Populi, Infixo
-- Jan 14, 2020: Improved, adan_eslavo
--------------------------------------------------------------

-- Chevaliers
local eChevaliers = GameInfoTypes["BUILDING_CHEVALIERS"]
local eChevaliersDummy = GameInfoTypes["BUILDING_CHEVALIERS_DUMMY"]
local bHasChevaliers = false
local eChevaliersOwner

-- Itsukushima
local eItsukushima = GameInfoTypes["BUILDING_ITSUKUSHIMA"]
local eItsukushimaDummy = GameInfoTypes["BUILDING_ITSUKUSHIMA_DUMMY"]
local bHasItsukushima = false
local eItsukushimaOwner

-- Qalhat
local eQalhat = GameInfoTypes["BUILDING_QALHAT"]
local eQalhatDummy = GameInfoTypes["BUILDING_QALHAT_DUMMY"]
local bHasQalhat = false
local eQalhatOwner

-- Qalhat
local eSunGate = GameInfoTypes["BUILDING_GATE_OF_SUN"]
local eSunGateDummy = GameInfoTypes["BUILDING_GATE_OF_SUN_DUMMY"]
local eWalls = GameInfoTypes["BUILDING_WALLS"]
local bHasSunGate = false
local eSunGateOwner

-- load game and check if they are built
function WasChevaliersAlreadyBuilt()
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pPlayer = Players[i]
	
		if pPlayer:IsEverAlive() then
			for city in pPlayer:Cities() do
				if city:IsHasBuilding(eChevaliers) then
					bHasChevaliers = true
					eChevaliersOwner = i
				end

				if city:IsHasBuilding(eItsukushima) then
					bHasItsukushima = true
					eItsukushimaOwner = i
				end

				if city:IsHasBuilding(eQalhat) then
					bHasQalhat = true
					eQalhatOwner = i
				end

				if city:IsHasBuilding(eSunGate) then
					bHasSunGate = true
					eSunGateOwner = i
				end
			end
		end
	end
end
Events.LoadScreenClose.Add(WasChevaliersAlreadyBuilt)

-- check if wonder was built
function IsWonderConstructed(ePlayer, eCity, eBuilding, bGold, bFaith) 
	if not bHasChevaliers then	
		if eBuilding == eChevaliers then
			bHasChevaliers = true
			eChevaliersOwner = ePlayer
			
			local pPlayer = Players[ePlayer]
		
			for city in pPlayer:Cities() do
				if not city:IsCoastal(10) and not city:IsHasBuilding(eChevaliers) then
					city:SetNumRealBuilding(eChevaliersDummy, 1);
				end
			end
		end
	end

	if not bHasItsukushima then	
		if eBuilding == eItsukushima then
			bHasItsukushima = true
			eItsukushimaOwner = ePlayer
			
			local pPlayer = Players[ePlayer]
		
			for city in pPlayer:Cities() do
				if city:IsCoastal(10) then
					city:SetNumRealBuilding(eItsukushimaDummy, 1);
				end
			end
		end
	end

	if not bHasQalhat then
		if eBuilding == eQalhat then
			bHasQalhat = true
			eQalhatOwner = ePlayer
			
			local pPlayer = Players[ePlayer]
			local iSeaTradeRoutesWithMajors = 0

			for _, player in ipairs(Players) do
				if player:IsAlive() then
					for _, tradeRoute in ipairs(player:GetTradeRoutes()) do
						if ((tradeRoute.FromID == ePlayer and not Players[tradeRoute.ToID]:IsMinorCiv()) 
						or (tradeRoute.ToID == ePlayer and not Players[tradeRoute.FromID]:IsMinorCiv())) 
						and tradeRoute.FromID ~= tradeRoute.ToID 
						and tradeRoute.Domain == GameInfoTypes.DOMAIN_SEA then
							iSeaTradeRoutesWithMajors = iSeaTradeRoutesWithMajors + 1
						end
					end
				end
			end

			local pCity = pPlayer:GetCityByID(eCity)
			
			pCity:SetNumRealBuilding(eQalhatDummy, iSeaTradeRoutesWithMajors);
			
			--[[		
			Domain - DomainTypes.DOMAIN_LAND or DomainTypes.DOMAIN_SEA (int)
			TurnsLeft - turns left before the trade route can be reassigned (int)
			FromCivilizationType - eg GameInfoTypes.CIVILIZATION_ENGLAND (int)
			FromID - from player ID (int)
			FromCityName - from city name (string)
			FromCity - from city (Lua pCity object)
			ToCivilizationType - to player civ type (int)
			ToID - to player ID (int)
			ToCityName - to city name (string)
			ToCity - to city (Lua pCity object)
			FromGPT - route yield (int)
			ToGPT - route yield (int)
			ToFood - route yield (int)
			ToProduction - route yield (int)
			FromScience - route yield (int)
			ToScience - route yield (int)
			ToReligion - to religion type (or -1) (int)
			ToPressure - to pressure (int)
			FromReligion - from religion type (or -1) (int)
			FromPressure - from pressure (int)
			FromTourism - from tourism (int)
			ToTourism - to tourism (int)
			--]]
		end
	end

	if not bHasSunGate then	
		if eBuilding == eSunGate then
			bHasSunGate = true
			eSunGateOwner = ePlayer
			
			local pPlayer = Players[ePlayer]
		
			for city in pPlayer:Cities() do
				if city:IsHasBuilding(eWalls) then
					city:SetNumRealBuilding(eSunGateDummy, 1);
				end
			end
		end
	else
		if eBuilding == eWalls then
			local pPlayer = Players[ePlayer]
			local pCity = pPlayer:GetCityByID(eCity)

			pCity:SetNumRealBuilding(eSunGateDummy, 1);
		end
	end
end
GameEvents.CityConstructed.Add(IsWonderConstructed)

-- check if wonder conquered by another player
function CheckForWonderAfterCapture(eOldOwner, bIsCapital, iX, iY, eNewOwner, iPop, bConquest)
	if bHasChevaliers then	
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetWorkingCity()
		
		if pConqCity:IsHasBuilding(eChevaliers) then
			local pOldOwner = Players[eOldOwner]
			
			for city in pOldOwner:Cities() do
				city:SetNumRealBuilding(eChevaliersDummy, 0)
			end
			
			local pNewOwner = Players[eNewOwner]
			eChevaliersOwner = eNewOwner
			
			for city in pNewOwner:Cities() do
				if not city:IsCoastal(10) and not city:IsHasBuilding(eChevaliers) then
					city:SetNumRealBuilding(eChevaliersDummy, 1)
				end
			end		
		else
			if eNewOwner == eChevaliersOwner and not pConqCity:IsCoastal(10) then
				pConqCity:SetNumRealBuilding(eChevaliersDummy, 1)
			end
		end
	end
	
	if bHasItsukushima then	
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetWorkingCity()
		
		if pConqCity:IsHasBuilding(eItsukushima) then
			local pOldOwner = Players[eOldOwner]
			
			for city in pOldOwner:Cities() do
				city:SetNumRealBuilding(eItsukushimaDummy, 0)
			end
			
			local pNewOwner = Players[eNewOwner]
			eItsukushimaOwner = eNewOwner
			
			for city in pNewOwner:Cities() do
				if city:IsCoastal(10) then
					city:SetNumRealBuilding(eItsukushimaDummy, 1)
				end
			end		
		else
			if eNewOwner == eItsukushimaOwner and pConqCity:IsCoastal(10) then
				pConqCity:SetNumRealBuilding(eItsukushimaDummy, 1)
			end
		end
	end

	if bHasQalhat then	
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetWorkingCity()
		
		if pConqCity:IsHasBuilding(eQalhat) then
			eQalhatOwner = eNewOwner
			local iSeaTradeRoutesWithMajors = 0
			
			for _, player in ipairs(Players) do
				if player:IsAlive() then
					for _, tradeRoute in ipairs(player:GetTradeRoutes()) do
						if ((tradeRoute.FromID == eNewOwner and not Players[tradeRoute.ToID]:IsMinorCiv()) 
						or (tradeRoute.ToID == eNewOwner and not Players[tradeRoute.FromID]:IsMinorCiv())) 
						and tradeRoute.FromID ~= tradeRoute.ToID 
						and tradeRoute.Domain == GameInfoTypes.DOMAIN_SEA then
							iSeaTradeRoutesWithMajors = iSeaTradeRoutesWithMajors + 1
						end
					end
				end
			end

			pConqCity:SetNumRealBuilding(eQalhatDummy, iSeaTradeRoutesWithMajors);
		end
	end

	if bHasSunGate then	
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetWorkingCity()
		
		if pConqCity:IsHasBuilding(eSunGate) then
			local pOldOwner = Players[eOldOwner]
			
			for city in pOldOwner:Cities() do
				city:SetNumRealBuilding(eSunGateDummy, 0)
			end
			
			local pNewOwner = Players[eNewOwner]
			eSunGateOwner = eNewOwner
			
			for city in pNewOwner:Cities() do
				if city:IsHasBuilding(eWalls) then
					city:SetNumRealBuilding(eSunGateDummy, 1)
				end
			end		
		else
			if eNewOwner == eSunGateOwner and pConqCity:IsHasBuilding(eWalls) then
				pConqCity:SetNumRealBuilding(eSunGateDummy, 1)
			end
		end
	end
end
GameEvents.CityCaptureComplete.Add(CheckForWonderAfterCapture)

-- check if new city has effects
function BuildDummyInNewCity(ePlayer, iX, iY)
	if bHasChevaliers then
		if ePlayer == eChevaliersOwner then
			local pPlot = Map.GetPlot(iX, iY)
			local pCity = pPlot:GetWorkingCity()
			
			if not pCity:IsCoastal(10) then
				pCity:SetNumRealBuilding(eChevaliersDummy, 1)
			end
		end
	end

	if bHasItsukushima then
		if ePlayer == eItsukushimaOwner then
			local pPlot = Map.GetPlot(iX, iY)
			local pCity = pPlot:GetWorkingCity()
			
			if pCity:IsCoastal(10) then
				pCity:SetNumRealBuilding(eItsukushimaDummy, 1)
			end
		end
	end

	if bHasSunGate then
		if ePlayer == eSunGateOwner then
			local pPlot = Map.GetPlot(iX, iY)
			local pCity = pPlot:GetWorkingCity()
			
			if pCity:IsHasBuilding(eWalls) then
				pCity:SetNumRealBuilding(eSunGateDummy, 1)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(BuildDummyInNewCity)

-- check if unit action changed
function SetDummiesOnUnitActionChange(ePlayer, iUnit)
	if bHasQalhat then
		local pPlayer = Players[ePlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		
		if pUnit == nil then return end 	
		
		local iUnitClass = pUnit:GetUnitClassType()
		
		if iUnitClass ~= GameInfoTypes.UNITCLASS_CARGO_SHIP then return end
		
		local iSeaTradeRoutesWithMajors = 0

		for _, player in ipairs(Players) do
			if player:IsAlive() then
				for city in player:Cities() do
					if city:IsHasBuilding(eQalhat) then
						for _, trader in ipairs(Players) do
							if not trader:IsEverAlive() then break end
						
							for _, tradeRoute in ipairs(trader:GetTradeRoutes()) do
								if ((tradeRoute.FromID == player:GetID() and not Players[tradeRoute.ToID]:IsMinorCiv()) 
								or (tradeRoute.ToID == player:GetID() and not Players[tradeRoute.FromID]:IsMinorCiv())) 
								and tradeRoute.FromID ~= tradeRoute.ToID 
								and tradeRoute.Domain == GameInfoTypes.DOMAIN_SEA then
									iSeaTradeRoutesWithMajors = iSeaTradeRoutesWithMajors + 1
								end
							end
						end

						city:SetNumRealBuilding(eQalhatDummy, iSeaTradeRoutesWithMajors);
						return
					end
				end
			end
		end
	end
end
Events.UnitActionChanged.Add(SetDummiesOnUnitActionChange)

print("Loaded WonderAbilityDummyBuilding.lua from MWfVP");