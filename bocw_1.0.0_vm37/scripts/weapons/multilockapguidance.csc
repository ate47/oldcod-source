#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace antipersonnel_guidance;

// Namespace antipersonnel_guidance/multilockapguidance
// Params 0, eflags: 0x6
// Checksum 0x72a78407, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"multilockap_guidance", &preinit, undefined, undefined, undefined);
}

// Namespace antipersonnel_guidance/multilockapguidance
// Params 0, eflags: 0x4
// Checksum 0xd552577f, Offset: 0xb8
// Size: 0x1c
function private preinit() {
    level thread player_init();
}

// Namespace antipersonnel_guidance/multilockapguidance
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

// Namespace antipersonnel_guidance/multilockapguidance
// Params 1, eflags: 0x0
// Checksum 0xa4078e52, Offset: 0x1a0
// Size: 0x12e
function watch_lockon(*localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"lockon_changed");
        state = waitresult.state;
        target = waitresult.target;
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

