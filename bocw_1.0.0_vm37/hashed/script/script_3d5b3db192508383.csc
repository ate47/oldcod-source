#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace dynent_use;

// Namespace dynent_use/dynent_use
// Params 0, eflags: 0x6
// Checksum 0xd4a49c49, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"dynent_use", &preinit, undefined, undefined, undefined);
}

// Namespace dynent_use/dynent_use
// Params 0, eflags: 0x4
// Checksum 0xdc770052, Offset: 0xe8
// Size: 0xa4
function private preinit() {
    if (!(isdefined(getgametypesetting(#"usabledynents")) ? getgametypesetting(#"usabledynents") : 0)) {
        return;
    }
    clientfield::register_clientuimodel("hudItems.dynentUseHoldProgress", #"hud_items", #"dynentuseholdprogress", 13000, 5, "float", undefined, 0, 0);
}

