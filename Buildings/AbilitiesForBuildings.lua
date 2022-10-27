local ePromotionYerba = GameInfoTypes.PROMOTION_FLETCHER

local tExcludedUnitClasses = {
	GameInfoTypes.UNITCLASS_HELICOPTER_GUNSHIP,
	GameInfoTypes.UNITCLASS_ANTI_TANK_GUN,
	GameInfoTypes.UNITCLASS_CAVALRY,
	GameInfoTypes.UNITCLASS_MUSKETMAN,
	GameInfoTypes.UNITCLASS_CUIRASSIER,
	GameInfoTypes.UNITCLASS_VP_SLINGER,
	GameInfoTypes.UNITCLASS_MACHINE_GUN,
	GameInfoTypes.UNITCLASS_GATLINGGUN,
	GameInfoTypes.UNITCLASS_BAZOOKA
}

function OnUpgradeTakeOutFletcher(iPlayer, iOldUnit, iNewUnit, bGoodyHut)
	local pPlayer = Players[iPlayer]
	local pOldUnit = pPlayer:GetUnitByID(iOldUnit)
	local pNewUnit = pPlayer:GetUnitByID(iNewUnit)
	print("OnPromoteTest", pPlayer:GetName(), pOldUnit:GetName(), pNewUnit:GetName())
	if pOldUnit:IsHasPromotion(ePromotionYerba) then
		local eUnitClass = pNewUnit:GetUnitClassType()
		print("OnPromoteTest-class", eUnitClass)
	
		for _, class in ipairs(tExcludedUnitClasses) do
			print("OnPromoteTest-class-for", eUnitClass, class)
	
			if class == eUnitClass then
				print("OnPromoteTest-class-match!!!")
	
				pNewUnit:SetHasPromotion(ePromotionYerba, false)
				break
			end
		end
	end
end
GameEvents.UnitUpgraded.Add(OnUpgradeTakeOutFletcher)

function OnCityTrainTakeOutFletcher(iPlayer, iCity, iUnit, bGold, bFaith)

end
GameEvents.CityTrained.Add(OnCityTrainTakeOutFletcher)

function OnCombatInstaKill(iAttackingPlayer, iAttackingUnit, iAttackerDamage, iAttackerFinalDamage, iAttackerMaxHP, iDefendingPlayer, iDefendingUnit, iDefenderDamage, iDefenderFinalDamage, iDefenderMaxHP, iInterceptingPlayer, iInterceptingUnit, iInterceptorDamage, iPlotX, iPlotY)
	local pAttackingPlayer = Players[iAttackingPlayer]
	
	if not (pAttackingPlayer and (iDefenderFinalDamage < iDefenderMaxHP)) then return end
	
	local pAttackingUnit = pAttackingPlayer:GetUnitByID(iAttackingUnit)
	
	if pAttackingUnit ~= nil and pAttackingUnit:IsHasPromotion(ePromotionYerba) then
		local iChanceToKill = math.random(100)
		
		if iChanceToKill <= 5 then
			local pDefendingPlayer = Players[iDefendingPlayer]
			local pDefendingUnit = pDefendingPlayer:GetUnitByID(iDefendingUnit)
			local eDefendingUnitType = pDefendingUnit:GetUnitType()

			pDefendingUnit:Kill(false, iAttackingPlayer)
			
			if pAttackingPlayer:IsHuman() and pAttackingPlayer:IsTurnActive() then
				pAttackingPlayer:AddNotification(NotificationTypes.NOTIFICATION_UNIT_DIED, 
					'Enemy unit was poisoned with your arrow and died in pain!', 
					'Poisoned Enemy', 
					pAttackingUnit:GetX(), pAttackingUnit:GetY(), eDefendingUnitType)
			end

			if pDefendingPlayer:IsHuman() then
				pDefendingPlayer:AddNotification(NotificationTypes.NOTIFICATION_UNIT_DIED, 
					'Poisoned arrow hit your unit causing letal infection! Unfortunately, it died horribly!', 
					'Your unit was poisoned!', 
					pAttackingUnit:GetX(), pAttackingUnit:GetY(), eDefendingUnitType)
			end
		end
	end
end
GameEvents.CombatEnded.Add(OnCombatInstaKill)
