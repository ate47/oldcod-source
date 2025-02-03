#using scripts\core_common\lui_shared;

#namespace multi_stage_friendly_lockon;

// Namespace multi_stage_friendly_lockon
// Method(s) 8 Total 15
class cmulti_stage_friendly_lockon : cluielem {

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xf9fa4d4b, Offset: 0x4b0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 0, eflags: 0x0
    // Checksum 0x7127d40e, Offset: 0x420
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("multi_stage_friendly_lockon");
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 2, eflags: 0x0
    // Checksum 0xcec4cec0, Offset: 0x398
    // Size: 0x7c
    function setup_clientfields(var_5a7b4b38, var_29786c92) {
        cluielem::setup_clientfields("multi_stage_friendly_lockon");
        cluielem::add_clientfield("entNum", 1, 10, "int", var_5a7b4b38);
        cluielem::add_clientfield("targetState", 1, 3, "int", var_29786c92);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x221894fc, Offset: 0x4e0
    // Size: 0x30
    function set_entnum(localclientnum, value) {
        set_data(localclientnum, "entNum", value);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x9399e6f6, Offset: 0x518
    // Size: 0x30
    function set_targetstate(localclientnum, value) {
        set_data(localclientnum, "targetState", value);
    }

    // Namespace cmulti_stage_friendly_lockon/multi_stage_friendly_lockon
    // Params 1, eflags: 0x0
    // Checksum 0x5c777c1e, Offset: 0x448
    // Size: 0x5c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "entNum", 0);
        set_data(localclientnum, "targetState", 0);
    }

}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 2, eflags: 0x0
// Checksum 0x4ad98d4a, Offset: 0xd8
// Size: 0x17e
function register(var_5a7b4b38, var_29786c92) {
    elem = new cmulti_stage_friendly_lockon();
    [[ elem ]]->setup_clientfields(var_5a7b4b38, var_29786c92);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"multi_stage_friendly_lockon"])) {
        level.var_ae746e8f[#"multi_stage_friendly_lockon"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"multi_stage_friendly_lockon"])) {
        level.var_ae746e8f[#"multi_stage_friendly_lockon"] = [];
    } else if (!isarray(level.var_ae746e8f[#"multi_stage_friendly_lockon"])) {
        level.var_ae746e8f[#"multi_stage_friendly_lockon"] = array(level.var_ae746e8f[#"multi_stage_friendly_lockon"]);
    }
    level.var_ae746e8f[#"multi_stage_friendly_lockon"][level.var_ae746e8f[#"multi_stage_friendly_lockon"].size] = elem;
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 0, eflags: 0x0
// Checksum 0xf0287ea1, Offset: 0x260
// Size: 0x34
function register_clientside() {
    elem = new cmulti_stage_friendly_lockon();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 1, eflags: 0x0
// Checksum 0x75512ca5, Offset: 0x2a0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 1, eflags: 0x0
// Checksum 0x1221277, Offset: 0x2c8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 1, eflags: 0x0
// Checksum 0x31152d7d, Offset: 0x2f0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 2, eflags: 0x0
// Checksum 0x140d561f, Offset: 0x318
// Size: 0x28
function set_entnum(localclientnum, value) {
    [[ self ]]->set_entnum(localclientnum, value);
}

// Namespace multi_stage_friendly_lockon/multi_stage_friendly_lockon
// Params 2, eflags: 0x0
// Checksum 0xcf65e5d9, Offset: 0x348
// Size: 0x28
function set_targetstate(localclientnum, value) {
    [[ self ]]->set_targetstate(localclientnum, value);
}

