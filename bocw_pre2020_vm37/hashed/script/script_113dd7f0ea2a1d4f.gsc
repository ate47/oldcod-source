#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace prototype_hud;

// Namespace prototype_hud
// Method(s) 31 Total 38
class cprototype_hud : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa4dd5385, Offset: 0x14e8
    // Size: 0x44
    function function_1ae171f(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "elementalpop_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5fd424a2, Offset: 0xcf0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6a43de36, Offset: 0xe58
    // Size: 0x44
    function set_fail_fanfare_visibility(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "fail_fanfare_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd1e1efc, Offset: 0x11c8
    // Size: 0x44
    function function_39bce8a1(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "plasmaticBurst_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xefc9d9dc, Offset: 0xf98
    // Size: 0x44
    function function_42b2f8b4(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "sr_score", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8d329c3b, Offset: 0x13a8
    // Size: 0x44
    function function_4dfb5783(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "objective_retrieval", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7759bee1, Offset: 0xdb8
    // Size: 0x44
    function set_objective_prompt_visibility(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "objective_prompt_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf30b1faa, Offset: 0x12b8
    // Size: 0x44
    function function_50510f94(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "sr_scrap", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5df8ac99, Offset: 0x1538
    // Size: 0x44
    function function_58ab28b5(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "electric_cherry_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd097e905, Offset: 0xd38
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb884f95b, Offset: 0x1088
    // Size: 0x44
    function function_63d25b40(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "speedcola_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf0883296, Offset: 0xef8
    // Size: 0x44
    function function_7491d6c5(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "main_objective_string", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x9bfd8210, Offset: 0xf48
    // Size: 0x44
    function function_817e4d10(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "active_obj_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7e0f0130, Offset: 0x1218
    // Size: 0x44
    function function_87cd5978(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "safehouse_claimed_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x105462ee, Offset: 0xfe8
    // Size: 0x44
    function function_887deed4(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "sr_score_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x96e8d6f1, Offset: 0xea8
    // Size: 0x44
    function function_8c3b3ce6(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "new_obj_fanfare_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 0, eflags: 0x1 linked
    // Checksum 0x847ba70c, Offset: 0x8b8
    // Size: 0x42c
    function setup_clientfields() {
        cluielem::setup_clientfields("prototype_hud");
        cluielem::function_dcb34c80("string", "active_objective_string", 1);
        cluielem::add_clientfield("objective_prompt_visibility", 1, 1, "int");
        cluielem::add_clientfield("fanfare_visibility", 1, 1, "int");
        cluielem::add_clientfield("fail_fanfare_visibility", 1, 1, "int");
        cluielem::add_clientfield("new_obj_fanfare_visibility", 1, 1, "int");
        cluielem::function_dcb34c80("string", "main_objective_string", 1);
        cluielem::add_clientfield("active_obj_visibility", 1, 1, "int");
        cluielem::add_clientfield("sr_score", 1, 3, "int");
        cluielem::add_clientfield("sr_score_vis", 1, 1, "int");
        cluielem::add_clientfield("juggernog_perk_vis", 1, 1, "int");
        cluielem::add_clientfield("speedcola_perk_vis", 1, 1, "int");
        cluielem::add_clientfield("quickrevive_perk_vis", 1, 1, "int");
        cluielem::add_clientfield("staminup_perk_vis", 1, 1, "int");
        cluielem::add_clientfield("frostbite_vis", 1, 1, "int");
        cluielem::add_clientfield("plasmaticBurst_vis", 1, 1, "int");
        cluielem::add_clientfield("safehouse_claimed_vis", 1, 1, "int");
        cluielem::add_clientfield("deadshot_perk_vis", 1, 1, "int");
        cluielem::add_clientfield("sr_scrap", 1, 3, "int");
        cluielem::add_clientfield("sr_scrap_vis", 1, 1, "int");
        cluielem::add_clientfield("pap_level", 1, 2, "int");
        cluielem::add_clientfield("objective_retrieval", 1, 1, "int");
        cluielem::add_clientfield("show_secure", 1, 1, "int");
        cluielem::add_clientfield("brainrot_vis", 1, 1, "int");
        cluielem::add_clientfield("deadwire_vis", 1, 1, "int");
        cluielem::add_clientfield("elementalpop_perk_vis", 1, 1, "int");
        cluielem::add_clientfield("electric_cherry_vis", 1, 1, "int");
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5a374291, Offset: 0x1178
    // Size: 0x44
    function function_91ad787e(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "frostbite_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x9baa7016, Offset: 0xd68
    // Size: 0x44
    function set_active_objective_string(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "active_objective_string", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2d64024f, Offset: 0x1308
    // Size: 0x44
    function function_9c9e8623(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "sr_scrap_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc1f8eb2b, Offset: 0x1128
    // Size: 0x44
    function function_aa1a1cab(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "staminup_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3dc01e08, Offset: 0x1498
    // Size: 0x44
    function function_b51e81a5(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "deadwire_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb1d7b5ad, Offset: 0x1448
    // Size: 0x44
    function function_b6156501(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "brainrot_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x15978b18, Offset: 0x1268
    // Size: 0x44
    function function_c8ecaa6e(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "deadshot_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb98e6278, Offset: 0xe08
    // Size: 0x44
    function set_fanfare_visibility(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "fanfare_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x1bc35aae, Offset: 0x1038
    // Size: 0x44
    function function_d2fbc8ea(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "juggernog_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xfd268114, Offset: 0x13f8
    // Size: 0x44
    function function_da4fba84(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "show_secure", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x85e74d5a, Offset: 0x10d8
    // Size: 0x44
    function function_e0aca7d1(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "quickrevive_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xbf58065d, Offset: 0x1358
    // Size: 0x44
    function function_f97ebde9(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "pap_level", value);
    }

}

// Namespace prototype_hud/prototype_hud
// Params 0, eflags: 0x1 linked
// Checksum 0x18e49413, Offset: 0x2e8
// Size: 0x34
function register() {
    elem = new cprototype_hud();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x35a9b000, Offset: 0x328
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace prototype_hud/prototype_hud
// Params 1, eflags: 0x0
// Checksum 0x8ae26129, Offset: 0x368
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace prototype_hud/prototype_hud
// Params 1, eflags: 0x1 linked
// Checksum 0x7830f9a3, Offset: 0x390
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x2fe2b3e9, Offset: 0x3b8
// Size: 0x28
function set_active_objective_string(player, value) {
    [[ self ]]->set_active_objective_string(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xe2677d18, Offset: 0x3e8
// Size: 0x28
function set_objective_prompt_visibility(player, value) {
    [[ self ]]->set_objective_prompt_visibility(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xe62e4eff, Offset: 0x418
// Size: 0x28
function set_fanfare_visibility(player, value) {
    [[ self ]]->set_fanfare_visibility(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xbb91f8ef, Offset: 0x448
// Size: 0x28
function set_fail_fanfare_visibility(player, value) {
    [[ self ]]->set_fail_fanfare_visibility(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x4ec5a9ec, Offset: 0x478
// Size: 0x28
function function_8c3b3ce6(player, value) {
    [[ self ]]->function_8c3b3ce6(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xbd7a50bc, Offset: 0x4a8
// Size: 0x28
function function_7491d6c5(player, value) {
    [[ self ]]->function_7491d6c5(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x800f9b4a, Offset: 0x4d8
// Size: 0x28
function function_817e4d10(player, value) {
    [[ self ]]->function_817e4d10(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xd3f60cac, Offset: 0x508
// Size: 0x28
function function_42b2f8b4(player, value) {
    [[ self ]]->function_42b2f8b4(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xa0b06c84, Offset: 0x538
// Size: 0x28
function function_887deed4(player, value) {
    [[ self ]]->function_887deed4(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xc7dd60f2, Offset: 0x568
// Size: 0x28
function function_d2fbc8ea(player, value) {
    [[ self ]]->function_d2fbc8ea(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x5779e8cd, Offset: 0x598
// Size: 0x28
function function_63d25b40(player, value) {
    [[ self ]]->function_63d25b40(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x6e0e1650, Offset: 0x5c8
// Size: 0x28
function function_e0aca7d1(player, value) {
    [[ self ]]->function_e0aca7d1(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x635403f0, Offset: 0x5f8
// Size: 0x28
function function_aa1a1cab(player, value) {
    [[ self ]]->function_aa1a1cab(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x6a63878d, Offset: 0x628
// Size: 0x28
function function_91ad787e(player, value) {
    [[ self ]]->function_91ad787e(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x7ffa0472, Offset: 0x658
// Size: 0x28
function function_39bce8a1(player, value) {
    [[ self ]]->function_39bce8a1(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x94e1f6d, Offset: 0x688
// Size: 0x28
function function_87cd5978(player, value) {
    [[ self ]]->function_87cd5978(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xb487bbf3, Offset: 0x6b8
// Size: 0x28
function function_c8ecaa6e(player, value) {
    [[ self ]]->function_c8ecaa6e(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xdda79e17, Offset: 0x6e8
// Size: 0x28
function function_50510f94(player, value) {
    [[ self ]]->function_50510f94(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xe0af0897, Offset: 0x718
// Size: 0x28
function function_9c9e8623(player, value) {
    [[ self ]]->function_9c9e8623(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xe1d10003, Offset: 0x748
// Size: 0x28
function function_f97ebde9(player, value) {
    [[ self ]]->function_f97ebde9(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xaafa6efa, Offset: 0x778
// Size: 0x28
function function_4dfb5783(player, value) {
    [[ self ]]->function_4dfb5783(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xaa5d1564, Offset: 0x7a8
// Size: 0x28
function function_da4fba84(player, value) {
    [[ self ]]->function_da4fba84(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xc08bf26, Offset: 0x7d8
// Size: 0x28
function function_b6156501(player, value) {
    [[ self ]]->function_b6156501(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x86381d69, Offset: 0x808
// Size: 0x28
function function_b51e81a5(player, value) {
    [[ self ]]->function_b51e81a5(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x4afe319d, Offset: 0x838
// Size: 0x28
function function_1ae171f(player, value) {
    [[ self ]]->function_1ae171f(player, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x8aac9ea1, Offset: 0x868
// Size: 0x28
function function_58ab28b5(player, value) {
    [[ self ]]->function_58ab28b5(player, value);
}

