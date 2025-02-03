#using scripts\core_common\lui_shared;

#namespace interactive_shot;

// Namespace interactive_shot
// Method(s) 7 Total 14
class cinteractive_shot : cluielem {

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x0
    // Checksum 0x996ae26e, Offset: 0x420
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 0, eflags: 0x0
    // Checksum 0x6a5f0b3e, Offset: 0x3a0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("interactive_shot");
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x0
    // Checksum 0x225e8da9, Offset: 0x348
    // Size: 0x4c
    function setup_clientfields(*textcallback) {
        cluielem::setup_clientfields("interactive_shot");
        cluielem::function_dcb34c80("string", "text", 1);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x0
    // Checksum 0xc3bafe86, Offset: 0x450
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x0
    // Checksum 0x342bb0d9, Offset: 0x3c8
    // Size: 0x4c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "text", #"");
    }

}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x70d5fa2, Offset: 0xc0
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
// Checksum 0x69c92b68, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new cinteractive_shot();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0xca6151f8, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x9c8cb24f, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x8da07a37, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x0
// Checksum 0x70ebf448, Offset: 0x2f8
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

