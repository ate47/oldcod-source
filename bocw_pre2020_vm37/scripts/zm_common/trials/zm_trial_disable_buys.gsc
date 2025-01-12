#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_traps;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_disable_buys;

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x6
// Checksum 0x920e82cf, Offset: 0x3c8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_disable_buys", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0x6699d330, Offset: 0x410
// Size: 0x1f4
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    if (util::get_map_name() === "zm_red") {
        level.var_b5079c7c = array("exp_lgt_ar_accurate_t8", "exp_lgt_ar_fastfire_t8", "exp_lgt_ar_modular_t8", "exp_lgt_ar_stealth_t8", "exp_lgt_bowie", "exp_lgt_lmg_standard_t8", "exp_lgt_pistol_revolver_t8", "exp_lgt_pistol_standard_t8", "exp_lgt_shotgun_pump_t8", "exp_lgt_shotgun_trenchgun_t8", "exp_lgt_smg_accurate_t8", "exp_lgt_smg_fastfire_t8", "exp_lgt_smg_handling_t8", "exp_lgt_smg_standard_t8", "exp_lgt_sniper_quickscope_t8", "exp_lgt_tr_leveraction_t8", "exp_lgt_tr_longburst_t8", "exp_lgt_tr_powersemi_t8");
    } else {
        level.var_b5079c7c = array("exp_lgt_ar_accurate_t8", "exp_lgt_ar_fastfire_t8", "exp_lgt_ar_modular_t8", "exp_lgt_ar_stealth_t8", "exp_lgt_ar_stealth_t8_2", "exp_lgt_bowie", "exp_lgt_bowie_2", "exp_lgt_lmg_standard_t8", "exp_lgt_pistol_burst_t8", "exp_lgt_pistol_standard_t8", "exp_lgt_shotgun_pump_t8", "exp_lgt_shotgun_trenchgun_t8", "exp_lgt_smg_accurate_t8", "exp_lgt_smg_accurate_t8_2", "exp_lgt_smg_drum_pistol_t8", "exp_lgt_smg_fastfire_t8", "exp_lgt_smg_handling_t8", "exp_lgt_smg_standard_t8", "exp_lgt_sniper_quickscope_t8", "exp_lgt_tr_leveraction_t8", "exp_lgt_tr_longburst_t8", "exp_lgt_tr_powersemi_t8");
    }
    zm_trial::register_challenge(#"disable_buys", &on_begin, &on_end);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 1, eflags: 0x5 linked
// Checksum 0x63511dea, Offset: 0x610
// Size: 0xdc
function private on_begin(var_a29299fb) {
    if (!is_true(level.buys_disabled)) {
        level.buys_disabled = 1;
        level notify(#"disable_buys");
        function_6fd56055();
        function_a4284cb4();
        function_47c81160();
        zm_trial_util::function_eea26e56();
        level.var_a29299fb = var_a29299fb;
        if (!isdefined(level.var_a29299fb)) {
            function_d5e17413();
        }
        zm_trial_util::function_8036c103();
        hide_traps();
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 1, eflags: 0x5 linked
// Checksum 0x5bd46a20, Offset: 0x6f8
// Size: 0xc4
function private on_end(round_reset) {
    assert(is_true(level.buys_disabled));
    if (!round_reset) {
        function_fa70c8c4();
        function_c606ef4b();
        function_d7ee2133();
        zm_trial_util::function_ef1fce77();
        function_c348adcc();
        zm_trial_util::function_302c6014();
        level.buys_disabled = undefined;
        show_traps();
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x1 linked
// Checksum 0xd8ca6b3f, Offset: 0x7c8
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"disable_buys");
    return isdefined(challenge);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x1 linked
// Checksum 0x543bfe79, Offset: 0x808
// Size: 0x176
function function_8327d26e() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    self endon(#"chest_accessed");
    self.var_7672d70d = 0;
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_7672d70d = 0;
    }
    level waittill(#"disable_buys");
    if (level flag::get("moving_chest_now")) {
        return;
    }
    self.var_7672d70d = 1;
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_7672d70d = 1;
        self.zbarrier notify(#"box_hacked_respin");
        if (isdefined(self.zbarrier.weapon_model)) {
            self.zbarrier.weapon_model notify(#"kill_weapon_movement");
        }
        if (isdefined(self.zbarrier.weapon_model_dw)) {
            self.zbarrier.weapon_model_dw notify(#"kill_weapon_movement");
        }
    }
    wait 0.1;
    self notify(#"trigger", {#activator:level});
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0x6e272188, Offset: 0x988
// Size: 0x2d8
function private function_6fd56055() {
    assert(isdefined(level._spawned_wallbuys));
    foreach (wallbuy in level._spawned_wallbuys) {
        target_struct = struct::get(wallbuy.target, "targetname");
        if (isdefined(target_struct) && isdefined(target_struct.target)) {
            wallbuy_fx = getent(target_struct.target, "targetname");
            if (isdefined(wallbuy_fx)) {
                wallbuy_fx ghost();
            }
        }
        model = struct::get(wallbuy.target, "targetname");
        if (isdefined(model) && isdefined(model.target)) {
            var_393a819e = getent(model.target, "targetname");
            if (isdefined(var_393a819e)) {
                var_393a819e ghost();
            }
        }
        if (isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientfieldname)) {
            assert(!isdefined(wallbuy.var_d6cca569));
            wallbuy.var_d6cca569 = level clientfield::get(wallbuy.trigger_stub.clientfieldname);
            level clientfield::set(wallbuy.trigger_stub.clientfieldname, 0);
        }
    }
    foreach (var_2b84085b in level.var_b5079c7c) {
        level exploder::exploder(var_2b84085b);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0xe69e886d, Offset: 0xc68
// Size: 0x2b8
function private function_fa70c8c4() {
    assert(isdefined(level._spawned_wallbuys));
    foreach (wallbuy in level._spawned_wallbuys) {
        target_struct = struct::get(wallbuy.target, "targetname");
        if (isdefined(target_struct) && isdefined(target_struct.target)) {
            wallbuy_fx = getent(target_struct.target, "targetname");
            if (isdefined(wallbuy_fx)) {
                wallbuy_fx show();
            }
        }
        model = struct::get(wallbuy.target, "targetname");
        if (isdefined(model) && isdefined(model.target)) {
            var_393a819e = getent(model.target, "targetname");
            if (isdefined(var_393a819e)) {
                var_393a819e show();
            }
        }
        if (isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientfieldname)) {
            assert(isdefined(wallbuy.var_d6cca569));
            level clientfield::set(wallbuy.trigger_stub.clientfieldname, wallbuy.var_d6cca569);
            wallbuy.var_d6cca569 = undefined;
        }
    }
    foreach (var_2b84085b in level.var_b5079c7c) {
        level exploder::exploder_stop(var_2b84085b);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 1, eflags: 0x5 linked
// Checksum 0x66f59f0, Offset: 0xf28
// Size: 0x58
function private _open_arcs(blocker) {
    if (isdefined(blocker.script_noteworthy) && (blocker.script_noteworthy == "electric_door" || blocker.script_noteworthy == "local_electric_door")) {
        return false;
    }
    return true;
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 2, eflags: 0x5 linked
// Checksum 0x6183ac4, Offset: 0xf88
// Size: 0x26a
function private function_fcf197fa(targetname, show) {
    blockers = getentarray(targetname, "targetname");
    if (isdefined(blockers)) {
        foreach (blocker in blockers) {
            if (isdefined(blocker.target) && _open_arcs(blocker)) {
                var_c819ac8 = getentarray(blocker.target, "targetname");
                if (isdefined(var_c819ac8)) {
                    foreach (var_1d6a70e8 in var_c819ac8) {
                        if (isdefined(var_1d6a70e8.objectid) && !var_1d6a70e8 zm_utility::function_1a4d2910()) {
                            switch (var_1d6a70e8.objectid) {
                            case #"symbol_back_debris":
                            case #"symbol_front_power":
                            case #"symbol_back":
                            case #"symbol_front":
                            case #"symbol_front_debris":
                            case #"symbol_back_power":
                                if (show) {
                                    var_1d6a70e8 show();
                                } else {
                                    var_1d6a70e8 ghost();
                                }
                                break;
                            default:
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0x2694b55a, Offset: 0x1200
// Size: 0x34
function private function_a4284cb4() {
    function_fcf197fa("zombie_door", 0);
    function_fcf197fa("zombie_debris", 0);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0xd11c23e8, Offset: 0x1240
// Size: 0x44
function private function_c606ef4b() {
    function_fcf197fa("zombie_door", 1);
    function_fcf197fa("zombie_debris", 1);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0x1317c84f, Offset: 0x1290
// Size: 0x40
function private function_4516d298() {
    level endon(#"end_game");
    while (level flag::get("moving_chest_now")) {
        waitframe(1);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0x264e37be, Offset: 0x12d8
// Size: 0x40
function private function_610df6d() {
    level endon(#"end_game");
    while (is_true(self._box_open)) {
        waitframe(1);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0x87ebdfc, Offset: 0x1320
// Size: 0x74
function private function_47c81160() {
    function_4516d298();
    if (level.chest_index != -1) {
        chest = level.chests[level.chest_index];
        chest function_610df6d();
        chest zm_magicbox::hide_chest(1);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0x678d625a, Offset: 0x13a0
// Size: 0x5c
function private function_d7ee2133() {
    function_4516d298();
    if (level.chest_index != -1) {
        chest = level.chests[level.chest_index];
        chest zm_magicbox::show_chest();
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0x4628f51c, Offset: 0x1408
// Size: 0x5c
function private function_d5e17413() {
    if (!isdefined(level.var_5bfd847e) || !level flag::exists(level.var_5bfd847e)) {
        return;
    }
    level clientfield::set("fasttravel_exploder", 0);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0x7b5479a0, Offset: 0x1470
// Size: 0x7c
function private function_c348adcc() {
    if (!isdefined(level.var_5bfd847e) || !level flag::exists(level.var_5bfd847e)) {
        return;
    }
    if (level flag::get(level.var_5bfd847e)) {
        level clientfield::set("fasttravel_exploder", 1);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0xb795336c, Offset: 0x14f8
// Size: 0xe0
function private hide_traps() {
    a_t_traps = getentarray("zombie_trap", "targetname");
    str_text = #"hash_55d25caf8f7bbb2f";
    foreach (t_trap in a_t_traps) {
        t_trap zm_traps::trap_set_string(str_text);
    }
    level notify(#"traps_cooldown");
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x5 linked
// Checksum 0xc4606af5, Offset: 0x15e0
// Size: 0xe8
function private show_traps() {
    a_t_traps = getentarray("zombie_trap", "targetname");
    str_text = #"hash_23c1c09e94181fdb";
    foreach (t_trap in a_t_traps) {
        t_trap zm_traps::trap_set_string(str_text, t_trap.zombie_cost);
    }
    level notify(#"traps_available");
}

