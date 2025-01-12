#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace player_reinsertion;

// Namespace player_reinsertion/player_reinsertion
// Params 0, eflags: 0x6
// Checksum 0xb7edada, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_reinsertion", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace player_reinsertion/player_reinsertion
// Params 0, eflags: 0x4
// Checksum 0xc6ddfd64, Offset: 0xb8
// Size: 0x18
function private function_70a657d8() {
    if (level.var_f2814a96 !== 0) {
        return;
    }
}

