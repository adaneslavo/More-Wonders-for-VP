print("Loading WonderAbilityDummyBuilding.lua from MWfVP");
--------------------------------------------------------------
-- Orginal script for Kronborg was created by LeeS 
-- Dec 13, 2017: Retrofitted for Vox Populi, Infixo
-- Jan 14, 2020: Improved, adan_eslavo
--------------------------------------------------------------

-- Chevaliers
local iChevaliers = GameInfoTypes["BUILDING_CHEVALIERS"]
local iChevaliersDummy = GameInfoTypes["BUILDING_CHEVALIERS_DUMMY"]
local bHasChevaliers = false
local iChevaliersOwner

-- Itsukushima
local iItsukushima = GameInfoTypes["BUILDING_ITSUKUSHIMA"]
local iItsukushimaDummy = GameInfoTypes["BUILDING_ITSUKUSHIMA_DUMMY"]
local bHasItsukushima = false
local iItsukushimaOwner

-- Qalhat
local iQalhat = GameInfoTypes["BUILDING_QALHAT"]
local iQalhatDummy = GameInfoTypes["BUILDING_QALHAT_DUMMY"]
local bHasQalhat = false
local iQalhatOwner

-- load game and check if they are built
function WasChevaliersAlreadyBuilt()
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pPlayer = Players[i]
	
		if pPlayer:IsEverAlive() then
			for city in pPlayer:Cities() do
				if city:IsHasBuilding(iChevaliers) then
					bHasChevaliers = true
					iChevaliersOwner = i
				end

				if city:IsHasBuilding(iItsukushima) then
					bHasItsukushima = true
					iItsukushimaOwner = i
				end

				if city:IsHasBuilding(iQalhat) then
					bHasQalhat = true
					iQalhatOwner = i
				end
			end
		end
	end
end
Events.LoadScreenClose.Add(WasChevaliersAlreadyBuilt)

-- check if wonder was built
function IsWonderConstructed(iPlayer, iCity, iBuilding, bGold, bFaith) 
	if not bHasChevaliers then	
		if iBuilding == iChevaliers then
			bHasChevaliers = true
			iChevaliersOwner = iPlayer
			
			local pPlayer = Players[iPlayer]
		
			for city in pPlayer:Cities() do
				if not city:IsCoastal(10) and not city:IsHasBuilding(iChevaliers) then
					city:SetNumRealBuilding(iChevaliersDummy, 1);
				end
			end
		end
	end

	if not bHasItsukushima then	
		if iBuilding == iItsukushima then
			bHasItsukushima = true
			iItsukushimaOwner = iPlayer
			
			local pPlayer = Players[iPlayer]
		
			for city in pPlayer:Cities() do
				if city:IsCoastal(10) then
					city:SetNumRealBuilding(iItsukushimaDummy, 1);
				end
			end
		end
	end

	if not bHasQalhat then
		if iBuilding == iQalhat then
			bHasQalhat = true
			iQalhatOwner = iPlayer
			
			local pPlayer = Players[iPlayer]
			local iNumberSeaTROtherPlayers = 0

			for _, player in ipairs(Players) do
				iCurrentPlayer = player:GetID()
				
				for _, tradeRoute in ipairs(player:GetTradeRoutes()) do
					if ((tradeRoute.FromID == iPlayer and not Players[tradeRoute.ToID]:IsMinorCiv()) 
					or (tradeRoute.ToID == iPlayer and not Players[tradeRoute.FromID]:IsMinorCiv())) 
					and tradeRoute.FromID ~= tradeRoute.ToID 
					and tradeRoute.Domain == GameInfoTypes.DOMAIN_SEA then
						iNumberSeaTROtherPlayers = iNumberSeaTROtherPlayers + 1
					end
				end
			end

			local pCity = pPlayer:GetCityByID(iCity)
			
			pCity:SetNumRealBuilding(iQalhatDummy, iNumberSeaTROtherPlayers);
			
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
end
GameEvents.CityConstructed.Add(IsWonderConstructed)

-- check if wonder conquered by another player
function CheckForWonderAfterCapture(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if bHasChevaliers then	
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetWorkingCity()
		
		if pConqCity:IsHasBuilding(iChevaliers) then
			local pOldOwner = Players[iOldOwner]
			
			for city in pOldOwner:Cities() do
				city:SetNumRealBuilding(iChevaliersDummy, 0)
			end
			
			local pNewOwner = Players[iNewOwner]
			iChevaliersOwner = iNewOwner
			
			for city in pNewOwner:Cities() do
				if not city:IsCoastal(10) and not city:IsHasBuilding(iChevaliers) then
					city:SetNumRealBuilding(iChevaliersDummy, 1)
				end
			end		
		else
			if iNewOwner == iChevaliersOwner and not pConqCity:IsCoastal(10) then
				pConqCity:SetNumRealBuilding(iChevaliersDummy, 1)
			end
		end
	end
	
	if bHasItsukushima then	
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetWorkingCity()
		
		if pConqCity:IsHasBuilding(iItsukushima) then
			local pOldOwner = Players[iOldOwner]
			
			for city in pOldOwner:Cities() do
				city:SetNumRealBuilding(iItsukushimaDummy, 0)
			end
			
			local pNewOwner = Players[iNewOwner]
			iItsukushimaOwner = iNewOwner
			
			for city in pNewOwner:Cities() do
				if city:IsCoastal(10) then
					city:SetNumRealBuilding(iItsukushimaDummy, 1)
				end
			end		
		else
			if iNewOwner == iItsukushimaOwner and pConqCity:IsCoastal(10) then
				pConqCity:SetNumRealBuilding(iItsukushimaDummy, 1)
			end
		end
	end

	if bHasQalhat then	
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetWorkingCity()
		
		if pConqCity:IsHasBuilding(iQalhat) then
			iQalhatOwner = iNewOwner
			local iNumberSeaTROtherPlayers = 0
			
			for _, player in ipairs(Players) do
				iCurrentPlayer = player:GetID()
				
				for _, tradeRoute in ipairs(player:GetTradeRoutes()) do
					if ((tradeRoute.FromID == iNewOwner and not Players[tradeRoute.ToID]:IsMinorCiv()) 
					or (tradeRoute.ToID == iNewOwner and not Players[tradeRoute.FromID]:IsMinorCiv())) 
					and tradeRoute.FromID ~= tradeRoute.ToID 
					and tradeRoute.Domain == GameInfoTypes.DOMAIN_SEA then
						iNumberSeaTROtherPlayers = iNumberSeaTROtherPlayers + 1
					end
				end
			end

			pConqCity:SetNumRealBuilding(iQalhatDummy, iNumberSeaTROtherPlayers);
		end
	end
end
GameEvents.CityCaptureComplete.Add(CheckForWonderAfterCapture)

-- check if new city has effects
function BuildDummyInNewCity(iPlayer, iX, iY)
	if bHasChevaliers then
		if iPlayer == iChevaliersOwner then
			local pPlot = Map.GetPlot(iX, iY)
			local pCity = pPlot:GetWorkingCity()
			
			if not pCity:IsCoastal(10) then
				pCity:SetNumRealBuilding(iChevaliersDummy, 1)
			end
		end
	end

	if bHasItsukushima then
		if iPlayer == iItsukushimaOwner then
			local pPlot = Map.GetPlot(iX, iY)
			local pCity = pPlot:GetWorkingCity()
			
			if pCity:IsCoastal(10) then
				pCity:SetNumRealBuilding(iItsukushimaDummy, 1)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(BuildDummyInNewCity)

-- check if unit action changed
function SetDummiesOnUnitActionChange(iPlayer, iUnit)
	if bHasQalhat then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		
		if pUnit == nil then return end 	
		
		local iUnitClass = pUnit:GetUnitClassType()
		
		if iUnitClass ~= GameInfoTypes.UNITCLASS_CARGO_SHIP then return end
		
		local iNumberSeaTROtherPlayers = 0

		for _, player in ipairs(Players) do
			for city in player:Cities() do
				if city:IsHasBuilding(iQalhat) then
					for _, trader in ipairs(Players) do
						if not trader:IsEverAlive() then break end
						iCurrentPlayer = trader:GetID()
				
						for _, tradeRoute in ipairs(trader:GetTradeRoutes()) do
							if ((tradeRoute.FromID == player:GetID() and not Players[tradeRoute.ToID]:IsMinorCiv()) 
							or (tradeRoute.ToID == player:GetID() and not Players[tradeRoute.FromID]:IsMinorCiv())) 
							and tradeRoute.FromID ~= tradeRoute.ToID 
							and tradeRoute.Domain == GameInfoTypes.DOMAIN_SEA then
								iNumberSeaTROtherPlayers = iNumberSeaTROtherPlayers + 1
							end
						end
					end

					city:SetNumRealBuilding(iQalhatDummy, iNumberSeaTROtherPlayers);
					return
				end
			end
		end
	end
end
Events.UnitActionChanged.Add(SetDummiesOnUnitActionChange)

print("Loaded WonderAbilityDummyBuilding.lua from MWfVP");