#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace replay_gun;

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x2
// Checksum 0x6ebf3001, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("replay_gun", &__init__, undefined, undefined);
}

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x0
// Checksum 0xb6db506b, Offset: 0x240
// Size: 0x4c
function __init__() {
    level thread player_init();
    duplicate_render::set_dr_filter_offscreen("replay", 75, "replay_locked", undefined, 2, "mc/hud_outline_model_red", 0);
}

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x0
// Checksum 0x8933e59b, Offset: 0x298
// Size: 0xc2
function player_init() {
    util::waitforclient(0);
    players = getlocalplayers();
    foreach (player in players) {
        player thread watch_lockon(0);
    }
}

// Namespace replay_gun/replay_gun
// Params 1, eflags: 0x0
// Checksum 0xa335e339, Offset: 0x368
// Size: 0x1c2
function watch_lockon(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill("lockon_changed");
        state = waitresult.state;
        target = waitresult.target;
        if (!isdefined(target) || isdefined(self.replay_lock) && self.replay_lock != target) {
            self.replay_lock duplicate_render::change_dr_flags(localclientnum, undefined, "replay_locked");
            self.replay_lock = undefined;
        }
        if ((target isplayer() || isdefined(target) && target isai()) && isalive(target)) {
            switch (state) {
            case 0:
            case 1:
            case 3:
                target duplicate_render::change_dr_flags(localclientnum, undefined, "replay_locked");
                break;
            case 2:
            case 4:
                target duplicate_render::change_dr_flags(localclientnum, "replay_locked", undefined);
                self.replay_lock = target;
                break;
            }
        }
    }
}

