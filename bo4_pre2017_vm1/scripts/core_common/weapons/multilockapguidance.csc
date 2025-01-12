#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace antipersonnel_guidance;

// Namespace antipersonnel_guidance/multilockapguidance
// Params 0, eflags: 0x2
// Checksum 0xc7a8fd8, Offset: 0x208
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("multilockap_guidance", &__init__, undefined, undefined);
}

// Namespace antipersonnel_guidance/multilockapguidance
// Params 0, eflags: 0x0
// Checksum 0xe76b7193, Offset: 0x248
// Size: 0x4c
function __init__() {
    level thread player_init();
    duplicate_render::set_dr_filter_offscreen("ap", 75, "ap_locked", undefined, 2, "mc/hud_outline_model_red", 0);
}

// Namespace antipersonnel_guidance/multilockapguidance
// Params 0, eflags: 0x0
// Checksum 0xe70b1fe7, Offset: 0x2a0
// Size: 0xc2
function player_init() {
    util::waitforclient(0);
    players = getlocalplayers();
    foreach (player in players) {
        player thread watch_lockon(0);
    }
}

// Namespace antipersonnel_guidance/multilockapguidance
// Params 1, eflags: 0x0
// Checksum 0x805b5daa, Offset: 0x370
// Size: 0x172
function watch_lockon(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill("lockon_changed");
        state = waitresult.state;
        target = waitresult.target;
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

