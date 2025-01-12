#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace wz_perk_paranoia;

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 0, eflags: 0x2
// Checksum 0x45830e8f, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_perk_paranoia", &__init__, undefined, undefined);
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 0, eflags: 0x0
// Checksum 0x2a9e6bd0, Offset: 0xd8
// Size: 0x24
function __init__() {
    callback::function_948e38c4(&function_948e38c4);
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 1, eflags: 0x0
// Checksum 0xd6e7cdec, Offset: 0x108
// Size: 0x9a
function function_948e38c4(localclientnum) {
    if (self function_40efd9db()) {
        var_3288f90e = self hasperk(localclientnum, #"specialty_paranoia");
        var_548aa6f4 = self.var_3288f90e !== var_3288f90e;
        if (var_548aa6f4) {
            self thread function_17fafbbc(localclientnum);
        }
        self.var_3288f90e = var_3288f90e;
    }
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 0, eflags: 0x4
// Checksum 0xee9530b2, Offset: 0x1b0
// Size: 0x132
function private function_4f7d9503() {
    assert(self isplayer());
    if (self function_40efd9db()) {
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

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 0, eflags: 0x4
// Checksum 0xbb4020f4, Offset: 0x2f0
// Size: 0x1a
function private function_33d659c6() {
    return self.origin + (0, 0, 36);
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 1, eflags: 0x4
// Checksum 0x31d98d11, Offset: 0x318
// Size: 0x6c6
function private function_17fafbbc(localclientnum) {
    level endon(#"game_ended");
    self endon(#"shutdown", #"death");
    self notify("54c668dc2f3a4336");
    self endon("54c668dc2f3a4336");
    if (!self hasperk(localclientnum, #"specialty_paranoia")) {
        return;
    }
    var_afeaafde = cos(10);
    while (true) {
        var_c776e9e4 = undefined;
        players = getplayers(localclientnum);
        foreach (player in players) {
            if (!isdefined(player)) {
                continue;
            }
            if (player == self) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            if (player.team == self.team) {
                continue;
            }
            if (!player isplayerads()) {
                continue;
            }
            player_eye_pos = player function_4f7d9503();
            var_69d5ff69 = self function_33d659c6();
            to_self = var_69d5ff69 - player_eye_pos;
            if (lengthsquared(to_self) > 21600 * 21600) {
                continue;
            }
            player_angles = player getplayerangles();
            player_forward = anglestoforward(player_angles);
            var_bb75ca6c = vectornormalize(to_self);
            if (vectordot(player_forward, var_bb75ca6c) < var_afeaafde) {
                continue;
            }
            test_points = [];
            if (!isdefined(test_points)) {
                test_points = [];
            } else if (!isarray(test_points)) {
                test_points = array(test_points);
            }
            test_points[test_points.size] = self.origin + (0, 0, 11);
            if (!isdefined(test_points)) {
                test_points = [];
            } else if (!isarray(test_points)) {
                test_points = array(test_points);
            }
            test_points[test_points.size] = self.origin + (0, 0, 40);
            if (!isdefined(test_points)) {
                test_points = [];
            } else if (!isarray(test_points)) {
                test_points = array(test_points);
            }
            test_points[test_points.size] = self.origin + (0, 0, 60);
            los = 0;
            foreach (test_point in test_points) {
                trace_dist = length(to_self) + 100;
                trace_end = test_point + vectorscale(player_forward, trace_dist * -1);
                trace = bullettrace(test_point, trace_end, 1, self);
                if (trace[#"fraction"] < 1 && trace[#"entity"] === player) {
                    los = 1;
                    break;
                }
            }
            if (los) {
                var_12fdbef7 = coordtransformtranspose(player.origin, self.origin, self.angles);
                var_55d0659 = vectortoangles(var_12fdbef7);
                yaw = absangleclamp360(var_55d0659[1]);
                if (yaw < 45 || yaw >= 315) {
                    var_c776e9e4 = #"hash_116dc26ba86b4ccc";
                } else if (yaw >= 45 && yaw < 135) {
                    var_c776e9e4 = #"hash_50b8f7df5b22fb9c";
                } else if (yaw >= 135 && yaw < 225) {
                    var_c776e9e4 = #"hash_363f368c12ede11e";
                } else {
                    var_c776e9e4 = #"hash_71633141240ccc49";
                }
                break;
            }
            waitframe(1);
        }
        if (isdefined(var_c776e9e4)) {
            var_990e6237 = self playsound(localclientnum, var_c776e9e4);
            while (soundplaying(var_990e6237)) {
                waitframe(1);
            }
            wait randomfloat(1);
        }
        waitframe(1);
    }
}

