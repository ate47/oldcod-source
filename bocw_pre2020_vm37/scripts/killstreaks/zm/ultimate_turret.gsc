#using script_1cc417743d7c262d;
#using scripts\core_common\battlechatter;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\ultimate_turret_shared;

#namespace ultimate_turret;

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x6
// Checksum 0xab65224e, Offset: 0xa8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"ultimate_turret", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x5 linked
// Checksum 0x39cf9726, Offset: 0xf8
// Size: 0x44
function private function_70a657d8() {
    level.var_729a0937 = &function_4b645b3f;
    level.var_bbc796bf = &turret_destroyed;
    init_shared();
}

// Namespace ultimate_turret/ultimate_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x90de34f8, Offset: 0x148
// Size: 0x2c
function function_4b645b3f(killstreaktype) {
    self globallogic_audio::play_taacom_dialog("timeout", killstreaktype);
}

// Namespace ultimate_turret/ultimate_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x9c1c41ab, Offset: 0x180
// Size: 0x66
function turret_destroyed(attacker, weapon) {
    profilestart();
    if (isdefined(attacker)) {
        attacker battlechatter::function_eebf94f6("ultimate_turret", weapon);
        attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
    }
    profilestop();
}

