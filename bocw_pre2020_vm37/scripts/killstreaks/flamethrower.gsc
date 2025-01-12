#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace flamethrower;

// Namespace flamethrower/flamethrower
// Params 0, eflags: 0x6
// Checksum 0x7fd20c0, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"flamethrower", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace flamethrower/flamethrower
// Params 0, eflags: 0x1 linked
// Checksum 0xbd41cd8f, Offset: 0xe0
// Size: 0x3c
function __init__() {
    if (!sessionmodeiscampaigngame()) {
        killstreaks::register_killstreak("killstreak_flamethrower", &killstreaks::function_fc82c544);
    }
}

