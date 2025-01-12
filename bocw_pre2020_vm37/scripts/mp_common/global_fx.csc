#using scripts\core_common\system_shared;

#namespace global_fx;

// Namespace global_fx/global_fx
// Params 0, eflags: 0x6
// Checksum 0xbb4a8556, Offset: 0x68
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"global_fx", &function_70a657d8, &main, undefined, undefined);
}

// Namespace global_fx/global_fx
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0xc0
// Size: 0x4
function private function_70a657d8() {
    
}

// Namespace global_fx/global_fx
// Params 0, eflags: 0x1 linked
// Checksum 0xb330c12a, Offset: 0xd0
// Size: 0x14
function main() {
    check_for_wind_override();
}

// Namespace global_fx/global_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x32ffc891, Offset: 0xf0
// Size: 0x28
function check_for_wind_override() {
    if (isdefined(level.custom_wind_callback)) {
        level thread [[ level.custom_wind_callback ]]();
    }
}

