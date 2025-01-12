#using scripts\core_common\system_shared;
#using scripts\weapons\heatseekingmissile;

#namespace heatseekingmissile;

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x6
// Checksum 0x832d14a0, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"heatseekingmissile", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x5 linked
// Checksum 0x3f429e57, Offset: 0xb8
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

