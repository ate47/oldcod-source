#namespace map;

// Namespace map/map
// Params 0, eflags: 0x0
// Checksum 0x492ca6aa, Offset: 0x68
// Size: 0x14
function init() {
    get_script_bundle();
}

// Namespace map/map
// Params 0, eflags: 0x0
// Checksum 0x5f365e53, Offset: 0x88
// Size: 0x6e
function get_script_bundle() {
    if (!isdefined(level.var_7045f0c9)) {
        level.var_7045f0c9 = function_e5892286();
    }
    if (!isdefined(level.var_7045f0c9)) {
        level.var_fb9dbc1b = 1;
        level.var_7045f0c9 = {};
    } else {
        level.var_fb9dbc1b = 0;
    }
    return level.var_7045f0c9;
}

// Namespace map/map
// Params 0, eflags: 0x0
// Checksum 0xe992b729, Offset: 0x100
// Size: 0x2a
function is_default() {
    if (!isdefined(level.var_fb9dbc1b)) {
        level.var_fb9dbc1b = 1;
    }
    return level.var_fb9dbc1b;
}

