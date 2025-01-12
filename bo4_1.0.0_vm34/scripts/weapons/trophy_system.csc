#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x927cb83d, Offset: 0xb0
// Size: 0x94
function init_shared() {
    clientfield::register("missile", "trophy_system_state", 1, 2, "int", &trophy_state_change, 0, 0);
    clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int", &trophy_state_change_recon, 0, 0);
}

// Namespace trophy_system/trophy_system
// Params 7, eflags: 0x0
// Checksum 0x2d5e58e4, Offset: 0x150
// Size: 0xca
function trophy_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        self thread trophy_rolling_anim(localclientnum);
        break;
    case 2:
        self thread trophy_stationary_anim(localclientnum);
        break;
    case 3:
        break;
    case 0:
        break;
    }
}

// Namespace trophy_system/trophy_system
// Params 7, eflags: 0x0
// Checksum 0x7d396dac, Offset: 0x228
// Size: 0xca
function trophy_state_change_recon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        self thread trophy_rolling_anim(localclientnum);
        break;
    case 2:
        self thread trophy_stationary_anim(localclientnum);
        break;
    case 3:
        break;
    case 0:
        break;
    }
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x96eb82cb, Offset: 0x300
// Size: 0x7c
function trophy_rolling_anim(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self useanimtree("generic");
    self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 1);
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x156f5d7c, Offset: 0x388
// Size: 0xa4
function trophy_stationary_anim(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self useanimtree("generic");
    self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 0);
    self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_open_anim", 1);
}

