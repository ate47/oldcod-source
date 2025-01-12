#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace wz_jukebox;

// Namespace wz_jukebox/level_init
// Params 1, eflags: 0x40
// Checksum 0x8dd78d66, Offset: 0x90
// Size: 0xc
function event_handler[level_init] main(eventstruct) {
    
}

// Namespace wz_jukebox/event_57a8880c
// Params 1, eflags: 0x40
// Checksum 0x71dcf1a5, Offset: 0xa8
// Size: 0x8c
function event_handler[event_57a8880c] function_565a245e(eventstruct) {
    if (eventstruct.ent.targetname === "dynent_jukebox") {
        if (eventstruct.state == 1) {
            eventstruct.ent thread function_3d865ce2();
        }
        if (eventstruct.state == 3) {
            eventstruct.ent thread function_cd57a25a();
        }
    }
}

// Namespace wz_jukebox/wz_jukebox
// Params 0, eflags: 0x0
// Checksum 0x60bbc22f, Offset: 0x140
// Size: 0x24
function function_3d865ce2() {
    wait 2;
    function_9e7b6692(self, 2);
}

// Namespace wz_jukebox/wz_jukebox
// Params 0, eflags: 0x0
// Checksum 0x2be40a01, Offset: 0x170
// Size: 0x24
function function_cd57a25a() {
    wait 2;
    function_9e7b6692(self, 1);
}

