#using scripts\core_common\lui_shared;

#namespace mp_revive_prompt;

// Namespace mp_revive_prompt
// Method(s) 9 Total 15
class cmp_revive_prompt : cluielem {

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x88905b7b, Offset: 0x4d8
    // Size: 0x30
    function set_reviveprogress(localclientnum, value) {
        set_data(localclientnum, "reviveProgress", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x4f37078e, Offset: 0x4a0
    // Size: 0x30
    function set_health(localclientnum, value) {
        set_data(localclientnum, "health", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xa4d1f0a3, Offset: 0x468
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientnum", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x2e296e36, Offset: 0x430
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"mp_revive_prompt");
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x91837fce, Offset: 0x3a0
    // Size: 0x88
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "clientnum", 0);
        set_data(localclientnum, "health", 0);
        set_data(localclientnum, "reviveProgress", 0);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x8c4208a8, Offset: 0x370
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 5, eflags: 0x0
    // Checksum 0x4c8f2f10, Offset: 0x2a8
    // Size: 0xbc
    function setup_clientfields(uid, var_13af07a1, healthcallback, var_8dd629e, var_81b4b29) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("clientnum", 1, 6, "int", var_13af07a1);
        cluielem::add_clientfield("health", 1, 5, "float", healthcallback);
        cluielem::add_clientfield("reviveProgress", 1, 5, "float", var_8dd629e);
    }

}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 5, eflags: 0x0
// Checksum 0x65bcd098, Offset: 0xc0
// Size: 0x70
function register(uid, var_13af07a1, healthcallback, var_8dd629e, var_81b4b29) {
    elem = new cmp_revive_prompt();
    [[ elem ]]->setup_clientfields(uid, var_13af07a1, healthcallback, var_8dd629e, var_81b4b29);
    return elem;
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0xd9d40f53, Offset: 0x138
// Size: 0x40
function register_clientside(uid) {
    elem = new cmp_revive_prompt();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x2268b806, Offset: 0x180
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x4ca2b35, Offset: 0x1a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x123ed267, Offset: 0x1d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x5ea81e55, Offset: 0x1f8
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x783109b0, Offset: 0x228
// Size: 0x28
function set_health(localclientnum, value) {
    [[ self ]]->set_health(localclientnum, value);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xc2efeb35, Offset: 0x258
// Size: 0x28
function set_reviveprogress(localclientnum, value) {
    [[ self ]]->set_reviveprogress(localclientnum, value);
}

