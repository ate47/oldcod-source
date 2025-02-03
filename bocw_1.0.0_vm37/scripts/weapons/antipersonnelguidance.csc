#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace antipersonnel_guidance;

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 0, eflags: 0x6
// Checksum 0xabaf8e7, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"antipersonnel_guidance", &preinit, undefined, undefined, undefined);
}

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 0, eflags: 0x4
// Checksum 0xd552577f, Offset: 0xb8
// Size: 0x1c
function private preinit() {
    level thread player_init();
}

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0xd4044be0, Offset: 0xe0
// Size: 0xb8
function player_init() {
    util::waitforclient(0);
    players = getlocalplayers();
    foreach (player in players) {
        player thread watch_lockon(0);
    }
}

// Namespace antipersonnel_guidance/antipersonnelguidance
// Params 1, eflags: 0x0
// Checksum 0x72407bed, Offset: 0x1a0
// Size: 0x12e
function watch_lockon(*localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"lockon_changed");
        target = waitresult.target;
        state = waitresult.state;
        if (isdefined(self.replay_lock) && (!isdefined(target) || self.replay_lock != target)) {
            self.ap_lock = undefined;
        }
        switch (state) {
        case 0:
        case 1:
        case 3:
            break;
        case 2:
        case 4:
            self.ap_lock = target;
            break;
        }
    }
}

