#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace tracker;

// Namespace tracker/tracker_shared
// Params 0, eflags: 0x0
// Checksum 0xc3923822, Offset: 0xc0
// Size: 0x24
function init_shared() {
    registerclientfields();
    function_fa884ccf();
}

// Namespace tracker/tracker_shared
// Params 0, eflags: 0x4
// Checksum 0x55aac755, Offset: 0xf0
// Size: 0x54
function private registerclientfields() {
    clientfield::register_clientuimodel("huditems.isExposedOnMinimap", #"hash_6f4b11a0bee9b73d", #"isexposedonminimap", 1, 1, "int", undefined, 0, 0);
}

// Namespace tracker/tracker_shared
// Params 0, eflags: 0x0
// Checksum 0xe41e9cde, Offset: 0x150
// Size: 0x110
function function_fa884ccf() {
    callback::on_localplayer_spawned(&on_player_spawned);
    var_5951c51b = getdvarint(#"hash_451ecc8708eb258d");
    level.var_5951c51b = var_5951c51b < 0 ? 3 : var_5951c51b;
    var_f2e5ae7 = getdvarint(#"hash_5b0b64262b06c91d");
    level.var_f2e5ae7 = var_f2e5ae7 < 0 ? 7500 : var_f2e5ae7;
    var_5b162bc3 = getdvarint(#"hash_7ae43b6918bd9bac");
    level.var_5b162bc3 = var_5b162bc3 < 0 ? 1000 : var_5b162bc3;
}

// Namespace tracker/tracker_shared
// Params 1, eflags: 0x0
// Checksum 0xe8047cc7, Offset: 0x268
// Size: 0x3c
function on_player_spawned(localclientnum) {
    if (!isbot(self)) {
        self thread function_8c47bbe5(localclientnum);
    }
}

// Namespace tracker/tracker_shared
// Params 0, eflags: 0x4
// Checksum 0xaef6fd3, Offset: 0x2b0
// Size: 0x132
function private function_dbd63244() {
    assert(isplayer(self));
    if (self function_da43934d()) {
        return self geteye();
    }
    stance = self getstance();
    switch (stance) {
    case #"prone":
        return (self.origin + (0, 0, 11));
    case #"crouch":
        return (self.origin + (0, 0, 40));
    case #"stand":
        return (self.origin + (0, 0, 60));
    default:
        return (self.origin + (0, 0, 60));
    }
}

// Namespace tracker/tracker_shared
// Params 0, eflags: 0x4
// Checksum 0xedf0fdfa, Offset: 0x3f0
// Size: 0x6a
function private function_94f8b125() {
    var_f2e5ae7 = level.var_f2e5ae7;
    currentweapon = self function_d2c2b168();
    if (isdefined(currentweapon.var_f2e5ae7) && currentweapon.var_f2e5ae7 > 0) {
        var_f2e5ae7 = currentweapon.var_f2e5ae7;
    }
    return var_f2e5ae7;
}

// Namespace tracker/tracker_shared
// Params 4, eflags: 0x4
// Checksum 0x1e087c67, Offset: 0x468
// Size: 0x122
function private function_ffea3e6b(localclientnum, var_18dd204e, spotter, target) {
    if (!isdefined(spotter) || !isdefined(target)) {
        return false;
    }
    if (!isplayer(spotter) || !isplayer(target)) {
        return false;
    }
    if (!spotter hasperk(localclientnum, #"specialty_tracker")) {
        return false;
    }
    if (target hasperk(localclientnum, #"specialty_immunetrackerspotting")) {
        return false;
    }
    if (!isdefined(target.team) || var_18dd204e == target.team) {
        return false;
    }
    if (!isalive(spotter) || !isalive(target)) {
        return false;
    }
    return true;
}

// Namespace tracker/tracker_shared
// Params 3, eflags: 0x4
// Checksum 0x815008a1, Offset: 0x598
// Size: 0x280
function private function_c8ffa38a(spotter, target, var_5a527fb7) {
    if (!isdefined(spotter) || !isdefined(target)) {
        return false;
    }
    if (!isplayer(spotter) || !isplayer(target)) {
        return false;
    }
    if (!is_true(spotter isplayerads())) {
        return false;
    }
    var_d2a509dc = spotter function_dbd63244();
    var_14586a15 = target function_dbd63244();
    var_eb5ac886 = var_14586a15 - var_d2a509dc;
    var_c384842d = lengthsquared(var_eb5ac886);
    if (var_c384842d > function_a3f6cdac(var_5a527fb7)) {
        return false;
    }
    if (var_c384842d < 1) {
        return false;
    }
    cosanglethreshold = cos(level.var_5951c51b);
    var_4c94543b = spotter getplayerangles();
    var_fde76ebb = anglestoforward(var_4c94543b);
    var_56c587f1 = vectornormalize(var_eb5ac886);
    if (vectordot(var_fde76ebb, var_56c587f1) < cosanglethreshold) {
        return false;
    }
    trace = bullettrace(var_d2a509dc, var_14586a15, 1, spotter);
    if (trace[#"fraction"] === 1) {
        return true;
    }
    var_26792c97 = trace[#"entity"];
    if (isdefined(var_26792c97) && var_26792c97 == target) {
        target function_a4f246fb(level.var_5b162bc3);
    }
    return true;
}

// Namespace tracker/tracker_shared
// Params 1, eflags: 0x4
// Checksum 0x751f567a, Offset: 0x820
// Size: 0x23c
function private function_8c47bbe5(localclientnum) {
    level endon(#"game_ended");
    self endon(#"disconnect", #"shutdown", #"death");
    self notify("2289f0e9cf025b40");
    self endon("2289f0e9cf025b40");
    while (true) {
        team = self.team;
        friendlies = getfriendlyplayers(localclientnum, team);
        foreach (spotter in friendlies) {
            if (!isdefined(spotter)) {
                continue;
            }
            var_5a527fb7 = spotter function_94f8b125();
            targets = getenemyplayers(localclientnum, team, spotter.origin, var_5a527fb7);
            foreach (target in targets) {
                var_bc24f393 = 0;
                if (function_ffea3e6b(localclientnum, team, spotter, target)) {
                    if (function_c8ffa38a(spotter, target, var_5a527fb7)) {
                        var_bc24f393 = 1;
                    }
                    wait 0.05;
                }
            }
        }
        wait 0.25;
    }
}

