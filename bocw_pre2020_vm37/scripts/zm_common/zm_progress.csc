#using script_3a2fac1479c56997;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_progress;

// Namespace zm_progress/zm_progress
// Params 0, eflags: 0x6
// Checksum 0x26828550, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_progress", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_progress/zm_progress
// Params 0, eflags: 0x5 linked
// Checksum 0x7a3fff14, Offset: 0xd8
// Size: 0x14
function private function_70a657d8() {
    zm_build_progress::register();
}

