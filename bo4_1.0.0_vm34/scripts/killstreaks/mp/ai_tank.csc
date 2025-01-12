#using scripts\core_common\system_shared;
#using scripts\killstreaks\ai_tank_shared;

#namespace ai_tank;

// Namespace ai_tank/ai_tank
// Params 0, eflags: 0x2
// Checksum 0xe1a866c6, Offset: 0x78
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"ai_tank", &__init__, undefined, #"killstreaks");
}

// Namespace ai_tank/ai_tank
// Params 0, eflags: 0x0
// Checksum 0x5d00c0b8, Offset: 0xc8
// Size: 0x14
function __init__() {
    init_shared();
}

