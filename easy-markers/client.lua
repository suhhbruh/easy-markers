
local markers = Config.Markers
local drawDistance = Config.DrawDistance

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, marker in ipairs(markers) do
            local distance = #(playerCoords - marker.coords)

            if distance < marker.radius then
                
                -- DrawMarker(23, marker.coords.x, marker.coords.y, marker.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, false, nil, nil, false) --Enable if you want marker to show when standing in location

               
                DrawText3D(marker.coords.x, marker.coords.y, marker.coords.z + 0.2, marker.text)
            elseif distance < drawDistance then
			
                -- Draw Marker letting player know they are close to location
                DrawMarker(23, marker.coords.x, marker.coords.y, marker.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 50, false, true, 2, false, nil, nil, false) --Look at https://docs.fivem.net/docs/game-references/markers/
				
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    local distance = #(vector3(pX, pY, pZ) - vector3(x, y, z))
    local scale = 1 / distance * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
		
        --DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 100) --Optional, Draws rectangle around text
    end
end
