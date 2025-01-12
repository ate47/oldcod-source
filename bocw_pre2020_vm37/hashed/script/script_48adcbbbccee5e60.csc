#using scripts\core_common\lui_shared;

#namespace interactive_shot;

// Namespace interactive_shot
// Method(s) 7 Total 13
class cinteractive_shot : cluielem {

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe3f6c502, Offset: 0x420
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8c67b7aa, Offset: 0x3a0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("interactive_shot");
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5b81b4d, Offset: 0x348
    // Size: 0x4c
    function setup_clientfields(*textcallback) {
        cluielem::setup_clientfields("interactive_shot");
        cluielem::function_dcb34c80("string", "text", 1);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2b734c09, Offset: 0x450
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1bb7e062, Offset: 0x3c8
    // Size: 0x4c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "text", #"");
    }

}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x1 linked
// Checksum 0x1236d25d, Offset: 0xc0
// Size: 0x176
function register(textcallback) {
    elem = new cinteractive_shot();
    [[ elem ]]->setup_clientfields(textcallback);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"interactive_shot"])) {
        level.var_ae746e8f[#"interactive_shot"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"interactive_shot"])) {
        level.var_ae746e8f[#"interactive_shot"] = [];
    } else if (!isarray(level.var_ae746e8f[#"interactive_shot"])) {
        level.var_ae746e8f[#"interactive_shot"] = array(level.var_ae746e8f[#"interactive_shot"]);
    }
    level.var_ae746e8f[#"interactive_shot"][level.var_ae746e8f[#"interactive_shot"].size] = elem;
}

// Namespace interactive_shot/interactive_shot
// Params 0, eflags: 0x0
// Checksum 0x4e9139fa, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new cinteractive_shot();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x9ac84058, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0xeb321b9f, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0xce32a914, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x0
// Checksum 0xa51d30f8, Offset: 0x2f8
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

