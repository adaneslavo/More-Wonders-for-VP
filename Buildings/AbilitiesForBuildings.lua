local ePromotionYerba = GameInfoTypes.PROMOTION_FLETCHER

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
