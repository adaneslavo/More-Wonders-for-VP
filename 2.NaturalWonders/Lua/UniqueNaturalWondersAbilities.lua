print("Loading UniqueNaturalWondersAbilities.lua from MWfVP");
--------------------------------------------------------------
-- Natural Wonders Abilities
-- Dec 13, 2017: Retrofitted for Vox Populi, Infixo
-- May 11, 2020: Created, adan_eslavo
--------------------------------------------------------------
local g_tNaturalWonder = {
	GameInfoTypes["FEATURE_SALAR_A"], -- 1
	GameInfoTypes["FEATURE_SALAR_B"],
	GameInfoTypes["FEATURE_EL_DORADO"],
	GameInfoTypes["FEATURE_POTOSI"],
	GameInfoTypes["FEATURE_CRATER"], --5
	GameInfoTypes["FEATURE_MESA"],
	GameInfoTypes["FEATURE_SOLOMONS_MINES"],
	GameInfoTypes["FEATURE_VOLCANO"],
	GameInfoTypes["FEATURE_FUJI"],
	GameInfoTypes["FEATURE_MT_SINAI"], -- 10
	GameInfoTypes["FEATURE_GEYSER"],
	GameInfoTypes["FEATURE_MT_EVEREST"],
<<<<<<< Updated upstream
	GameInfoTypes["FEATURE_REEF"],
=======
	GameInfoTypes["FEATURE_NEW_REEF_A"],
	GameInfoTypes["FEATURE_NEW_REEF_B"],
	GameInfoTypes["FEATURE_NEW_REEF_C"], -- 15
>>>>>>> Stashed changes
	GameInfoTypes["FEATURE_GIBRALTAR"],
	GameInfoTypes["FEATURE_LAKE_VICTORIA"],
	GameInfoTypes["FEATURE_CAUSEWAY_A"],
	GameInfoTypes["FEATURE_CAUSEWAY_B"],
<<<<<<< Updated upstream
	GameInfoTypes["FEATURE_RETBA"],
	GameInfoTypes["FEATURE_DALLOL"]
=======
	GameInfoTypes["FEATURE_RETBA"], -- 20
	GameInfoTypes["FEATURE_LUMI_BAY"],
	GameInfoTypes["FEATURE_DALLOL"],
	GameInfoTypes["FEATURE_EYE_OF_SAHARA_A"],
	GameInfoTypes["FEATURE_EYE_OF_SAHARA_B"],
	GameInfoTypes["FEATURE_EYE_OF_SAHARA_C"], -- 25
	GameInfoTypes["FEATURE_MT_PAEKTU"],
	GameInfoTypes["FEATURE_MT_KAILASH"],
	GameInfoTypes["FEATURE_KILIMANJARO"],
	GameInfoTypes["FEATURE_ULURU"]
>>>>>>> Stashed changes
}
local iWonderWithDummies = 19

<<<<<<< Updated upstream
=======
local g_iWonderWithDummies = #g_tNaturalWonder
>>>>>>> Stashed changes
local g_tNaturalWonderOwner = {}
local g_tNaturalWonderExists = {}
	for i = 1, iWonderWithDummies do
		g_tNaturalWonderExists[i] = false
	end

local g_tNaturalWonderSkip = {}
	for i = 1, iWonderWithDummies do
		g_tNaturalWonderSkip[i] = false
	end
<<<<<<< Updated upstream
	g_tNaturalWonderSkip[16] = true
=======
	-- skip is used for multitle wonders, where all tiles give same building; to prevent deleting previously set building skip is used;
	-- g_tNaturalWonderSkip[18] = true -- unused since v0.16

local g_tNaturalWonderRegularBuilding = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderRegularBuilding[i] = false
	end
	-- used to place regular building instead of dummy ones;
	g_tNaturalWonderRegularBuilding[26] = true
>>>>>>> Stashed changes

local g_tNaturalWonderX = {}
local g_tNaturalWonderY = {}

local g_tNaturalWonderDummy = {
	GameInfoTypes["BUILDING_SALAR_A_DUMMY"], -- 1
	GameInfoTypes["BUILDING_SALAR_B_DUMMY"],
	GameInfoTypes["BUILDING_EL_DORADO_DUMMY"],
	GameInfoTypes["BUILDING_POTOSI_DUMMY"],
	GameInfoTypes["BUILDING_CRATER_DUMMY"], -- 5
	GameInfoTypes["BUILDING_MESA_DUMMY"],
	GameInfoTypes["BUILDING_SOLOMONS_MINES_DUMMY"],
	GameInfoTypes["BUILDING_VOLCANO_DUMMY"],
	GameInfoTypes["BUILDING_FUJI_1_DUMMY"],
	GameInfoTypes["BUILDING_MT_SINAI_DUMMY"], -- 10
	GameInfoTypes["BUILDING_GEYSER_DUMMY"],
	GameInfoTypes["BUILDING_MT_EVEREST_DUMMY"],
	GameInfoTypes["BUILDING_NEW_REEF_A_DUMMY"],
	GameInfoTypes["BUILDING_NEW_REEF_B_DUMMY"],
	GameInfoTypes["BUILDING_NEW_REEF_C_DUMMY"], -- 15
	GameInfoTypes["BUILDING_GIBRALTAR_DUMMY"],
	GameInfoTypes["BUILDING_LAKE_VICTORIA_DUMMY"],
<<<<<<< Updated upstream
	GameInfoTypes["BUILDING_CAUSEWAY_DUMMY"],
	GameInfoTypes["BUILDING_CAUSEWAY_DUMMY"],
	GameInfoTypes["BUILDING_RETBA_DUMMY"],
	GameInfoTypes["BUILDING_DALLOL_DUMMY"]
=======
	GameInfoTypes["BUILDING_CAUSEWAY_A_DUMMY"],
	GameInfoTypes["BUILDING_CAUSEWAY_B_DUMMY"],
	GameInfoTypes["BUILDING_RETBA_DUMMY"], -- 20
	GameInfoTypes["BUILDING_LUMI_BAY_DUMMY"],
	GameInfoTypes["BUILDING_DALLOL_DUMMY"],
	GameInfoTypes["BUILDING_EYE_OF_SAHARA_A_DUMMY"],
	GameInfoTypes["BUILDING_EYE_OF_SAHARA_B_DUMMY"],
	GameInfoTypes["BUILDING_EYE_OF_SAHARA_C_DUMMY"], -- 25
	GameInfoTypes["BUILDING_MT_PAEKTU"],
	GameInfoTypes["BUILDING_MT_KAILASH_DUMMY"],
	GameInfoTypes["BUILDING_KILIMANJARO_DUMMY"],
	GameInfoTypes["BUILDING_ULURU_DUMMY"]
>>>>>>> Stashed changes
}

local g_tNaturalWonderDummy2 = {}
	for i = 1, iWonderWithDummies do
		g_tNaturalWonderDummy2[i] = false
	end
	g_tNaturalWonderDummy2[9] = GameInfoTypes["BUILDING_FUJI_2_DUMMY"]

local g_tNaturalWonderDummy3 = {}
	for i = 1, iWonderWithDummies do
		g_tNaturalWonderDummy3[i] = false
	end
	g_tNaturalWonderDummy3[9] = GameInfoTypes["BUILDING_FUJI_3_DUMMY"]

<<<<<<< Updated upstream
=======
local g_tNaturalWonderDummyPolicy = {}
	for i = 1, g_iWonderWithDummies do
		g_tNaturalWonderDummyPolicy[i] = false
	end
	g_tNaturalWonderDummyPolicy[20] = GameInfoTypes["POLICY_RETBA_DUMMY"]
	g_tNaturalWonderDummyPolicy[21] = GameInfoTypes["POLICY_LUMI_BAY_DUMMY"]


-- initializing regular building booleans
local bMtPaektuBuilt = false

for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local pPlayer = Players[i]
	print("Paektu boolean:", pPlayer:CountNumBuildings(g_tNaturalWonderDummy[26]))
	if pPlayer:CountNumBuildings(g_tNaturalWonderDummy[26]) > 0 then
		bMtPaektuBuilt = true
		break
	end
end



>>>>>>> Stashed changes
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

				print("PlotTypes", eFeature, pPlot:GetPlotType())
			end
		end
	end
end
Events.LoadScreenClose.Add(CheckIfNaturalWonderExists)

<<<<<<< Updated upstream
=======
function CheckIfBuildingsWereBuilt()
	for _, player in ipairs(Players) do
		-- MT. PAEKTU
		if player:CountNumBuildings(g_tNaturalWonderDummy[26]) == 1 then
			bMtPaektuBuilt = true
		end
	end
end
Events.LoadScreenClose.Add(CheckIfBuildingsWereBuilt)



>>>>>>> Stashed changes
function SetDummiesForOwnedNaturalWonders(ePlayer)
	local bSkip = false

	for i, existingFeature in ipairs(g_tNaturalWonderExists) do
		if existingFeature then
			local pPlayer = Players[ePlayer]
			local bHasNaturalWonderInRange = pPlayer:CountCityFeatures(g_tNaturalWonder[i]) >= 1
			
			if bHasNaturalWonderInRange then
				g_tNaturalWonderOwner[i] = Map.GetPlot(g_tNaturalWonderX[i], g_tNaturalWonderY[i]):GetOwner()
<<<<<<< Updated upstream
				
				if g_tNaturalWonderOwner[i] == ePlayer then
					pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy[i], 1)

					if g_tNaturalWonderDummy2[i] then
						pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy2[i], 1)
					end

					if g_tNaturalWonderDummy3[i] then
						pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy3[i], 1)
					end
					
					bSkip = g_tNaturalWonderSkip[i]
				else
					if not bSkip then
						pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy[i], 0)
=======

				if not g_tNaturalWonderRegularBuilding[i] then
					local pCapital = pPlayer:GetCapitalCity()
					
					if g_tNaturalWonderOwner[i] == ePlayer then
						if g_tNaturalWonderDummy[i] then
							pCapital:SetNumRealBuilding(g_tNaturalWonderDummy[i], 1)
						end
>>>>>>> Stashed changes

						if g_tNaturalWonderDummy2[i] then
							pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy2[i], 0)
						end

						if g_tNaturalWonderDummy3[i] then
							pPlayer:GetCapitalCity():SetNumRealBuilding(g_tNaturalWonderDummy3[i], 0)
						end
<<<<<<< Updated upstream
					else
						bSkip = g_tNaturalWonderSkip[i]
=======

						if g_tNaturalWonderDummyPolicy[i] then
							pPlayer:SetHasPolicy(g_tNaturalWonderDummyPolicy[i], true)
						end
					
						bSkip = g_tNaturalWonderSkip[i]
					else
						if not bSkip then
							if g_tNaturalWonderDummy[i] then
								pCapital:SetNumRealBuilding(g_tNaturalWonderDummy[i], 0)
							end							

							if g_tNaturalWonderDummy2[i] then
								pCapital:SetNumRealBuilding(g_tNaturalWonderDummy2[i], 0)
							end

							if g_tNaturalWonderDummy3[i] then
								pCapital:SetNumRealBuilding(g_tNaturalWonderDummy3[i], 0)
							end

							if g_tNaturalWonderDummyPolicy[i] then
								pPlayer:SetHasPolicy(g_tNaturalWonderDummyPolicy[i], false)
							end
						else
							bSkip = g_tNaturalWonderSkip[i]
						end
					end
				else
					-- MT. PAEKTU
					if g_tNaturalWonderDummy[i] == GameInfoTypes["BUILDING_MT_PAEKTU"] and bMtPaektuBuilt == false then
						if g_tNaturalWonderOwner[i] == ePlayer then
							local pCity = Map.GetPlot(g_tNaturalWonderX[i], g_tNaturalWonderY[i]):GetWorkingCity()
								
							pCity:SetNumRealBuilding(g_tNaturalWonderDummy[i], 1)
							bMtPaektuBuilt = true
						end
>>>>>>> Stashed changes
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
