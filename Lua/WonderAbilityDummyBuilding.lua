print("Loading WonderChevaliers.lua from MWfVP");
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
			end
		end
	end
	print(bHasChevaliers, iChevaliersOwner)
	print(bHasItsukushima, iItsukushimaOwner)
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

print("Loaded WonderChevaliers.lua from MWfVP");