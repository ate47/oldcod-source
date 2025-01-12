#using scripts\core_common\bots\bot;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\gametypes\_prop_controls;
#using scripts\mp_common\gametypes\dogtags;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\prop;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\gametypes\spawnlogic;
#using scripts\mp_common\util;

#namespace prop_dev;

/#

    // Namespace prop_dev/_prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0xebceff52, Offset: 0x100
    // Size: 0x94
    function adddevguicommand(path, var_66e49a4e) {
        pathstr = "<dev string:x30>" + path + "<dev string:x30>";
        cmdstr = "<dev string:x30>" + var_66e49a4e + "<dev string:x32>";
        debugcommand = "<dev string:x35>" + pathstr + "<dev string:x41>" + cmdstr;
        adddebugcommand(debugcommand);
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x40ce410d, Offset: 0x1a0
    // Size: 0x18c6
    function propdevgui() {
        var_b58392ae = 0;
        var_8b6a1374 = 0;
        var_ccd61088 = 0;
        var_6c9fc047 = 0;
        var_f0760dd5 = 0;
        var_8c45c976 = 0;
        var_fe10d650 = 0;
        var_74fced3d = 0;
        minigame_on = getdvarint(#"scr_prop_minigame", 1);
        server_hud = getdvarint(#"scr_ph_useprophudserver", 1);
        var_100dc1ab = getdvarfloat(#"player_swimdamage", 10);
        util::set_dvar_int_if_unset("<dev string:x43>", 0);
        util::set_dvar_int_if_unset("<dev string:x56>", 0);
        util::set_dvar_int_if_unset("<dev string:x68>", 0);
        util::set_dvar_int_if_unset("<dev string:x7b>", 0);
        util::set_dvar_int_if_unset("<dev string:x8c>", 0);
        util::set_dvar_int_if_unset("<dev string:x9d>", 0);
        util::set_dvar_int_if_unset("<dev string:xb2>", 0);
        util::set_dvar_int_if_unset("<dev string:xcb>", 0);
        util::set_dvar_int_if_unset("<dev string:xe2>", 0);
        util::set_dvar_int_if_unset("<dev string:xf5>", 0);
        util::set_dvar_int_if_unset("<dev string:x107>", 0);
        util::set_dvar_int_if_unset("<dev string:x11f>", 1);
        util::set_dvar_int_if_unset("<dev string:x13f>", 1);
        util::set_dvar_int_if_unset("<dev string:x157>", 0);
        util::set_dvar_int_if_unset("<dev string:x16c>", 0);
        util::set_dvar_int_if_unset("<dev string:x180>", 0);
        util::set_dvar_int_if_unset("<dev string:x197>", 0);
        util::set_dvar_int_if_unset("<dev string:x1ad>", 0);
        util::set_dvar_int_if_unset("<dev string:x1bf>", 0);
        util::set_dvar_int_if_unset("<dev string:x1d7>", 0);
        util::set_dvar_int_if_unset("<dev string:x1ef>", 0);
        setdvar(#"hash_4424a07b5272599a", 0);
        setdvar(#"hash_34a3e2c00f7cd27f", 0);
        setdvar(#"hash_3fd977c7de8de72b", 0);
        setdvar(#"hash_5fea18fb5a6e0027", 0);
        setdvar(#"hash_69637702c083dc28", 0);
        setdvar(#"hash_2a03924a528ff9a8", 0);
        setdvar(#"hash_740b6f4a4aa58f21", 0);
        setdvar(#"hash_7115842bdfa67a2b", 0);
        if (getdvarint(#"hash_70c6c4a3e9254926", 0) != 0) {
            adddebugcommand("<dev string:x20a>");
        }
        adddevguicommand("<dev string:x227>", "<dev string:x247>");
        adddevguicommand("<dev string:x267>", "<dev string:x280>");
        adddevguicommand("<dev string:x2bd>", "<dev string:x2d6>" + 4 + "<dev string:x2f2>");
        adddevguicommand("<dev string:x313>", "<dev string:x2d6>" + 0.25 + "<dev string:x2f2>");
        adddevguicommand("<dev string:x32d>", "<dev string:x351>");
        adddevguicommand("<dev string:x36e>", "<dev string:x391>");
        adddevguicommand("<dev string:x3b2>", "<dev string:x3d3>");
        adddevguicommand("<dev string:x3f0>", "<dev string:x412>");
        adddevguicommand("<dev string:x430>", "<dev string:x452>");
        adddevguicommand("<dev string:x470>", "<dev string:x490>");
        adddevguicommand("<dev string:x4ac>", "<dev string:x4cc>");
        adddevguicommand("<dev string:x4e8>", "<dev string:x501>");
        adddevguicommand("<dev string:x51e>", "<dev string:x537>");
        adddevguicommand("<dev string:x554>", "<dev string:x56a>");
        adddevguicommand("<dev string:x583>", "<dev string:x599>");
        adddevguicommand("<dev string:x5b2>", "<dev string:x5c5>");
        adddevguicommand("<dev string:x612>", "<dev string:x628>");
        adddevguicommand("<dev string:x645>", "<dev string:x65a>");
        adddevguicommand("<dev string:x677>", "<dev string:x68d>");
        adddevguicommand("<dev string:x6a5>", "<dev string:x6c4>");
        adddevguicommand("<dev string:x6dc>", "<dev string:x6fa>");
        adddevguicommand("<dev string:x711>", "<dev string:x72a>");
        adddevguicommand("<dev string:x74a>", "<dev string:x762>");
        adddevguicommand("<dev string:x781>", "<dev string:x79d>");
        adddevguicommand("<dev string:x7c0>", "<dev string:x7d7>");
        adddevguicommand("<dev string:x7fa>", "<dev string:x815>");
        adddevguicommand("<dev string:x832>", "<dev string:x85c>");
        adddevguicommand("<dev string:x87c>", "<dev string:x8a9>");
        adddevguicommand("<dev string:x8c5>", "<dev string:x8f5>");
        adddevguicommand("<dev string:x914>", "<dev string:x93f>");
        adddevguicommand("<dev string:x960>", "<dev string:x97a>");
        adddevguicommand("<dev string:x99d>", "<dev string:x9b6>");
        adddevguicommand("<dev string:x9d3>", "<dev string:x9f7>");
        while (true) {
            if (isdefined(level.prematch_over) && level.prematch_over) {
                level.allow_teamchange = "<dev string:xa1f>" + getdvarint(#"hash_7f436a7b31a003f3", 0);
                level.var_2898ef72 = getdvarint(#"hash_4819c54cbad5ed87", 0) != 0;
            }
            if (getdvarint(#"scr_ph_useprophudserver", 0) != server_hud && isdefined(level.players)) {
                server_hud = getdvarint(#"scr_ph_useprophudserver", 0);
                if (!isdefined(level.players[0].changepropkey)) {
                    iprintlnbold("<dev string:xa20>");
                } else {
                    foreach (player in level.players) {
                        if (isdefined(player.team) && player util::isprop()) {
                            player prop_controls::propabilitykeysvisible(server_hud, 1);
                        }
                    }
                    level.elim_hud.alpha = server_hud;
                }
            }
            if (getdvarint(#"hash_2c678eea20875ddd", 0) != var_ccd61088 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player util::isprop()) {
                        var_ccd61088 = getdvarint(#"hash_2c678eea20875ddd", 0);
                        player.var_c4494f8d = !(isdefined(player.var_c4494f8d) && player.var_c4494f8d);
                        player iprintlnbold(player.var_c4494f8d ? "<dev string:xa38>" : "<dev string:xa4a>");
                    }
                }
            }
            if (getdvarint(#"hash_4aab269ba89e7cb6", 0) != var_6c9fc047 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player util::isprop()) {
                        var_6c9fc047 = getdvarint(#"hash_4aab269ba89e7cb6", 0);
                        player.var_b53602f4 = !(isdefined(player.var_b53602f4) && player.var_b53602f4);
                        player iprintlnbold(player.var_b53602f4 ? "<dev string:xa59>" : "<dev string:xa6a>");
                    }
                }
            }
            if (getdvarint(#"hash_53ee83feb4db4606", 0) != var_f0760dd5 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player util::isprop()) {
                        var_f0760dd5 = getdvarint(#"hash_53ee83feb4db4606", 0);
                        player.var_2f1101f4 = !(isdefined(player.var_2f1101f4) && player.var_2f1101f4);
                        player iprintlnbold(player.var_2f1101f4 ? "<dev string:xa78>" : "<dev string:xa8a>");
                    }
                }
            }
            if (getdvarint(#"hash_62162f1f94cbba77", 0) != var_8c45c976) {
                var_8c45c976 = getdvarint(#"hash_62162f1f94cbba77", 0);
                if (var_8c45c976) {
                    setdvar(#"doublejump_time_before_recharge", 1);
                    setdvar(#"doublejump_time_before_recharge_fast", 1);
                    setdvar(#"playerenergy_restrate", 10000);
                } else {
                    setdvar(#"doublejump_time_before_recharge", 1600);
                    setdvar(#"doublejump_time_before_recharge_fast", 1000);
                    setdvar(#"playerenergy_restrate", 400);
                    iprintlnbold(var_8c45c976 ? "<dev string:xa99>" : "<dev string:xaa9>");
                }
            }
            if (getdvarint(#"hash_618be616410fad95", 0) != var_fe10d650 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player prop::function_e4b2f23()) {
                        var_fe10d650 = getdvarint(#"hash_618be616410fad95", 0);
                        player.var_74ca9cd1 = !(isdefined(player.var_74ca9cd1) && player.var_74ca9cd1);
                        player iprintlnbold(player.var_74ca9cd1 ? "<dev string:xab6>" : "<dev string:xac6>");
                    }
                }
            }
            isremoved = getdvarint(#"hash_21d7ba8da36d4023", 0);
            if (isremoved != var_b58392ae) {
                var_b58392ae = isremoved;
                function_f35dfc64(!isremoved);
            }
            var_504c9134 = getdvarint(#"hash_34a3e2c00f7cd27f", 0);
            if (var_504c9134 != var_8b6a1374) {
                var_8b6a1374 = var_504c9134;
                result = function_194631ab(var_504c9134);
                if (!result) {
                    var_8b6a1374 = !var_504c9134;
                }
                if (var_8b6a1374) {
                    level.drown_damage = 0;
                } else {
                    level.drown_damage = var_100dc1ab;
                }
            }
            if (getdvarint(#"hash_3fd977c7de8de72b", 0) != 0) {
                function_543336f9();
                setdvar(#"hash_3fd977c7de8de72b", 0);
            }
            if (getdvarint(#"hash_5fea18fb5a6e0027", 0) != 0) {
                function_a8147bf9();
                setdvar(#"hash_5fea18fb5a6e0027", 0);
            }
            if (getdvarint(#"hash_69637702c083dc28", 0) != 0) {
                function_1a022b4b();
                setdvar(#"hash_69637702c083dc28", 0);
            }
            if (getdvarint(#"hash_7115842bdfa67a2b", 0) != 0) {
                if (isdefined(level.players) && isdefined(level.players[0])) {
                    level thread prop::function_435d5169(#"score_last_alive", level.players[0]);
                }
                setdvar(#"hash_7115842bdfa67a2b", 0);
            }
            if (getdvarint(#"hash_34e9a7fac83d28a6", 0) != 0) {
                function_276ad638();
            }
            if (getdvarint(#"hash_7b2608d6176b79f4", 0)) {
                function_b02387d6();
            }
            if (getdvarint(#"hash_4424a07b5272599a", 0) != 0) {
                showmodels();
                setdvar(#"hash_4424a07b5272599a", 0);
            }
            if (getdvarint(#"hash_84008139ad85e21", 0) != 0) {
                if (isdefined(level.players) && isdefined(level.players[0])) {
                    level.players[0] prop_controls::canlock();
                }
            }
            if (getdvarint(#"hash_2fa05819a4eeb99b", 0) != 0 || getdvarint(#"hash_84008139ad85e21", 0) != 0) {
                function_36895abd();
            }
            if (getdvarint(#"hash_2a03924a528ff9a8", 0) != 0) {
                function_6863880e();
                setdvar(#"hash_2a03924a528ff9a8", 0);
            }
            if (getdvarint(#"hash_740b6f4a4aa58f21", 0) != 0) {
                function_9b9725b1();
                setdvar(#"hash_740b6f4a4aa58f21", 0);
            }
            if (getdvarint(#"hash_2441330d88677536", 0) != 0 && isdefined(level.players)) {
                foreach (player in level.players) {
                    player notify(#"cancelcountdown");
                }
                setdvar(#"hash_2441330d88677536", 0);
            }
            if (getdvarint(#"hash_7da18bcec6fafe7f", 0) != 0) {
                function_b52ad1b2();
            }
            if (getdvarint(#"hash_745b5ef88dd291e1", 0) != 0) {
                showplayers();
            }
            if (getdvarint(#"hash_3c0e90252ca92099", 0) != 0) {
                showtargets();
            }
            if (getdvarint(#"scr_prop_minigame", 1) != minigame_on && isdefined(level.players) && level.players.size > 0) {
                minigame_on = getdvarint(#"scr_prop_minigame", 1);
                iprintlnbold(minigame_on ? "<dev string:xad3>" : "<dev string:xadf>");
            }
            if (getdvarint(#"hash_6132db0becb8f98", 0) != var_74fced3d && isdefined(level.players) && level.players.size > 0) {
                var_74fced3d = getdvarint(#"hash_6132db0becb8f98", 0);
                if (var_74fced3d == 2) {
                    iprintlnbold("<dev string:xaec>");
                } else if (var_74fced3d == 1) {
                    iprintlnbold("<dev string:xaff>");
                } else {
                    iprintlnbold("<dev string:xb13>");
                }
            }
            waitframe(1);
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x38d0c208, Offset: 0x1a70
    // Size: 0xf4
    function function_f35dfc64(enabled) {
        setdvar(#"com_statmon", enabled);
        setdvar(#"con_minicon", enabled);
        setdvar(#"cg_drawfps", enabled);
        setdvar(#"cg_drawtime", enabled);
        setdvar(#"cg_drawviewpos", enabled);
        setdvar(#"hash_173fd7265ae0b7b1", enabled);
        setdvar(#"hash_2d3acd259cd6aca6", enabled);
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x57ac8fc4, Offset: 0x1b70
    // Size: 0xe2
    function function_194631ab(enabled) {
        if (!isdefined(level.players) || level.players.size == 0) {
            return 0;
        }
        player = level.players[0];
        if (!isdefined(player) || !isalive(player) || isdefined(player.placementoffset) || !isdefined(player.prop)) {
            return 0;
        }
        if (enabled) {
            player function_1b260dda();
        } else {
            player function_bff3e3c5();
        }
        return 1;
    }

    // Namespace prop_dev/_prop_dev
    // Params 5, eflags: 0x0
    // Checksum 0x2504be9d, Offset: 0x1c60
    // Size: 0x88
    function function_e7f343ff(color, label, value, text, var_5f790513) {
        hudelem = prop_controls::addupperrighthudelem(label, value, text, var_5f790513);
        hudelem.alpha = 0.5;
        hudelem.color = color;
        return hudelem;
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x10942b71, Offset: 0x1cf0
    // Size: 0x1c4
    function function_1b260dda() {
        self prop_controls::cleanuppropcontrolshud();
        self prop_controls::function_3122ae57();
        if (self issplitscreen()) {
            self.currenthudy = -10;
        } else {
            self.currenthudy = -80;
        }
        self.var_4efaa35 = function_639754d0(self.prop.info.modelname);
        white = (1, 1, 1);
        red = (1, 0, 0);
        green = (0, 1, 0);
        blue = (0, 0.5, 1);
        self.var_af6ef079 = array(self.placementmodel, self.var_b97b612d, self.var_6b04bc54, self.var_f3f7c094, self.var_ec187f25, self.var_c61604bc, self.var_381d73f7, self.var_3e02b967, self.var_e7ec6bb6, self.var_f1fdc495, self.var_40dabe6f, self.var_c9f40191);
        self.placementindex = 0;
        self function_9cfa92f3();
        self thread function_d8d922ad();
        self thread function_18a45f58();
        self thread function_8bd2ff0();
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x98ff723a, Offset: 0x1ec0
    // Size: 0x184
    function function_bff3e3c5() {
        self notify(#"hash_3ecc0277d544b441");
        prop_controls::safedestroy(self.placementmodel);
        prop_controls::safedestroy(self.var_b97b612d);
        prop_controls::safedestroy(self.var_6b04bc54);
        prop_controls::safedestroy(self.var_f3f7c094);
        prop_controls::safedestroy(self.var_ec187f25);
        prop_controls::safedestroy(self.var_c61604bc);
        prop_controls::safedestroy(self.var_381d73f7);
        prop_controls::safedestroy(self.var_3e02b967);
        prop_controls::safedestroy(self.var_e7ec6bb6);
        prop_controls::safedestroy(self.var_f1fdc495);
        prop_controls::safedestroy(self.var_40dabe6f);
        prop_controls::safedestroy(self.var_c9f40191);
        self function_4e71de66();
        self prop_controls::propcontrolshud();
        self prop_controls::setupkeybindings();
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x61a73c72, Offset: 0x2050
    // Size: 0x6c
    function function_8bd2ff0() {
        self endon(#"game_ended");
        self endon(#"disconnect");
        self endon(#"hash_3ecc0277d544b441");
        self waittill(#"death");
        setdvar(#"hash_34a3e2c00f7cd27f", 0);
    }

    // Namespace prop_dev/_prop_dev
    // Params 6, eflags: 0x0
    // Checksum 0x2f436757, Offset: 0x20c8
    // Size: 0x13c
    function debugaxis(origin, angles, size, alpha, depthtest, duration) {
        axisx = anglestoforward(angles) * size;
        axisy = anglestoright(angles) * size;
        axisz = anglestoup(angles) * size;
        line(origin, origin + axisx, (1, 0, 0), alpha, 0, duration);
        line(origin, origin + axisy, (0, 1, 0), alpha, 0, duration);
        line(origin, origin + axisz, (0, 0, 1), alpha, 0, duration);
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x538b520c, Offset: 0x2210
    // Size: 0xae
    function function_d8d922ad() {
        self endon(#"hash_3ecc0277d544b441");
        while (true) {
            debugaxis(self.origin, self.angles, 100, 1, 0, 1);
            box(self.origin, self getmins(), self getmaxs(), self.angles[1], (1, 0, 1), 1, 0, 1);
            waitframe(1);
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x3c85b83b, Offset: 0x22c8
    // Size: 0x1a0
    function function_18a45f58() {
        self endon(#"hash_3ecc0277d544b441");
        self function_9c8c6fe4(0);
        while (true) {
            waitresult = self waittill(#"up", #"down", #"left", #"right", #"shot");
            msg = waitresult._notify;
            if (!isdefined(msg)) {
                continue;
            }
            if (msg == "<dev string:xb28>") {
                self function_6049bca3(-1);
                continue;
            }
            if (msg == "<dev string:xb2b>") {
                self function_6049bca3(1);
                continue;
            }
            if (msg == "<dev string:xb30>") {
                self function_a24562f8(1);
                continue;
            }
            if (msg == "<dev string:xb36>") {
                self function_a24562f8(-1);
                continue;
            }
            if (msg == "<dev string:xb3b>") {
                function_c64fb4ca();
            }
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0xdbd1c912, Offset: 0x2470
    // Size: 0x68
    function function_6049bca3(val) {
        self endon(#"letgo");
        function_9c8c6fe4(val);
        wait 0.5;
        while (true) {
            function_9c8c6fe4(val);
            wait 0.05;
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x16554011, Offset: 0x24e0
    // Size: 0xea
    function function_9c8c6fe4(val) {
        hudelem = self.var_af6ef079[self.placementindex];
        hudelem.alpha = 0.5;
        hudelem.fontscale = 1;
        self.placementindex += val;
        if (self.placementindex >= self.var_af6ef079.size) {
            self.placementindex = 0;
        } else if (self.placementindex < 0) {
            self.placementindex = self.var_af6ef079.size - 1;
        }
        hudelem = self.var_af6ef079[self.placementindex];
        hudelem.alpha = 1;
        hudelem.fontscale = 1.3;
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x12f0ff7c, Offset: 0x25d8
    // Size: 0x68
    function function_a24562f8(val) {
        self endon(#"letgo");
        function_8bdc662f(val);
        wait 0.05;
        while (true) {
            function_8bdc662f(val);
            wait 0.05;
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0xf4ed8c49, Offset: 0x2648
    // Size: 0x72
    function function_e52aa8bb(inval) {
        tempindex = self.var_4efaa35 + inval;
        if (tempindex >= level.propindex.size) {
            tempindex = 0;
        } else if (tempindex < 0) {
            tempindex = level.propindex.size - 1;
        }
        self.var_4efaa35 = tempindex;
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0xa583d491, Offset: 0x26c8
    // Size: 0x88
    function function_639754d0(var_95f39eee) {
        for (index = 0; index < level.propindex.size; index++) {
            if (level.proplist[level.propindex[index][0]][level.propindex[index][1]].modelname == var_95f39eee) {
                return index;
            }
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0xcfdc8f09, Offset: 0x2758
    // Size: 0xefc
    function function_8bdc662f(val) {
        hudelem = self.var_af6ef079[self.placementindex];
        if (hudelem == self.placementmodel) {
            function_e52aa8bb(val);
            self.prop.info = level.proplist[level.propindex[self.var_4efaa35][0]][level.propindex[self.var_4efaa35][1]];
            prop_controls::propchangeto(self.prop.info);
            self.placementmodel settext("<dev string:xb40>" + self.var_4efaa35 + "<dev string:xb48>" + self.prop.info.modelname);
            self.var_b97b612d settext("<dev string:xb4c>" + self.prop.info.propsizetext);
            self.var_6b04bc54 setvalue(self.prop.info.propsize);
            self.var_f3f7c094 setvalue(self.prop.info.propscale);
            self.var_ec187f25 setvalue(self.prop.info.xyzoffset[0]);
            self.var_c61604bc setvalue(self.prop.info.xyzoffset[1]);
            self.var_381d73f7 setvalue(self.prop.info.xyzoffset[2]);
            self.var_3e02b967 setvalue(self.prop.info.anglesoffset[0]);
            self.var_e7ec6bb6 setvalue(self.prop.info.anglesoffset[1]);
            self.var_f1fdc495 setvalue(self.prop.info.anglesoffset[2]);
            self.var_40dabe6f setvalue(self.prop.info.propheight);
            self.var_c9f40191 setvalue(self.prop.info.proprange);
            return;
        }
        if (hudelem == self.var_b97b612d || hudelem == self.var_6b04bc54) {
            sizes = array("<dev string:xb53>", "<dev string:xb5a>", "<dev string:xb60>", "<dev string:xb67>", "<dev string:xb6d>", "<dev string:xb74>");
            index = 0;
            for (i = 0; i < sizes.size; i++) {
                if (sizes[i] == self.prop.info.propsizetext) {
                    index = i;
                    break;
                }
            }
            index += val;
            if (index < 0) {
                index = sizes.size - 1;
            } else if (index >= sizes.size) {
                index = 0;
            }
            self.prop.info.propsizetext = sizes[index];
            self.prop.info.propsize = prop::getpropsize(self.prop.info.propsizetext);
            self.var_b97b612d settext("<dev string:xb4c>" + self.prop.info.propsizetext);
            self.var_6b04bc54 setvalue(self.prop.info.propsize);
            self.health = self.prop.info.propsize;
            self.maxhealth = self.health;
            return;
        }
        if (hudelem == self.var_f3f7c094) {
            var_759a3fa8 = 0.1;
            var_c5fe12fe = 10;
            var_edcea860 = 0.01;
            self.prop.info.propscale += var_edcea860 * val;
            self.prop.info.propscale = math::clamp(self.prop.info.propscale, var_759a3fa8, var_c5fe12fe);
            self.prop setscale(self.prop.info.propscale);
            self.var_f3f7c094 setvalue(self.prop.info.propscale);
            return;
        }
        if (hudelem == self.var_ec187f25) {
            self.prop unlink();
            self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0] + val, self.prop.info.xyzoffset[1], self.prop.info.xyzoffset[2]);
            self.prop.xyzoffset = self.prop.info.xyzoffset;
            self.var_ec187f25 setvalue(self.prop.info.xyzoffset[0]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_c61604bc) {
            self.prop unlink();
            self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0], self.prop.info.xyzoffset[1] + val, self.prop.info.xyzoffset[2]);
            self.prop.xyzoffset = self.prop.info.xyzoffset;
            self.var_c61604bc setvalue(self.prop.info.xyzoffset[1]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_381d73f7) {
            self.prop unlink();
            self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0], self.prop.info.xyzoffset[1], self.prop.info.xyzoffset[2] + val);
            self.prop.xyzoffset = self.prop.info.xyzoffset;
            self.var_381d73f7 setvalue(self.prop.info.xyzoffset[2]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_3e02b967) {
            self.prop unlink();
            self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0] + val, self.prop.info.anglesoffset[1], self.prop.info.anglesoffset[2]);
            self.prop.anglesoffset = self.prop.info.anglesoffset;
            self.var_3e02b967 setvalue(self.prop.info.anglesoffset[0]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_e7ec6bb6) {
            self.prop unlink();
            self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0], self.prop.info.anglesoffset[1] + val, self.prop.info.anglesoffset[2]);
            self.prop.anglesoffset = self.prop.info.anglesoffset;
            self.var_e7ec6bb6 setvalue(self.prop.info.anglesoffset[1]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_f1fdc495) {
            self.prop unlink();
            self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0], self.prop.info.anglesoffset[1], self.prop.info.anglesoffset[2] + val);
            self.prop.anglesoffset = self.prop.info.anglesoffset;
            self.var_f1fdc495 setvalue(self.prop.info.anglesoffset[2]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_40dabe6f) {
            adjust = 10;
            self.prop.info.propheight += adjust * val;
            self.prop.info.propheight = math::clamp(self.prop.info.propheight, -30, 40);
            self.thirdpersonheightoffset = self.prop.info.propheight;
            self setclientthirdperson(1);
            self.var_40dabe6f setvalue(self.prop.info.propheight);
            return;
        }
        if (hudelem == self.var_c9f40191) {
            adjust = 10;
            self.prop.info.proprange += adjust * val;
            self.prop.info.proprange = math::clamp(self.prop.info.proprange, 50, 360);
            self.thirdpersonrange = self.prop.info.proprange;
            self setclientthirdperson(1);
            self.var_c9f40191 setvalue(self.prop.info.proprange);
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xfa4feacc, Offset: 0x3660
    // Size: 0x74
    function function_4ef69a48() {
        self.prop.origin = self.propent.origin;
        self prop::applyxyzoffset();
        self prop::applyanglesoffset();
        self.prop linkto(self.propent);
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x691edf8f, Offset: 0x36e0
    // Size: 0x1e4
    function function_9cfa92f3() {
        self prop_controls::notifyonplayercommand("<dev string:xb28>", "<dev string:xb7b>");
        self prop_controls::notifyonplayercommand("<dev string:xb2b>", "<dev string:xb89>");
        self prop_controls::notifyonplayercommand("<dev string:xb36>", "<dev string:xb97>");
        self prop_controls::notifyonplayercommand("<dev string:xb30>", "<dev string:xba5>");
        self prop_controls::notifyonplayercommand("<dev string:xbb3>", "<dev string:xbb9>");
        self prop_controls::notifyonplayercommand("<dev string:xbb3>", "<dev string:xbc7>");
        self prop_controls::notifyonplayercommand("<dev string:xbb3>", "<dev string:xbd5>");
        self prop_controls::notifyonplayercommand("<dev string:xbb3>", "<dev string:xbe3>");
        self prop_controls::notifyonplayercommand("<dev string:xb3b>", "<dev string:xbf1>");
        self prop_controls::notifyonplayercommand("<dev string:xbf9>", "<dev string:xc01>");
        self prop_controls::notifyonplayercommand("<dev string:xc0a>", "<dev string:xc11>");
        self prop_controls::notifyonplayercommand("<dev string:xc0a>", "<dev string:xc1c>");
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xdfcbfbc4, Offset: 0x38d0
    // Size: 0x1e4
    function function_4e71de66() {
        self prop_controls::notifyonplayercommandremove("<dev string:xb28>", "<dev string:xb7b>");
        self prop_controls::notifyonplayercommandremove("<dev string:xb2b>", "<dev string:xb89>");
        self prop_controls::notifyonplayercommandremove("<dev string:xb36>", "<dev string:xb97>");
        self prop_controls::notifyonplayercommandremove("<dev string:xb30>", "<dev string:xba5>");
        self prop_controls::notifyonplayercommandremove("<dev string:xbb3>", "<dev string:xbb9>");
        self prop_controls::notifyonplayercommandremove("<dev string:xbb3>", "<dev string:xbc7>");
        self prop_controls::notifyonplayercommandremove("<dev string:xbb3>", "<dev string:xbd5>");
        self prop_controls::notifyonplayercommandremove("<dev string:xbb3>", "<dev string:xbe3>");
        self prop_controls::notifyonplayercommandremove("<dev string:xb3b>", "<dev string:xbf1>");
        self prop_controls::notifyonplayercommandremove("<dev string:xbf9>", "<dev string:xc01>");
        self prop_controls::notifyonplayercommandremove("<dev string:xc0a>", "<dev string:xc11>");
        self prop_controls::notifyonplayercommandremove("<dev string:xc0a>", "<dev string:xc1c>");
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x9275892e, Offset: 0x3ac0
    // Size: 0x50
    function function_b7096a63(vec) {
        return isdefined(vec) && (vec[0] != 0 || vec[1] != 0 || vec[2] != 0);
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x3cfc1e47, Offset: 0x3b18
    // Size: 0x48
    function function_f0e744af(propinfo) {
        return isdefined(propinfo.propheight) && propinfo.propheight != prop::getthirdpersonheightoffsetforsize(propinfo.propsize);
    }

    // Namespace prop_dev/_prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0xdfe28e52, Offset: 0x3b68
    // Size: 0x48
    function function_52e4c413(propinfo) {
        return isdefined(propinfo.proprange) && propinfo.proprange != prop::getthirdpersonrangeforsize(propinfo.propsize);
    }

    // Namespace prop_dev/_prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0x867c7fa8, Offset: 0x3bb8
    // Size: 0x264
    function function_954fa963(file, propinfo) {
        propstr = "<dev string:xa1f>" + propinfo.modelname + "<dev string:xc26>" + propinfo.propsizetext + "<dev string:xc26>" + propinfo.propscale;
        if (function_b7096a63(propinfo.xyzoffset)) {
            propstr += "<dev string:xc26>" + propinfo.xyzoffset[0] + "<dev string:xc26>" + propinfo.xyzoffset[1] + "<dev string:xc26>" + propinfo.xyzoffset[2];
        } else {
            propstr += "<dev string:xc28>";
        }
        if (function_b7096a63(propinfo.anglesoffset)) {
            propstr += "<dev string:xc26>" + propinfo.anglesoffset[0] + "<dev string:xc26>" + propinfo.anglesoffset[1] + "<dev string:xc26>" + propinfo.anglesoffset[2];
        } else {
            propstr += "<dev string:xc28>";
        }
        if (function_f0e744af(propinfo)) {
            propstr += "<dev string:xc26>" + propinfo.propheight;
        } else {
            propstr += "<dev string:xc26>" + prop::getthirdpersonheightoffsetforsize(propinfo.propsize);
        }
        if (function_52e4c413(propinfo)) {
            propstr += "<dev string:xc26>" + propinfo.proprange;
        } else {
            propstr += "<dev string:xc26>" + prop::getthirdpersonrangeforsize(propinfo.propsize);
        }
        fprintln(file, propstr);
    }

    // Namespace prop_dev/_prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0xabb5e00d, Offset: 0x3e28
    // Size: 0x5c
    function function_90b01d01(file, propinfo) {
        propstr = "<dev string:xc2f>" + propinfo.modelname + "<dev string:xc45>";
        fprintln(file, propstr);
    }

    // Namespace prop_dev/_prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0xe15261ef, Offset: 0x3e90
    // Size: 0x10c
    function function_74e29250(file, propsizetext) {
        foreach (sizetype in level.proplist) {
            foreach (propinfo in sizetype) {
                if (propinfo.propsizetext == propsizetext) {
                    function_954fa963(file, propinfo);
                }
            }
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0xf2f43f97, Offset: 0x3fa8
    // Size: 0x10c
    function function_bce1e8ea(file, propsizetext) {
        foreach (sizetype in level.proplist) {
            foreach (propinfo in sizetype) {
                if (propinfo.propsizetext == propsizetext) {
                    function_90b01d01(file, propinfo);
                }
            }
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0x638ba747, Offset: 0x40c0
    // Size: 0x314
    function function_d3a80896(file, var_dc7b1be6) {
        var_7b625b5a = var_dc7b1be6 + "<dev string:xc4a>";
        var_74036302 = var_dc7b1be6 + "<dev string:xc4f>";
        var_11e4d40d = var_dc7b1be6 + "<dev string:xc54>";
        var_9f31b917 = level.script + "<dev string:xc5a>";
        var_a0b36f12 = level.script + "<dev string:xc60>";
        var_43a6e14b = "<dev string:xc65>";
        var_6da36d3e = "<dev string:xc7e>";
        var_586b7057 = "<dev string:xc9a>";
        fprintln(file, "<dev string:xcbe>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xd64>");
        fprintln(file, "<dev string:xd6c>" + var_7b625b5a + "<dev string:xd83>");
        fprintln(file, "<dev string:xd95>" + var_74036302 + "<dev string:xd83>");
        fprintln(file, "<dev string:xdac>" + var_11e4d40d + "<dev string:xdbf>" + var_43a6e14b);
        fprintln(file, "<dev string:xdc4>" + var_7b625b5a + "<dev string:xdbf>" + var_586b7057);
        fprintln(file, "<dev string:xdd7>" + var_74036302 + "<dev string:xdbf>" + var_6da36d3e);
        fprintln(file, "<dev string:xdea>");
        fprintln(file, "<dev string:xe0b>" + var_9f31b917 + "<dev string:xe26>" + var_dc7b1be6);
        fprintln(file, "<dev string:xe31>" + var_a0b36f12 + "<dev string:xe4c>" + var_74036302 + "<dev string:xe62>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xe64>");
        fprintln(file, "<dev string:xa1f>");
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x7d8beb3b, Offset: 0x43e0
    // Size: 0x3ac
    function function_543336f9() {
        platform = "<dev string:xe94>";
        if (level.orbis) {
            platform = "<dev string:xe97>";
        } else if (level.durango) {
            platform = "<dev string:xe9d>";
        }
        var_dc7b1be6 = level.script + "<dev string:xea5>";
        var_7b625b5a = var_dc7b1be6 + "<dev string:xc4a>";
        var_36b45864 = "<dev string:xea9>" + platform + "<dev string:xeaf>";
        var_586b7057 = "<dev string:xc9a>";
        file = openfile(var_7b625b5a, "<dev string:xebc>");
        if (file == -1) {
            iprintlnbold("<dev string:xec2>" + var_36b45864 + var_7b625b5a + "<dev string:xed5>");
            println("<dev string:xec2>" + var_36b45864 + var_7b625b5a + "<dev string:xed5>");
            return;
        }
        function_d3a80896(file, var_dc7b1be6);
        fprintln(file, "<dev string:xee2>");
        function_74e29250(file, "<dev string:xb53>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xef5>");
        function_74e29250(file, "<dev string:xb5a>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf02>");
        function_74e29250(file, "<dev string:xb60>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf10>");
        function_74e29250(file, "<dev string:xb67>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf1d>");
        function_74e29250(file, "<dev string:xb6d>");
        iprintlnbold("<dev string:xf30>" + var_36b45864 + var_7b625b5a + "<dev string:xf37>" + var_586b7057);
        println("<dev string:xf30>" + var_36b45864 + var_7b625b5a + "<dev string:xf37>" + var_586b7057);
        closefile(file);
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xd0812575, Offset: 0x4798
    // Size: 0x394
    function function_a8147bf9() {
        platform = "<dev string:xe94>";
        if (level.orbis) {
            platform = "<dev string:xe97>";
        } else if (level.durango) {
            platform = "<dev string:xe9d>";
        }
        var_dc7b1be6 = level.script + "<dev string:xea5>";
        var_7b625b5a = var_dc7b1be6 + "<dev string:xc4f>";
        var_36b45864 = "<dev string:xea9>" + platform + "<dev string:xeaf>";
        var_586b7057 = "<dev string:xc7e>";
        file = openfile(var_7b625b5a, "<dev string:xebc>");
        if (file == -1) {
            iprintlnbold("<dev string:xec2>" + var_36b45864 + var_7b625b5a + "<dev string:xed5>");
            println("<dev string:xec2>" + var_36b45864 + var_7b625b5a + "<dev string:xed5>");
            return;
        }
        fprintln(file, "<dev string:xf42>");
        function_bce1e8ea(file, "<dev string:xb53>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf57>");
        function_bce1e8ea(file, "<dev string:xb5a>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf66>");
        function_bce1e8ea(file, "<dev string:xb60>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf76>");
        function_bce1e8ea(file, "<dev string:xb67>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf85>");
        function_bce1e8ea(file, "<dev string:xb6d>");
        iprintlnbold("<dev string:xf30>" + var_36b45864 + var_7b625b5a + "<dev string:xf37>" + var_586b7057);
        println("<dev string:xf30>" + var_36b45864 + var_7b625b5a + "<dev string:xf37>" + var_586b7057);
        closefile(file);
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x6613df30, Offset: 0x4b38
    // Size: 0xc34
    function function_1a022b4b() {
        platform = "<dev string:xe94>";
        if (level.orbis) {
            platform = "<dev string:xe97>";
        } else if (level.durango) {
            platform = "<dev string:xe9d>";
        }
        var_dc7b1be6 = level.script + "<dev string:xea5>";
        var_7b625b5a = var_dc7b1be6 + "<dev string:xc4a>";
        var_74036302 = var_dc7b1be6 + "<dev string:xc4f>";
        var_11e4d40d = var_dc7b1be6 + "<dev string:xc54>";
        var_9f31b917 = level.script + "<dev string:xc5a>";
        var_a0b36f12 = level.script + "<dev string:xc60>";
        var_36b45864 = "<dev string:xea9>" + platform + "<dev string:xeaf>";
        var_43a6e14b = "<dev string:xc65>";
        var_6da36d3e = "<dev string:xc7e>";
        var_586b7057 = "<dev string:xc9a>";
        file = openfile(var_7b625b5a, "<dev string:xebc>");
        if (file == -1) {
            iprintlnbold("<dev string:xec2>" + var_36b45864 + var_7b625b5a + "<dev string:xed5>");
            println("<dev string:xec2>" + var_36b45864 + var_7b625b5a + "<dev string:xed5>");
            return;
        }
        function_d3a80896(file, var_dc7b1be6);
        fprintln(file, "<dev string:xee2>");
        fprintln(file, "<dev string:xf9a>");
        fprintln(file, "<dev string:xf9a>");
        fprintln(file, "<dev string:xf9a>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xef5>");
        fprintln(file, "<dev string:xfb3>");
        fprintln(file, "<dev string:xfb3>");
        fprintln(file, "<dev string:xfb3>");
        fprintln(file, "<dev string:xfb3>");
        fprintln(file, "<dev string:xfb3>");
        fprintln(file, "<dev string:xfb3>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf02>");
        fprintln(file, "<dev string:xfca>");
        fprintln(file, "<dev string:xfca>");
        fprintln(file, "<dev string:xfca>");
        fprintln(file, "<dev string:xfca>");
        fprintln(file, "<dev string:xfca>");
        fprintln(file, "<dev string:xfca>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf10>");
        fprintln(file, "<dev string:xfe3>");
        fprintln(file, "<dev string:xfe3>");
        fprintln(file, "<dev string:xfe3>");
        fprintln(file, "<dev string:xfe3>");
        fprintln(file, "<dev string:xfe3>");
        fprintln(file, "<dev string:xfe3>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf1d>");
        fprintln(file, "<dev string:xffa>");
        fprintln(file, "<dev string:xffa>");
        fprintln(file, "<dev string:xffa>");
        closefile(file);
        file = openfile(var_74036302, "<dev string:xebc>");
        if (file == -1) {
            iprintlnbold("<dev string:xec2>" + var_36b45864 + var_74036302 + "<dev string:xed5>");
            println("<dev string:xec2>" + var_36b45864 + var_74036302 + "<dev string:xed5>");
            return;
        }
        fprintln(file, "<dev string:xf42>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf57>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf66>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf76>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:xa1f>");
        fprintln(file, "<dev string:xf85>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        fprintln(file, "<dev string:x1018>");
        closefile(file);
        file = openfile(var_11e4d40d, "<dev string:xebc>");
        if (file == -1) {
            iprintlnbold("<dev string:xec2>" + var_36b45864 + var_11e4d40d + "<dev string:xed5>");
            println("<dev string:xec2>" + var_36b45864 + var_11e4d40d + "<dev string:xed5>");
            return;
        }
        fprintln(file, "<dev string:x1032>" + var_7b625b5a);
        fprintln(file, "<dev string:x1052>" + var_74036302);
        closefile(file);
        iprintlnbold("<dev string:x1066>" + var_36b45864);
        println("<dev string:x1066>" + var_36b45864);
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x8f35f2c1, Offset: 0x5778
    // Size: 0x3c2
    function function_c64fb4ca() {
        player = level.players[0];
        if (!isdefined(player) || !isalive(player) || !(isdefined(player.hasspawned) && player.hasspawned)) {
            return;
        }
        if (isdefined(level.players[1])) {
            enemybot = level.players[1];
        } else {
            enemybot = bot::add_bot(util::getotherteam(player.team));
        }
        if (!isdefined(enemybot.pers[#"participation"])) {
            enemybot.pers[#"participation"] = 0;
        }
        if (!isdefined(enemybot.hits)) {
            enemybot.hits = 0;
        }
        setdvar(#"bot_allowattack", 0);
        setdvar(#"bot_allowmovement", 0);
        player.health = player.maxhealth;
        weapon = getweapon("<dev string:x107d>");
        end = player.origin;
        dir = anglestoforward(player.angles);
        start = end + dir * 100 + (0, 0, 30);
        magicbullet(weapon, start, end, enemybot);
        dirback = -1 * dir;
        start = end + dirback * 100 + (0, 0, 30);
        magicbullet(weapon, start, end, enemybot);
        dirright = anglestoright(player.angles);
        start = end + dirright * 100 + (0, 0, 30);
        magicbullet(weapon, start, end, enemybot);
        dirleft = -1 * dirright;
        start = end + dirleft * 100 + (0, 0, 30);
        magicbullet(weapon, start, end, enemybot);
        start = end + (0, 0, 100);
        magicbullet(weapon, start, end, enemybot);
        player waittilltimeout(0.3, #"damage");
        wait 0.05;
        player.health = player.maxhealth;
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xbc390c94, Offset: 0x5b48
    // Size: 0xf0
    function function_276ad638() {
        if (!isdefined(level.players)) {
            return;
        }
        foreach (player in level.players) {
            if (isdefined(player) && isdefined(player.team) && player.team == game.defenders) {
                print3d(player.origin + (0, 0, 50), "<dev string:xa1f>" + player.health);
            }
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xb77b7710, Offset: 0x5c40
    // Size: 0x110
    function function_b52ad1b2() {
        if (!isdefined(level.players)) {
            return;
        }
        foreach (player in level.players) {
            velocity = player getvelocity();
            var_6c52699a = (velocity[0], velocity[1], 0);
            speed = length(var_6c52699a);
            print3d(player.origin + (0, 0, 50), "<dev string:xa1f>" + speed);
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xf03d0f6a, Offset: 0x5d58
    // Size: 0xb8
    function function_b02387d6() {
        if (!isdefined(level.players)) {
            return;
        }
        foreach (player in level.players) {
            if (isdefined(player) && isdefined(player.prop)) {
                player prop_controls::get_ground_normal(player.prop, 1);
            }
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 3, eflags: 0x0
    // Checksum 0xdb1682ed, Offset: 0x5e18
    // Size: 0x2c0
    function function_61b27799(propinfo, origin, angles) {
        propent = spawn("<dev string:x108a>", origin);
        propent setcontents(0);
        propent notsolid();
        propent setplayercollision(0);
        prop = spawn("<dev string:x108a>", propent.origin);
        prop.angles = angles;
        prop setmodel(propinfo.modelname);
        prop setscale(propinfo.propscale);
        prop setcandamage(1);
        prop.xyzoffset = propinfo.xyzoffset;
        prop.anglesoffset = propinfo.anglesoffset;
        prop.health = 1;
        prop setplayercollision(0);
        forward = anglestoforward(angles) * prop.xyzoffset[0];
        right = anglestoright(angles) * prop.xyzoffset[1];
        up = anglestoup(angles) * prop.xyzoffset[2];
        prop.origin += forward;
        prop.origin += right;
        prop.origin += up;
        prop.angles += prop.anglesoffset;
        prop linkto(propent);
        propent.prop = prop;
        propent.propinfo = propinfo;
        return propent;
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x98a9a74f, Offset: 0x60e0
    // Size: 0x226
    function showmodels() {
        player = level.players[0];
        angles = player.angles;
        dir = anglestoforward(angles);
        origin = player.origin + (0, 0, 100);
        if (!isdefined(level.var_7627c471)) {
            level.var_7627c471 = [];
            foreach (category in level.proplist) {
                foreach (propinfo in category) {
                    level.var_7627c471[level.var_7627c471.size] = function_61b27799(propinfo, origin, angles);
                    origin += dir * 60;
                }
            }
            return;
        }
        foreach (propent in level.var_7627c471) {
            propent.origin = origin;
            origin += dir * 60;
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xc79bffee, Offset: 0x6310
    // Size: 0x344
    function function_36895abd() {
        if (!isdefined(level.var_ec1690fd)) {
            return;
        }
        color = (0, 1, 0);
        if (!level.var_ec1690fd.success) {
            color = (1, 0, 0);
        }
        print3d(level.var_ec1690fd.playerorg + (0, 0, 50), level.var_ec1690fd.type);
        box(level.var_ec1690fd.playerorg, level.var_ec1690fd.playermins, level.var_ec1690fd.playermaxs, level.var_ec1690fd.playerangles[1], color);
        if (isdefined(level.var_ec1690fd.origin1)) {
            sphere(level.var_ec1690fd.origin1, 5, color);
            line(level.var_ec1690fd.playerorg, level.var_ec1690fd.origin1);
            if (isdefined(level.var_ec1690fd.text1)) {
                print3d(level.var_ec1690fd.origin1 + (0, 0, -10), level.var_ec1690fd.text1);
            }
        }
        if (isdefined(level.var_ec1690fd.origin2)) {
            sphere(level.var_ec1690fd.origin2, 5, color);
            line(level.var_ec1690fd.playerorg, level.var_ec1690fd.origin2);
            if (isdefined(level.var_ec1690fd.text2)) {
                print3d(level.var_ec1690fd.origin2 + (0, 0, 10), level.var_ec1690fd.text2);
            }
        }
        if (isdefined(level.var_ec1690fd.origin3)) {
            sphere(level.var_ec1690fd.origin3, 5, color);
            line(level.var_ec1690fd.playerorg, level.var_ec1690fd.origin3);
            if (isdefined(level.var_ec1690fd.text3)) {
                print3d(level.var_ec1690fd.origin3 + (0, 0, 30), level.var_ec1690fd.text3);
            }
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 4, eflags: 0x0
    // Checksum 0x3b3ddc05, Offset: 0x6660
    // Size: 0x16c
    function function_b2eba1e3(propinfo, origin, angles, team) {
        var_a20cbf64 = spawn("<dev string:x108a>", origin);
        var_a20cbf64.targetname = "<dev string:x1097>";
        var_a20cbf64 setmodel(propinfo.modelname);
        var_a20cbf64 setscale(propinfo.propscale);
        var_a20cbf64.angles = angles;
        var_a20cbf64 setcandamage(1);
        var_a20cbf64.fakehealth = 50;
        var_a20cbf64.health = 99999;
        var_a20cbf64.maxhealth = 99999;
        var_a20cbf64 thread prop::function_500dc7d9(&prop_controls::damageclonewatch);
        var_a20cbf64 setplayercollision(0);
        var_a20cbf64 makesentient();
        var_a20cbf64 setteam(team);
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xbfff81d8, Offset: 0x67d8
    // Size: 0x236
    function function_9b9725b1() {
        player = level.players[0];
        angles = player.angles;
        dir = anglestoforward(angles);
        origin = player.origin + (0, 0, 100);
        if (isdefined(level.var_79ca1379)) {
            foreach (clone in level.var_79ca1379) {
                clone prop_controls::function_a40d8853();
            }
        }
        level.var_79ca1379 = [];
        foreach (category in level.proplist) {
            foreach (propinfo in category) {
                level.var_79ca1379[level.var_79ca1379.size] = function_b2eba1e3(propinfo, origin, angles, util::getotherteam(player.team));
                origin += dir * 60;
            }
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x4edec3b0, Offset: 0x6a18
    // Size: 0x10a
    function function_6863880e() {
        player = level.players[0];
        angles = player.angles;
        dir = anglestoforward(angles);
        origin = player.origin + dir * (0, 0, 100);
        propinfo = prop::getnextprop(player);
        if (!isdefined(level.var_79ca1379)) {
            level.var_79ca1379 = [];
        }
        level.var_79ca1379[level.var_79ca1379.size] = function_b2eba1e3(propinfo, origin, angles, util::getotherteam(player.team));
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xc28d3ba8, Offset: 0x6b30
    // Size: 0xd8
    function showplayers() {
        if (!isdefined(level.players)) {
            return;
        }
        foreach (player in level.players) {
            box(player.origin, player getmins(), player getmaxs(), player.angles[1], (1, 0, 1), 1, 0, 1);
        }
    }

    // Namespace prop_dev/_prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x3697f01, Offset: 0x6c10
    // Size: 0xd6
    function showtargets() {
        if (!isdefined(level.var_e5ad813f) || !isdefined(level.var_e5ad813f.targets)) {
            return;
        }
        for (i = 0; i < level.var_e5ad813f.targets.size; i++) {
            target = level.var_e5ad813f.targets[i];
            if (isdefined(target)) {
                print3d(target.origin + (0, 0, 30), "<dev string:xa1f>" + target.fakehealth);
            }
        }
    }

#/
