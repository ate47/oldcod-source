#using scripts\core_common\lui_shared;

#namespace scavenger_icon;

// Namespace scavenger_icon
// Method(s) 9 Total 16
class cscavenger_icon : cluielem {

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0xead73d17, Offset: 0x528
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0xeaf05033, Offset: 0x648
    // Size: 0x6c
    function function_417df30c(localclientnum) {
        current_val = get_data(localclientnum, "rareScrapPulse");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "rareScrapPulse", new_val);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0x56b1e175, Offset: 0x5d0
    // Size: 0x6c
    function function_47e82a09(localclientnum) {
        current_val = get_data(localclientnum, "scrapPulse");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "scrapPulse", new_val);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 0, eflags: 0x0
    // Checksum 0x3fc17102, Offset: 0x480
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("scavenger_icon");
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 3, eflags: 0x0
    // Checksum 0x92ebf55e, Offset: 0x3c8
    // Size: 0xac
    function setup_clientfields(var_c21a7363, var_32c73fea, var_d239de43) {
        cluielem::setup_clientfields("scavenger_icon");
        cluielem::add_clientfield("ammoPulse", 1, 1, "counter", var_c21a7363);
        cluielem::add_clientfield("scrapPulse", 1, 1, "counter", var_32c73fea);
        cluielem::add_clientfield("rareScrapPulse", 4000, 1, "counter", var_d239de43);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0xb52d95e0, Offset: 0x558
    // Size: 0x6c
    function function_e4e9c303(localclientnum) {
        current_val = get_data(localclientnum, "ammoPulse");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "ammoPulse", new_val);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0xf51334b2, Offset: 0x4a8
    // Size: 0x78
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "ammoPulse", 0);
        set_data(localclientnum, "scrapPulse", 0);
        set_data(localclientnum, "rareScrapPulse", 0);
    }

}

// Namespace scavenger_icon/scavenger_icon
// Params 3, eflags: 0x0
// Checksum 0xc090a081, Offset: 0xe0
// Size: 0x18e
function register(var_c21a7363, var_32c73fea, var_d239de43) {
    elem = new cscavenger_icon();
    [[ elem ]]->setup_clientfields(var_c21a7363, var_32c73fea, var_d239de43);
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
// Checksum 0xfb80fc21, Offset: 0x278
// Size: 0x34
function register_clientside() {
    elem = new cscavenger_icon();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x5a159584, Offset: 0x2b8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x6d90192e, Offset: 0x2e0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xfed8576a, Offset: 0x308
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xc256b2a0, Offset: 0x330
// Size: 0x1c
function function_e4e9c303(localclientnum) {
    [[ self ]]->function_e4e9c303(localclientnum);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x1cf868d5, Offset: 0x358
// Size: 0x1c
function function_47e82a09(localclientnum) {
    [[ self ]]->function_47e82a09(localclientnum);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x24af73d7, Offset: 0x380
// Size: 0x1c
function function_417df30c(localclientnum) {
    [[ self ]]->function_417df30c(localclientnum);
}

