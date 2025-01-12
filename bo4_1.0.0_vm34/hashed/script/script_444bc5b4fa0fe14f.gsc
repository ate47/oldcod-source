#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace namespace_31bdfe2d;

// Namespace namespace_31bdfe2d/namespace_31bdfe2d
// Params 0, eflags: 0x2
// Checksum 0x3227aa66, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_4229d59c5b830185", &__init__, undefined, undefined);
}

// Namespace namespace_31bdfe2d/namespace_31bdfe2d
// Params 0, eflags: 0x0
// Checksum 0xc295ea9a, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_3746f3c279f7a5ea", &on_begin, &on_end);
}

// Namespace namespace_31bdfe2d/namespace_31bdfe2d
// Params 1, eflags: 0x4
// Checksum 0x54d31664, Offset: 0x138
// Size: 0x154
function private on_begin(number_to_kill) {
    switch (getplayers().size) {
    case 1:
        level.var_2060b296 = 10;
        break;
    case 2:
        level.var_2060b296 = 15;
        break;
    case 3:
        level.var_2060b296 = 20;
        break;
    case 4:
        level.var_2060b296 = 25;
        break;
    default:
        assert(0);
        break;
    }
    level.var_ad28ee46 = 0;
    level thread function_4b76cfcb();
    zm_trial_util::function_368f31a9(level.var_2060b296);
    zm_trial_util::function_ef967e48(level.var_ad28ee46);
    level thread function_8c2c4c07();
}

// Namespace namespace_31bdfe2d/namespace_31bdfe2d
// Params 1, eflags: 0x4
// Checksum 0xc66612d6, Offset: 0x298
// Size: 0x72
function private on_end(round_reset) {
    zm_trial_util::function_59861180();
    if (!round_reset) {
        if (level.var_ad28ee46 < level.var_2060b296) {
            zm_trial::fail(#"hash_3f700791572b0dcf");
        }
    }
    level.var_2060b296 = undefined;
    level.var_ad28ee46 = undefined;
}

// Namespace namespace_31bdfe2d/namespace_31bdfe2d
// Params 0, eflags: 0x4
// Checksum 0xb3d101a6, Offset: 0x318
// Size: 0x4c
function private function_8c2c4c07() {
    level endon(#"hash_7646638df88a3656");
    while (true) {
        level waittill(#"hash_166cac102910cdb3");
        level.var_ad28ee46++;
    }
}

// Namespace namespace_31bdfe2d/namespace_31bdfe2d
// Params 0, eflags: 0x4
// Checksum 0xca19a4a8, Offset: 0x370
// Size: 0x96
function private function_4b76cfcb() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    while (true) {
        var_15ebf219 = level.var_ad28ee46;
        if (var_15ebf219 < 0) {
            var_15ebf219 = 0;
        } else if (var_15ebf219 > level.var_2060b296) {
            var_15ebf219 = level.var_2060b296;
        }
        zm_trial_util::function_ef967e48(var_15ebf219);
        waitframe(1);
    }
}

// Namespace namespace_31bdfe2d/namespace_31bdfe2d
// Params 0, eflags: 0x0
// Checksum 0xd4f4c102, Offset: 0x410
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"hash_3746f3c279f7a5ea");
    return isdefined(challenge);
}

// Namespace namespace_31bdfe2d/namespace_31bdfe2d
// Params 0, eflags: 0x0
// Checksum 0xa601c03c, Offset: 0x450
// Size: 0x8
function function_54400533() {
    return 30;
}

// Namespace namespace_31bdfe2d/namespace_31bdfe2d
// Params 0, eflags: 0x0
// Checksum 0xbad299f3, Offset: 0x460
// Size: 0x8
function function_43328a2d() {
    return 4;
}

