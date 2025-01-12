#using scripts\core_common\lui_shared;

#namespace multi_stage_target_lockon;

// Namespace multi_stage_target_lockon
// Method(s) 8 Total 14
class cmulti_stage_target_lockon : cluielem {

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x2d905b09, Offset: 0x3e8
    // Size: 0x30
    function set_targetstate(localclientnum, value) {
        set_data(localclientnum, "targetState", value);
    }

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x6b05521c, Offset: 0x3b0
    // Size: 0x30
    function set_entnum(localclientnum, value) {
        set_data(localclientnum, "entNum", value);
    }

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0x7bfa1d94, Offset: 0x378
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"multi_stage_target_lockon");
    }

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0x5848a30b, Offset: 0x310
    // Size: 0x5c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "entNum", 0);
        set_data(localclientnum, "targetState", 0);
    }

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xcff275cc, Offset: 0x2e0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cmulti_stage_target_lockon/multi_stage_target_lockon
    // Params 3, eflags: 0x0
    // Checksum 0xe5a33fc2, Offset: 0x250
    // Size: 0x84
    function setup_clientfields(uid, var_f2b103c5, var_5668fa70) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("entNum", 1, 6, "int", var_f2b103c5);
        cluielem::add_clientfield("targetState", 1, 3, "int", var_5668fa70);
    }

}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 3, eflags: 0x0
// Checksum 0xf3946360, Offset: 0xb0
// Size: 0x58
function register(uid, var_f2b103c5, var_5668fa70) {
    elem = new cmulti_stage_target_lockon();
    [[ elem ]]->setup_clientfields(uid, var_f2b103c5, var_5668fa70);
    return elem;
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x6d0a5a45, Offset: 0x110
// Size: 0x40
function register_clientside(uid) {
    elem = new cmulti_stage_target_lockon();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 1, eflags: 0x0
// Checksum 0xfd75d12b, Offset: 0x158
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 1, eflags: 0x0
// Checksum 0xabdab74c, Offset: 0x180
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x674d1f34, Offset: 0x1a8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xf0da8726, Offset: 0x1d0
// Size: 0x28
function set_entnum(localclientnum, value) {
    [[ self ]]->set_entnum(localclientnum, value);
}

// Namespace multi_stage_target_lockon/multi_stage_target_lockon
// Params 2, eflags: 0x0
// Checksum 0x1e5a6310, Offset: 0x200
// Size: 0x28
function set_targetstate(localclientnum, value) {
    [[ self ]]->set_targetstate(localclientnum, value);
}

