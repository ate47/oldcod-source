#using scripts\core_common\lui_shared;

#namespace prototype_hud;

// Namespace prototype_hud
// Method(s) 32 Total 38
class cprototype_hud : cluielem {

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xab51474c, Offset: 0x18d0
    // Size: 0x30
    function function_1ae171f(localclientnum, value) {
        set_data(localclientnum, "elementalpop_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0xef688d03, Offset: 0x1360
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7b83d797, Offset: 0x1438
    // Size: 0x30
    function set_fail_fanfare_visibility(localclientnum, value) {
        set_data(localclientnum, "fail_fanfare_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6b5183a1, Offset: 0x16a0
    // Size: 0x30
    function function_39bce8a1(localclientnum, value) {
        set_data(localclientnum, "plasmaticBurst_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x54ac673, Offset: 0x1518
    // Size: 0x30
    function function_42b2f8b4(localclientnum, value) {
        set_data(localclientnum, "sr_score", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x166509c5, Offset: 0x17f0
    // Size: 0x30
    function function_4dfb5783(localclientnum, value) {
        set_data(localclientnum, "objective_retrieval", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x486aa154, Offset: 0x13c8
    // Size: 0x30
    function set_objective_prompt_visibility(localclientnum, value) {
        set_data(localclientnum, "objective_prompt_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xda869a20, Offset: 0x1748
    // Size: 0x30
    function function_50510f94(localclientnum, value) {
        set_data(localclientnum, "sr_scrap", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xfcc13fed, Offset: 0x1908
    // Size: 0x30
    function function_58ab28b5(localclientnum, value) {
        set_data(localclientnum, "electric_cherry_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 0, eflags: 0x1 linked
    // Checksum 0x65b7e693, Offset: 0x1018
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("prototype_hud");
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xe3a9fc3b, Offset: 0x15c0
    // Size: 0x30
    function function_63d25b40(localclientnum, value) {
        set_data(localclientnum, "speedcola_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xda7fb7d8, Offset: 0x14a8
    // Size: 0x30
    function function_7491d6c5(localclientnum, value) {
        set_data(localclientnum, "main_objective_string", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x41d1b9e6, Offset: 0x14e0
    // Size: 0x30
    function function_817e4d10(localclientnum, value) {
        set_data(localclientnum, "active_obj_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf92b3dac, Offset: 0x16d8
    // Size: 0x30
    function function_87cd5978(localclientnum, value) {
        set_data(localclientnum, "safehouse_claimed_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4540e63b, Offset: 0x1550
    // Size: 0x30
    function function_887deed4(localclientnum, value) {
        set_data(localclientnum, "sr_score_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x201e2c48, Offset: 0x1470
    // Size: 0x30
    function function_8c3b3ce6(localclientnum, value) {
        set_data(localclientnum, "new_obj_fanfare_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 26, eflags: 0x1 linked
    // Checksum 0xeb3c59bb, Offset: 0xb10
    // Size: 0x4fc
    function setup_clientfields(*var_532cdc1a, var_7a99f2e1, var_b5ae72b8, var_2b966169, var_f16d8f66, *var_8b49b908, var_e16cbdb9, var_118baa9c, var_a3e07062, var_a56fa4ae, var_be404169, var_45eb6dcd, var_8ac6deea, var_3d7d82d8, var_a8f182ca, var_3eddf86f, var_3a7491dd, var_bcbdeb9e, var_eb3e8975, var_18f1dd43, var_ac373a00, var_a491b704, var_31351835, var_1f456b34, var_ee28fade, var_7955d0b1) {
        cluielem::setup_clientfields("prototype_hud");
        cluielem::function_dcb34c80("string", "active_objective_string", 1);
        cluielem::add_clientfield("objective_prompt_visibility", 1, 1, "int", var_b5ae72b8);
        cluielem::add_clientfield("fanfare_visibility", 1, 1, "int", var_2b966169);
        cluielem::add_clientfield("fail_fanfare_visibility", 1, 1, "int", var_f16d8f66);
        cluielem::add_clientfield("new_obj_fanfare_visibility", 1, 1, "int", var_8b49b908);
        cluielem::function_dcb34c80("string", "main_objective_string", 1);
        cluielem::add_clientfield("active_obj_visibility", 1, 1, "int", var_e16cbdb9);
        cluielem::add_clientfield("sr_score", 1, 3, "int", var_118baa9c);
        cluielem::add_clientfield("sr_score_vis", 1, 1, "int", var_a3e07062);
        cluielem::add_clientfield("juggernog_perk_vis", 1, 1, "int", var_a56fa4ae);
        cluielem::add_clientfield("speedcola_perk_vis", 1, 1, "int", var_be404169);
        cluielem::add_clientfield("quickrevive_perk_vis", 1, 1, "int", var_45eb6dcd);
        cluielem::add_clientfield("staminup_perk_vis", 1, 1, "int", var_8ac6deea);
        cluielem::add_clientfield("frostbite_vis", 1, 1, "int", var_3d7d82d8);
        cluielem::add_clientfield("plasmaticBurst_vis", 1, 1, "int", var_a8f182ca);
        cluielem::add_clientfield("safehouse_claimed_vis", 1, 1, "int", var_3eddf86f);
        cluielem::add_clientfield("deadshot_perk_vis", 1, 1, "int", var_3a7491dd);
        cluielem::add_clientfield("sr_scrap", 1, 3, "int", var_bcbdeb9e);
        cluielem::add_clientfield("sr_scrap_vis", 1, 1, "int", var_eb3e8975);
        cluielem::add_clientfield("pap_level", 1, 2, "int", var_18f1dd43);
        cluielem::add_clientfield("objective_retrieval", 1, 1, "int", var_ac373a00);
        cluielem::add_clientfield("show_secure", 1, 1, "int", var_a491b704);
        cluielem::add_clientfield("brainrot_vis", 1, 1, "int", var_31351835);
        cluielem::add_clientfield("deadwire_vis", 1, 1, "int", var_1f456b34);
        cluielem::add_clientfield("elementalpop_perk_vis", 1, 1, "int", var_ee28fade);
        cluielem::add_clientfield("electric_cherry_vis", 1, 1, "int", var_7955d0b1);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x32503a61, Offset: 0x1668
    // Size: 0x30
    function function_91ad787e(localclientnum, value) {
        set_data(localclientnum, "frostbite_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa790523, Offset: 0x1390
    // Size: 0x30
    function set_active_objective_string(localclientnum, value) {
        set_data(localclientnum, "active_objective_string", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb8e23401, Offset: 0x1780
    // Size: 0x30
    function function_9c9e8623(localclientnum, value) {
        set_data(localclientnum, "sr_scrap_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x55b29444, Offset: 0x1630
    // Size: 0x30
    function function_aa1a1cab(localclientnum, value) {
        set_data(localclientnum, "staminup_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4b7dbd78, Offset: 0x1898
    // Size: 0x30
    function function_b51e81a5(localclientnum, value) {
        set_data(localclientnum, "deadwire_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x78b4c61, Offset: 0x1860
    // Size: 0x30
    function function_b6156501(localclientnum, value) {
        set_data(localclientnum, "brainrot_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7b1086f4, Offset: 0x1710
    // Size: 0x30
    function function_c8ecaa6e(localclientnum, value) {
        set_data(localclientnum, "deadshot_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x78a9775c, Offset: 0x1400
    // Size: 0x30
    function set_fanfare_visibility(localclientnum, value) {
        set_data(localclientnum, "fanfare_visibility", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa06d57d9, Offset: 0x1588
    // Size: 0x30
    function function_d2fbc8ea(localclientnum, value) {
        set_data(localclientnum, "juggernog_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc4774260, Offset: 0x1828
    // Size: 0x30
    function function_da4fba84(localclientnum, value) {
        set_data(localclientnum, "show_secure", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xcb661c8b, Offset: 0x15f8
    // Size: 0x30
    function function_e0aca7d1(localclientnum, value) {
        set_data(localclientnum, "quickrevive_perk_vis", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x30900c16, Offset: 0x17b8
    // Size: 0x30
    function function_f97ebde9(localclientnum, value) {
        set_data(localclientnum, "pap_level", value);
    }

    // Namespace cprototype_hud/prototype_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd40e8e89, Offset: 0x1040
    // Size: 0x314
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "active_objective_string", #"");
        set_data(localclientnum, "objective_prompt_visibility", 0);
        set_data(localclientnum, "fanfare_visibility", 0);
        set_data(localclientnum, "fail_fanfare_visibility", 0);
        set_data(localclientnum, "new_obj_fanfare_visibility", 0);
        set_data(localclientnum, "main_objective_string", #"");
        set_data(localclientnum, "active_obj_visibility", 0);
        set_data(localclientnum, "sr_score", 0);
        set_data(localclientnum, "sr_score_vis", 0);
        set_data(localclientnum, "juggernog_perk_vis", 0);
        set_data(localclientnum, "speedcola_perk_vis", 0);
        set_data(localclientnum, "quickrevive_perk_vis", 0);
        set_data(localclientnum, "staminup_perk_vis", 0);
        set_data(localclientnum, "frostbite_vis", 0);
        set_data(localclientnum, "plasmaticBurst_vis", 0);
        set_data(localclientnum, "safehouse_claimed_vis", 0);
        set_data(localclientnum, "deadshot_perk_vis", 0);
        set_data(localclientnum, "sr_scrap", 0);
        set_data(localclientnum, "sr_scrap_vis", 0);
        set_data(localclientnum, "pap_level", 0);
        set_data(localclientnum, "objective_retrieval", 0);
        set_data(localclientnum, "show_secure", 0);
        set_data(localclientnum, "brainrot_vis", 0);
        set_data(localclientnum, "deadwire_vis", 0);
        set_data(localclientnum, "elementalpop_perk_vis", 0);
        set_data(localclientnum, "electric_cherry_vis", 0);
    }

}

// Namespace prototype_hud/prototype_hud
// Params 26, eflags: 0x1 linked
// Checksum 0xbd2284ce, Offset: 0x2e0
// Size: 0x26e
function register(var_532cdc1a, var_7a99f2e1, var_b5ae72b8, var_2b966169, var_f16d8f66, var_8b49b908, var_e16cbdb9, var_118baa9c, var_a3e07062, var_a56fa4ae, var_be404169, var_45eb6dcd, var_8ac6deea, var_3d7d82d8, var_a8f182ca, var_3eddf86f, var_3a7491dd, var_bcbdeb9e, var_eb3e8975, var_18f1dd43, var_ac373a00, var_a491b704, var_31351835, var_1f456b34, var_ee28fade, var_7955d0b1) {
    elem = new cprototype_hud();
    [[ elem ]]->setup_clientfields(var_532cdc1a, var_7a99f2e1, var_b5ae72b8, var_2b966169, var_f16d8f66, var_8b49b908, var_e16cbdb9, var_118baa9c, var_a3e07062, var_a56fa4ae, var_be404169, var_45eb6dcd, var_8ac6deea, var_3d7d82d8, var_a8f182ca, var_3eddf86f, var_3a7491dd, var_bcbdeb9e, var_eb3e8975, var_18f1dd43, var_ac373a00, var_a491b704, var_31351835, var_1f456b34, var_ee28fade, var_7955d0b1);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"prototype_hud"])) {
        level.var_ae746e8f[#"prototype_hud"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"prototype_hud"])) {
        level.var_ae746e8f[#"prototype_hud"] = [];
    } else if (!isarray(level.var_ae746e8f[#"prototype_hud"])) {
        level.var_ae746e8f[#"prototype_hud"] = array(level.var_ae746e8f[#"prototype_hud"]);
    }
    level.var_ae746e8f[#"prototype_hud"][level.var_ae746e8f[#"prototype_hud"].size] = elem;
}

// Namespace prototype_hud/prototype_hud
// Params 0, eflags: 0x0
// Checksum 0x6c0cfd1c, Offset: 0x558
// Size: 0x34
function register_clientside() {
    elem = new cprototype_hud();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace prototype_hud/prototype_hud
// Params 1, eflags: 0x0
// Checksum 0xbe449201, Offset: 0x598
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace prototype_hud/prototype_hud
// Params 1, eflags: 0x0
// Checksum 0xb2782b06, Offset: 0x5c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace prototype_hud/prototype_hud
// Params 1, eflags: 0x0
// Checksum 0x79066f6e, Offset: 0x5e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x83ef4be, Offset: 0x610
// Size: 0x28
function set_active_objective_string(localclientnum, value) {
    [[ self ]]->set_active_objective_string(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x4fa63ce2, Offset: 0x640
// Size: 0x28
function set_objective_prompt_visibility(localclientnum, value) {
    [[ self ]]->set_objective_prompt_visibility(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x32884606, Offset: 0x670
// Size: 0x28
function set_fanfare_visibility(localclientnum, value) {
    [[ self ]]->set_fanfare_visibility(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xcff481a2, Offset: 0x6a0
// Size: 0x28
function set_fail_fanfare_visibility(localclientnum, value) {
    [[ self ]]->set_fail_fanfare_visibility(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x459e96c5, Offset: 0x6d0
// Size: 0x28
function function_8c3b3ce6(localclientnum, value) {
    [[ self ]]->function_8c3b3ce6(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xb894aa93, Offset: 0x700
// Size: 0x28
function function_7491d6c5(localclientnum, value) {
    [[ self ]]->function_7491d6c5(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xc7626750, Offset: 0x730
// Size: 0x28
function function_817e4d10(localclientnum, value) {
    [[ self ]]->function_817e4d10(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xa22aa91f, Offset: 0x760
// Size: 0x28
function function_42b2f8b4(localclientnum, value) {
    [[ self ]]->function_42b2f8b4(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x6b0a92d4, Offset: 0x790
// Size: 0x28
function function_887deed4(localclientnum, value) {
    [[ self ]]->function_887deed4(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xae7010b0, Offset: 0x7c0
// Size: 0x28
function function_d2fbc8ea(localclientnum, value) {
    [[ self ]]->function_d2fbc8ea(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x86bbf241, Offset: 0x7f0
// Size: 0x28
function function_63d25b40(localclientnum, value) {
    [[ self ]]->function_63d25b40(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x41c44778, Offset: 0x820
// Size: 0x28
function function_e0aca7d1(localclientnum, value) {
    [[ self ]]->function_e0aca7d1(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x7bbd0618, Offset: 0x850
// Size: 0x28
function function_aa1a1cab(localclientnum, value) {
    [[ self ]]->function_aa1a1cab(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x69b78dbc, Offset: 0x880
// Size: 0x28
function function_91ad787e(localclientnum, value) {
    [[ self ]]->function_91ad787e(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xc00c5934, Offset: 0x8b0
// Size: 0x28
function function_39bce8a1(localclientnum, value) {
    [[ self ]]->function_39bce8a1(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x768017d2, Offset: 0x8e0
// Size: 0x28
function function_87cd5978(localclientnum, value) {
    [[ self ]]->function_87cd5978(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x882ed469, Offset: 0x910
// Size: 0x28
function function_c8ecaa6e(localclientnum, value) {
    [[ self ]]->function_c8ecaa6e(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x6786de29, Offset: 0x940
// Size: 0x28
function function_50510f94(localclientnum, value) {
    [[ self ]]->function_50510f94(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x1e21332f, Offset: 0x970
// Size: 0x28
function function_9c9e8623(localclientnum, value) {
    [[ self ]]->function_9c9e8623(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x4680531, Offset: 0x9a0
// Size: 0x28
function function_f97ebde9(localclientnum, value) {
    [[ self ]]->function_f97ebde9(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x9eda19fa, Offset: 0x9d0
// Size: 0x28
function function_4dfb5783(localclientnum, value) {
    [[ self ]]->function_4dfb5783(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xc19d80c6, Offset: 0xa00
// Size: 0x28
function function_da4fba84(localclientnum, value) {
    [[ self ]]->function_da4fba84(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xdfd96c7f, Offset: 0xa30
// Size: 0x28
function function_b6156501(localclientnum, value) {
    [[ self ]]->function_b6156501(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0x44988d89, Offset: 0xa60
// Size: 0x28
function function_b51e81a5(localclientnum, value) {
    [[ self ]]->function_b51e81a5(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xc95be466, Offset: 0xa90
// Size: 0x28
function function_1ae171f(localclientnum, value) {
    [[ self ]]->function_1ae171f(localclientnum, value);
}

// Namespace prototype_hud/prototype_hud
// Params 2, eflags: 0x0
// Checksum 0xc486382b, Offset: 0xac0
// Size: 0x28
function function_58ab28b5(localclientnum, value) {
    [[ self ]]->function_58ab28b5(localclientnum, value);
}

