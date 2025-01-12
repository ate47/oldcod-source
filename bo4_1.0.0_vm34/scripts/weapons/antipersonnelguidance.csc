#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace antipersonnel_guidance;

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 0, eflags: 0x2
// Checksum 0x436497a2, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"antipersonnel_guidance", &__init__, undefined, undefined);
}

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0x2c6d1cfe, Offset: 0xf0
// Size: 0x4c
function __init__() {
    level thread player_init();
    duplicate_render::set_dr_filter_offscreen("ap", 75, "ap_locked", undefined, 2, "mc/hud_outline_model_red", 0);
}

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0xd91198e9, Offset: 0x148
// Size: 0xb0
function player_init() {
    util::waitforclient(0);
    players = getlocalplayers();
    foreach (player in players) {
        player thread watch_lockon(0);
    }
}

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 1, eflags: 0x0
// Checksum 0xbaccd48, Offset: 0x200
// Size: 0x196
function watch_lockon(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"lockon_changed");
        target = waitresult.target;
        state = waitresult.state;
        if (isdefined(self.replay_lock) && (!isdefined(target) || self.replay_lock != target)) {
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

