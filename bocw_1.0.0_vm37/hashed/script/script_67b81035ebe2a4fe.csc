#using scripts\core_common\lui_shared;

#namespace mp_prop_timer;

// Namespace mp_prop_timer
// Method(s) 8 Total 15
class cmp_prop_timer : cluielem {

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 1, eflags: 0x0
    // Checksum 0x7d9be207, Offset: 0x4a0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 2, eflags: 0x0
    // Checksum 0xb582e4b1, Offset: 0x508
    // Size: 0x30
    function set_isprop(localclientnum, value) {
        set_data(localclientnum, "isProp", value);
    }

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 0, eflags: 0x0
    // Checksum 0xf37e0b02, Offset: 0x410
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("mp_prop_timer");
    }

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 2, eflags: 0x0
    // Checksum 0xc2eba517, Offset: 0x388
    // Size: 0x7c
    function setup_clientfields(var_43c7e6f7, var_6fb92716) {
        cluielem::setup_clientfields("mp_prop_timer");
        cluielem::add_clientfield("timeRemaining", 1, 5, "int", var_43c7e6f7);
        cluielem::add_clientfield("isProp", 1, 1, "int", var_6fb92716);
    }

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 2, eflags: 0x0
    // Checksum 0x56799dc7, Offset: 0x4d0
    // Size: 0x30
    function set_timeremaining(localclientnum, value) {
        set_data(localclientnum, "timeRemaining", value);
    }

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 1, eflags: 0x0
    // Checksum 0x4f601e31, Offset: 0x438
    // Size: 0x5c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "timeRemaining", 0);
        set_data(localclientnum, "isProp", 0);
    }

}

// Namespace mp_prop_timer/mp_prop_timer
// Params 2, eflags: 0x0
// Checksum 0x3f5e1266, Offset: 0xc8
// Size: 0x17e
function register(var_43c7e6f7, var_6fb92716) {
    elem = new cmp_prop_timer();
    [[ elem ]]->setup_clientfields(var_43c7e6f7, var_6fb92716);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"mp_prop_timer"])) {
        level.var_ae746e8f[#"mp_prop_timer"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"mp_prop_timer"])) {
        level.var_ae746e8f[#"mp_prop_timer"] = [];
    } else if (!isarray(level.var_ae746e8f[#"mp_prop_timer"])) {
        level.var_ae746e8f[#"mp_prop_timer"] = array(level.var_ae746e8f[#"mp_prop_timer"]);
    }
    level.var_ae746e8f[#"mp_prop_timer"][level.var_ae746e8f[#"mp_prop_timer"].size] = elem;
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 0, eflags: 0x0
// Checksum 0x9fa6be5b, Offset: 0x250
// Size: 0x34
function register_clientside() {
    elem = new cmp_prop_timer();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 1, eflags: 0x0
// Checksum 0x2400832a, Offset: 0x290
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 1, eflags: 0x0
// Checksum 0x445aa5f2, Offset: 0x2b8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 1, eflags: 0x0
// Checksum 0x24f3549a, Offset: 0x2e0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 2, eflags: 0x0
// Checksum 0xa1203aae, Offset: 0x308
// Size: 0x28
function set_timeremaining(localclientnum, value) {
    [[ self ]]->set_timeremaining(localclientnum, value);
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 2, eflags: 0x0
// Checksum 0xfcce9be1, Offset: 0x338
// Size: 0x28
function set_isprop(localclientnum, value) {
    [[ self ]]->set_isprop(localclientnum, value);
}

