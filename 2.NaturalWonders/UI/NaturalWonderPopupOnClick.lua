-- NaturalWonderPopupOnClick
-- Author: Adam
-- DateCreated: 9/29/2022 8:18:21 PM
--------------------------------------------------------------
include("IconSupport")
include("InstanceManager")
include("InfoTooltipInclude")
include("SupportFunctions")

local L = Locale.ConvertTextKey

local tSortTable
local eName = 0
local eOwn = 1
local eOwner = 2
local eDistance = 3
local eClosestCity = 4
local iSortMode = -1
local bSortReverse = false

local tNaturalWonders = {}
local bIsNaturalWonder = false
local bIsPseudoWonder = false
--------------------------------
-- REGISTERING FEATURES ON MAP
-- COUNTING FEATURES ON MAP
--------------------------------
for row in GameInfo.Features() do
	bIsNaturalWonder = row.NaturalWonder
	bIsPseudoWonder = (row.PseudoNaturalWonder == 1)
	
	if bIsNaturalWonder or bIsPseudoWonder then
		tNaturalWonders[row.ID] = {
			Description		= L(row.Description),
			PortraitIndex	= row.PortraitIndex,
			IconAtlas		= row.IconAtlas
		}
	end
end

local tPlotsIndexes = {}
local iNaturalWonderMaximumCount = 0

for i = 0, Map.GetNumPlots()-1, 1 do
	local pPlot = Map.GetPlotByIndex(i)

	if tNaturalWonders[pPlot:GetFeatureType()] ~= nil then
		table.insert(tPlotsIndexes, i)
		iNaturalWonderMaximumCount = iNaturalWonderMaximumCount + 1
	end
end
--------------------------------
-- SUPPORT FUNCTIONS
--------------------------------
function CheckDistance(pPlayer, pPlot)
	local iMinDistance = 10000
	local sClosestCity = ""

	for city in pPlayer:Cities() do
		local iCityX = city:GetX()
		local iCityY = city:GetY()
		
		local iPlotDistance = Map.PlotDistance(iCityX, iCityY, pPlot:GetX(), pPlot:GetY())
		
		if iPlotDistance < iMinDistance then
			iMinDistance = iPlotDistance
			sClosestCity = city:GetName()
		end
	end

	return iMinDistance, sClosestCity
end
--------------------------------
-- CLICK SUPPORT FUNCTIONS
--------------------------------
function OnNaturalWonderLeftClick(eFeature)
    print("LEFT CLICK!", eFeature)
end

function OnNaturalWonderRightClick(x, y)
    local pPlot = Map.GetPlot(x, y)
    
	if pPlot ~= nil then
    	UI.LookAt(pPlot)
	end
end
--------------------------------
-- MAIN FUNCTION
--------------------------------
function ShowHideHandler(bIsHide, bInitState)
    -- clearing the stacks!
	Controls.NaturalWonderGridStack:DestroyAllChildren()

	local ePlayer = Game.GetActivePlayer()
	local pPlayer = Players[ePlayer]
	
	-- top of the panel
	CivIconHookup(ePlayer, 64, Controls.Icon, Controls.CivIconBG, Controls.CivIconShadow, false, true)
    
    local iNaturalWonderFoundCount = 0
	tSortTable = {}
	    	
	for _, index in pairs(tPlotsIndexes) do
		local pPlot = Map.GetPlotByIndex(index)
		local ePlotOwner = pPlot:GetOwner()
		local pPlotOwner, pPlotOwnerTeam
		local iDistance, sClosestCity = CheckDistance(pPlayer, pPlot) -- measures distance from wonder plot to closest city of all player's cities
		local sDistanceText = ""
		local bRevealed = pPlot:IsRevealed(Game.GetActiveTeam(), false) -- determines if the NW is shown in the panel
		
		-- checking if player owning the wonder was met
		if ePlotOwner ~= -1 then
			pPlotOwner = Players[ePlotOwner]
			pPlotOwnerTeam = Teams[pPlotOwner:GetTeam()]

			if not pPlotOwnerTeam:IsHasMet(Game.GetActiveTeam()) then
				ePlotOwner = -2 -- haven't yet met this player
			end 
		end
        
        -- setting the distance text (only if there's at least one city)
		if iDistance ~= 10000 then
			sDistanceText = L("TXT_KEY_NATURAL_WONDER_DISTANCE", iDistance, sClosestCity)
		end
		
		if bRevealed then
			local instance = {}
			ContextPtr:BuildInstanceForControl("NaturalWonderTile", instance, Controls.NaturalWonderGridStack)
			
			local sortEntry = {}
			tSortTable[tostring(instance.NW)] = sortEntry
			
			local eFeature = pPlot:GetFeatureType()
			local naturalWonder = tNaturalWonders[eFeature]
			
			-- main icon
			IconHookup(naturalWonder.PortraitIndex, 64, naturalWonder.IconAtlas, instance.NaturalWonderButtonIcon)
			
			--  wonder name/description
			instance.NaturalWonderButtonText:SetText(naturalWonder.Description)
			sortEntry.Name = naturalWonder.Description
			
			-- buttons
			instance.NaturalWonderButton:RegisterCallback(Mouse.eLClick, OnNaturalWonderLeftClick)
			instance.NaturalWonderButton:SetVoid1(eFeature)
			instance.NaturalWonderButton:RegisterCallback(Mouse.eRClick, OnNaturalWonderRightClick)
			instance.NaturalWonderButton:SetVoids(pPlot:GetX(), pPlot:GetY())
			
			-- ownership
			if ePlotOwner == ePlayer then
				instance.NaturalWonderOwnership:SetText(L("TXT_KEY_NATURAL_WONDER_OWNERSHIP_YES"))
				sortEntry.Own = "Yes"
			else
			    sortEntry.Own = "No"
			end
			
			-- current owner
			if ePlotOwner == -2 then
				IconHookup(5, 45, "KRIS_SWORDSMAN_PROMOTION_ATLAS", instance.NaturalWonderOwnerIconBG)
				instance.NaturalWonderOwnerIconBG:SetHide(false)
				--instance.NaturalWonderOwnerIconBG:SetOffset(Vector2(-1,0))
				sortEntry.Owner = "ZZY"
			elseif ePlotOwner ~= -1 then
        		CivIconHookup(ePlotOwner, 45, instance.NaturalWonderOwnerIcon, instance.NaturalWonderOwnerIconBG, instance.NaturalWonderOwnerIconShadow, false, true)
				instance.NaturalWonderOwnerIconBG:SetHide(false)
				--instance.NaturalWonderOwnerIconBG:SetOffset(Vector2(0,0))
				sortEntry.Owner = pPlotOwner:GetName()
        	else
				instance.NaturalWonderOwnerIconBG:SetHide(true)
				sortEntry.Owner = "ZZZ"
        	end
			
			-- distance from the closest city
			instance.NaturalWonderDistance:SetText(sDistanceText)
			sortEntry.Distance = iDistance
			sortEntry.ClosestCity = sClosestCity
			
			-- counter for different text label
			iNaturalWonderFoundCount = iNaturalWonderFoundCount + 1
		end
	end

	local bIsFoundAnyNaturalWonders = iNaturalWonderFoundCount > 0
	Controls.NoNaturalWonder:SetHide(bIsFoundAnyNaturalWonders)
    
	local sCountColor = ""
	if iNaturalWonderFoundCount == 0 then
		sCountColor = "[COLOR_NEGATIVE_TEXT]"
	elseif iNaturalWonderFoundCount == iNaturalWonderMaximumCount then
		sCountColor = "[COLOR_POSITIVE_TEXT]"
	else
		sCountColor = "[COLOR_YIELD_GOLD]"
	end
	
    local sNaturalWondersCount = L("TXT_KEY_NATURAL_WONDER_COUNT", sCountColor, iNaturalWonderFoundCount, iNaturalWonderMaximumCount)
    Controls.NaturalWondersFound:SetText(sNaturalWondersCount)
    
	Controls.NaturalWonderGridStack:CalculateSize()
	Controls.NaturalWonderScrollPanel:CalculateInternalSize()
	
	if not bIsHide then
		bSortReverse = false
		OnSort(eName)
	end
end
ContextPtr:SetShowHideHandler(ShowHideHandler)
ContextPtr:SetHide(true)
--------------------------------
-- SORTING
--------------------------------
function SortFunction(a, b)
    local valueA, valueB
	
	local entryA = tSortTable[tostring(a)]
    local entryB = tSortTable[tostring(b)]

	local bReversedOrder = false
	
    if entryA == nil or entryB == nil then 
		if entryA and entryB == nil then
			return false
		elseif  entryA == nil and entryB then
			return true
		else
			if bSortReverse then
				return tostring(a) > tostring(b)
			else
				return tostring(a) < tostring(b)
			end
        end
    else
		if iSortMode == eName then
			valueA = entryA.Name
			valueB = entryB.Name
		elseif iSortMode == eOwn then
			valueA = entryA.Own
			valueB = entryB.Own
			bReversedOrder = true
		elseif iSortMode == eOwner then
			valueA = entryA.Owner
			valueB = entryB.Owner
		elseif iSortMode == eDistance then
			valueA = entryA.Distance
			valueB = entryB.Distance
		elseif iSortMode == eClosestCity then
			valueA = entryA.ClosestCity
			valueB = entryB.ClosestCity
		end
	    
		if valueA == valueB then
			if iSortMode == eDistance then
				valueA = entryA.ClosestCity
				valueB = entryB.ClosestCity
			elseif iSortMode == eClosestCity then
				valueA = entryA.Distance
				valueB = entryB.Distance
			else
				valueA = entryA.Name
				valueB = entryB.Name
			end
		end

		if bReversedOrder then
			if bSortReverse then
				return valueA < valueB
			else
				return valueA > valueB
			end
		else
			if bSortReverse then
				return valueA > valueB
			else
				return valueA < valueB
			end
		end
    end
end

function OnSort(type)
    if iSortMode == type then
        bSortReverse = not bSortReverse
    else
        bSortReverse = false
    end

    iSortMode = type
    Controls.NaturalWonderGridStack:SortChildren(SortFunction)
end

function OnSortAlternative(type)
	if type == eDistance then
		type = eClosestCity
	end
	
	if iSortMode == type then
        bSortReverse = not bSortReverse
    else
        bSortReverse = false
    end

    iSortMode = type
    Controls.NaturalWonderGridStack:SortChildren(SortFunction)
end
Controls.NaturalWonderHeaderName:RegisterCallback(Mouse.eLClick, OnSort)
Controls.NaturalWonderHeaderOwn:RegisterCallback(Mouse.eLClick, OnSort)
Controls.NaturalWonderHeaderOwner:RegisterCallback(Mouse.eLClick, OnSort)
Controls.NaturalWonderHeaderDistance:RegisterCallback(Mouse.eLClick, OnSort)
Controls.NaturalWonderHeaderDistance:RegisterCallback(Mouse.eRClick, OnSortAlternative)
Controls.NaturalWonderHeaderName:SetVoid1(eName)
Controls.NaturalWonderHeaderOwn:SetVoid1(eOwn)
Controls.NaturalWonderHeaderOwner:SetVoid1(eOwner)
Controls.NaturalWonderHeaderDistance:SetVoid1(eDistance)
--------------------------------
-- CLOSING
--------------------------------
function OnClose()
	ContextPtr:SetHide(true)
end
Controls.CloseButton:RegisterCallback(Mouse.eLClick, OnClose)

function InputHandler(uiMsg, wParam, lParam)
	if uiMsg == KeyEvents.KeyDown then
		if wParam == Keys.VK_ESCAPE then
			OnClose()
			return true
		end
	end
end
ContextPtr:SetInputHandler(InputHandler)
--------------------------------
-- DIPLO CORNER (ICON ADDITION)
--------------------------------
function OnDiploCornerPopup()
	ContextPtr:SetHide(false)
end

function OnAdditionalInformationDropdownGatherEntries(additionalEntries)
	table.insert(additionalEntries, {text=L("TXT_KEY_NATURAL_WONDER_DIPLO_CORNER_HOOK"), call=OnDiploCornerPopup, art="WonderPlannerLogo.dds"})
end
LuaEvents.AdditionalInformationDropdownGatherEntries.Add(OnAdditionalInformationDropdownGatherEntries)
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()