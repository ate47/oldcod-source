#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace warmachine;

// Namespace warmachine/warmachine
// Params 0, eflags: 0x6
// Checksum 0xf9f241f3, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"warmachine", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace warmachine/warmachine
// Params 0, eflags: 0x1 linked
// Checksum 0x1c3ada5a, Offset: 0xe0
// Size: 0x3c
function __init__() {
    if (!sessionmodeiscampaigngame()) {
        killstreaks::register_killstreak("killstreak_warmachine", &killstreaks::function_fc82c544);
    }
}

