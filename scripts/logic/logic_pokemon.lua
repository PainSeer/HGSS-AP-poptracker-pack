function land_encounters()
    return AccessibilityLevel.Normal
end

function day_encounters()
    if not day() then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_time_on"), AccessibilityLevel.SequenceBreak)
end

function morning_encounters()
    if not morning() then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_time_on"), AccessibilityLevel.SequenceBreak)
end

function night_encounters()
    if not night() then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_time_on"), AccessibilityLevel.SequenceBreak)
end

function surf_encounters()
    if not surf() then return AccessibilityLevel.None end
    
    if has("encmethod_surf_on") then
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
        math.min(evo_area, AccessibilityLevel.SequenceBreak)
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
        if not night() then return AccessibilityLevel.None end
    elseif timeofday == "day" then
        if not day() then return AccessibilityLevel.None end
    else
        print("Typo!")
    end

    return math.max(has_level("evomethod_time_on"), AccessibilityLevel.SequenceBreak)
end