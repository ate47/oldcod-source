#using scripts\core_common\clientfield_shared;

#namespace flak_drone;

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x0
// Checksum 0x2776be91, Offset: 0xa0
// Size: 0x64
function init_shared() {
    if (!isdefined(level.var_5460023b)) {
        level.var_5460023b = {};
        clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int", &active_camo_changed, 0, 0);
    }
}

// Namespace flak_drone/flak_drone
// Params 7, eflags: 0x0
// Checksum 0x986dbab2, Offset: 0x110
// Size: 0x6c
function active_camo_changed(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify(#"endtest");
    self thread doreveal(fieldname, bwastimejump != 0);
}

// Namespace flak_drone/flak_drone
// Params 2, eflags: 0x0
// Checksum 0x4b7ef993, Offset: 0x188
// Size: 0xea
function doreveal(localclientnum, direction) {
    self notify(#"endtest");
    self endon(#"endtest");
    self endon(#"death");
    if (direction) {
        startval = 1;
    } else {
        startval = 0;
    }
    while (startval >= 0 && startval <= 1) {
        self mapshaderconstant(localclientnum, 0, "scriptVector0", startval, 0, 0, 0);
        if (direction) {
            startval -= 0.032;
        } else {
            startval += 0.032;
        }
        waitframe(1);
    }
}

