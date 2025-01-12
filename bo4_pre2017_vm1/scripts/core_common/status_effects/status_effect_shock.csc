#using scripts/core_common/clientfield_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace status_effect_shock;

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x2
// Checksum 0x312ababe, Offset: 0x168
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("status_effect_shock", &__init__, undefined, undefined);
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x44c62dd2, Offset: 0x1a8
// Size: 0x4c
function __init__() {
    clientfield::register("toplayer", "shocked", 1, 1, "int", &function_a1a17f4, 0, 0);
}

// Namespace status_effect_shock/status_effect_shock
// Params 7, eflags: 0x0
// Checksum 0xd5b27911, Offset: 0x200
// Size: 0xa4
function function_a1a17f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = getlocalplayer(localclientnum);
    if (newval == 1) {
        self function_bc45922b(localplayer);
        return;
    }
    self function_cc911409(localplayer);
}

// Namespace status_effect_shock/status_effect_shock
// Params 1, eflags: 0x0
// Checksum 0x3822e1ea, Offset: 0x2b0
// Size: 0x48
function function_bc45922b(localplayer) {
    self endon(#"hash_d7814286");
    while (true) {
        localplayer thread postfx::playpostfxbundle("pstfx_shock_charge");
        wait 0.65;
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 1, eflags: 0x0
// Checksum 0x46778dcd, Offset: 0x300
// Size: 0x34
function function_cc911409(localplayer) {
    self notify(#"hash_d7814286");
    localplayer thread postfx::stoppostfxbundle();
}

