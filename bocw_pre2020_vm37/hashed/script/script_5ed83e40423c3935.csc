#using scripts\core_common\lui_shared;

#namespace wz_revive_prompt;

// Namespace wz_revive_prompt
// Method(s) 10 Total 16
class cwz_revive_prompt : cluielem {

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x974a7474, Offset: 0x608
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x4c14cd5f, Offset: 0x638
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientnum", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x57b0611d, Offset: 0x6a8
    // Size: 0x30
    function set_reviveprogress(localclientnum, value) {
        set_data(localclientnum, "reviveProgress", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 0, eflags: 0x0
    // Checksum 0x1a67421, Offset: 0x530
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("wz_revive_prompt");
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 6, eflags: 0x0
    // Checksum 0x96609b10, Offset: 0x438
    // Size: 0xec
    function setup_clientfields(var_c05c67e2, healthcallback, var_d65e5a18, *var_f228b5fa, var_7cb8f98a, *var_bda3bf84) {
        cluielem::setup_clientfields("wz_revive_prompt");
        cluielem::add_clientfield("clientnum", 1, 7, "int", var_d65e5a18);
        cluielem::add_clientfield("health", 1, 5, "float", var_f228b5fa);
        cluielem::add_clientfield("reviveProgress", 1, 5, "float", var_7cb8f98a);
        cluielem::add_clientfield("cowardsWay", 1, 1, "int", var_bda3bf84);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x18ef3d1a, Offset: 0x6e0
    // Size: 0x30
    function set_cowardsway(localclientnum, value) {
        set_data(localclientnum, "cowardsWay", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xc62bf453, Offset: 0x670
    // Size: 0x30
    function set_health(localclientnum, value) {
        set_data(localclientnum, "health", value);
    }

    // Namespace cwz_revive_prompt/wz_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0xfaf3b286, Offset: 0x558
    // Size: 0xa4
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "clientnum", 0);
        set_data(localclientnum, "health", 0);
        set_data(localclientnum, "reviveProgress", 0);
        set_data(localclientnum, "cowardsWay", 0);
    }

}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 6, eflags: 0x0
// Checksum 0x568e640f, Offset: 0xf0
// Size: 0x1a6
function register(var_c05c67e2, healthcallback, var_d65e5a18, var_f228b5fa, var_7cb8f98a, var_bda3bf84) {
    elem = new cwz_revive_prompt();
    [[ elem ]]->setup_clientfields(var_c05c67e2, healthcallback, var_d65e5a18, var_f228b5fa, var_7cb8f98a, var_bda3bf84);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"wz_revive_prompt"])) {
        level.var_ae746e8f[#"wz_revive_prompt"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"wz_revive_prompt"])) {
        level.var_ae746e8f[#"wz_revive_prompt"] = [];
    } else if (!isarray(level.var_ae746e8f[#"wz_revive_prompt"])) {
        level.var_ae746e8f[#"wz_revive_prompt"] = array(level.var_ae746e8f[#"wz_revive_prompt"]);
    }
    level.var_ae746e8f[#"wz_revive_prompt"][level.var_ae746e8f[#"wz_revive_prompt"].size] = elem;
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 0, eflags: 0x0
// Checksum 0x7809696e, Offset: 0x2a0
// Size: 0x34
function register_clientside() {
    elem = new cwz_revive_prompt();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0xe301ce1d, Offset: 0x2e0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0xd36c07a, Offset: 0x308
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0xb58c6706, Offset: 0x330
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xc6bdfc4c, Offset: 0x358
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x36cbd965, Offset: 0x388
// Size: 0x28
function set_health(localclientnum, value) {
    [[ self ]]->set_health(localclientnum, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x7f15f54a, Offset: 0x3b8
// Size: 0x28
function set_reviveprogress(localclientnum, value) {
    [[ self ]]->set_reviveprogress(localclientnum, value);
}

// Namespace wz_revive_prompt/wz_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xced815d4, Offset: 0x3e8
// Size: 0x28
function set_cowardsway(localclientnum, value) {
    [[ self ]]->set_cowardsway(localclientnum, value);
}
