#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_revive_prompt;

// Namespace mp_revive_prompt
// Method(s) 8 Total 15
class cmp_revive_prompt : cluielem {

    var var_57a3d576;

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x503668a4, Offset: 0x418
    // Size: 0x3c
    function set_reviveprogress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "reviveProgress", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xe10b5522, Offset: 0x3d0
    // Size: 0x3c
    function set_health(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "health", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xfdcceaa8, Offset: 0x388
    // Size: 0x3c
    function set_clientnum(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "clientnum", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0xe6bf6c16, Offset: 0x358
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xb6b7548, Offset: 0x308
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "mp_revive_prompt", persistent);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x180db1b1, Offset: 0x260
    // Size: 0x9c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("clientnum", 1, 6, "int");
        cluielem::add_clientfield("health", 1, 5, "float");
        cluielem::add_clientfield("reviveProgress", 1, 5, "float");
    }

}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0xf0112ca0, Offset: 0xd8
// Size: 0x40
function register(uid) {
    elem = new cmp_revive_prompt();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xc9b4b30c, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x37c7ffbe, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0xbf3aefcf, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xe59a897a, Offset: 0x1b0
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x89bfab34, Offset: 0x1e0
// Size: 0x28
function set_health(player, value) {
    [[ self ]]->set_health(player, value);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x84e24296, Offset: 0x210
// Size: 0x28
function set_reviveprogress(player, value) {
    [[ self ]]->set_reviveprogress(player, value);
}

