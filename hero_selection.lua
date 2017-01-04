

----------------------------------------------------------------------------------------------------

MyBots = {"npc_dota_hero_sniper"}

function Think()
	
	-- Get the current Game Mode --
	
	local GameMode = GetGameMode()
	
	-- If it is 1 v 1, then pick Sniper for Dire. --
	if ( GameMode == GAMEMODE_1V1MID) then
		SelectHero( 5, MyBots[0] )
		
	-- If Game Mode is not 1 v 1 Mid.
	else
		local IDs = GetTeamPlayers(GetTeam())
		for i, id in pairs(IDs) do
			if IsPlayerBot(id) then
				SelectHero(id, MyBots[i])
			end
		end
	end
	
end

---------------------------------------------------------------------------------------------------