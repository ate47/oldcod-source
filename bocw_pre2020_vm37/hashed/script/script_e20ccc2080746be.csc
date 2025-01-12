#using scripts\core_common\util_shared;

#namespace namespace_4914de7c;

// Namespace namespace_4914de7c/level_init
// Params 1, eflags: 0x40
// Checksum 0xc3253b0, Offset: 0x78
// Size: 0x2a
function event_handler[level_init] main(*eventstruct) {
    if (util::get_map_name() !== "wz_russia") {
        return;
    }
}

