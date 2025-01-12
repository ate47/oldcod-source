#using script_1568a517f901b845;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace napalm_strike;

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x6
// Checksum 0x5451f2e0, Offset: 0xe8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"napalm_strike", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x5 linked
// Checksum 0xd24f3985, Offset: 0x138
// Size: 0x74
function private function_70a657d8() {
    init_shared("killstreak_napalm_strike" + "_zm");
    clientfield::register("scriptmover", "napalm_strike_marker_on", 1, 1, "int", &napalm_strike_marker_on, 0, 0);
}

// Namespace napalm_strike/napalm_strike
// Params 7, eflags: 0x1 linked
// Checksum 0x769dedb4, Offset: 0x1b8
// Size: 0xa4
function napalm_strike_marker_on(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.marker_fx = util::playfxontag(fieldname, #"hash_199c0d2d354d29f8", self, "tag_origin");
        return;
    }
    if (isdefined(self.marker_fx)) {
        stopfx(fieldname, self.marker_fx);
    }
}

