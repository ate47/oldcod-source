#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace multi_stage_target_lockon;

// Namespace multi_stage_target_lockon
// Method(s) 7 Total 14
class cmulti_stage_target_lockon : cluielem {

    var var_57a3d576;

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x2d9d106c, Offset: 0x370
    // Size: 0x3c
    function set_targetstate(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "targetState", value);
    }

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0xb803f283, Offset: 0x328
    // Size: 0x3c
    function set_entnum(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "entNum", value);
    }

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xe4eb9170, Offset: 0x2f8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x33c71edc, Offset: 0x2a8
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "multi_stage_target_lockon", persistent);
    }

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0x4e20879e, Offset: 0x228
    // Size: 0x74
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("entNum", 1, 6, "int");
        cluielem::add_clientfield("targetState", 1, 3, "int");
    }

}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 1, eflags: 0x0
// Checksum 0xa1eb3f72, Offset: 0xd0
// Size: 0x40
function register(uid) {
    elem = new cmulti_stage_target_lockon();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 2, eflags: 0x0
// Checksum 0x62e187a4, Offset: 0x118
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x8abd5f9c, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x95162d21, Offset: 0x180
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xe0b783c4, Offset: 0x1a8
// Size: 0x28
function set_entnum(player, value) {
    [[ self ]]->set_entnum(player, value);
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xbdc483ae, Offset: 0x1d8
// Size: 0x28
function set_targetstate(player, value) {
    [[ self ]]->set_targetstate(player, value);
}

