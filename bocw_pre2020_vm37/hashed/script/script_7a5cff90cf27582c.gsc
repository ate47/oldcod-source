#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace blackseajetskideployprompt;

// Namespace blackseajetskideployprompt
// Method(s) 6 Total 13
class class_6b831806 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_6b831806/blackseajetskideployprompt
    // Params 2, eflags: 0x0
    // Checksum 0x7e0087e4, Offset: 0x248
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_6b831806/blackseajetskideployprompt
    // Params 2, eflags: 0x0
    // Checksum 0x9210a8ff, Offset: 0x2c0
    // Size: 0x44
    function function_26d9350e(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "deployProgress", value);
    }

    // Namespace namespace_6b831806/blackseajetskideployprompt
    // Params 1, eflags: 0x0
    // Checksum 0xe78242dd, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_6b831806/blackseajetskideployprompt
    // Params 0, eflags: 0x0
    // Checksum 0x18a22fae, Offset: 0x1f8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("BlackSeaJetskiDeployPrompt");
        cluielem::add_clientfield("deployProgress", 1, 5, "float");
    }

}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 0, eflags: 0x0
// Checksum 0x3404794, Offset: 0xd8
// Size: 0x34
function register() {
    elem = new class_6b831806();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 2, eflags: 0x0
// Checksum 0xca2e1c40, Offset: 0x118
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 1, eflags: 0x0
// Checksum 0x7c7778f0, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 1, eflags: 0x0
// Checksum 0xa2ef2991, Offset: 0x180
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 2, eflags: 0x0
// Checksum 0xb7d9cefa, Offset: 0x1a8
// Size: 0x28
function function_26d9350e(player, value) {
    [[ self ]]->function_26d9350e(player, value);
}

