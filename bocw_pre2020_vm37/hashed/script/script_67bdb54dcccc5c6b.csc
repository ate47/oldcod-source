#using scripts\core_common\lui_shared;

#namespace sr_vote_prompt;

// Namespace sr_vote_prompt
// Method(s) 12 Total 18
class class_7ea39903 : cluielem {

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 1, eflags: 0x1 linked
    // Checksum 0x47541923, Offset: 0x730
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd903d83b, Offset: 0x7d0
    // Size: 0x30
    function function_1dc82d57(localclientnum, value) {
        set_data(localclientnum, "vote_accepted", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 0, eflags: 0x1 linked
    // Checksum 0x52f18cdc, Offset: 0x618
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("sr_vote_prompt");
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd63e5da9, Offset: 0x808
    // Size: 0x30
    function function_7308be62(localclientnum, value) {
        set_data(localclientnum, "vote_header", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 6, eflags: 0x1 linked
    // Checksum 0x1966edc6, Offset: 0x4d0
    // Size: 0x13c
    function setup_clientfields(var_318bbc08, var_cf01dc47, var_de68d865, *var_df922664, var_9fc69c5a, var_9e92dcaa) {
        cluielem::setup_clientfields("sr_vote_prompt");
        cluielem::add_clientfield("vote_progress", 1, 8, "float", var_cf01dc47);
        cluielem::add_clientfield("vote_starter", 1, 7, "int", var_de68d865);
        cluielem::add_clientfield("vote_accepted", 1, 1, "int", var_df922664);
        cluielem::function_dcb34c80("string", "vote_header", 1);
        cluielem::add_clientfield("vote_show_button", 1, 1, "int", var_9fc69c5a);
        cluielem::add_clientfield("vote_show_key", 1, 1, "int", var_9e92dcaa);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2afcbe44, Offset: 0x760
    // Size: 0x30
    function function_9d1ae78b(localclientnum, value) {
        set_data(localclientnum, "vote_progress", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8add78a9, Offset: 0x798
    // Size: 0x30
    function function_cd2610bc(localclientnum, value) {
        set_data(localclientnum, "vote_starter", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0x9d00f11e, Offset: 0x878
    // Size: 0x30
    function function_ed78f536(localclientnum, value) {
        set_data(localclientnum, "vote_show_key", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0xae414c98, Offset: 0x840
    // Size: 0x30
    function function_ee141c89(localclientnum, value) {
        set_data(localclientnum, "vote_show_button", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5f97ec79, Offset: 0x640
    // Size: 0xe4
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "vote_progress", 0);
        set_data(localclientnum, "vote_starter", 0);
        set_data(localclientnum, "vote_accepted", 0);
        set_data(localclientnum, "vote_header", #"");
        set_data(localclientnum, "vote_show_button", 0);
        set_data(localclientnum, "vote_show_key", 0);
    }

}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 6, eflags: 0x1 linked
// Checksum 0x1c6a12cf, Offset: 0x128
// Size: 0x1a6
function register(var_318bbc08, var_cf01dc47, var_de68d865, var_df922664, var_9fc69c5a, var_9e92dcaa) {
    elem = new class_7ea39903();
    [[ elem ]]->setup_clientfields(var_318bbc08, var_cf01dc47, var_de68d865, var_df922664, var_9fc69c5a, var_9e92dcaa);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"sr_vote_prompt"])) {
        level.var_ae746e8f[#"sr_vote_prompt"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"sr_vote_prompt"])) {
        level.var_ae746e8f[#"sr_vote_prompt"] = [];
    } else if (!isarray(level.var_ae746e8f[#"sr_vote_prompt"])) {
        level.var_ae746e8f[#"sr_vote_prompt"] = array(level.var_ae746e8f[#"sr_vote_prompt"]);
    }
    level.var_ae746e8f[#"sr_vote_prompt"][level.var_ae746e8f[#"sr_vote_prompt"].size] = elem;
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 0, eflags: 0x0
// Checksum 0x26412470, Offset: 0x2d8
// Size: 0x34
function register_clientside() {
    elem = new class_7ea39903();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 1, eflags: 0x0
// Checksum 0x4655f43f, Offset: 0x318
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 1, eflags: 0x0
// Checksum 0x53fab3d4, Offset: 0x340
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 1, eflags: 0x0
// Checksum 0x9aef82a9, Offset: 0x368
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x0
// Checksum 0x4bbdeea0, Offset: 0x390
// Size: 0x28
function function_9d1ae78b(localclientnum, value) {
    [[ self ]]->function_9d1ae78b(localclientnum, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x0
// Checksum 0x2ac8241f, Offset: 0x3c0
// Size: 0x28
function function_cd2610bc(localclientnum, value) {
    [[ self ]]->function_cd2610bc(localclientnum, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x0
// Checksum 0xf25c0667, Offset: 0x3f0
// Size: 0x28
function function_1dc82d57(localclientnum, value) {
    [[ self ]]->function_1dc82d57(localclientnum, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x0
// Checksum 0xe645d4a, Offset: 0x420
// Size: 0x28
function function_7308be62(localclientnum, value) {
    [[ self ]]->function_7308be62(localclientnum, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x0
// Checksum 0x4994680a, Offset: 0x450
// Size: 0x28
function function_ee141c89(localclientnum, value) {
    [[ self ]]->function_ee141c89(localclientnum, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x0
// Checksum 0x43f65835, Offset: 0x480
// Size: 0x28
function function_ed78f536(localclientnum, value) {
    [[ self ]]->function_ed78f536(localclientnum, value);
}

