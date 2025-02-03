#using scripts\core_common\system_shared;

#namespace global_fx;

// Namespace global_fx/global_fx
// Params 0, eflags: 0x6
// Checksum 0x6bd834bc, Offset: 0x68
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"global_fx", &preinit, &main, undefined, undefined);
}

// Namespace global_fx/global_fx
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xc0
// Size: 0x4
function private preinit() {
    
}

// Namespace global_fx/global_fx
// Params 0, eflags: 0x0
// Checksum 0xac04f97f, Offset: 0xd0
// Size: 0x24
function main() {
    function_94923bb0();
    check_for_wind_override();
}

// Namespace global_fx/global_fx
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x100
// Size: 0x4
function function_94923bb0() {
    
}

// Namespace global_fx/global_fx
// Params 0, eflags: 0x0
// Checksum 0xa26364bf, Offset: 0x110
// Size: 0x28
function check_for_wind_override() {
    if (isdefined(level.custom_wind_callback)) {
        level thread [[ level.custom_wind_callback ]]();
    }
}

