#namespace map;

// Namespace map/map
// Params 0, eflags: 0x0
// Checksum 0x85ae0532, Offset: 0x60
// Size: 0x14
function init() {
    get_script_bundle();
}

// Namespace map/map
// Params 0, eflags: 0x1 linked
// Checksum 0x2f741977, Offset: 0x80
// Size: 0x72
function get_script_bundle() {
    if (!isdefined(level.var_427d6976)) {
        level.var_427d6976 = function_2717b55f();
    }
    if (!isdefined(level.var_427d6976)) {
        level.var_179eaba8 = 1;
        level.var_427d6976 = {};
    } else {
        level.var_179eaba8 = 0;
    }
    return level.var_427d6976;
}

// Namespace map/map
// Params 0, eflags: 0x0
// Checksum 0xc32325ef, Offset: 0x100
// Size: 0x2e
function is_default() {
    if (!isdefined(level.var_179eaba8)) {
        level.var_179eaba8 = 1;
    }
    return level.var_179eaba8;
}

