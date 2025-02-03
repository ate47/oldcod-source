#using scripts\core_common\system_shared;
#using scripts\weapons\heatseekingmissile;

#namespace heatseekingmissile;

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x6
// Checksum 0x4a15fe6e, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"heatseekingmissile", &preinit, undefined, undefined, undefined);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x4
// Checksum 0x6a4b297c, Offset: 0xb8
// Size: 0x34
function private preinit() {
    level.lockoncloserange = 330;
    level.lockoncloseradiusscaler = 3;
    init_shared();
}

