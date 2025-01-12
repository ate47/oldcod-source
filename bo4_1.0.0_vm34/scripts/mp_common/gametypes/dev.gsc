#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\perks;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\supplydrop;
#using scripts\mp_common\devgui;
#using scripts\mp_common\gametypes\dev_class;
#using scripts\mp_common\gametypes\dev_spawn;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\util;

#namespace dev;

/#

    // Namespace dev/dev
    // Params 0, eflags: 0x2
    // Checksum 0xd457eda8, Offset: 0x130
    // Size: 0x4c
    function autoexec __init__system__() {
        system::register(#"dev", &__init__, undefined, #"spawning_shared");
    }

#/

// Namespace dev/dev
// Params 0, eflags: 0x0
// Checksum 0xf5dcf0dd, Offset: 0x188
// Size: 0x5e
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connected);
    /#
        level.devongetormakebot = &getormakebot;
    #/
}

// Namespace dev/dev
// Params 0, eflags: 0x0
// Checksum 0xd0468b71, Offset: 0x1f0
// Size: 0x3c0
function init() {
    /#
        if (getdvarstring(#"scr_show_hq_spawns") == "<dev string:x30>") {
            setdvar(#"scr_show_hq_spawns", "<dev string:x30>");
        }
        if (!isdefined(getdvar(#"scr_testscriptruntimeerror"))) {
            setdvar(#"scr_testscriptruntimeerror", "<dev string:x31>");
        }
        if (getdvarstring(#"hash_42bc2c660a3d2ecd") == "<dev string:x30>") {
            setdvar(#"hash_42bc2c660a3d2ecd", "<dev string:x36>");
        }
        thread testscriptruntimeerror();
        thread testdvars();
        thread addenemyheli();
        thread addtestcarepackage();
        thread devhelipathdebugdraw();
        thread devstraferunpathdebugdraw();
        thread dev_class::dev_cac_init();
        thread dev_spawn::function_446284cf();
        thread globallogic_score::setplayermomentumdebug();
        setdvar(#"scr_giveperk", "<dev string:x30>");
        setdvar(#"scr_forceevent", "<dev string:x30>");
        setdvar(#"scr_draw_triggers", 0);
        setdvar(#"scr_givegesture", "<dev string:x30>");
        thread engagement_distance_debug_toggle();
        thread equipment_dev_gui();
        thread grenade_dev_gui();
        setdvar(#"debug_dynamic_ai_spawning", 0);
        level.dem_spawns = [];
        if (level.gametype == "<dev string:x38>") {
            extra_spawns = [];
            extra_spawns[0] = "<dev string:x3c>";
            extra_spawns[1] = "<dev string:x54>";
            extra_spawns[2] = "<dev string:x6c>";
            extra_spawns[3] = "<dev string:x84>";
            for (i = 0; i < extra_spawns.size; i++) {
                points = getentarray(extra_spawns[i], "<dev string:x9c>");
                if (isdefined(points) && points.size > 0) {
                    level.dem_spawns = arraycombine(level.dem_spawns, points, 1, 0);
                }
            }
        }
        for (;;) {
            updatedevsettings();
            wait 0.5;
        }
    #/
}

// Namespace dev/dev
// Params 0, eflags: 0x0
// Checksum 0x50785d24, Offset: 0x5b8
// Size: 0x44
function on_player_connected() {
    /#
        if (isdefined(level.devgui_unlimited_ammo) && level.devgui_unlimited_ammo) {
            wait 1;
            self thread devgui_unlimited_ammo();
        }
    #/
}

/#

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x1230d605, Offset: 0x608
    // Size: 0x3e6
    function updatehardpoints() {
        keys = getarraykeys(level.killstreaks);
        for (i = 0; i < keys.size; i++) {
            dvar = level.killstreaks[keys[i]].devdvar;
            enemydvar = level.killstreaks[keys[i]].devenemydvar;
            host = util::gethostplayer();
            if (isdefined(dvar) && getdvarint(dvar, 0) == 1) {
                foreach (player in level.players) {
                    if (isdefined(level.usingmomentum) && level.usingmomentum && isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
                        player killstreaks::give(keys[i]);
                        continue;
                    }
                    if (isbot(player)) {
                        player.bot[#"killstreaks"] = [];
                        player.bot[#"killstreaks"][0] = killstreaks::get_menu_name(keys[i]);
                        killstreakweapon = killstreaks::get_killstreak_weapon(keys[i]);
                        player killstreaks::give_weapon(killstreakweapon, 1);
                        globallogic_score::_setplayermomentum(player, 2000);
                        continue;
                    }
                    player killstreaks::give(keys[i]);
                }
                setdvar(dvar, 0);
            }
            if (isdefined(enemydvar) && getdvarint(enemydvar, 0) == 1) {
                team = "<dev string:xa6>";
                player = util::gethostplayer();
                if (isdefined(player.team)) {
                    team = util::getotherteam(player.team);
                }
                ent = getormakebot(team);
                if (!isdefined(ent)) {
                    println("<dev string:xb1>");
                    continue;
                }
                wait 1;
                if (isbot(ent)) {
                    ent killstreaks::give(keys[i]);
                } else {
                    ent killstreaks::give(keys[i]);
                }
                setdvar(enemydvar, 0);
            }
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x6417cd67, Offset: 0x9f8
    // Size: 0x4c
    function warpalltohost(team) {
        host = util::gethostplayer();
        warpalltoplayer(team, host.name);
    }

    // Namespace dev/dev
    // Params 2, eflags: 0x0
    // Checksum 0x2bfab64a, Offset: 0xa50
    // Size: 0x3bc
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
                    if (strstartswith(team, "<dev string:xcb>") && target.team == players[i].team) {
                        continue;
                    }
                    if (strstartswith(team, "<dev string:xd4>") && target.team != players[i].team) {
                        continue;
                    }
                }
                goal = undefined;
                if (isdefined(spawn_origin)) {
                    players[i] setorigin(spawn_origin);
                    goal = spawn_origin;
                } else if (nodes.size > 0) {
                    node = array::random(nodes);
                    players[i] setorigin(node.origin);
                    goal = node;
                } else {
                    players[i] setorigin(origin);
                    goal = origin;
                }
                if (isdefined(goal) && isbot(players[i])) {
                    players[i] setgoal(goal, 1);
                }
            }
        }
        setdvar(#"scr_playerwarp", "<dev string:x30>");
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x8f793d16, Offset: 0xe18
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
                if ((location == "<dev string:xe0>" || location == "<dev string:x30>") && isdefined(level.default_start_location)) {
                    location = level.default_start_location;
                }
                match_string = level.scr_zm_ui_gametype + "<dev string:xe8>" + location;
                if (level.streamdumpteamindex < level.teams.size) {
                    structs = struct::get_array("<dev string:xea>", "<dev string:xf8>");
                    if (isdefined(structs)) {
                        foreach (struct in structs) {
                            if (isdefined(struct.script_string)) {
                                tokens = strtok(struct.script_string, "<dev string:x10a>");
                                foreach (token in tokens) {
                                    if (token == match_string) {
                                        spawnpoints[spawnpoints.size] = struct;
                                    }
                                }
                            }
                        }
                    }
                    if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
                        spawnpoints = struct::get_array("<dev string:x10c>", "<dev string:x121>");
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
                wait 5;
                setdvar(#"r_streamdumpdistance", 2);
            }
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x1b9bca50, Offset: 0x1240
    // Size: 0x265c
    function updatedevsettings() {
        player = util::gethostplayer();
        dev_spawn::function_cb52ecae();
        updateminimapsetting();
        if (level.players.size > 0) {
            updatehardpoints();
            playerwarp_string = getdvarstring(#"scr_playerwarp");
            if (playerwarp_string == "<dev string:x12c>") {
                warpalltohost();
            } else if (playerwarp_string == "<dev string:x131>") {
                warpalltohost(playerwarp_string);
            } else if (playerwarp_string == "<dev string:x13e>") {
                warpalltohost(playerwarp_string);
            } else if (strstartswith(playerwarp_string, "<dev string:xcb>")) {
                name = getsubstr(playerwarp_string, 8);
                warpalltoplayer(playerwarp_string, name);
            } else if (strstartswith(playerwarp_string, "<dev string:xd4>")) {
                name = getsubstr(playerwarp_string, 11);
                warpalltoplayer(playerwarp_string, name);
            } else if (strstartswith(playerwarp_string, "<dev string:x14e>")) {
                name = getsubstr(playerwarp_string, 4);
                warpalltoplayer(undefined, name);
            } else if (playerwarp_string == "<dev string:x153>") {
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
            } else if (playerwarp_string == "<dev string:x164>") {
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
            } else if (playerwarp_string == "<dev string:x175>") {
                players = getplayers();
                setdvar(#"scr_playerwarp", "<dev string:x30>");
                if (!isdefined(level.devgui_spawn_index)) {
                    level.devgui_spawn_index = 0;
                }
                spawns = isdefined(level.var_c88d2e0d) ? level.var_c88d2e0d : level.spawnpoints;
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
            } else if (playerwarp_string == "<dev string:x180>") {
                players = getplayers();
                setdvar(#"scr_playerwarp", "<dev string:x30>");
                if (!isdefined(level.devgui_spawn_index)) {
                    level.devgui_spawn_index = 0;
                }
                spawns = isdefined(level.var_c88d2e0d) ? level.var_c88d2e0d : level.spawnpoints;
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
                    iprintln("<dev string:x18b>");
                    iprintln("<dev string:x1ae>");
                    player.devgui_spawn_active = 1;
                    player thread devgui_spawn_think();
                } else {
                    player notify(#"devgui_spawn_think");
                    player.devgui_spawn_active = 0;
                    player setactionslot(3, "<dev string:x1ce>");
                }
                setdvar(#"scr_devgui_spawn", "<dev string:x30>");
            } else if (getdvarstring(#"hash_c9f8ff06a656024") != "<dev string:x30>") {
                player = util::gethostplayer();
                if (!isdefined(player.var_266f69ad)) {
                    player.var_266f69ad = 0;
                }
                if (!player.var_266f69ad) {
                    iprintln("<dev string:x18b>");
                    iprintln("<dev string:x1ae>");
                    player.var_266f69ad = 1;
                    player thread function_f320a3f1();
                } else {
                    player notify(#"hash_47f3d9a9e91670d1");
                    player.var_266f69ad = 0;
                    player setactionslot(3, "<dev string:x1ce>");
                }
                setdvar(#"hash_c9f8ff06a656024", "<dev string:x30>");
            } else if (getdvarstring(#"scr_player_ammo") != "<dev string:x30>") {
                players = getplayers();
                if (!isdefined(level.devgui_unlimited_ammo)) {
                    level.devgui_unlimited_ammo = 1;
                } else {
                    level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
                }
                if (level.devgui_unlimited_ammo) {
                    iprintln("<dev string:x1d6>");
                } else {
                    iprintln("<dev string:x1fb>");
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
                    iprintln("<dev string:x223>");
                    level thread devgui_unlimited_momentum();
                } else {
                    iprintln("<dev string:x24c>");
                    level notify(#"devgui_unlimited_momentum");
                }
                setdvar(#"scr_player_momentum", "<dev string:x30>");
            } else if (getdvarstring(#"scr_give_player_score") != "<dev string:x30>") {
                level thread devgui_increase_momentum(getdvarint(#"scr_give_player_score", 0));
                setdvar(#"scr_give_player_score", "<dev string:x30>");
            } else if (getdvarstring(#"hash_7d7add0fb8d419c8") != "<dev string:x30>") {
                level thread function_72b389c8();
                setdvar(#"hash_7d7add0fb8d419c8", "<dev string:x30>");
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
                    iprintln("<dev string:x278>");
                    globallogic_utils::pausetimer();
                } else {
                    iprintln("<dev string:x28c>");
                    globallogic_utils::resumetimer();
                }
                setdvar(#"scr_round_pause", "<dev string:x30>");
            } else if (getdvarstring(#"scr_round_end") != "<dev string:x30>") {
                level globallogic::forceend();
                setdvar(#"scr_round_end", "<dev string:x30>");
            } else if (getdvarint(#"scr_health_debug", 0)) {
                players = getplayers();
                host = util::gethostplayer();
                if (!isdefined(host.devgui_health_debug)) {
                    host.devgui_health_debug = 0;
                }
                if (host.devgui_health_debug) {
                    host.devgui_health_debug = 0;
                    for (i = 0; i < players.size; i++) {
                        players[i] notify(#"devgui_health_debug");
                        if (isdefined(players[i].debug_health_bar)) {
                            players[i].debug_health_bar destroy();
                            players[i].debug_health_text destroy();
                            players[i].debug_health_bar = undefined;
                            players[i].debug_health_text = undefined;
                        }
                    }
                } else {
                    host.devgui_health_debug = 1;
                    for (i = 0; i < players.size; i++) {
                        players[i] thread devgui_health_debug();
                    }
                }
                setdvar(#"scr_health_debug", 0);
            } else if (getdvarstring(#"scr_show_hq_spawns") != "<dev string:x30>") {
                if (!isdefined(level.devgui_show_hq)) {
                    level.devgui_show_hq = 0;
                }
                if (level.gametype == "<dev string:x2a1>" && isdefined(level.radios)) {
                    if (!level.devgui_show_hq) {
                        for (i = 0; i < level.radios.size; i++) {
                            color = (1, 0, 0);
                            level dev_spawn::showonespawnpoint(level.radios[i], color, "<dev string:x2a6>", 32, "<dev string:x2b5>");
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
                    wait 5;
                    setdvar(#"r_streamdumpdistance", 2);
                }
            }
        }
        if (getdvarstring(#"scr_giveperk") == "<dev string:x36>") {
            players = getplayers();
            iprintln("<dev string:x2be>");
            for (i = 0; i < players.size; i++) {
                players[i] clearperks();
                players[i].extraperks = undefined;
            }
            setdvar(#"scr_giveperk", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_giveperk") != "<dev string:x30>") {
            perk = getdvarstring(#"scr_giveperk");
            specialties = strtok(perk, "<dev string:x2e0>");
            players = getplayers();
            iprintln("<dev string:x2e2>" + perk + "<dev string:x2fd>");
            for (i = 0; i < players.size; i++) {
                for (j = 0; j < specialties.size; j++) {
                    players[i] perks::perk_setperk(specialties[j]);
                    players[i].extraperks[specialties[j]] = 1;
                }
            }
            setdvar(#"scr_giveperk", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_giveskill") == "<dev string:x36>") {
            players = getplayers();
            iprintln("<dev string:x2ff>");
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                player function_edf4fd1d();
                player loadout::function_d92e1a6d(player.team, player.curclass);
            }
            setdvar(#"scr_giveskill", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_giveskill") != "<dev string:x30>") {
            talentname = getdvarstring(#"scr_giveskill");
            var_ae143242 = hash(talentname);
            players = getplayers();
            iprintln("<dev string:x322>" + talentname + "<dev string:x2fd>");
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                player function_748988bc(var_ae143242);
                player loadout::function_d92e1a6d(player.team, player.curclass);
            }
            setdvar(#"scr_giveskill", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_givetalent") == "<dev string:x36>") {
            players = getplayers();
            iprintln("<dev string:x33e>");
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                player function_edf4fd1d();
                player loadout::function_d92e1a6d(player.team, player.curclass);
            }
            setdvar(#"scr_givetalent", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_givetalent") != "<dev string:x30>") {
            talentname = getdvarstring(#"scr_givetalent");
            var_ae143242 = hash(talentname);
            players = getplayers();
            iprintln("<dev string:x361>" + talentname + "<dev string:x2fd>");
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                player function_748988bc(var_ae143242);
                player loadout::function_d92e1a6d(player.team, player.curclass);
            }
            setdvar(#"scr_givetalent", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_forcegrenade") != "<dev string:x30>") {
            force_grenade_throw(getweapon(getdvarstring(#"scr_forcegrenade")));
            setdvar(#"scr_forcegrenade", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_forceevent") != "<dev string:x30>") {
            event = getdvarstring(#"scr_forceevent");
            player = util::gethostplayer();
            forward = anglestoforward(player.angles);
            right = anglestoright(player.angles);
            if (event == "<dev string:x37e>") {
                player dodamage(1, player.origin + forward);
            } else if (event == "<dev string:x388>") {
                player dodamage(1, player.origin - forward);
            } else if (event == "<dev string:x391>") {
                player dodamage(1, player.origin - right);
            } else if (event == "<dev string:x39a>") {
                player dodamage(1, player.origin + right);
            }
            setdvar(#"scr_forceevent", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_takeperk") != "<dev string:x30>") {
            perk = getdvarstring(#"scr_takeperk");
            for (i = 0; i < level.players.size; i++) {
                level.players[i] perks::perk_unsetperk(perk);
                level.players[i].extraperks[perk] = undefined;
            }
            setdvar(#"scr_takeperk", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_x_kills_y") != "<dev string:x30>") {
            nametokens = strtok(getdvarstring(#"scr_x_kills_y"), "<dev string:x10a>");
            if (nametokens.size > 1) {
                thread xkillsy(nametokens[0], nametokens[1]);
            }
            setdvar(#"scr_x_kills_y", "<dev string:x30>");
        }
        if (getdvarstring(#"scr_usedogs") != "<dev string:x30>") {
            ownername = getdvarstring(#"scr_usedogs");
            setdvar(#"scr_usedogs", "<dev string:x30>");
            owner = undefined;
            for (index = 0; index < level.players.size; index++) {
                if (level.players[index].name == ownername) {
                    owner = level.players[index];
                }
            }
            if (isdefined(owner)) {
                owner killstreaks::trigger_killstreak("<dev string:x3a4>");
            }
        }
        if (getdvarstring(#"scr_entdebug") != "<dev string:x30>") {
            ents = getentarray();
            level.entarray = [];
            level.entcounts = [];
            level.entgroups = [];
            for (index = 0; index < ents.size; index++) {
                classname = ents[index].classname;
                if (!issubstr(classname, "<dev string:x3a9>")) {
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
        if (getdvarint(#"debug_dynamic_ai_spawning", 0) && !isdefined(level.larry)) {
            thread larry_thread();
        } else if (!getdvarint(#"debug_dynamic_ai_spawning", 0)) {
            level notify(#"kill_larry");
        }
        if (getdvarint(#"scr_force_finalkillcam", 0) == 1) {
            level thread killcam::do_final_killcam();
            level thread waitthennotifyfinalkillcam();
        }
        if (getdvarint(#"scr_force_roundkillcam", 0) == 1) {
            level thread killcam::do_final_killcam();
            level thread waitthennotifyroundkillcam();
        }
        potm::debugupdate();
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xb797e4aa, Offset: 0x38a8
    // Size: 0x44
    function waitthennotifyroundkillcam() {
        waitframe(1);
        level notify(#"play_final_killcam");
        setdvar(#"scr_force_roundkillcam", 0);
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xb946ac7b, Offset: 0x38f8
    // Size: 0x4c
    function waitthennotifyfinalkillcam() {
        waitframe(1);
        level notify(#"play_final_killcam");
        waitframe(1);
        setdvar(#"scr_force_finalkillcam", 0);
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xad018a61, Offset: 0x3950
    // Size: 0x836
    function function_f320a3f1() {
        self notify("<invalid>");
        self endon("<invalid>");
        self endon(#"disconnect");
        dpad_left = 0;
        dpad_right = 0;
        dpad_up = 0;
        dpad_down = 0;
        if (!isdefined(level.var_ae47c5b0)) {
            level.var_ae47c5b0 = spawnstruct();
            level.var_ae47c5b0.dataset = [];
            var_98c8cf78 = spawnstruct();
            var_98c8cf78.name = "<dev string:x3c1>";
            var_98c8cf78.spawns = level.spawnpoints;
            level.var_ae47c5b0.dataset[0] = var_98c8cf78;
            var_abda6d2a = spawnstruct();
            var_abda6d2a.name = "<dev string:x3cf>";
            var_abda6d2a.spawns = level.spawn_start[#"allies"];
            level.var_ae47c5b0.dataset[1] = var_abda6d2a;
            var_bf68163b = spawnstruct();
            var_bf68163b.name = "<dev string:x3e5>";
            var_bf68163b.spawns = level.spawn_start[#"axis"];
            level.var_ae47c5b0.dataset[2] = var_bf68163b;
            var_5e0ba000 = spawnstruct();
            var_5e0ba000.name = "<dev string:x3f9>";
            var_5e0ba000.spawns = level.allspawnpoints;
            level.var_ae47c5b0.dataset[3] = var_5e0ba000;
        }
        level.var_ae47c5b0.teamfilter = "<dev string:x31>";
        level.var_ae47c5b0.currentsetindex = 0;
        level.var_ae47c5b0.currentspawnindex = 0;
        var_a171379c = 0;
        while (true) {
            self setactionslot(3, "<dev string:x30>");
            self setactionslot(4, "<dev string:x30>");
            if (!dpad_up && self buttonpressed("<dev string:x408>")) {
                level.var_ae47c5b0.currentsetindex++;
                if (level.var_ae47c5b0.currentsetindex >= level.var_ae47c5b0.dataset.size) {
                    level.var_ae47c5b0.currentsetindex = 0;
                }
                level.var_ae47c5b0.currentspawnindex = 0;
                dpad_up = 1;
                var_a171379c = 1;
            } else if (!self buttonpressed("<dev string:x408>")) {
                dpad_up = 0;
            }
            if (!dpad_down && self buttonpressed("<dev string:x410>")) {
                level.var_ae47c5b0.currentsetindex--;
                if (level.var_ae47c5b0.currentsetindex < 0) {
                    level.var_ae47c5b0.currentsetindex = level.var_ae47c5b0.dataset.size - 1;
                }
                level.var_ae47c5b0.currentspawnindex = 0;
                var_a171379c = 1;
                dpad_down = 1;
            } else if (!self buttonpressed("<dev string:x410>")) {
                dpad_down = 0;
            }
            if (!dpad_left && self buttonpressed("<dev string:x41a>")) {
                level.var_ae47c5b0.currentspawnindex--;
                if (level.var_ae47c5b0.currentspawnindex < 0) {
                    level.var_ae47c5b0.currentspawnindex = level.var_ae47c5b0.dataset[level.var_ae47c5b0.currentsetindex].spawns.size - 1;
                }
                var_a171379c = 1;
                dpad_left = 1;
            } else if (!self buttonpressed("<dev string:x41a>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<dev string:x424>")) {
                level.var_ae47c5b0.currentspawnindex++;
                if (level.var_ae47c5b0.currentspawnindex >= level.var_ae47c5b0.dataset[level.var_ae47c5b0.currentsetindex].spawns.size) {
                    level.var_ae47c5b0.currentspawnindex = 0;
                }
                var_a171379c = 1;
                dpad_right = 1;
            } else if (!self buttonpressed("<dev string:x424>")) {
                dpad_right = 0;
            }
            if (var_a171379c) {
                origin = level.var_ae47c5b0.dataset[level.var_ae47c5b0.currentsetindex].spawns[level.var_ae47c5b0.currentspawnindex].origin;
                angles = level.var_ae47c5b0.dataset[level.var_ae47c5b0.currentsetindex].spawns[level.var_ae47c5b0.currentspawnindex].angles;
                println("<dev string:x42f>" + level.var_ae47c5b0.dataset[level.var_ae47c5b0.currentsetindex].name);
                self setorigin(origin);
                self setplayerangles(angles);
                var_a171379c = 0;
            }
            debug2dtext((100, 750, 0), "<dev string:x44f>" + level.var_ae47c5b0.dataset[level.var_ae47c5b0.currentsetindex].name, (1, 0, 0));
            debug2dtext((100, 800, 0), "<dev string:x459>" + string(level.var_ae47c5b0.currentspawnindex) + "<dev string:x461>" + string(level.var_ae47c5b0.dataset[level.var_ae47c5b0.currentsetindex].spawns.size), (1, 0, 0));
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xe970d8f1, Offset: 0x4190
    // Size: 0x2e6
    function devgui_spawn_think() {
        self notify(#"devgui_spawn_think");
        self endon(#"devgui_spawn_think");
        self endon(#"disconnect");
        dpad_left = 0;
        dpad_right = 0;
        dpad_up = 0;
        dpad_down = 0;
        for (;;) {
            self setactionslot(3, "<dev string:x30>");
            self setactionslot(4, "<dev string:x30>");
            if (!dpad_left && self buttonpressed("<dev string:x41a>")) {
                setdvar(#"scr_playerwarp", "<dev string:x180>");
                dpad_left = 1;
            } else if (!self buttonpressed("<dev string:x41a>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<dev string:x424>")) {
                setdvar(#"scr_playerwarp", "<dev string:x175>");
                dpad_right = 1;
            } else if (!self buttonpressed("<dev string:x424>")) {
                dpad_right = 0;
            }
            if (!dpad_up && self buttonpressed("<dev string:x408>")) {
                setdvar(#"scr_playerwarp", "<dev string:x164>");
                dpad_up = 1;
            } else if (!self buttonpressed("<dev string:x408>")) {
                dpad_up = 0;
            }
            if (!dpad_down && self buttonpressed("<dev string:x410>")) {
                setdvar(#"scr_playerwarp", "<dev string:x153>");
                dpad_down = 1;
            } else if (!self buttonpressed("<dev string:x410>")) {
                dpad_down = 0;
            }
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x2efdd88d, Offset: 0x4480
    // Size: 0x172
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
                if (killstreaks::is_killstreak_weapon(weapon)) {
                    continue;
                }
                self givemaxammo(weapon);
            }
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x11e155dd, Offset: 0x4600
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
                if (player.sessionstate != "<dev string:x46a>") {
                    continue;
                }
                globallogic_score::_setplayermomentum(player, 5000);
            }
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0xb552acb7, Offset: 0x4728
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
            if (player.sessionstate != "<dev string:x46a>") {
                continue;
            }
            player globallogic_score::giveplayermomentumnotification(score, #"kill", "<dev string:x472>");
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0xfd639eaf, Offset: 0x4838
    // Size: 0xd8
    function function_72b389c8(score) {
        players = getplayers();
        foreach (player in players) {
            if (isdefined(player) && isalive(player) && player.sessionstate == "<dev string:x46a>") {
                player globallogic_score::resetplayermomentum();
            }
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x76a29b85, Offset: 0x4918
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
        self.debug_health_bar.alignx = "<dev string:x47f>";
        self.debug_health_bar.aligny = "<dev string:x484>";
        self.debug_health_bar.horzalign = "<dev string:x488>";
        self.debug_health_bar.vertalign = "<dev string:x488>";
        self.debug_health_bar.alpha = 1;
        self.debug_health_bar.foreground = 1;
        self.debug_health_bar setshader(#"black", 1, 8);
        self.debug_health_text = newdebughudelem(self);
        self.debug_health_text.x = x + 80;
        self.debug_health_text.y = y;
        self.debug_health_text.alignx = "<dev string:x47f>";
        self.debug_health_text.aligny = "<dev string:x484>";
        self.debug_health_text.horzalign = "<dev string:x488>";
        self.debug_health_text.vertalign = "<dev string:x488>";
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
    // Checksum 0xa631de05, Offset: 0x4c40
    // Size: 0xbe
    function giveextraperks() {
        if (!isdefined(self.extraperks)) {
            return;
        }
        perks = getarraykeys(self.extraperks);
        for (i = 0; i < perks.size; i++) {
            println("<dev string:x493>" + self.name + "<dev string:x49e>" + perks[i] + "<dev string:x4a9>");
            self perks::perk_setperk(perks[i]);
        }
    }

    // Namespace dev/dev
    // Params 2, eflags: 0x0
    // Checksum 0x870ae0ed, Offset: 0x4d08
    // Size: 0x14c
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
        victim thread [[ level.callbackplayerdamage ]](attacker, attacker, 1000, 0, "<dev string:x4b7>", level.weaponnone, (0, 0, 0), (0, 0, 0), "<dev string:x31>", (0, 0, 0), 0, 0, (1, 0, 0));
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xd32e75ec, Offset: 0x4e60
    // Size: 0x24
    function testscriptruntimeerrorassert() {
        wait 1;
        assert(0);
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x5eb03e18, Offset: 0x4e90
    // Size: 0x2c
    function testscriptruntimeassertmsgassert() {
        wait 1;
        assertmsg("<dev string:x4c8>");
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xbbc690c8, Offset: 0x4ec8
    // Size: 0x2c
    function testscriptruntimeerrormsgassert() {
        wait 1;
        errormsg("<dev string:x4df>");
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x4415a96a, Offset: 0x4f00
    // Size: 0x44
    function testscriptruntimeerror2() {
        myundefined = "<dev string:x4f5>";
        if (myundefined == 1) {
            println("<dev string:x4fa>");
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xc1cd4f22, Offset: 0x4f50
    // Size: 0x1c
    function testscriptruntimeerror1() {
        testscriptruntimeerror2();
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x69a52383, Offset: 0x4f78
    // Size: 0x12c
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
        if (myerror == "<dev string:x520>") {
            testscriptruntimeerrorassert();
        } else if (myerror == "<dev string:x527>") {
            testscriptruntimeassertmsgassert();
        } else if (myerror == "<dev string:x531>") {
            testscriptruntimeerrormsgassert();
        } else {
            testscriptruntimeerror1();
        }
        thread testscriptruntimeerror();
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xfd5363ed, Offset: 0x50b0
    // Size: 0x104
    function testdvars() {
        wait 5;
        for (;;) {
            if (getdvarstring(#"scr_testdvar") != "<dev string:x30>") {
                break;
            }
            wait 1;
        }
        tokens = strtok(getdvarstring(#"scr_testdvar"), "<dev string:x10a>");
        dvarname = tokens[0];
        dvarvalue = tokens[1];
        setdvar(dvarname, dvarvalue);
        setdvar(#"scr_testdvar", "<dev string:x30>");
        thread testdvars();
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x7de267a7, Offset: 0x51c0
    // Size: 0x234
    function addenemyheli() {
        wait 5;
        for (;;) {
            if (getdvarint(#"scr_spawnenemyheli", 0) > 0) {
                break;
            }
            wait 1;
        }
        enemyheli = getdvarint(#"scr_spawnenemyheli", 0);
        setdvar(#"scr_spawnenemyheli", 0);
        team = "<dev string:xa6>";
        player = util::gethostplayer();
        if (isdefined(player.pers[#"team"])) {
            team = util::getotherteam(player.pers[#"team"]);
        }
        ent = getormakebot(team);
        if (!isdefined(ent)) {
            println("<dev string:xb1>");
            wait 1;
            thread addenemyheli();
            return;
        }
        switch (enemyheli) {
        case 1:
            level.helilocation = ent.origin;
            ent thread helicopter::usekillstreakhelicopter("<dev string:x53a>");
            wait 0.5;
            ent notify(#"confirm_location", {#position:level.helilocation});
            break;
        case 2:
            break;
        }
        thread addenemyheli();
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x522d5cfe, Offset: 0x5400
    // Size: 0xd8
    function getormakebot(team) {
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i].team == team) {
                if (isbot(level.players[i])) {
                    return level.players[i];
                }
            }
        }
        ent = bot::add_bot(team);
        if (isdefined(ent)) {
            sound::play_on_players("<dev string:x54d>");
            wait 1;
        }
        return ent;
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xfaff8690, Offset: 0x54e0
    // Size: 0x25c
    function addtestcarepackage() {
        wait 5;
        for (;;) {
            if (getdvarint(#"scr_givetestsupplydrop", 0) > 0) {
                break;
            }
            wait 1;
        }
        supplydrop = getdvarint(#"scr_givetestsupplydrop", 0);
        team = "<dev string:xa6>";
        player = util::gethostplayer();
        if (isdefined(player.pers[#"team"])) {
            switch (supplydrop) {
            case 2:
                team = util::getotherteam(player.pers[#"team"]);
                break;
            case 1:
            default:
                team = player.pers[#"team"];
                break;
            }
        }
        setdvar(#"scr_givetestsupplydrop", 0);
        ent = getormakebot(team);
        if (!isdefined(ent)) {
            println("<dev string:xb1>");
            wait 1;
            thread addtestcarepackage();
            return;
        }
        ent killstreakrules::killstreakstart("<dev string:x55f>", team);
        ent thread supplydrop::helidelivercrate(ent.origin, getweapon(#"supplydrop"), ent, team);
        thread addtestcarepackage();
    }

    // Namespace dev/dev
    // Params 6, eflags: 0x0
    // Checksum 0xaec5ae58, Offset: 0x5748
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
    // Checksum 0xbf4d3967, Offset: 0x57c8
    // Size: 0x66
    function lineuntilnotified(start, end, color, depthtest, notification) {
        level endon(notification);
        for (;;) {
            line(start, end, color, depthtest);
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x860de241, Offset: 0x5838
    // Size: 0x184
    function engagement_distance_debug_toggle() {
        level endon(#"kill_engage_dist_debug_toggle_watcher");
        if (!isdefined(getdvarint(#"debug_engage_dists", 0))) {
            setdvar(#"debug_engage_dists", 0);
        }
        laststate = getdvarint(#"debug_engage_dists", 0);
        while (true) {
            currentstate = getdvarint(#"debug_engage_dists", 0);
            if (dvar_turned_on(currentstate) && !dvar_turned_on(laststate)) {
                weapon_engage_dists_init();
                thread debug_realtime_engage_dist();
                laststate = currentstate;
            } else if (!dvar_turned_on(currentstate) && dvar_turned_on(laststate)) {
                level notify(#"kill_all_engage_dist_debug");
                laststate = currentstate;
            }
            wait 0.3;
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x469984b0, Offset: 0x59c8
    // Size: 0x2a
    function dvar_turned_on(val) {
        if (val <= 0) {
            return 0;
        }
        return 1;
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xfe806039, Offset: 0x5a00
    // Size: 0x3e0
    function engagement_distance_debug_init() {
        level.debug_xpos = -50;
        level.debug_ypos = 250;
        level.debug_yinc = 18;
        level.debug_fontscale = 1.5;
        level.white = (1, 1, 1);
        level.green = (0, 1, 0);
        level.yellow = (1, 1, 0);
        level.red = (1, 0, 0);
        level.realtimeengagedist = newdebughudelem();
        level.realtimeengagedist.alignx = "<dev string:x47f>";
        level.realtimeengagedist.fontscale = level.debug_fontscale;
        level.realtimeengagedist.x = level.debug_xpos;
        level.realtimeengagedist.y = level.debug_ypos;
        level.realtimeengagedist.color = level.white;
        level.realtimeengagedist settext("<dev string:x56b>");
        xpos = level.debug_xpos + 207;
        level.realtimeengagedist_value = newdebughudelem();
        level.realtimeengagedist_value.alignx = "<dev string:x47f>";
        level.realtimeengagedist_value.fontscale = level.debug_fontscale;
        level.realtimeengagedist_value.x = xpos;
        level.realtimeengagedist_value.y = level.debug_ypos;
        level.realtimeengagedist_value.color = level.white;
        level.realtimeengagedist_value setvalue(0);
        xpos += 37;
        level.realtimeengagedist_middle = newdebughudelem();
        level.realtimeengagedist_middle.alignx = "<dev string:x47f>";
        level.realtimeengagedist_middle.fontscale = level.debug_fontscale;
        level.realtimeengagedist_middle.x = xpos;
        level.realtimeengagedist_middle.y = level.debug_ypos;
        level.realtimeengagedist_middle.color = level.white;
        level.realtimeengagedist_middle settext("<dev string:x589>");
        xpos += 105;
        level.realtimeengagedist_offvalue = newdebughudelem();
        level.realtimeengagedist_offvalue.alignx = "<dev string:x47f>";
        level.realtimeengagedist_offvalue.fontscale = level.debug_fontscale;
        level.realtimeengagedist_offvalue.x = xpos;
        level.realtimeengagedist_offvalue.y = level.debug_ypos;
        level.realtimeengagedist_offvalue.color = level.white;
        level.realtimeengagedist_offvalue setvalue(0);
        hudobjarray = [];
        hudobjarray[0] = level.realtimeengagedist;
        hudobjarray[1] = level.realtimeengagedist_value;
        hudobjarray[2] = level.realtimeengagedist_middle;
        hudobjarray[3] = level.realtimeengagedist_offvalue;
        return hudobjarray;
    }

    // Namespace dev/dev
    // Params 2, eflags: 0x0
    // Checksum 0x90a66a6b, Offset: 0x5de8
    // Size: 0x66
    function engage_dist_debug_hud_destroy(hudarray, killnotify) {
        level waittill(killnotify);
        for (i = 0; i < hudarray.size; i++) {
            hudarray[i] destroy();
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xbc21be2b, Offset: 0x5e58
    // Size: 0x70c
    function weapon_engage_dists_init() {
        level.engagedists = [];
        genericpistol = spawnstruct();
        genericpistol.engagedistmin = 125;
        genericpistol.engagedistoptimal = 225;
        genericpistol.engagedistmulligan = 50;
        genericpistol.engagedistmax = 400;
        shotty = spawnstruct();
        shotty.engagedistmin = 50;
        shotty.engagedistoptimal = 200;
        shotty.engagedistmulligan = 75;
        shotty.engagedistmax = 350;
        genericsmg = spawnstruct();
        genericsmg.engagedistmin = 100;
        genericsmg.engagedistoptimal = 275;
        genericsmg.engagedistmulligan = 100;
        genericsmg.engagedistmax = 500;
        genericlmg = spawnstruct();
        genericlmg.engagedistmin = 325;
        genericlmg.engagedistoptimal = 550;
        genericlmg.engagedistmulligan = 150;
        genericlmg.engagedistmax = 850;
        genericriflesa = spawnstruct();
        genericriflesa.engagedistmin = 325;
        genericriflesa.engagedistoptimal = 550;
        genericriflesa.engagedistmulligan = 150;
        genericriflesa.engagedistmax = 850;
        genericriflebolt = spawnstruct();
        genericriflebolt.engagedistmin = 350;
        genericriflebolt.engagedistoptimal = 600;
        genericriflebolt.engagedistmulligan = 150;
        genericriflebolt.engagedistmax = 900;
        generichmg = spawnstruct();
        generichmg.engagedistmin = 390;
        generichmg.engagedistoptimal = 600;
        generichmg.engagedistmulligan = 100;
        generichmg.engagedistmax = 900;
        genericsniper = spawnstruct();
        genericsniper.engagedistmin = 950;
        genericsniper.engagedistoptimal = 1700;
        genericsniper.engagedistmulligan = 300;
        genericsniper.engagedistmax = 3000;
        engage_dists_add("<dev string:x5a0>", genericpistol);
        engage_dists_add("<dev string:x5a5>", genericpistol);
        engage_dists_add("<dev string:x5ab>", genericpistol);
        engage_dists_add("<dev string:x5b3>", genericpistol);
        engage_dists_add("<dev string:x5bb>", genericsmg);
        engage_dists_add("<dev string:x5c4>", genericsmg);
        engage_dists_add("<dev string:x5d0>", genericsmg);
        engage_dists_add("<dev string:x5d5>", genericsmg);
        engage_dists_add("<dev string:x5da>", genericsmg);
        engage_dists_add("<dev string:x5e0>", genericsmg);
        engage_dists_add("<dev string:x5e5>", genericsmg);
        engage_dists_add("<dev string:x5f3>", shotty);
        engage_dists_add("<dev string:x5fb>", genericlmg);
        engage_dists_add("<dev string:x5ff>", genericlmg);
        engage_dists_add("<dev string:x609>", genericlmg);
        engage_dists_add("<dev string:x614>", genericlmg);
        engage_dists_add("<dev string:x625>", genericlmg);
        engage_dists_add("<dev string:x62a>", genericlmg);
        engage_dists_add("<dev string:x635>", genericlmg);
        engage_dists_add("<dev string:x63a>", genericlmg);
        engage_dists_add("<dev string:x645>", genericlmg);
        engage_dists_add("<dev string:x64a>", genericlmg);
        engage_dists_add("<dev string:x655>", genericriflesa);
        engage_dists_add("<dev string:x65e>", genericriflesa);
        engage_dists_add("<dev string:x668>", genericriflesa);
        engage_dists_add("<dev string:x66e>", genericriflesa);
        engage_dists_add("<dev string:x677>", genericriflebolt);
        engage_dists_add("<dev string:x683>", genericriflebolt);
        engage_dists_add("<dev string:x690>", genericriflebolt);
        engage_dists_add("<dev string:x69c>", genericriflebolt);
        engage_dists_add("<dev string:x6a3>", genericriflebolt);
        engage_dists_add("<dev string:x6af>", generichmg);
        engage_dists_add("<dev string:x6b5>", generichmg);
        engage_dists_add("<dev string:x6c1>", generichmg);
        engage_dists_add("<dev string:x6c6>", generichmg);
        engage_dists_add("<dev string:x6d1>", genericsniper);
        engage_dists_add("<dev string:x6e4>", genericsniper);
        engage_dists_add("<dev string:x6f8>", genericsniper);
        engage_dists_add("<dev string:x70b>", genericsniper);
        engage_dists_add("<dev string:x719>", genericsniper);
        engage_dists_add("<dev string:x725>", genericsniper);
        level thread engage_dists_watcher();
    }

    // Namespace dev/dev
    // Params 2, eflags: 0x0
    // Checksum 0xdbeed2e6, Offset: 0x6570
    // Size: 0x42
    function engage_dists_add(weaponname, values) {
        level.engagedists[getweapon(weaponname)] = values;
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x9d33d8de, Offset: 0x65c0
    // Size: 0x3e
    function get_engage_dists(weapon) {
        if (isdefined(level.engagedists[weapon])) {
            return level.engagedists[weapon];
        }
        return undefined;
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xc3db671f, Offset: 0x6608
    // Size: 0x118
    function engage_dists_watcher() {
        level endon(#"kill_all_engage_dist_debug");
        level endon(#"kill_engage_dists_watcher");
        while (true) {
            player = util::gethostplayer();
            playerweapon = player getcurrentweapon();
            if (!isdefined(player.lastweapon)) {
                player.lastweapon = playerweapon;
            } else if (player.lastweapon == playerweapon) {
                waitframe(1);
                continue;
            }
            values = get_engage_dists(playerweapon);
            if (isdefined(values)) {
                level.weaponengagedistvalues = values;
            } else {
                level.weaponengagedistvalues = undefined;
            }
            player.lastweapon = playerweapon;
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x8a0c0db6, Offset: 0x6728
    // Size: 0x496
    function debug_realtime_engage_dist() {
        level endon(#"kill_all_engage_dist_debug");
        level endon(#"kill_realtime_engagement_distance_debug");
        hudobjarray = engagement_distance_debug_init();
        level thread engage_dist_debug_hud_destroy(hudobjarray, "<dev string:x738>");
        level.debugrtengagedistcolor = level.green;
        player = util::gethostplayer();
        while (true) {
            lasttracepos = (0, 0, 0);
            direction = player getplayerangles();
            direction_vec = anglestoforward(direction);
            eye = player geteye();
            eye = (eye[0], eye[1], eye[2] + 20);
            trace = bullettrace(eye, eye + vectorscale(direction_vec, 100000), 1, player);
            tracepoint = trace[#"position"];
            tracenormal = trace[#"normal"];
            tracedist = int(distance(eye, tracepoint));
            if (tracepoint != lasttracepos) {
                lasttracepos = tracepoint;
                if (!isdefined(level.weaponengagedistvalues)) {
                    hudobj_changecolor(hudobjarray, level.white);
                    hudobjarray engagedist_hud_changetext("<dev string:x753>", tracedist);
                } else {
                    engagedistmin = level.weaponengagedistvalues.engagedistmin;
                    engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
                    engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
                    engagedistmax = level.weaponengagedistvalues.engagedistmax;
                    if (tracedist >= engagedistmin && tracedist <= engagedistmax) {
                        if (tracedist >= engagedistoptimal - engagedistmulligan && tracedist <= engagedistoptimal + engagedistmulligan) {
                            hudobjarray engagedist_hud_changetext("<dev string:x75a>", tracedist);
                            hudobj_changecolor(hudobjarray, level.green);
                        } else {
                            hudobjarray engagedist_hud_changetext("<dev string:x762>", tracedist);
                            hudobj_changecolor(hudobjarray, level.yellow);
                        }
                    } else if (tracedist < engagedistmin) {
                        hudobj_changecolor(hudobjarray, level.red);
                        hudobjarray engagedist_hud_changetext("<dev string:x765>", tracedist);
                    } else if (tracedist > engagedistmax) {
                        hudobj_changecolor(hudobjarray, level.red);
                        hudobjarray engagedist_hud_changetext("<dev string:x76b>", tracedist);
                    }
                }
            }
            thread util::function_60e3cc9(1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
            thread util::function_60e3cc9(1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
            waitframe(1);
        }
    }

    // Namespace dev/dev
    // Params 2, eflags: 0x0
    // Checksum 0x8de5911, Offset: 0x6bc8
    // Size: 0x88
    function hudobj_changecolor(hudobjarray, newcolor) {
        for (i = 0; i < hudobjarray.size; i++) {
            hudobj = hudobjarray[i];
            if (hudobj.color != newcolor) {
                hudobj.color = newcolor;
                level.debugrtengagedistcolor = newcolor;
            }
        }
    }

    // Namespace dev/dev
    // Params 2, eflags: 0x0
    // Checksum 0x1b538548, Offset: 0x6c58
    // Size: 0x2f6
    function engagedist_hud_changetext(engagedisttype, units) {
        if (!isdefined(level.lastdisttype)) {
            level.lastdisttype = "<dev string:x31>";
        }
        if (engagedisttype == "<dev string:x75a>") {
            self[1] setvalue(units);
            self[2] settext("<dev string:x770>");
            self[3].alpha = 0;
        } else if (engagedisttype == "<dev string:x762>") {
            self[1] setvalue(units);
            self[2] settext("<dev string:x780>");
            self[3].alpha = 0;
        } else if (engagedisttype == "<dev string:x765>") {
            amountunder = level.weaponengagedistvalues.engagedistmin - units;
            self[1] setvalue(units);
            self[3] setvalue(amountunder);
            self[3].alpha = 1;
            if (level.lastdisttype != engagedisttype) {
                self[2] settext("<dev string:x78b>");
            }
        } else if (engagedisttype == "<dev string:x76b>") {
            amountover = units - level.weaponengagedistvalues.engagedistmax;
            self[1] setvalue(units);
            self[3] setvalue(amountover);
            self[3].alpha = 1;
            if (level.lastdisttype != engagedisttype) {
                self[2] settext("<dev string:x79c>");
            }
        } else if (engagedisttype == "<dev string:x753>") {
            self[1] setvalue(units);
            self[2] settext("<dev string:x7ac>");
            self[3].alpha = 0;
        }
        level.lastdisttype = engagedisttype;
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x7b91c28a, Offset: 0x6f58
    // Size: 0x1da
    function larry_thread() {
        setdvar(#"bot_allowmovement", 0);
        setdvar(#"bot_allowaiming", 0);
        setdvar(#"bot_pressattackbtn", 0);
        setdvar(#"bot_pressmeleebtn", 0);
        level.larry = spawnstruct();
        player = util::gethostplayer();
        player thread larry_init(level.larry);
        level waittill(#"kill_larry");
        larry_hud_destroy(level.larry);
        if (isdefined(level.larry.model)) {
            level.larry.model delete();
        }
        if (isdefined(level.larry.ai)) {
            for (i = 0; i < level.larry.ai.size; i++) {
                kick(level.larry.ai[i] getentitynumber());
            }
        }
        level.larry = undefined;
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x9c483d40, Offset: 0x7140
    // Size: 0x254
    function larry_init(larry) {
        level endon(#"kill_larry");
        larry_hud_init(larry);
        larry.model = spawn("<dev string:x7cf>", (0, 0, 0));
        larry.model setmodel(#"defaultactor");
        larry.ai = [];
        wait 0.1;
        for (;;) {
            waitframe(1);
            if (larry.ai.size > 0) {
                larry.model hide();
                continue;
            }
            direction = self getplayerangles();
            direction_vec = anglestoforward(direction);
            eye = self geteye();
            trace = bullettrace(eye, eye + vectorscale(direction_vec, 8000), 0, undefined);
            dist = distance(eye, trace[#"position"]);
            position = eye + vectorscale(direction_vec, dist - 64);
            larry.model.origin = position;
            larry.model.angles = self.angles + (0, 180, 0);
            if (self usebuttonpressed()) {
                self larry_ai(larry);
                while (self usebuttonpressed()) {
                    waitframe(1);
                }
            }
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x98ce8ff0, Offset: 0x73a0
    // Size: 0x224
    function larry_ai(larry) {
        var_6109c352 = "<dev string:xa6>";
        if (level.teambased) {
            foreach (team in level.teams) {
                if (team != self.team) {
                    var_6109c352 = team;
                    break;
                }
            }
        } else {
            foreach (team in level.teams) {
                if (getplayers(team).size == 0) {
                    var_6109c352 = team;
                    break;
                }
            }
        }
        larry.ai[larry.ai.size] = bot::add_bot(var_6109c352);
        i = larry.ai.size - 1;
        larry.ai[i] thread larry_ai_thread(larry, larry.model.origin, larry.model.angles);
        larry.ai[i] thread larry_ai_damage(larry);
        larry.ai[i] thread larry_ai_health(larry);
    }

    // Namespace dev/dev
    // Params 3, eflags: 0x0
    // Checksum 0xc4902b56, Offset: 0x75d0
    // Size: 0x1e0
    function larry_ai_thread(larry, origin, angles) {
        level endon(#"kill_larry");
        for (;;) {
            self waittill(#"spawned_player");
            larry.menu[larry.menu_health] setvalue(self.health);
            larry.menu[larry.menu_damage] settext("<dev string:x30>");
            larry.menu[larry.menu_range] settext("<dev string:x30>");
            larry.menu[larry.menu_hitloc] settext("<dev string:x30>");
            larry.menu[larry.menu_weapon] settext("<dev string:x30>");
            larry.menu[larry.menu_perks] settext("<dev string:x30>");
            self setorigin(origin);
            self setplayerangles(angles);
            self clearperks();
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x3deeca1f, Offset: 0x77b8
    // Size: 0x2b8
    function larry_ai_damage(larry) {
        level endon(#"kill_larry");
        for (;;) {
            waitresult = self waittill(#"damage");
            attacker = waitresult.attacker;
            damage = waitresult.amount;
            point = waitresult.position;
            if (!isdefined(attacker)) {
                continue;
            }
            player = util::gethostplayer();
            if (!isdefined(player)) {
                continue;
            }
            if (attacker != player) {
                continue;
            }
            eye = player geteye();
            range = int(distance(eye, point));
            larry.menu[larry.menu_health] setvalue(self.health);
            larry.menu[larry.menu_damage] setvalue(damage);
            larry.menu[larry.menu_range] setvalue(range);
            if (isdefined(self.cac_debug_location)) {
                larry.menu[larry.menu_hitloc] settext(self.cac_debug_location);
            } else {
                larry.menu[larry.menu_hitloc] settext("<dev string:x7dc>");
            }
            if (isdefined(self.cac_debug_weapon)) {
                larry.menu[larry.menu_weapon] settext(self.cac_debug_weapon);
                continue;
            }
            larry.menu[larry.menu_weapon] settext("<dev string:x7dc>");
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x9d222d34, Offset: 0x7a78
    // Size: 0x60
    function larry_ai_health(larry) {
        level endon(#"kill_larry");
        for (;;) {
            waitframe(1);
            larry.menu[larry.menu_health] setvalue(self.health);
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0x9b865af3, Offset: 0x7ae0
    // Size: 0x586
    function larry_hud_init(larry) {
        /#
            x = -45;
            y = 275;
            menu_name = "<dev string:x7e6>";
            larry.hud = new_hud(menu_name, undefined, x, y, 1);
            larry.hud setshader(#"white", 135, 65);
            larry.hud.alignx = "<dev string:x47f>";
            larry.hud.aligny = "<dev string:x484>";
            larry.hud.sort = 10;
            larry.hud.alpha = 0.6;
            larry.hud.color = (0, 0, 0.5);
            larry.menu[0] = new_hud(menu_name, "<dev string:x7f1>", x + 5, y + 10, 1);
            larry.menu[1] = new_hud(menu_name, "<dev string:x7ff>", x + 5, y + 20, 1);
            larry.menu[2] = new_hud(menu_name, "<dev string:x807>", x + 5, y + 30, 1);
            larry.menu[3] = new_hud(menu_name, "<dev string:x80e>", x + 5, y + 40, 1);
            larry.menu[4] = new_hud(menu_name, "<dev string:x81c>", x + 5, y + 50, 1);
            larry.cleartextmarker = newdebughudelem();
            larry.cleartextmarker.alpha = 0;
            larry.cleartextmarker settext("<dev string:x824>");
            larry.menu_health = larry.menu.size;
            larry.menu_damage = larry.menu.size + 1;
            larry.menu_range = larry.menu.size + 2;
            larry.menu_hitloc = larry.menu.size + 3;
            larry.menu_weapon = larry.menu.size + 4;
            larry.menu_perks = larry.menu.size + 5;
            x_offset = 70;
            larry.menu[larry.menu_health] = new_hud(menu_name, "<dev string:x30>", x + x_offset, y + 10, 1);
            larry.menu[larry.menu_damage] = new_hud(menu_name, "<dev string:x30>", x + x_offset, y + 20, 1);
            larry.menu[larry.menu_range] = new_hud(menu_name, "<dev string:x30>", x + x_offset, y + 30, 1);
            larry.menu[larry.menu_hitloc] = new_hud(menu_name, "<dev string:x30>", x + x_offset, y + 40, 1);
            larry.menu[larry.menu_weapon] = new_hud(menu_name, "<dev string:x30>", x + x_offset, y + 50, 1);
            larry.menu[larry.menu_perks] = new_hud(menu_name, "<dev string:x30>", x + x_offset, y + 60, 1);
        #/
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0xb50b1041, Offset: 0x8070
    // Size: 0xac
    function larry_hud_destroy(larry) {
        if (isdefined(larry.hud)) {
            larry.hud destroy();
            for (i = 0; i < larry.menu.size; i++) {
                larry.menu[i] destroy();
            }
            larry.cleartextmarker destroy();
        }
    }

    // Namespace dev/dev
    // Params 5, eflags: 0x0
    // Checksum 0x483036a0, Offset: 0x8128
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
    // Checksum 0x8546e118, Offset: 0x8200
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
            hud.alignx = "<dev string:x47f>";
            hud.aligny = "<dev string:x82b>";
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
    // Checksum 0xe88ce341, Offset: 0x8378
    // Size: 0x14c
    function print_weapon_name() {
        /#
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
                iprintlnbold(getweaponname(weapon));
            }
        #/
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xf0245b43, Offset: 0x84d0
    // Size: 0x236
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
        level.dev_equipment[10] = getweapon(#"threat_detector");
        level.dev_equipment[11] = getweapon(#"armor_station");
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0x1400c2e, Offset: 0x8710
    // Size: 0x266
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
        level.dev_grenade[11] = getweapon(#"incendiary_grenade");
        level.dev_grenade[12] = getweapon(#"sprint_boost_grenade");
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0xe5f64ce6, Offset: 0x8980
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
    // Checksum 0x4a5b4c0b, Offset: 0x8a40
    // Size: 0x150
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
                    level.players[i] devgui::devgui_give_weapon(getweaponname(level.dev_equipment[devgui_int]));
                }
                setdvar(#"scr_give_equipment", 0);
            }
        }
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xeefa6036, Offset: 0x8b98
    // Size: 0x150
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
                    level.players[i] devgui::devgui_give_weapon(getweaponname(level.dev_grenade[devgui_int]));
                }
                setdvar(#"scr_give_grenade", 0);
            }
        }
    }

    // Namespace dev/dev
    // Params 1, eflags: 0x0
    // Checksum 0xc6696a69, Offset: 0x8cf0
    // Size: 0x27c
    function force_grenade_throw(weapon) {
        if (weapon == level.weaponnone) {
            return;
        }
        setdvar(#"bot_allowmovement", 0);
        setdvar(#"bot_allowaiming", 0);
        setdvar(#"bot_pressattackbtn", 0);
        setdvar(#"bot_pressmeleebtn", 0);
        setdvar(#"scr_botsallowkillstreaks", 0);
        host = util::gethostplayer();
        if (!isdefined(host.team)) {
            iprintln("<dev string:x832>");
            return;
        }
        bot = getormakebot(util::getotherteam(host.team));
        if (!isdefined(bot)) {
            iprintln("<dev string:xb1>");
            return;
        }
        angles = host getplayerangles();
        angles = (0, angles[1], 0);
        dir = anglestoforward(angles);
        dir = vectornormalize(dir);
        origin = host geteye() + vectorscale(dir, 256);
        velocity = vectorscale(dir, -1024);
        grenade = bot magicgrenadeplayer(weapon, origin, velocity);
        grenade setteam(bot.team);
        grenade setowner(bot);
    }

    // Namespace dev/dev
    // Params 0, eflags: 0x0
    // Checksum 0xa5cf61db, Offset: 0x8f78
    // Size: 0x472
    function devstraferunpathdebugdraw() {
        white = (1, 1, 1);
        red = (1, 0, 0);
        green = (0, 1, 0);
        blue = (0, 0, 1);
        violet = (0.4, 0, 0.6);
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = (0, 0, -50);
        endonmsg = "<dev string:x857>";
        while (true) {
            if (killstreaks::should_draw_debug("<dev string:x875>") > 0) {
                nodes = [];
                end = 0;
                node = getvehiclenode("<dev string:x881>", "<dev string:x121>");
                if (!isdefined(node)) {
                    println("<dev string:x88f>");
                    setdvar(#"scr_devstraferunpathdebugdraw", 0);
                    continue;
                }
                while (isdefined(node.target)) {
                    new_node = getvehiclenode(node.target, "<dev string:x121>");
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
                                sphere(node.origin, radius, textcolor, textalpha, 1, sides, int(drawtime * 1000));
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
    // Checksum 0x5efb6f92, Offset: 0x93f8
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
        endonmsg = "<dev string:x8a8>";
        while (true) {
            if (getdvarint(#"scr_devhelipathsdebugdraw", 0) > 0) {
                script_origins = getentarray("<dev string:x8c2>", "<dev string:x9c>");
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
    // Checksum 0x1203f844, Offset: 0x97c8
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
    // Checksum 0x675d40b1, Offset: 0x98d0
    // Size: 0x6c
    function drawtargetnametext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
    }

    // Namespace dev/dev
    // Params 4, eflags: 0x0
    // Checksum 0x9a678f4d, Offset: 0x9948
    // Size: 0x6c
    function drawnoteworthytext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.script_noteworthy, textcolor, textalpha, textscale);
    }

    // Namespace dev/dev
    // Params 4, eflags: 0x0
    // Checksum 0x7beec3e7, Offset: 0x99c0
    // Size: 0xbc
    function draworigintext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        originstring = "<dev string:x8d0>" + self.origin[0] + "<dev string:x8d2>" + self.origin[1] + "<dev string:x8d2>" + self.origin[2] + "<dev string:x8d5>";
        print3d(self.origin + textoffset, originstring, textcolor, textalpha, textscale);
    }

    // Namespace dev/dev
    // Params 4, eflags: 0x0
    // Checksum 0x92e764ed, Offset: 0x9a88
    // Size: 0xd4
    function drawspeedacceltext(textcolor, textalpha, textscale, textoffset) {
        if (isdefined(self.script_airspeed)) {
            print3d(self.origin + (0, 0, textoffset[2] * 2), "<dev string:x8d7>" + self.script_airspeed, textcolor, textalpha, textscale);
        }
        if (isdefined(self.script_accel)) {
            print3d(self.origin + (0, 0, textoffset[2] * 3), "<dev string:x8e8>" + self.script_accel, textcolor, textalpha, textscale);
        }
    }

    // Namespace dev/dev
    // Params 7, eflags: 0x0
    // Checksum 0x1bb235f1, Offset: 0x9b68
    // Size: 0x142
    function drawpath(linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
        level endon(endonmsg);
        ent = self;
        entfirsttarget = ent.targetname;
        while (isdefined(ent.target)) {
            enttarget = getent(ent.target, "<dev string:x121>");
            ent thread drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg);
            if (ent.targetname == "<dev string:x8f6>") {
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
    // Checksum 0xe84440a2, Offset: 0x9cb8
    // Size: 0x116
    function drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
        level endon(endonmsg);
        while (drawtime > 0) {
            if (isdefined(self.targetname) && self.targetname == "<dev string:x881>") {
                print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
            }
            line(self.origin, enttarget.origin, linecolor);
            self drawspeedacceltext(textcolor, textalpha, textscale, textoffset);
            drawtime -= 0.05;
            waitframe(1);
        }
    }

#/
