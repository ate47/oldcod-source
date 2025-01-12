#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_cache_back;

// Namespace zm_bgb_cache_back/zm_bgb_cache_back
// Params 0, eflags: 0x2
// Checksum 0x4e38643b, Offset: 0x90
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_cache_back", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_cache_back/zm_bgb_cache_back
// Params 0, eflags: 0x0
// Checksum 0xfd7f0891, Offset: 0xe0
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_cache_back", "activated", 1, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_cache_back/zm_bgb_cache_back
// Params 0, eflags: 0x0
// Checksum 0xd7cf55d4, Offset: 0x150
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("full_ammo", undefined, 96);
}

