#using scripts\core_common\lui_shared;

#namespace sr_perk_machine_choice;

// Namespace sr_perk_machine_choice
// Method(s) 6 Total 12
class class_a19c3039 : cluielem {

    // Namespace namespace_a19c3039/sr_perk_machine_choice
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb502f0c2, Offset: 0x380
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_a19c3039/sr_perk_machine_choice
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb6c3af0f, Offset: 0x328
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("sr_perk_machine_choice");
    }

    // Namespace namespace_a19c3039/sr_perk_machine_choice
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa225067f, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_perk_machine_choice");
    }

    // Namespace namespace_a19c3039/sr_perk_machine_choice
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3b60537e, Offset: 0x350
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace sr_perk_machine_choice/sr_perk_machine_choice
// Params 0, eflags: 0x1 linked
// Checksum 0x2c350ac2, Offset: 0xb0
// Size: 0x16e
function register() {
    elem = new class_a19c3039();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"sr_perk_machine_choice"])) {
        level.var_ae746e8f[#"sr_perk_machine_choice"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"sr_perk_machine_choice"])) {
        level.var_ae746e8f[#"sr_perk_machine_choice"] = [];
    } else if (!isarray(level.var_ae746e8f[#"sr_perk_machine_choice"])) {
        level.var_ae746e8f[#"sr_perk_machine_choice"] = array(level.var_ae746e8f[#"sr_perk_machine_choice"]);
    }
    level.var_ae746e8f[#"sr_perk_machine_choice"][level.var_ae746e8f[#"sr_perk_machine_choice"].size] = elem;
}

// Namespace sr_perk_machine_choice/sr_perk_machine_choice
// Params 0, eflags: 0x0
// Checksum 0x6d935f27, Offset: 0x228
// Size: 0x34
function register_clientside() {
    elem = new class_a19c3039();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace sr_perk_machine_choice/sr_perk_machine_choice
// Params 1, eflags: 0x0
// Checksum 0x2f24cb7f, Offset: 0x268
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace sr_perk_machine_choice/sr_perk_machine_choice
// Params 1, eflags: 0x0
// Checksum 0xfe358745, Offset: 0x290
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_perk_machine_choice/sr_perk_machine_choice
// Params 1, eflags: 0x0
// Checksum 0x3a06b5f7, Offset: 0x2b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

