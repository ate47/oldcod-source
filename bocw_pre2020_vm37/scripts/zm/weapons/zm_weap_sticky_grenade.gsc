#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_equipment;

#namespace sticky_grenade;

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 0, eflags: 0x6
// Checksum 0x9ef5d3d3, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"sticky_grenade", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 0, eflags: 0x5 linked
// Checksum 0x8788830d, Offset: 0xd8
// Size: 0x64
function private function_70a657d8() {
    zm::function_84d343d(#"eq_acid_bomb", &function_140f2522);
    zm::function_84d343d(#"eq_acid_bomb_extra", &function_140f2522);
}

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 12, eflags: 0x1 linked
// Checksum 0x6fb63ea2, Offset: 0x148
// Size: 0x82
function function_140f2522(*inflictor, *attacker, damage, *flags, meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (surfacetype === "MOD_IMPACT") {
        return 0;
    }
    return boneindex;
}

