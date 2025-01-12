#using scripts\core_common\lui_shared;

#namespace scavenger_icon;

// Namespace scavenger_icon
// Method(s) 7 Total 13
class cscavenger_icon : cluielem {

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x1 linked
    // Checksum 0x14267b14, Offset: 0x408
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 0, eflags: 0x1 linked
    // Checksum 0x53e738a2, Offset: 0x398
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("scavenger_icon");
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x1 linked
    // Checksum 0xfbde47b1, Offset: 0x438
    // Size: 0x6c
    function increment_pulse(localclientnum) {
        current_val = get_data(localclientnum, "pulse");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "pulse", new_val);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x1 linked
    // Checksum 0x73f9b576, Offset: 0x340
    // Size: 0x4c
    function setup_clientfields(var_bea2552f) {
        cluielem::setup_clientfields("scavenger_icon");
        cluielem::add_clientfield("pulse", 1, 1, "counter", var_bea2552f);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8104acbc, Offset: 0x3c0
    // Size: 0x40
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "pulse", 0);
    }

}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x1 linked
// Checksum 0xf354d1eb, Offset: 0xc0
// Size: 0x176
function register(var_bea2552f) {
    elem = new cscavenger_icon();
    [[ elem ]]->setup_clientfields(var_bea2552f);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"scavenger_icon"])) {
        level.var_ae746e8f[#"scavenger_icon"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"scavenger_icon"])) {
        level.var_ae746e8f[#"scavenger_icon"] = [];
    } else if (!isarray(level.var_ae746e8f[#"scavenger_icon"])) {
        level.var_ae746e8f[#"scavenger_icon"] = array(level.var_ae746e8f[#"scavenger_icon"]);
    }
    level.var_ae746e8f[#"scavenger_icon"][level.var_ae746e8f[#"scavenger_icon"].size] = elem;
}

// Namespace scavenger_icon/scavenger_icon
// Params 0, eflags: 0x0
// Checksum 0x86b61f83, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new cscavenger_icon();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x9ac84058, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xeb321b9f, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xce32a914, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x975b3c5f, Offset: 0x2f8
// Size: 0x1c
function increment_pulse(localclientnum) {
    [[ self ]]->increment_pulse(localclientnum);
}

