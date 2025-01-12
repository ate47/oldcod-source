#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace wz_revive_prompt;

// Namespace wz_revive_prompt
// Method(s) 9 Total 16
class cwz_revive_prompt : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x8985b4a4, Offset: 0x370
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x861d2a5e, Offset: 0x3e8
    // Size: 0x44
    function set_clientnum(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "clientnum", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xaa8da263, Offset: 0x488
    // Size: 0x44
    function set_reviveprogress(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "reviveProgress", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x31ca0b, Offset: 0x3b8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 0, eflags: 0x0
    // Checksum 0x4d19e4a, Offset: 0x2a8
    // Size: 0xbc
    function setup_clientfields() {
        cluielem::setup_clientfields("wz_revive_prompt");
        cluielem::add_clientfield("clientnum", 1, 7, "int");
        cluielem::add_clientfield("health", 1, 5, "float");
        cluielem::add_clientfield("reviveProgress", 1, 5, "float");
        cluielem::add_clientfield("cowardsWay", 1, 1, "int");
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x81995431, Offset: 0x4d8
    // Size: 0x44
    function set_cowardsway(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "cowardsWay", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x9fcb1840, Offset: 0x438
    // Size: 0x44
    function set_health(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "health", value);
    }

}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 0, eflags: 0x0
// Checksum 0x10a4d756, Offset: 0xf8
// Size: 0x34
function register() {
    elem = new cwz_revive_prompt();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xf9df25c3, Offset: 0x138
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x94bac228, Offset: 0x178
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x2ab077a3, Offset: 0x1a0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xac5014b5, Offset: 0x1c8
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x71c448f5, Offset: 0x1f8
// Size: 0x28
function set_health(player, value) {
    [[ self ]]->set_health(player, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x684ee39b, Offset: 0x228
// Size: 0x28
function set_reviveprogress(player, value) {
    [[ self ]]->set_reviveprogress(player, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x25c05f7c, Offset: 0x258
// Size: 0x28
function set_cowardsway(player, value) {
    [[ self ]]->set_cowardsway(player, value);
}

