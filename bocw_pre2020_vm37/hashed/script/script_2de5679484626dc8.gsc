#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_dac_challenges_hud;

// Namespace zm_dac_challenges_hud
// Method(s) 16 Total 23
class czm_dac_challenges_hud : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x42a321b9, Offset: 0x898
    // Size: 0x44
    function set_binlocation(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "bInLocation", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa03223cd, Offset: 0x660
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xffef6675, Offset: 0x7f8
    // Size: 0x44
    function set_challengetext(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "challengeText", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x807477da, Offset: 0x848
    // Size: 0x44
    function set_bottomtext(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "bottomText", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3655e890, Offset: 0x980
    // Size: 0x44
    function set_rewardhidden(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "rewardHidden", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa7c571f6, Offset: 0x6a8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 0, eflags: 0x1 linked
    // Checksum 0x87eb854e, Offset: 0x480
    // Size: 0x1d4
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_dac_challenges_hud");
        cluielem::add_clientfield("_state", 1, 2, "int");
        cluielem::function_dcb34c80("string", "challengeText", 1);
        cluielem::function_dcb34c80("string", "bottomText", 1);
        cluielem::add_clientfield("bInLocation", 1, 1, "int");
        cluielem::add_clientfield("progress", 1, 1, "counter");
        cluielem::add_clientfield("tributeAvailable", 1, 3, "int");
        cluielem::add_clientfield("rewardHidden", 1, 1, "int");
        cluielem::add_clientfield("challengeFailing", 1, 1, "int");
        cluielem::function_dcb34c80("string", "rewardText", 1);
        cluielem::add_clientfield("challengeTypeText", 1, 1, "int");
        cluielem::add_clientfield("showIntelRewardText", 1, 1, "int");
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0x642166df, Offset: 0x8e8
    // Size: 0x3c
    function increment_progress(player) {
        player clientfield::function_bb878fc3(var_d5213cbb, var_bf9c8c95, "progress");
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xef3928f4, Offset: 0x930
    // Size: 0x44
    function set_tributeavailable(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "tributeAvailable", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4267c15d, Offset: 0xa70
    // Size: 0x44
    function function_c079b98b(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "challengeTypeText", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6bb82d88, Offset: 0xac0
    // Size: 0x44
    function function_c21d733d(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showIntelRewardText", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x286962c6, Offset: 0x9d0
    // Size: 0x44
    function set_challengefailing(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "challengeFailing", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb82b9eed, Offset: 0x6d8
    // Size: 0x114
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"hash_6038b42ab4ce959d" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        if (#"hash_3045a78750b13a96" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 2);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd61285c5, Offset: 0xa20
    // Size: 0x44
    function function_f63ec96b(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "rewardText", value);
    }

}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 0, eflags: 0x1 linked
// Checksum 0xa241abef, Offset: 0x188
// Size: 0x34
function register() {
    elem = new czm_dac_challenges_hud();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xf9df25c3, Offset: 0x1c8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 1, eflags: 0x1 linked
// Checksum 0x94bac228, Offset: 0x208
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 1, eflags: 0x1 linked
// Checksum 0x2ab077a3, Offset: 0x230
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x6c46f716, Offset: 0x258
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x8b66ef1b, Offset: 0x288
// Size: 0x28
function set_challengetext(player, value) {
    [[ self ]]->set_challengetext(player, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x1735c4c9, Offset: 0x2b8
// Size: 0x28
function set_bottomtext(player, value) {
    [[ self ]]->set_bottomtext(player, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x1329996a, Offset: 0x2e8
// Size: 0x28
function set_binlocation(player, value) {
    [[ self ]]->set_binlocation(player, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 1, eflags: 0x1 linked
// Checksum 0x1669cdb, Offset: 0x318
// Size: 0x1c
function increment_progress(player) {
    [[ self ]]->increment_progress(player);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xb4ed7bdb, Offset: 0x340
// Size: 0x28
function set_tributeavailable(player, value) {
    [[ self ]]->set_tributeavailable(player, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xa2872afa, Offset: 0x370
// Size: 0x28
function set_rewardhidden(player, value) {
    [[ self ]]->set_rewardhidden(player, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x68b8d1ab, Offset: 0x3a0
// Size: 0x28
function set_challengefailing(player, value) {
    [[ self ]]->set_challengefailing(player, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x755da148, Offset: 0x3d0
// Size: 0x28
function function_f63ec96b(player, value) {
    [[ self ]]->function_f63ec96b(player, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x181c5b87, Offset: 0x400
// Size: 0x28
function function_c079b98b(player, value) {
    [[ self ]]->function_c079b98b(player, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x1935ccd2, Offset: 0x430
// Size: 0x28
function function_c21d733d(player, value) {
    [[ self ]]->function_c21d733d(player, value);
}

