function land_encounters()
    return AccessibilityLevel.Normal
end

function day_encounters()
    if not has("daytime") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_time_on"), AccessibilityLevel.SequenceBreak)
end

function morning_encounters()
    if not has("morningtime") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_time_on"), AccessibilityLevel.SequenceBreak)
end

function night_encounters()
    if not has("nighttime") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_time_on"), AccessibilityLevel.SequenceBreak)
end

function surf_encounters()
    if not surf() then return AccessibilityLevel.None end

    return AccessibilityLevel.Normal
end

function rocksmash_encounters()
    if not rock_smash() then return AccessibilityLevel.None end

    if has("encmethod_rocksmash_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function hoennsound_encounters()
    if not (has("hoennsound") and has("upgradableradiopokegearcard")) then return AccessibilityLevel.None end
    
    if has("encmethod_sounds_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function sinnohsound_encounters()
    if not (has("sinnohsound") and has("upgradableradiopokegearcard")) then return AccessibilityLevel.None end
    
    if has("encmethod_sounds_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

-- This will come back sooner than later I think -palex00
--function roamer_encounters()
--    if not has("poketch") or not has("markingmap") then return AccessibilityLevel.None end
--    
--    local cynthia = Tracker:FindObjectForCode("@pokemon_league_hall_of_fame").AccessibilityLevel
--    if has("encmethod_roamer_on") then
--        return math.max(has_level("opt_can_reset_legendaries_in_ap_helper_on"), cynthia, AccessibilityLevel.SequenceBreak)    
--    end
--    
--    return AccessibilityLevel.SequenceBreak
--end

function oldrod_encounters()
    if not has("oldrod") then return AccessibilityLevel.None end

    if has("encmethod_fishing_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function goodrod_encounters()
    if not has("goodrod") then return AccessibilityLevel.None end

    if has("encmethod_fishing_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function superrod_encounters()
    if not has("superrod") then return AccessibilityLevel.None end

    if has("encmethod_fishing_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function fishingnight_encounters()
    if not (has("goodrod") or has("superrod")) then return AccessibilityLevel.None end
    if not has("nighttime") then return AccessibilityLevel.None end

    if has("encmethod_fishing_on") and has("encmethod_time_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function goodrodnotnight_encounters()
    if not has("goodrod") then return AccessibilityLevel.None end
    if not (has("morningtime") or has("daytime")) then return AccessibilityLevel.None end

    if has("encmethod_fishing_on") and has("encmethod_time_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function superrodnotnight_encounters()
    if not has("superrod") then return AccessibilityLevel.None end
    if not (has("morningtime") or has("daytime")) then return AccessibilityLevel.None end

    if has("encmethod_fishing_on") and has("encmethod_time_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

ENC_METHODS = {
    land = land_encounters,
    morning = morning_encounters,
    day = day_encounters,
    night = night_encounters,
    surf = surf_encounters,
    oldrod = oldrod_encounters,
    goodrod = goodrod_encounters,
    superrod = superrod_encounters,
    fishingnight = fishingnight_encounters,
    goodrodnotnight = goodrodnotnight_encounters,
    superrodnotnight = superrodnotnight_encounters,
    rocksmash = rocksmash_encounters,
    hoenn = hoennsound_encounters,
    sinnoh = sinnohsound_encounters,
}

function enc(...)
    local best = AccessibilityLevel.None
    for _, name in ipairs({...}) do
        local method = ENC_METHODS[name]
        if method == nil then
            print("Unknown encounter method: "..tostring(name))
        else
            local level = method()
            if level > best then
                best = level
            end
        end
    end
    return best
end

function evo_item_shop()
    if has("opt_evo_items_shop_in_ap_helper_on") then
        return AccessibilityLevel.Normal
    else
        local goldenrod = Tracker:FindObjectForCode("@goldenrod_department_store_1f").AccessibilityLevel
        return math.max(goldenrod, AccessibilityLevel.SequenceBreak)
    end    
end

--== Evolution Logic ==--

function levelup()
    if has("evomethod_level_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
    -- yep. any level is always in logic.
end


function evolve_useitem(value)
    if not has(value) then return end
    
    if has("evomethod_useitem_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_helditem(value)
    if not has(value) then return end
    
    if has("evomethod_helditem_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end


function evolve_trade_item(value)
    if not has(value) or not has("linkingcord") then return end
    
    if has("evomethod_useitem_on") and has("evomethod_helditem_on") then
        return evo_item_shop()
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_area(area)
    local evo_area = Tracker:FindObjectForCode("@"..area).AccessibilityLevel
    if has("evomethod_location_on") then
        return evo_area
    else
        return math.min(evo_area, AccessibilityLevel.SequenceBreak)
    end
end

function evolve_mildly(which)
    if has("evomethod_mildlyannoying_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_highly(which)
    local goldenrod = Tracker:FindObjectForCode("@goldenrod_department_store_1f").AccessibilityLevel
    local beauty = Tracker:FindObjectForCode("@virt_beauty").AccessibilityLevel

    if which ~= "wurmple" and not has("bag") then return AccessibilityLevel.None end

    if has("evomethod_highlyannoying_on") then
        if which == "tyrogue" then
            return math.max(goldenrod, AccessibilityLevel.SequenceBreak)
        elseif which == "beauty" then
            return beauty
        elseif which == "wurmple" then
            return AccessibilityLevel.Normal
        end
    else
        if which == "beauty" then
            return math.min(beauty, AccessibilityLevel.SequenceBreak)
        end
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_friendship()
    if has("evomethod_happiness_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_time(timeofday)
    if timeofday == "night" then
        if not has("nighttime") then return AccessibilityLevel.None end
    elseif timeofday == "day" then
        if not has("daytime") then return AccessibilityLevel.None end
    else
        print("Typo!")
    end

    return math.max(has_level("evomethod_time_on"), AccessibilityLevel.SequenceBreak)
end

--== Evolution Data ==--

local function parse_rule(rule)
    local checks = {}
    for _, token in ipairs(rule) do
        if token:sub(1, 2) == "^$" then
            local args = {}
            for arg in token:sub(3):gmatch("[^|]+") do
                table.insert(args, arg)
            end
            local func = table.remove(args, 1)
            table.insert(checks, {func = _G[func], args = args})
        else
            table.insert(checks, {code = token})
        end
    end
    return checks
end

function setEvolutionData(data)
    EVOLUTION_DATA = data
    PRE_EVOLUTION = {}
    for from, evos in pairs(data) do
        for _, evo in ipairs(evos) do
            evo.checks = parse_rule(evo.rule)
            PRE_EVOLUTION[evo.into] = {from = from, evo = evo}
        end
    end
end

function evolution_access(evo)
    local min = AccessibilityLevel.Normal
    for _, check in ipairs(evo.checks) do
        local level
        if check.code then
            level = has_level(check.code)
        else
            level = check.func(table.unpack(check.args)) or AccessibilityLevel.None
        end
        if level < min then
            if level == AccessibilityLevel.None then
                return AccessibilityLevel.None
            end
            min = level
        end
    end
    return min
end

function evolve_from(target)
    local pre = PRE_EVOLUTION[tonumber(target)]
    if not has("caught_" .. pre.from) then
        return AccessibilityLevel.None
    end
    return evolution_access(pre.evo)
end
