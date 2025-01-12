#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_powerups;

#namespace frag_grenade;

// Namespace frag_grenade/zm_weap_frag_grenade
// Params 0, eflags: 0x6
// Checksum 0x74dc7553, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"frag_grenade", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace frag_grenade/zm_weap_frag_grenade
// Params 0, eflags: 0x5 linked
// Checksum 0x40a1bf8d, Offset: 0xf0
// Size: 0x94
function private function_70a657d8() {
    zm::function_84d343d(#"eq_frag_grenade", &function_719b774a);
    zm::function_84d343d(#"eq_frag_grenade_extra", &function_719b774a);
    zm::function_84d343d(#"frag_grenade", &function_719b774a);
}

// Namespace frag_grenade/zm_weap_frag_grenade
// Params 12, eflags: 0x1 linked
// Checksum 0x19775a98, Offset: 0x190
// Size: 0x82
function function_719b774a(*inflictor, *attacker, damage, *flags, meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (surfacetype === "MOD_IMPACT") {
        return 0;
    }
    return boneindex;
}

