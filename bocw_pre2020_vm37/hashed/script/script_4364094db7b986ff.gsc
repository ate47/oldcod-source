#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace sr_vote_prompt;

// Namespace sr_vote_prompt
// Method(s) 11 Total 18
class class_7ea39903 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0xdc827c55, Offset: 0x458
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd3c9d541, Offset: 0x570
    // Size: 0x44
    function function_1dc82d57(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "vote_accepted", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3f8595f6, Offset: 0x4a0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0x68040e75, Offset: 0x5c0
    // Size: 0x44
    function function_7308be62(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "vote_header", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc4664f42, Offset: 0x340
    // Size: 0x10c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_vote_prompt");
        cluielem::add_clientfield("vote_progress", 1, 8, "float");
        cluielem::add_clientfield("vote_starter", 1, 7, "int");
        cluielem::add_clientfield("vote_accepted", 1, 1, "int");
        cluielem::function_dcb34c80("string", "vote_header", 1);
        cluielem::add_clientfield("vote_show_button", 1, 1, "int");
        cluielem::add_clientfield("vote_show_key", 1, 1, "int");
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8924ae89, Offset: 0x4d0
    // Size: 0x44
    function function_9d1ae78b(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "vote_progress", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0x50a868d8, Offset: 0x520
    // Size: 0x44
    function function_cd2610bc(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "vote_starter", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0x561abb6c, Offset: 0x660
    // Size: 0x44
    function function_ed78f536(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "vote_show_key", value);
    }

    // Namespace namespace_7ea39903/sr_vote_prompt
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb1a3ca4d, Offset: 0x610
    // Size: 0x44
    function function_ee141c89(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "vote_show_button", value);
    }

}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 0, eflags: 0x1 linked
// Checksum 0xa68d3e5c, Offset: 0x130
// Size: 0x34
function register() {
    elem = new class_7ea39903();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x1 linked
// Checksum 0xab93d0f6, Offset: 0x170
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 1, eflags: 0x1 linked
// Checksum 0x2f3c9e91, Offset: 0x1b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 1, eflags: 0x1 linked
// Checksum 0x54a16eec, Offset: 0x1d8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x1 linked
// Checksum 0x2bba9319, Offset: 0x200
// Size: 0x28
function function_9d1ae78b(player, value) {
    [[ self ]]->function_9d1ae78b(player, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x1 linked
// Checksum 0x4a9f578, Offset: 0x230
// Size: 0x28
function function_cd2610bc(player, value) {
    [[ self ]]->function_cd2610bc(player, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x1 linked
// Checksum 0x94273a2a, Offset: 0x260
// Size: 0x28
function function_1dc82d57(player, value) {
    [[ self ]]->function_1dc82d57(player, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x1 linked
// Checksum 0xc116c38f, Offset: 0x290
// Size: 0x28
function function_7308be62(player, value) {
    [[ self ]]->function_7308be62(player, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x1 linked
// Checksum 0xa0953f9d, Offset: 0x2c0
// Size: 0x28
function function_ee141c89(player, value) {
    [[ self ]]->function_ee141c89(player, value);
}

// Namespace sr_vote_prompt/sr_vote_prompt
// Params 2, eflags: 0x1 linked
// Checksum 0x32c81d9d, Offset: 0x2f0
// Size: 0x28
function function_ed78f536(player, value) {
    [[ self ]]->function_ed78f536(player, value);
}

