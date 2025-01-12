#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_homunculus;

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x2
// Checksum 0x83f8a70a, Offset: 0x118
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_weap_homunculus", &__init__, &__main__, undefined);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0xf9d4d41d, Offset: 0x168
// Size: 0xb4
function __init__() {
    clientfield::register("scriptmover", "" + #"hash_2d49d2cf3d339e18", 1, 1, "int", &function_d2288418, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_32c5838be960cfee", 1, 1, "int", &function_f6cc84b5, 0, 0);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0xed4bd8cc, Offset: 0x228
// Size: 0x30
function __main__() {
    if (!zm_weapons::is_weapon_included(getweapon("homunculus"))) {
        return;
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 7, eflags: 0x0
// Checksum 0x750a3850, Offset: 0x260
// Size: 0xb4
function function_d2288418(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        v_up = (360, 0, 0);
        v_forward = (0, 0, 360);
        playfx(localclientnum, "zm_weapons/fx8_equip_homunc_death_exp", self gettagorigin("j_spinelower"), v_forward, v_up);
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 7, eflags: 0x0
// Checksum 0x16285e37, Offset: 0x320
// Size: 0xc4
function function_f6cc84b5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        v_up = (360, 0, 0);
        v_forward = (0, 0, 360);
        playfx(localclientnum, "zm_weapons/fx8_equip_homunc_spawn", self.origin, v_forward, v_up);
        self playsound(localclientnum, #"hash_21206f1b7fb27f81");
    }
}

