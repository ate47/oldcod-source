#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace scythe;

// Namespace scythe/scythe
// Params 0, eflags: 0x6
// Checksum 0x971721fa, Offset: 0x88
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"scythe", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace scythe/scythe
// Params 0, eflags: 0x1 linked
// Checksum 0xc3d049ad, Offset: 0xd8
// Size: 0x3c
function __init__() {
    if (!sessionmodeiscampaigngame()) {
        killstreaks::register_killstreak("killstreak_scythe", &killstreaks::function_fc82c544);
    }
}

