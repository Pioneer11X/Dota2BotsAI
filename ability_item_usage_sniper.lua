

castAssassinateDesire = 0;

function AbilityUsageThink()

	-- I assume this gets the bot .. i.e., sniper here
	local npcBot = GetBot()
	
	-- Skip if we are already using an ability
	if ( npcBot:IsUsingAbility() ) then return end
	
	abilityASS = npcBot:GetAbilityByName("sniper_assassinate")
	
	castAssassinateDesire, castASSTarget = ConsiderAssassinate() 
	
	if ( castAssassinateDesire > 0.5 ) then
		npcBot:Action_UseAbilityOnEntity( abilityASS, castASSTarget )
		return
	end
	
end

-- Functions that help think

function CanCastAssassinateOnTarget( npcTarget )
	
	if npcTarget:IsInvulnerable() then
		return false
	else
		return true
	end
end

function ConsiderAssassinate()

	local npcBot = GetBot()
	
	-- Is is castable? 
	if ( note abilityASS:IsFullyCastable() ) then
		return BOT_ACTION_DESIRE_NONE, 0
	end
	
	--Add code if we want to run or something? No.. I guess that goes in the mode level.
	
	--Get the values for this skill
	local assRange = abilityASS:GetCastRange()
	local assDamage = abilityASS:GetAbilityDamage()
	
	-- If for some reason, we have a target and can kill them, kill them.
	
	local npcTarget = npcBot:GetTarget()
	
	if ( npcTarget ~= nil and CanCastAssassinateOnTarget( npcTarget ) )
	then
		if ( npcTarget:GetActualDamage( assDamage, DAMAGE_TYPE_MAGICAL ) > npcTarget:GetHealth() and UnitToUnitDistance ( npcTarget, npcBot ) < ( nCastRange + 200 ) )
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget
		end
	end
	
	
	-- Check for a chanelling enemu nearby
	local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE )
	
	for _, npcEnemy in pairs( tableNearbyEnemyHeroes )
	do
		if ( npcEnemy:IsChanneling() )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy
		end
	end