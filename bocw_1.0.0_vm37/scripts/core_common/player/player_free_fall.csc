#using script_7ca3324ffa5389e4;
#using scripts\core_common\animation_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace player_free_fall;

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x6
// Checksum 0xc904184, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_free_fall", &preinit, undefined, undefined, undefined);
}

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xe0
// Size: 0x4
function private preinit() {
    
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0x76635b96, Offset: 0xf0
// Size: 0x56
function private function_c9a18304(*eventstruct) {
    if (!(isplayer(self) || self isplayercorpse())) {
        return;
    }
    if (self function_21c0fa55()) {
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0xce7b8bb8, Offset: 0x150
// Size: 0x56
function private function_26d46af3(*eventstruct) {
    if (!(isplayer(self) || self isplayercorpse())) {
        return;
    }
    if (self function_21c0fa55()) {
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0xe8348104, Offset: 0x1b0
// Size: 0x3e
function private function_f99c2453(*eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    if (self function_21c0fa55()) {
    }
}

