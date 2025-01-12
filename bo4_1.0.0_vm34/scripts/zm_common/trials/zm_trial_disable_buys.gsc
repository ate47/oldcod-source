#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_disable_buys;

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x2
// Checksum 0x8d465be0, Offset: 0x330
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_disable_buys", &__init__, undefined, undefined);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x0
// Checksum 0xbc37eff6, Offset: 0x378
// Size: 0x124
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    level.var_b2baa271 = array("exp_lgt_ar_accurate_t8", "exp_lgt_ar_fastfire_t8", "exp_lgt_ar_modular_t8", "exp_lgt_ar_stealth_t8", "exp_lgt_ar_stealth_t8_2", "exp_lgt_bowie", "exp_lgt_bowie_2", "exp_lgt_lmg_standard_t8", "exp_lgt_pistol_burst_t8", "exp_lgt_pistol_standard_t8", "exp_lgt_shotgun_pump_t8", "exp_lgt_shotgun_trenchgun_t8", "exp_lgt_smg_accurate_t8", "exp_lgt_smg_accurate_t8_2", "exp_lgt_smg_drum_pistol_t8", "exp_lgt_smg_fastfire_t8", "exp_lgt_smg_handling_t8", "exp_lgt_smg_standard_t8", "exp_lgt_sniper_quickscope_t8", "exp_lgt_tr_leveraction_t8", "exp_lgt_tr_longburst_t8", "exp_lgt_tr_powersemi_t8");
    zm_trial::register_challenge(#"disable_buys", &on_begin, &on_end);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x4
// Checksum 0x5c58ec44, Offset: 0x4a8
// Size: 0xac
function private on_begin() {
    if (!(isdefined(level.buys_disabled) && level.buys_disabled)) {
        level.buys_disabled = 1;
        level notify(#"disable_buys");
        function_d30f172f();
        function_acbfb2cb();
        hide_magicbox();
        zm_trial_util::function_5af41a8();
        function_e183c0b9();
        zm_trial_util::function_8d6f6c09();
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 1, eflags: 0x4
// Checksum 0xcc0c5806, Offset: 0x560
// Size: 0xae
function private on_end(round_reset) {
    assert(isdefined(level.buys_disabled) && level.buys_disabled);
    if (!round_reset) {
        function_cef5d672();
        function_20ebd0de();
        show_magicbox();
        zm_trial_util::function_4662a26f();
        function_e2391836();
        zm_trial_util::function_46e52c6b();
        level.buys_disabled = undefined;
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x0
// Checksum 0x4ae59d59, Offset: 0x618
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"disable_buys");
    return isdefined(challenge);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x0
// Checksum 0x8e7145dc, Offset: 0x658
// Size: 0x176
function function_713cd670() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    self endon(#"chest_accessed");
    self.var_41ea08e9 = 0;
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_41ea08e9 = 0;
    }
    level waittill(#"disable_buys");
    if (level flag::get("moving_chest_now")) {
        return;
    }
    self.var_41ea08e9 = 1;
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_41ea08e9 = 1;
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
// Params 0, eflags: 0x4
// Checksum 0x9005ed5c, Offset: 0x7d8
// Size: 0x2e8
function private function_d30f172f() {
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
            var_22ee937e = getent(model.target, "targetname");
            if (isdefined(var_22ee937e)) {
                var_22ee937e ghost();
            }
        }
        if (isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientfieldname)) {
            assert(!isdefined(wallbuy.var_3978e382));
            wallbuy.var_3978e382 = level clientfield::get(wallbuy.trigger_stub.clientfieldname);
            level clientfield::set(wallbuy.trigger_stub.clientfieldname, 0);
        }
    }
    foreach (var_1d0246ce in level.var_b2baa271) {
        level exploder::exploder(var_1d0246ce);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x4
// Checksum 0xcc89a66c, Offset: 0xac8
// Size: 0x2c0
function private function_cef5d672() {
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
            var_22ee937e = getent(model.target, "targetname");
            if (isdefined(var_22ee937e)) {
                var_22ee937e show();
            }
        }
        if (isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientfieldname)) {
            assert(isdefined(wallbuy.var_3978e382));
            level clientfield::set(wallbuy.trigger_stub.clientfieldname, wallbuy.var_3978e382);
            wallbuy.var_3978e382 = undefined;
        }
    }
    foreach (var_1d0246ce in level.var_b2baa271) {
        level exploder::exploder_stop(var_1d0246ce);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 1, eflags: 0x4
// Checksum 0xa4ba7434, Offset: 0xd90
// Size: 0x58
function private function_ba9af783(blocker) {
    if (isdefined(blocker.script_noteworthy) && (blocker.script_noteworthy == "electric_door" || blocker.script_noteworthy == "local_electric_door")) {
        return false;
    }
    return true;
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 2, eflags: 0x4
// Checksum 0xef840d78, Offset: 0xdf0
// Size: 0x252
function private function_75e1e45f(targetname, show) {
    blockers = getentarray(targetname, "targetname");
    if (isdefined(blockers)) {
        foreach (blocker in blockers) {
            if (isdefined(blocker.target) && function_ba9af783(blocker)) {
                var_13eac1ee = getentarray(blocker.target, "targetname");
                if (isdefined(var_13eac1ee)) {
                    foreach (var_ecaebab7 in var_13eac1ee) {
                        if (isdefined(var_ecaebab7.objectid) && !var_ecaebab7 zm_utility::function_e8fc435c()) {
                            switch (var_ecaebab7.objectid) {
                            case #"symbol_back_debris":
                            case #"symbol_front_power":
                            case #"symbol_back":
                            case #"symbol_front":
                            case #"symbol_front_debris":
                            case #"symbol_back_power":
                                if (show) {
                                    var_ecaebab7 show();
                                } else {
                                    var_ecaebab7 ghost();
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
// Params 0, eflags: 0x4
// Checksum 0xa7912fab, Offset: 0x1050
// Size: 0x34
function private function_acbfb2cb() {
    function_75e1e45f("zombie_door", 0);
    function_75e1e45f("zombie_debris", 0);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x4
// Checksum 0x860eff79, Offset: 0x1090
// Size: 0x44
function private function_20ebd0de() {
    function_75e1e45f("zombie_door", 1);
    function_75e1e45f("zombie_debris", 1);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x4
// Checksum 0xe4a53002, Offset: 0x10e0
// Size: 0x30
function private function_866615b7() {
    while (level flag::get("moving_chest_now")) {
        waitframe(1);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x4
// Checksum 0x8214db0d, Offset: 0x1118
// Size: 0x64
function private hide_magicbox() {
    function_866615b7();
    if (level.chest_index != -1) {
        chest = level.chests[level.chest_index];
        chest zm_magicbox::hide_chest(1);
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x4
// Checksum 0x28f85b5c, Offset: 0x1188
// Size: 0x5c
function private show_magicbox() {
    function_866615b7();
    if (level.chest_index != -1) {
        chest = level.chests[level.chest_index];
        chest zm_magicbox::show_chest();
    }
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x4
// Checksum 0xb909de38, Offset: 0x11f0
// Size: 0x24
function private function_e183c0b9() {
    level clientfield::set("fasttravel_exploder", 0);
}

// Namespace zm_trial_disable_buys/zm_trial_disable_buys
// Params 0, eflags: 0x4
// Checksum 0xf259faab, Offset: 0x1220
// Size: 0x44
function private function_e2391836() {
    if (level flag::get(level.var_8b3ad83a)) {
        level clientfield::set("fasttravel_exploder", 1);
    }
}

