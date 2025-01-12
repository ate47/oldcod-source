#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace multi_stage_friendly_lockon;

// Namespace multi_stage_friendly_lockon
// Method(s) 7 Total 14
class cmulti_stage_friendly_lockon : cluielem {

    var var_57a3d576;

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 2, eflags: 0x0
    // Checksum 0xeb423ca6, Offset: 0x370
    // Size: 0x3c
    function set_targetstate(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "targetState", value);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x9a0adf20, Offset: 0x328
    // Size: 0x3c
    function set_entnum(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "entNum", value);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xead890a0, Offset: 0x2f8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 2, eflags: 0x0
    // Checksum 0xd8230730, Offset: 0x2a8
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "multi_stage_friendly_lockon", persistent);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 1, eflags: 0x0
    // Checksum 0x1b39205c, Offset: 0x228
    // Size: 0x74
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("entNum", 1, 10, "int");
        cluielem::add_clientfield("targetState", 1, 3, "int");
    }

}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 1, eflags: 0x0
// Checksum 0x4e644871, Offset: 0xd0
// Size: 0x40
function register(uid) {
    elem = new cmulti_stage_friendly_lockon();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 2, eflags: 0x0
// Checksum 0x44eef153, Offset: 0x118
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 1, eflags: 0x0
// Checksum 0x55291547, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 1, eflags: 0x0
// Checksum 0xd45d64d3, Offset: 0x180
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 2, eflags: 0x0
// Checksum 0x920419fb, Offset: 0x1a8
// Size: 0x28
function set_entnum(player, value) {
    [[ self ]]->set_entnum(player, value);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 2, eflags: 0x0
// Checksum 0xda4af4bd, Offset: 0x1d8
// Size: 0x28
function set_targetstate(player, value) {
    [[ self ]]->set_targetstate(player, value);
}

