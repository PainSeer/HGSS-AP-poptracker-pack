function toggle_itemgrid()
    local suffix = ""

    if not has("pokemon_heartgold") then
        suffix = suffix .. "_ss"
    end

    if not has("opt_hmreader_off") then
        suffix = suffix .. "_hmreader"
    end
    
    Tracker:AddLayouts("layouts/items/items"..suffix..".json")
end

function toggle_eventgrid()
    local suffix = ""

    if not has("pokemon_heartgold") then
        suffix = suffix .. "_ss"
    end
    
    Tracker:AddLayouts("layouts/events"..suffix..".json")
end

function toggle_dexsearchgrid()
    local suffix = ""

    if not has("pokemon_heartgold") then
        suffix = suffix .. "_ss"
    end
    
	Tracker:AddLayouts("layouts/dexsearch"..suffix..".json")
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
    local suffix = ""
   
    if not has("opt_randomize_fly_items_none") then
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

function toggle_mossyrock()
    if has("opt_mossy_rock_johto") then
        Tracker:AddMaps("maps/ilexforest_mossy.json")
    else
        Tracker:AddMaps("maps/ilexforest.json")
    end

    if has("opt_mossy_rock_kanto") then
        Tracker:AddMaps("maps/viridianforest_mossy.json")
	else
        Tracker:AddMaps("maps/viridianforest.json")
    end
end

function toggle_icyrock()
    if has("opt_icy_rock_johto") then
        Tracker:AddMaps("maps/icepath1f_icy.json")
    else
        Tracker:AddMaps("maps/icepath1f.json")
    end    

    if has("opt_icy_rock_kanto") then
        Tracker:AddMaps("maps/seafoamislandsb3f_icy.json")
    else 
        Tracker:AddMaps("maps/seafoamislandsb3f.json")
    end
end
