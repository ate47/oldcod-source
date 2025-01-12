#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace antipersonnel_guidance;

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 0, eflags: 0x2
// Checksum 0x990cf2fb, Offset: 0x210
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("antipersonnel_guidance", &__init__, undefined, undefined);
}

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0xf48658f6, Offset: 0x250
// Size: 0x4c
function __init__() {
    level thread player_init();
    duplicate_render::set_dr_filter_offscreen("ap", 75, "ap_locked", undefined, 2, "mc/hud_outline_model_red", 0);
}

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0xf6c593ee, Offset: 0x2a8
// Size: 0xc2
function player_init() {
    util::waitforclient(0);
    players = getlocalplayers();
    foreach (player in players) {
        player thread watch_lockon(0);
    }
}

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 1, eflags: 0x0
// Checksum 0xca18b5c1, Offset: 0x378
// Size: 0x172
function watch_lockon(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill("lockon_changed");
        target = waitresult.target;
        state = waitresult.state;
        if (!isdefined(target) || isdefined(self.replay_lock) && self.replay_lock != target) {
            self.ap_lock duplicate_render::change_dr_flags(localclientnum, undefined, "ap_locked");
            self.ap_lock = undefined;
        }
        switch (state) {
        case 0:
        case 1:
        case 3:
            target duplicate_render::change_dr_flags(localclientnum, undefined, "ap_locked");
            break;
        case 2:
        case 4:
            target duplicate_render::change_dr_flags(localclientnum, "ap_locked", undefined);
            self.ap_lock = target;
            break;
        }
    }
}

