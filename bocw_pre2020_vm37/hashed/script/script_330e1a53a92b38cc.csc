#using scripts\core_common\lui_shared;

#namespace mp_revive_prompt;

// Namespace mp_revive_prompt
// Method(s) 9 Total 15
class cmp_revive_prompt : cluielem {

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x8d6034c9, Offset: 0x568
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x8b03004c, Offset: 0x598
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientnum", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x3d339801, Offset: 0x608
    // Size: 0x30
    function set_reviveprogress(localclientnum, value) {
        set_data(localclientnum, "reviveProgress", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 0, eflags: 0x0
    // Checksum 0xe2b9f4fc, Offset: 0x4b0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("mp_revive_prompt");
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 4, eflags: 0x0
    // Checksum 0xf2427af3, Offset: 0x3f0
    // Size: 0xb4
    function setup_clientfields(var_c05c67e2, healthcallback, var_d65e5a18, *var_f228b5fa) {
        cluielem::setup_clientfields("mp_revive_prompt");
        cluielem::add_clientfield("clientnum", 1, 7, "int", healthcallback);
        cluielem::add_clientfield("health", 1, 5, "float", var_d65e5a18);
        cluielem::add_clientfield("reviveProgress", 1, 5, "float", var_f228b5fa);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xc1b7bee2, Offset: 0x5d0
    // Size: 0x30
    function set_health(localclientnum, value) {
        set_data(localclientnum, "health", value);
    }

    // Namespace cmp_revive_prompt/mp_revive_prompt
    // Params 1, eflags: 0x0
    // Checksum 0xa8728ca3, Offset: 0x4d8
    // Size: 0x88
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "clientnum", 0);
        set_data(localclientnum, "health", 0);
        set_data(localclientnum, "reviveProgress", 0);
    }

}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 4, eflags: 0x0
// Checksum 0xd0afacb, Offset: 0xe8
// Size: 0x196
function register(var_c05c67e2, healthcallback, var_d65e5a18, var_f228b5fa) {
    elem = new cmp_revive_prompt();
    [[ elem ]]->setup_clientfields(var_c05c67e2, healthcallback, var_d65e5a18, var_f228b5fa);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"mp_revive_prompt"])) {
        level.var_ae746e8f[#"mp_revive_prompt"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"mp_revive_prompt"])) {
        level.var_ae746e8f[#"mp_revive_prompt"] = [];
    } else if (!isarray(level.var_ae746e8f[#"mp_revive_prompt"])) {
        level.var_ae746e8f[#"mp_revive_prompt"] = array(level.var_ae746e8f[#"mp_revive_prompt"]);
    }
    level.var_ae746e8f[#"mp_revive_prompt"][level.var_ae746e8f[#"mp_revive_prompt"].size] = elem;
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 0, eflags: 0x0
// Checksum 0x4ff8ddba, Offset: 0x288
// Size: 0x34
function register_clientside() {
    elem = new cmp_revive_prompt();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x5625522c, Offset: 0x2c8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x6daf34d2, Offset: 0x2f0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 1, eflags: 0x0
// Checksum 0x4536bcd4, Offset: 0x318
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xfd922b32, Offset: 0x340
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0x9614490f, Offset: 0x370
// Size: 0x28
function set_health(localclientnum, value) {
    [[ self ]]->set_health(localclientnum, value);
}

// Namespace mp_revive_prompt/mp_revive_prompt
// Params 2, eflags: 0x0
// Checksum 0xa72d5e6b, Offset: 0x3a0
// Size: 0x28
function set_reviveprogress(localclientnum, value) {
    [[ self ]]->set_reviveprogress(localclientnum, value);
}

