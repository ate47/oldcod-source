#using scripts\core_common\lui_shared;

#namespace dirtybomb_usebar;

// Namespace dirtybomb_usebar
// Method(s) 8 Total 14
class class_fbe341f : cluielem {

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 1, eflags: 0x0
    // Checksum 0x88187830, Offset: 0x4a8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 0, eflags: 0x0
    // Checksum 0xd8c3ca8, Offset: 0x410
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("DirtyBomb_UseBar");
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 1, eflags: 0x0
    // Checksum 0x5856206e, Offset: 0x390
    // Size: 0x74
    function setup_clientfields(var_ec85b709) {
        cluielem::setup_clientfields("DirtyBomb_UseBar");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("progressFrac", 1, 10, "float", var_ec85b709);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0xe7e64878, Offset: 0x4d8
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
    // Checksum 0xb6653236, Offset: 0x590
    // Size: 0x30
    function function_f0df5702(localclientnum, value) {
        set_data(localclientnum, "progressFrac", value);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 1, eflags: 0x0
    // Checksum 0xe0409b0e, Offset: 0x438
    // Size: 0x68
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "progressFrac", 0);
    }

}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0x3793c2a, Offset: 0xd8
// Size: 0x176
function register(var_ec85b709) {
    elem = new class_fbe341f();
    [[ elem ]]->setup_clientfields(var_ec85b709);
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
// Checksum 0x1e4c42f6, Offset: 0x258
// Size: 0x34
function register_clientside() {
    elem = new class_fbe341f();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0x9ac84058, Offset: 0x298
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0xeb321b9f, Offset: 0x2c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0xce32a914, Offset: 0x2e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0xa3608e4f, Offset: 0x310
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0xe9e96eab, Offset: 0x340
// Size: 0x28
function function_f0df5702(localclientnum, value) {
    [[ self ]]->function_f0df5702(localclientnum, value);
}

