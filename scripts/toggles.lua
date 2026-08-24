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
