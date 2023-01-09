local object = `v_ilev_fos_mic`
local zones = {}
local range = nil


---------------
-- Functions --
---------------

local function range(context)
    if context == "small" then 
        range = 20
    elseif context == "medium" then
        range = 35
    else
        range = 50
    end
end

local function inside()
    exports["pma-voice"]:overrideProximityRange(range, true)
end

local function onExit()
    exports["pma-voice"]:clearProximityOverride()
end
  
local function createZones()
    CreateThread(function()
        for k, v in pairs(Config.Zones) do
            zones = lib.zones.box({
                coords = v.coords,
                size = vec3(5, 5, 5),
                onExit =  onExit,
                inside = inside,
            })
        end
    end)
end

---------------
--- Threads ---
---------------

CreateThread(function() 
    for k,v in pairs(Config.Zones) do
       
        local pos = GetEntityCoords(cache.ped)
        local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))

        if v.spawnProp == true then 
            if dist < 150 then  
                local prop = CreateObject(object, vector3(v.coords.x, v.coords.y, v.coords.z - 0.5), false)
                FreezeEntityPosition(prop, true)
                SetEntityHeading(prop, v.coords.w)
            end
        end

        if dist < 10 then 
            range(v.context)
        end
        
    end
end)

--------------
--- Events ---
--------------

AddEventHandler('onResourceStart', function(resourceName)
    createZones()
end)