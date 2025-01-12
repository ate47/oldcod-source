#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace dynent_use;

// Namespace dynent_use/dynent_use
// Params 0, eflags: 0x6
// Checksum 0x1d9c7687, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"dynent_use", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace dynent_use/dynent_use
// Params 0, eflags: 0x5 linked
// Checksum 0xa8653175, Offset: 0xe8
// Size: 0xa4
function private function_70a657d8() {
    if (!(isdefined(getgametypesetting(#"usabledynents")) ? getgametypesetting(#"usabledynents") : 0)) {
        return;
    }
    clientfield::register_clientuimodel("hudItems.dynentUseHoldProgress", #"hash_6f4b11a0bee9b73d", #"dynentuseholdprogress", 13000, 5, "float", undefined, 0, 0);
}

