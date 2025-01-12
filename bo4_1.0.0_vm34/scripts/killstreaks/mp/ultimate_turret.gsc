#using scripts\core_common\system_shared;
#using scripts\killstreaks\ultimate_turret_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;

#namespace ultimate_turret;

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x2
// Checksum 0x37acffc7, Offset: 0xa0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"ultimate_turret", &__init__, undefined, #"killstreaks");
}

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x0
// Checksum 0xaac8a31, Offset: 0xf0
// Size: 0x4c
function __init__() {
    level.var_383a5cc9 = &function_4c30d886;
    level.var_7d3194e = &turret_destroyed;
    init_shared();
}

// Namespace ultimate_turret/ultimate_turret
// Params 1, eflags: 0x0
// Checksum 0x1a41c83f, Offset: 0x148
// Size: 0x2c
function function_4c30d886(killstreaktype) {
    self globallogic_audio::play_taacom_dialog("timeout", killstreaktype);
}

// Namespace ultimate_turret/ultimate_turret
// Params 2, eflags: 0x0
// Checksum 0x338145d9, Offset: 0x180
// Size: 0x34
function turret_destroyed(attacker, weapon) {
    attacker battlechatter::function_b5530e2c("ultimate_turret", weapon);
}

