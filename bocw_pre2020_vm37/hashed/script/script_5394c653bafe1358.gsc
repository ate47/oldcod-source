#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_revive_prompt;

// Namespace mp_revive_prompt
// Method(s) 8 Total 15
class cmp_revive_prompt : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xcd692b14, Offset: 0x310
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xf09fc1b, Offset: 0x388
    // Size: 0x44
    function set_clientnum(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "clientnum", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x95f8a2c5, Offset: 0x428
    // Size: 0x44
    function set_reviveprogress(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "reviveProgress", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x3e0b5676, Offset: 0x358
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 0, eflags: 0x0
    // Checksum 0x209fdf86, Offset: 0x270
    // Size: 0x94
    function setup_clientfields() {
        cluielem::setup_clientfields("mp_revive_prompt");
        cluielem::add_clientfield("clientnum", 1, 7, "int", 0);
        cluielem::add_clientfield("health", 1, 5, "float", 0);
        cluielem::add_clientfield("reviveProgress", 1, 5, "float", 0);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xc09ab52d, Offset: 0x3d8
    // Size: 0x44
    function set_health(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "health", value);
    }

}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 0, eflags: 0x0
// Checksum 0x2b68da3d, Offset: 0xf0
// Size: 0x34
function register() {
    elem = new cmp_revive_prompt();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x17ff746, Offset: 0x130
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x1870d62a, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x4fad5457, Offset: 0x198
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xdf8f1917, Offset: 0x1c0
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x4d7b19b1, Offset: 0x1f0
// Size: 0x28
function set_health(player, value) {
    [[ self ]]->set_health(player, value);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xd1f6bcfa, Offset: 0x220
// Size: 0x28
function set_reviveprogress(player, value) {
    [[ self ]]->set_reviveprogress(player, value);
}

