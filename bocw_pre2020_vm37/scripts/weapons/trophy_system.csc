#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xbb0f18c1, Offset: 0xb8
// Size: 0x94
function init_shared() {
    clientfield::register("missile", "trophy_system_state", 1, 2, "int", &trophy_state_change, 0, 0);
    clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int", &trophy_state_change_recon, 0, 0);
}

// Namespace trophy_system/trophy_system
// Params 7, eflags: 0x0
// Checksum 0xefaff054, Offset: 0x158
// Size: 0xca
function trophy_state_change(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 1:
        self thread trophy_rolling_anim(fieldname);
        break;
    case 2:
        self thread trophy_stationary_anim(fieldname);
        break;
    case 3:
        break;
    case 0:
        break;
    }
}

// Namespace trophy_system/trophy_system
// Params 7, eflags: 0x0
// Checksum 0x6f5f76c4, Offset: 0x230
// Size: 0xca
function trophy_state_change_recon(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 1:
        self thread trophy_rolling_anim(fieldname);
        break;
    case 2:
        self thread trophy_stationary_anim(fieldname);
        break;
    case 3:
        break;
    case 0:
        break;
    }
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x133b369, Offset: 0x308
// Size: 0x7c
function trophy_rolling_anim(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self useanimtree("generic");
    self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 1);
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xd7a4a9db, Offset: 0x390
// Size: 0xa4
function trophy_stationary_anim(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self useanimtree("generic");
    self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 0);
    self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_open_anim", 1);
}

