soundInfo = {}

defaultInfo = {
    volume = 1.0,
    url = "",
    id = "",
    position = nil,
    distance = 0,
    playing = false,
    paused = false,
    loop = false,
}

function getLink(name_)
    return soundInfo[name_].url
end

function getPosition(name_)
    return soundInfo[name_].position
end

function isLooped(name_)
    return soundInfo[name_].loop
end

function getInfo(name_)
    return soundInfo[name_]
end

function soundExists(name_)
    if soundInfo[name_] == nil then
        return false
    end
    return true
end 

function isPlaying(name_)
    if soundInfo[name_] == nil then return false end
    return soundInfo[name_].playing
end

function isPaused(name_)
    return soundInfo[name_].paused
end

function getDistance(name_)
    return soundInfo[name_].distance
end

function getVolume(name_)
    return soundInfo[name_].volume
end