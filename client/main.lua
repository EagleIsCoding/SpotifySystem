local NearZone = false

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        if not NearZone then
            Wait(2500)
        else
            Wait(50)
        end
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        SendNUIMessage({
            status = "position",
            x = pos.x,
            y = pos.y,
            z = pos.z
        })
    end
end) 


MusicZone = {
    
    {
        name = "accessoire_ambience",
        link = "https://www.youtube.com/watch?v=e_FddI2HI7A", -- https://www.youtube.com/watch?v=rBLuvEwIF5E
        dst = 9.0,
        starting = 60.0,
        pos = vector3(-1123.8, -1440.4, 6.2),
        max = 0.1,
    },
    {
        name = "casino_ambience",
        link = "https://www.youtube.com/watch?v=_ytFg0hFad8", -- https://www.youtube.com/watch?v=rBLuvEwIF5E
        dst = 100.0,
        starting = 60.0,
        pos = vector3(1110.3363037109,224.43264770508,-49.840751647949),
        max = 0.1,
    },
}

Citizen.CreateThread(function()
    Wait(2000)
    while true do
        NearZone = false
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        for k,v in pairs(MusicZone) do
            local dst = GetDistanceBetweenCoords(pCoords, v.pos, true)
            if not NearZone then
                if dst < v.starting then
                    NearZone = true
                    if soundExists(v.name) then
                        Resume(v.name)
                    else
                        PlayUrlPos(v.name, v.link, v.max, v.pos, true)
                        setVolumeMax(v.name, v.max)
                        Distance(v.name, v.dst)
                    end
                else
                    if soundExists(v.name) then
                        if not isPaused(v.name) then
                            Pause(v.name)
                        end
                    end
                end
            end
        end

        if not NearZone then
            Wait(350)
        else
            Wait(50)
        end
    end
end)