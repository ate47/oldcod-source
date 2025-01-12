#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace wz_revive_prompt;

// Namespace wz_revive_prompt
// Method(s) 8 Total 15
class cwz_revive_prompt : cluielem {

    var var_57a3d576;

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x836b2758, Offset: 0x418
    // Size: 0x3c
    function set_reviveprogress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "reviveProgress", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x62d94616, Offset: 0x3d0
    // Size: 0x3c
    function set_health(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "health", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x1b7f6009, Offset: 0x388
    // Size: 0x3c
    function set_clientnum(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "clientnum", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x4ca9d603, Offset: 0x358
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xac1b06e9, Offset: 0x308
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "wz_revive_prompt", persistent);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x3516eec3, Offset: 0x260
    // Size: 0x9c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("clientnum", 1, 6, "int");
        cluielem::add_clientfield("health", 1, 5, "float");
        cluielem::add_clientfield("reviveProgress", 1, 5, "float");
    }

}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x543247a, Offset: 0xd8
// Size: 0x40
function register(uid) {
    elem = new cwz_revive_prompt();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xbf02db9a, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x6f8c6809, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0xeb17ae23, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x73e38721, Offset: 0x1b0
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xd3ba412d, Offset: 0x1e0
// Size: 0x28
function set_health(player, value) {
    [[ self ]]->set_health(player, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x7bb3c871, Offset: 0x210
// Size: 0x28
function set_reviveprogress(player, value) {
    [[ self ]]->set_reviveprogress(player, value);
}

