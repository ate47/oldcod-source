#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\mp_common\player\player_utils;

#namespace high_value_target;

// Namespace high_value_target/high_value_target
// Params 0, eflags: 0x6
// Checksum 0x2ddb1648, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"high_value_target", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace high_value_target/high_value_target
// Params 0, eflags: 0x5 linked
// Checksum 0x999009e3, Offset: 0xe8
// Size: 0x6c
function private function_70a657d8() {
    level.var_8d51c9b1 = getgametypesetting(#"hash_6141cddd96ac214e");
    callback::on_spawned(&onplayerspawned);
    player::function_cf3aa03d(&onplayerkilled);
}

// Namespace high_value_target/high_value_target
// Params 0, eflags: 0x1 linked
// Checksum 0xf7323cce, Offset: 0x160
// Size: 0xda
function onplayerspawned() {
    killstreakcount = isdefined(self.pers[#"cur_kill_streak"]) ? self.pers[#"cur_kill_streak"] : 0;
    if (killstreakcount < level.var_8d51c9b1) {
        if (self.ishvt !== 0) {
            self clientfield::set("high_value_target", 0);
            self.ishvt = 0;
        }
        return;
    }
    if (self.ishvt !== 1) {
        self clientfield::set("high_value_target", 1);
        self.ishvt = 1;
    }
}

// Namespace high_value_target/high_value_target
// Params 9, eflags: 0x1 linked
// Checksum 0x18130c55, Offset: 0x248
// Size: 0x24c
function onplayerkilled(*einflictor, attacker, *idamage, *smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    if (isdefined(psoffsettime) && isdefined(psoffsettime.pers[#"cur_kill_streak"])) {
        var_f5d993e3 = isdefined(psoffsettime.pers[#"cur_kill_streak"]) ? psoffsettime.pers[#"cur_kill_streak"] : 0;
        if (var_f5d993e3 >= level.var_8d51c9b1 && psoffsettime clientfield::get("high_value_target") !== 1) {
            psoffsettime clientfield::set("high_value_target", 1);
            psoffsettime.ishvt = 1;
        }
    }
    if (isdefined(self) && self.ishvt === 1) {
        if (isdefined(psoffsettime) && isplayer(psoffsettime) && psoffsettime hasperk(#"hash_1c40ade36b54ff8") && psoffsettime != self && psoffsettime.team != self.team) {
            var_13f7eb29 = self.pers[#"kill_streak_before_death"];
            if (!isdefined(var_13f7eb29) || var_13f7eb29 < level.var_8d51c9b1) {
                return;
            }
            if (var_13f7eb29 > 20) {
                scoreevent = #"hash_782e222fd957d953" + 20;
            } else {
                scoreevent = #"hash_782e222fd957d953" + var_13f7eb29;
            }
            scoreevents::processscoreevent(scoreevent, psoffsettime, self, deathanimduration);
        }
    }
}

