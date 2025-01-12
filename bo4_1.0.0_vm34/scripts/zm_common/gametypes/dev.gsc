#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\util;

#namespace dev;

/#

    // Namespace dev/dev
    // Params 0, eflags: 0x2
    // Checksum 0x8111377f, Offset: 0xd0
    // Size: 0x4c
    function autoexec __init__system__() {
        system::register(#"dev", &__init__, undefined, #"spawnlogic");
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x301d87d0, Offset: 0x128
    // Size: 0x2c
    function __init__() {
        callback::on_start_gametype(&init);
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xfaa0ee37, Offset: 0x160
    // Size: 0x310
    function init() {
        if (getdvarstring(#"scr_show_hq_spawns") == "<dev string:x30>") {
            setdvar(#"scr_show_hq_spawns", "<dev string:x30>");
        }
        if (!isdefined(getdvar(#"scr_testscriptruntimeerror"))) {
            setdvar(#"scr_testscriptruntimeerror", "<dev string:x31>");
        }
        thread testscriptruntimeerror();
        thread testdvars();
        thread devhelipathdebugdraw();
        thread devstraferunpathdebugdraw();
        thread globallogic_score::setplayermomentumdebug();
        setdvar(#"scr_giveperk", "<dev string:x30>");
        setdvar(#"scr_forceevent", "<dev string:x30>");
        setdvar(#"scr_draw_triggers", 0);
        thread equipment_dev_gui();
        thread grenade_dev_gui();
        setdvar(#"debug_dynamic_ai_spawning", 0);
        level.dem_spawns = [];
        if (level.gametype == "<dev string:x36>") {
            extra_spawns = [];
            extra_spawns[0] = "<dev string:x3a>";
            extra_spawns[1] = "<dev string:x52>";
            extra_spawns[2] = "<dev string:x6a>";
            extra_spawns[3] = "<dev string:x82>";
            for (i = 0; i < extra_spawns.size; i++) {
                points = getentarray(extra_spawns[i], "<dev string:x9a>");
                if (isdefined(points) && points.size > 0) {
                    level.dem_spawns = arraycombine(level.dem_spawns, points, 1, 0);
                }
            }
        }
        callback::on_connect(&on_player_connect);
        for (;;) {
            updatedevsettings();
            wait 0.5;
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x250990e1, Offset: 0x478
    // Size: 0x8
    function on_player_connect() {
        
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x7f5069f5, Offset: 0x488
    // Size: 0x4c
    function warpalltohost(team) {
        host = util::gethostplayer();
        warpalltoplayer(team, host.name);
    }

    // Namespace dev/dev
    // Params 2, eflags: 0x0
    // Checksum 0x7ac07048, Offset: 0x4e0
    // Size: 0x34c
    function warpalltoplayer(team, player) {
        players = getplayers();
        target = undefined;
        for (i = 0; i < players.size; i++) {
            if (players[i].name == player) {
                target = players[i];
                break;
            }
        }
        if (isdefined(target)) {
            origin = target.origin;
            nodes = getnodesinradius(origin, 128, 32, 128, #"path");
            angles = target getplayerangles();
            yaw = (0, angles[1], 0);
            forward = anglestoforward(yaw);
            spawn_origin = origin + forward * 128 + (0, 0, 16);
            if (!bullettracepassed(target geteye(), spawn_origin, 0, target)) {
                spawn_origin = undefined;
            }
            for (i = 0; i < players.size; i++) {
                if (players[i] == target) {
                    continue;
                }
                if (isdefined(team)) {
                    if (strstartswith(team, "<dev string:xa4>") && target.team == players[i].team) {
                        continue;
                    }
                    if (strstartswith(team, "<dev string:xad>") && target.team != players[i].team) {
                        continue;
                    }
                }
                if (isdefined(spawn_origin)) {
                    players[i] setorigin(spawn_origin);
                    continue;
                }
                if (nodes.size > 0) {
                    node = array::random(nodes);
                    players[i] setorigin(node.origin);
                    continue;
                }
                players[i] setorigin(origin);
            }
        }
        setdvar(#"scr_playerwarp", "<dev string:x30>");
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x24586f3e, Offset: 0x838
    // Size: 0x41c
    function updatedevsettingszm() {
        if (level.players.size > 0) {
            if (getdvarint(#"r_streamdumpdistance", 0) == 3) {
                if (!isdefined(level.streamdumpteamindex)) {
                    level.streamdumpteamindex = 0;
                } else {
                    level.streamdumpteamindex++;
                }
                numpoints = 0;
                spawnpoints = [];
                location = level.scr_zm_map_start_location;
                if ((location == "<dev string:xb9>" || location == "<dev string:x30>") && isdefined(level.default_start_location)) {
                    location = level.default_start_location;
                }
                match_string = level.scr_zm_ui_gametype + "<dev string:xc1>" + location;
                if (level.streamdumpteamindex < level.teams.size) {
                    structs = struct::get_array("<dev string:xc3>", "<dev string:xd1>");
                    if (isdefined(structs)) {
                        foreach (struct in structs) {
                            if (isdefined(struct.script_string)) {
                                tokens = strtok(struct.script_string, "<dev string:xe3>");
                                foreach (token in tokens) {
                                    if (token == match_string) {
                                        spawnpoints[spawnpoints.size] = struct;
                                    }
                                }
                            }
                        }
                    }
                    if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
                        spawnpoints = struct::get_array("<dev string:xe5>", "<dev string:xfa>");
                    }
                    if (isdefined(spawnpoints)) {
                        numpoints = spawnpoints.size;
                    }
                }
                if (numpoints == 0) {
                    setdvar(#"r_streamdumpdistance", 0);
                    level.streamdumpteamindex = -1;
                    return;
                }
                averageorigin = (0, 0, 0);
                averageangles = (0, 0, 0);
                foreach (spawnpoint in spawnpoints) {
                    averageorigin += spawnpoint.origin / numpoints;
                    averageangles += spawnpoint.angles / numpoints;
                }
                level.players[0] setplayerangles(averageangles);
                level.players[0] setorigin(averageorigin);
                waitframe(1);
                setdvar(#"r_streamdumpdistance", 2);
            }
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x47d4db1f, Offset: 0xc60
    // Size: 0x209c
    function updatedevsettings() {
        show_spawns = getdvarint(#"scr_showspawns", 0);
        show_start_spawns = getdvarint(#"scr_showstartspawns", 0);
        player = util::gethostplayer();
        if (show_spawns >= 1) {
            show_spawns = 1;
        } else {
            show_spawns = 0;
        }
        if (show_start_spawns >= 1) {
            show_start_spawns = 1;
        } else {
            show_start_spawns = 0;
        }
        if (!isdefined(level.show_spawns) || level.show_spawns != show_spawns) {
            level.show_spawns = show_spawns;
            setdvar(#"scr_showspawns", level.show_spawns);
            if (level.show_spawns) {
                showspawnpoints();
            } else {
                hidespawnpoints();
            }
        }
        if (!isdefined(level.show_start_spawns) || level.show_start_spawns != show_start_spawns) {
            level.show_start_spawns = show_start_spawns;
            setdvar(#"scr_showstartspawns", level.show_start_spawns);
            if (level.show_start_spawns) {
                showstartspawnpoints();
            } else {
                hidestartspawnpoints();
            }
        }
        updateminimapsetting();
        if (level.players.size > 0) {
            if (getdvarstring(#"scr_playerwarp") == "<dev string:x105>") {
                warpalltohost();
            } else if (getdvarstring(#"scr_playerwarp") == "<dev string:x10a>") {
                warpalltohost(getdvarstring(#"scr_playerwarp"));
            } else if (getdvarstring(#"scr_playerwarp") == "<dev string:x117>") {
                warpalltohost(getdvarstring(#"scr_playerwarp"));
            } else if (strstartswith(getdvarstring(#"scr_playerwarp"), "<dev string:xa4>")) {
                name = getsubstr(getdvarstring(#"scr_playerwarp"), 8);
                warpalltoplayer(getdvarstring(#"scr_playerwarp"), name);
            } else if (strstartswith(getdvarstring(#"scr_playerwarp"), "<dev string:xad>")) {
                name = getsubstr(getdvarstring(#"scr_playerwarp"), 11);
                warpalltoplayer(getdvarstring(#"scr_playerwarp"), name);
            } else if (strstartswith(getdvarstring(#"scr_playerwarp"), "<dev string:x127>")) {
                name = getsubstr(getdvarstring(#"scr_playerwarp"), 4);
                warpalltoplayer(undefined, name);
            } else if (getdvarstring(#"scr_playerwarp") == "<dev string:x12c>") {
                players = getplayers();
                setdvar(#"scr_playerwarp", "<dev string:x30>");
                if (!isdefined(level.devgui_start_spawn_index)) {
                    level.devgui_start_spawn_index = 0;
                }
                player = util::gethostplayer();
                spawns = level.spawn_start[player.pers[#"team"]];
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
                }
                level.devgui_start_spawn_index++;
                if (level.devgui_start_spawn_index >= spawns.size) {
                    level.devgui_start_spawn_index = 0;
                }
            } else if (getdvarstring(#"scr_playerwarp") == "<dev string:x13d>") {
                players = getplayers();
                setdvar(#"scr_playerwarp", "<dev string:x30>");
                if (!isdefined(level.devgui_start_spawn_index)) {
                    level.devgui_start_spawn_index = 0;
                }
                player = util::gethostplayer();
                spawns = level.spawn_start[player.pers[#"team"]];
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
                }
                level.devgui_start_spawn_index--;
                if (level.devgui_start_spawn_index < 0) {
                    level.devgui_start_spawn_index = spawns.size - 1;
                }
            } else if (getdvarstring(#"scr_playerwarp") == "<dev string:x14e>") {
                players = getplayers();
                setdvar(#"scr_playerwarp", "<dev string:x30>");
                if (!isdefined(level.devgui_spawn_index)) {
                    level.devgui_spawn_index = 0;
                }
                spawns = level.spawnpoints;
                spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
                }
                level.devgui_spawn_index++;
                if (level.devgui_spawn_index >= spawns.size) {
                    level.devgui_spawn_index = 0;
                }
            } else if (getdvarstring(#"scr_playerwarp") == "<dev string:x159>") {
                players = getplayers();
                setdvar(#"scr_playerwarp", "<dev string:x30>");
                if (!isdefined(level.devgui_spawn_index)) {
                    level.devgui_spawn_index = 0;
                }
                spawns = level.spawnpoints;
                spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
                }
                level.devgui_spawn_index--;
                if (level.devgui_spawn_index < 0) {
                    level.devgui_spawn_index = spawns.size - 1;
                }
            } else if (getdvarstring(#"scr_devgui_spawn") != "<dev string:x30>") {
                player = util::gethostplayer();
                if (!isdefined(player.devgui_spawn_active)) {
                    player.devgui_spawn_active = 0;
                }
                if (!player.devgui_spawn_active) {
                    iprintln("<dev string:x164>");
                    iprintln("<dev string:x187>");
                    player.devgui_spawn_active = 1;
                    player thread devgui_spawn_think();
                } else {
                    player notify(#"devgui_spawn_think");
                    player.devgui_spawn_active = 0;
                    player setactionslot(3, "<dev string:x1a7>");
                }
                setdvar(#"scr_devgui_spawn", "<dev string:x30>");
            } else if (getdvarstring(#"scr_player_ammo") != "<dev string:x30>") {
                players = getplayers();
                if (!isdefined(level.devgui_unlimited_ammo)) {
                    level.devgui_unlimited_ammo = 1;
                } else {
                    level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
                }
                if (level.devgui_unlimited_ammo) {
                    iprintln("<dev string:x1af>");
                } else {
                    iprintln("<dev string:x1d4>");
                }
                for (i = 0; i < players.size; i++) {
                    if (level.devgui_unlimited_ammo) {
                        players[i] thread devgui_unlimited_ammo();
                        continue;
                    }
                    players[i] notify(#"devgui_unlimited_ammo");
                }
                setdvar(#"scr_player_ammo", "<dev string:x30>");
            } else if (getdvarstring(#"scr_player_momentum") != "<dev string:x30>") {
                if (!isdefined(level.devgui_unlimited_momentum)) {
                    level.devgui_unlimited_momentum = 1;
                } else {
                    level.devgui_unlimited_momentum = !level.devgui_unlimited_momentum;
                }
                if (level.devgui_unlimited_momentum) {
                    iprintln("<dev string:x1fc>");
                    level thread devgui_unlimited_momentum();
                } else {
                    iprintln("<dev string:x225>");
                    level notify(#"devgui_unlimited_momentum");
                }
                setdvar(#"scr_player_momentum", "<dev string:x30>");
            } else if (getdvarstring(#"scr_give_player_score") != "<dev string:x30>") {
                level thread devgui_increase_momentum(getdvarint(#"scr_give_player_score", 0));
                setdvar(#"scr_give_player_score", "<dev string:x30>");
            } else if (getdvarstring(#"scr_player_zero_ammo") != "<dev string:x30>") {
                players = getplayers();
                for (i = 0; i < players.size; i++) {
                    player = players[i];
                    weapons = player getweaponslist();
                    arrayremovevalue(weapons, level.weaponbasemelee);
                    for (j = 0; j < weapons.size; j++) {
                        if (weapons[j] == level.weaponnone) {
                            continue;
                        }
                        player setweaponammostock(weapons[j], 0);
                        player setweaponammoclip(weapons[j], 0);
                    }
                }
                setdvar(#"scr_player_zero_ammo", "<dev string:x30>");
            } else if (getdvarstring(#"scr_emp_jammed") != "<dev string:x30>") {
                players = getplayers();
                for (i = 0; i < players.size; i++) {
                    player = players[i];
                    player setempjammed(getdvarint(#"scr_emp_jammed", 0));
                }
                setdvar(#"scr_emp_jammed", "<dev string:x30>");
            } else if (getdvarstring(#"scr_round_pause") != "<dev string:x30>") {
                if (!level.timerstopped) {
                    iprintln("<dev string:x251>");
                    globallogic_utils::pausetimer();
                } else {
                    iprintln("<dev string:x265>");
                    globallogic_utils::resumetimer();
                }
                setdvar(#"scr_round_pause", "<dev string:x30>");
            } else if (getdvarstring(#"scr_round_end") != "<dev string:x30>") {
                level globallogic::forceend();
                setdvar(#"scr_round_end", "<dev string:x30>");
            } else if (getdvarstring(#"scr_show_hq_spawns") != "<dev string:x30>") {
                if (!isdefined(level.devgui_show_hq)) {
                    level.devgui_show_hq = 0;
                }
                if (level.gametype == "<dev string:x27a>" && isdefined(level.radios)) {
                    if (!level.devgui_show_hq) {
                        for (i = 0; i < level.radios.size; i++) {
                            color = (1, 0, 0);
                            level showonespawnpoint(level.radios[i], color, "<dev string:x27f>", 32, "<dev string:x28e>");
                        }
                    } else {
                        level notify(#"hide_hq_points");
                    }
                    level.devgui_show_hq = !level.devgui_show_hq;
                }
                setdvar(#"scr_show_hq_spawns", "<dev string:x30>");
            }
            if (getdvarint(#"r_streamdumpdistance", 0) == 3) {
                if (!isdefined(level.streamdumpteamindex)) {
                    level.streamdumpteamindex = 0;
                } else {
                    level.streamdumpteamindex++;
                }
                numpoints = 0;
                if (level.streamdumpteamindex < level.teams.size) {
                    teamname = getarraykeys(level.teams)[level.streamdumpteamindex];
                    if (isdefined(level.spawn_start[teamname])) {
                        numpoints = level.spawn_start[teamname].size;
                    }
                }
                if (numpoints == 0) {
                    setdvar(#"r_streamdumpdistance", 0);
                    level.streamdumpteamindex = -1;
                } else {
                    averageorigin = (0, 0, 0);
                    averageangles = (0, 0, 0);
                    foreach (spawnpoint in level.spawn_start[teamname]) {
                        averageorigin += spawnpoint.origin / numpoints;
                        averageangles += spawnpoint.angles / numpoints;
                    }
                    level.players[0] setplayerangles(averageangles);
                    level.players[0] setorigin(averageorigin);
                    waitframe(1);
                    setdvar(#"r_streamdumpdistance", 2);
                }
            }
        }
        if (getdvarstring(#"scr_giveperk") == "<dev string:x297>") {
            players = getplayers();
            iprintln("<dev string:x299>");
            for (i = 0; i < players.size; i++) {
                players[i] clearperks();
            }
            setdvar(#"scr_giveperk", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_giveperk") != "<dev string:x30>") {
            perk = getdvarstring(#"scr_giveperk");
            specialties = strtok(perk, "<dev string:x2bb>");
            players = getplayers();
            iprintln("<dev string:x2bd>" + perk + "<dev string:x2d8>");
            foreach (player in players) {
                foreach (specialty in specialties) {
                    player setperk(specialty);
                    if (!isdefined(player.extraperks)) {
                        player.extraperks = [];
                    }
                    player.extraperks[specialty] = 1;
                }
            }
            setdvar(#"scr_giveperk", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_toggleperk") != "<dev string:x30>") {
            perk = getdvarstring(#"scr_toggleperk");
            specialties = strtok(perk, "<dev string:x2bb>");
            players = getplayers();
            iprintln("<dev string:x2da>" + perk + "<dev string:x2d8>");
            foreach (player in players) {
                foreach (specialty in specialties) {
                    if (!isdefined(player.extraperks)) {
                        player.extraperks = [];
                    }
                    if (player hasperk(specialty)) {
                        player unsetperk(specialty);
                        player.extraperks[specialty] = 0;
                        continue;
                    }
                    player setperk(specialty);
                    player.extraperks[specialty] = 1;
                }
            }
            setdvar(#"scr_toggleperk", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_forceevent") != "<dev string:x30>") {
            event = getdvarstring(#"scr_forceevent");
            player = util::gethostplayer();
            forward = anglestoforward(player.angles);
            right = anglestoright(player.angles);
            if (event == "<dev string:x2f7>") {
                player dodamage(1, player.origin + forward);
            } else if (event == "<dev string:x301>") {
                player dodamage(1, player.origin - forward);
            } else if (event == "<dev string:x30a>") {
                player dodamage(1, player.origin - right);
            } else if (event == "<dev string:x313>") {
                player dodamage(1, player.origin + right);
            }
            setdvar(#"scr_forceevent", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_takeperk") != "<dev string:x30>") {
            perk = getdvarstring(#"scr_takeperk");
            for (i = 0; i < level.players.size; i++) {
                level.players[i] unsetperk(perk);
                level.players[i].extraperks[perk] = undefined;
            }
            setdvar(#"scr_takeperk", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_x_kills_y") != "<dev string:x30>") {
            nametokens = strtok(getdvarstring(#"scr_x_kills_y"), "<dev string:xe3>");
            if (nametokens.size > 1) {
                thread xkillsy(nametokens[0], nametokens[1]);
            }
            setdvar(#"scr_x_kills_y", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_entdebug") != "<dev string:x30>") {
            ents = getentarray();
            level.entarray = [];
            level.entcounts = [];
            level.entgroups = [];
            for (index = 0; index < ents.size; index++) {
                classname = ents[index].classname;
                if (!issubstr(classname, "<dev string:x31d>")) {
                    curent = ents[index];
                    level.entarray[level.entarray.size] = curent;
                    if (!isdefined(level.entcounts[classname])) {
                        level.entcounts[classname] = 0;
                    }
                    level.entcounts[classname]++;
                    if (!isdefined(level.entgroups[classname])) {
                        level.entgroups[classname] = [];
                    }
                    level.entgroups[classname][level.entgroups[classname].size] = curent;
                }
            }
        }
        potm::debugupdate();
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x3c243142, Offset: 0x2d08
    // Size: 0x1b6
    function devgui_spawn_think() {
        self notify(#"devgui_spawn_think");
        self endon(#"devgui_spawn_think");
        self endon(#"disconnect");
        dpad_left = 0;
        dpad_right = 0;
        for (;;) {
            self setactionslot(3, "<dev string:x30>");
            self setactionslot(4, "<dev string:x30>");
            if (!dpad_left && self buttonpressed("<dev string:x324>")) {
                setdvar(#"scr_playerwarp", "<dev string:x159>");
                dpad_left = 1;
            } else if (!self buttonpressed("<dev string:x324>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<dev string:x32e>")) {
                setdvar(#"scr_playerwarp", "<dev string:x14e>");
                dpad_right = 1;
            } else if (!self buttonpressed("<dev string:x32e>")) {
                dpad_right = 0;
            }
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x73a8f9a5, Offset: 0x2ec8
    // Size: 0x152
    function devgui_unlimited_ammo() {
        self notify(#"devgui_unlimited_ammo");
        self endon(#"devgui_unlimited_ammo");
        self endon(#"disconnect");
        for (;;) {
            wait 1;
            primary_weapons = self getweaponslistprimaries();
            offhand_weapons_and_alts = array::exclude(self getweaponslist(1), primary_weapons);
            weapons = arraycombine(primary_weapons, offhand_weapons_and_alts, 0, 0);
            arrayremovevalue(weapons, level.weaponbasemelee);
            for (i = 0; i < weapons.size; i++) {
                weapon = weapons[i];
                if (weapon == level.weaponnone) {
                    continue;
                }
                self givemaxammo(weapon);
            }
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x3d27fbc6, Offset: 0x3028
    // Size: 0x11c
    function devgui_unlimited_momentum() {
        level notify(#"devgui_unlimited_momentum");
        level endon(#"devgui_unlimited_momentum");
        for (;;) {
            wait 1;
            players = getplayers();
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                if (!isalive(player)) {
                    continue;
                }
                if (player.sessionstate != "<dev string:x339>") {
                    continue;
                }
                globallogic_score::_setplayermomentum(player, 5000);
            }
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x19241e9d, Offset: 0x3150
    // Size: 0x108
    function devgui_increase_momentum(score) {
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player)) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            if (player.sessionstate != "<dev string:x339>") {
                continue;
            }
            player globallogic_score::giveplayermomentumnotification(score, #"testplayerscorefortan", "<dev string:x341>", 0);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x42b1ee17, Offset: 0x3260
    // Size: 0x320
    function devgui_health_debug() {
        self notify(#"devgui_health_debug");
        self endon(#"devgui_health_debug");
        self endon(#"disconnect");
        x = 80;
        y = 40;
        self.debug_health_bar = newdebughudelem(self);
        self.debug_health_bar.x = x + 80;
        self.debug_health_bar.y = y + 2;
        self.debug_health_bar.alignx = "<dev string:x34e>";
        self.debug_health_bar.aligny = "<dev string:x353>";
        self.debug_health_bar.horzalign = "<dev string:x357>";
        self.debug_health_bar.vertalign = "<dev string:x357>";
        self.debug_health_bar.alpha = 1;
        self.debug_health_bar.foreground = 1;
        self.debug_health_bar setshader(#"black", 1, 8);
        self.debug_health_text = newdebughudelem(self);
        self.debug_health_text.x = x + 80;
        self.debug_health_text.y = y;
        self.debug_health_text.alignx = "<dev string:x34e>";
        self.debug_health_text.aligny = "<dev string:x353>";
        self.debug_health_text.horzalign = "<dev string:x357>";
        self.debug_health_text.vertalign = "<dev string:x357>";
        self.debug_health_text.alpha = 1;
        self.debug_health_text.fontscale = 1;
        self.debug_health_text.foreground = 1;
        if (!isdefined(self.maxhealth) || self.maxhealth <= 0) {
            self.maxhealth = 100;
        }
        for (;;) {
            waitframe(1);
            width = self.health / self.maxhealth * 300;
            width = int(max(width, 1));
            self.debug_health_bar setshader(#"black", width, 8);
            self.debug_health_text setvalue(self.health);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xa1e1b474, Offset: 0x3588
    // Size: 0xbe
    function giveextraperks() {
        if (!isdefined(self.extraperks)) {
            return;
        }
        perks = getarraykeys(self.extraperks);
        for (i = 0; i < perks.size; i++) {
            println("<dev string:x362>" + self.name + "<dev string:x36d>" + perks[i] + "<dev string:x378>");
            self setperk(perks[i]);
        }
    }

    // Namespace dev/dev
    // Params 2, eflags: 0x0
    // Checksum 0xd461f734, Offset: 0x3650
    // Size: 0x144
    function xkillsy(attackername, victimname) {
        attacker = undefined;
        victim = undefined;
        for (index = 0; index < level.players.size; index++) {
            if (level.players[index].name == attackername) {
                attacker = level.players[index];
                continue;
            }
            if (level.players[index].name == victimname) {
                victim = level.players[index];
            }
        }
        if (!isalive(attacker) || !isalive(victim)) {
            return;
        }
        victim thread [[ level.callbackplayerdamage ]](attacker, attacker, 1000, 0, "<dev string:x386>", level.weaponnone, (0, 0, 0), (0, 0, 0), "<dev string:x31>", 0, 0);
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xc4b377b2, Offset: 0x37a0
    // Size: 0x24
    function testscriptruntimeerrorassert() {
        wait 1;
        assert(0);
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xdabcfd47, Offset: 0x37d0
    // Size: 0x44
    function testscriptruntimeerror2() {
        myundefined = "<dev string:x397>";
        if (myundefined == 1) {
            println("<dev string:x39c>");
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x401a941b, Offset: 0x3820
    // Size: 0x1c
    function testscriptruntimeerror1() {
        testscriptruntimeerror2();
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xa2c45597, Offset: 0x3848
    // Size: 0xdc
    function testscriptruntimeerror() {
        wait 5;
        for (;;) {
            if (getdvarstring(#"scr_testscriptruntimeerror") != "<dev string:x31>") {
                break;
            }
            wait 1;
        }
        myerror = getdvarstring(#"scr_testscriptruntimeerror");
        setdvar(#"scr_testscriptruntimeerror", "<dev string:x31>");
        if (myerror == "<dev string:x3c2>") {
            testscriptruntimeerrorassert();
        } else {
            testscriptruntimeerror1();
        }
        thread testscriptruntimeerror();
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x48d6df7b, Offset: 0x3930
    // Size: 0x104
    function testdvars() {
        wait 5;
        for (;;) {
            if (getdvarstring(#"scr_testdvar") != "<dev string:x30>") {
                break;
            }
            wait 1;
        }
        tokens = strtok(getdvarstring(#"scr_testdvar"), "<dev string:xe3>");
        dvarname = tokens[0];
        dvarvalue = tokens[1];
        setdvar(dvarname, dvarvalue);
        setdvar(#"scr_testdvar", "<dev string:x30>");
        thread testdvars();
    }

    // Namespace dev/dev
    // Params 5, eflags: 0x0
    // Checksum 0x3d5e3b6, Offset: 0x3a40
    // Size: 0x50e
    function showonespawnpoint(spawn_point, color, notification, height, print) {
        if (!isdefined(height) || height <= 0) {
            height = util::get_player_height();
        }
        if (!isdefined(print)) {
            print = spawn_point.classname;
        }
        center = spawn_point.origin;
        forward = anglestoforward(spawn_point.angles);
        right = anglestoright(spawn_point.angles);
        forward = vectorscale(forward, 16);
        right = vectorscale(right, 16);
        a = center + forward - right;
        b = center + forward + right;
        c = center - forward + right;
        d = center - forward - right;
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(b, c, color, 0, notification);
        thread lineuntilnotified(c, d, color, 0, notification);
        thread lineuntilnotified(d, a, color, 0, notification);
        thread lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
        a += (0, 0, height);
        b += (0, 0, height);
        c += (0, 0, height);
        d += (0, 0, height);
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(b, c, color, 0, notification);
        thread lineuntilnotified(c, d, color, 0, notification);
        thread lineuntilnotified(d, a, color, 0, notification);
        center += (0, 0, height / 2);
        arrow_forward = anglestoforward(spawn_point.angles);
        arrowhead_forward = anglestoforward(spawn_point.angles);
        arrowhead_right = anglestoright(spawn_point.angles);
        arrow_forward = vectorscale(arrow_forward, 32);
        arrowhead_forward = vectorscale(arrowhead_forward, 24);
        arrowhead_right = vectorscale(arrowhead_right, 8);
        a = center + arrow_forward;
        b = center + arrowhead_forward - arrowhead_right;
        c = center + arrowhead_forward + arrowhead_right;
        thread lineuntilnotified(center, a, color, 0, notification);
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(a, c, color, 0, notification);
        thread print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
        return;
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x9f5e695c, Offset: 0x3f58
    // Size: 0xe0
    function showspawnpoints() {
        if (isdefined(level.spawnpoints)) {
            color = (1, 1, 1);
            for (spawn_point_index = 0; spawn_point_index < level.spawnpoints.size; spawn_point_index++) {
                showonespawnpoint(level.spawnpoints[spawn_point_index], color, "<dev string:x3c9>");
            }
        }
        for (i = 0; i < level.dem_spawns.size; i++) {
            color = (0, 1, 0);
            showonespawnpoint(level.dem_spawns[i], color, "<dev string:x3c9>");
        }
        return;
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xbdc607fe, Offset: 0x4040
    // Size: 0x22
    function hidespawnpoints() {
        level notify(#"hide_spawnpoints");
        return;
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x3caabaa7, Offset: 0x4070
    // Size: 0x22e
    function showstartspawnpoints() {
        if (!level.teambased) {
            return;
        }
        if (!isdefined(level.spawn_start)) {
            return;
        }
        team_colors = [];
        team_colors[#"axis"] = (1, 0, 1);
        team_colors[#"allies"] = (0, 1, 1);
        team_colors[#"team3"] = (1, 1, 0);
        team_colors[#"team4"] = (0, 1, 0);
        team_colors[#"team5"] = (0, 0, 1);
        team_colors[#"team6"] = (1, 0.7, 0);
        team_colors[#"team7"] = (0.25, 0.25, 1);
        team_colors[#"team8"] = (0.88, 0, 1);
        foreach (team, _ in level.teams) {
            color = team_colors[team];
            foreach (spawnpoint in level.spawn_start[team]) {
                showonespawnpoint(spawnpoint, color, "<dev string:x3da>");
            }
        }
        return;
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x1dd8ce49, Offset: 0x42a8
    // Size: 0x22
    function hidestartspawnpoints() {
        level notify(#"hide_startspawnpoints");
        return;
    }

    // Namespace dev/dev
    // Params 6, eflags: 0x0
    // Checksum 0xbe54184e, Offset: 0x42d8
    // Size: 0x76
    function print3duntilnotified(origin, text, color, alpha, scale, notification) {
        level endon(notification);
        for (;;) {
            print3d(origin, text, color, alpha, scale);
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 5, eflags: 0x0
    // Checksum 0x81e91be2, Offset: 0x4358
    // Size: 0x66
    function lineuntilnotified(start, end, color, depthtest, notification) {
        level endon(notification);
        for (;;) {
            line(start, end, color, depthtest);
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x68e00cec, Offset: 0x43c8
    // Size: 0x2a
    function dvar_turned_on(val) {
        if (val <= 0) {
            return 0;
        }
        return 1;
    }

    // Namespace dev/dev
    // Params 5, eflags: 0x0
    // Checksum 0x41fed996, Offset: 0x4400
    // Size: 0xce
    function new_hud(hud_name, msg, x, y, scale) {
        if (!isdefined(level.hud_array)) {
            level.hud_array = [];
        }
        if (!isdefined(level.hud_array[hud_name])) {
            level.hud_array[hud_name] = [];
        }
        hud = set_hudelem(msg, x, y, scale);
        level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
        return hud;
    }

    // Namespace dev/dev
    // Params 7, eflags: 0x0
    // Checksum 0x91d24a46, Offset: 0x44d8
    // Size: 0x16a
    function set_hudelem(text, x, y, scale, alpha, sort, debug_hudelem) {
        /#
            if (!isdefined(alpha)) {
                alpha = 1;
            }
            if (!isdefined(scale)) {
                scale = 1;
            }
            if (!isdefined(sort)) {
                sort = 20;
            }
            hud = newdebughudelem();
            hud.debug_hudelem = 1;
            hud.location = 0;
            hud.alignx = "<dev string:x34e>";
            hud.aligny = "<dev string:x3f0>";
            hud.foreground = 1;
            hud.fontscale = scale;
            hud.sort = sort;
            hud.alpha = alpha;
            hud.x = x;
            hud.y = y;
            hud.og_scale = scale;
            if (isdefined(text)) {
                hud settext(text);
            }
            return hud;
        #/
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xc6240f6a, Offset: 0x4650
    // Size: 0x144
    function print_weapon_name() {
        self notify(#"print_weapon_name");
        self endon(#"print_weapon_name");
        wait 0.2;
        if (self isswitchingweapons()) {
            waitresult = self waittill(#"weapon_change_complete");
            fail_safe = 0;
            while (waitresult.weapon == level.weaponnone) {
                waitresult = self waittill(#"weapon_change_complete");
                waitframe(1);
                fail_safe++;
                if (fail_safe > 120) {
                    break;
                }
            }
        } else {
            weapon = self getcurrentweapon();
        }
        printweaponname = getdvarint(#"scr_print_weapon_name", 1);
        if (printweaponname) {
            iprintlnbold(weapon.name);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xa5b9560a, Offset: 0x47a0
    // Size: 0x1d6
    function set_equipment_list() {
        if (isdefined(level.dev_equipment)) {
            return;
        }
        level.dev_equipment = [];
        level.dev_equipment[1] = getweapon(#"acoustic_sensor");
        level.dev_equipment[2] = getweapon(#"camera_spike");
        level.dev_equipment[3] = getweapon(#"claymore");
        level.dev_equipment[4] = getweapon(#"satchel_charge");
        level.dev_equipment[5] = getweapon(#"scrambler");
        level.dev_equipment[6] = getweapon(#"tactical_insertion");
        level.dev_equipment[7] = getweapon(#"bouncingbetty");
        level.dev_equipment[8] = getweapon(#"trophy_system");
        level.dev_equipment[9] = getweapon(#"pda_hack");
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x2234d630, Offset: 0x4980
    // Size: 0x206
    function set_grenade_list() {
        if (isdefined(level.dev_grenade)) {
            return;
        }
        level.dev_grenade = [];
        level.dev_grenade[1] = getweapon(#"frag_grenade");
        level.dev_grenade[2] = getweapon(#"sticky_grenade");
        level.dev_grenade[3] = getweapon(#"hatchet");
        level.dev_grenade[4] = getweapon(#"willy_pete");
        level.dev_grenade[5] = getweapon(#"proximity_grenade");
        level.dev_grenade[6] = getweapon(#"flash_grenade");
        level.dev_grenade[7] = getweapon(#"concussion_grenade");
        level.dev_grenade[8] = getweapon(#"nightingale");
        level.dev_grenade[9] = getweapon(#"emp_grenade");
        level.dev_grenade[10] = getweapon(#"sensor_grenade");
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x48f8e968, Offset: 0x4b90
    // Size: 0xb6
    function take_all_grenades_and_equipment(player) {
        for (i = 0; i < level.dev_equipment.size; i++) {
            player takeweapon(level.dev_equipment[i + 1]);
        }
        for (i = 0; i < level.dev_grenade.size; i++) {
            player takeweapon(level.dev_grenade[i + 1]);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xc6106f94, Offset: 0x4c50
    // Size: 0x140
    function equipment_dev_gui() {
        set_equipment_list();
        set_grenade_list();
        setdvar(#"scr_give_equipment", "<dev string:x30>");
        while (true) {
            wait 0.5;
            devgui_int = getdvarint(#"scr_give_equipment", 0);
            if (devgui_int != 0) {
                for (i = 0; i < level.players.size; i++) {
                    take_all_grenades_and_equipment(level.players[i]);
                    level.players[i] giveweapon(level.dev_equipment[devgui_int]);
                }
                setdvar(#"scr_give_equipment", 0);
            }
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xa81d4cf, Offset: 0x4d98
    // Size: 0x140
    function grenade_dev_gui() {
        set_equipment_list();
        set_grenade_list();
        setdvar(#"scr_give_grenade", "<dev string:x30>");
        while (true) {
            wait 0.5;
            devgui_int = getdvarint(#"scr_give_grenade", 0);
            if (devgui_int != 0) {
                for (i = 0; i < level.players.size; i++) {
                    take_all_grenades_and_equipment(level.players[i]);
                    level.players[i] giveweapon(level.dev_grenade[devgui_int]);
                }
                setdvar(#"scr_give_grenade", 0);
            }
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x1eaf3fa5, Offset: 0x4ee0
    // Size: 0x46a
    function devstraferunpathdebugdraw() {
        white = (1, 1, 1);
        red = (1, 0, 0);
        green = (0, 1, 0);
        blue = (0, 0, 1);
        violet = (0.4, 0, 0.6);
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = (0, 0, -50);
        endonmsg = "<dev string:x3f7>";
        while (true) {
            if (getdvarint(#"scr_devstraferunpathdebugdraw", 0) > 0) {
                nodes = [];
                end = 0;
                node = getvehiclenode("<dev string:x415>", "<dev string:xfa>");
                if (!isdefined(node)) {
                    println("<dev string:x423>");
                    setdvar(#"scr_devstraferunpathdebugdraw", 0);
                    continue;
                }
                while (isdefined(node.target)) {
                    new_node = getvehiclenode(node.target, "<dev string:xfa>");
                    foreach (n in nodes) {
                        if (n == new_node) {
                            end = 1;
                        }
                    }
                    textscale = 30;
                    if (drawtime == maxdrawtime) {
                        node thread drawpathsegment(new_node, violet, violet, 1, textscale, origintextoffset, drawtime, endonmsg);
                    }
                    if (isdefined(node.script_noteworthy)) {
                        textscale = 10;
                        switch (node.script_noteworthy) {
                        case #"strafe_start":
                            textcolor = green;
                            textalpha = 1;
                            break;
                        case #"strafe_stop":
                            textcolor = red;
                            textalpha = 1;
                            break;
                        case #"strafe_leave":
                            textcolor = white;
                            textalpha = 1;
                            break;
                        }
                        switch (node.script_noteworthy) {
                        case #"strafe_stop":
                        case #"strafe_leave":
                        case #"strafe_start":
                            sides = 10;
                            radius = 100;
                            if (drawtime == maxdrawtime) {
                                sphere(node.origin, radius, textcolor, textalpha, 1, sides, drawtime * 1000);
                            }
                            node draworiginlines();
                            node drawnoteworthytext(textcolor, textalpha, textscale);
                            break;
                        }
                    }
                    if (end) {
                        break;
                    }
                    nodes[nodes.size] = new_node;
                    node = new_node;
                }
                drawtime -= 0.05;
                if (drawtime < 0) {
                    drawtime = maxdrawtime;
                }
                waitframe(1);
                continue;
            }
            wait 1;
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xfcfa1e21, Offset: 0x5358
    // Size: 0x3c4
    function devhelipathdebugdraw() {
        white = (1, 1, 1);
        red = (1, 0, 0);
        green = (0, 1, 0);
        blue = (0, 0, 1);
        textcolor = white;
        textalpha = 1;
        textscale = 1;
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = (0, 0, -50);
        endonmsg = "<dev string:x43c>";
        while (true) {
            if (getdvarint(#"scr_devhelipathsdebugdraw", 0) > 0) {
                script_origins = getentarray("<dev string:x456>", "<dev string:x9a>");
                foreach (ent in script_origins) {
                    if (isdefined(ent.targetname)) {
                        switch (ent.targetname) {
                        case #"heli_start":
                            textcolor = blue;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        case #"heli_loop_start":
                            textcolor = green;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        case #"heli_attack_area":
                            textcolor = red;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        case #"heli_leave":
                            textcolor = white;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        }
                        switch (ent.targetname) {
                        case #"heli_leave":
                        case #"heli_attack_area":
                        case #"heli_start":
                        case #"heli_loop_start":
                            if (drawtime == maxdrawtime) {
                                ent thread drawpath(textcolor, white, textalpha, textscale, origintextoffset, drawtime, endonmsg);
                            }
                            ent draworiginlines();
                            ent drawtargetnametext(textcolor, textalpha, textscale);
                            ent draworigintext(textcolor, textalpha, textscale, origintextoffset);
                            break;
                        }
                    }
                }
                drawtime -= 0.05;
                if (drawtime < 0) {
                    drawtime = maxdrawtime;
                }
            }
            if (getdvarint(#"scr_devhelipathsdebugdraw", 0) == 0) {
                level notify(endonmsg);
                drawtime = maxdrawtime;
                wait 1;
            }
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x76561d7d, Offset: 0x5728
    // Size: 0xfc
    function draworiginlines() {
        red = (1, 0, 0);
        green = (0, 1, 0);
        blue = (0, 0, 1);
        line(self.origin, self.origin + anglestoforward(self.angles) * 10, red);
        line(self.origin, self.origin + anglestoright(self.angles) * 10, green);
        line(self.origin, self.origin + anglestoup(self.angles) * 10, blue);
    }

    // Namespace dev/dev
    // Params 4, eflags: 0x0
    // Checksum 0x5c57f119, Offset: 0x5830
    // Size: 0x6c
    function drawtargetnametext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
    }

    // Namespace dev/dev
    // Params 4, eflags: 0x0
    // Checksum 0x982312c8, Offset: 0x58a8
    // Size: 0x6c
    function drawnoteworthytext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.script_noteworthy, textcolor, textalpha, textscale);
    }

    // Namespace dev/dev
    // Params 4, eflags: 0x0
    // Checksum 0x4e14c20, Offset: 0x5920
    // Size: 0xbc
    function draworigintext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        originstring = "<dev string:x464>" + self.origin[0] + "<dev string:x466>" + self.origin[1] + "<dev string:x466>" + self.origin[2] + "<dev string:x469>";
        print3d(self.origin + textoffset, originstring, textcolor, textalpha, textscale);
    }

    // Namespace dev/dev
    // Params 4, eflags: 0x0
    // Checksum 0x95a78f5f, Offset: 0x59e8
    // Size: 0xd4
    function drawspeedacceltext(textcolor, textalpha, textscale, textoffset) {
        if (isdefined(self.script_airspeed)) {
            print3d(self.origin + (0, 0, textoffset[2] * 2), "<dev string:x46b>" + self.script_airspeed, textcolor, textalpha, textscale);
        }
        if (isdefined(self.script_accel)) {
            print3d(self.origin + (0, 0, textoffset[2] * 3), "<dev string:x47c>" + self.script_accel, textcolor, textalpha, textscale);
        }
    }

    // Namespace dev/dev
    // Params 7, eflags: 0x0
    // Checksum 0xe9e9ab7c, Offset: 0x5ac8
    // Size: 0x142
    function drawpath(linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
        level endon(endonmsg);
        ent = self;
        entfirsttarget = ent.targetname;
        while (isdefined(ent.target)) {
            enttarget = getent(ent.target, "<dev string:xfa>");
            ent thread drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg);
            if (ent.targetname == "<dev string:x48a>") {
                entfirsttarget = ent.target;
            } else if (ent.target == entfirsttarget) {
                break;
            }
            ent = enttarget;
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 8, eflags: 0x0
    // Checksum 0x9ab30c71, Offset: 0x5c18
    // Size: 0x116
    function drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
        level endon(endonmsg);
        while (drawtime > 0) {
            if (isdefined(self.targetname) && self.targetname == "<dev string:x415>") {
                print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
            }
            line(self.origin, enttarget.origin, linecolor);
            self drawspeedacceltext(textcolor, textalpha, textscale, textoffset);
            drawtime -= 0.05;
            waitframe(1);
        }
    }

#/
