ESX  = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local open = false
local SliderProgress = 1
local StartMusic = false
local IsPaused = false
local SpotifyMenu = RageUI.CreateMenu(false, "Action(s) disponibles", 0, 0, "banner_spotify", "banner_spotify")
local SpotifyAddMusicMenu = RageUI.CreateSubMenu(SpotifyMenu, false, "Action(s) disponibles", 0, 0, "banner_spotify", "banner_spotify")
local SpotifyPlayerMusicMenu = RageUI.CreateSubMenu(SpotifyMenu, false, "Action(s) disponibles", 0, 0, "banner_spotify", "banner_spotify")
SpotifyMenu.Closed = function()   
    RageUI.Visible(SpotifyMenu, false)
    open = false
end 
    
function OpenSpotifyMenu()
    if open then 
        open = false 
        RageUI.Visible(SpotifyMenu,false)
        return
    else
        open = true 
        RageUI.Visible(SpotifyMenu, true)
        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(SpotifyMenu, function()
                    RageUI.Button('Ajouter une musique', false , {RightLabel = "→"}, true , {}, SpotifyAddMusicMenu)
                    RageUI.Button('Vos musiques', false , {RightLabel = "→"}, true , {
                        onSelected = function()
                            RefreshPlayerMusic()
                        end
                    },SpotifyPlayerMusicMenu)
                    if StartMusic then
                        RageUI.Separator("~g~Musique en cours:~s~ "..CurrentSong)
                        RageUI.SliderProgress('Volume', SliderProgress, 10, false, {
                            ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
                            ProgressColor = { R = 30, G = 215, B = 96, A = 255 },
                        }, true, {
                            onSliderChange = function(Index)
                                SliderProgress = Index
                                setVolume("Music", Index/10)
                            end
                        })
                        if not IsPaused then 
                            RageUI.Button("Mettre en pause", false , {RightLabel = "→"}, true , {
                                onSelected = function()
                                    Pause("Music")
                                    IsPaused = true
                                end
                            })
                        else
                            RageUI.Button("Relancer", false , {RightLabel = "→"}, true , {
                                onSelected = function()
                                    Resume("Music")
                                    IsPaused = false
                                end
                            })
                        end
                        RageUI.Button('~r~Arrêter la musique', false , {RightLabel = "→"}, true , {
                            onSelected = function()
                                Destroy("Music")
                                StartMusic = false
                            end
                        })
                    end
                end)
                RageUI.IsVisible(SpotifyAddMusicMenu, function()
                    RageUI.Button("Nom de la musique", false, {RightLabel = current_song}, true, {
                        onSelected = function()
                            local NameOfSong = KeyboardInput("add_music", "Nom de votre musique", "", 15)
                            current_song = NameOfSong
                        end
                    })
                    RageUI.Button("ID youtube de la musique", false, {RightLabel = current_url}, true, {
                        onSelected = function()
                            local URL = KeyboardInput("add_url", "ID Youtube de votre musique", "", 15)
                            print(URL)
                            current_url = URL
                            print(current_url)
                        end
                    })
                    if current_song and current_url then 
                        RageUI.Button("Ajouter la musique", false, {RightLabel = "→", Color = {BackgroundColor = {30, 215, 96, 80}}}, true, {
                            onSelected = function()
                                TriggerServerEvent("SpotifySystem:AddMusic", current_song, current_url)
                                Wait(100)
                                current_song = "" 
                                current_url= ""
                            end
                        })
                    else
                        RageUI.Button("Ajouter la musique", false, {RightLabel = "→", Color = {BackgroundColor = {30, 215, 96, 80}}}, false, {})
                    end
                end)
                RageUI.IsVisible(SpotifyPlayerMusicMenu, function()
                    for i=1, #YourPlayerMusic do
                        RageUI.Button(YourPlayerMusic[i].name, false, {RightLabel = "~g~Écouter~s~ →"}, true , {
                            onSelected = function()
                                PlayUrl("Music", "https://www.youtube.com/watch?v="..YourPlayerMusic[i].url, 0.1, false)
                                CurrentSong = YourPlayerMusic[i].name
                                StartMusic = true
                            end
                        })
                    end
                end)
                Wait(0)
            end
        end)
    end
end 



RegisterCommand("spotify", function()
    RefreshPlayerMusic()
    OpenSpotifyMenu()
end)
