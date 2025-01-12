#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;

#namespace rat;

/#

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1b79e9f8, Offset: 0x88
    // Size: 0x5dc
    function init() {
        if (!isdefined(level.rat)) {
            level.rat = spawnstruct();
            level.rat.common = spawnstruct();
            level.rat.script_command_list = [];
            level.rat.playerskilled = 0;
            level.rat.var_e02af3d0 = 0;
            callback::on_player_killed(&function_2e884888);
            addratscriptcmd("<dev string:x30>", &function_19d7bdd);
            addratscriptcmd("<dev string:x43>", &rscteleport);
            addratscriptcmd("<dev string:x4c>", &function_ae2e3344);
            addratscriptcmd("<dev string:x59>", &function_1e9fa6d1);
            addratscriptcmd("<dev string:x63>", &function_e9104788);
            addratscriptcmd("<dev string:x70>", &function_dae1074b);
            addratscriptcmd("<dev string:x7a>", &function_4bfff7f7);
            addratscriptcmd("<dev string:x83>", &function_738cdf24);
            addratscriptcmd("<dev string:x91>", &function_941be324);
            addratscriptcmd("<dev string:xa3>", &function_4a8d730e);
            addratscriptcmd("<dev string:xb4>", &function_2c20af68);
            addratscriptcmd("<dev string:xc0>", &function_974ea217);
            addratscriptcmd("<dev string:xcf>", &function_a57bc90b);
            addratscriptcmd("<dev string:xe1>", &function_766ec65b);
            addratscriptcmd("<dev string:xf2>", &rscsimulatescripterror);
            addratscriptcmd("<dev string:x106>", &function_1d43b61a);
            addratscriptcmd("<dev string:x118>", &function_e68c20ad);
            addratscriptcmd("<dev string:x122>", &function_693db89b);
            addratscriptcmd("<dev string:x136>", &function_8a81dfda);
            addratscriptcmd("<dev string:x14c>", &function_313e47f);
            addratscriptcmd("<dev string:x157>", &function_6187e667);
            addratscriptcmd("<dev string:x167>", &function_9b0bb0d);
            addratscriptcmd("<dev string:x174>", &function_f846c6d9);
            addratscriptcmd("<dev string:x189>", &function_7200e19e);
            addratscriptcmd("<dev string:x196>", &function_65e3ea3f);
            addratscriptcmd("<dev string:x1a7>", &function_ffabaacf);
            addratscriptcmd("<dev string:x1b9>", &function_ef004462);
            addratscriptcmd("<dev string:x1c8>", &function_1b2eb59b);
            addratscriptcmd("<dev string:x1d5>", &function_c50c8aa7);
            addratscriptcmd("<dev string:x1e9>", &function_8a818d2b);
            addratscriptcmd("<dev string:x1f3>", &function_f687aedd);
            addratscriptcmd("<dev string:x202>", &function_3205da2d);
            addratscriptcmd("<dev string:x216>", &function_6dcf3f54);
        }
    }

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7cb954df, Offset: 0x670
    // Size: 0x24
    function function_5650d768() {
        level flagsys::set("<dev string:x22c>");
    }

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0xad17d9f2, Offset: 0x6a0
    // Size: 0x24
    function function_62053ec9() {
        level flagsys::clear("<dev string:x22c>");
    }

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0x903b5f3, Offset: 0x6d0
    // Size: 0x24
    function function_98499d2() {
        level flagsys::set("<dev string:x247>");
    }

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6983e2f6, Offset: 0x700
    // Size: 0x24
    function function_7f411587() {
        level flagsys::clear("<dev string:x247>");
    }

    // Namespace rat/rat_shared
    // Params 2, eflags: 0x0
    // Checksum 0xa0816340, Offset: 0x730
    // Size: 0x4a
    function addratscriptcmd(commandname, functioncallback) {
        init();
        level.rat.script_command_list[commandname] = functioncallback;
    }

    // Namespace rat/rat_scriptcommand
    // Params 1, eflags: 0x40
    // Checksum 0x4da5f74d, Offset: 0x788
    // Size: 0x114
    function event_handler[rat_scriptcommand] codecallback_ratscriptcommand(params) {
        init();
        assert(isdefined(params._cmd));
        assert(isdefined(params._id));
        assert(isdefined(level.rat.script_command_list[params._cmd]), "<dev string:x260>" + params._cmd);
        callback = level.rat.script_command_list[params._cmd];
        ret = level [[ callback ]](params);
        ratreportcommandresult(params._id, 1, ret);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc8d1f049, Offset: 0x8a8
    // Size: 0x154
    function getplayer(params) {
        if (isdefined(params._xuid)) {
            xuid = int(params._xuid);
            foreach (player in getplayers()) {
                if (!isdefined(player.bot)) {
                    player_xuid = int(player getxuid(1));
                    if (xuid == player_xuid) {
                        return player;
                    }
                }
            }
            ratreportcommandresult(params._id, 0, "<dev string:x27c>");
            wait 1;
            return;
        }
        return util::gethostplayer();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x935c6c65, Offset: 0xa08
    // Size: 0x98
    function function_19d7bdd(params) {
        foreach (cmd, func in level.rat.script_command_list) {
            function_dd184abd(params._id, cmd);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5de87d3, Offset: 0xaa8
    // Size: 0x2c
    function function_766ec65b(params) {
        if (isdefined(level.inprematchperiod)) {
            return level.inprematchperiod;
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x3fe56ce5, Offset: 0xae0
    // Size: 0x124
    function rscteleport(params) {
        player = getplayer(params);
        pos = (float(params.x), float(params.y), float(params.z));
        player setorigin(pos);
        if (isdefined(params.ax)) {
            angles = (float(params.ax), float(params.ay), float(params.az));
            player setplayerangles(angles);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x19aa6e2d, Offset: 0xc10
    // Size: 0x4c
    function function_e68c20ad(params) {
        player = getplayer(params);
        player setstance(params.stance);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb13f6f8d, Offset: 0xc68
    // Size: 0x44
    function function_1e9fa6d1(params) {
        player = getplayer(params);
        return player getstance();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x640d9307, Offset: 0xcb8
    // Size: 0x44
    function function_313e47f(params) {
        player = getplayer(params);
        return player ismeleeing();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6dd950cd, Offset: 0xd08
    // Size: 0x44
    function function_e9104788(params) {
        player = getplayer(params);
        return player playerads();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x529d5ce7, Offset: 0xd58
    // Size: 0x3c
    function function_dae1074b(params) {
        player = getplayer(params);
        return player.health;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x39a15d67, Offset: 0xda0
    // Size: 0xac
    function function_4bfff7f7(params) {
        player = getplayer(params);
        if (isdefined(params.amount)) {
            player dodamage(int(params.amount), player getorigin());
            return;
        }
        player dodamage(1, player getorigin());
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1bd37aae, Offset: 0xe58
    // Size: 0x6c
    function function_738cdf24(params) {
        player = getplayer(params);
        currentweapon = player getcurrentweapon();
        if (isdefined(currentweapon.name)) {
            return currentweapon.name;
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf585f83c, Offset: 0xed0
    // Size: 0x6c
    function function_3205da2d(params) {
        player = getplayer(params);
        currentweapon = player getcurrentweapon();
        if (isdefined(currentweapon.name)) {
            return currentweapon.reloadtime;
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xde07bfc9, Offset: 0xf48
    // Size: 0x64
    function function_941be324(params) {
        player = getplayer(params);
        currentweapon = player getcurrentweapon();
        return player getammocount(currentweapon);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2ad0b233, Offset: 0xfb8
    // Size: 0x64
    function function_4a8d730e(params) {
        player = getplayer(params);
        currentweapon = player getcurrentweapon();
        return player getweaponammoclip(currentweapon);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf5348c0f, Offset: 0x1028
    // Size: 0x64
    function function_2c20af68(params) {
        player = getplayer(params);
        currentweapon = player getcurrentweapon();
        return player getweaponammoclipsize(currentweapon);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8b3ddd6a, Offset: 0x1098
    // Size: 0xac
    function function_a57bc90b(params) {
        player = getplayer(params);
        origin = player getorigin();
        function_dd184abd(params._id, origin);
        angles = player getplayerangles();
        function_dd184abd(params._id, angles);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xdd1813c7, Offset: 0x1150
    // Size: 0x4c
    function function_974ea217(params) {
        if (isdefined(params.var_e67d86c4)) {
            return getnumconnectedplayers(1);
        }
        return getnumconnectedplayers(0);
    }

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0x426aa2c4, Offset: 0x11a8
    // Size: 0x6a
    function function_2e884888() {
        if (isdefined(self.bot)) {
            level.rat.var_e02af3d0 += 1;
            return;
        }
        level.rat.playerskilled += 1;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x72362828, Offset: 0x1220
    // Size: 0x24
    function function_6187e667(params) {
        return level.rat.playerskilled;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xab0a6292, Offset: 0x1250
    // Size: 0x24
    function function_9b0bb0d(params) {
        return level.rat.var_e02af3d0;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5829efcc, Offset: 0x1280
    // Size: 0x18c
    function function_ae2e3344(params) {
        foreach (player in level.players) {
            if (!isdefined(player.bot)) {
                continue;
            }
            pos = (float(params.x), float(params.y), float(params.z));
            player setorigin(pos);
            if (isdefined(params.ax)) {
                angles = (float(params.ax), float(params.ay), float(params.az));
                player setplayerangles(angles);
            }
            if (!isdefined(params.all)) {
                break;
            }
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x20405a3f, Offset: 0x1418
    // Size: 0x190
    function function_693db89b(params) {
        player = getplayer(params);
        forward = anglestoforward(player.angles);
        distance = 50;
        if (isdefined(params.distance)) {
            distance = float(params.distance);
        }
        spawn = player.origin + forward * distance;
        foreach (other_player in level.players) {
            if (other_player == player) {
                continue;
            }
            if (isdefined(params.var_5e0bb988) && int(params.var_5e0bb988) && !isdefined(other_player.bot)) {
                continue;
            }
            other_player setorigin(spawn);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x92ee747c, Offset: 0x15b0
    // Size: 0x1ec
    function function_8a81dfda(params) {
        player = getplayer(params);
        forward = anglestoforward(player.angles);
        distance = 50;
        if (isdefined(params.distance)) {
            distance = float(params.distance);
        }
        spawn = player.origin + forward * distance;
        foreach (other_player in level.players) {
            if (isdefined(params.bot) && int(params.bot) && !isdefined(other_player.bot)) {
                continue;
            }
            if (player getteam() != other_player getteam()) {
                other_player setorigin(spawn);
                other_player setplayerangles(player.angles);
                return;
            }
        }
        ratreportcommandresult(params._id, 0, "<dev string:x2a1>");
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x333cb057, Offset: 0x17a8
    // Size: 0xd4
    function function_6dcf3f54(params) {
        player = getplayer(params);
        forward = anglestoforward(player.angles);
        distance = 50;
        if (isdefined(params.distance)) {
            distance = float(params.distance);
        }
        front = player.origin + forward * distance;
        player setorigin(front);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x449f3d04, Offset: 0x1888
    // Size: 0x44
    function function_f846c6d9(params) {
        player = getplayer(params);
        return player isplayinganimscripted();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x343dbb55, Offset: 0x18d8
    // Size: 0x46
    function function_65e3ea3f(params) {
        player = getplayer(params);
        return !player arecontrolsfrozen();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x49e990fd, Offset: 0x1928
    // Size: 0x3c
    function function_7200e19e(params) {
        if (isdefined(params.flag)) {
            return flagsys::get(params.flag);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x26a9fc08, Offset: 0x1970
    // Size: 0xa6
    function function_1d43b61a(params) {
        foreach (player in getplayers()) {
            if (isbot(player)) {
                return player.health;
            }
        }
        return -1;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb24e4d4, Offset: 0x1a20
    // Size: 0x42
    function function_1b2eb59b(params) {
        if (isdefined(level.var_571dce92)) {
            level [[ level.var_571dce92 ]]();
            return 1;
        }
        return 0;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4470c632, Offset: 0x1a70
    // Size: 0x64
    function function_22f50f8e(name) {
        level flagsys::set("<dev string:x2cf>");
        level scene::play(name);
        level flagsys::clear("<dev string:x2cf>");
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x35983290, Offset: 0x1ae0
    // Size: 0x64
    function function_8a818d2b(params) {
        if (isdefined(params.name)) {
            level thread function_22f50f8e(params.name);
            return;
        }
        ratreportcommandresult(params._id, 0, "<dev string:x2d9>");
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xdde1b293, Offset: 0x1b50
    // Size: 0x2c
    function function_f687aedd(params) {
        return flagsys::get("<dev string:x2cf>");
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x3e7471fe, Offset: 0x1b88
    // Size: 0x5e
    function rscsimulatescripterror(params) {
        if (params.errorlevel == "<dev string:x2f0>") {
            assertmsg("<dev string:x2f6>");
            return;
        }
        thisdoesntexist.orthis = 0;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xaa49be88, Offset: 0x1bf0
    // Size: 0x154
    function rscrecteleport(params) {
        println("<dev string:x30f>");
        player = [[ level.rat.common.gethostplayer ]]();
        pos = player getorigin();
        angles = player getplayerangles();
        cmd = "<dev string:x331>" + pos[0] + "<dev string:x342>" + pos[1] + "<dev string:x346>" + pos[2] + "<dev string:x34a>" + angles[0] + "<dev string:x34f>" + angles[1] + "<dev string:x354>" + angles[2];
        ratrecordmessage(0, "<dev string:x359>", cmd);
        setdvar(#"rat_record_teleport_request", 0);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x11d862c1, Offset: 0x1d50
    // Size: 0x84
    function function_ffabaacf(params) {
        num = 0;
        if (isdefined(params)) {
            if (isdefined(params.num)) {
                num = int(params.num);
            }
        }
        if (num > 0) {
            adddebugcommand("<dev string:x366>" + num);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x59421a, Offset: 0x1de0
    // Size: 0x84
    function function_ef004462(params) {
        num = 0;
        if (isdefined(params)) {
            if (isdefined(params.num)) {
                num = int(params.num);
            }
        }
        if (num > 0) {
            adddebugcommand("<dev string:x383>" + num);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf35e0a01, Offset: 0x1e70
    // Size: 0x44
    function function_c50c8aa7(params) {
        player = getplayer(params);
        toggleplayercontrol(player);
    }

#/
