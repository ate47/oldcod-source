#using scripts\core_common\lui_shared;

#namespace spectrerisingindicator;

// Namespace spectrerisingindicator
// Method(s) 8 Total 14
class cspectrerisingindicator : cluielem {

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 1, eflags: 0x0
    // Checksum 0xf10f3ee1, Offset: 0x4a8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 2, eflags: 0x0
    // Checksum 0x5b1aaa69, Offset: 0x4d8
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientnum", value);
    }

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 0, eflags: 0x0
    // Checksum 0xf580bdbe, Offset: 0x418
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("SpectreRisingIndicator");
    }

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 2, eflags: 0x0
    // Checksum 0x5331c615, Offset: 0x510
    // Size: 0x30
    function set_isalive(localclientnum, value) {
        set_data(localclientnum, "isAlive", value);
    }

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 2, eflags: 0x0
    // Checksum 0x516b10aa, Offset: 0x390
    // Size: 0x7c
    function setup_clientfields(var_c05c67e2, var_f25b9f45) {
        cluielem::setup_clientfields("SpectreRisingIndicator");
        cluielem::add_clientfield("clientnum", 1, 7, "int", var_c05c67e2);
        cluielem::add_clientfield("isAlive", 1, 1, "int", var_f25b9f45);
    }

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 1, eflags: 0x0
    // Checksum 0xeb60e5be, Offset: 0x440
    // Size: 0x5c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "clientnum", 0);
        set_data(localclientnum, "isAlive", 0);
    }

}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 2, eflags: 0x0
// Checksum 0x818e21b4, Offset: 0xd0
// Size: 0x17e
function register(var_c05c67e2, var_f25b9f45) {
    elem = new cspectrerisingindicator();
    [[ elem ]]->setup_clientfields(var_c05c67e2, var_f25b9f45);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"spectrerisingindicator"])) {
        level.var_ae746e8f[#"spectrerisingindicator"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"spectrerisingindicator"])) {
        level.var_ae746e8f[#"spectrerisingindicator"] = [];
    } else if (!isarray(level.var_ae746e8f[#"spectrerisingindicator"])) {
        level.var_ae746e8f[#"spectrerisingindicator"] = array(level.var_ae746e8f[#"spectrerisingindicator"]);
    }
    level.var_ae746e8f[#"spectrerisingindicator"][level.var_ae746e8f[#"spectrerisingindicator"].size] = elem;
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 0, eflags: 0x0
// Checksum 0x8a120e89, Offset: 0x258
// Size: 0x34
function register_clientside() {
    elem = new cspectrerisingindicator();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 1, eflags: 0x0
// Checksum 0xc65437c7, Offset: 0x298
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 1, eflags: 0x0
// Checksum 0x60e0dd40, Offset: 0x2c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 1, eflags: 0x0
// Checksum 0x7348de66, Offset: 0x2e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 2, eflags: 0x0
// Checksum 0x25f5663d, Offset: 0x310
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 2, eflags: 0x0
// Checksum 0x17c78a02, Offset: 0x340
// Size: 0x28
function set_isalive(localclientnum, value) {
    [[ self ]]->set_isalive(localclientnum, value);
}

