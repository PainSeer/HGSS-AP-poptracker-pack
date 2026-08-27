function toggle_gameversion()
    if has("pokemon_heartgold") then
        Tracker:AddLayouts("layouts/tracker_hg.json")
        Tracker:AddLayouts("layouts/items_hg_max.json")
    elseif has("pokemon_soulsilver") then
        Tracker:AddLayouts("layouts/tracker_ss.json")
        Tracker:AddLayouts("layouts/items_ss_max.json")
	end
end





function toggle_itemgrid()
    suffix = ""
    
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
