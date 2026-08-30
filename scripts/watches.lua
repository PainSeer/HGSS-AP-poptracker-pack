-- Standard Handlers
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotify)
Archipelago:AddBouncedHandler("map handler", onMap)

-- Layout Watches
ScriptHost:AddWatchForCode("opt_hmreader", "opt_hmreader", toggle_itemgrid)
ScriptHost:AddWatchForCode("splitmap", "splitmap", toggle_splitmap)
ScriptHost:AddWatchForCode("opt_randomize_fly_items", "opt_randomize_fly_items", toggle_trackerlayout)
ScriptHost:AddWatchForCode("game_version", "game_version", toggle_itemgrid)
ScriptHost:AddWatchForCode("game_version2", "game_version", toggle_eventgrid)

-- Pokemon Related
ScriptHost:AddWatchForCode("encounter_tracking", "encounter_tracking", updatePokemon)
ScriptHost:AddWatchForCode("search_active", "search_active", searchMon)
ScriptHost:AddWatchForCode("search_geodude_active", "search_geodude_active", searchGeodude)
ScriptHost:AddWatchForCode("search_kecleon_active", "search_kecleon_active", searchKecleon)
ScriptHost:AddWatchForCode("search_snorlax_active", "search_snorlax_active", searchSnorlax)
ScriptHost:AddWatchForCode("search_amity_active", "search_amity_active", searchAmity)

-- Other
ScriptHost:AddWatchForCode("hint_tracking", "hint_tracking", toggleHints)

-- Vanilla Item Syncs
--for _, code in ipairs({"pokedex_1", "pokedex_2", "pokedex_3"}) do
--    ScriptHost:AddWatchForCode(code, code, syncPokedex)
--end
--
---- Event Location Syncs
--for _, code in ipairs(FLAG_EVENT_CODES) do
--    ScriptHost:AddWatchForCode(code, code, syncHostedFromBase)
--    ScriptHost:AddWatchForCode(code.."_hosted", code.."_hosted", syncBaseFromHosted)
--end
--
---- Vanilla Item Location Syncs
--for _, code in ipairs(HOSTED_VANILLA_CODES) do
--    ScriptHost:AddWatchForCode(code, code, syncHostedFromBase)
--    ScriptHost:AddWatchForCode(code.."_hosted", code.."_hosted", syncBaseFromHosted)
--end
--
---- The edge cases. Those fuckers.
--local hosted_specific = {"coupon_1", "coupon_2", "coupon_3", "pokedex_1", "pokedex_2", "pokedex_3"}
--for _, code in ipairs(UNOWN_ITEMS) do table.insert(hosted_specific, code) end
--for _, code in ipairs(hosted_specific) do
--    ScriptHost:AddWatchForCode(code.."_hostsync", code, syncHostedFromBase)
--    ScriptHost:AddWatchForCode(code.."_hosted", code.."_hosted", syncBaseFromHosted)
--end

-- Debug
--ScriptHost:AddWatchForCode("debug", "*", debug)
--ScriptHost:AddOnLocationSectionChangedHandler("debug", debug)
