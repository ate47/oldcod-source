#using scripts\core_common\system_shared;
#using scripts\killstreaks\remotemissile_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;

#namespace remotemissile;

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x2
// Checksum 0x456cd7d8, Offset: 0xc8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"remotemissile", &__init__, undefined, #"killstreaks");
}

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x0
// Checksum 0x8c701874, Offset: 0x118
// Size: 0x5e
function __init__() {
    init_shared();
    level.var_4ac15ffa = &function_4ac15ffa;
    level.var_f32b1ce9 = &function_f32b1ce9;
    level.var_32e3865c = &function_32e3865c;
}

// Namespace remotemissile/remotemissile
// Params 2, eflags: 0x0
// Checksum 0x1446c90f, Offset: 0x180
// Size: 0x54
function function_4ac15ffa(killstreak_id, team) {
    if (!isdefined(self.currentkillstreakdialog) && isdefined(level.var_602d80f2)) {
        self thread [[ level.var_602d80f2 ]]("callInRemoteMissile", "callInFutzRemoteMissile");
    }
}

// Namespace remotemissile/remotemissile
// Params 1, eflags: 0x0
// Checksum 0x5524e37, Offset: 0x1e0
// Size: 0x180
function function_f32b1ce9(rocket) {
    self endon(#"remotemissile_done");
    rocket endon(#"death");
    var_75813f86 = 0;
    while (!var_75813f86) {
        enemy = self.owner battlechatter::get_closest_player_enemy(self.origin, 1);
        if (!isdefined(enemy)) {
            return 0;
        }
        eyepoint = enemy geteye();
        relativepos = vectornormalize(self.origin - eyepoint);
        dir = anglestoforward(enemy getplayerangles());
        dotproduct = vectordot(relativepos, dir);
        if (dotproduct > 0 && sighttracepassed(self.origin, eyepoint, 1, enemy, self)) {
            enemy thread battlechatter::play_killstreak_threat("remote_missile");
            var_75813f86 = 1;
        }
        wait 0.1;
    }
}

// Namespace remotemissile/remotemissile
// Params 2, eflags: 0x0
// Checksum 0x70791408, Offset: 0x368
// Size: 0x34
function function_32e3865c(attacker, weapon) {
    attacker battlechatter::function_b5530e2c("remote_missile", weapon);
}

