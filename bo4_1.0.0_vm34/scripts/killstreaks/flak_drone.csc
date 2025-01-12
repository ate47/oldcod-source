#using scripts\core_common\clientfield_shared;
#using scripts\core_common\duplicaterender_mgr;

#namespace flak_drone;

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x0
// Checksum 0x7a3a9c70, Offset: 0xd8
// Size: 0x64
function init_shared() {
    if (!isdefined(level.var_a0df44ac)) {
        level.var_a0df44ac = {};
        clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int", &active_camo_changed, 0, 0);
    }
}

// Namespace flak_drone/flak_drone
// Params 7, eflags: 0x0
// Checksum 0xbb79998a, Offset: 0x148
// Size: 0x114
function active_camo_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    flags_changed = self duplicate_render::set_dr_flag("active_camo_flicker", newval == 2);
    flags_changed = self duplicate_render::set_dr_flag("active_camo_on", 0) || flags_changed;
    flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 1) || flags_changed;
    if (flags_changed) {
        self duplicate_render::update_dr_filters(localclientnum);
    }
    self notify(#"endtest");
    self thread doreveal(localclientnum, newval != 0);
}

// Namespace flak_drone/flak_drone
// Params 2, eflags: 0x0
// Checksum 0xaa2b001b, Offset: 0x268
// Size: 0x15c
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
    flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 0);
    flags_changed = self duplicate_render::set_dr_flag("active_camo_on", direction) || flags_changed;
    if (flags_changed) {
        self duplicate_render::update_dr_filters(localclientnum);
    }
}

