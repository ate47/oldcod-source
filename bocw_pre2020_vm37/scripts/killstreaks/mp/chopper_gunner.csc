#using script_4eecbd20dc9a462c;
#using scripts\core_common\system_shared;

#namespace chopper_gunner;

// Namespace chopper_gunner/chopper_gunner
// Params 0, eflags: 0x6
// Checksum 0x4a1fe6e6, Offset: 0x70
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"chopper_gunner", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace chopper_gunner/chopper_gunner
// Params 0, eflags: 0x5 linked
// Checksum 0xc69d7ecb, Offset: 0xc0
// Size: 0x14
function private function_70a657d8() {
    namespace_e8c18978::function_70a657d8();
}

