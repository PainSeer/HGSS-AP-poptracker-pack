function cut()
    return has("hm01cut") and (has("free_cut") or has("hivebadge"))
end

function fly()
    return has("hm02fly") and (has("free_fly") or has("stormbadge"))
end

function surf()
    return has("hm03surf") and (has("free_surf") or has("fogbadge"))
end

function strength()
    return has("hm04strength") and (has("free_strength") or has("plainbadge"))
end

function rock_smash()
    return has("hm06rocksmash") and (has("free_rocksmash") or has("zephyrbadge"))
end

function waterfall()
    return has("hm07waterfall") and (has("free_waterfall") or has("risingbadge"))
end

function down_waterfall()
    return has("hm07waterfall")
end

function whirlpool()
    return has("hm05whirlpool") and (has("free_whirlpool") or has("glacierbadge"))
end

function rock_climb()
    return has("hm08rockclimb") and (has("free_rockclimb") or has("earthbadge"))
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

function johto_badges_req(count)
    return (johtobadges() >= tonumber(count))
end

function kanto_badges_req(count)
    return (kantobadges() >= tonumber(count))
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
    Tracker:ProviderCountForCode("boulderbadge") +
    Tracker:ProviderCountForCode("cascadebadge") +
    Tracker:ProviderCountForCode("thunderbadge") +
    Tracker:ProviderCountForCode("rainbowbadge") +
    Tracker:ProviderCountForCode("soulbadge") +
    Tracker:ProviderCountForCode("marshbadge") +
    Tracker:ProviderCountForCode("volcanobadge") +
    Tracker:ProviderCountForCode("earthbadge")
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
    Tracker:ProviderCountForCode("boulderbadge") +
    Tracker:ProviderCountForCode("cascadebadge") +
    Tracker:ProviderCountForCode("thunderbadge") +
    Tracker:ProviderCountForCode("rainbowbadge") +
    Tracker:ProviderCountForCode("soulbadge") +
    Tracker:ProviderCountForCode("marshbadge") +
    Tracker:ProviderCountForCode("volcanobadge") +
    Tracker:ProviderCountForCode("earthbadge")
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

function radio_tower_trigger()
    if not (has("fogbadge") and has("mineralbadge") and has("stormbadge") and has("glacierbadge")) then
	return false
    else
        return true
    end
end

function red_scale()
    return has("redscale")
end

function meet_boxart()
    return has("event_meet_ho_oh") or has("event_meet_lugia")    
end

function basement_key()
    return has("basementkey")
end

function ragecandybar()
    return has("ragecandybar")
end

function bicycle()
    return has("bicycle")
end

function machine_part()
    return has("machinepart")
end

function fog_badge()
    return has("fogbadge")
end

function silver_wing()
    return has("silverwing")
end

function rainbow_wing()
    return has("rainbowwing")
end

function water_stone()
    return has("waterstone")
end

function lost_item()
    return has("lostitem")
end

function ap_helper()
    if has("opt_items_shop_in_ap_helper_on") then
	return true
    else
	return Tracker:FindObjectForCode("@goldenrod_department_store_1f").AccessibilityLevel
    end
end