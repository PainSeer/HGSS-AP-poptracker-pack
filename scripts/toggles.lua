function toggle_itemgrid()
    suffix = ""
    
    if not has("opt_hmreader_off") then
        suffix = suffix.."_hmreader"
    end
    
    if has("opt_marsh_pass_on") then
        suffix = suffix.."_marshpass"
    end
    
    if has("opt_storage_key_on") then
        suffix = suffix.."_storagekey"
    end
    
    if has("opt_unown_item") then
        suffix = suffix.."_unownfile"
    end
    
    Tracker:AddLayouts("layouts/items/items"..suffix..".json")
end

function toggle_splitmap()
    if has("splitmap_off") then
        Tracker:AddLayouts("layouts/tabs_single.json")
    elseif has("splitmap_on") then
        Tracker:AddLayouts("layouts/tabs_split.json")
    elseif has("splitmap_reverse") then
        Tracker:AddLayouts("layouts/tabs_reverse.json")
    end
end

function toggle_trackerlayout()
    suffix = ""
   
    if not has("opt_randomize_fly_items_off") then
        suffix = suffix.."_flyunlock"
    end

    Tracker:AddLayouts("layouts/tracker"..suffix..".json")
end


function toggle_pastoriabarriers()
    if has("opt_pastoria_barriers_on") then
        Tracker:AddMaps("maps/pastoria_barriers.json")
    elseif has("opt_pastoria_barriers_off") then
        Tracker:AddMaps("maps/pastoria_off.json")
    elseif has("opt_pastoria_barriers_unknown") then
        Tracker:AddMaps("maps/pastoria_unknown.json")
	end
end

function toggle_route207roadblock()
    if has("opt_route_207_barricade_none") then
        Tracker:AddMaps("maps/route207_none.json")

    elseif has("opt_route_207_barricade_bicycle_slope") then
        Tracker:AddMaps("maps/route207.json")

    elseif has("opt_route_207_barricade_bicycle_slope_and_cut_tree") then
        Tracker:AddMaps("maps/route207_bicycle_slope_and_cut_tree.json")

    elseif has("opt_route_207_barricade_bicycle_slope_and_psyduck") then
        Tracker:AddMaps("maps/route207_bicycle_slope_and_psyduck.json")

    elseif has("opt_route_207_barricade_bicycle_slope_and_rock_smash") then
        Tracker:AddMaps("maps/route207_bicycle_slope_and_rock_smash.json")

    elseif has("opt_route_207_barricade_bicycle_slope_and_strength_boulder") then
        Tracker:AddMaps("maps/route207_bicycle_slope_and_strength_boulder.json")

    elseif has("opt_route_207_barricade_cut_tree") then
        Tracker:AddMaps("maps/route207_cut_tree.json")

    elseif has("opt_route_207_barricade_impassable") then
        Tracker:AddMaps("maps/route207_impassable.json")

    elseif has("opt_route_207_barricade_psyduck") then
        Tracker:AddMaps("maps/route207_psyduck.json")

    elseif has("opt_route_207_barricade_rock_climb") then
        Tracker:AddMaps("maps/route207_rock_climb.json")

    elseif has("opt_route_207_barricade_rock_climb_and_cut_tree") then
        Tracker:AddMaps("maps/route207_rock_climb_and_cut_tree.json")

    elseif has("opt_route_207_barricade_rock_climb_and_psyduck") then
        Tracker:AddMaps("maps/route207_rock_climb_and_psyduck.json")

    elseif has("opt_route_207_barricade_rock_climb_and_rock_smash") then
        Tracker:AddMaps("maps/route207_rock_climb_and_rock_smash.json")

    elseif has("opt_route_207_barricade_rock_climb_and_strength_boulder") then
        Tracker:AddMaps("maps/route207_rock_climb_and_strength_boulder.json")

    elseif has("opt_route_207_barricade_rock_smash") then
        Tracker:AddMaps("maps/route207_rock_smash.json")

    elseif has("opt_route_207_barricade_strength_boulder") then
        Tracker:AddMaps("maps/route207_strength_boulder.json")

    elseif has("opt_route_207_barricade_unknown") then
        Tracker:AddMaps("maps/route207_unknown.json")
	end
end

function toggle_route210roadblock()
    if has("opt_route_210_lower_barricade_none") then
        Tracker:AddMaps("maps/route210south.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope") then
        Tracker:AddMaps("maps/route210south_bike_slope.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_cut_tree") then
        Tracker:AddMaps("maps/route210south_bike_slope_cut.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_psyduck") then
        Tracker:AddMaps("maps/route210south_bike_slope_psyduck.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_rock_smash") then
        Tracker:AddMaps("maps/route210south_bike_slope_rock_smash.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_strength_boulder") then
        Tracker:AddMaps("maps/route210south_bike_slope_strength.json")

    elseif has("opt_route_210_lower_barricade_cut_tree") then
        Tracker:AddMaps("maps/route210south_cut.json")

    elseif has("opt_route_210_lower_barricade_impassable") then
        Tracker:AddMaps("maps/route210south_impassable.json")

    elseif has("opt_route_210_lower_barricade_psyduck") then
        Tracker:AddMaps("maps/route210south_psyduck.json")

    elseif has("opt_route_210_lower_barricade_rock_climb") then
        Tracker:AddMaps("maps/route210south_rock_climb.json")

    elseif has("opt_route_210_lower_barricade_rock_climb_and_cut_tree") then
        Tracker:AddMaps("maps/route210south_rock_climb_cut.json")

    elseif has("opt_route_210_lower_barricade_rock_climb_and_psyduck") then
        Tracker:AddMaps("maps/route210south_rock_climb_psyduck.json")

    elseif has("opt_route_210_lower_barricade_rock_climb_and_rock_smash") then
        Tracker:AddMaps("maps/route210south_rock_climb_rock_smash.json")

    elseif has("opt_route_210_lower_barricade_rock_climb_and_strength_boulder") then
        Tracker:AddMaps("maps/route210south_rock_climb_strength.json")

    elseif has("opt_route_210_lower_barricade_rock_smash") then
        Tracker:AddMaps("maps/route210south_rock_smash.json")

    elseif has("opt_route_210_lower_barricade_strength_boulder") then
        Tracker:AddMaps("maps/route210south_strength.json")

    elseif has("opt_route_210_lower_barricade_surf") then
        Tracker:AddMaps("maps/route210south_surf.json")

    elseif has("opt_route_210_lower_barricade_surf_and_cut_tree") then
        Tracker:AddMaps("maps/route210south_surf_cut.json")

    elseif has("opt_route_210_lower_barricade_surf_and_psyduck") then
        Tracker:AddMaps("maps/route210south_surf_psyduck.json") 

    elseif has("opt_route_210_lower_barricade_surf_and_rock_smash") then
        Tracker:AddMaps("maps/route210south_surf_rock_smash.json")

    elseif has("opt_route_210_lower_barricade_surf_and_strength_boulder") then
        Tracker:AddMaps("maps/route210south_surf_strength.json")

    elseif has("opt_route_210_lower_barricade_waterfall") then
        Tracker:AddMaps("maps/route210south_waterfall.json")

    elseif has("opt_route_210_lower_barricade_waterfall_and_cut_tree") then
        Tracker:AddMaps("maps/route210south_waterfall_cut.json")

    elseif has("opt_route_210_lower_barricade_waterfall_and_psyduck") then
        Tracker:AddMaps("maps/route210south_waterfall_psyduck.json")

    elseif has("opt_route_210_lower_barricade_waterfall_and_rock_smash") then
        Tracker:AddMaps("maps/route210south_waterfall_rock_smash.json")

    elseif has("opt_route_210_lower_barricade_waterfall_and_strength_boulder") then
        Tracker:AddMaps("maps/route210south_waterfall_strength.json")

    elseif has("opt_route_210_lower_barricade_unknown") then
        Tracker:AddMaps("maps/route210south_unknown.json")
	end
end

function toggle_route215roadblock()
    if has("opt_route_215_barricade_none") then
        Tracker:AddMaps("maps/route215west.json")

    elseif has("opt_route_215_barricade_bicycle_bridge") then
        Tracker:AddMaps("maps/route215west_bike_bridge.json")

    elseif has("opt_route_215_barricade_bicycle_bridge_and_cut_tree") then
        Tracker:AddMaps("maps/route215west_bike_bridge_cut.json")

    elseif has("opt_route_215_barricade_bicycle_bridge_and_psyduck") then
        Tracker:AddMaps("maps/route215west_bike_bridge_psyduck.json")

    elseif has("opt_route_215_barricade_bicycle_bridge_and_rock_smash") then
        Tracker:AddMaps("maps/route215west_bike_bridge_rock_smash.json")

    elseif has("opt_route_215_barricade_bicycle_bridge_and_strength_boulder") then
        Tracker:AddMaps("maps/route215west_bike_bridge_strength.json")

    elseif has("opt_route_215_barricade_cut_tree") then
        Tracker:AddMaps("maps/route215west_cut.json")

    elseif has("opt_route_215_barricade_impassable") then
        Tracker:AddMaps("maps/route215west_impassable.json")

    elseif has("opt_route_215_barricade_psyduck") then
        Tracker:AddMaps("maps/route215west_psyduck.json")

    elseif has("opt_route_215_barricade_rock_climb") then
        Tracker:AddMaps("maps/route215west_rock_climb.json")

    elseif has("opt_route_215_barricade_rock_climb_and_cut_tree") then
        Tracker:AddMaps("maps/route215west_rock_climb_cut.json")

    elseif has("opt_route_215_barricade_rock_climb_and_psyduck") then
        Tracker:AddMaps("maps/route215west_rock_climb_psyduck.json")

    elseif has("opt_route_215_barricade_rock_climb_and_rock_smash") then
        Tracker:AddMaps("maps/route215west_rock_climb_rock_smash.json")

    elseif has("opt_route_215_barricade_rock_climb_and_strength_boulder") then
        Tracker:AddMaps("maps/route215west_rock_climb_strength.json")

    elseif has("opt_route_215_barricade_rock_smash") then
        Tracker:AddMaps("maps/route215west_rock_smash.json")

    elseif has("opt_route_215_barricade_strength_boulder") then
        Tracker:AddMaps("maps/route215west_strength.json")

    elseif has("opt_route_215_barricade_surf") then
        Tracker:AddMaps("maps/route215west_surf.json")

    elseif has("opt_route_215_barricade_surf_and_cut_tree") then
        Tracker:AddMaps("maps/route215west_surf_cut.json")

    elseif has("opt_route_215_barricade_surf_and_psyduck") then
        Tracker:AddMaps("maps/route215west_surf_psyduck.json") 

    elseif has("opt_route_215_barricade_surf_and_rock_smash") then
        Tracker:AddMaps("maps/route215west_surf_rock_smash.json")

    elseif has("opt_route_215_barricade_surf_and_strength_boulder") then
        Tracker:AddMaps("maps/route215west_surf_strength.json")

    elseif has("opt_route_215_barricade_waterfall") then
        Tracker:AddMaps("maps/route215west_waterfall.json")

    elseif has("opt_route_215_barricade_waterfall_and_cut_tree") then
        Tracker:AddMaps("maps/route215west_waterfall_cut.json")

    elseif has("opt_route_215_barricade_waterfall_and_psyduck") then
        Tracker:AddMaps("maps/route215west_waterfall_psyduck.json")

    elseif has("opt_route_215_barricade_waterfall_and_rock_smash") then
        Tracker:AddMaps("maps/route215west_waterfall_rock_smash.json")

    elseif has("opt_route_215_barricade_waterfall_and_strength_boulder") then
        Tracker:AddMaps("maps/route215west_waterfall_strength.json")

    elseif has("opt_route_215_barricade_unknown") then
        Tracker:AddMaps("maps/route215west_unknown.json")
	end
end


function syncCoupons()
    if not has("opt_keyitems_off") then return end
    local count = 0
    for _, code in ipairs({"coupon_1", "coupon_2", "coupon_3"}) do
        if Tracker:FindObjectForCode(code).Active then
            count = count + 1
        end
    end
    Tracker:FindObjectForCode("coupons").AcquiredCount = count
end

function syncUnownFile()
    if not has("opt_hidden_off") then return end
    local count = 0
    for _, code in ipairs(UNOWN_ITEMS) do
        if Tracker:FindObjectForCode(code).Active then
            count = count + 1
        end
    end
    Tracker:FindObjectForCode("unownfile").AcquiredCount = count
end

function syncPokedex()
    if not has("opt_pokedex_off") then return end
    local count = 0
    for _, code in ipairs({"pokedex_1", "pokedex_2", "pokedex_3"}) do
        if Tracker:FindObjectForCode(code).Active then
            count = count + 1
        end
    end
    Tracker:FindObjectForCode("pokedex").CurrentStage = count
end

function syncHostedFromBase(code)
    Tracker:FindObjectForCode(code.."_hosted").Active = Tracker:FindObjectForCode(code).Active
end

function syncBaseFromHosted(code)
    local base = code:gsub("_hosted", "")
    Tracker:FindObjectForCode(base).Active = Tracker:FindObjectForCode(code).Active
end
