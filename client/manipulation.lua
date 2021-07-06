function Distance(name_, distance_)
    SendNUIMessage({
        status = "distance",
        name = name_,
        distance = distance_,
    })
    soundInfo[name_].distance = distance_
end

function Position(name_, pos)
    SendNUIMessage({
        status = "soundPosition",
        name = name_,
        x = pos.x,
        y = pos.y,
        z = pos.z,
    })
    soundInfo[name_].position = pos
    soundInfo[name_].id = name_
end 

function Destroy(name_)
    SendNUIMessage({
        status = "delete",
        name = name_
    })
    soundInfo[name_] = nil
end

function Resume(name_)
    SendNUIMessage({
        status = "resume",
        name = name_
    })
    soundInfo[name_].playing = true
    soundInfo[name_].paused = false
end

function Pause(name_)
    SendNUIMessage({
        status = "pause",
        name = name_
    })
    soundInfo[name_].playing = false
    soundInfo[name_].paused = true
end

function setVolume(name_, vol)
    SendNUIMessage({
        status = "volume",
        volume = vol,
        name = name_,
    })
    soundInfo[name_].volume = vol
end

function setVolumeMax(name_, vol)
    SendNUIMessage({
        status = "max_volume",
        volume = vol,
        name = name_,
    })
    soundInfo[name_].volume = vol
end