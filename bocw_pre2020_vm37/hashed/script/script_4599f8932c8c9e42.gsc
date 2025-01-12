#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace ray_gun;

// Namespace ray_gun/namespace_b7964db5
// Params 0, eflags: 0x6
// Checksum 0x29f9c056, Offset: 0x88
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"ray_gun", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace ray_gun/namespace_b7964db5
// Params 0, eflags: 0x1 linked
// Checksum 0x99118b21, Offset: 0xd8
// Size: 0x5c
function __init__() {
    if (!sessionmodeiscampaigngame() && !sessionmodeiszombiesgame()) {
        killstreaks::register_killstreak("killstreak_ray_gun", &killstreaks::function_fc82c544);
    }
}

