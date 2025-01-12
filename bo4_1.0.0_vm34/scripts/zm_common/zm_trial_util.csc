#using script_13ba67412d79c7f;
#using script_39ee47b0c71ab0f1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_util;

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x2
// Checksum 0xda5f3988, Offset: 0x430
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_util", &__init__, undefined, undefined);
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x4
// Checksum 0x611f2169, Offset: 0x478
// Size: 0x396
function private __init__() {
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.roundNumber");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.roundSuccess");
    level.var_d459b40b = createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.roundTitle");
    level.var_48cad99b = createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.roundDescription");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.strikes");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.disablePerks");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.disableGun");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.disableEquip");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.disableSpecial");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.disableAbilities");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.gameStartTime");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.globalCheckState");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.globalCounterMax");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.globalCounterValue");
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.hudDeactivated");
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    callback::on_localclient_connect(&on_localplayer_connect);
    callback::on_finalize_initialization(&finalize_clientfields);
    level.var_55ff882e = 0;
    level.var_bb57ff69 = zm_trial_timer::register("zm_trial_timer");
    level.var_98b0023 = zm_trial_weapon_locked::register_clientside(#"zm_trial_weapon_locked");
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x4
// Checksum 0x46a612ef, Offset: 0x818
// Size: 0x64
function private on_localplayer_connect(localclientnum) {
    timer_model = function_c6d62a53(localclientnum);
    setuimodelvalue(timer_model, 0);
    level.var_98b0023 zm_trial_weapon_locked::open(localclientnum);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x4
// Checksum 0x9ea71ae9, Offset: 0x888
// Size: 0x6f6
function private finalize_clientfields(localclientnum) {
    clientfield::register("world", "ZMHudGlobal.trials.trialIndex", 1, getminbitcountfornum(15), "int", &function_87d9b69e, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.roundNumber", 1, getminbitcountfornum(30), "int", &function_e96dd73b, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.roundSuccess", 1, getminbitcountfornum(1), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.strikes", 1, getminbitcountfornum(3), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableGun", 1, getminbitcountfornum(1), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableEquip", 1, getminbitcountfornum(1), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableSpecial", 1, getminbitcountfornum(1), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disablePerks", 1, getminbitcountfornum(1), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableAbilities", 1, getminbitcountfornum(1), "int", undefined, 0, 0);
    clientfield::register("toplayer", "zm_trials_timer", 1, getminbitcountfornum(300), "int", &function_8b303904, 0, 1);
    clientfield::register("toplayer", "zm_trials_weapon_locked", 1, 1, "counter", &function_d46c046a, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.playerCounterMax", 1, getminbitcountfornum(200), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameState", 1, 2, "int", &function_3b195fde, 0, 1);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.failurePlayer", 1, 4, "int", undefined, 0, 0);
    clientfield::register_bgcache("worlduimodel", "string", "ZMHudGlobal.trials.failureReason", 1, &function_3f8609c3, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameStartTime", 1, 31, "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.showScoreboard", 1, getminbitcountfornum(1), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.globalCheckState", 1, getminbitcountfornum(2), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.globalCounterValue", 1, getminbitcountfornum(200), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.globalCounterMax", 1, getminbitcountfornum(200), "int", undefined, 0, 0);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.hudDeactivated", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmhud.currentWeaponLocked", 1, 1, "int", undefined, 0, 0);
    for (i = 0; i < 4; i++) {
        clientfield::register("worlduimodel", "PlayerList.client" + i + "." + "trialsCheckState", 1, 2, "int", undefined, 0, 0);
        clientfield::register("worlduimodel", "PlayerList.client" + i + "." + "trialsCounterValue", 1, getminbitcountfornum(200), "int", undefined, 0, 0);
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 7, eflags: 0x4
// Checksum 0xa6b6c0a1, Offset: 0xf88
// Size: 0x5e
function private function_87d9b69e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_f0a67892 = zm_trial::function_9e924db7(newval);
}

// Namespace zm_trial_util/zm_trial_util
// Params 7, eflags: 0x4
// Checksum 0x33f64a, Offset: 0xff0
// Size: 0x104
function private function_e96dd73b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    round_index = newval - 1;
    if (isdefined(level.var_f0a67892) && isdefined(level.var_f0a67892.rounds[round_index])) {
        on_challenge_end(localclientnum);
        level.var_a790dc75 = level.var_f0a67892.rounds[round_index];
        function_8d8310a2(localclientnum);
    } else {
        on_challenge_end(localclientnum);
        level.var_a790dc75 = undefined;
    }
    function_8dce8279();
}

// Namespace zm_trial_util/zm_trial_util
// Params 7, eflags: 0x4
// Checksum 0x9da9f0cf, Offset: 0x1100
// Size: 0x5c
function private function_3b195fde(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_55ff882e = newval;
    function_8dce8279();
}

// Namespace zm_trial_util/zm_trial_util
// Params 7, eflags: 0x4
// Checksum 0xd624e067, Offset: 0x1168
// Size: 0x5c
function private function_3f8609c3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_4def90bf = newval;
    function_8dce8279();
}

// Namespace zm_trial_util/zm_trial_util
// Params 7, eflags: 0x4
// Checksum 0xe73739fd, Offset: 0x11d0
// Size: 0xc4
function private function_8b303904(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!function_9a47ed7f(localclientnum)) {
        timer_model = function_c6d62a53(localclientnum);
        duration_msec = newval * 1000;
        setuimodelvalue(timer_model, getservertime(localclientnum, 1) + duration_msec);
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 7, eflags: 0x4
// Checksum 0x92743872, Offset: 0x12a0
// Size: 0x54
function private function_d46c046a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_49b6503a(localclientnum);
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x4
// Checksum 0xe4a0644c, Offset: 0x1300
// Size: 0xe2
function private function_8d8310a2(local_client_num) {
    if (isdefined(level.var_a790dc75)) {
        for (i = 0; i < level.var_a790dc75.challenges.size; i++) {
            challenge = level.var_a790dc75.challenges[i];
            if (isdefined(level.var_e63b8d85[challenge.name]) && isdefined(level.var_e63b8d85[challenge.name].var_5f7c5b3)) {
                [[ level.var_e63b8d85[challenge.name].var_5f7c5b3 ]](local_client_num, challenge.params);
            }
        }
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x4
// Checksum 0xbb96c467, Offset: 0x13f0
// Size: 0xd6
function private on_challenge_end(local_client_num) {
    if (isdefined(level.var_a790dc75)) {
        for (i = 0; i < level.var_a790dc75.challenges.size; i++) {
            challenge = level.var_a790dc75.challenges[i];
            if (isdefined(level.var_e63b8d85[challenge.name]) && isdefined(level.var_e63b8d85[challenge.name].var_640416df)) {
                [[ level.var_e63b8d85[challenge.name].var_640416df ]](local_client_num);
            }
        }
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 0, eflags: 0x4
// Checksum 0xcf0fcd1f, Offset: 0x14d0
// Size: 0x102
function private function_8dce8279() {
    assert(isdefined(level.var_55ff882e));
    setuimodelvalue(level.var_d459b40b, #"");
    setuimodelvalue(level.var_48cad99b, #"");
    switch (level.var_55ff882e) {
    default:
        if (isdefined(level.var_a790dc75)) {
            setuimodelvalue(level.var_d459b40b, level.var_a790dc75.name_str);
            setuimodelvalue(level.var_48cad99b, level.var_a790dc75.desc_str);
        }
        break;
    }
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x4
// Checksum 0x9a2e0bfd, Offset: 0x15e0
// Size: 0x4a
function private function_c6d62a53(localclientnum) {
    controller_model = getuimodelforcontroller(localclientnum);
    return createuimodel(controller_model, "ZMHud.trialsTimer");
}

// Namespace zm_trial_util/zm_trial_util
// Params 1, eflags: 0x0
// Checksum 0xe731bda3, Offset: 0x1638
// Size: 0x54
function function_49b6503a(localclientnum) {
    level.var_98b0023 zm_trial_weapon_locked::function_74b3c310(localclientnum);
    self playsound(localclientnum, #"hash_17c7895c4b5180ce");
}

