-- NaturalWonderPopupOnClick
-- Author: Adam
-- DateCreated: 9/29/2022 8:18:21 PM
--------------------------------------------------------------
include("IconSupport")
include("InstanceManager")

local tNaturalWonders = {}
local bIsNaturalWonder = false
local bIsPseudoWonder = false

for row in GameInfo.Features() do
	bIsNaturalWonder = row.NaturalWonder
	bIsPseudoWonder = (row.PseudoNaturalWonder == 1)
	print("NWPopupOnClick", row.ID, bIsNaturalWonder, bIsPseudoWonder)
	
	if bIsNaturalWonder or bIsPseudoWonder then
		tNaturalWonders[row.ID] = true
		print("NWPopupOnClick", row.Type, "added to the table")
	end
end

function OnNaturalWonderClick()
    print("NW clicked successfully!")
end
	
for i = 0, Map.GetNumPlots()-1, 1 do
	local pPlot = Map.GetPlotByIndex(i)
	print("NWPopupOnClick", i, tNaturalWonders[pPlot:GetFeatureType()])
	if tNaturalWonders[pPlot:GetFeatureType()] then
		local instance = {}
		ContextPtr:BuildInstanceForControl("NaturalWonderTile", instance, Controls.NaturalWonderTileContainer)
		print("NWPopupOnClick", i, "instance created")
		
		local wx, wy, wz = GridToWorld(pPlot:GetX(), pPlot:GetY())
		print("NWPopupOnClick", i, wx, wy, wz)
		instance.NaturalWonderButtonFrame:SetWorldPositionVal(wx, wy, 0)
		print("NWPopupOnClick", i, "instance placed")
		
		instance.NaturalWonderButtonFrame:SetHide(false)
		instance.NaturalWonderButton:SetHide(false)
		print("NWPopupOnClick", i, "instance shown")
			
		instance.NaturalWonderButton:RegisterCallback(Mouse.eLClick, OnNaturalWonderClick)
		print("NWPopupOnClick", i, "instance clickbait made")
		
		instance.NaturalWonderButton:SetVoids(wx, wy)
		print("NWPopupOnClick", i, "instance clickbait position added")

		instance.NaturalWonderButton:GetID()
	end
end