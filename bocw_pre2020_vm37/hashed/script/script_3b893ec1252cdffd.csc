#using scripts\core_common\lui_shared;

#namespace doa_overworld;

// Namespace doa_overworld
// Method(s) 6 Total 12
class cdoa_overworld : cluielem {

    // Namespace cdoa_overworld/doa_overworld
    // Params 1, eflags: 0x0
    // Checksum 0xc7741028, Offset: 0x378
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cdoa_overworld/doa_overworld
    // Params 0, eflags: 0x0
    // Checksum 0x24a8cf25, Offset: 0x320
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("DOA_Overworld");
    }

    // Namespace cdoa_overworld/doa_overworld
    // Params 0, eflags: 0x0
    // Checksum 0x3b463985, Offset: 0x2f8
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("DOA_Overworld");
    }

    // Namespace cdoa_overworld/doa_overworld
    // Params 1, eflags: 0x0
    // Checksum 0x2bf5276e, Offset: 0x348
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace doa_overworld/doa_overworld
// Params 0, eflags: 0x0
// Checksum 0x9fa8de4a, Offset: 0xa8
// Size: 0x16e
function register() {
    elem = new cdoa_overworld();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"doa_overworld"])) {
        level.var_ae746e8f[#"doa_overworld"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"doa_overworld"])) {
        level.var_ae746e8f[#"doa_overworld"] = [];
    } else if (!isarray(level.var_ae746e8f[#"doa_overworld"])) {
        level.var_ae746e8f[#"doa_overworld"] = array(level.var_ae746e8f[#"doa_overworld"]);
    }
    level.var_ae746e8f[#"doa_overworld"][level.var_ae746e8f[#"doa_overworld"].size] = elem;
}

// Namespace doa_overworld/doa_overworld
// Params 0, eflags: 0x0
// Checksum 0x26bad7a5, Offset: 0x220
// Size: 0x34
function register_clientside() {
    elem = new cdoa_overworld();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace doa_overworld/doa_overworld
// Params 1, eflags: 0x0
// Checksum 0x1d3f70a7, Offset: 0x260
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace doa_overworld/doa_overworld
// Params 1, eflags: 0x0
// Checksum 0xe9546b3a, Offset: 0x288
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_overworld/doa_overworld
// Params 1, eflags: 0x0
// Checksum 0x479469de, Offset: 0x2b0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

