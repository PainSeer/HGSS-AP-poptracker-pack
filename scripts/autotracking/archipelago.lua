require("scripts/autotracking/item_mapping")
require("scripts/autotracking/location_mapping")
require("scripts/autotracking/option_mapping")
require("scripts/autotracking/flag_mapping")
require("scripts/autotracking/map_mapping")
require("scripts/autotracking/encounter_mapping")

CUR_INDEX = -1
SLOT_DATA = nil

SLOT_DATA = {}
ENCOUNTERS_GROUPED = {}
POKEMON_TO_LOCATIONS = {}
ROOM_SEED = "default"
SAVED_HINTS = {}
TRAINER_START_ID = 262148
TRAINER_END_ID = 262878

if Highlight then
    HIGHLIGHT_LEVEL= {
        [10] = Highlight.Unspecified,
        [20] = Highlight.Avoid,
        [30] = Highlight.Priority,
        [40] = Highlight.None,
        [100] = Highlight.Unspecified,
        [101] = Highlight.Priority,
        [102] = Highlight.NoPriority,
        [103] = Highlight.Priority,
        [104] = Highlight.Avoid,
        [105] = Highlight.Priority,
        [106] = Highlight.NoPriority,
        [107] = Highlight.Priority,
    }
end

HIGHLIGHT_PRIORITY =  {
    [Highlight.Priority] = 1, -- priority
    [Highlight.NoPriority] = 2, -- useful
    [Highlight.Avoid] = 3, -- trap
    [Highlight.Unspecified] = 4, -- filler
    [Highlight.None] = 5 -- none
}

function onClear(slot_data)
    print(dump_table(slot_data))
    CUR_INDEX = -1
    PLAYER_ID = Archipelago.PlayerNumber or -1
    TEAM_NUMBER = Archipelago.TeamNumber or 0
    SLOT_DATA = slot_data
    GAME = Archipelago:GetPlayerGame(PLAYER_ID)
    
    -- we check for correct game, version, and non manual
    if GAME == "Pokemon HGSS" or GAME == "Pokemon HeartGold" then
        Tracker:AddLayouts("layouts/errors/error_singe.json")
        return
    elseif GAME == "Pokemon HeartGold and SoulSilver" then
        local version = tostring(slot_data["world_version"])
        local major_version = version:match("^([^.]+%.[^.]+)%.")
        local patch_version = tonumber(version:match("^[^.]+%.[^.]+%.(%d+)"))
        if major_version == "0.0" and patch_version >= 6 then
            toggle_trackerlayout() -- the version in slot-data is currently fucked. It's always 1 lol.
        else
            Tracker:AddLayouts("layouts/errors/error_version.json")
        end
    else
        Tracker:AddLayouts("layouts/errors/error_game.json")
        return
    end

    -------------------------------------------------
    -- RESET AREA
    resetLocations()
    resetItems()
    
    -- resets trainer visibility. I gave up on making it dynamic, now we just flat out reset everything :(
    for id, _ in pairs(LOCATION_MAPPING) do
        if id >= TRAINER_START_ID and id <= TRAINER_END_ID then
            Tracker:FindObjectForCode("opt_trainer_" .. id).Active = false
        end
    end
    -------------------------------------------------

    ENCOUNTERS_GROUPED = {}
    POKEMON_TO_LOCATIONS = {}

    for slot_key, dex_number in pairs(slot_data.generated_encounters or {}) do
        local section = ENCOUNTER_MAPPING[slot_key]
        if section ~= nil then
            if ENCOUNTERS_GROUPED[section] == nil then
                ENCOUNTERS_GROUPED[section] = {}
            end
            table.insert(ENCOUNTERS_GROUPED[section], dex_number)

            if POKEMON_TO_LOCATIONS[dex_number] == nil then
                POKEMON_TO_LOCATIONS[dex_number] = {}
            end
            table.insert(POKEMON_TO_LOCATIONS[dex_number], section)
        end
    end

    -------------------------------------------------



    for k, v in pairs(slot_data) do
        if SLOT_CODES[k] then
            local stage = (SLOT_CODES[k].mapping and SLOT_CODES[k].mapping[v] or v)
            Tracker:FindObjectForCode(SLOT_CODES[k].code).CurrentStage = stage
        elseif LIST_CODES[k] then
            for _, code in pairs(LIST_CODES[k].values) do
                Tracker:FindObjectForCode(code).CurrentStage = 0
            end
        
            for _, name in ipairs(v or {}) do
                local code = LIST_CODES[k].values[name]
                if code then
                    Tracker:FindObjectForCode(code).CurrentStage = 1
                end
            end
        elseif k == "blue_return_viridian_badge_requirement" then
            Tracker:FindObjectForCode("opt_blue_badges").AcquiredCount = v
        elseif k == "remove_badge_requirements" then
            -- this can be simplified / reverted if TrueBlue resolves "all" to the individual codes
            local remove_all = false
            for _, hm in pairs(v) do
                if hm == "all" then
                    remove_all = true
                    break
                end
            end
            if remove_all then
                for _, code in pairs(HM_CODES) do
                    Tracker:FindObjectForCode(code).CurrentStage = 1
                end
            else
                for _, hm in pairs(v) do
                    if HM_CODES[hm] then
                        Tracker:FindObjectForCode(HM_CODES[hm]).CurrentStage = 1
                    end
                end
            end
        elseif k == "trainersanity_trainers" then
            if #v == 0 then
                TRAINERS:setType("none")
            elseif #v == 461 then
                TRAINERS:setType("full")
            else
                TRAINERS:setType("partial")
                TRAINERS:setStage(#v)
                for _, value in ipairs(v) do
                    Tracker:FindObjectForCode("opt_trainer_" .. value).Active = true
                end
            end
        elseif k == "dexsanity_specs" then
            local rolled_dexsanity = {}
            for _, num in ipairs(v) do
                rolled_dexsanity[num] = true
            end
            for i = 1, 493 do
                Tracker:FindObjectForCode("dexsanity_visibility_" .. i).Active = rolled_dexsanity[i] == true
            end
            Tracker:FindObjectForCode("opt_dexsanity").AcquiredCount = #v
            if #v == 0 then
                Tracker:FindObjectForCode("location_visibility").CurrentStage = 0
            else
                Tracker:FindObjectForCode("location_visibility").CurrentStage = 1
            end
        end
    end

    -- Fly Unlocks processing
    local stages = {
        ["0000"] = 0,
        ["0001"] = 1,
        ["0010"] = 2,
        ["0011"] = 3,
        ["0100"] = 4,
        ["0101"] = 5,
        ["0110"] = 6,
        ["0111"] = 7,
        ["1000"] = 8,
        ["1001"] = 9,
        ["1010"] = 10,
        ["1011"] = 11,
        ["1100"] = 12,
        ["1101"] = 13,
        ["1110"] = 14,
        ["1111"] = 15
    }

    -- Fetch Active values for Kanto, Johto, Pokémon League, Mount Silver
    local kanto = Tracker:FindObjectForCode("flyunlocks_kanto").Active and "1" or "0"
    local johto = Tracker:FindObjectForCode("flyunlocks_johto").Active and "1" or "0"
    local pokemon_league = Tracker:FindObjectForCode("flyunlocks_pokemonleague").Active and "1" or "0"
    local mount_silver = Tracker:FindObjectForCode("flyunlocks_mtsilver").Active and "1" or "0"

    -- Concatenate values to form the key
    local key = kanto .. johto .. pokemon_league .. mount_silver

    -- Set the CurrentStage of opt_randomize_fly_items based on the key
    Tracker:FindObjectForCode("opt_randomize_fly_items").CurrentStage = stages[key] or 0

    initiateVanillaFlyTracking()

    -- resetting datastorage events that aren't reset at other places
    updateEvents(1, 0)
    updateEvents(2, 0)

    -- resets all vanilla key items
    for register = 1, 4 do
        local list = _G["FLAG_ITEM" .. tostring(register) .. "_CODES"]
        for _, obj in ipairs(list) do
            if obj.codes then
                for _, code in ipairs(obj.codes) do
                    if code ~= "" then
                        Tracker:FindObjectForCode(code).Active = false
                    end
                end
            end
        end
    end
    -- note: hints, seen, caught, are reset in other places

    if Archipelago.PlayerNumber > -1 then
        local slot = TEAM_NUMBER .. "_" .. PLAYER_ID
        local function makeID(key, suffix)
            return "pokemon_hgss_" .. key .. slot .. (suffix or "")
        end
        IDs = {
            EVENT1     = makeID("tracked_events_", "_0"),
            EVENT2     = makeID("tracked_events_", "_1"),
            SEEN       = makeID("seen_pokemon_"),
            CAUGHT     = makeID("caught_pokemon_"),
--            ROADBLOCK  = makeID("saw_locations_"),
            KEY1       = makeID("tracked_unrandomized_required_locations_", "_0"),
            KEY2       = makeID("tracked_unrandomized_required_locations_", "_1"),
            KEY3       = makeID("tracked_unrandomized_required_locations_", "_2"),
            KEY4       = makeID("tracked_unrandomized_required_locations_", "_3"),
            HINT       = makeID("_read_hints_", ""),
        }
        
        for _, id in pairs(IDs) do
            Archipelago:SetNotify({id})
            Archipelago:Get({id})
        end
    end
end

function resetLocations()
    for _, location_array in pairs(LOCATION_MAPPING) do
        for _, location in pairs(location_array) do
            if location then
                local location_obj = Tracker:FindObjectForCode(location)
                if location_obj then
                    if location:sub(1, 1) == "@" then
                        location_obj.AvailableChestCount = location_obj.ChestCount
                    else
                        location_obj.Active = false
                    end
                end
            end
        end
    end
end

function resetItems()
    for _, item_array in pairs(ITEM_MAPPING) do
        for _, item_pair in pairs(item_array) do
            item_code = item_pair[1]
            item_type = item_pair[2]
            -- print("on clear", item_code, item_type)
            local item_obj = Tracker:FindObjectForCode(item_code)
            if item_obj then
                if item_obj.Type == "toggle" then
                    item_obj.Active = false
                elseif item_obj.Type == "progressive" then
                    item_obj.CurrentStage = 0
                elseif item_obj.Type == "consumable" then
                    if item_obj.MinCount then
                        item_obj.AcquiredCount = item_obj.MinCount
                    else
                        item_obj.AcquiredCount = 0
                    end
                elseif item_obj.Type == "progressive_toggle" then
                    item_obj.CurrentStage = 0
                    item_obj.Active = false
                end
            end
        end
    end
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local item = ITEM_MAPPING[item_id]
    if not item or not item[1] then
        --print(string.format("onItem: could not find item mapping for id %s", item_id))
        return
    end
    for _, item_pair in pairs(item) do
        item_code = item_pair[1]
        item_type = item_pair[2]
        local item_obj = Tracker:FindObjectForCode(item_code)
        if item_obj then
            if item_obj.Type == "toggle" then
                -- print("toggle")
                item_obj.Active = true
            elseif item_obj.Type == "progressive" then
                -- print("progressive")
                if item_obj.Active == true then
                    item_obj.CurrentStage = item_obj.CurrentStage + 1
                else
                    item_obj.Active = true
                end
            elseif item_obj.Type == "consumable" then
                -- print("consumable")
                item_obj.AcquiredCount = item_obj.AcquiredCount + item_obj.Increment * (tonumber(item_pair[3]) or 1)
            elseif item_obj.Type == "progressive_toggle" then
                -- print("progressive_toggle")
                if item_obj.Active then
                    item_obj.CurrentStage = item_obj.CurrentStage + 1
                else
                    item_obj.Active = true
                end
            end
        else
            print(string.format("onItem: could not find object for code %s", item_code[1]))
        end
    end
end

-- This is a debug to be used so you can check if there's locations that exist in either
-- the pack or the game (fullsanity seed) that don't in the tracker
------ tables to track usage
----local missing_mappings = {}   -- location_ids passed to function but not in LOCATION_MAPPING
----local called_mappings  = {}   -- mappings that were actually used
----
----function onLocation(location_id, location_name)
----    local location_array = LOCATION_MAPPING[location_id]
----
----    -- mark this id as called
----    called_mappings[location_id] = true
----
----    -- no mapping exists
----    if not location_array then
----        missing_mappings[location_id] = true
----        return
----    end
----
----    for _, location in pairs(location_array) do
----        -- (code)
----    end
----end
----
------ call this when processing is finished
----function printLocationReport()
----    print("=== Missing LOCATION_MAPPING ===")
----    for id, _ in pairs(missing_mappings) do
----        print(id)
----    end
----
----    print("=== LOCATION_MAPPING never called ===")
----    for id, _ in pairs(LOCATION_MAPPING) do
----        if not called_mappings[id] then
----            print(id)
----        end
----    end
----end

---- we use this for hint tracking
CLEARED_LOCATIONS = {}
--called when a location gets cleared
function onLocation(location_id, location_name)
    local location_array = LOCATION_MAPPING[location_id]
    if not location_array or not location_array[1] then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
        return
    end

    for _, location in pairs(location_array) do
        local location_obj = Tracker:FindObjectForCode(location)
        -- print(location, location_obj)
        if location_obj then
            if location:sub(1, 1) == "@" then
                location_obj.AvailableChestCount = location_obj.AvailableChestCount - 1
                local current_total = CLEARED_LOCATIONS[location_id] or 0
                CLEARED_LOCATIONS[location_id] = current_total + 1
            else
                location_obj.Active = true
            end
        else
            print(string.format("onLocation: could not find location_object for code %s", location))
        end
    end
end

function onNotify(key, value, old_value)
    if value ~= nil and value ~= 0 and old_value ~= value then
        if key == IDs.EVENT1 then
            updateEvents(1, value)
        elseif key == IDs.EVENT2 then
            updateEvents(2, value)
--        elseif key == IDs.ROADBLOCK then
--            updateRoadblock(value)
        elseif key == IDs.KEY1 then
            updateVanillaKeyItems(1, value)
        elseif key == IDs.KEY2 then
            updateVanillaKeyItems(2, value)
        elseif key == IDs.KEY3 then
            updateVanillaKeyItems(3, value)
        elseif key == IDs.KEY4 then
            updateVanillaKeyItems(4, value)
        elseif key == IDs.HINT then
            SAVED_HINTS = value
            updateHints()
        elseif key == IDs.CAUGHT then
            updateCaught(value)
        elseif key == IDs.SEEN then
            updateSeen(value)
        end
    end
end

function updateEvents(register, value)
    if value == nil then return end
    
    local list = _G["FLAG_EVENT" .. tostring(register) .. "_CODES"]
    
    for i, code in ipairs(list) do
        local bit = (value >> (i - 1)) & 1
        Tracker:FindObjectForCode(code).Active = (bit == 1)
    end
end

--function updateRoadblock(value)
--    for i, rb in ipairs(FLAG_ROADBLOCKS) do
--        local bit = (value >> (i - 1)) & 1
--        if bit == 1 then
--            Tracker:FindObjectForCode(SLOT_CODES[rb.option].code).CurrentStage = SAVED_ROADBLOCKS[rb.option]
--        end
--    end
--end

function updateVanillaKeyItems(register, value)
    if value == nil then return end

    local list = _G["FLAG_ITEM" .. tostring(register) .. "_CODES"]

    for i, obj in ipairs(list) do
        local bit = (value >> (i - 1)) & 1
        if bit == 1 and obj.codes and (not obj.option or has(obj.option)) then
            for _, code in ipairs(obj.codes) do
                Tracker:FindObjectForCode(code).Active = true
            end
        end
    end

    syncPokedex()
    syncPokegear()
end

function toggleHints()
    if has("hint_tracking_off") then
        updatePokemon()
        resetHints()
    elseif has("hint_tracking_on") then
        resetHints()
        updateHints()
        updatePokemon()
    elseif has("hint_tracking_on_plus") then
        updateHints()
        updatePokemon()
    end
end

function toggle_encvisibility()
    if Tracker:FindObjectForCode("dexsanity").AcquiredCount ~= 0 then
        Tracker:FindObjectForCode("location_visibility").CurrentStage = 1
    end
end

function resetHints()
    CLEARED_HINTS = {}
    for _, hint in ipairs(SAVED_HINTS) do
        if hint.finding_player == PLAYER_ID then
            local mapped = LOCATION_MAPPING[hint.location]
            local locations = (type(mapped) == "table") and mapped or { mapped }
    
            for _, location in ipairs(locations) do
                -- Only sections (items don't support Highlight)
                if location:sub(1, 1) == "@" then
                    local obj = Tracker:FindObjectForCode(location)
                    local final_value = obj.ChestCount
                    local cleared = CLEARED_LOCATIONS[location] or 0
                    final_value = final_value - cleared
                    obj.AvailableChestCount = final_value
                    obj.Highlight = 0
                end
            end
        end
    end
    
    for _, section in ipairs(ENCOUNTER_SECTIONS) do
        local obj = Tracker:FindObjectForCode(section)
        if obj then
            obj.Highlight = 0
        end
    end
end

CLEARED_HINTS = {}
function updateHints()
    if not Highlight then return end
    if has("hint_tracking_off") then return end

    CLEARED_HINTS = {}

    for _, locations in pairs(LOCATION_MAPPING) do
        for _, location in pairs(locations) do
            if location:sub(1, 1) == "@" then
                local obj = Tracker:FindObjectForCode(location)
                obj.Highlight = 0
            end
        end
    end
    for _, section in ipairs(ENCOUNTER_SECTIONS) do
        local obj = Tracker:FindObjectForCode(section)
        if obj then
            obj.Highlight = 0
        end
    end

    local tracking_plus = has("hint_tracking_on_plus")
    for _, hint in ipairs(SAVED_HINTS) do
        if hint.finding_player == PLAYER_ID then
            local mapped = LOCATION_MAPPING[hint.location]
            local incoming_val = 0
            
            if hint.status == 0 then
                incoming_val = HIGHLIGHT_LEVEL[100 + hint.item_flags]
            else
                incoming_val = HIGHLIGHT_LEVEL[hint.status]
            end

            -- Special handling for Pokémon locations (196609–197101)
            if hint.location >= 196609 and hint.location <= 197101 then
                local poke_id = hint.location - 196608
                local poke_locations = POKEMON_TO_LOCATIONS[poke_id]

                if poke_locations then
                    for _, section in ipairs(poke_locations) do
                        local obj = Tracker:FindObjectForCode(section)
                        if obj then
                            if tracking_plus then
                                if hint.found == false and incoming_val == Highlight.Priority then
                                    obj.Highlight = incoming_val
                                end
                            else
                                local current_val = obj.Highlight
                                if current_val == nil or HIGHLIGHT_PRIORITY[incoming_val] < HIGHLIGHT_PRIORITY[current_val] then
                                    obj.Highlight = incoming_val
                                end
                            end
                        end
                    end
                end

                goto continue_hint
            end

            local locations = (type(mapped) == "table") and mapped or { mapped }

            for _, location in ipairs(locations) do
                if location:sub(1, 1) == "@" then
                    local obj = Tracker:FindObjectForCode(location)
    
                    if tracking_plus then
                        if hint.found == false then
                            if incoming_val == Highlight.Priority then
                                obj.Highlight = incoming_val
                            else
                                local current_total = CLEARED_HINTS[location] or 0
                                CLEARED_HINTS[location] = current_total + 1
                            end
                        end
                    else
                        local current_val = obj.Highlight
                        if current_val == nil or HIGHLIGHT_PRIORITY[incoming_val] < HIGHLIGHT_PRIORITY[current_val] then
                            obj.Highlight = incoming_val
                        end
                    end
                end
            end

            ::continue_hint::
        end
    end

    if tracking_plus then
        for location, count in pairs(CLEARED_HINTS) do
            local obj = Tracker:FindObjectForCode(location)
            local cleared = CLEARED_LOCATIONS[location] or 0
            obj.AvailableChestCount = obj.ChestCount - count - cleared
            if obj.AvailableChestCount == 0 then
                obj.Highlight = 0
            end
        end
    end
end

--function onMap(mapBounce)
--    if has("automap_on") and mapBounce.data ~= nil then
--        local mapID = mapBounce.data.mapNumber

--        if MAP_XZYSPLIT_MAPPING[mapID] ~= nil then
--            local matrixX = mapBounce.data.matrixX
--            local matrixZ = mapBounce.data.matrixZ
--            local playerY = mapBounce.data.playerY
--            local tabs = MAP_XZYSPLIT_MAPPING[mapID] and MAP_XZYSPLIT_MAPPING[mapID][matrixX] and MAP_XZYSPLIT_MAPPING[mapID][matrixX][matrixZ] and MAP_XZYSPLIT_MAPPING[mapID][matrixX][matrixZ][playerY]
--            if tabs then
--                for i, tab in ipairs(tabs) do
--                    Tracker:UiHint("ActivateTab", tab)
--                end
--            end
--        elseif MAP_SPLIT_MAPPING[mapID] ~= nil then
--            local matrixX = mapBounce.data.matrixX
--            local matrixZ = mapBounce.data.matrixZ
--            local tabs = MAP_SPLIT_MAPPING[mapID] and MAP_SPLIT_MAPPING[mapID][matrixX] and MAP_SPLIT_MAPPING[mapID][matrixX][matrixZ]
--            if tabs then
--                for i, tab in ipairs(tabs) do
--                    Tracker:UiHint("ActivateTab", tab)
--                end
--            end
--        elseif mapID == 336 or mapID == 373 then
--            Tracker:UiHint("ActivateTab", "Routes")
--            Tracker:UiHint("ActivateTab", "R213 & VLF")

            -- Special handling for this as they're a mess of interconectedness
            -- We are specifically panning to the areas the player is in,
            -- loosely based on their matrix coordinate
            -- each matrix should be 25x25 blocks. to get to the center of the next one,
            -- that's 800 pixels. (16 pixels per block)

            -- for this giant map, the boundaries are the following:
            -- matrixZ: 23-26 (including)
            -- matrixX: 20-22 (including)

--            local x_cor = 294 + ((mapBounce.data.matrixX - 20) * 500)
--            if x_cor >= 1094 then
--                x_cor = 1094
--            elseif x_cor <= 794 then
--                x_cor = 794
--            end

--            local y_cor = 200 + ((mapBounce.data.matrixZ - 23) * 500)
--            if y_cor >= 1648 then
--                y_cor = 1648
--            elseif y_cor <= 200 then
--                y_cor = 500
--            end

--            Tracker:UiHint("Zoom route213valorlakefront", 2)
--            Tracker:UiHint("Pan route213valorlakefront", x_cor..","..y_cor)
--        elseif MAP_MAPPING[mapID] ~= nil then    
--            local tabs = MAP_MAPPING[mapID]
--            if tabs then
--                for _, tab in ipairs(tabs) do
--                    Tracker:UiHint("ActivateTab", tab)
--                end
--            end
--        else
--            --print("No Mapping found for:")
--            --print(dump_table(mapBounce))
--        end
--    end
--end
