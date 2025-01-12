#using scripts\core_common\lui_shared;

#namespace zm_location;

// Namespace zm_location
// Method(s) 7 Total 13
class czm_location : cluielem {

    // Namespace czm_location/zm_location
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7ee0b716, Offset: 0x420
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_location/zm_location
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfa5755ba, Offset: 0x3a0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_location");
    }

    // Namespace czm_location/zm_location
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9d720094, Offset: 0x348
    // Size: 0x4c
    function setup_clientfields(*var_5c0f4d11) {
        cluielem::setup_clientfields("zm_location");
        cluielem::function_dcb34c80("string", "location_name", 1);
    }

    // Namespace czm_location/zm_location
    // Params 2, eflags: 0x1 linked
    // Checksum 0x61a01ee6, Offset: 0x450
    // Size: 0x30
    function set_location_name(localclientnum, value) {
        set_data(localclientnum, "location_name", value);
    }

    // Namespace czm_location/zm_location
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa4828d63, Offset: 0x3c8
    // Size: 0x4c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "location_name", #"");
    }

}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x1 linked
// Checksum 0x71d06e51, Offset: 0xc0
// Size: 0x176
function register(var_5c0f4d11) {
    elem = new czm_location();
    [[ elem ]]->setup_clientfields(var_5c0f4d11);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_location"])) {
        level.var_ae746e8f[#"zm_location"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_location"])) {
        level.var_ae746e8f[#"zm_location"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_location"])) {
        level.var_ae746e8f[#"zm_location"] = array(level.var_ae746e8f[#"zm_location"]);
    }
    level.var_ae746e8f[#"zm_location"][level.var_ae746e8f[#"zm_location"].size] = elem;
}

// Namespace zm_location/zm_location
// Params 0, eflags: 0x0
// Checksum 0x88311eaa, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new czm_location();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0x4d68e832, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0x81a2f072, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0x26f3c122, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_location/zm_location
// Params 2, eflags: 0x0
// Checksum 0x825af32e, Offset: 0x2f8
// Size: 0x28
function set_location_name(localclientnum, value) {
    [[ self ]]->set_location_name(localclientnum, value);
}

