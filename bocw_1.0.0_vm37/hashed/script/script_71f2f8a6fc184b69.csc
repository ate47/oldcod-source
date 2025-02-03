#using scripts\core_common\lui_shared;

#namespace insertion_passenger_count;

// Namespace insertion_passenger_count
// Method(s) 7 Total 14
class cinsertion_passenger_count : cluielem {

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0x8ffc2c76, Offset: 0x418
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 0, eflags: 0x0
    // Checksum 0x55447289, Offset: 0x3a8
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("insertion_passenger_count");
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0x75d621e5, Offset: 0x350
    // Size: 0x4c
    function setup_clientfields(var_fbcc4763) {
        cluielem::setup_clientfields("insertion_passenger_count");
        cluielem::add_clientfield("count", 1, 7, "int", var_fbcc4763);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 2, eflags: 0x0
    // Checksum 0xb5399297, Offset: 0x448
    // Size: 0x30
    function set_count(localclientnum, value) {
        set_data(localclientnum, "count", value);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0xf241e532, Offset: 0x3d0
    // Size: 0x40
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "count", 0);
    }

}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x8d15ea, Offset: 0xc8
// Size: 0x176
function register(var_fbcc4763) {
    elem = new cinsertion_passenger_count();
    [[ elem ]]->setup_clientfields(var_fbcc4763);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"insertion_passenger_count"])) {
        level.var_ae746e8f[#"insertion_passenger_count"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"insertion_passenger_count"])) {
        level.var_ae746e8f[#"insertion_passenger_count"] = [];
    } else if (!isarray(level.var_ae746e8f[#"insertion_passenger_count"])) {
        level.var_ae746e8f[#"insertion_passenger_count"] = array(level.var_ae746e8f[#"insertion_passenger_count"]);
    }
    level.var_ae746e8f[#"insertion_passenger_count"][level.var_ae746e8f[#"insertion_passenger_count"].size] = elem;
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 0, eflags: 0x0
// Checksum 0x1062b4b6, Offset: 0x248
// Size: 0x34
function register_clientside() {
    elem = new cinsertion_passenger_count();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x7e8bedc5, Offset: 0x288
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0xa4050258, Offset: 0x2b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0xd15b7cf, Offset: 0x2d8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 2, eflags: 0x0
// Checksum 0xc01543c8, Offset: 0x300
// Size: 0x28
function set_count(localclientnum, value) {
    [[ self ]]->set_count(localclientnum, value);
}

