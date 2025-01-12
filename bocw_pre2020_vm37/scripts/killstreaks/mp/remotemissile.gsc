#using script_396f7d71538c9677;
#using scripts\core_common\battlechatter;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\remotemissile_shared;

#namespace remotemissile;

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x6
// Checksum 0xc9957b03, Offset: 0xe8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"remotemissile", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x5 linked
// Checksum 0x7f666993, Offset: 0x138
// Size: 0x9c
function private function_70a657d8() {
    bundlename = "killstreak_remote_missile";
    if (sessionmodeiswarzonegame()) {
        bundlename += "_wz";
    }
    init_shared(bundlename);
    level.var_5951cb24 = &function_5951cb24;
    level.var_dab39bb8 = &function_dab39bb8;
    level.var_feddd85a = &function_feddd85a;
}

// Namespace remotemissile/remotemissile
// Params 2, eflags: 0x1 linked
// Checksum 0xac492577, Offset: 0x1e0
// Size: 0x3c
function function_5951cb24(*killstreak_id, *team) {
    self thread battlechatter::function_fff18afc("callInRemoteMissile", "callInFutzRemoteMissile");
}

// Namespace remotemissile/remotemissile
// Params 1, eflags: 0x1 linked
// Checksum 0x7dad5ea5, Offset: 0x228
// Size: 0x180
function function_dab39bb8(rocket) {
    self endon(#"remotemissile_done");
    rocket endon(#"death");
    var_b5e50364 = 0;
    while (!var_b5e50364) {
        enemy = self.owner battlechatter::get_closest_player_enemy(self.origin, 1);
        if (!isdefined(enemy)) {
            return;
        }
        eyepoint = enemy geteye();
        relativepos = vectornormalize(self.origin - eyepoint);
        dir = anglestoforward(enemy getplayerangles());
        dotproduct = vectordot(relativepos, dir);
        if (dotproduct > 0 && sighttracepassed(self.origin, eyepoint, 1, enemy, self)) {
            enemy thread battlechatter::playkillstreakthreat("remote_missile");
            var_b5e50364 = 1;
        }
        wait 0.1;
    }
}

// Namespace remotemissile/remotemissile
// Params 2, eflags: 0x1 linked
// Checksum 0x56084563, Offset: 0x3b0
// Size: 0x34
function function_feddd85a(attacker, *weapon) {
    weapon battlechatter::function_eebf94f6("remote_missile");
}

