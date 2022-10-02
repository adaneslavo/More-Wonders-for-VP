print("Loading UniqueNaturalWondersAbilities.lua from MWfVP");
--------------------------------------------------------------
-- Natural Wonders Abilities
-- Dec 13, 2017: Retrofitted for Vox Populi, Infixo
-- May 11, 2020: Created, adan_eslavo
--------------------------------------------------------------
local g_tNaturalWonder = {
	GameInfoTypes["FEATURE_SALAR_A"],
	GameInfoTypes["FEATURE_SALAR_B"],
	GameInfoTypes["FEATURE_EL_DORADO"],
	GameInfoTypes["FEATURE_POTOSI"],
	GameInfoTypes["FEATURE_CRATER"],
	GameInfoTypes["FEATURE_MESA"],
	GameInfoTypes["FEATURE_SOLOMONS_MINES"],
	GameInfoTypes["FEATURE_VOLCANO"],
	GameInfoTypes["FEATURE_FUJI"],
	GameInfoTypes["FEATURE_MT_SINAI"],
	GameInfoTypes["FEATURE_GEYSER"],
	GameInfoTypes["FEATURE_MT_EVEREST"],
	GameInfoTypes["FEATURE_NEW_REEF"],
	GameInfoTypes["FEATURE_GIBRALTAR"],
	GameInfoTypes["FEATURE_LAKE_VICTORIA"],
	GameInfoTypes["FEATURE_CAUSEWAY_A"],
	GameInfoTypes["FEATURE_CAUSEWAY_B"],
	GameInfoTypes["FEATURE_RETBA"],
	GameInfoTypes["FEATURE_LUMI_BAY"],
	GameInfoTypes["FEATURE_DALLOL"],
	GameInfoTypes["FEATURE_EYE_OF_SAHARA_A"],
	GameInfoTypes["FEATURE_EYE_OF_SAHARA_B"],
	GameInfoTypes["FEATURE_EYE_OF_SAHARA_C"],
	GameInfoTypes["FEATURE_MT_PAEKTU"]
}

local g_iWonderWithDummies = 24
local g_tNaturalWonderOwner = {}

local g_tNaturalWonderExists = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderExists[i] = false
	end

local g_tNaturalWonderSkip = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderSkip[i] = false
	end
	-- skip is used for multitle wonders, where all tiles give same building; to prevent deleting previously set building skip is used;
	g_tNaturalWonderSkip[16] = true
	g_tNaturalWonderSkip[21] = true
	g_tNaturalWonderSkip[22] = true

local g_tNaturalWonderRegularBuilding = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderRegularBuilding[i] = false
	end
	-- used to place regular building instead of dummy ones;
	g_tNaturalWonderRegularBuilding[24] = true

local g_tNaturalWonderX = {}
local g_tNaturalWonderY = {}

local g_tNaturalWonderDummy = {
	GameInfoTypes["BUILDING_SALAR_A_DUMMY"],
	GameInfoTypes["BUILDING_SALAR_B_DUMMY"],
	GameInfoTypes["BUILDING_EL_DORADO_DUMMY"],
	GameInfoTypes["BUILDING_POTOSI_DUMMY"],
	GameInfoTypes["BUILDING_CRATER_DUMMY"],
	GameInfoTypes["BUILDING_MESA_DUMMY"],
	GameInfoTypes["BUILDING_SOLOMONS_MINES_DUMMY"],
	GameInfoTypes["BUILDING_VOLCANO_DUMMY"],
	GameInfoTypes["BUILDING_FUJI_1_DUMMY"],
	GameInfoTypes["BUILDING_MT_SINAI_DUMMY"],
	GameInfoTypes["BUILDING_GEYSER_DUMMY"],
	GameInfoTypes["BUILDING_MT_EVEREST_DUMMY"],
	GameInfoTypes["BUILDING_REEF_DUMMY"],
	GameInfoTypes["BUILDING_GIBRALTAR_DUMMY"],
	GameInfoTypes["BUILDING_LAKE_VICTORIA_DUMMY"],
	GameInfoTypes["BUILDING_CAUSEWAY_DUMMY"],
	GameInfoTypes["BUILDING_CAUSEWAY_DUMMY"],
	GameInfoTypes["BUILDING_RETBA_DUMMY"],
	GameInfoTypes["BUILDING_LUMI_BAY_DUMMY"],
	GameInfoTypes["BUILDING_DALLOL_DUMMY"],
	GameInfoTypes["BUILDING_EYE_OF_SAHARA"],
	GameInfoTypes["BUILDING_EYE_OF_SAHARA"],
	GameInfoTypes["BUILDING_EYE_OF_SAHARA"],
	GameInfoTypes["BUILDING_MT_PAEKTU"]
}

local g_tNaturalWonderDummy2 = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderDummy2[i] = false
	end
	g_tNaturalWonderDummy2[9] = GameInfoTypes["BUILDING_FUJI_2_DUMMY"]

local g_tNaturalWonderDummy3 = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderDummy3[i] = false
	end
	g_tNaturalWonderDummy3[9] = GameInfoTypes["BUILDING_FUJI_3_DUMMY"]

local bMtPaektuBuilt = false



-- load game and check if they exists
function CheckIfNaturalWonderExists()
	for j = 0, Map.GetNumPlots() - 1 do
		local pPlot = Map.GetPlotByIndex(j)
		local eFeature = pPlot:GetFeatureType()

		for i, feature in ipairs(g_tNaturalWonder) do
			if eFeature == feature then
				g_tNaturalWonderX[i] = pPlot:GetX()
				g_tNaturalWonderY[i] = pPlot:GetY()
				g_tNaturalWonderExists[i] = true
			end
		end
	end
end
Events.LoadScreenClose.Add(CheckIfNaturalWonderExists)

function CheckIfBuildingsWereBuilt()
	for _, player in ipairs(Players) do
		-- MT. PAEKTU
		if player:CountNumBuildings(g_tNaturalWonderDummy[24]) == 1 then
			bMtPaektuBuilt = true
		end
	end
end
Events.LoadScreenClose.Add(CheckIfBuildingsWereBuilt)



function SetDummiesForOwnedNaturalWonders(ePlayer)
	local bSkip = false

	for i, existingFeature in ipairs(g_tNaturalWonderExists) do
		if existingFeature then
			local pPlayer = Players[ePlayer]
			local bHasNaturalWonderInRange = pPlayer:CountCityFeatures(g_tNaturalWonder[i]) >= 1
			
			if bHasNaturalWonderInRange then
				if not g_tNaturalWonderRegularBuilding[i] then
					g_tNaturalWonderOwner[i] = Map.GetPlot(g_tNaturalWonderX[i], g_tNaturalWonderY[i]):GetOwner()
					local pCapital = pPlayer:GetCapitalCity()
					

					if g_tNaturalWonderOwner[i] == ePlayer then
						pCapital:SetNumRealBuilding(g_tNaturalWonderDummy[i], 1)

						if g_tNaturalWonderDummy2[i] then
							pCapital:SetNumRealBuilding(g_tNaturalWonderDummy2[i], 1)
						end

						if g_tNaturalWonderDummy3[i] then
							pCapital:SetNumRealBuilding(g_tNaturalWonderDummy3[i], 1)
						end
					
						bSkip = g_tNaturalWonderSkip[i]
					else
						if not bSkip then
							pCapital:SetNumRealBuilding(g_tNaturalWonderDummy[i], 0)

							if g_tNaturalWonderDummy2[i] then
								pCapital:SetNumRealBuilding(g_tNaturalWonderDummy2[i], 0)
							end

							if g_tNaturalWonderDummy3[i] then
								pCapital:SetNumRealBuilding(g_tNaturalWonderDummy3[i], 0)
							end
						else
							bSkip = g_tNaturalWonderSkip[i]
						end
					end
				else
					-- MT. PAEKTU
					if g_tNaturalWonderDummy[i] == GameInfoTypes["BUILDING_MT_PAEKTU"] then
						if bMtPaektuBuilt == false then
							if pPlayer:CountNumBuildings(g_tNaturalWonderDummy[i]) == 0 then
								local pCity = Map.GetPlot(g_tNaturalWonderX[i], g_tNaturalWonderY[i]):GetWorkingCity()
								
								pCity:SetNumRealBuilding(g_tNaturalWonderDummy[i], 1)
								bMtPaektuBuilt = true
							end
						end
					end
				end
			else
				if bSkip then
					bSkip = g_tNaturalWonderSkip[i]
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(SetDummiesForOwnedNaturalWonders)
--------------------------------------------------------------
--------------------------------------------------------------
print("Loaded UniqueNaturalWondersAbilities.lua from MWfVP");
--------------------------------------------------------------
--------------------------------------------------------------
