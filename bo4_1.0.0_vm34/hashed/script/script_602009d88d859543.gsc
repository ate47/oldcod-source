#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm\weapons\zm_weap_spectral_shield;
#using scripts\zm\zm_escape_vo_hooks;
#using scripts\zm\zm_escape_weap_quest;
#using scripts\zm_common\util\ai_brutus_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace namespace_bd4d66e5;

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 0, eflags: 0x0
// Checksum 0x3c4eb07e, Offset: 0x2c0
// Size: 0x15a
function init() {
    level.var_76123e8b = 1;
    level.var_6a5cf7c6 = &function_773a2251;
    level.var_18e96d09 = &function_302c8417;
    level.var_a4b4dee4 = &function_3153b08d;
    level.var_7482bc0e = &function_60ba6607;
    level.var_8ffc2d68 = &function_1108a598;
    level.var_25484282 = 1;
    if (level.var_25484282) {
        level.var_a8ae6233[#"cafeteria_west_side"] = 0;
        level.var_a8ae6233[#"warden_house_shower"] = 0;
    }
    level.var_4b03d246 = 1;
    level flag::init(#"hash_76a9f44aee68fe8e");
    level flag::init(#"hash_6a5df83b0716ed39");
    level.var_e3c3e322 = 31;
    level.var_2684a605 = 22;
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 0, eflags: 0x0
// Checksum 0xa0a33583, Offset: 0x428
// Size: 0xe
function function_ce7e7de0() {
    self.var_bf7ec16c = [];
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 0, eflags: 0x0
// Checksum 0xfe3a33aa, Offset: 0x440
// Size: 0x20a
function function_773a2251() {
    var_46078bf5 = self.unitrigger_stub.script_string;
    var_7d79285a = self.unitrigger_stub;
    switch (var_46078bf5) {
    case #"hash_1e3fbddd6a0b1088":
    case #"hash_3c428518d68f7f04":
        self.unitrigger_stub.var_796a4e2a = "warden_house_shower";
        break;
    case #"hash_40b0def60178b997":
    case #"hash_5422169ef482ba21":
        self.unitrigger_stub.var_796a4e2a = "cafeteria_west_side";
        break;
    }
    self.unitrigger_stub.var_9613e391 = struct::get("scene_" + var_46078bf5, "script_string");
    switch (var_46078bf5) {
    case #"hash_3c428518d68f7f04":
        var_7d79285a.var_a6c13c21 = struct::get("scene_shower_to_warden_house", "script_string");
        break;
    case #"hash_1e3fbddd6a0b1088":
        var_7d79285a.var_a6c13c21 = struct::get("scene_warden_house_to_shower", "script_string");
        break;
    case #"hash_5422169ef482ba21":
        var_7d79285a.var_a6c13c21 = struct::get("scene_cafeteria_to_west_side", "script_string");
        break;
    case #"hash_40b0def60178b997":
        var_7d79285a.var_a6c13c21 = struct::get("scene_west_side_to_cafeteria", "script_string");
        break;
    }
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 2, eflags: 0x0
// Checksum 0xc42d46b7, Offset: 0x658
// Size: 0x570
function function_302c8417(player, var_796a4e2a) {
    if (!isdefined(self.hint_string)) {
        self.hint_string = [];
    }
    n_player_index = player getentitynumber();
    b_result = 0;
    if (isdefined(self.stub)) {
        str_loc = self.stub.script_string;
    }
    if (!zombie_utility::is_player_valid(player)) {
        self.hint_string[n_player_index] = #"";
    } else if (isdefined(player.var_56c7266a) && player.var_56c7266a && self.stub.script_string !== "dropout") {
        self.hint_string[n_player_index] = #"";
    } else if (isdefined(player.var_14f171d3) && player.var_14f171d3) {
        self.hint_string[n_player_index] = #"";
    } else if (level flag::get(#"disable_fast_travel")) {
        self.hint_string[n_player_index] = #"";
    } else if (!level flag::get("power_on1")) {
        self.hint_string[n_player_index] = #"hash_1889aab1f9075530";
        self sethintstringforplayer(player, self.hint_string[n_player_index]);
        b_result = 1;
    } else if (isdefined(player.var_bf7ec16c[var_796a4e2a]) && player.var_bf7ec16c[var_796a4e2a] || isdefined(level.var_25484282) && level.var_25484282 && isdefined(level.var_a8ae6233[var_796a4e2a]) && level.var_a8ae6233[var_796a4e2a]) {
        self.hint_string[n_player_index] = #"hash_7667bd0f83307360";
        self sethintstringforplayer(player, self.hint_string[n_player_index]);
        b_result = 1;
    } else {
        self.hint_string[n_player_index] = #"";
        b_result = 1;
        switch (str_loc) {
        case #"hash_3c428518d68f7f04":
            if (level flag::get(#"hash_76a9f44aee68fe8e") || zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_3c4e15b133cbbbfa";
            } else {
                self.hint_string[n_player_index] = #"hash_2110980a2c8a4dd3";
            }
            break;
        case #"hash_1e3fbddd6a0b1088":
            if (level flag::get(#"hash_76a9f44aee68fe8e") || zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_751feed02ba9abc4";
            } else {
                self.hint_string[n_player_index] = #"hash_af863c29e30651d";
            }
            break;
        case #"hash_40b0def60178b997":
            if (level flag::get(#"hash_6a5df83b0716ed39") || zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_5bd2ed18b058d064";
            } else {
                self.hint_string[n_player_index] = #"hash_1db3b05a63943f7d";
            }
            break;
        case #"hash_5422169ef482ba21":
            if (level flag::get(#"hash_6a5df83b0716ed39") || zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_9fdf28b2277fe11";
            } else {
                self.hint_string[n_player_index] = #"hash_3600e293ddc9f9b6";
            }
            break;
        default:
            self.hint_string[n_player_index] = #"hash_2731cc5c1208e2e4";
            break;
        }
        self sethintstringforplayer(player, self.hint_string[n_player_index]);
    }
    return b_result;
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 1, eflags: 0x0
// Checksum 0x43cdda3a, Offset: 0xbd0
// Size: 0xae
function function_3153b08d(e_unitrigger) {
    var_796a4e2a = e_unitrigger.stub.var_796a4e2a;
    var_2f6fac84 = function_151e6f35(e_unitrigger);
    if (level flag::get(var_2f6fac84)) {
        n_cost = 0;
    } else if (isdefined(e_unitrigger.stub)) {
        n_cost = e_unitrigger.stub.zombie_cost;
    } else {
        n_cost = e_unitrigger.zombie_cost;
    }
    return n_cost;
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 1, eflags: 0x0
// Checksum 0x2890ddb9, Offset: 0xc88
// Size: 0x33c
function function_60ba6607(e_unitrigger) {
    var_796a4e2a = e_unitrigger.stub.var_796a4e2a;
    var_2f6fac84 = function_151e6f35(e_unitrigger);
    n_player_index = self getentitynumber();
    if (!level flag::get(var_2f6fac84)) {
        level thread function_8b90006d(var_2f6fac84, var_796a4e2a, e_unitrigger.stub.var_9613e391, e_unitrigger.stub.var_a6c13c21, self);
    }
    switch (e_unitrigger.hint_string[n_player_index]) {
    case #"hash_9fdf28b2277fe11":
    case #"hash_3600e293ddc9f9b6":
        if (!zm_zonemgr::zone_is_enabled("zone_cafeteria")) {
            zm_zonemgr::enable_zone("zone_cafeteria");
            zm_zonemgr::enable_zone("zone_cafeteria_end");
            level flag::set(#"hash_6059fbd4a3d1823e");
        }
        break;
    case #"hash_af863c29e30651d":
    case #"hash_751feed02ba9abc4":
        if (!zm_zonemgr::zone_is_enabled("zone_warden_house")) {
            zm_zonemgr::enable_zone("zone_warden_house");
            zm_zonemgr::enable_zone("zone_warden_house_exterior");
            level flag::set(#"hash_6804675ac314efd1");
        }
        break;
    case #"hash_2110980a2c8a4dd3":
    case #"hash_3c4e15b133cbbbfa":
        if (!zm_zonemgr::zone_is_enabled("cellblock_shower")) {
            zm_zonemgr::enable_zone("cellblock_shower");
        }
        break;
    case #"hash_1db3b05a63943f7d":
    case #"hash_5bd2ed18b058d064":
        if (!zm_zonemgr::zone_is_enabled("zone_new_industries") || !zm_zonemgr::zone_is_enabled("zone_new_industries_transverse_tunnel")) {
            zm_zonemgr::enable_zone("zone_new_industries");
            zm_zonemgr::enable_zone("zone_new_industries_transverse_tunnel");
            level flag::set(#"hash_2873d6b98dfeaf6d");
        }
        break;
    }
    self thread zm_escape_vo_hooks::function_e6273db3();
    self thread function_9055d838();
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 0, eflags: 0x4
// Checksum 0x13442a0e, Offset: 0xfd0
// Size: 0xbc
function private function_9055d838() {
    self endon(#"disconnect");
    w_current = self getcurrentweapon();
    if (!zm_weap_spectral_shield::function_fa783e7(w_current)) {
        return;
    }
    var_d2f4cbdf = self getweaponslistprimaries();
    self switchtoweaponimmediate(var_d2f4cbdf[0], 1);
    self waittill(#"fasttravel_finished");
    self switchtoweaponimmediate(w_current, 1);
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 1, eflags: 0x0
// Checksum 0x5894dc5b, Offset: 0x1098
// Size: 0x96
function function_151e6f35(e_unitrigger) {
    var_796a4e2a = e_unitrigger.stub.var_796a4e2a;
    switch (var_796a4e2a) {
    case #"warden_house_shower":
        var_2f6fac84 = #"hash_76a9f44aee68fe8e";
        break;
    case #"cafeteria_west_side":
        var_2f6fac84 = #"hash_6a5df83b0716ed39";
        break;
    }
    return var_2f6fac84;
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 5, eflags: 0x0
// Checksum 0x162deeab, Offset: 0x1138
// Size: 0x1ba
function function_8b90006d(var_d31bfb95, var_796a4e2a, var_9613e391, var_a6c13c21, var_264acf26) {
    var_9613e391 thread scene::play("open");
    var_a6c13c21 thread scene::play("open");
    level flag::set(#"hash_5466d69fa17fc721");
    level flag::set(var_d31bfb95);
    level waittilltimeout(13, #"hash_3c3c6b906f6bbd6");
    level flag::clear(var_d31bfb95);
    level flag::clear(#"hash_5466d69fa17fc721");
    var_9613e391 thread scene::play("close");
    var_a6c13c21 thread scene::play("close");
    if (level.var_25484282) {
        if (isdefined(level.var_91b12f5b) && level.var_91b12f5b) {
            var_264acf26.var_b7bc1a68 = 0.5;
        } else {
            var_264acf26.var_b7bc1a68 = 30;
        }
        level thread function_fdabf51c(var_796a4e2a, var_264acf26);
        return;
    }
    var_264acf26.var_b7bc1a68 = undefined;
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 2, eflags: 0x0
// Checksum 0xa6bbb469, Offset: 0x1300
// Size: 0x106
function function_fdabf51c(var_796a4e2a, var_264acf26) {
    str_notify_endon = "global_cooldown_watcher_" + var_796a4e2a;
    level notify(str_notify_endon);
    level endon(str_notify_endon);
    if (level.var_25484282) {
        level.var_a8ae6233[var_796a4e2a] = 1;
        if (isdefined(level.var_91b12f5b) && level.var_91b12f5b) {
            n_cooldown = 0.5;
        } else {
            n_cooldown = 30;
            if (var_264acf26 hasperk(#"specialty_cooldown")) {
                n_cooldown *= 0.5;
            }
        }
        level waittilltimeout(n_cooldown, #"hash_3c3c6b906f6bbd6");
        level.var_a8ae6233[var_796a4e2a] = 0;
    }
}

// Namespace namespace_bd4d66e5/namespace_96a2ec8f
// Params 0, eflags: 0x0
// Checksum 0x73934d15, Offset: 0x1410
// Size: 0x2c
function function_1108a598() {
    self zm_audio::create_and_play_dialog("hellhole", "exit", undefined, 1);
}

