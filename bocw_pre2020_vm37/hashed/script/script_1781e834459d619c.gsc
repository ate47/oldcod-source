#using script_1cc417743d7c262d;
#using script_5312dbb58ee628a8;
#using scripts\core_common\battlechatter;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;

#namespace missile_turret;

// Namespace missile_turret/missile_turret
// Params 0, eflags: 0x6
// Checksum 0x439053e2, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"missile_turret", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace missile_turret/missile_turret
// Params 0, eflags: 0x5 linked
// Checksum 0x2905533b, Offset: 0xf0
// Size: 0x44
function private function_70a657d8() {
    level.var_1c5940ad = &function_4b645b3f;
    level.var_2958ac6c = &turret_destroyed;
    init_shared();
}

// Namespace missile_turret/missile_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xdebd7c79, Offset: 0x140
// Size: 0x2c
function function_4b645b3f(killstreaktype) {
    self globallogic_audio::play_taacom_dialog("timeout", killstreaktype);
}

// Namespace missile_turret/missile_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x6a9f1493, Offset: 0x178
// Size: 0x66
function turret_destroyed(attacker, weapon) {
    profilestart();
    if (isdefined(attacker)) {
        attacker battlechatter::function_eebf94f6("missile_turret", weapon);
        attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
    }
    profilestop();
}

