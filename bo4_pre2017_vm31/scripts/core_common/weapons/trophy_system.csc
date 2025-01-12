#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x14ade11d, Offset: 0x1d0
// Size: 0x9c
function init_shared(localclientnum) {
    clientfield::register("missile", "trophy_system_state", 1, 2, "int", &trophy_state_change, 0, 1);
    clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int", &trophy_state_change_recon, 0, 0);
}

// Namespace trophy_system/trophy_system
// Params 7, eflags: 0x0
// Checksum 0x4db2743e, Offset: 0x278
// Size: 0xe6
function trophy_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
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
// Checksum 0x88b3c3b, Offset: 0x368
// Size: 0xe6
function trophy_state_change_recon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
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
// Checksum 0xbd44d8d0, Offset: 0x458
// Size: 0x5c
function trophy_rolling_anim(localclientnum) {
    self endon(#"death");
    self useanimtree(#mp_trophy_system);
    self setanim(mp_trophy_system%o_trophy_deploy, 1);
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x7b5de679, Offset: 0x4c0
// Size: 0x84
function trophy_stationary_anim(localclientnum) {
    self endon(#"death");
    self useanimtree(#mp_trophy_system);
    self setanim(mp_trophy_system%o_trophy_deploy, 0);
    self setanim(mp_trophy_system%o_trophy_spin, 1);
}

