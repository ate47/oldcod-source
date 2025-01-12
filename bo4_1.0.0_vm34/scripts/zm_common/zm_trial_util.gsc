#using script_2595527427ea71eb;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_util;

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x2
// Checksum 0x33cb4ba3, Offset: 0x438
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_util", &__init__, undefined, undefined);
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x4
// Checksum 0xd644a9d8, Offset: 0x480
// Size: 0x5e
function private __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    callback::on_finalize_initialization(&finalize_clientfields);
    level.var_bb57ff69 = zm_trial_timer::register("zm_trial_timer");
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0x5d8ce17a, Offset: 0x4e8
// Size: 0x24
function function_49b6503a() {
    self clientfield::increment_to_player("zm_trials_weapon_locked");
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0x1e05b4c, Offset: 0x518
// Size: 0xac
function function_cf9e59f8() {
    if (!level flag::get(#"trial_failed") && clientfield::get_world_uimodel("ZMHudGlobal.trials.gameState") != 2) {
        clientfield::set_world_uimodel("ZMHudGlobal.trials.failurePlayer", 0);
        clientfield::set_world_uimodel("ZMHudGlobal.trials.failureReason", #"hash_cd63faed592da03");
        set_game_state(3);
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0xe48590a4, Offset: 0x5d0
// Size: 0x2c
function function_83dcb6c4() {
    wait 1;
    clientfield::set_world_uimodel("ZMHudGlobal.trials.showScoreboard", 1);
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x4
// Checksum 0x97e0f76d, Offset: 0x608
// Size: 0x5ec
function private finalize_clientfields() {
    clientfield::register("world", "ZMHudGlobal.trials.trialIndex", 1, getminbitcountfornum(15), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.roundNumber", 1, getminbitcountfornum(30), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.roundSuccess", 1, getminbitcountfornum(1), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.strikes", 1, getminbitcountfornum(3), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disablePerks", 1, getminbitcountfornum(1), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableGun", 1, getminbitcountfornum(1), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableEquip", 1, getminbitcountfornum(1), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableSpecial", 1, getminbitcountfornum(1), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableAbilities", 1, getminbitcountfornum(1), "int");
    clientfield::register("toplayer", "zm_trials_timer", 1, getminbitcountfornum(300), "int");
    clientfield::register("toplayer", "zm_trials_weapon_locked", 1, 1, "counter");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.playerCounterMax", 1, getminbitcountfornum(200), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameState", 1, 2, "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.failurePlayer", 1, 4, "int");
    clientfield::register_bgcache("worlduimodel", "string", "ZMHudGlobal.trials.failureReason", 1);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameStartTime", 1, 31, "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.showScoreboard", 1, getminbitcountfornum(1), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.globalCheckState", 1, getminbitcountfornum(2), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.globalCounterValue", 1, getminbitcountfornum(200), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.globalCounterMax", 1, getminbitcountfornum(200), "int");
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.hudDeactivated", 1, 1, "int");
    clientfield::register("clientuimodel", "zmhud.currentWeaponLocked", 1, 1, "int");
    for (i = 0; i < 4; i++) {
        clientfield::register("worlduimodel", "PlayerList.client" + i + "." + "trialsCheckState", 1, 2, "int");
        clientfield::register("worlduimodel", "PlayerList.client" + i + "." + "trialsCounterValue", 1, getminbitcountfornum(200), "int");
    }
    level thread function_40775c86();
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x4
// Checksum 0xaf582adb, Offset: 0xc00
// Size: 0xa4
function private function_40775c86() {
    level flag::wait_till("start_zombie_round_logic");
    assert(isdefined(level.var_f0a67892) && isdefined(level.var_f0a67892.index));
    level clientfield::set("ZMHudGlobal.trials.trialIndex", level.var_f0a67892.index);
    clientfield::set_world_uimodel("ZMHudGlobal.trials.failurePlayer", 0);
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0x9f4576a7, Offset: 0xcb0
// Size: 0x44
function function_37d417cf() {
    assert(isdefined(level.var_f6545288));
    clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", level.var_f6545288);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x8a47c5c3, Offset: 0xd00
// Size: 0x2c
function function_3e6b8345(islocked) {
    self clientfield::set_player_uimodel("zmhud.currentWeaponLocked", islocked);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x75ec948c, Offset: 0xd38
// Size: 0x4c
function start_timer(seconds) {
    assert(seconds <= 300);
    self clientfield::set_to_player("zm_trials_timer", seconds);
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0xf940daf, Offset: 0xd90
// Size: 0x24
function stop_timer() {
    self clientfield::set_to_player("zm_trials_timer", 0);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x9228a8e0, Offset: 0xdc0
// Size: 0x5c
function function_368f31a9(var_5b9a7ac2) {
    assert(var_5b9a7ac2 >= 0 && var_5b9a7ac2 <= 200);
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCounterMax", var_5b9a7ac2);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0xe9805cb5, Offset: 0xe28
// Size: 0x7c
function function_ef967e48(var_15ebf219) {
    assert(var_15ebf219 >= 0 && var_15ebf219 <= 200);
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCheckState", 1);
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCounterValue", var_15ebf219);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x86ed7e7b, Offset: 0xeb0
// Size: 0xb4
function function_722a8267(var_382c2020) {
    assert(var_382c2020 == 0 || var_382c2020 == 1);
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCounterValue", 0);
    if (var_382c2020 == 0) {
        level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCheckState", 2);
        return;
    }
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCheckState", 3);
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0xfec58586, Offset: 0xf70
// Size: 0x1c
function function_59861180() {
    clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCheckState", 0);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0xd31599df, Offset: 0xf98
// Size: 0x5c
function function_530f0033(var_5b9a7ac2) {
    assert(var_5b9a7ac2 >= 0 && var_5b9a7ac2 <= 200);
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.playerCounterMax", var_5b9a7ac2);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x865bbe92, Offset: 0x1000
// Size: 0xd4
function function_fb5ea4e6(var_15ebf219) {
    assert(isplayer(self));
    assert(var_15ebf219 >= 0 && var_15ebf219 <= 200);
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + "." + "trialsCheckState", 1);
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + "." + "trialsCounterValue", var_15ebf219);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x67627df9, Offset: 0x10e0
// Size: 0x124
function function_9eca2595(var_382c2020) {
    assert(isplayer(self));
    assert(var_382c2020 == 0 || var_382c2020 == 1);
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + "." + "trialsCounterValue", 0);
    if (var_382c2020 == 0) {
        clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + "." + "trialsCheckState", 2);
        return;
    }
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + "." + "trialsCheckState", 3);
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0xa972c9bc, Offset: 0x1210
// Size: 0x64
function function_fccd8386() {
    assert(isplayer(self));
    clientfield::set_world_uimodel("PlayerList.client" + self.entity_num + "." + "trialsCheckState", 0);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x75fe8847, Offset: 0x1280
// Size: 0x24
function set_game_state(game_state) {
    clientfield::set_world_uimodel("ZMHudGlobal.trials.gameState", game_state);
}

// Namespace zm_trial_util/zm_trial_util
// Params 2, eflags: 0x0
// Checksum 0x346f27f7, Offset: 0x12b0
// Size: 0xbc
function function_94941940(reason, var_6fbb8a00 = undefined) {
    assert(clientfield::get_world_uimodel("<dev string:x30>") == 1);
    var_bbd01580 = 0;
    if (isdefined(var_6fbb8a00)) {
        var_bbd01580 = function_f81b37c2(var_6fbb8a00);
    }
    clientfield::set_world_uimodel("ZMHudGlobal.trials.failurePlayer", var_bbd01580);
    clientfield::set_world_uimodel("ZMHudGlobal.trials.failureReason", reason);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x6b2ae3, Offset: 0x1378
// Size: 0x220
function function_afc1efee(var_14129ca9) {
    assert(isdefined(self.var_871d24d3));
    assert(self.var_871d24d3.size >= 4);
    var_1cd25b20 = {};
    var_1cd25b20.var_d9b8b0f4 = [];
    for (slot = 0; slot < 4; slot++) {
        vapor = self.var_871d24d3[slot];
        var_2729dbb0 = isinarray(self.var_ee217989, vapor);
        var_72f6f84e = var_14129ca9 && zm_perks::function_8521d0ed(vapor);
        if (var_2729dbb0 && !var_72f6f84e) {
            self notify(vapor + "_stop", {#var_39af19e:!var_72f6f84e, #var_d136d40a:1});
            assert(isdefined(level.var_fb762d80));
            if (isdefined(level.var_fb762d80[vapor])) {
                var_3b150d94 = level.var_fb762d80[vapor];
                self notify(var_3b150d94 + "_stop", {#var_39af19e:!var_72f6f84e});
            }
            if (vapor == #"specialty_additionalprimaryweapon") {
                var_1cd25b20.additional_primary_weapon = self.var_7d93cc5e;
            }
            var_1cd25b20.var_d9b8b0f4[slot] = 1;
            continue;
        }
        var_1cd25b20.var_d9b8b0f4[slot] = 0;
    }
    return var_1cd25b20;
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0xf6dc59d2, Offset: 0x15a0
// Size: 0x102
function function_e023e6a5(var_1cd25b20) {
    assert(isdefined(self.var_871d24d3));
    assert(self.var_871d24d3.size >= 4);
    assert(var_1cd25b20.var_d9b8b0f4.size == 4);
    level.var_6e6ed8ab = 1;
    for (slot = 0; slot < 4; slot++) {
        vapor = self.var_871d24d3[slot];
        if (var_1cd25b20.var_d9b8b0f4[slot]) {
            self zm_perks::function_79567d8a(vapor, slot);
        }
    }
    level.var_6e6ed8ab = undefined;
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x5201a87c, Offset: 0x16b0
// Size: 0xe6
function function_93ced8f4(var_1cd25b20) {
    slot = self zm_perks::function_ec1dff78(#"specialty_additionalprimaryweapon");
    if (slot != -1 && var_1cd25b20.var_d9b8b0f4[slot] && isdefined(var_1cd25b20.additional_primary_weapon)) {
        if (isinarray(self.var_ee217989, #"specialty_additionalprimaryweapon")) {
            if (self hasweapon(var_1cd25b20.additional_primary_weapon)) {
                self notify(#"hash_29c66728ccd27f03", {#weapon:var_1cd25b20.additional_primary_weapon});
            }
        }
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0xfa3f364b, Offset: 0x17a0
// Size: 0x98
function function_8d6f6c09() {
    a_structs = struct::get_array("perk_vapor_altar");
    foreach (s_struct in a_structs) {
        s_struct zm_perks::function_29a9ca48();
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0xb8108f91, Offset: 0x1840
// Size: 0x98
function function_46e52c6b() {
    a_structs = struct::get_array("perk_vapor_altar");
    foreach (s_struct in a_structs) {
        s_struct zm_perks::function_dbc1588c();
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0x1dd79877, Offset: 0x18e0
// Size: 0x9a
function function_5af41a8() {
    assert(!isdefined(level.var_109dc970));
    if (isdefined(level.pap_machine) && level flag::get("pap_machine_active")) {
        level.var_109dc970 = 1;
        if (isdefined(level.var_78722f01)) {
            self [[ level.var_78722f01 ]](0);
        }
        return;
    }
    level.var_109dc970 = 0;
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0x4727e537, Offset: 0x1988
// Size: 0x82
function function_4662a26f() {
    assert(isdefined(level.var_109dc970));
    if (isdefined(level.pap_machine) && isdefined(level.var_109dc970) && level.var_109dc970) {
        if (isdefined(level.var_78722f01)) {
            [[ level.var_78722f01 ]](1);
        }
    }
    level.var_109dc970 = undefined;
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x0
// Checksum 0x1751faca, Offset: 0x1a18
// Size: 0x24
function function_53e0b982() {
    luinotifyevent(#"hash_6b83e3eca730e165", 0);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x4978da73, Offset: 0x1a48
// Size: 0x24
function function_5b5c3c53(successful) {
    clientfield::set_world_uimodel("ZMHudGlobal.trials.roundSuccess", successful);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x20bf71f3, Offset: 0x1a78
// Size: 0xa2
function function_f81b37c2(players) {
    bitarray = 0;
    foreach (player in players) {
        bitarray |= 1 << player getentitynumber();
    }
    return bitarray;
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x7c2e8a6e, Offset: 0x1b28
// Size: 0x3e
function function_3d0f0a4d(player) {
    bitarray = 0;
    bitarray |= 1 << player getentitynumber();
    return bitarray;
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x35a80a58, Offset: 0x1b70
// Size: 0xa4
function function_f9e294e9(forceupdate) {
    weapon = self getcurrentweapon();
    if (self function_8782fa47(weapon)) {
        self function_3e6b8345(1);
        return;
    }
    if (isdefined(forceupdate) && forceupdate || !(isdefined(self.var_56c7266a) && self.var_56c7266a)) {
        self function_3e6b8345(0);
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0x49db71c, Offset: 0x1c20
// Size: 0x24
function function_2033328b(eventstruct) {
    function_f9e294e9(0);
}

/#

    // Namespace zm_trial_util/zm_trial_util
    // Params 0, eflags: 0x0
    // Checksum 0x83ebe8a3, Offset: 0x1c50
    // Size: 0x1ce
    function open_all_doors() {
        a_zombie_doors = getentarray("<dev string:x4d>", "<dev string:x59>");
        for (i = 0; i < a_zombie_doors.size; i++) {
            if (!(isdefined(a_zombie_doors[i].has_been_opened) && a_zombie_doors[i].has_been_opened)) {
                a_zombie_doors[i] notify(#"trigger", {#is_forced:1});
            }
            waitframe(1);
        }
        var_a44c3c69 = getentarray("<dev string:x64>", "<dev string:x59>");
        for (i = 0; i < var_a44c3c69.size; i++) {
            var_a44c3c69[i] notify(#"trigger", {#is_forced:1});
            waitframe(1);
        }
        a_zombie_debris = getentarray("<dev string:x77>", "<dev string:x59>");
        for (i = 0; i < a_zombie_debris.size; i++) {
            if (isdefined(a_zombie_debris[i])) {
                a_zombie_debris[i] notify(#"trigger", {#is_forced:1});
            }
            waitframe(1);
        }
    }

    // Namespace zm_trial_util/zm_trial_util
    // Params 0, eflags: 0x0
    // Checksum 0x21d4a53a, Offset: 0x1e28
    // Size: 0x16a
    function function_6440f858() {
        foreach (player in getplayers()) {
            for (i = 0; i < player.var_871d24d3.size; i++) {
                perk = player.var_871d24d3[i];
                if (isdefined(player.perk_purchased) && player.perk_purchased == perk) {
                    continue;
                }
                if (!player hasperk(perk) && !player zm_perks::has_perk_paused(perk)) {
                    n_index = player zm_perks::function_ec1dff78(perk);
                    player zm_perks::function_79567d8a(perk, n_index);
                }
            }
        }
    }

#/
