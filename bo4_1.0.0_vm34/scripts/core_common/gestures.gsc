#using scripts\core_common\system_shared;

#namespace gestures;

// Namespace gestures/gestures
// Params 0, eflags: 0x2
// Checksum 0x2e3852e4, Offset: 0xa0
// Size: 0x34
function autoexec __init__system__() {
    system::register(#"gestures", undefined, &main, undefined);
}

// Namespace gestures/gestures
// Params 0, eflags: 0x0
// Checksum 0xbe76f3bb, Offset: 0xe0
// Size: 0x324
function main() {
    function_9b7d6a42(#"hash_23c6eb5541cbc62f", "sig_buckler_dw");
    function_9b7d6a42(#"hash_419f11534af12a76", "sig_buckler_dw");
    function_9b7d6a42(#"ges_blinded", "sig_buckler_dw");
    function_9b7d6a42(#"hash_4f15a5e59317b738", "sig_buckler_dw");
    function_9b7d6a42(#"hash_6dbb203d420a583", "sig_buckler_dw");
    function_9b7d6a42(#"ges_grab", "sig_buckler_dw");
    function_9b7d6a42(#"hash_681eef1744584fb2", "sig_buckler_dw");
    function_9b7d6a42(#"hash_577f00f59de390db", "sig_buckler_dw");
    function_9b7d6a42(#"ges_shocked", "sig_buckler_dw");
    function_9b7d6a42(#"hash_5723248289b2a00b", "sig_buckler_dw");
    function_9b7d6a42(#"hash_23c6eb5541cbc62f", "sig_buckler_turret");
    function_9b7d6a42(#"hash_419f11534af12a76", "sig_buckler_turret");
    function_9b7d6a42(#"ges_blinded", "sig_buckler_turret");
    function_9b7d6a42(#"hash_4f15a5e59317b738", "sig_buckler_turret");
    function_9b7d6a42(#"hash_6dbb203d420a583", "sig_buckler_turret");
    function_9b7d6a42(#"ges_grab", "sig_buckler_turret");
    function_9b7d6a42(#"hash_681eef1744584fb2", "sig_buckler_turret");
    function_9b7d6a42(#"hash_577f00f59de390db", "sig_buckler_turret");
    function_9b7d6a42(#"ges_shocked", "sig_buckler_turret");
    function_9b7d6a42(#"hash_5723248289b2a00b", "sig_buckler_turret");
}

// Namespace gestures/gestures
// Params 1, eflags: 0x0
// Checksum 0x8736ee16, Offset: 0x410
// Size: 0xc2
function give_gesture(gestureweapon) {
    assert(gestureweapon != level.weaponnone, "<dev string:x30>");
    assert(!isdefined(self.gestureweapon) || self.gestureweapon == level.weaponnone, "<dev string:x5d>");
    self setactionslot(3, "taunt");
    self giveweapon(gestureweapon);
    self.gestureweapon = gestureweapon;
}

// Namespace gestures/gestures
// Params 0, eflags: 0x0
// Checksum 0x287df59b, Offset: 0x4e0
// Size: 0x8e
function clear_gesture() {
    self notify(#"cleargesture");
    if (isdefined(self.gestureweapon) && self.gestureweapon != level.weaponnone) {
        self setactionslot(3, "");
        self takeweapon(self.gestureweapon);
        self.gestureweapon = level.weaponnone;
    }
}

// Namespace gestures/gestures
// Params 1, eflags: 0x0
// Checksum 0x68266ba6, Offset: 0x578
// Size: 0x72
function function_f84cb726(gesturename) {
    if (!isdefined(gesturename)) {
        return 0;
    }
    if (gesturename == "") {
        return 0;
    }
    var_78af79db = gesturename;
    if (!ishash(var_78af79db)) {
        var_78af79db = hash(var_78af79db);
    }
    return var_78af79db;
}

// Namespace gestures/gestures
// Params 2, eflags: 0x0
// Checksum 0xd857edff, Offset: 0x5f8
// Size: 0x192
function function_9b7d6a42(gesturename, weaponname) {
    if (!isdefined(level.gesturedata)) {
        level.gesturedata = [];
    }
    var_78af79db = function_f84cb726(gesturename);
    if (!ishash(var_78af79db)) {
        return;
    }
    weapon = getweapon(weaponname);
    if (!isdefined(weapon) || weapon == level.weaponnone) {
        return;
    }
    if (!isdefined(level.gesturedata[var_78af79db])) {
        level.gesturedata[var_78af79db] = spawnstruct();
    }
    if (!isdefined(level.gesturedata[var_78af79db].weapons)) {
        level.gesturedata[var_78af79db].weapons = [];
    }
    if (!isdefined(level.gesturedata[var_78af79db].weapons[weapon])) {
        level.gesturedata[var_78af79db].weapons[weapon] = spawnstruct();
    }
    level.gesturedata[var_78af79db].weapons[weapon].var_42026238 = 1;
}

// Namespace gestures/gestures
// Params 1, eflags: 0x0
// Checksum 0x6c9812b8, Offset: 0x798
// Size: 0xba
function function_26eab6ed(gesturename) {
    if (!isdefined(level.gesturedata)) {
        level.gesturedata = [];
    }
    var_78af79db = function_f84cb726(gesturename);
    if (!ishash(var_78af79db)) {
        return;
    }
    if (!isdefined(level.gesturedata[var_78af79db])) {
        level.gesturedata[var_78af79db] = spawnstruct();
    }
    level.gesturedata[var_78af79db].var_ef65a487 = 1;
}

// Namespace gestures/gestures
// Params 1, eflags: 0x0
// Checksum 0x4b10113b, Offset: 0x860
// Size: 0x226
function function_8d9a1fb(gesturename) {
    var_78af79db = function_f84cb726(gesturename);
    if (!ishash(var_78af79db)) {
        return false;
    }
    weapon = self getcurrentweapon();
    if (isdefined(self.disablegestures) && self.disablegestures) {
        return false;
    }
    if (!isdefined(weapon) || level.weaponnone == weapon || isdefined(weapon.var_6a110104) && weapon.var_6a110104) {
        return false;
    }
    if (isdefined(level.gesturedata) && isdefined(level.gesturedata[var_78af79db]) && isdefined(level.gesturedata[var_78af79db].weapons) && isdefined(level.gesturedata[var_78af79db].weapons[weapon.rootweapon]) && isdefined(level.gesturedata[var_78af79db].weapons[weapon.rootweapon].var_42026238) && level.gesturedata[var_78af79db].weapons[weapon.rootweapon].var_42026238) {
        return false;
    }
    if (weapon.isdualwield && isdefined(level.gesturedata) && isdefined(level.gesturedata[var_78af79db]) && isdefined(level.gesturedata[var_78af79db].var_ef65a487) && level.gesturedata[var_78af79db].var_ef65a487) {
        return false;
    }
    if (self function_1b77f4ea()) {
        return false;
    }
    return true;
}

// Namespace gestures/gestures
// Params 1, eflags: 0x0
// Checksum 0xa30c645f, Offset: 0xa90
// Size: 0x72
function function_ce8466b6(var_b535f68b) {
    gesturename = undefined;
    if (isdefined(var_b535f68b)) {
        weapon = self getcurrentweapon();
        stancetype = weapon.var_5d75cc16;
        gesturename = function_983c5d8f(var_b535f68b, stancetype);
    }
    return gesturename;
}

// Namespace gestures/gestures
// Params 7, eflags: 0x0
// Checksum 0x6bbb6cc5, Offset: 0xb10
// Size: 0x86
function play_gesture(gesturename, target, var_98bcd282, blendtime, starttime, var_5d549c25, stopall) {
    if (self function_8d9a1fb(gesturename)) {
        return self function_d32a43ab(gesturename, target, var_98bcd282, blendtime, starttime, var_5d549c25, stopall);
    }
    return 0;
}

// Namespace gestures/gestures
// Params 7, eflags: 0x0
// Checksum 0x28d82bac, Offset: 0xba0
// Size: 0x6a
function function_d32a43ab(gesturename, target, var_98bcd282, blendtime, starttime, var_5d549c25, stopall) {
    return self playgestureviewmodel(gesturename, target, var_98bcd282, blendtime, starttime, var_5d549c25, stopall);
}

// Namespace gestures/gestures
// Params 7, eflags: 0x0
// Checksum 0x2a552711, Offset: 0xc18
// Size: 0x8a
function function_42215dfa(var_b535f68b, target, var_98bcd282, blendtime, starttime, var_5d549c25, stopall) {
    gesturename = self function_ce8466b6(var_b535f68b);
    return play_gesture(gesturename, target, var_98bcd282, blendtime, starttime, var_5d549c25, stopall);
}

// Namespace gestures/gestures
// Params 7, eflags: 0x0
// Checksum 0x5cb8900d, Offset: 0xcb0
// Size: 0x8a
function function_d44d1a3a(var_b535f68b, target, var_98bcd282, blendtime, starttime, var_5d549c25, stopall) {
    gesturename = self function_ce8466b6(var_b535f68b);
    return function_d32a43ab(gesturename, target, var_98bcd282, blendtime, starttime, var_5d549c25, stopall);
}

