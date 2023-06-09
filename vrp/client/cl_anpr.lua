local a = true
local b = false
local c = ""
local d = ""
local e = 0.0
local f = 0.0
local g = 0.0
local h = 0.0
local i = ""
local j = ""
local k
local l
local m = {}
local n = false

RegisterCommand(
    "anpr",
    function(p, r)
        a = not a
    end,
    false
)
RegisterCommand(
    "lockanpr",
    function(p, r)
        b = not b
    end,
    false
)
local s = false
Citizen.CreateThread(
    function()
        while true do
            if a then
                s = isPedInPoliceVehicle()
                if s then
                    k = anprGetVehicle("front")
                    l = anprGetVehicle("rear")
                end
            end
            Wait(250)
        end
    end
)
function func_drawFullAnpr()
    if a and s then
        drawFrontAnprText()
        drawRearAnprText()
    end
end

createThreadOnTick(func_drawFullAnpr)


function anprGetVehicle(t)
    local u
    if t == "front" then
        u = 50.0
    elseif t == "rear" then
        u = -50.0
    end
    local v = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local w = GetOffsetFromEntityInWorldCoords(v, 0.0, 1.0, 0.3)
    local x = GetOffsetFromEntityInWorldCoords(v, 0.0, u, 0.0)
    local y = StartExpensiveSynchronousShapeTestLosProbe(w, x, 10, v, 0)
    local z, z, z, z, A = GetShapeTestResult(y)
    if A > 0 and IsEntityAVehicle(A) then
        local B = GetVehicleNumberPlateText(A)
        if B ~= nil then
            if m[B] ~= nil then
                local C = m[B]
                SetTimeout(
                    10000,
                    function()
                        n = false
                    end
                )
            end
        end
        return A
    else
        return nil
    end
end
function isPedInPoliceVehicle()
    if IsPedInAnyPoliceVehicle(GetPlayerPed(-1), false) then
            return true
    end
    return false
end
function DrawAdvancedText(D, E, F, G, H, I, J, K, L, M, N, O)
    SetTextFont(N)
    SetTextProportional(0)
    SetTextScale(H, H)
    SetTextJustification(O)
    SetTextColour(J, K, L, M)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(I)
    EndTextCommandDisplayText(D - 0.1 + F, E - 0.02 + G)
end
function drawFrontAnprText()
    if b then
        DrawAdvancedText(0.8665, 0.675, 0.1, 0.2, 0.5, "FRONT", 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(0.4665, 0.71, 0.1, 0.2, 1.5, "VEHICLE PLATE:  " .. c, 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(0.4665, 0.735, 0.1, 0.2, 1.5, "VEHICLE SPEED:  " .. g .. " MPH", 200, 0, 0, 255, 4, 0)
       
    elseif not b then
        if k ~= nil and k ~= 0 then
            c = GetVehicleNumberPlateText(k) or "N/A"
            i = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(k)))
            e = roundnumber(GetEntitySpeed(k) * 2.236936, 1)
        end
        g = e
        DrawAdvancedText(0.43, 0.675, 0.1, 0.2, 0.5, "FRONT", 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(0.43, 0.71, 0.1, 0.2, 0.4, "VEHICLE PLATE:  " .. c, 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(0.43, 0.735, 0.1, 0.2, 0.4, "VEHICLE SPEED:  " .. e .. " MPH", 255, 255, 255, 255, 4, 0)
       
    end
end
function drawRearAnprText()
    if b then
        DrawAdvancedText(0.566, 0.675, 0.1, 0.2, 0.5, "BACK", 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(0.566, 0.71, 0.1, 0.2, 0.4, "VEHICLE PLATE:  " .. d, 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(0.566, 0.735, 0.1, 0.2, 0.4, "VEHICLE SPEED:  " .. h .. " MPH", 200, 0, 0, 255, 4, 0)
        
    elseif not b then
        if l ~= nil and l ~= 0 then
            d = GetVehicleNumberPlateText(l) or "N/A"
            j = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(l)))
            f = roundnumber(GetEntitySpeed(l) * 2.236936, 1)
        end
        h = f
        DrawAdvancedText(0.566, 0.675, 0.1, 0.2, 0.5, "BACK", 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(0.566, 0.71, 0.1, 0.2, 0.4, "VEHICLE PLATE:  " .. d, 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(0.566, 0.735, 0.1, 0.2, 0.4, "VEHICLE SPEED:  " .. f .. " MPH", 255, 255, 255, 255, 4, 0)
       
    end
end
function roundnumber(P, Q)
    local R = 10 ^ (Q or 0)
    return math.floor(P * R + 0.5) / R
end
