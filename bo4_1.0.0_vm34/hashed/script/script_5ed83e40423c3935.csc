#using scripts\core_common\lui_shared;

#namespace wz_revive_prompt;

// Namespace wz_revive_prompt
// Method(s) 9 Total 15
class cwz_revive_prompt : cluielem {

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x5b6c6bdc, Offset: 0x4d8
    // Size: 0x30
    function set_reviveprogress(localclientnum, value) {
        set_data(localclientnum, "reviveProgress", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x88233a4e, Offset: 0x4a0
    // Size: 0x30
    function set_health(localclientnum, value) {
        set_data(localclientnum, "health", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xa72f1616, Offset: 0x468
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientnum", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0xe0e976e, Offset: 0x430
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"wz_revive_prompt");
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0xbf06abea, Offset: 0x3a0
    // Size: 0x88
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "clientnum", 0);
        set_data(localclientnum, "health", 0);
        set_data(localclientnum, "reviveProgress", 0);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x15caf765, Offset: 0x370
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 5, eflags: 0x0
    // Checksum 0x25ff20d1, Offset: 0x2a8
    // Size: 0xbc
    function setup_clientfields(uid, var_13af07a1, healthcallback, var_8dd629e, var_81b4b29) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("clientnum", 1, 6, "int", var_13af07a1);
        cluielem::add_clientfield("health", 1, 5, "float", healthcallback);
        cluielem::add_clientfield("reviveProgress", 1, 5, "float", var_8dd629e);
    }

}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 5, eflags: 0x0
// Checksum 0x984212cb, Offset: 0xc0
// Size: 0x70
function register(uid, var_13af07a1, healthcallback, var_8dd629e, var_81b4b29) {
    elem = new cwz_revive_prompt();
    [[ elem ]]->setup_clientfields(uid, var_13af07a1, healthcallback, var_8dd629e, var_81b4b29);
    return elem;
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0xcf3a90e9, Offset: 0x138
// Size: 0x40
function register_clientside(uid) {
    elem = new cwz_revive_prompt();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x7aa0e210, Offset: 0x180
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0xd4cfac22, Offset: 0x1a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x27014c4b, Offset: 0x1d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x5a42f142, Offset: 0x1f8
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x3482d51d, Offset: 0x228
// Size: 0x28
function set_health(localclientnum, value) {
    [[ self ]]->set_health(localclientnum, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xbbd72dda, Offset: 0x258
// Size: 0x28
function set_reviveprogress(localclientnum, value) {
    [[ self ]]->set_reviveprogress(localclientnum, value);
}

