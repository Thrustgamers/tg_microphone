local object = "v_ilev_fos_mic"
local zones = {}
local range = nil

--As soon as the resource starts the creation of the zones will start
AddEventHandler('onResourceStart', function(resourceName)
    createZones()
end)

--decides what raduis your voice will have 
function range(context)
    if context == "small" then 
        range = 20
    elseif context == "medium" then
        range = 35
    else
        range = 50
    end
end

--Inside Zone
function inside()
    exports["pma-voice"]:overrideProximityRange(range, true)
end

--Exiting Zone
function onExit()
    exports["pma-voice"]:clearProximityOverride()
end
  
--Zone Creation
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

--Thread
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
