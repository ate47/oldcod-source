#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace multi_stage_friendly_lockon;

// Namespace multi_stage_friendly_lockon
// Method(s) 7 Total 14
class cmulti_stage_friendly_lockon : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x3c587f9a, Offset: 0x2a8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 1, eflags: 0x0
    // Checksum 0x7ef876b5, Offset: 0x2f0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 0, eflags: 0x0
    // Checksum 0x29657535, Offset: 0x230
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("multi_stage_friendly_lockon");
        cluielem::add_clientfield("entNum", 1, 10, "int");
        cluielem::add_clientfield("targetState", 1, 3, "int");
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x116b7b05, Offset: 0x320
    // Size: 0x44
    function set_entnum(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "entNum", value);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x8e6e263b, Offset: 0x370
    // Size: 0x44
    function set_targetstate(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "targetState", value);
    }

}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 0, eflags: 0x0
// Checksum 0xe6e127c2, Offset: 0xe0
// Size: 0x34
function register() {
    elem = new cmulti_stage_friendly_lockon();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 2, eflags: 0x0
// Checksum 0x3a3edadf, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 1, eflags: 0x0
// Checksum 0xdd84b28a, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 1, eflags: 0x0
// Checksum 0x800f7339, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 2, eflags: 0x0
// Checksum 0xd064fc85, Offset: 0x1b0
// Size: 0x28
function set_entnum(player, value) {
    [[ self ]]->set_entnum(player, value);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 2, eflags: 0x0
// Checksum 0x9847f1df, Offset: 0x1e0
// Size: 0x28
function set_targetstate(player, value) {
    [[ self ]]->set_targetstate(player, value);
}

