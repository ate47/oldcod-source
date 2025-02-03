#using scripts\core_common\system_shared;

#namespace gestures;

// Namespace gestures/gestures
// Params 0, eflags: 0x6
// Checksum 0x4fd45a9b, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gestures", undefined, &main, undefined, undefined);
}

// Namespace gestures/gestures
// Params 0, eflags: 0x0
// Checksum 0x99838d12, Offset: 0xe8
// Size: 0x324
function main() {
    function_a5202150(#"hash_23c6eb5541cbc62f", "sig_buckler_dw");
    function_a5202150(#"hash_419f11534af12a76", "sig_buckler_dw");
    function_a5202150(#"ges_blinded", "sig_buckler_dw");
    function_a5202150(#"hash_4f15a5e59317b738", "sig_buckler_dw");
    function_a5202150(#"hash_6dbb203d420a583", "sig_buckler_dw");
    function_a5202150(#"ges_grab", "sig_buckler_dw");
    function_a5202150(#"hash_681eef1744584fb2", "sig_buckler_dw");
    function_a5202150(#"hash_577f00f59de390db", "sig_buckler_dw");
    function_a5202150(#"ges_shocked", "sig_buckler_dw");
    function_a5202150(#"hash_5723248289b2a00b", "sig_buckler_dw");
    function_a5202150(#"hash_23c6eb5541cbc62f", "sig_buckler_turret");
    function_a5202150(#"hash_419f11534af12a76", "sig_buckler_turret");
    function_a5202150(#"ges_blinded", "sig_buckler_turret");
    function_a5202150(#"hash_4f15a5e59317b738", "sig_buckler_turret");
    function_a5202150(#"hash_6dbb203d420a583", "sig_buckler_turret");
    function_a5202150(#"ges_grab", "sig_buckler_turret");
    function_a5202150(#"hash_681eef1744584fb2", "sig_buckler_turret");
    function_a5202150(#"hash_577f00f59de390db", "sig_buckler_turret");
    function_a5202150(#"ges_shocked", "sig_buckler_turret");
    function_a5202150(#"hash_5723248289b2a00b", "sig_buckler_turret");
}

// Namespace gestures/gestures
// Params 1, eflags: 0x0
// Checksum 0xf18553cf, Offset: 0x418
// Size: 0xc2
function give_gesture(gestureweapon) {
    assert(gestureweapon != level.weaponnone, "<dev string:x38>");
    assert(!isdefined(self.gestureweapon) || self.gestureweapon == level.weaponnone, "<dev string:x68>");
    self setactionslot(3, "taunt");
    self giveweapon(gestureweapon);
    self.gestureweapon = gestureweapon;
}

// Namespace gestures/gestures
// Params 0, eflags: 0x0
// Checksum 0x4e19483, Offset: 0x4e8
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
// Checksum 0xfb66730, Offset: 0x580
// Size: 0x72
function function_e198bde3(gesturename) {
    if (!isdefined(gesturename)) {
        return 0;
    }
    if (gesturename == "") {
        return 0;
    }
    var_45e6768d = gesturename;
    if (!ishash(var_45e6768d)) {
        var_45e6768d = hash(var_45e6768d);
    }
    return var_45e6768d;
}

// Namespace gestures/gestures
// Params 2, eflags: 0x0
// Checksum 0x5d14d855, Offset: 0x600
// Size: 0x182
function function_a5202150(gesturename, weaponname) {
    if (!isdefined(level.gesturedata)) {
        level.gesturedata = [];
    }
    var_45e6768d = function_e198bde3(gesturename);
    if (!ishash(var_45e6768d)) {
        return;
    }
    weapon = getweapon(weaponname);
    if (!isdefined(weapon) || weapon == level.weaponnone) {
        return;
    }
    if (!isdefined(level.gesturedata[var_45e6768d])) {
        level.gesturedata[var_45e6768d] = spawnstruct();
    }
    if (!isdefined(level.gesturedata[var_45e6768d].weapons)) {
        level.gesturedata[var_45e6768d].weapons = [];
    }
    if (!isdefined(level.gesturedata[var_45e6768d].weapons[weapon])) {
        level.gesturedata[var_45e6768d].weapons[weapon] = spawnstruct();
    }
    level.gesturedata[var_45e6768d].weapons[weapon].var_fa9d3758 = 1;
}

// Namespace gestures/gestures
// Params 1, eflags: 0x0
// Checksum 0xe440a77f, Offset: 0x790
// Size: 0xb6
function function_ba4529d4(gesturename) {
    if (!isdefined(level.gesturedata)) {
        level.gesturedata = [];
    }
    var_45e6768d = function_e198bde3(gesturename);
    if (!ishash(var_45e6768d)) {
        return;
    }
    if (!isdefined(level.gesturedata[var_45e6768d])) {
        level.gesturedata[var_45e6768d] = spawnstruct();
    }
    level.gesturedata[var_45e6768d].var_93380a93 = 1;
}

// Namespace gestures/gestures
// Params 1, eflags: 0x0
// Checksum 0x728aff1c, Offset: 0x850
// Size: 0x22e
function function_8cc27b6d(gesturename) {
    var_45e6768d = function_e198bde3(gesturename);
    if (!ishash(var_45e6768d)) {
        return false;
    }
    weapon = self getcurrentweapon();
    if (is_true(self.disablegestures)) {
        return false;
    }
    if (!isdefined(weapon) || level.weaponnone == weapon) {
        return false;
    }
    if (is_true(weapon.var_d2751f9d)) {
        return false;
    }
    if (is_true(weapon.var_554be9f7) && self isfiring()) {
        return false;
    }
    if (isdefined(level.gesturedata) && isdefined(level.gesturedata[var_45e6768d]) && isdefined(level.gesturedata[var_45e6768d].weapons) && isdefined(level.gesturedata[var_45e6768d].weapons[weapon.rootweapon]) && is_true(level.gesturedata[var_45e6768d].weapons[weapon.rootweapon].var_fa9d3758)) {
        return false;
    }
    if (weapon.isdualwield && isdefined(level.gesturedata) && isdefined(level.gesturedata[var_45e6768d]) && is_true(level.gesturedata[var_45e6768d].var_93380a93)) {
        return false;
    }
    if (self function_55acff10(1)) {
        return false;
    }
    return true;
}

// Namespace gestures/gestures
// Params 1, eflags: 0x0
// Checksum 0xbf14a902, Offset: 0xa88
// Size: 0x72
function function_c77349d4(var_851342cf) {
    gesturename = undefined;
    if (isdefined(var_851342cf)) {
        weapon = self getcurrentweapon();
        stancetype = weapon.var_6566504b;
        gesturename = function_d12fe2ad(var_851342cf, stancetype);
    }
    return gesturename;
}

// Namespace gestures/gestures
// Params 7, eflags: 0x0
// Checksum 0x4fd17d16, Offset: 0xb08
// Size: 0x7e
function play_gesture(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall) {
    if (self function_8cc27b6d(gesturename)) {
        return self function_b6cc48ed(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
    }
    return 0;
}

// Namespace gestures/gestures
// Params 7, eflags: 0x0
// Checksum 0x706ee3dc, Offset: 0xb90
// Size: 0x5a
function function_b6cc48ed(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall) {
    return self playgestureviewmodel(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
}

// Namespace gestures/gestures
// Params 7, eflags: 0x0
// Checksum 0x953a3f5, Offset: 0xbf8
// Size: 0x7a
function function_56e00fbf(var_851342cf, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall) {
    gesturename = self function_c77349d4(var_851342cf);
    return play_gesture(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
}

// Namespace gestures/gestures
// Params 7, eflags: 0x0
// Checksum 0x490f4300, Offset: 0xc80
// Size: 0x7a
function function_e62f6dde(var_851342cf, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall) {
    gesturename = self function_c77349d4(var_851342cf);
    return function_b6cc48ed(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
}

// Namespace gestures/gestures
// Params 7, eflags: 0x0
// Checksum 0xd08d1d2b, Offset: 0xd08
// Size: 0x262
function function_f3e2696f(ent, weapon, weapon_options, timeout, var_1e89628f, var_1d78d31, callbackfail) {
    self endon(#"death");
    var_f69ae03d = self weaponcyclingenabled();
    self disableweaponcycling();
    while (self isswitchingweapons()) {
        waitframe(1);
    }
    if (var_f69ae03d) {
        self enableweaponcycling();
    }
    var_f3b15ce0 = 0;
    if (!self giveandfireoffhand(weapon, weapon_options)) {
        if (isdefined(callbackfail)) {
            self [[ callbackfail ]](ent, var_f3b15ce0);
        }
        return;
    }
    while (true) {
        result = self waittilltimeout(timeout, #"grenade_pullback", #"offhand_fire", #"offhand_end");
        if (result._notify == #"timeout") {
            break;
        }
        if (result.weapon == weapon) {
            if (result._notify == #"offhand_end") {
                break;
            }
            if (result._notify == #"grenade_pullback") {
                var_f3b15ce0 = 1;
                if (isdefined(var_1e89628f)) {
                    self [[ var_1e89628f ]](ent);
                }
                continue;
            }
            if (result._notify == #"offhand_fire") {
                if (isdefined(var_1d78d31)) {
                    self [[ var_1d78d31 ]](ent);
                }
                return;
            }
        }
    }
    if (isdefined(callbackfail)) {
        self [[ callbackfail ]](ent, var_f3b15ce0);
    }
}

