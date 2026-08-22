function cut()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_cut")
    or (has("hm01cut") and has("forestbadge"))
end

function fly()
    if not has("bag") then
        return false
    end
    return has("free_fly")
    or (has("hm02fly") and has("cobblebadge"))
end

function surf()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_surf")
    or (has("hm03surf") and has("fenbadge"))
end

function strength()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_strength")
    or (has("hm04strength") and has("minebadge"))
end

function defog()
    if not has("bag") then
        return false
    end
    return has("free_defog")
    or (has("hm05defog") and has("relicbadge"))
end

function rock_smash()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_rocksmash")
    or (has("hm06rocksmash") and has("coalbadge"))
end

function waterfall()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_waterfall")
    or (has("hm07waterfall") and has("beaconbadge"))
end

function down_waterfall()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("hm07waterfall")
end

function rock_climb()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_rockclimb")
    or (has("hm08rockclimb") and has("iciclebadge"))
end

function hidden()
    if has("opt_dowsing_off") or (has("dowsingmachine") and has("poketch")) then
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
    Tracker:ProviderCountForCode("coalbadge") +
    Tracker:ProviderCountForCode("forestbadge") +
    Tracker:ProviderCountForCode("cobblebadge") +
    Tracker:ProviderCountForCode("fenbadge") +
    Tracker:ProviderCountForCode("relicbadge") +
    Tracker:ProviderCountForCode("minebadge") +
    Tracker:ProviderCountForCode("iciclebadge") +
    Tracker:ProviderCountForCode("beaconbadge")
end

function poketch_req(badgecount)
    if badgecount ~= nil then 
        if badges() >= tonumber(badgecount) then
            -- dummy
        else
            return false
        end
    end
    return has("coupons", 3) and has("parcel")
end

function route203_pass()
    if has("opt_route_203_off") then
        return true
    else
        return has("poketch")
    end
end

function early_sunyshore()
    if has("opt_early_sunyshore_on") then
        return AccessibilityLevel.Normal
    else
        return math.min(has_level("event_clear_distortion"), Tracker:FindObjectForCode("@distortion_world").AccessibilityLevel)
    end
end

function north_sinnoh_fly()
    if has("opt_north_sinnoh_fly_off") or fly() then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function soft_defog()
    if has("opt_hm_visibility_off") or defog() then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function unowns()
    if has("opt_unown_none") then
        return true
    elseif has("opt_unown_item") then
        return has("unownfile", 26)
    elseif has("opt_unown_vanilla") then
        return Tracker:FindObjectForCode("@solaceon_town").AccessibilityLevel
    end
end

function pastoria_barriers()
    return has("opt_pastoria_barriers_off") or surf()
end

function boat_canalave_pastoria()
    if has("opt_boat_canalave_pastoria_off") then
        return false
    elseif has("opt_boat_canalave_pastoria_on") then
        return true
    elseif has("opt_boat_canalave_pastoria_ssticket") then
        return has("ssticket")
    end
end

function boat_canalave_snowpoint()
    if has("opt_boat_canalave_snowpoint_off") then
        return false
    elseif has("opt_boat_canalave_snowpoint_on") then
        return true
    elseif has("opt_boat_canalave_snowpoint_ssticket") then
        return has("ssticket")
    end
end

function boat_pastoria_snowpoint()
    if has("opt_boat_pastoria_snowpoint_off") then
        return false
    elseif has("opt_boat_pastoria_snowpoint_on") then
        return true
    elseif has("opt_boat_pastoria_snowpoint_ssticket") then
        return has("ssticket")
    end
end

function route_207_barricade_up()
    if has("opt_route_207_barricade_none") then
        return true
    elseif has("opt_route_207_barricade_bicycle_slope") then
        return has("bicycle")
    elseif has("opt_route_207_barricade_rock_climb") then
        return rock_climb()
    elseif has("opt_route_207_barricade_impassable") then
        return false
    elseif has("opt_route_207_barricade_cut_tree") then
        return cut()
    elseif has("opt_route_207_barricade_rock_smash") then
        return rock_smash()
    elseif has("opt_route_207_barricade_strength_boulder") then
        return strength()
    elseif has("opt_route_207_barricade_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_207_barricade_bicycle_slope_and_cut_tree") then
        return has("bicycle") and cut()
    elseif has("opt_route_207_barricade_bicycle_slope_and_rock_smash") then
        return has("bicycle") and rock_smash()
    elseif has("opt_route_207_barricade_bicycle_slope_and_strength_boulder") then
        return has("bicycle") and strength()
    elseif has("opt_route_207_barricade_bicycle_slope_and_psyduck") then
        return has("bicycle") and has("secretpotion")
    elseif has("opt_route_207_barricade_rock_climb_and_cut_tree") then
        return rock_climb() and cut()
    elseif has("opt_route_207_barricade_rock_climb_and_rock_smash") then
        return rock_climb() and rock_smash()
    elseif has("opt_route_207_barricade_rock_climb_and_strength_boulder") then
        return rock_climb() and strength()
    elseif has("opt_route_207_barricade_rock_climb_and_psyduck") then
        return rock_climb() and has("secretpotion")
    end
end

function route_207_barricade_down()
    if has("opt_route_207_barricade_none") then
        return true
    elseif has("opt_route_207_barricade_bicycle_slope") then
        return true
    elseif has("opt_route_207_barricade_rock_climb") then
        return rock_climb()
    elseif has("opt_route_207_barricade_impassable") then
        return false
    elseif has("opt_route_207_barricade_cut_tree") then
        return cut()
    elseif has("opt_route_207_barricade_rock_smash") then
        return rock_smash()
    elseif has("opt_route_207_barricade_strength_boulder") then
        return strength()
    elseif has("opt_route_207_barricade_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_207_barricade_bicycle_slope_and_cut_tree") then
        return cut()
    elseif has("opt_route_207_barricade_bicycle_slope_and_rock_smash") then
        return rock_smash()
    elseif has("opt_route_207_barricade_bicycle_slope_and_strength_boulder") then
        return strength()
    elseif has("opt_route_207_barricade_bicycle_slope_and_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_207_barricade_rock_climb_and_cut_tree") then
        return rock_climb() and cut()
    elseif has("opt_route_207_barricade_rock_climb_and_rock_smash") then
        return rock_climb() and rock_smash()
    elseif has("opt_route_207_barricade_rock_climb_and_strength_boulder") then
        return rock_climb() and strength()
    elseif has("opt_route_207_barricade_rock_climb_and_psyduck") then
        return rock_climb() and has("secretpotion")
    end
end

function route_210_lower_barricade_up()
    if has("opt_route_210_lower_barricade_none") then
        return true
    elseif has("opt_route_210_lower_barricade_bicycle_slope") then
        return has("bicycle")
    elseif has("opt_route_210_lower_barricade_rock_climb") then
        return rock_climb()
    elseif has("opt_route_210_lower_barricade_surf") then
        return surf()
    elseif has("opt_route_210_lower_barricade_waterfall") then
        return surf() and waterfall()
    elseif has("opt_route_210_lower_barricade_impassable") then
        return false
    elseif has("opt_route_210_lower_barricade_cut_tree") then
        return cut()
    elseif has("opt_route_210_lower_barricade_rock_smash") then
        return rock_smash()
    elseif has("opt_route_210_lower_barricade_strength_boulder") then
        return strength()
    elseif has("opt_route_210_lower_barricade_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_cut_tree") then
        return has("bicycle") and cut()
    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_rock_smash") then
        return has("bicycle") and rock_smash()
    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_strength_boulder") then
        return has("bicycle") and strength()
    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_psyduck") then
        return has("bicycle") and has("secretpotion")
    elseif has("opt_route_210_lower_barricade_rock_climb_and_cut_tree") then
        return rock_climb() and cut()
    elseif has("opt_route_210_lower_barricade_rock_climb_and_rock_smash") then
        return rock_climb() and rock_smash()
    elseif has("opt_route_210_lower_barricade_rock_climb_and_strength_boulder") then
        return rock_climb() and strength()
    elseif has("opt_route_210_lower_barricade_rock_climb_and_psyduck") then
        return rock_climb() and has("secretpotion")
    elseif has("opt_route_210_lower_barricade_surf_and_cut_tree") then
        return surf() and cut()
    elseif has("opt_route_210_lower_barricade_surf_and_rock_smash") then
        return surf() and rock_smash()
    elseif has("opt_route_210_lower_barricade_surf_and_strength_boulder") then
        return surf() and strength()
    elseif has("opt_route_210_lower_barricade_surf_and_psyduck") then
        return surf() and has("secretpotion")
    elseif has("opt_route_210_lower_barricade_waterfall_and_cut_tree") then
        return surf() and waterfall() and cut()
    elseif has("opt_route_210_lower_barricade_waterfall_and_rock_smash") then
        return surf() and waterfall() and rock_smash()
    elseif has("opt_route_210_lower_barricade_waterfall_and_strength_boulder") then
        return surf() and waterfall() and strength()
    elseif has("opt_route_210_lower_barricade_waterfall_and_psyduck") then
        return surf() and waterfall() and has("secretpotion")
    end
end

function route_210_lower_barricade_down()
    if has("opt_route_210_lower_barricade_none") then
        return true
    elseif has("opt_route_210_lower_barricade_bicycle_slope") then
        return true
    elseif has("opt_route_210_lower_barricade_rock_climb") then
        return rock_climb()
    elseif has("opt_route_210_lower_barricade_surf") then
        return surf()
    elseif has("opt_route_210_lower_barricade_waterfall") then
        return surf() and down_waterfall()
    elseif has("opt_route_210_lower_barricade_impassable") then
        return false
    elseif has("opt_route_210_lower_barricade_cut_tree") then
        return cut()
    elseif has("opt_route_210_lower_barricade_rock_smash") then
        return rock_smash()
    elseif has("opt_route_210_lower_barricade_strength_boulder") then
        return strength()
    elseif has("opt_route_210_lower_barricade_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_cut_tree") then
        return cut()
    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_rock_smash") then
        return rock_smash()
    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_strength_boulder") then
        return strength()
    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_210_lower_barricade_rock_climb_and_cut_tree") then
        return rock_climb() and cut()
    elseif has("opt_route_210_lower_barricade_rock_climb_and_rock_smash") then
        return rock_climb() and rock_smash()
    elseif has("opt_route_210_lower_barricade_rock_climb_and_strength_boulder") then
        return rock_climb() and strength()
    elseif has("opt_route_210_lower_barricade_rock_climb_and_psyduck") then
        return rock_climb() and has("secretpotion")
    elseif has("opt_route_210_lower_barricade_surf_and_cut_tree") then
        return surf() and cut()
    elseif has("opt_route_210_lower_barricade_surf_and_rock_smash") then
        return surf() and rock_smash()
    elseif has("opt_route_210_lower_barricade_surf_and_strength_boulder") then
        return surf() and strength()
    elseif has("opt_route_210_lower_barricade_surf_and_psyduck") then
        return surf() and has("secretpotion")
    elseif has("opt_route_210_lower_barricade_waterfall_and_cut_tree") then
        return surf() and down_waterfall() and cut()
    elseif has("opt_route_210_lower_barricade_waterfall_and_rock_smash") then
        return surf() and down_waterfall() and rock_smash()
    elseif has("opt_route_210_lower_barricade_waterfall_and_strength_boulder") then
        return surf() and down_waterfall() and strength()
    elseif has("opt_route_210_lower_barricade_waterfall_and_psyduck") then
        return surf() and down_waterfall() and has("secretpotion")
    end
end

function route_215_barricade_east()
    if has("opt_route_215_barricade_none") then
        return true
    elseif has("opt_route_215_barricade_bicycle_bridge") then
        return bicycle_through_route_210_barricade() and has("bicycle")
    elseif has("opt_route_215_barricade_rock_climb") then
        return rock_climb()
    elseif has("opt_route_215_barricade_surf") then
        return surf()
    elseif has("opt_route_215_barricade_waterfall") then
        return surf() and waterfall()
    elseif has("opt_route_215_barricade_impassable") then
        return false
    elseif has("opt_route_215_barricade_cut_tree") then
        return cut()
    elseif has("opt_route_215_barricade_rock_smash") then
        return rock_smash()
    elseif has("opt_route_215_barricade_strength_boulder") then
        return strength()
    elseif has("opt_route_215_barricade_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_215_barricade_bicycle_bridge_and_cut_tree") then
        return bicycle_through_route_210_barricade() and has("bicycle") and cut()
    elseif has("opt_route_215_barricade_bicycle_bridge_and_rock_smash") then
        return bicycle_through_route_210_barricade() and has("bicycle") and rock_smash()
    elseif has("opt_route_215_barricade_bicycle_bridge_and_strength_boulder") then
        return bicycle_through_route_210_barricade() and has("bicycle") and strength()
    elseif has("opt_route_215_barricade_bicycle_bridge_and_psyduck") then
        return bicycle_through_route_210_barricade() and has("bicycle") and has("secretpotion")
    elseif has("opt_route_215_barricade_rock_climb_and_cut_tree") then
        return rock_climb() and cut()
    elseif has("opt_route_215_barricade_rock_climb_and_rock_smash") then
        return rock_climb() and rock_smash()
    elseif has("opt_route_215_barricade_rock_climb_and_strength_boulder") then
        return rock_climb() and strength()
    elseif has("opt_route_215_barricade_rock_climb_and_psyduck") then
        return rock_climb() and has("secretpotion")
    elseif has("opt_route_215_barricade_surf_and_cut_tree") then
        return surf() and cut()
    elseif has("opt_route_215_barricade_surf_and_rock_smash") then
        return surf() and rock_smash()
    elseif has("opt_route_215_barricade_surf_and_strength_boulder") then
        return surf() and strength()
    elseif has("opt_route_215_barricade_surf_and_psyduck") then
        return surf() and has("secretpotion")
    elseif has("opt_route_215_barricade_waterfall_and_cut_tree") then
        return surf() and waterfall() and cut()
    elseif has("opt_route_215_barricade_waterfall_and_rock_smash") then
        return surf() and waterfall() and rock_smash()
    elseif has("opt_route_215_barricade_waterfall_and_strength_boulder") then
        return surf() and waterfall() and strength()
    elseif has("opt_route_215_barricade_waterfall_and_psyduck") then
        return surf() and waterfall() and has("secretpotion")
    end
end

function route_215_barricade_west()
    if has("opt_route_215_barricade_none") then
        return true
    elseif has("opt_route_215_barricade_bicycle_bridge") then
        return has("bag") and has("bicycle")
    elseif has("opt_route_215_barricade_rock_climb") then
        return rock_climb()
    elseif has("opt_route_215_barricade_surf") then
        return surf()
    elseif has("opt_route_215_barricade_waterfall") then
        return surf() and down_waterfall()
    elseif has("opt_route_215_barricade_impassable") then
        return false
    elseif has("opt_route_215_barricade_cut_tree") then
        return cut()
    elseif has("opt_route_215_barricade_rock_smash") then
        return rock_smash()
    elseif has("opt_route_215_barricade_strength_boulder") then
        return strength()
    elseif has("opt_route_215_barricade_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_215_barricade_bicycle_bridge_and_cut_tree") then
        return has("bag") and has("bicycle") and cut()
    elseif has("opt_route_215_barricade_bicycle_bridge_and_rock_smash") then
        return has("bag") and has("bicycle") and rock_smash()
    elseif has("opt_route_215_barricade_bicycle_bridge_and_strength_boulder") then
        return has("bag") and has("bicycle") and strength()
    elseif has("opt_route_215_barricade_bicycle_bridge_and_psyduck") then
        return has("bag") and has("bicycle") and has("secretpotion")
    elseif has("opt_route_215_barricade_rock_climb_and_cut_tree") then
        return rock_climb() and cut()
    elseif has("opt_route_215_barricade_rock_climb_and_rock_smash") then
        return rock_climb() and rock_smash()
    elseif has("opt_route_215_barricade_rock_climb_and_strength_boulder") then
        return rock_climb() and strength()
    elseif has("opt_route_215_barricade_rock_climb_and_psyduck") then
        return rock_climb() and has("secretpotion")
    elseif has("opt_route_215_barricade_surf_and_cut_tree") then
        return surf() and cut()
    elseif has("opt_route_215_barricade_surf_and_rock_smash") then
        return surf() and rock_smash()
    elseif has("opt_route_215_barricade_surf_and_strength_boulder") then
        return surf() and strength()
    elseif has("opt_route_215_barricade_surf_and_psyduck") then
        return surf() and has("secretpotion")
    elseif has("opt_route_215_barricade_waterfall_and_cut_tree") then
        return surf() and down_waterfall() and cut()
    elseif has("opt_route_215_barricade_waterfall_and_rock_smash") then
        return surf() and down_waterfall() and rock_smash()
    elseif has("opt_route_215_barricade_waterfall_and_strength_boulder") then
        return surf() and down_waterfall() and strength()
    elseif has("opt_route_215_barricade_waterfall_and_psyduck") then
        return surf() and down_waterfall() and has("secretpotion")
    end
end

function bicycle_through_route_210_barricade()
    if has("opt_route_210_lower_barricade_impassable")
    or has("opt_route_210_lower_barricade_surf")
    or has("opt_route_210_lower_barricade_surf_and_cut_tree")
    or has("opt_route_210_lower_barricade_surf_and_rock_smash")
    or has("opt_route_210_lower_barricade_surf_and_strength_boulder")
    or has("opt_route_210_lower_barricade_surf_and_psyduck")
    or has("opt_route_210_lower_barricade_waterfall")
    or has("opt_route_210_lower_barricade_waterfall_and_cut_tree")
    or has("opt_route_210_lower_barricade_waterfall_and_rock_smash")
    or has("opt_route_210_lower_barricade_waterfall_and_strength_boulder")
    or has("opt_route_210_lower_barricade_waterfall_and_psyduck") then
        return has("bag")
    end
    return true
end

function veilstone_bicycle_from_solaceon()
    if has("opt_route_215_barricade_impassable")
    or has("opt_route_215_barricade_surf")
    or has("opt_route_215_barricade_surf_and_cut_tree")
    or has("opt_route_215_barricade_surf_and_rock_smash")
    or has("opt_route_215_barricade_surf_and_strength_boulder")
    or has("opt_route_215_barricade_surf_and_psyduck")
    or has("opt_route_215_barricade_waterfall")
    or has("opt_route_215_barricade_waterfall_and_cut_tree")
    or has("opt_route_215_barricade_waterfall_and_rock_smash")
    or has("opt_route_215_barricade_waterfall_and_strength_boulder")
    or has("opt_route_215_barricade_waterfall_and_psyduck") then
        return has("bag")
    end
    return bicycle_through_route_210_barricade()
end

function marsh_pass()
    return has("opt_marsh_pass_off") or has("marshpass")
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

-- Dex IDs that can satisfy the Amity Square companion requirement.
-- The National Dex unlocks four additional eligible Pokemon.
function amity_square_dex_ids()
    local dexIds = {
        25,  -- Pikachu
        35,  -- Clefairy
        54,  -- Psyduck
        387, -- Turtwig
        388, -- Grotle
        389, -- Torterra
        390, -- Chimchar
        391, -- Monferno
        392, -- Infernape
        393, -- Piplup
        394, -- Prinplup
        395, -- Empoleon
        417, -- Pachirisu
        425, -- Drifloon
        427, -- Buneary
        440  -- Happiny
    }

    if has("national_dex") then
        table.insert(dexIds, 39)  -- Jigglypuff
        table.insert(dexIds, 255) -- Torchic
        table.insert(dexIds, 285) -- Shroomish
        table.insert(dexIds, 300) -- Skitty
    end

    return dexIds
end

function amity_square()
    for _, id in ipairs(amity_square_dex_ids()) do
        if has("caught_" .. id) then
            return AccessibilityLevel.Normal
        end
    end

    return AccessibilityLevel.Inspect
end

function has_mon(dexnumber)
    if has("caught_"..dexnumber) then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.Inspect
    end
end

function day()
    return has("poketch") and has("daytime")
end

function night()
    return has("poketch") and has("nighttime")
end

function can_freefly(destination)
  return fly() and 
  (has("flyunlock_"..destination))
end

function partial_trainersanity()
    if TRAINERS:getType() == "partial" then
        return true
    else
        return false
    end
end
