#using scripts\core_common\lui_shared;

#namespace dirtybomb_usebar;

// Namespace dirtybomb_usebar
// Method(s) 9 Total 16
class class_fbe341f : cluielem {

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 1, eflags: 0x0
    // Checksum 0xee22a759, Offset: 0x540
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0x7cf09cdb, Offset: 0x660
    // Size: 0x30
    function function_4aa46834(localclientnum, value) {
        set_data(localclientnum, "activatorCount", value);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 0, eflags: 0x0
    // Checksum 0x4f18681b, Offset: 0x488
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("DirtyBomb_UseBar");
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0xea442190, Offset: 0x3d8
    // Size: 0xa4
    function setup_clientfields(var_ec85b709, var_193163f7) {
        cluielem::setup_clientfields("DirtyBomb_UseBar");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("progressFrac", 1, 10, "float", var_ec85b709);
        cluielem::add_clientfield("activatorCount", 1, 3, "int", var_193163f7);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0xf3ceea2d, Offset: 0x570
    // Size: 0xac
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"detonating" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0x1ae58abe, Offset: 0x628
    // Size: 0x30
    function function_f0df5702(localclientnum, value) {
        set_data(localclientnum, "progressFrac", value);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 1, eflags: 0x0
    // Checksum 0xb4509dc4, Offset: 0x4b0
    // Size: 0x84
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "progressFrac", 0);
        set_data(localclientnum, "activatorCount", 0);
    }

}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x4c55723, Offset: 0xe8
// Size: 0x17e
function register(var_ec85b709, var_193163f7) {
    elem = new class_fbe341f();
    [[ elem ]]->setup_clientfields(var_ec85b709, var_193163f7);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"dirtybomb_usebar"])) {
        level.var_ae746e8f[#"dirtybomb_usebar"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"dirtybomb_usebar"])) {
        level.var_ae746e8f[#"dirtybomb_usebar"] = [];
    } else if (!isarray(level.var_ae746e8f[#"dirtybomb_usebar"])) {
        level.var_ae746e8f[#"dirtybomb_usebar"] = array(level.var_ae746e8f[#"dirtybomb_usebar"]);
    }
    level.var_ae746e8f[#"dirtybomb_usebar"][level.var_ae746e8f[#"dirtybomb_usebar"].size] = elem;
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 0, eflags: 0x0
// Checksum 0xb1239501, Offset: 0x270
// Size: 0x34
function register_clientside() {
    elem = new class_fbe341f();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0xc1bb9098, Offset: 0x2b0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0x39aba260, Offset: 0x2d8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0xb1a0e085, Offset: 0x300
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x57a98e02, Offset: 0x328
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x7f11a234, Offset: 0x358
// Size: 0x28
function function_f0df5702(localclientnum, value) {
    [[ self ]]->function_f0df5702(localclientnum, value);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0xdc5ca42a, Offset: 0x388
// Size: 0x28
function function_4aa46834(localclientnum, value) {
    [[ self ]]->function_4aa46834(localclientnum, value);
}

