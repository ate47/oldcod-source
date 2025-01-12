#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace namespace_fe84c968;

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 0, eflags: 0x0
// Checksum 0x20a203a, Offset: 0x540
// Size: 0xcc
function init() {
    clientfield::register("toplayer", "RGB_keyboard_manager", 1, 3, "int", &function_18a2f2b6, 0, 0);
    if (ispc() && getdvarint(#"hash_cca6902a7ce5273", 0) == 1) {
        callback::on_localclient_connect(&localclient_connect);
        callback::on_gameplay_started(&function_a965c790);
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0xb33b34c, Offset: 0x618
// Size: 0xa4
function function_a965c790(localclientnum) {
    player = function_f97e7787(localclientnum);
    player thread function_fdeeec5f(localclientnum);
    level.var_e0e60d5f = 1;
    callback::on_spawned(&function_fdeeec5f);
    callback::remove_callback(#"on_gameplay_started", &function_a965c790);
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0xd66d9904, Offset: 0x6c8
// Size: 0xa4
function localclient_connect(localclientnum) {
    function_722d2ef0(8);
    function_8130b1b();
    function_7475c495(4, 8, 8698, 2500, 750, 750, 0);
    if (!util::is_frontend_map()) {
        thread function_755f1144(localclientnum);
        thread function_b0a2f08b(localclientnum);
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0x168155e5, Offset: 0x778
// Size: 0x1bc
function function_fdeeec5f(localclientnum) {
    self endon(#"round_ended");
    player = function_f97e7787(localclientnum);
    if (!isdefined(player) || self != player || function_1fe374eb(localclientnum) || function_9a47ed7f(localclientnum)) {
        return;
    }
    function_8130b1b();
    player thread function_ba918579();
    player thread function_3eee45d0(localclientnum);
    player thread function_8dd5e0e0(localclientnum);
    player thread function_349b8010(localclientnum);
    player thread function_3a951cd5(localclientnum);
    if (!sessionmodeiswarzonegame() && !sessionmodeiszombiesgame()) {
        player thread function_70df27c2(localclientnum);
    }
    player waittill(#"death");
    function_722d2ef0(8);
    function_8130b1b();
    function_7475c495(1, 8, 255);
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 0, eflags: 0x0
// Checksum 0xedf61c91, Offset: 0x940
// Size: 0x124
function function_ba918579() {
    level endon(#"game_ended");
    var_7cfd69f3 = array("+forward", "+moveleft", "+moveright", "+back");
    foreach (key in var_7cfd69f3) {
        function_c807af26(self function_8966f654(key), 1, 16777215);
    }
    function_c807af26(self function_8966f654("chatmodelast"), 1, 16187136);
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0xfdc262c6, Offset: 0xa70
// Size: 0x100
function function_3eee45d0(localclientnum) {
    self endon(#"death");
    while (!(isdefined(level.gameended) && level.gameended)) {
        if (isdefined(level.var_5c55836a) && level.var_5c55836a) {
            function_7475c495(4, 8, 16646058, 300, 200, 200, 0);
        } else if (isswimming(localclientnum)) {
            function_7475c495(4, 8, 16711680, 300, 200, 200, 0);
        } else {
            function_7475c495(1, 8, 8698);
        }
        wait 0.5;
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0x17640395, Offset: 0xb78
// Size: 0x248
function function_8dd5e0e0(localclientnum) {
    self endon(#"death");
    self endon(#"disconnect");
    var_92e2b16b = array("key_f1", "key_f2", "key_f3", "key_f4");
    while (!(isdefined(level.gameended) && level.gameended)) {
        var_4bb4de62 = function_f97e7787(localclientnum);
        if (!isdefined(var_4bb4de62)) {
            break;
        }
        current_health = renderhealthoverlayhealth(localclientnum);
        basehealth = var_4bb4de62 getplayerspawnhealth();
        n_health = current_health * basehealth;
        if (n_health > 125) {
            function_19ca1975(var_92e2b16b, 65280);
        } else if (n_health > 100) {
            function_19ca1975(var_92e2b16b, 65535);
        } else if (n_health > 75) {
            function_19ca1975(var_92e2b16b, 13209);
        } else if (n_health > 50) {
            function_19ca1975(var_92e2b16b, 255);
        } else if (n_health > 25) {
            function_4711bf83(var_92e2b16b, 255, 300, 200, 200, 0);
        } else if (n_health > 0) {
            function_4711bf83(var_92e2b16b, 255, 200, 50, 50, 0);
        } else {
            function_19ca1975(var_92e2b16b, 0);
        }
        wait 0.5;
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0xf9783212, Offset: 0xdc8
// Size: 0x1a4
function function_349b8010(localclientnum) {
    self endon(#"death");
    var_3406b947 = array("key_f8", "key_f7", "key_f6", "key_f5");
    while (!(isdefined(level.gameended) && level.gameended)) {
        w_currentweapon = getcurrentweapon(localclientnum);
        var_e4a438f3 = getweaponammoclip(localclientnum, w_currentweapon);
        n_clipsize = w_currentweapon.clipsize;
        if (n_clipsize > 0) {
            var_8f45cc7f = var_e4a438f3 / n_clipsize;
        } else {
            var_8f45cc7f = 0;
        }
        for (var_7e6ce334 = 0; var_7e6ce334 < var_3406b947.size; var_7e6ce334++) {
            if (var_8f45cc7f > var_7e6ce334 / var_3406b947.size) {
                function_c807af26(var_3406b947[var_7e6ce334], 1, 9408399);
                continue;
            }
            function_c807af26(var_3406b947[var_7e6ce334], 1, 855309);
        }
        wait 0.5;
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0xc6ad6ca7, Offset: 0xf78
// Size: 0x224
function function_3a951cd5(localclientnum) {
    self endon(#"death");
    level endon(#"keybind_change");
    a_keys = array(self function_8966f654("+frag"), self function_8966f654("+smoke"), self function_8966f654("+weapoffhandspecial"));
    function_19ca1975(a_keys, 855309);
    self.var_5302ceda = array(0, 0, 0);
    while (!(isdefined(level.gameended) && level.gameended)) {
        for (ga = 0; ga < a_keys.size; ga++) {
            gadgetpower = getgadgetpower(localclientnum, ga);
            if (isdefined(gadgetpower) && gadgetpower == 1 && isdefined(self.var_5302ceda[ga]) && !self.var_5302ceda[ga]) {
                self.var_5302ceda[ga] = 1;
                self thread function_4d4517b7(a_keys[ga], ga, localclientnum);
                continue;
            }
            if (isdefined(gadgetpower) && gadgetpower != 1) {
                function_c807af26(a_keys[ga], 1, 855309);
                self.var_5302ceda[ga] = 0;
            }
        }
        wait 0.5;
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 3, eflags: 0x0
// Checksum 0x1c6c4ddc, Offset: 0x11a8
// Size: 0x13c
function function_4d4517b7(var_9da32253, var_bc22b80a, localclientnum) {
    self endon(#"death");
    level endon(#"game_ended", #"keybind_change");
    function_c807af26(var_9da32253, 3, 63487, 855309, 275, 0);
    for (i = 0; i < 160; i++) {
        if (isdefined(getgadgetpower(localclientnum, var_bc22b80a)) && getgadgetpower(localclientnum, var_bc22b80a)) {
            waitframe(1);
            continue;
        }
        function_c807af26(var_9da32253, 1, 8698);
        self.var_5302ceda[var_bc22b80a] = 0;
        return;
    }
    function_c807af26(var_9da32253, 1, 63487);
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0xde98a5fe, Offset: 0x12f0
// Size: 0xd0
function function_755f1144(localclientnum) {
    level endon(#"game_ended");
    while (!(isdefined(level.gameended) && level.gameended)) {
        self waittill(#"keybind_change");
        function_8130b1b();
        player = function_609b5d7a(localclientnum);
        player function_ba918579();
        player thread function_3a951cd5(localclientnum);
        player thread function_70df27c2(localclientnum);
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 0, eflags: 0x0
// Checksum 0xff8f81b8, Offset: 0x13c8
// Size: 0xb2
function function_1f3fd33f() {
    function_8130b1b();
    var_eeb4ab3a = array(255, 13209, 63487, 65280, 16711680, 11141375, 16746751);
    while (true) {
        for (color = 0; color < var_eeb4ab3a.size; color++) {
            function_7475c495(1, 8, var_eeb4ab3a[color]);
            wait 0.1;
        }
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 2, eflags: 0x0
// Checksum 0x53821527, Offset: 0x1488
// Size: 0x1d8
function function_23926c3f(localclientnum, winningteam) {
    self endon(#"death");
    player = function_f97e7787(localclientnum);
    var_cfb1607a = array("key_f9", "key_f10", "key_f11", "key_f12");
    color = undefined;
    if (!isalive(player) && !isdefined(player) || self != player || function_1fe374eb(localclientnum) || function_9a47ed7f(localclientnum)) {
        return;
    }
    if (winningteam == "tie") {
        color = 9408399;
    } else if (winningteam == player.team) {
        color = 16187136;
    } else if (winningteam != player.team) {
        color = 255;
    }
    if (isdefined(color)) {
        foreach (key in var_cfb1607a) {
            function_c807af26(key, 1, color);
        }
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0x3439766e, Offset: 0x1668
// Size: 0x6e4
function function_b0a2f08b(localclientnum) {
    level endon(#"game_ended");
    var_1d1f1f63 = array("key_escape", "key_f1", "key_f2", "key_f3", "key_f4", "key_f5", "key_f6", "key_f7", "key_f8", "key_f9", "key_f10", "key_f11", "key_f12", "key_sysrq", "key_scroll", "key_pause");
    var_c6b55986 = array("key_grave", "key_numlock", "key_multiply", "key_divide", "key_subtract", "key_1", "key_2", "key_3", "key_4", "key_5", "key_6", "key_7", "key_8", "key_9", "key_0", "key_minus", "key_equals", "key_back", "key_insert", "key_home", "key_prior");
    var_33134f25 = array("key_numpad9", "key_numpad8", "key_numpad7", "key_add", "key_tab", "key_q", "key_w", "key_e", "key_r", "key_t", "key_y", "key_u", "key_i", "key_o", "key_p", "key_lbracket", "key_rbracket", "key_backslash", "key_delete", "key_end", "key_next");
    var_24c5ef0 = array("key_numpad6", "key_numpad5", "key_numpad4", "key_capital", "key_a", "key_s", "key_d", "key_f", "key_g", "key_h", "key_j", "key_k", "key_l", "key_semicolon", "key_apostrophe", "key_return");
    var_20b3747f = array("key_numpad3", "key_numpad2", "key_numpad1", "key_lshift", "key_z", "key_x", "key_c", "key_v", "key_b", "key_n", "key_m", "key_comma", "key_period", "key_slash", "key_rshift", "key_numpadenter", "key_up");
    var_c79ee102 = array("key_numpad0", "key_decimal", "key_left", "key_down", "key_right", "key_lcontrol", "key_rcontrol", "key_lwin", "key_lmenu", "key_rmenu", "key_apps", "key_fn");
    controllermodel = getuimodelforcontroller(localclientnum);
    parentmodel = createuimodel(getglobaluimodel(), "PositionDraft");
    var_756f7111 = createuimodel(parentmodel, "timeRemaining");
    var_192c10a0 = createuimodel(controllermodel, "PositionDraft");
    var_da2ad088 = createuimodel(var_192c10a0, "stage");
    previoustime = 0;
    while (!(isdefined(level.gameended) && level.gameended)) {
        var_b6e34608 = getuimodelvalue(var_da2ad088);
        var_4fbb43ed = getuimodelvalue(var_756f7111);
        if (isdefined(var_b6e34608) && isdefined(var_4fbb43ed)) {
            if (var_b6e34608 == 6 && var_4fbb43ed != previoustime) {
                function_7475c495(1, 8, 8698);
                function_19ca1975(var_1d1f1f63, 0);
                if (var_4fbb43ed == 5) {
                    function_c25d1782(var_c6b55986, 8698, 0, 750);
                } else if (var_4fbb43ed == 4) {
                    function_c25d1782(var_33134f25, 8698, 0, 750);
                } else if (var_4fbb43ed == 3) {
                    function_c25d1782(var_24c5ef0, 8698, 0, 750);
                } else if (var_4fbb43ed == 2) {
                    function_c25d1782(var_20b3747f, 8698, 0, 750);
                } else if (var_4fbb43ed == 1) {
                    function_7475c495(2, 8, 8698, 0, 750);
                }
                previoustime = var_4fbb43ed;
            } else if (var_b6e34608 == 0 && previoustime == 1) {
                previoustime = 0;
                function_722d2ef0(3);
                break;
            }
        }
        wait 0.3;
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0xaaace82d, Offset: 0x1d58
// Size: 0x32c
function function_70df27c2(localclientnum) {
    self endon(#"death");
    level endon(#"game_ended", #"keybind_change");
    controllermodel = getuimodelforcontroller(localclientnum);
    parentmodel = createuimodel(controllermodel, "killstreaks");
    var_81a10aea = createuimodel(parentmodel, "momentumPercentage");
    var_b4ce23f8 = createuimodel(parentmodel, "killstreak0");
    var_c3fc86df = createuimodel(parentmodel, "killstreak1");
    var_b6552352 = createuimodel(parentmodel, "killstreak2");
    var_c52c3b11 = createuimodel(parentmodel, "killstreak3");
    var_afaa9de5 = array(var_b4ce23f8, var_c3fc86df, var_b6552352, var_c52c3b11);
    var_4bfc237b = array(self function_8966f654("scorestreak1"), self function_8966f654("scorestreak2"), self function_8966f654("scorestreak3"), self function_8966f654("scorestreak4"));
    while (!(isdefined(level.gameended) && level.gameended)) {
        var_69c82d72 = getuimodelvalue(var_81a10aea);
        for (i = 0; i < var_afaa9de5.size; i++) {
            var_1bcb5909 = createuimodel(var_afaa9de5[i], "rewardAmmo");
            var_409fe0e5 = getuimodelvalue(var_1bcb5909);
            if (isdefined(var_409fe0e5) && var_409fe0e5 > 0) {
                function_c807af26(var_4bfc237b[i], 3, 63487, 0, 275, 0);
                continue;
            }
            function_c807af26(var_4bfc237b[i], 1, 1513239);
        }
        wait 0.5;
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 7, eflags: 0x0
// Checksum 0x18391f11, Offset: 0x2090
// Size: 0x172
function function_18a2f2b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = function_f97e7787(localclientnum);
    if (!isdefined(level) && !isdefined(level.var_e0e60d5f) && level.var_e0e60d5f == 0) {
        return;
    }
    switch (newval) {
    case 1:
        function_1f3fd33f();
        break;
    case 2:
        function_23926c3f(localclientnum, "tie");
        break;
    case 3:
        function_23926c3f(localclientnum, "allies");
        break;
    case 4:
        function_23926c3f(localclientnum, "axis");
        break;
    default:
        break;
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 2, eflags: 0x0
// Checksum 0x4289d333, Offset: 0x2210
// Size: 0x90
function function_19ca1975(keylist, color) {
    foreach (key in keylist) {
        function_c807af26(key, 1, color);
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 4, eflags: 0x0
// Checksum 0x6e650599, Offset: 0x22a8
// Size: 0xa8
function function_c25d1782(keylist, startcolor, endcolor, fadetime) {
    foreach (key in keylist) {
        function_c807af26(key, 2, startcolor, endcolor, fadetime);
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 6, eflags: 0x0
// Checksum 0x8ade498a, Offset: 0x2358
// Size: 0xc0
function function_4711bf83(keylist, color, var_359fd6e5, fadetime, var_e7091de3, offset) {
    foreach (key in keylist) {
        function_c807af26(key, 4, color, var_359fd6e5, fadetime, var_e7091de3, offset);
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 1, eflags: 0x0
// Checksum 0x691afd8b, Offset: 0x2420
// Size: 0x80
function function_35f97c8e(keylist) {
    foreach (key in keylist) {
        function_bf9f772b(key);
    }
}

