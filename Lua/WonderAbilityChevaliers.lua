print("Loading WonderChevaliers.lua from MWfVP");
--------------------------------------------------------------
-- Orginal script for Kronborg was created by LeeS 
-- Dec 13, 2017: Retrofitted for Vox Populi, Infixo
-- Jan 14, 2020: Improved, adan_eslavo
--------------------------------------------------------------

local iChevaliers = GameInfoTypes["BUILDING_CHEVALIERS"]
local iChevaliersDummy = GameInfoTypes["BUILDING_CHEVALIERS_DUMMY"]
local bHasChevaliers = false
local iChevaliersOwner, iChevaliersCity

-- Chevaliers: load game, check if they are built
function WasChevaliersAlreadyBuilt()
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pPlayer = Players[i]
	
		if pPlayer:IsEverAlive() then
			for city in pPlayer:Cities() do
				if city:IsHasBuilding(iChevaliers) then
					bHasChevaliers = true
					iChevaliersCity = city:GetID()
					iChevaliersOwner = i
				end
			end
		end
	end
end
Events.LoadScreenClose.Add(WasChevaliersAlreadyBuilt)

-- Chevaliers: check if wonder was built
function IsChevaliersConstructed(iPlayer, iCity, iBuilding, bGold, bFaith) 
	if not bHasChevaliers then	
		if iBuilding == iChevaliers then
			bHasChevaliers = true
			iChevaliersCity = iCity
			iChevaliersOwner = iPlayer
			
			local pPlayer = Players[iPlayer]
		
			for city in pPlayer:Cities() do
				if not city:IsCoastal(10) then
					city:SetNumRealBuilding(iChevaliersDummy, 1);
				end
			end
		end
	end
end
GameEvents.CityConstructed.Add(IsChevaliersConstructed)

-- Chevaliers: check if wonder conquered by another player
function CheckChevalierAfterCapture(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if bHasChevaliers then	
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetPlotCity()
		local iConqCity = pConqCity:GetID()
		
		if iConqCity == iChevaliersCity then
			-- Chevaliers was conquered: clear all dummies
			local pOldOwner = Players[iOldOwner]
			
			for city in pOldOwner:Cities() do
				city:SetNumRealBuilding(iChevaliersDummy, 0)
			end
			
			-- now grant dummies for a new owner
			local pNewOwner = Players[iNewOwner]
			iChevaliersOwner = iNewOwner
			
			for city in pNewOwner:Cities() do
				if not city:IsCoastal(10) then
					city:SetNumRealBuilding(iChevaliersDummy, 1)
				end
			end		
		else
			-- player that owns Chevaliers conquered another city, check if NOT coastal
			if iNewOwner == iChevaliersOwner and not pConqCity:IsCoastal(10) then
				pConqCity:SetNumRealBuilding(iChevaliersDummy, 1)
			end
		end
	end
end
GameEvents.CityCaptureComplete.Add(CheckChevalierAfterCapture)

-- Chevaliers: check if new city has effects
function BuildChevaliersInNewCity(iPlayer, iX, iY)
	if bHasChevaliers then
		if iPlayer == iChevaliersOwner then
			local pPlot = Map.GetPlot(iX, iY)
			local pCity = pPlot:GetPlotCity()
			
			if not city:IsCoastal(10) then
				city:SetNumRealBuilding(iChevaliersDummy, 1)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(BuildChevaliersInNewCity)

print("Loaded WonderChevaliers.lua from MWfVP");