-- Spawn override

firstTick = false

Citizen.CreateThread(function()
while not firstTick and NetworkIsSessionStarted() do
	Wait(0)
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()

    exports.spawnmanager:setAutoSpawnCallback(function()
        if spawnLock then
            return
        end

        --spawnLock = true

        TriggerEvent('playerSpawn')
		
		--local vec3, heading = NetworkGetRespawnResult(GetRandomIntInRange(1,64))
		-- local randomX, randomY = math.random(-25,25)+.0,math.random(-25,25)+.0
		local randomX, randomY = GetRandomFloatInRange(-25,25),GetRandomFloatInRange(-25,25)
		local x,y,z=table.unpack(GetEntityCoords(GetPlayerPed(-1)))
		-- vec3 = GetClosestVehicleNode(x+randomX,y+randomY,z, 1, 100.0, 2.5)
		success, vec3, heading = GetRandomVehicleNode(x,y,z, 150.0, 1, true, true)
		-- 
		Citizen.Trace("Spawning at: "..tostring(vec3).."\n"..tostring(heading).."\n")
		
		if success == false then 
			-- success, vec3 = GetSafeCoordForPed(x,y,z,false,16) 
		end
		
		-- success = true
		-- heading = 0
		if success then
			x,y,z=table.unpack(vec3)
		else
			x,y,z=x,y,z -- use player pos
		end
		local model = GetEntityModel(GetPlayerPed(-1))
		
		local success,vec3 = GetSafeCoordForPed(x, y, z, false, 16)
		
		local x,y,z = table.unpack(vec3)
		
		if firstTick == false then
			exports.spawnmanager:spawnPlayer({x = 151.35, y = -1035.25, z = 29.3, model = model})
		end
		
		-- DoScreenFadeOut(3000)
		
		-- Wait(3000)
		
		-- StartPlayerSwitch(GetPlayerPed(-1), GetPlayerPed(-1), 8, 2)
		
		-- StartPlayerSwitch(GetPlayerPed(-1), GetPlayerPed(-1), 8, 2)
		
		-- Wait(3000)
		
		NetworkResurrectLocalPlayer(x,y,z,heading,false,false)
		
		-- Wait(500)
		-- DoScreenFadeIn(3000)
		
		-- StartPlayerSwitch(GetPlayerPed(-1), GetPlayerPed(-1), 0, 2)
		
		firstTick = true
		
		--if not IsEntityDead(GetPlayerPed(-1)) then spawnLock = false end
    end)
end
end)