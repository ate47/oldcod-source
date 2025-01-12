#using scripts\core_common\lui_shared;

#namespace zm_arcade_timer;

// Namespace zm_arcade_timer
// Method(s) 10 Total 16
class czm_arcade_timer : cluielem {

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 1, eflags: 0x0
    // Checksum 0xc05387a3, Offset: 0x5e0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0xce50e0f1, Offset: 0x680
    // Size: 0x30
    function set_minutes(localclientnum, value) {
        set_data(localclientnum, "minutes", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0x8f24d847, Offset: 0x6b8
    // Size: 0x30
    function set_title(localclientnum, value) {
        set_data(localclientnum, "title", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 0, eflags: 0x0
    // Checksum 0xf51160f2, Offset: 0x508
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_arcade_timer");
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0xdc476b35, Offset: 0x610
    // Size: 0x30
    function set_showzero(localclientnum, value) {
        set_data(localclientnum, "showzero", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 4, eflags: 0x0
    // Checksum 0x901a6a6a, Offset: 0x420
    // Size: 0xdc
    function setup_clientfields(var_8fd8bfaa, var_b1de907e, var_359a4d9a, *var_395b3059) {
        cluielem::setup_clientfields("zm_arcade_timer");
        cluielem::add_clientfield("showzero", 1, 1, "int", var_b1de907e);
        cluielem::add_clientfield("seconds", 1, 6, "int", var_359a4d9a);
        cluielem::add_clientfield("minutes", 1, 4, "int", var_395b3059);
        cluielem::function_dcb34c80("string", "title", 1);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0xdf765ae, Offset: 0x648
    // Size: 0x30
    function set_seconds(localclientnum, value) {
        set_data(localclientnum, "seconds", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 1, eflags: 0x0
    // Checksum 0x8c3e986c, Offset: 0x530
    // Size: 0xa4
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "showzero", 0);
        set_data(localclientnum, "seconds", 0);
        set_data(localclientnum, "minutes", 0);
        set_data(localclientnum, "title", #"");
    }

}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 4, eflags: 0x0
// Checksum 0x6c35ca64, Offset: 0xe8
// Size: 0x196
function register(var_8fd8bfaa, var_b1de907e, var_359a4d9a, var_395b3059) {
    elem = new czm_arcade_timer();
    [[ elem ]]->setup_clientfields(var_8fd8bfaa, var_b1de907e, var_359a4d9a, var_395b3059);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_arcade_timer"])) {
        level.var_ae746e8f[#"zm_arcade_timer"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_arcade_timer"])) {
        level.var_ae746e8f[#"zm_arcade_timer"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_arcade_timer"])) {
        level.var_ae746e8f[#"zm_arcade_timer"] = array(level.var_ae746e8f[#"zm_arcade_timer"]);
    }
    level.var_ae746e8f[#"zm_arcade_timer"][level.var_ae746e8f[#"zm_arcade_timer"].size] = elem;
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 0, eflags: 0x0
// Checksum 0xfe680c8c, Offset: 0x288
// Size: 0x34
function register_clientside() {
    elem = new czm_arcade_timer();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0x2c06bbcc, Offset: 0x2c8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0xfe370286, Offset: 0x2f0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0x6153647b, Offset: 0x318
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0xcb6b7e36, Offset: 0x340
// Size: 0x28
function set_showzero(localclientnum, value) {
    [[ self ]]->set_showzero(localclientnum, value);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0x8f16ac9d, Offset: 0x370
// Size: 0x28
function set_seconds(localclientnum, value) {
    [[ self ]]->set_seconds(localclientnum, value);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0xc995b7d6, Offset: 0x3a0
// Size: 0x28
function set_minutes(localclientnum, value) {
    [[ self ]]->set_minutes(localclientnum, value);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0xe0489426, Offset: 0x3d0
// Size: 0x28
function set_title(localclientnum, value) {
    [[ self ]]->set_title(localclientnum, value);
}

