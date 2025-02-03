#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;

#namespace rat;

/#

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9b40ccad, Offset: 0x80
    // Size: 0x624
    function init() {
        if (!isdefined(level.rat)) {
            level.rat = spawnstruct();
            level.rat.common = spawnstruct();
            level.rat.script_command_list = [];
            level.rat.playerskilled = 0;
            level.rat.var_cd4fd549 = 0;
            callback::on_player_killed(&function_cecf7c3d);
            addratscriptcmd("<dev string:x38>", &function_5fd1a95b);
            addratscriptcmd("<dev string:x4e>", &rscteleport);
            addratscriptcmd("<dev string:x5a>", &function_51706559);
            addratscriptcmd("<dev string:x6a>", &function_b2fe8b5a);
            addratscriptcmd("<dev string:x77>", &function_bff535fb);
            addratscriptcmd("<dev string:x87>", &function_220d66d8);
            addratscriptcmd("<dev string:x94>", &function_be6e2f9f);
            addratscriptcmd("<dev string:xa0>", &function_ff0fa082);
            addratscriptcmd("<dev string:xb1>", &function_aecb1023);
            addratscriptcmd("<dev string:xc6>", &function_90282828);
            addratscriptcmd("<dev string:xda>", &function_3b51dc31);
            addratscriptcmd("<dev string:xe9>", &function_a6d4d86b);
            addratscriptcmd("<dev string:xfb>", &function_54b7f226);
            addratscriptcmd("<dev string:x110>", &function_1b77bedd);
            addratscriptcmd("<dev string:x124>", &rscsimulatescripterror);
            addratscriptcmd("<dev string:x13b>", &function_1f00a502);
            addratscriptcmd("<dev string:x150>", &function_696e6dd3);
            addratscriptcmd("<dev string:x15d>", &function_dec22d87);
            addratscriptcmd("<dev string:x174>", &function_e3ab4393);
            addratscriptcmd("<dev string:x18d>", &function_cb62ece6);
            addratscriptcmd("<dev string:x19b>", &function_d197a150);
            addratscriptcmd("<dev string:x1ae>", &function_c4336b49);
            addratscriptcmd("<dev string:x1be>", &function_ccc178f3);
            addratscriptcmd("<dev string:x1d6>", &function_2fa64525);
            addratscriptcmd("<dev string:x1e6>", &function_6fb461e2);
            addratscriptcmd("<dev string:x1fa>", &function_f52fc58b);
            addratscriptcmd("<dev string:x20f>", &function_dbc9b57c);
            addratscriptcmd("<dev string:x221>", &function_4f3a7675);
            addratscriptcmd("<dev string:x231>", &function_458913b0);
            addratscriptcmd("<dev string:x248>", &function_191d6974);
            addratscriptcmd("<dev string:x255>", &function_d1b632ff);
            addratscriptcmd("<dev string:x267>", &function_7d9a084b);
            addratscriptcmd("<dev string:x27e>", &function_1ac5a32b);
            addratscriptcmd("<dev string:x297>", &function_7992a479);
            addratscriptcmd("<dev string:x2a5>", &function_9efe300c);
        }
    }

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8731a8a3, Offset: 0x6b0
    // Size: 0x24
    function function_7d22c1c9() {
        level flag::set("<dev string:x2b8>");
    }

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc706e0ca, Offset: 0x6e0
    // Size: 0x24
    function function_65e13d0f() {
        level flag::clear("<dev string:x2b8>");
    }

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7a68329b, Offset: 0x710
    // Size: 0x24
    function function_b4f2a076() {
        level flag::set("<dev string:x2d6>");
    }

    // Namespace rat/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0xed0de5b7, Offset: 0x740
    // Size: 0x24
    function function_6aa20375() {
        level flag::clear("<dev string:x2d6>");
    }

    // Namespace rat/rat_shared
    // Params 2, eflags: 0x0
    // Checksum 0xcc9dd75d, Offset: 0x770
    // Size: 0x44
    function addratscriptcmd(commandname, functioncallback) {
        init();
        level.rat.script_command_list[commandname] = functioncallback;
    }

    // Namespace rat/rat_scriptcommand
    // Params 1, eflags: 0x40
    // Checksum 0x705caa58, Offset: 0x7c0
    // Size: 0x114
    function event_handler[rat_scriptcommand] codecallback_ratscriptcommand(params) {
        init();
        assert(isdefined(params._cmd));
        assert(isdefined(params._id));
        assert(isdefined(level.rat.script_command_list[params._cmd]), "<dev string:x2f2>" + params._cmd);
        callback = level.rat.script_command_list[params._cmd];
        ret = level [[ callback ]](params);
        ratreportcommandresult(params._id, 1, ret);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb04e7e6, Offset: 0x8e0
    // Size: 0x15c
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
            ratreportcommandresult(params._id, 0, "<dev string:x311>");
            wait 1;
            return;
        }
        return util::gethostplayer();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xddbd3f15, Offset: 0xa48
    // Size: 0xa8
    function function_5fd1a95b(params) {
        foreach (cmd, func in level.rat.script_command_list) {
            function_55e20e75(params._id, cmd);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xfd992eeb, Offset: 0xaf8
    // Size: 0x6c
    function function_7992a479(params) {
        player = getplayer(params);
        weapon = getweapon(params.weaponname);
        player giveweapon(weapon);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xace12809, Offset: 0xb70
    // Size: 0x2c
    function function_1b77bedd(*params) {
        if (isdefined(level.inprematchperiod)) {
            return level.inprematchperiod;
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1d3a6ea3, Offset: 0xba8
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
    // Checksum 0x26f9cdb0, Offset: 0xcd8
    // Size: 0x4c
    function function_696e6dd3(params) {
        player = getplayer(params);
        player setstance(params.stance);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xed424975, Offset: 0xd30
    // Size: 0x44
    function function_b2fe8b5a(params) {
        player = getplayer(params);
        return player getstance();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc5a53d20, Offset: 0xd80
    // Size: 0x44
    function function_cb62ece6(params) {
        player = getplayer(params);
        return player ismeleeing();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x73a444ed, Offset: 0xdd0
    // Size: 0x44
    function function_bff535fb(params) {
        player = getplayer(params);
        return player playerads();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xbfeaf794, Offset: 0xe20
    // Size: 0x38
    function function_220d66d8(params) {
        player = getplayer(params);
        return player.health;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x38ade2f0, Offset: 0xe60
    // Size: 0xac
    function function_be6e2f9f(params) {
        player = getplayer(params);
        if (isdefined(params.amount)) {
            player dodamage(int(params.amount), player getorigin());
            return;
        }
        player dodamage(1, player getorigin());
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe97485fe, Offset: 0xf18
    // Size: 0x78
    function function_ff0fa082(params) {
        player = getplayer(params);
        if (!isdefined(player)) {
            return "<dev string:x339>";
        }
        currentweapon = player getcurrentweapon();
        if (isdefined(currentweapon.name)) {
            return currentweapon.name;
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6198ec86, Offset: 0xf98
    // Size: 0x68
    function function_7d9a084b(params) {
        player = getplayer(params);
        currentweapon = player getcurrentweapon();
        if (isdefined(currentweapon.name)) {
            return currentweapon.reloadtime;
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe5580be0, Offset: 0x1008
    // Size: 0x64
    function function_aecb1023(params) {
        player = getplayer(params);
        currentweapon = player getcurrentweapon();
        return player getammocount(currentweapon);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xba2f9c4f, Offset: 0x1078
    // Size: 0x64
    function function_90282828(params) {
        player = getplayer(params);
        currentweapon = player getcurrentweapon();
        return player getweaponammoclip(currentweapon);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7c5c32df, Offset: 0x10e8
    // Size: 0x64
    function function_3b51dc31(params) {
        player = getplayer(params);
        currentweapon = player getcurrentweapon();
        return player getweaponammoclipsize(currentweapon);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7c5337d0, Offset: 0x1158
    // Size: 0xac
    function function_54b7f226(params) {
        player = getplayer(params);
        origin = player getorigin();
        function_55e20e75(params._id, origin);
        angles = player getplayerangles();
        function_55e20e75(params._id, angles);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd6302d9c, Offset: 0x1210
    // Size: 0x4c
    function function_a6d4d86b(params) {
        if (isdefined(params.var_185699f8)) {
            return getnumconnectedplayers(1);
        }
        return getnumconnectedplayers(0);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb6ff62ec, Offset: 0x1268
    // Size: 0x72
    function function_cecf7c3d(*params) {
        if (isdefined(self.bot)) {
            level.rat.var_cd4fd549 += 1;
            return;
        }
        level.rat.playerskilled += 1;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x21005bfc, Offset: 0x12e8
    // Size: 0x24
    function function_d197a150(*params) {
        return level.rat.playerskilled;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd224a320, Offset: 0x1318
    // Size: 0x24
    function function_c4336b49(*params) {
        return level.rat.var_cd4fd549;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x78eea671, Offset: 0x1348
    // Size: 0x19c
    function function_51706559(params) {
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
    // Checksum 0xe8d3c4c4, Offset: 0x14f0
    // Size: 0x190
    function function_dec22d87(params) {
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
            if (isdefined(params.var_5d792f96) && int(params.var_5d792f96) && !isdefined(other_player.bot)) {
                continue;
            }
            other_player setorigin(spawn);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc14bb85, Offset: 0x1688
    // Size: 0x1ec
    function function_e3ab4393(params) {
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
        ratreportcommandresult(params._id, 0, "<dev string:x33d>");
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe8179d50, Offset: 0x1880
    // Size: 0xcc
    function function_1ac5a32b(params) {
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
    // Checksum 0xa7241882, Offset: 0x1958
    // Size: 0x44
    function function_ccc178f3(params) {
        player = getplayer(params);
        return player isplayinganimscripted();
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x346f3211, Offset: 0x19a8
    // Size: 0x52
    function function_6fb461e2(params) {
        player = getplayer(params);
        if (isdefined(player)) {
            return !player arecontrolsfrozen();
        }
        return 0;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd1f925d9, Offset: 0x1a08
    // Size: 0x3c
    function function_2fa64525(params) {
        if (isdefined(params.flag)) {
            return flag::get(params.flag);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4e61419d, Offset: 0x1a50
    // Size: 0xb2
    function function_1f00a502(*params) {
        foreach (player in getplayers()) {
            if (isbot(player)) {
                return player.health;
            }
        }
        return -1;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe56d33b7, Offset: 0x1b10
    // Size: 0x42
    function function_4f3a7675(*params) {
        if (isdefined(level.var_5efad16e)) {
            level [[ level.var_5efad16e ]]();
            return 1;
        }
        return 0;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x17d96d73, Offset: 0x1b60
    // Size: 0x64
    function function_d04e8397(name) {
        level flag::set("<dev string:x36e>");
        level scene::play(name);
        level flag::clear("<dev string:x36e>");
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb190dfd, Offset: 0x1bd0
    // Size: 0x64
    function function_191d6974(params) {
        if (isdefined(params.name)) {
            level thread function_d04e8397(params.name);
            return;
        }
        ratreportcommandresult(params._id, 0, "<dev string:x37b>");
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x50531699, Offset: 0x1c40
    // Size: 0x2c
    function function_d1b632ff(*params) {
        return flag::get("<dev string:x36e>");
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xbaf6d0f7, Offset: 0x1c78
    // Size: 0x5a
    function rscsimulatescripterror(params) {
        if (params.errorlevel == "<dev string:x395>") {
            assertmsg("<dev string:x39e>");
            return;
        }
        thisdoesntexist.orthis = 0;
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa28c5d5d, Offset: 0x1ce0
    // Size: 0x154
    function rscrecteleport(*params) {
        println("<dev string:x3ba>");
        player = [[ level.rat.common.gethostplayer ]]();
        pos = player getorigin();
        angles = player getplayerangles();
        cmd = "<dev string:x3df>" + pos[0] + "<dev string:x3f3>" + pos[1] + "<dev string:x3fa>" + pos[2] + "<dev string:x401>" + angles[0] + "<dev string:x409>" + angles[1] + "<dev string:x411>" + angles[2];
        ratrecordmessage(0, "<dev string:x419>", cmd);
        setdvar(#"rat_record_teleport_request", 0);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x79bd2831, Offset: 0x1e40
    // Size: 0x7c
    function function_f52fc58b(params) {
        num = 0;
        if (isdefined(params)) {
            if (isdefined(params.num)) {
                num = int(params.num);
            }
        }
        if (num > 0) {
            adddebugcommand("<dev string:x429>" + num);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x223db7f0, Offset: 0x1ec8
    // Size: 0x7c
    function function_dbc9b57c(params) {
        num = 0;
        if (isdefined(params)) {
            if (isdefined(params.num)) {
                num = int(params.num);
            }
        }
        if (num > 0) {
            adddebugcommand("<dev string:x449>" + num);
        }
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1cae2f93, Offset: 0x1f50
    // Size: 0x44
    function function_458913b0(params) {
        player = getplayer(params);
        toggleplayercontrol(player);
    }

    // Namespace rat/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe48c7b17, Offset: 0x1fa0
    // Size: 0x134
    function function_9efe300c(params) {
        player = getplayer(params);
        spawn = 0;
        team = "<dev string:x466>";
        if (isdefined(params) && isdefined(params.spawn)) {
            if (isdefined(params.spawn)) {
                spawn = int(params.spawn);
            }
            if (isdefined(params.team)) {
                team = params.team;
            }
        }
        if (isdefined(level.spawn_start) && isdefined(level.spawn_start[team])) {
            player setorigin(level.spawn_start[team][spawn].origin);
            player setplayerangles(level.spawn_start[team][spawn].angles);
        }
    }

#/
