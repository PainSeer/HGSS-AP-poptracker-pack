SLOT_CODES = {
    version = {code = "game_version"},
    pokegear_card = {code = "opt_pokegearcards"},
    hms = {code = "opt_hms"},
    badges = {code = "opt_badges"},
    overworlds = {code = "opt_overworld"},
    hiddens = {code = "opt_hidden"},
    npc_gifts = {code = "opt_npcgifts"},
    key_items = {code = "opt_keyitems"},
    rods = {code = "opt_rods"},
    running_shoes = {code = "opt_shoes"},
    bicycle = {code = "opt_bicycle"},
    pokedex = {code = "opt_pokedex"},
    visibility_hm_logic = {code = "opt_hm_visibility"},
    dowsing_machine_logic = {code = "opt_dowsing"},
    goal = {code = "opt_goal"},
    require_restored_power_for_magnet_train = {code = "opt_train"},
    hm_reader = {code = "opt_hmreader"},
    sound_items = {code = "opt_sounditems"},
    time_items = {code = "opt_timeitems"},
    mossy_rock_locations = {code = "opt_mossy_rock"},
    icy_rock_locations = {code = "opt_icy_rock"},
    ap_items_shop_in_ap_helper = {code = "opt_items_shop_in_ap_helper"},
    require_fly_items_for_flight = {code = "opt_require_fly_items_for_flight"}
}

HM_CODES = {
    cut = "hm01cut",
    fly = "hm02fly",
    surf = "hm03surf",
    strength = "hm04strength",
    defog = "hm05whirlpool",
    rock_smash = "hm06rocksmash",
    waterfall = "hm07waterfall",
    rock_climb = "hm08rockclimb"
}

LIST_CODES = {
    in_logic_encounters = {
        values = {
            ["rock_smash"]                  = "encmethod_rocksmash",
            ["sounds"]                      = "encmethod_sounds",
--            ["surf"]                        = "encmethod_surf",
            ["rods"]                        = "encmethod_fishing",
            ["time"]                        = "encmethod_time",
--            ["roamers"]                     = "encmethod_roamer",
        }
    },
    in_logic_evolution_methods = {
        values = {
            ["level"]               = "evomethod_level",
            ["happiness"]           = "evomethod_happiness",
            ["use_item"]            = "evomethod_useitem",
            ["held_item"]           = "evomethod_helditem",
            ["time"]                = "evomethod_time",
            ["location"]            = "evomethod_location",
            ["mildly_annoying"]     = "evomethod_mildlyannoying",
            ["highly_annoying"]     = "evomethod_highlyannoying",
        }
    },
--    randomize_fly_items = {
--        values = {
--            ["kanto"]               = "flyunlocks_kanto",
--            ["johto"]               = "flyunlocks_johto",
--            ["pokemon_league"]      = "flyunlocks_pokemon_league",
--            ["mount_silver"]        = "flyunlocks_mount_silver"
--        }
--    }

}