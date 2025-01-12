#using script_48f7c4ab73137f8;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_game_module;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_weapons;

#namespace zm_trial;

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x2
// Checksum 0x67bafbb5, Offset: 0x290
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial", &__init__, undefined, undefined);
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0x8fbcbd01, Offset: 0x2d8
// Size: 0x96
function private __init__() {
    if (!is_trial_mode()) {
        return;
    }
    if (!isdefined(level.var_e096cfb3)) {
        level.var_e096cfb3 = [];
    }
    if (!isdefined(level.var_e63b8d85)) {
        level.var_e63b8d85 = [];
    }
    level.var_b21e401b = undefined;
    level.var_dfd44a87 = undefined;
    function_333f194f();
    level.var_8f0efe80 = &reset_round;
}

// Namespace zm_trial/zm_trial
// Params 3, eflags: 0x0
// Checksum 0xedb8c411, Offset: 0x378
// Size: 0xbe
function register_challenge(name, var_fa157b4e, var_4cef4a96) {
    if (!isdefined(level.var_e63b8d85)) {
        level.var_e63b8d85 = [];
    }
    assert(!isdefined(level.var_e63b8d85[name]));
    info = {#name:name, #var_fa157b4e:var_fa157b4e, #var_4cef4a96:var_4cef4a96};
    level.var_e63b8d85[name] = info;
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x6ee077c, Offset: 0x440
// Size: 0xac
function function_871c1f7f(name) {
    if (is_trial_mode() && isdefined(level.var_dfd44a87)) {
        foreach (active_challenge in level.var_dfd44a87) {
            if (active_challenge.name == name) {
                return active_challenge;
            }
        }
    }
    return undefined;
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x5470572b, Offset: 0x4f8
// Size: 0x3a
function function_bdd52e23(name) {
    if (!is_trial_mode()) {
        return 0;
    }
    return level flag::get(name);
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x0
// Checksum 0xda0aee69, Offset: 0x540
// Size: 0x22
function is_trial_mode() {
    return level flag::exists(#"ztrial");
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0xb65b6bb6, Offset: 0x570
// Size: 0x24
function function_577f4821(var_6bb5e176) {
    clientfield::set_world_uimodel("ZMHudGlobal.trials.disableGun", var_6bb5e176);
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x959d8cec, Offset: 0x5a0
// Size: 0x24
function function_8452d327(var_6bb5e176) {
    clientfield::set_world_uimodel("ZMHudGlobal.trials.disableEquip", var_6bb5e176);
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x8b2a9a2f, Offset: 0x5d0
// Size: 0x24
function function_987ca9a2(var_6bb5e176) {
    clientfield::set_world_uimodel("ZMHudGlobal.trials.disableSpecial", var_6bb5e176);
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x20b6eb1d, Offset: 0x600
// Size: 0x54
function function_373bbacc(var_6bb5e176) {
    clientfield::set_world_uimodel("ZMHudGlobal.trials.disableGun", var_6bb5e176);
    clientfield::set_world_uimodel("ZMHudGlobal.trials.disableEquip", var_6bb5e176);
    clientfield::set_world_uimodel("ZMHudGlobal.trials.disableSpecial", var_6bb5e176);
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0xdccca697, Offset: 0x660
// Size: 0x24
function function_e6903c38(var_6bb5e176) {
    clientfield::set_world_uimodel("ZMHudGlobal.trials.disablePerks", var_6bb5e176);
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x9c42a88e, Offset: 0x690
// Size: 0x24
function function_a30785f9(var_6bb5e176) {
    clientfield::set_world_uimodel("ZMHudGlobal.trials.disableAbilities", var_6bb5e176);
}

// Namespace zm_trial/zm_trial
// Params 2, eflags: 0x0
// Checksum 0xccabe1af, Offset: 0x6c0
// Size: 0x264
function fail(reason = undefined, var_6fbb8a00 = undefined) {
    if (level flag::get("round_reset") || level flag::get(#"trial_failed")) {
        return;
    }
    foreach (aplayer in getplayers()) {
        aplayer val::set("round_reset", "takedamage", 0);
        aplayer val::set("round_reset", "freezecontrols", 1);
        aplayer function_319b02e(0);
        if (level.var_70cb425c zm_laststand_client::is_open(aplayer)) {
            level.var_70cb425c zm_laststand_client::close(aplayer);
        }
    }
    if (!isdefined(reason)) {
        reason = #"hash_3d9d6e119fdd76ae";
    }
    zm_trial_util::set_game_state(1);
    zm_trial_util::function_94941940(reason, var_6fbb8a00);
    function_c5280bd8(function_2a447e6c() + 1);
    if (function_2a447e6c() < 3) {
        level flag::set("round_reset");
        playsoundatposition(#"hash_13781c956ed2b1ca", (0, 0, 0));
        return;
    }
    level thread function_26a4f207();
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x0
// Checksum 0xcfc46dca, Offset: 0x930
// Size: 0x198
function function_2abe2c44() {
    level notify(#"end_round_think");
    setmatchflag("disableIngameMenu", 1);
    foreach (player in getplayers()) {
        player val::set("end_game", "takedamage", 0);
        player val::set("end_game", "freezecontrols", 1);
        player closeingamemenu();
        player closemenu("StartMenu_Main");
    }
    music::setmusicstate("trials_end_success");
    zm_trial_util::set_game_state(2);
    level.var_fa7b2e86 = 1;
    wait 3;
    level notify(#"hash_4c09c9d01060d7ad");
    level notify(#"end_game");
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x0
// Checksum 0x1a086fbf, Offset: 0xad0
// Size: 0x1a8
function function_26a4f207() {
    level flag::set(#"trial_failed");
    level notify(#"end_round_think");
    music::setmusicstate("trials_end_fail");
    setmatchflag("disableIngameMenu", 1);
    foreach (player in getplayers()) {
        player val::set("end_game", "takedamage", 0);
        player val::set("end_game", "freezecontrols", 1);
        player closeingamemenu();
        player closemenu("StartMenu_Main");
    }
    zm_trial_util::set_game_state(3);
    wait 3;
    level notify(#"hash_4c09c9d01060d7ad");
    level notify(#"end_game");
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x0
// Checksum 0xbffc5994, Offset: 0xc80
// Size: 0xe
function function_2a447e6c() {
    return level.trial_strikes;
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x5816e873, Offset: 0xc98
// Size: 0x6c
function function_c5280bd8(count) {
    assert(count >= 0 && count <= 3);
    level.trial_strikes = count;
    clientfield::set_world_uimodel("ZMHudGlobal.trials.strikes", level.trial_strikes);
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x2eca745e, Offset: 0xd10
// Size: 0x8c
function function_29ac39b6(name) {
    foreach (var_f0a67892 in level.var_e096cfb3) {
        if (var_f0a67892.name == name) {
            return var_f0a67892;
        }
    }
    return undefined;
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x0
// Checksum 0x2cd61344, Offset: 0xda8
// Size: 0x8e
function function_9b72fb1a(var_46a78b90) {
    for (i = 0; i <= 1000; i++) {
        if (hash("" + i) == var_46a78b90) {
            return i;
        }
    }
    assert(0, "<dev string:x30>" + var_46a78b90);
    return 0;
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0x22c44e31, Offset: 0xe40
// Size: 0x1b4
function private reset_round() {
    level.custom_spawnplayer = undefined;
    wait 3;
    function_643d7f00();
    level lui::screen_fade_out(0.5);
    function_a05fe2a9();
    function_4af86aac();
    level zm_game_module::zombie_goto_round(level.round_number);
    zm_trial_util::set_game_state(0);
    level zm_game_module::respawn_players();
    waitframe(1);
    function_6edc1d71();
    waitframe(1);
    foreach (player in getplayers()) {
        player val::reset("round_reset", "takedamage");
        player val::reset("round_reset", "freezecontrols");
        player function_319b02e(1);
    }
    level lui::screen_close_menu();
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0x4ddcc436, Offset: 0x1000
// Size: 0xe6
function private function_a05fe2a9() {
    foreach (player in getplayers()) {
        if (player laststand::player_is_in_laststand()) {
            player zm_laststand::auto_revive(player);
        }
        player val::reset(#"laststand", "ignoreme");
        player clientfield::set("zmbLastStand", 0);
    }
    waitframe(1);
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0x4db66ceb, Offset: 0x10f0
// Size: 0xfc
function private function_717fbc01() {
    foreach (player in getplayers()) {
        foreach (weapon in player getweaponslist(1)) {
            player unlockweapon(weapon);
        }
    }
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0x60a650ae, Offset: 0x11f8
// Size: 0x118
function private function_643d7f00() {
    foreach (player in getplayers()) {
        if (!(isdefined(player.var_56c7266a) && player.var_56c7266a)) {
            player notify(#"fasttravel_over");
        }
    }
    foreach (player in getplayers()) {
        player bgb::take();
    }
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0x4431345e, Offset: 0x1318
// Size: 0x18a
function private function_4af86aac() {
    foreach (player in getplayers()) {
        player.var_4ae991b4 = {};
        player.var_4ae991b4.score = player zm_score::function_a8fa79c2();
        player.var_4ae991b4.score_total = player.score_total;
        if (player.sessionstate == "spectator") {
            if (isdefined(player.s_loadout)) {
                player.var_4ae991b4.loadout = player.s_loadout;
            } else {
                player.var_4ae991b4.loadout = undefined;
            }
        } else {
            player.var_4ae991b4.loadout = player zm_weapons::player_get_loadout();
            player takeallweapons();
        }
        player.var_4ae991b4.var_bdbde150 = player zm_trial_util::function_afc1efee(0);
    }
}

// Namespace zm_trial/zm_trial
// Params 1, eflags: 0x4
// Checksum 0x7cd63431, Offset: 0x14b0
// Size: 0x10c
function private function_47556509(loadout) {
    primary_weapons = self getweaponslistprimaries();
    foreach (primary_weapon in primary_weapons) {
        if (isdefined(loadout) && primary_weapon === loadout.current) {
            self switchtoweaponimmediate(primary_weapon, 1);
            return;
        }
    }
    if (primary_weapons.size > 0) {
        self switchtoweaponimmediate(primary_weapons[0], 1);
        return;
    }
    self switchtoweaponimmediate();
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0xcc041e98, Offset: 0x15c8
// Size: 0x232
function private function_6edc1d71() {
    foreach (player in getplayers()) {
        player zm_trial_util::function_e023e6a5(player.var_4ae991b4.var_bdbde150);
        assert(isdefined(player.var_4ae991b4));
        player zm_score::function_fb877e6e(player.var_4ae991b4.score);
        player.score_total = player.var_4ae991b4.score_total;
        if (isdefined(player.var_4ae991b4.loadout)) {
            player zm_weapons::player_give_loadout(player.var_4ae991b4.loadout, 1, 0);
        } else {
            player takeallweapons();
            player zm_loadout::give_start_weapon(1);
            player zm_loadout::init_player_offhand_weapons();
        }
        player zm_trial_util::function_93ced8f4(player.var_4ae991b4.var_bdbde150);
        player function_47556509(player.var_4ae991b4.loadout);
        for (slot = 0; slot < 3; slot++) {
            if (isdefined(player._gadgets_player[slot])) {
                player gadgetcharging(slot, 1);
            }
        }
    }
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0x48d6a143, Offset: 0x1808
// Size: 0x416
function private function_333f194f() {
    table = #"hash_25cc5a6f4fbdfbd9";
    column_count = tablelookupcolumncount(table);
    var_2b0fb6af = tablelookuprowcount(table);
    row = 0;
    while (row < var_2b0fb6af) {
        var_9f99900f = tablelookupcolumnforrow(table, row, 1);
        assert(!isdefined(function_29ac39b6(var_9f99900f)));
        var_f0a67892 = {#name:var_9f99900f, #rounds:[], #index:level.var_e096cfb3.size};
        level.var_e096cfb3[level.var_e096cfb3.size] = var_f0a67892;
        do {
            row++;
            round = tablelookupcolumnforrow(table, row, 0);
            if (row < var_2b0fb6af && round != 0) {
                round_index = round - 1;
                if (!isdefined(var_f0a67892.rounds[round_index])) {
                    var_f0a67892.rounds[round_index] = {};
                    round_info = var_f0a67892.rounds[round_index];
                    round_info.name = tablelookupcolumnforrow(table, row, 1);
                    round_info.round = round;
                    round_info.name_str = tablelookupcolumnforrow(table, row, 2);
                    round_info.desc_str = tablelookupcolumnforrow(table, row, 3);
                    round_info.var_f45cb194 = tablelookupcolumnforrow(table, row, 4);
                    round_info.challenges = [];
                }
                assert(isdefined(var_f0a67892.rounds[round_index]));
                round_info = var_f0a67892.rounds[round_index];
                challenge_name = tablelookupcolumnforrow(table, row, 5);
                var_61365c91 = [];
                array::add(round_info.challenges, {#name:challenge_name, #row:row, #params:var_61365c91});
                for (i = 0; i < 8; i++) {
                    param = tablelookupcolumnforrow(table, row, 6 + i);
                    if (isdefined(param) && param != #"") {
                        var_61365c91[var_61365c91.size] = param;
                    }
                }
            }
        } while (row < var_2b0fb6af && round != 0);
    }
    level.var_f0a67892 = level.var_e096cfb3[0];
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x4
// Checksum 0x7e05842f, Offset: 0x1c28
// Size: 0xd6
function private function_f12cde30() {
    end_time = gettime() + 10000;
    while (gettime() < end_time) {
        all_players_spawned = 1;
        foreach (player in getplayers()) {
            if (player.sessionstate == "spectator") {
                all_players_spawned = 0;
            }
        }
        if (all_players_spawned) {
            waitframe(1);
            break;
        }
        waitframe(1);
    }
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x0
// Checksum 0x70fcdcfc, Offset: 0x1d08
// Size: 0x31e
function function_8def5e51() {
    if (!is_trial_mode()) {
        return;
    }
    assert(isdefined(level.var_f0a67892));
    assert(!isdefined(level.var_b21e401b));
    assert(!isdefined(level.var_dfd44a87));
    round_index = level.round_number - 1;
    assert(round_index >= 0);
    if (round_index >= level.var_f0a67892.rounds.size) {
        return;
    }
    music::setmusicstate("trials_round_start");
    zm_trial_util::set_game_state(0);
    zm_trial_util::function_53e0b982();
    zm_trial_util::function_5b5c3c53(0);
    clientfield::set_world_uimodel("ZMHudGlobal.trials.roundNumber", level.round_number);
    zm_trial_util::function_37d417cf();
    function_f12cde30();
    level.var_dfd44a87 = [];
    level.var_b21e401b = level.var_f0a67892.rounds[round_index];
    for (i = 0; i < level.var_b21e401b.challenges.size; i++) {
        challenge = level.var_b21e401b.challenges[i];
        assert(isdefined(level.var_e63b8d85));
        assert(isdefined(level.var_e63b8d85[challenge.name]));
        var_72085a07 = level.var_e63b8d85[challenge.name];
        var_28ed9ff3 = {#name:challenge.name, #row:challenge.row, #info:var_72085a07, #params:challenge.params};
        array::add(level.var_dfd44a87, var_28ed9ff3);
        if (isdefined(var_72085a07.var_fa157b4e)) {
            util::single_func_argarray(var_28ed9ff3, var_72085a07.var_fa157b4e, challenge.params);
        }
    }
}

// Namespace zm_trial/zm_trial
// Params 0, eflags: 0x0
// Checksum 0xc31a9f85, Offset: 0x2030
// Size: 0x174
function on_round_end() {
    if (!is_trial_mode()) {
        return;
    }
    level notify(#"hash_7646638df88a3656");
    assert(isdefined(level.var_b21e401b));
    assert(isdefined(level.var_dfd44a87));
    var_4358ae0d = level flag::get("round_reset");
    if (!(isdefined(var_4358ae0d) && var_4358ae0d)) {
        music::setmusicstate("trials_round_end");
    }
    for (i = 0; i < level.var_dfd44a87.size; i++) {
        var_28ed9ff3 = level.var_dfd44a87[i];
        if (isdefined(var_28ed9ff3.info.var_4cef4a96)) {
            var_28ed9ff3 [[ var_28ed9ff3.info.var_4cef4a96 ]](var_4358ae0d);
        }
    }
    level.var_b21e401b = undefined;
    level.var_dfd44a87 = undefined;
    function_717fbc01();
}

