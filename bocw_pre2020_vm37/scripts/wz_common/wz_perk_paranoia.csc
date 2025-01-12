#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace wz_perk_paranoia;

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 0, eflags: 0x6
// Checksum 0x89fa0cd5, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_perk_paranoia", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 0, eflags: 0x5 linked
// Checksum 0x7c8b269c, Offset: 0x120
// Size: 0x64
function private function_70a657d8() {
    callback::function_930e5d42(&function_930e5d42);
    callback::on_spawned(&on_player_spawned);
    callback::on_killcam_begin(&on_killcam_begin);
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 1, eflags: 0x1 linked
// Checksum 0x125edd5b, Offset: 0x190
// Size: 0x24
function function_930e5d42(localclientnum) {
    self function_1c7e186f(localclientnum);
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 1, eflags: 0x1 linked
// Checksum 0xb52dd0d9, Offset: 0x1c0
// Size: 0x24
function on_player_spawned(localclientnum) {
    self function_1c7e186f(localclientnum);
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 1, eflags: 0x5 linked
// Checksum 0x7d2b93e2, Offset: 0x1f0
// Size: 0xa2
function private function_1c7e186f(localclientnum) {
    if (self == function_5c10bd79(localclientnum)) {
        var_369be743 = self hasperk(localclientnum, #"specialty_paranoia");
        var_7c49d38b = self.var_369be743 !== var_369be743;
        if (var_7c49d38b) {
            self thread function_3e9077b(localclientnum);
        }
        self.var_369be743 = var_369be743;
    }
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 1, eflags: 0x1 linked
// Checksum 0x8d0c0ccf, Offset: 0x2a0
// Size: 0x74
function on_killcam_begin(params) {
    if (level.gameended === 1) {
        if (isdefined(params.localclientnum)) {
            local_player = function_5c10bd79(params.localclientnum);
            local_player thread function_f2390c61(params.localclientnum);
        }
    }
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 1, eflags: 0x1 linked
// Checksum 0xaa97fa8e, Offset: 0x320
// Size: 0x64
function function_f2390c61(localclientnum) {
    wait 0.1;
    if (isdefined(self) && function_92beaa28(localclientnum)) {
        wait 1.5;
    }
    wait 0.1;
    if (isdefined(self)) {
        self function_3e9077b(localclientnum);
    }
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 0, eflags: 0x5 linked
// Checksum 0x71d59ae9, Offset: 0x390
// Size: 0x132
function private function_dbd63244() {
    assert(isplayer(self));
    if (self function_21c0fa55()) {
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
// Params 0, eflags: 0x5 linked
// Checksum 0xdefdb331, Offset: 0x4d0
// Size: 0x1a
function private function_c9d3a835() {
    return self.origin + (0, 0, 36);
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 1, eflags: 0x5 linked
// Checksum 0xceffcc08, Offset: 0x4f8
// Size: 0x9ee
function private function_3e9077b(localclientnum) {
    level endon(#"game_ended");
    self endon(#"disconnect", #"shutdown", #"death");
    self notify("64ab6e4ffb30d422");
    self endon("64ab6e4ffb30d422");
    var_5bc097ee = self hasperk(localclientnum, #"specialty_paranoia");
    var_81f254ba = cos(10);
    self function_c97460c6();
    while (true) {
        var_7cefa3dc = undefined;
        enemy_players = getenemyplayers(localclientnum, self.team, self.origin, 21600 + 15);
        foreach (player in enemy_players) {
            waitframe(1);
            if (!isdefined(player)) {
                continue;
            }
            if (!function_56e2eaa8(player)) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            if (is_true(player function_bee2bbc7())) {
                continue;
            }
            if (player hasperk(localclientnum, #"specialty_immuneparanoia")) {
                continue;
            }
            if (!is_true(player isplayerads())) {
                continue;
            }
            if (!var_5bc097ee && player.weapon.issniperweapon != 1) {
                continue;
            }
            player_eye_pos = player function_dbd63244();
            var_2cb75b52 = self function_c9d3a835();
            to_self = var_2cb75b52 - player_eye_pos;
            var_2c01c01e = lengthsquared(to_self);
            if (var_2c01c01e > function_a3f6cdac(21600)) {
                continue;
            }
            player_angles = player getplayerangles();
            player_forward = anglestoforward(player_angles);
            var_e1a2a16a = vectornormalize(to_self);
            if (vectordot(player_forward, var_e1a2a16a) < var_81f254ba) {
                continue;
            }
            var_2f138f98 = self function_dbd63244();
            var_7cd3af52 = angleclamp180(vectortopitch(var_2f138f98 + (0, 0, 20) - player_eye_pos));
            var_e909bde9 = angleclamp180(vectortopitch(self.origin - (0, 0, 10) - player_eye_pos));
            player_pitch = player_angles[0];
            var_6958d5cc = var_7cd3af52 <= player_pitch && player_pitch <= var_e909bde9;
            if (!var_6958d5cc) {
                /#
                    debug_line(player_eye_pos, player_eye_pos + vectorscale(player_forward, 21600), (1, 1, 0));
                #/
                continue;
            }
            var_9e9288e5 = (to_self[0], to_self[1], 0);
            var_77490c15 = vectornormalize(var_9e9288e5);
            var_8aea606c = vectorcross(var_77490c15, (0, 0, 1));
            var_fada11c4 = 15 + 20;
            var_f63b37c5 = vectorscale(var_8aea606c, var_fada11c4);
            var_ace65a4d = vectordot(vectornormalize(var_9e9288e5 + var_f63b37c5), var_77490c15);
            var_d885fce5 = vectornormalize((player_forward[0], player_forward[1], 0));
            var_cf2630c5 = vectordot(var_77490c15, var_d885fce5) > var_ace65a4d;
            if (!var_cf2630c5) {
                /#
                    debug_line(player_eye_pos, player_eye_pos + vectorscale(player_forward, 21600), (1, 1, 0));
                #/
                continue;
            }
            var_448a2e21 = undefined;
            trace_dist = length(to_self);
            trace_end = player_eye_pos + vectorscale(player_forward, trace_dist);
            trace = bullettrace(player_eye_pos, trace_end, 1, player);
            if (trace[#"fraction"] === 1) {
                var_448a2e21 = 1;
                /#
                    debug_line(player_eye_pos, trace_end, (0, 1, 0));
                #/
            } else {
                /#
                    debug_line(player_eye_pos, trace[#"position"], (1, 0, 0));
                #/
            }
            if (var_448a2e21 !== 1) {
                trace = bullettrace(player_eye_pos, var_2f138f98, 1, player);
                if (trace[#"fraction"] === 1) {
                    var_448a2e21 = 1;
                    /#
                        debug_line(player_eye_pos, var_2f138f98, (0, 1, 0));
                    #/
                } else {
                    /#
                        debug_line(player_eye_pos, trace[#"position"], (1, 0, 0));
                    #/
                    continue;
                }
            }
            if (var_448a2e21 === 1) {
                var_7cefa3dc = #"hash_73a3e9d9afd7f5b9";
                /#
                    debug_sphere(self.origin, 10, (0, 1, 0));
                #/
                break;
            }
        }
        if (getdvarint(#"hash_50e84a29a7fc192e", 0) == 0) {
            if (isdefined(var_7cefa3dc) && isdefined(player)) {
                if (var_2c01c01e >= function_a3f6cdac(2000) && player.weapon.issniperweapon === 1) {
                    var_32fc4c15 = player gettagorigin("tag_barrel");
                    if (isdefined(var_32fc4c15)) {
                        util::playfxontag(localclientnum, "lensflares/fx9_lf_sniper_glint", player, "tag_barrel");
                    }
                }
                if (var_5bc097ee) {
                    if (!is_true(player.var_1627fdd)) {
                        player.var_1627fdd = 1;
                        player playsound(localclientnum, #"hash_74faa2aaae4a8737");
                        player thread util::delay(15, "disconnect", &function_c97460c6);
                    }
                    var_2b836fea = player playsound(localclientnum, var_7cefa3dc);
                    self thread function_5de58e5(player, var_2b836fea);
                    while (soundplaying(var_2b836fea)) {
                        waitframe(1);
                    }
                    self notify(#"hash_3a0dfecf2b9bdcec");
                    wait randomfloat(1);
                } else {
                    wait randomfloatrange(5, 7);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 0, eflags: 0x5 linked
// Checksum 0x3ed5868c, Offset: 0xef0
// Size: 0xe
function private function_c97460c6() {
    self.var_1627fdd = 0;
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 2, eflags: 0x5 linked
// Checksum 0x5aa68e09, Offset: 0xf08
// Size: 0x7e
function private function_5de58e5(player, var_2b836fea) {
    self endon(#"hash_3a0dfecf2b9bdcec");
    util::waittill_any_ents_two(self, "death", player, "death");
    stopsound(var_2b836fea);
    if (isdefined(self)) {
        self.var_1627fdd = 0;
    }
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 3, eflags: 0x4
// Checksum 0x4cec9ff9, Offset: 0xf90
// Size: 0x6c
function private debug_line(start, end, color) {
    if (getdvarint(#"hash_50e84a29a7fc192e", 0) == 1) {
        /#
            line(start, end, color, 0.75, 0, 1);
        #/
    }
}

// Namespace wz_perk_paranoia/wz_perk_paranoia
// Params 3, eflags: 0x4
// Checksum 0x22fc22ce, Offset: 0x1008
// Size: 0x74
function private debug_sphere(origin, radius, color) {
    if (getdvarint(#"hash_50e84a29a7fc192e", 0) == 1) {
        /#
            sphere(origin, radius, color, 0.95, 0, 20, 1);
        #/
    }
}

