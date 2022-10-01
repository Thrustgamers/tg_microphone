local object = "v_ilev_fos_mic"
local zones = {}
local range = nil

AddEventHandler('onResourceStart', function(resourceName)
    createZones()
end)

function range(context)
    if context == "small" then 
        range = 20
    elseif context == "medium" then
        range = 35
    else
        range = 50
    end
end


function inside()
    exports["pma-voice"]:overrideProximityRange(50, true)
end

function onExit()
    exports["pma-voice"]:clearProximityOverride()
end
  

function createZones()
    CreateThread(function()
        for k, v in pairs(Config.Zones) do
            zones = lib.zones.box({
                coords = vector(v.coords.x, v.coords.y, v.coords.z),
                size = vector3(5, 5, 5),
                onExit =  onExit,
                inside = inside,
            })
        end
    end)
end

CreateThread(function() 
    for k,v in pairs(Config.Zones) do
        if #(GetEntityCoords(PlayerPedId()) - vector3(v.coords.x, v.coords.y, v.coords.z)) < 150 then 
            if v.spawnProp ~= true then
                local prop = CreateObject(GetHashKey(object), vector3(v.x, v.y, v.z - 1.0), false)
                if #(GetEntityCoords(PlayerPedId()) - vector3(v.coords.x, v.coords.y, v.coords.z)) < 10 then 
                    range(v.Config.Zones.context)
                end
                print(k)
                FreezeEntityPosition(prop, true)
            end
        end
    end
end)