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
ScriptHost:AddWatchForCode("search_magikarp_active", "search_magikarp_active", searchMagikarp)
ScriptHost:AddWatchForCode("search_chansey_active", "search_chansey_active", searchChansey)
ScriptHost:AddWatchForCode("search_jigglypuff_active", "search_jigglypuff_active", searchJigglypuff)
ScriptHost:AddWatchForCode("search_lickitung_active", "search_lickitung_active", searchLickitung)
ScriptHost:AddWatchForCode("search_oddish_active", "search_oddish_active", searchOddish)
ScriptHost:AddWatchForCode("search_marill_active", "search_marill_active", searchMarill)
ScriptHost:AddWatchForCode("search_staryu_active", "search_staryu_active", searchStaryu)
ScriptHost:AddWatchForCode("search_growlithe_active", "search_growlithe_active", searchGrowlithe)
ScriptHost:AddWatchForCode("search_vulpix_active", "search_vulpix_active", searchVulpix)
ScriptHost:AddWatchForCode("search_pichu_active", "search_pichu_active", searchPichu)

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
for _, code in ipairs(FLAG_EVENT1_CODES) do
    ScriptHost:AddWatchForCode(code, code, syncHostedFromBase)
    ScriptHost:AddWatchForCode(code.."_hosted", code.."_hosted", syncBaseFromHosted)
end
for _, code in ipairs(FLAG_EVENT2_CODES) do
    ScriptHost:AddWatchForCode(code, code, syncHostedFromBase)
    ScriptHost:AddWatchForCode(code.."_hosted", code.."_hosted", syncBaseFromHosted)
end
ScriptHost:AddWatchForCode("slowpoke_well_kurt", "event_clear_slowpoke_well", syncKurtFromSlowpokeWell)

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
