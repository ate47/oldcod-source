#using script_7893277eec698972;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\zm\zm_zodt8;
#using scripts\zm\zm_zodt8_pap_quest;
#using scripts\zm\zm_zodt8_sentinel_trial;
#using scripts\zm\zm_zodt8_side_quests;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_trial_util;

#namespace zm_zodt8_devgui;

/#

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7438965f, Offset: 0xc0
    // Size: 0x1c6
    function function_91912a79() {
        zm_devgui::add_custom_devgui_callback(&function_c18b7cd9);
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:x7b>");
        adddebugcommand("<dev string:xbd>");
        adddebugcommand("<dev string:xf4>");
        adddebugcommand("<dev string:x146>");
        adddebugcommand("<dev string:x19a>");
        adddebugcommand("<dev string:x1e1>");
        adddebugcommand("<dev string:x244>");
        adddebugcommand("<dev string:x2a9>");
        adddebugcommand("<dev string:x30e>");
        adddebugcommand("<dev string:x377>");
        adddebugcommand("<dev string:x3be>");
        adddebugcommand("<dev string:x409>");
        adddebugcommand("<dev string:x452>");
        adddebugcommand("<dev string:x4a7>");
        adddebugcommand("<dev string:x4f3>");
        level.var_f277a2d8 = &function_235b514e;
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x471683ba, Offset: 0x290
    // Size: 0x3f2
    function function_c18b7cd9(cmd) {
        switch (cmd) {
        case #"hash_50d92ca3c6c7c2a8":
            level thread function_432361ef();
            return 1;
        case #"gear_up":
            level thread zodt8_sentinel::gear_up();
            return 1;
        case #"hash_672373a99384fb53":
            level thread function_86384fe4();
            return 1;
        case #"hash_5634a634a8ffec47":
            level thread function_1dd17ab6();
            return 1;
        case #"move_pap":
            level thread function_d507c91b();
            return 1;
        case #"hash_74823c0e0a29545b":
            give_flare("<dev string:x53f>");
            return 1;
        case #"hash_130280144168a5e7":
            give_flare("<dev string:x543>");
            return 1;
        case #"hash_2972e55f40fe8050":
            give_flare("<dev string:x549>");
            return 1;
        case #"hash_59b568ce3fe548b6":
            level thread function_aee2185c();
            return 1;
        case #"hash_be17a68845640e4":
            level thread function_8d422c15("<dev string:x54e>");
            return 1;
        case #"hash_5c17aed53086a4e8":
            level thread function_8d422c15("<dev string:x554>");
            return 1;
        case #"hash_2474089e18afbc3":
            level thread function_8d422c15("<dev string:x55b>");
            return 1;
        case #"hash_515fa2d180024bd3":
            level thread function_8d422c15("<dev string:x562>");
            return 1;
        case #"hash_687e53bfcb79ec3b":
            if (isdefined(level.chests) && isdefined(level.chest_index) && isdefined(level.chests[level.chest_index].zbarrier)) {
                level.chests[level.chest_index].zbarrier thread namespace_7890c038::function_daa4e0cd();
            }
            break;
        case #"hide_chests":
            function_d017a2f4();
            if (level.chest_index != -1) {
                chest = level.chests[level.chest_index];
                chest zm_magicbox::hide_chest(0);
            }
            break;
        case #"show_chests":
            function_d017a2f4();
            if (level.chest_index != -1) {
                chest = level.chests[level.chest_index];
                chest zm_magicbox::show_chest();
            }
            break;
        }
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa756c235, Offset: 0x690
    // Size: 0x30
    function function_d017a2f4() {
        while (level flag::get("<dev string:x56b>")) {
            waitframe(1);
        }
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5775faf2, Offset: 0x6c8
    // Size: 0x84
    function function_432361ef() {
        zm_devgui::zombie_devgui_open_sesame();
        level thread zodt8_pap_quest::function_b254f888();
        level flag::set(#"open_lore_room");
        level thread zm_zodt8::change_water_height_fore(1);
        level thread zm_zodt8::change_water_height_aft(1);
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x24bd7e23, Offset: 0x758
    // Size: 0x6c
    function function_d507c91b() {
        if (!level flag::get("<dev string:x57c>")) {
            level.s_pap_quest.var_d6c419fd = 0;
            level flag::set("<dev string:x57c>");
            return;
        }
        level zodt8_pap_quest::function_5e2ad5f4();
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xef0fc8b4, Offset: 0x7d0
    // Size: 0xdc
    function function_1dd17ab6() {
        if (level flag::get("<dev string:x58f>")) {
            if (level.e_clip_water_aft clientfield::get("<dev string:x5a1>") != 0) {
                iprintlnbold("<dev string:x5ba>");
            } else {
                zm_zodt8::change_water_height_aft(0);
            }
            return;
        }
        if (level.e_clip_water_aft clientfield::get("<dev string:x5a1>") != 0) {
            iprintlnbold("<dev string:x5ba>");
            return;
        }
        zm_zodt8::change_water_height_aft(1);
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x8b039fb0, Offset: 0x8b8
    // Size: 0xdc
    function function_86384fe4() {
        if (level flag::get("<dev string:x5f1>")) {
            if (level.e_clip_water_fore clientfield::get("<dev string:x5a1>") != 0) {
                iprintlnbold("<dev string:x604>");
            } else {
                zm_zodt8::change_water_height_fore(0);
            }
            return;
        }
        if (level.e_clip_water_fore clientfield::get("<dev string:x5a1>") != 0) {
            iprintlnbold("<dev string:x604>");
            return;
        }
        zm_zodt8::change_water_height_fore(1);
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6c27da50, Offset: 0x9a0
    // Size: 0x44
    function function_aee2185c() {
        a_e_players = getplayers();
        namespace_d17fd4ae::function_3f903b89(a_e_players[0]);
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xc067d84a, Offset: 0x9f0
    // Size: 0x13e
    function function_8d422c15(var_11c258f8) {
        a_e_players = getplayers();
        foreach (e_player in a_e_players) {
            switch (var_11c258f8) {
            case #"decay":
                namespace_d17fd4ae::function_53b76ce3(e_player);
                break;
            case #"plasma":
                namespace_d17fd4ae::function_f284dd11(e_player);
                break;
            case #"purity":
                namespace_d17fd4ae::function_2ba8b254(e_player);
                break;
            case #"radiance":
                namespace_d17fd4ae::function_c986900(e_player);
                break;
            }
        }
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x5723fc61, Offset: 0xb38
    // Size: 0x12e
    function give_flare(str_color) {
        a_e_players = getplayers();
        foreach (e_player in a_e_players) {
            switch (str_color) {
            case #"red":
                namespace_7890c038::give_flare("<dev string:x53f>");
                break;
            case #"green":
                namespace_7890c038::give_flare("<dev string:x543>");
                break;
            case #"blue":
                namespace_7890c038::give_flare("<dev string:x549>");
                break;
            }
        }
    }

    // Namespace zm_zodt8_devgui/zm_zodt8_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xb25aa8c, Offset: 0xc70
    // Size: 0x3dc
    function private function_235b514e(round_number) {
        var_12120e51 = array(0, 500, 1000, 1000, 1400, 4000, 5000, 5500, 5500, 5500, 8000, 8000, 8000, 8000, 9000, 9000, 9000, 9500, 9500, 9500, 9500, 11000, 11000, 11000, 11000, 13000, 13000, 13000, 13000, 14000);
        round_index = round_number - 1;
        assert(round_index >= 0 && round_index < 30);
        foreach (player in getplayers()) {
            player zm_score::function_fb877e6e(var_12120e51[round_index]);
        }
        if (round_number >= 7) {
            level flag::set("<dev string:x63a>");
            level flag::set(#"hash_3e80d503318a5674");
        }
        if (round_number >= 8) {
            assert(isdefined(level.var_1c7ed52c[#"zblueprint_shield_dual_wield"]));
            foreach (trigger in level.var_1c7ed52c[#"zblueprint_shield_dual_wield"]) {
                trigger.crafted = 1;
                trigger.blueprint = trigger.craftfoundry;
                if (isdefined(trigger.model)) {
                    trigger.model notsolid();
                    trigger.model show();
                }
            }
            foreach (player in getplayers()) {
                player zm_devgui::zombie_devgui_weapon_give(#"zhield_dw");
            }
        }
        if (round_number >= 9) {
            zm_trial_util::open_all_doors();
        }
        if (round_number >= 13) {
            level.s_pap_quest.var_d6c419fd = 0;
            level flag::set("<dev string:x57c>");
        }
        if (round_number >= 24) {
            zm_trial_util::function_6440f858();
        }
    }

#/
