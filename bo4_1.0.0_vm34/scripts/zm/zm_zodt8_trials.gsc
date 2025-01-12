#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_trial;

#namespace zm_zodt8_trials;

// Namespace zm_zodt8_trials/zm_zodt8_trials
// Params 0, eflags: 0x6
// Checksum 0x99e45d9b, Offset: 0x78
// Size: 0x24
function private autoexec function_b259fc91() {
    zm_round_spawning::function_1707d338(&function_4e227790);
}

// Namespace zm_zodt8_trials/zm_zodt8_trials
// Params 1, eflags: 0x4
// Checksum 0x14b581c4, Offset: 0xa8
// Size: 0x516
function private function_4e227790(var_1c748f5e) {
    if (!zm_trial::is_trial_mode()) {
        return var_1c748f5e;
    }
    if (!isdefined(var_1c748f5e[#"blight_father"])) {
        var_1c748f5e[#"blight_father"] = 0;
    }
    if (!isdefined(var_1c748f5e[#"stoker"])) {
        var_1c748f5e[#"stoker"] = 0;
    }
    if (!isdefined(var_1c748f5e[#"catalyst"])) {
        var_1c748f5e[#"catalyst"] = 0;
    }
    assert(isdefined(level.var_f0a67892));
    assert(isdefined(level.var_b21e401b));
    player_count = getplayers().size;
    if (level.round_number == 24) {
        assert(level.var_b21e401b.name == #"unhealthy");
        if (player_count == 1) {
            var_1c748f5e[#"blight_father"] = 2;
        } else {
            var_1c748f5e[#"blight_father"] = 4;
        }
    } else if (level.round_number == 28) {
        assert(level.var_b21e401b.name == #"hash_7aff6c8730240d5");
        var_1c748f5e[#"blight_father"] = max(var_1c748f5e[#"blight_father"], 1);
        var_1c748f5e[#"stoker"] = max(var_1c748f5e[#"stoker"], 1);
        var_1c748f5e[#"catalyst"] = max(var_1c748f5e[#"catalyst"], 1);
        var_1c748f5e[#"blight_father"] = int(ceil(var_1c748f5e[#"blight_father"] * 1.3));
        var_1c748f5e[#"stoker"] = int(ceil(var_1c748f5e[#"stoker"] * 1.3));
        var_1c748f5e[#"catalyst"] = int(ceil(var_1c748f5e[#"catalyst"] * 1.3));
    } else if (level.round_number == 30) {
        assert(level.var_b21e401b.name == #"hash_37f11d9a44a08099");
        if (player_count == 1) {
            var_1c748f5e[#"blight_father"] = 3;
            var_1c748f5e[#"stoker"] = var_1c748f5e[#"stoker"] + 2;
            var_1c748f5e[#"catalyst"] = var_1c748f5e[#"catalyst"] + 8;
        } else {
            var_1c748f5e[#"blight_father"] = 8;
            var_1c748f5e[#"stoker"] = var_1c748f5e[#"stoker"] + 4;
            var_1c748f5e[#"catalyst"] = var_1c748f5e[#"catalyst"] + 16;
        }
    }
    return var_1c748f5e;
}

