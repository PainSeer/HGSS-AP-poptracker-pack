function cut()
    return has("hm01cut") and (has ("free_cut") or has(hivebadge))
end

function fly()
    return has("hm02fly") and (has ("free_fly") or has(stormbadge))
end

function surf()
    return has("hm03surf") and (has ("free_surf") or has(fogbadge))
end

function strength()
    return has("hm04strength") and (has ("free_strength") or has(plainbadge))
end

function rock_smash()
    return has("hm01rock_smash") and (has ("free_rock_smash") or has(zephyrbadge))
end

function waterfall()
    return has("hm07waterfall") and (has ("free_waterfall") or has(risingbadge))
end

function down_waterfall()
    return has("hm07waterfall")
end

function whirlpool()
    return has("hm05whirlpool") and (has ("free_whirlpool") or has(glacierbadge))
end

function rock_climb()
    return has("hm08rock_climb") and (has ("free_rock_climb") or has(earthbadge))
end

function hidden()
    if has("opt_dowsing_off") or has("dowsingmachine") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function badges_req(count)
    return (badges() >= tonumber(count))
end

function badges()
    return
    Tracker:ProviderCountForCode("zephyrbadge") +
    Tracker:ProviderCountForCode("hivebadge") +
    Tracker:ProviderCountForCode("plainbadge") +
    Tracker:ProviderCountForCode("fogbadge") +
    Tracker:ProviderCountForCode("stormbadge") +
    Tracker:ProviderCountForCode("mineralbadge") +
    Tracker:ProviderCountForCode("glacierbadge") +
    Tracker:ProviderCountForCode("risingbadge") +
    Tracker:ProviderCountForCode("zephyrbadge") +
    Tracker:ProviderCountForCode("hivebadge") +
    Tracker:ProviderCountForCode("plainbadge") +
    Tracker:ProviderCountForCode("fogbadge") +
    Tracker:ProviderCountForCode("stormbadge") +
    Tracker:ProviderCountForCode("mineralbadge") +
    Tracker:ProviderCountForCode("glacierbadge") +
    Tracker:ProviderCountForCode("risingbadge")
end

function johtobadges()
    return
    Tracker:ProviderCountForCode("zephyrbadge") +
    Tracker:ProviderCountForCode("hivebadge") +
    Tracker:ProviderCountForCode("plainbadge") +
    Tracker:ProviderCountForCode("fogbadge") +
    Tracker:ProviderCountForCode("stormbadge") +
    Tracker:ProviderCountForCode("mineralbadge") +
    Tracker:ProviderCountForCode("glacierbadge") +
    Tracker:ProviderCountForCode("risingbadge")
end

function kantobadges()
    return
    Tracker:ProviderCountForCode("zephyrbadge") +
    Tracker:ProviderCountForCode("hivebadge") +
    Tracker:ProviderCountForCode("plainbadge") +
    Tracker:ProviderCountForCode("fogbadge") +
    Tracker:ProviderCountForCode("stormbadge") +
    Tracker:ProviderCountForCode("mineralbadge") +
    Tracker:ProviderCountForCode("glacierbadge") +
    Tracker:ProviderCountForCode("risingbadge")
end

function flash()
    if has("opt_hm_visibility_off") or has("tm70flash") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function roamer_respawn()
    return AccessibilityLevel.Normal
end

function any_rod()
    return has("oldrod") or has("goodrod") or has("superrod")
end

function see_regional_mons()
    goal = Tracker:FindObjectForCode("regional_dex_goal").AcquiredCount
    seen = Tracker:FindObjectForCode("num_seen_reg").AcquiredCount
    if goal <= seen then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.Inspect
    end
end

function has_mon(dexnumber)
    if has("caught_"..dexnumber) then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.Inspect
    end
end

function day()
    return has("daytime")
end

function night()
    return has("nighttime")
end

function morning()
    return has("morningtime")
end

function can_freefly(destination)
  return fly() and 
  (has("fly_map_"..destination))
end

function partial_trainersanity()
    if TRAINERS:getType() == "partial" then
        return true
    else
        return false
    end
end
