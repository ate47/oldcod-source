#using scripts\core_common\util_shared;

#namespace zm_maptable;

// Namespace zm_maptable/zm_maptable
// Params 0, eflags: 0x0
// Checksum 0xd652b39, Offset: 0x70
// Size: 0x8e
function function_b710859c() {
    if (!isdefined(level.maptableentry)) {
        mapname = util::get_map_name();
        fields = getmapfields();
        /#
            if (!isdefined(fields)) {
                fields = getmapfields(mapname, "<dev string:x30>");
            }
        #/
        level.maptableentry = fields;
    }
    return level.maptableentry;
}

// Namespace zm_maptable/zm_maptable
// Params 0, eflags: 0x0
// Checksum 0xddcda98d, Offset: 0x108
// Size: 0x5a
function get_cast() {
    cast = #"other";
    fields = function_b710859c();
    if (isdefined(fields)) {
        cast = fields.cast;
    }
    return cast;
}

// Namespace zm_maptable/zm_maptable
// Params 0, eflags: 0x0
// Checksum 0x526f2a49, Offset: 0x170
// Size: 0x42
function get_story() {
    var_77cc3cb2 = get_cast();
    if (var_77cc3cb2 === #"story1") {
        return 1;
    }
    return 2;
}

