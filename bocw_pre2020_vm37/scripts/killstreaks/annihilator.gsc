#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace annihilator;

// Namespace annihilator/annihilator
// Params 0, eflags: 0x6
// Checksum 0x7c780ee8, Offset: 0xa0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"annihilator", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace annihilator/annihilator
// Params 0, eflags: 0x1 linked
// Checksum 0xda812586, Offset: 0xf0
// Size: 0x3c
function __init__() {
    if (!sessionmodeiscampaigngame()) {
        killstreaks::register_killstreak("killstreak_annihilator", &killstreaks::function_fc82c544);
    }
}

