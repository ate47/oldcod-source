#using scripts\core_common\util_shared;

#namespace zm_maptable;

// Namespace zm_maptable/zm_maptable
// Params 0, eflags: 0x1 linked
// Checksum 0xba05d94d, Offset: 0x68
// Size: 0x66
function function_10672567() {
    if (!isdefined(level.maptableentry)) {
        mapname = util::get_map_name();
        fields = getmapfields(mapname);
        level.maptableentry = fields;
    }
    return level.maptableentry;
}

// Namespace zm_maptable/zm_maptable
// Params 0, eflags: 0x1 linked
// Checksum 0x8a58a562, Offset: 0xd8
// Size: 0x56
function get_cast() {
    cast = #"other";
    fields = function_10672567();
    if (isdefined(fields)) {
        cast = fields.cast;
    }
    return cast;
}

// Namespace zm_maptable/zm_maptable
// Params 0, eflags: 0x1 linked
// Checksum 0xc9ff2e49, Offset: 0x138
// Size: 0x42
function get_story() {
    var_26ea2807 = get_cast();
    if (var_26ea2807 === #"story1") {
        return 1;
    }
    return 2;
}

