#using scripts\core_common\lui_shared;

#namespace lui_napalm_strike;

// Namespace lui_napalm_strike
// Method(s) 6 Total 12
class clui_napalm_strike : cluielem {

    // Namespace clui_napalm_strike/lui_napalm_strike
    // Params 1, eflags: 0x1 linked
    // Checksum 0xba6d8900, Offset: 0x380
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace clui_napalm_strike/lui_napalm_strike
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcabe1da8, Offset: 0x328
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("lui_napalm_strike");
    }

    // Namespace clui_napalm_strike/lui_napalm_strike
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc73dbfbd, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("lui_napalm_strike");
    }

    // Namespace clui_napalm_strike/lui_napalm_strike
    // Params 1, eflags: 0x1 linked
    // Checksum 0x311e9c90, Offset: 0x350
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace lui_napalm_strike/lui_napalm_strike
// Params 0, eflags: 0x0
// Checksum 0xddd0ba00, Offset: 0xb0
// Size: 0x16e
function register() {
    elem = new clui_napalm_strike();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"lui_napalm_strike"])) {
        level.var_ae746e8f[#"lui_napalm_strike"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"lui_napalm_strike"])) {
        level.var_ae746e8f[#"lui_napalm_strike"] = [];
    } else if (!isarray(level.var_ae746e8f[#"lui_napalm_strike"])) {
        level.var_ae746e8f[#"lui_napalm_strike"] = array(level.var_ae746e8f[#"lui_napalm_strike"]);
    }
    level.var_ae746e8f[#"lui_napalm_strike"][level.var_ae746e8f[#"lui_napalm_strike"].size] = elem;
}

// Namespace lui_napalm_strike/lui_napalm_strike
// Params 0, eflags: 0x0
// Checksum 0x6758b442, Offset: 0x228
// Size: 0x34
function register_clientside() {
    elem = new clui_napalm_strike();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace lui_napalm_strike/lui_napalm_strike
// Params 1, eflags: 0x0
// Checksum 0x4c6edf28, Offset: 0x268
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace lui_napalm_strike/lui_napalm_strike
// Params 1, eflags: 0x0
// Checksum 0xac2cdcbf, Offset: 0x290
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace lui_napalm_strike/lui_napalm_strike
// Params 1, eflags: 0x0
// Checksum 0x52721039, Offset: 0x2b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

