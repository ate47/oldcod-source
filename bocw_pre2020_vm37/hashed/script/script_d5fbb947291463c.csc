#using scripts\core_common\lui_shared;

#namespace zm_dac_challenges_hud;

// Namespace zm_dac_challenges_hud
// Method(s) 17 Total 23
class czm_dac_challenges_hud : cluielem {

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2e7439f7, Offset: 0xbb0
    // Size: 0x30
    function set_binlocation(localclientnum, value) {
        set_data(localclientnum, "bInLocation", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd9bf8da7, Offset: 0xa20
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc044b470, Offset: 0xb40
    // Size: 0x30
    function set_challengetext(localclientnum, value) {
        set_data(localclientnum, "challengeText", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7adbefdb, Offset: 0xb78
    // Size: 0x30
    function set_bottomtext(localclientnum, value) {
        set_data(localclientnum, "bottomText", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xed0b5b37, Offset: 0xc98
    // Size: 0x30
    function set_rewardhidden(localclientnum, value) {
        set_data(localclientnum, "rewardHidden", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdaa1ddc5, Offset: 0x868
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_dac_challenges_hud");
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 10, eflags: 0x1 linked
    // Checksum 0x5203dade, Offset: 0x638
    // Size: 0x224
    function setup_clientfields(*var_be2ad4d, *var_a7896263, var_4866daed, progresscallback, var_5d7491df, var_26df3d64, var_90359ec7, *var_2404f6c6, var_74cf4193, var_e89bb89d) {
        cluielem::setup_clientfields("zm_dac_challenges_hud");
        cluielem::add_clientfield("_state", 1, 2, "int");
        cluielem::function_dcb34c80("string", "challengeText", 1);
        cluielem::function_dcb34c80("string", "bottomText", 1);
        cluielem::add_clientfield("bInLocation", 1, 1, "int", progresscallback);
        cluielem::add_clientfield("progress", 1, 1, "counter", var_5d7491df);
        cluielem::add_clientfield("tributeAvailable", 1, 3, "int", var_26df3d64);
        cluielem::add_clientfield("rewardHidden", 1, 1, "int", var_90359ec7);
        cluielem::add_clientfield("challengeFailing", 1, 1, "int", var_2404f6c6);
        cluielem::function_dcb34c80("string", "rewardText", 1);
        cluielem::add_clientfield("challengeTypeText", 1, 1, "int", var_74cf4193);
        cluielem::add_clientfield("showIntelRewardText", 1, 1, "int", var_e89bb89d);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0xacf4a814, Offset: 0xbe8
    // Size: 0x6c
    function increment_progress(localclientnum) {
        current_val = get_data(localclientnum, "progress");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "progress", new_val);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xe2baf515, Offset: 0xc60
    // Size: 0x30
    function set_tributeavailable(localclientnum, value) {
        set_data(localclientnum, "tributeAvailable", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5acd3834, Offset: 0xd40
    // Size: 0x30
    function function_c079b98b(localclientnum, value) {
        set_data(localclientnum, "challengeTypeText", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x72668893, Offset: 0xd78
    // Size: 0x30
    function function_c21d733d(localclientnum, value) {
        set_data(localclientnum, "showIntelRewardText", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5bc2c4f3, Offset: 0xcd0
    // Size: 0x30
    function set_challengefailing(localclientnum, value) {
        set_data(localclientnum, "challengeFailing", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd408c540, Offset: 0xa50
    // Size: 0xe4
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"hash_6038b42ab4ce959d" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        if (#"hash_3045a78750b13a96" == state_name) {
            set_data(localclientnum, "_state", 2);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd06fba51, Offset: 0xd08
    // Size: 0x30
    function function_f63ec96b(localclientnum, value) {
        set_data(localclientnum, "rewardText", value);
    }

    // Namespace czm_dac_challenges_hud/zm_dac_challenges_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0x66dfaaae, Offset: 0x890
    // Size: 0x184
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "challengeText", #"");
        set_data(localclientnum, "bottomText", #"");
        set_data(localclientnum, "bInLocation", 0);
        set_data(localclientnum, "progress", 0);
        set_data(localclientnum, "tributeAvailable", 0);
        set_data(localclientnum, "rewardHidden", 0);
        set_data(localclientnum, "challengeFailing", 0);
        set_data(localclientnum, "rewardText", #"");
        set_data(localclientnum, "challengeTypeText", 0);
        set_data(localclientnum, "showIntelRewardText", 0);
    }

}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 10, eflags: 0x1 linked
// Checksum 0x55e5fc51, Offset: 0x180
// Size: 0x1ce
function register(var_be2ad4d, var_a7896263, var_4866daed, progresscallback, var_5d7491df, var_26df3d64, var_90359ec7, var_2404f6c6, var_74cf4193, var_e89bb89d) {
    elem = new czm_dac_challenges_hud();
    [[ elem ]]->setup_clientfields(var_be2ad4d, var_a7896263, var_4866daed, progresscallback, var_5d7491df, var_26df3d64, var_90359ec7, var_2404f6c6, var_74cf4193, var_e89bb89d);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_dac_challenges_hud"])) {
        level.var_ae746e8f[#"zm_dac_challenges_hud"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_dac_challenges_hud"])) {
        level.var_ae746e8f[#"zm_dac_challenges_hud"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_dac_challenges_hud"])) {
        level.var_ae746e8f[#"zm_dac_challenges_hud"] = array(level.var_ae746e8f[#"zm_dac_challenges_hud"]);
    }
    level.var_ae746e8f[#"zm_dac_challenges_hud"][level.var_ae746e8f[#"zm_dac_challenges_hud"].size] = elem;
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 0, eflags: 0x0
// Checksum 0x5bea534, Offset: 0x358
// Size: 0x34
function register_clientside() {
    elem = new czm_dac_challenges_hud();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0xacc12c69, Offset: 0x398
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0x11d5fdd5, Offset: 0x3c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0x5978c248, Offset: 0x3e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xf33a9db9, Offset: 0x410
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x7c02aead, Offset: 0x440
// Size: 0x28
function set_challengetext(localclientnum, value) {
    [[ self ]]->set_challengetext(localclientnum, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x4c11b39d, Offset: 0x470
// Size: 0x28
function set_bottomtext(localclientnum, value) {
    [[ self ]]->set_bottomtext(localclientnum, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x77a0eb6f, Offset: 0x4a0
// Size: 0x28
function set_binlocation(localclientnum, value) {
    [[ self ]]->set_binlocation(localclientnum, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0xd4a36d18, Offset: 0x4d0
// Size: 0x1c
function increment_progress(localclientnum) {
    [[ self ]]->increment_progress(localclientnum);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x1a94e516, Offset: 0x4f8
// Size: 0x28
function set_tributeavailable(localclientnum, value) {
    [[ self ]]->set_tributeavailable(localclientnum, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x3e2ec84d, Offset: 0x528
// Size: 0x28
function set_rewardhidden(localclientnum, value) {
    [[ self ]]->set_rewardhidden(localclientnum, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xeb364a3f, Offset: 0x558
// Size: 0x28
function set_challengefailing(localclientnum, value) {
    [[ self ]]->set_challengefailing(localclientnum, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x73566076, Offset: 0x588
// Size: 0x28
function function_f63ec96b(localclientnum, value) {
    [[ self ]]->function_f63ec96b(localclientnum, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xb60ec677, Offset: 0x5b8
// Size: 0x28
function function_c079b98b(localclientnum, value) {
    [[ self ]]->function_c079b98b(localclientnum, value);
}

// Namespace zm_dac_challenges_hud/zm_dac_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xf6099e50, Offset: 0x5e8
// Size: 0x28
function function_c21d733d(localclientnum, value) {
    [[ self ]]->function_c21d733d(localclientnum, value);
}

