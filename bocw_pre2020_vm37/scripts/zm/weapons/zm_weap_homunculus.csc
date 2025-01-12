#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_homunculus;

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x6
// Checksum 0xcdeb4801, Offset: 0x110
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_weap_homunculus", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x5 linked
// Checksum 0xcd80c191, Offset: 0x168
// Size: 0xb4
function private function_70a657d8() {
    clientfield::register("scriptmover", "" + #"hash_2d49d2cf3d339e18", 1, 1, "int", &function_6fcc4908, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_32c5838be960cfee", 1, 1, "int", &function_3e362ad8, 0, 0);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x5 linked
// Checksum 0x9837c517, Offset: 0x228
// Size: 0x38
function private postinit() {
    if (!zm_weapons::is_weapon_included(getweapon(#"homunculus"))) {
        return;
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 7, eflags: 0x1 linked
// Checksum 0x47299e16, Offset: 0x268
// Size: 0xdc
function function_6fcc4908(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && isdefined(self)) {
        v_up = (360, 0, 0);
        v_forward = (0, 0, 360);
        origin = self gettagorigin("j_spinelower");
        if (!isdefined(origin)) {
            origin = self.origin;
        }
        playfx(fieldname, "zm_weapons/fx8_equip_homunc_death_exp", origin, v_forward, v_up);
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 7, eflags: 0x1 linked
// Checksum 0x930cef78, Offset: 0x350
// Size: 0xc4
function function_3e362ad8(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        v_up = (360, 0, 0);
        v_forward = (0, 0, 360);
        playfx(fieldname, "zm_weapons/fx8_equip_homunc_spawn", self.origin, v_forward, v_up);
        self playsound(fieldname, #"hash_21206f1b7fb27f81");
    }
}

