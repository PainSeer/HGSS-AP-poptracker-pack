-- Standard Handlers
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotify)
--Archipelago:AddBouncedHandler("map handler", onMap)

-- Layout Watches
ScriptHost:AddWatchForCode("opt_hmreader", "opt_hmreader", toggle_itemgrid)
ScriptHost:AddWatchForCode("splitmap", "splitmap", toggle_splitmap)
ScriptHost:AddWatchForCode("opt_randomize_fly_items", "opt_randomize_fly_items", toggle_trackerlayout)
ScriptHost:AddWatchForCode("game_version", "game_version", toggle_itemgrid)
ScriptHost:AddWatchForCode("game_version2", "game_version", toggle_eventgrid)
ScriptHost:AddWatchForCode("game_version3", "game_version", toggle_dexsearchgrid)
ScriptHost:AddWatchForCode("opt_mossy_rock", "opt_mossy_rock", toggle_mossyrock)
ScriptHost:AddWatchForCode("opt_icy_rock", "opt_icy_rock", toggle_icyrock)

-- Pokemon Related
ScriptHost:AddWatchForCode("encounter_tracking", "encounter_tracking", updatePokemon)
ScriptHost:AddWatchForCode("search_active", "search_active", searchMon)
ScriptHost:AddWatchForCode("search_geodude_active", "search_geodude_active", searchGeodude)
ScriptHost:AddWatchForCode("search_kecleon_active", "search_kecleon_active", searchKecleon)
ScriptHost:AddWatchForCode("search_snorlax_active", "search_snorlax_active", searchSnorlax)
ScriptHost:AddWatchForCode("search_amity_active", "search_amity_active", searchAmity)

-- Other
ScriptHost:AddWatchForCode("hint_tracking", "hint_tracking", toggleHints)

-- Vanilla Item Sync for toggle item <-> consumable/progressive item
for _, code in ipairs({"pokedex_1", "pokedex_2"}) do
    ScriptHost:AddWatchForCode(code, code, syncPokedex)
end

for _, code in ipairs({"upgradableradiopokegearcard_1", "upgradableradiopokegearcard_2"}) do
    ScriptHost:AddWatchForCode(code, code, syncPokegear)
end

-- Event Location Syncs
for _, code in ipairs(FLAG_EVENT_CODES) do
    ScriptHost:AddWatchForCode(code, code, syncHostedFromBase)
    ScriptHost:AddWatchForCode(code.."_hosted", code.."_hosted", syncBaseFromHosted)
end

-- Vanilla Location Syncs
for _, code in ipairs(HOSTED_VANILLA_CODES) do
    ScriptHost:AddWatchForCode(code, code, syncHostedFromBase)
    ScriptHost:AddWatchForCode(code.."_hosted", code.."_hosted", syncBaseFromHosted)
end

-- Vanilla Location Syncs (consumable + progressive items)
local hosted_specific = {"pokedex_1", "pokedex_2", "upgradableradiopokegearcard_1", "upgradableradiopokegearcard_2"}
for _, code in ipairs(hosted_specific) do
    ScriptHost:AddWatchForCode(code.."_hosted", code.."_hosted", syncBaseFromHosted)
end

-- Debug
--ScriptHost:AddWatchForCode("debug", "*", debug)
--ScriptHost:AddOnLocationSectionChangedHandler("debug", debug)
