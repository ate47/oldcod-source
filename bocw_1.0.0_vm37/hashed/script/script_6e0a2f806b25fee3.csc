#using scripts\core_common\lui_shared;

#namespace stim_count;

// Namespace stim_count
// Method(s) 7 Total 14
class class_44eccfcc : cluielem {

    // Namespace namespace_44eccfcc/stim_count
    // Params 1, eflags: 0x0
    // Checksum 0x8ffc2c76, Offset: 0x400
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_44eccfcc/stim_count
    // Params 0, eflags: 0x0
    // Checksum 0x55447289, Offset: 0x390
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("stim_count");
    }

    // Namespace namespace_44eccfcc/stim_count
    // Params 2, eflags: 0x0
    // Checksum 0x11925445, Offset: 0x430
    // Size: 0x30
    function function_6eef7f4f(localclientnum, value) {
        set_data(localclientnum, "stim_count", value);
    }

    // Namespace namespace_44eccfcc/stim_count
    // Params 1, eflags: 0x0
    // Checksum 0x6df53c6b, Offset: 0x338
    // Size: 0x4c
    function setup_clientfields(var_ce21941e) {
        cluielem::setup_clientfields("stim_count");
        cluielem::add_clientfield("stim_count", 1, 4, "int", var_ce21941e);
    }

    // Namespace namespace_44eccfcc/stim_count
    // Params 1, eflags: 0x0
    // Checksum 0x56ea23e0, Offset: 0x3b8
    // Size: 0x40
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "stim_count", 0);
    }

}

// Namespace stim_count/stim_count
// Params 1, eflags: 0x0
// Checksum 0x193590eb, Offset: 0xb0
// Size: 0x176
function register(var_ce21941e) {
    elem = new class_44eccfcc();
    [[ elem ]]->setup_clientfields(var_ce21941e);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"stim_count"])) {
        level.var_ae746e8f[#"stim_count"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"stim_count"])) {
        level.var_ae746e8f[#"stim_count"] = [];
    } else if (!isarray(level.var_ae746e8f[#"stim_count"])) {
        level.var_ae746e8f[#"stim_count"] = array(level.var_ae746e8f[#"stim_count"]);
    }
    level.var_ae746e8f[#"stim_count"][level.var_ae746e8f[#"stim_count"].size] = elem;
}

// Namespace stim_count/stim_count
// Params 0, eflags: 0x0
// Checksum 0xa9de1f48, Offset: 0x230
// Size: 0x34
function register_clientside() {
    elem = new class_44eccfcc();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace stim_count/stim_count
// Params 1, eflags: 0x0
// Checksum 0x7e8bedc5, Offset: 0x270
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace stim_count/stim_count
// Params 1, eflags: 0x0
// Checksum 0xa4050258, Offset: 0x298
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace stim_count/stim_count
// Params 1, eflags: 0x0
// Checksum 0xd15b7cf, Offset: 0x2c0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace stim_count/stim_count
// Params 2, eflags: 0x0
// Checksum 0xc81098dd, Offset: 0x2e8
// Size: 0x28
function function_6eef7f4f(localclientnum, value) {
    [[ self ]]->function_6eef7f4f(localclientnum, value);
}

