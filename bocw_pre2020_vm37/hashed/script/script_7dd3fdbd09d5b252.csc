#using scripts\core_common\lui_shared;

#namespace death_zone;

// Namespace death_zone
// Method(s) 7 Total 13
class cdeath_zone : cluielem {

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0x21f8c1b0, Offset: 0x410
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cdeath_zone/death_zone
    // Params 2, eflags: 0x0
    // Checksum 0xc271a4a3, Offset: 0x440
    // Size: 0x30
    function set_shutdown_sec(localclientnum, value) {
        set_data(localclientnum, "shutdown_sec", value);
    }

    // Namespace cdeath_zone/death_zone
    // Params 0, eflags: 0x0
    // Checksum 0x1682e5f4, Offset: 0x3a0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("death_zone");
    }

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0xfd605312, Offset: 0x348
    // Size: 0x4c
    function setup_clientfields(var_fd61f748) {
        cluielem::setup_clientfields("death_zone");
        cluielem::add_clientfield("shutdown_sec", 1, 9, "int", var_fd61f748);
    }

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0x5bc64015, Offset: 0x3c8
    // Size: 0x40
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "shutdown_sec", 0);
    }

}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x51bfca87, Offset: 0xc0
// Size: 0x176
function register(var_fd61f748) {
    elem = new cdeath_zone();
    [[ elem ]]->setup_clientfields(var_fd61f748);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"death_zone"])) {
        level.var_ae746e8f[#"death_zone"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"death_zone"])) {
        level.var_ae746e8f[#"death_zone"] = [];
    } else if (!isarray(level.var_ae746e8f[#"death_zone"])) {
        level.var_ae746e8f[#"death_zone"] = array(level.var_ae746e8f[#"death_zone"]);
    }
    level.var_ae746e8f[#"death_zone"][level.var_ae746e8f[#"death_zone"].size] = elem;
}

// Namespace death_zone/death_zone
// Params 0, eflags: 0x0
// Checksum 0x719fd356, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new cdeath_zone();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x2e22fc65, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0xd3bbab88, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x4e8764ec, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace death_zone/death_zone
// Params 2, eflags: 0x0
// Checksum 0x438f6664, Offset: 0x2f8
// Size: 0x28
function set_shutdown_sec(localclientnum, value) {
    [[ self ]]->set_shutdown_sec(localclientnum, value);
}

