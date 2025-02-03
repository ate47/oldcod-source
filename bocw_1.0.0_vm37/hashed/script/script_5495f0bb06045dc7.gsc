#using script_1467cf24b0d4ee55;
#using script_1cc417743d7c262d;
#using script_277bc0c5e470495e;
#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_6652a3edaad1063c;
#using script_67ce8e728d8f37ba;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\dogtags;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\player\player_reinsertion;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\bb;
#using scripts\mp_common\gameadvertisement;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\menus;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\laststand;
#using scripts\mp_common\player\player_killed;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\team_assignment;
#using scripts\mp_common\teams\teams;
#using scripts\wz_common\character_banter;
#using scripts\wz_common\hud;
#using scripts\wz_common\oob;
#using scripts\wz_common\spawn;
#using scripts\wz_common\teams\teams;
#using scripts\wz_common\util;
#using scripts\wz_common\wz_ignore_systems;
#using scripts\wz_common\wz_progression;

#namespace namespace_17baa64d;

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x79322427, Offset: 0x3d8
// Size: 0x70c
function init() {
    globallogic::init();
    level.var_79219af4 = 0;
    if (getdvarint(#"hash_2cc9b0ef1896d89a", 1) != 0) {
        level.var_79219af4 = isdefined(getgametypesetting(#"startplayers")) ? getgametypesetting(#"startplayers") : 0;
    }
    level.var_f2814a96 = isdefined(getgametypesetting(#"hash_6be1c95551e78384")) ? getgametypesetting(#"hash_6be1c95551e78384") : 0;
    if (level.var_f2814a96 !== 1 && level.var_f2814a96 !== 2) {
        level.var_3d984b4c = 0;
    }
    level.var_153e7dad = 1;
    level.var_4cea2bec = isdefined(getgametypesetting(#"hash_6cc7b012775d9662")) ? getgametypesetting(#"hash_6cc7b012775d9662") : 0;
    level.var_6c900548 = isdefined(getgametypesetting(#"hash_2b3e56efad3a1504")) ? getgametypesetting(#"hash_2b3e56efad3a1504") : 0;
    level.var_e16a689f = isdefined(getgametypesetting(#"hash_557cb4680634f585")) ? getgametypesetting(#"hash_557cb4680634f585") : 0;
    level.onstartgametype = &on_start_game_type;
    level.onspawnplayer = &on_spawn_player;
    level.onendround = &on_end_round;
    level.onendgame = &on_end_game;
    level.ondeadevent = &on_dead_event;
    level.ononeleftevent = &on_one_left_event;
    level.var_a962eeb6 = &function_486a8395;
    level.var_a3e209ba = &function_a3e209ba;
    if (isdefined(getgametypesetting(#"disableclassselection")) ? getgametypesetting(#"disableclassselection") : 0) {
        level.var_86513cd0 = &function_3b0db3c2;
    }
    level.var_74b10e67 = &loadout::register_perks;
    level.var_5495fbf1 = 0;
    level.var_e7b05b51 = 0;
    level.var_674e8051 = 1;
    level.var_f48e69e7 = 1;
    level.var_f97a6ba3 = 1;
    level.var_806e130d = 1;
    if (isdefined(getgametypesetting(#"disableweapondrop")) ? getgametypesetting(#"disableweapondrop") : 0) {
        level.var_827f5a28 = 1;
    }
    level.var_eed7c027 = [];
    level.on_spawn_player = &spawn::on_spawn_player;
    insertion::init();
    hud::function_9b9cecdf();
    death_circle::init_vo();
    oob::init();
    callback::on_player_killed(&function_c1a417ee);
    player::function_cf3aa03d(&player_killed);
    callback::on_spawned(&on_player_spawned);
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_game_playing(&start_warzone);
    callback::add_callback(#"on_last_alive", &function_5af3a29);
    callback::add_callback(#"hash_40cd438036ae13df", &function_1f93e91f);
    callback::on_item_pickup(&on_item_pickup);
    callback::add_callback(#"hash_1019ab4b81d07b35", &team_eliminated);
    function_aaa24662();
    level.wound_disabled = 1;
    level.var_b219667f = 1;
    level.var_606becce = [];
    level thread function_23600e7d();
    /#
        callback::on_vehicle_spawned(&function_5d7553c9);
        level.var_5efad16e = &function_73b0f715;
        forcedplayerteam = getdvarstring(#"forcedplayerteam", "<dev string:x38>");
        if (forcedplayerteam != "<dev string:x38>") {
            level.forcedplayerteam = forcedplayerteam;
        }
        level thread function_c2a75696();
    #/
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x8b69989a, Offset: 0xaf0
// Size: 0x64
function on_spawn_player(predictedspawn) {
    if (level.var_f2814a96 === 1 || level.var_f2814a96 === 2) {
        namespace_ce472ff1::on_spawn_player(predictedspawn);
        return;
    }
    spawn::on_spawn_player(predictedspawn);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0xa129ea43, Offset: 0xb60
// Size: 0x1ac
function on_start_game_type() {
    level.displayroundendtext = 0;
    level.var_992e9235 = [];
    level thread spawn::function_e93291ff();
    level callback::add_callback(#"hash_774be40ec06d5212", &function_bcde1e07);
    level flag::clear(#"spawning_allowed");
    laststand_mp::function_414115a0(90, 150);
    laststand_mp::function_414115a0(25, 150);
    laststand_mp::function_414115a0(15, 150);
    laststand_mp::function_414115a0(10, 150);
    laststand_mp::function_414115a0(5, 150);
    laststand_mp::function_414115a0(3, 150);
    laststand_mp::function_414115a0(1, 150);
    laststand_mp::function_414115a0(0, 150);
    death_circle::init();
    if (is_true(level.var_4cea2bec)) {
        level thread function_6ee52dd0(level.var_6c900548, level.var_e16a689f);
    }
    level thread hud::function_5db32126();
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x3ca9243c, Offset: 0xd18
// Size: 0x34
function function_bcde1e07() {
    level flag::clear(#"spawning_allowed");
    player_insertion::function_bcde1e07();
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0xfa9af919, Offset: 0xd58
// Size: 0xdc
function function_3b0db3c2() {
    if (!util::isfirstround()) {
        return;
    }
    /#
        if (function_7373cc35()) {
            return;
        }
    #/
    level.prematchperiod = max(level.prematchperiod, 5);
    level thread character_banter::start();
    level waittill(#"hash_78e53817cafb5265");
    level thread character_banter::stop();
    println("<dev string:x3c>");
    if (level.var_b02808b6) {
        gameadvertisement::setadvertisedstatus(0);
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x4
// Checksum 0xaab6145d, Offset: 0xe40
// Size: 0x7e
function private function_70171add() {
    if (randomfloat(1) <= getdvarfloat(#"survey_chance", 0)) {
        return randomintrange(1, getdvarint(#"survey_count", 0) + 1);
    }
    return 0;
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x273e4f7f, Offset: 0xec8
// Size: 0x2e4
function start_warzone() {
    level notify(#"start_warzone");
    println("<dev string:x3c>");
    if (level.var_b02808b6) {
        gameadvertisement::setadvertisedstatus(0);
    }
    teams::function_344e464d();
    if (is_true(level.spawnsystem.deathcirclerespawn)) {
        level callback::add_callback(#"hash_3057417db7f8acdd", &function_77319881);
    }
    if (sessionmodeisonlinegame() && getdvarint(#"hash_6aad986495699040", 0) != 0) {
        function_f539d880();
    }
    function_65469e2e();
    if (level.var_f2814a96 === 0 || level.var_f2814a96 === 2) {
        level player_insertion::function_8dcd8623();
    }
    level.ingraceperiod = 0;
    spawning::function_7a87efaa();
    level.var_bde3d03 = undefined;
    survey_id = function_70171add();
    foreach (player in getplayers()) {
        player spawn::function_8cef1872();
        player val::reset(#"warzonestaging", "takedamage");
        if (sessionmodeisonlinegame()) {
            player stats::function_7a850245(#"demofileid", getdemofileid());
            if (level.rankedmatch) {
                player stats::function_7a850245("surveyId", survey_id);
            }
        }
    }
    spawn::function_cb5864fc();
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0xcff8b44f, Offset: 0x11b8
// Size: 0x4c
function on_player_connect() {
    self.var_63af7f75 = -1;
    self.var_c5134737 = 1;
    level hud::function_22df4165();
    self wz_progression::player_connected();
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x6f2f9acb, Offset: 0x1210
// Size: 0x64
function on_player_disconnect() {
    self wz_progression::player_disconnected();
    level hud::function_22df4165();
    dogtag = self.var_c0ad34c;
    if (isdefined(dogtag)) {
        item_drop::function_ccba50c6(dogtag);
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0xcd06dcb5, Offset: 0x1280
// Size: 0xc8
function team_eliminated(params) {
    team = params.team;
    foreach (player in getplayers(team)) {
        dogtag = player.var_c0ad34c;
        if (isdefined(dogtag)) {
            item_drop::function_ccba50c6(dogtag);
        }
    }
}

/#

    // Namespace namespace_17baa64d/namespace_17baa64d
    // Params 0, eflags: 0x0
    // Checksum 0x6e1b0126, Offset: 0x1350
    // Size: 0xfc
    function function_5d7553c9() {
        if (game.state == #"pregame") {
            return;
        }
        if (level flag::get(#"item_world_reset")) {
            return;
        }
        if (!is_true(self.isplayervehicle)) {
            return;
        }
        if (!isdefined(level.var_c18a1e6b)) {
            level.var_c18a1e6b = 0;
        }
        level.var_c18a1e6b++;
        if (getdvarint(#"hash_10daadecda56ef52", 1) && level.var_c18a1e6b > 120) {
            assert(level.var_c18a1e6b <= 120, "<dev string:x57>");
        }
    }

    // Namespace namespace_17baa64d/namespace_17baa64d
    // Params 0, eflags: 0x4
    // Checksum 0xab2c2690, Offset: 0x1458
    // Size: 0x130
    function private function_c2a75696() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x7a>" + mapname + "<dev string:x8b>");
        adddebugcommand("<dev string:x7a>" + mapname + "<dev string:xc0>");
        while (true) {
            waitframe(1);
            string = getdvarstring(#"warzone_devgui_cmd", "<dev string:x38>");
            switch (string) {
            case #"start":
                function_73b0f715();
                break;
            default:
                break;
            }
            setdvar(#"warzone_devgui_cmd", "<dev string:x38>");
        }
    }

#/

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 3, eflags: 0x4
// Checksum 0xc6cefaab, Offset: 0x1590
// Size: 0x84
function private function_75189494(var_c6ce2627, playercount, var_404397c4) {
    data = {#var_19b5b856:var_c6ce2627, #var_f388074a:playercount, #var_4a2854ac:var_404397c4};
    function_92d1707f(#"hash_7bcd081bd6940681", data);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x4
// Checksum 0xdf32e4a4, Offset: 0x1620
// Size: 0xfc0
function private function_23600e7d() {
    var_26ef8eea = isdefined(getgametypesetting(#"hash_bd1199baafe11fe")) ? getgametypesetting(#"hash_bd1199baafe11fe") : 1;
    /#
        var_26ef8eea = 0;
    #/
    if (var_26ef8eea && !isdedicated()) {
        println("<dev string:x102>");
        return;
    }
    if (getdvarint(#"hash_2cc9b0ef1896d89a", 1) != 0) {
        println("<dev string:x13a>");
        return;
    }
    while (!isdefined(game.state) || game.state != #"pregame") {
        waitframe(1);
    }
    while (function_a1ef346b().size == 0) {
        waitframe(1);
    }
    if (getdvarint(#"wz_test_mode", 0) != 0) {
        println("<dev string:x166>");
        level function_73b0f715();
        return;
    }
    /#
        if (function_7373cc35()) {
            return;
        }
    #/
    level endon(#"start_warzone");
    level.var_8fcd8a61 = isdefined(getgametypesetting(#"hash_35c2d850e39fa704")) ? getgametypesetting(#"hash_35c2d850e39fa704") : 100;
    level.var_e9d6c52f = isdefined(getgametypesetting(#"hash_46f957248efbd39a")) ? getgametypesetting(#"hash_46f957248efbd39a") : 10;
    level.player_reduction = isdefined(getgametypesetting(#"player_reduction")) ? getgametypesetting(#"player_reduction") : 4;
    level.evolution_interval = isdefined(getgametypesetting(#"evolution_interval")) ? getgametypesetting(#"evolution_interval") : 20;
    level.var_8ca0499 = isdefined(getgametypesetting(#"hash_ad6c0d1cd92c1fe")) ? getgametypesetting(#"hash_ad6c0d1cd92c1fe") : 30;
    level.var_493d04d3 = isdefined(getgametypesetting(#"hash_28233b1037888945")) ? getgametypesetting(#"hash_28233b1037888945") : 15;
    level.max_wait_time = isdefined(getgametypesetting(#"max_wait_time")) ? getgametypesetting(#"max_wait_time") : 0;
    level.var_3f631d69 = isdefined(getgametypesetting(#"hash_2d4ff63e866cdd74")) ? getgametypesetting(#"hash_2d4ff63e866cdd74") : 120;
    if (level.evolution_interval <= 0) {
        level.evolution_interval = 1;
    }
    level.var_25fc8e84 = int(ceil(level.max_wait_time * 60 / level.evolution_interval));
    starttime = gettime();
    var_fb9555e1 = 3;
    level.var_a132ca2b = level.var_8fcd8a61;
    level.var_7dc1df3a = spawnstruct();
    level.var_7dc1df3a.var_e2382b29 = level.var_8fcd8a61;
    var_e09e5160 = function_a1ef346b().size;
    evolution = 0;
    println("<dev string:x19c>" + starttime);
    println("<dev string:x1b6>" + level.var_8fcd8a61);
    println("<dev string:x1d0>" + level.var_e9d6c52f);
    println("<dev string:x1ea>" + level.player_reduction);
    println("<dev string:x204>" + level.evolution_interval);
    println("<dev string:x220>" + level.var_8ca0499);
    println("<dev string:x241>" + level.var_493d04d3);
    println("<dev string:x268>" + level.max_wait_time);
    println("<dev string:x27f>" + level.var_3f631d69);
    println("<dev string:x2a9>" + level.var_25fc8e84);
    println("<dev string:x2c6>" + level.var_a132ca2b);
    while (true) {
        println("<dev string:x2e4>");
        println("<dev string:x319>" + evolution);
        if (getdvarint(#"hash_2cc9b0ef1896d89a", 1) != 0) {
            println("<dev string:x13a>");
            level.var_7dc1df3a = undefined;
            return;
        }
        if (level.max_wait_time > 0 && level.var_25fc8e84 <= 0) {
            level.var_a132ca2b = level.var_e9d6c52f;
            level.var_8ca0499 = level.var_3f631d69;
            level.var_493d04d3 = 0;
            println("<dev string:x33e>" + level.max_wait_time + "<dev string:x36e>");
            println("<dev string:x37b>" + level.var_a132ca2b + "<dev string:x39d>" + level.var_8ca0499);
        }
        if (function_a1ef346b().size >= level.var_a132ca2b) {
            level.var_7dc1df3a.var_7be962bb = function_a1ef346b().size;
            level.var_7dc1df3a.var_7d960258 = level.var_a132ca2b;
            if (function_a1ef346b().size < level.var_8fcd8a61) {
                println("<dev string:x3b9>" + level.var_8fcd8a61 + "<dev string:x3f8>" + function_a1ef346b().size);
                if (level.var_8ca0499 > 0) {
                    timeleft = level.var_8ca0499;
                    println("<dev string:x409>" + level.var_8ca0499);
                    while (timeleft > 0) {
                        timeleft -= 1;
                        wait 1;
                        if (function_a1ef346b().size >= level.var_8fcd8a61) {
                            break;
                        }
                    }
                    level.var_7dc1df3a.var_a104a7da = function_a1ef346b().size - level.var_7dc1df3a.var_7be962bb;
                }
            }
            if (function_a1ef346b().size < level.var_a132ca2b) {
                wait 5;
                var_fb9555e1 = 3;
                continue;
            }
            if (level.var_b02808b6) {
                println("<dev string:x44a>");
                gameadvertisement::setadvertisedstatus(0);
            }
            level.var_7dc1df3a.duration = gettime() - starttime;
            println("<dev string:x46b>" + gettime());
            level function_73b0f715();
            return;
        }
        if (level.var_493d04d3 <= 0 && function_a1ef346b().size < level.var_e9d6c52f) {
            if (var_fb9555e1 > 0) {
                println("<dev string:x485>" + function_a1ef346b().size);
                wait 5;
                var_fb9555e1--;
                println("<dev string:x4cb>" + var_fb9555e1);
                continue;
            }
            function_75189494(gettime() - starttime, function_a1ef346b().size, level.var_e9d6c52f);
            println("<dev string:x4e7>" + gettime());
            level.var_7dc1df3a = undefined;
            exitlevel(0, #"hash_35b5848d9f1b58e0");
            return;
        }
        println("<dev string:x504>");
        println("<dev string:x537>" + function_a1ef346b().size);
        println("<dev string:x54f>" + level.var_a132ca2b);
        if (function_a1ef346b().size < level.var_a132ca2b) {
            var_7bce82a7 = function_a1ef346b().size - var_e09e5160;
            if (var_7bce82a7 >= 3) {
                println("<dev string:x567>" + var_7bce82a7);
                if (level.var_a132ca2b < level.var_8fcd8a61 - level.maxteamplayers) {
                    var_b0c8b797 = level.var_a132ca2b - function_a1ef346b().size;
                    if (var_b0c8b797 < 4 * level.maxteamplayers) {
                        level.var_a132ca2b += level.maxteamplayers;
                        println("<dev string:x58c>" + level.var_a132ca2b);
                    }
                }
                var_e09e5160 = function_a1ef346b().size;
                wait 2;
                println("<dev string:x5b7>" + evolution);
                continue;
            }
        }
        evolution++;
        var_e09e5160 = function_a1ef346b().size;
        println("<dev string:x5e3>" + level.evolution_interval);
        timeleft = level.evolution_interval;
        while (timeleft > 0) {
            timeleft -= 1;
            wait 1;
            if (function_a1ef346b().size >= level.var_a132ca2b) {
                break;
            }
        }
        if (function_a1ef346b().size < level.var_a132ca2b) {
            level.var_a132ca2b -= level.player_reduction;
            if (level.var_a132ca2b < level.var_e9d6c52f) {
                level.var_a132ca2b = level.var_e9d6c52f;
            }
        }
        if (level.var_25fc8e84 > 0) {
            level.var_25fc8e84--;
        }
        if (level.var_493d04d3 > 0) {
            level.var_493d04d3--;
        }
        println("<dev string:x60d>" + level.var_a132ca2b);
        println("<dev string:x632>" + level.var_493d04d3);
        println("<dev string:x664>");
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 2, eflags: 0x4
// Checksum 0x992fdd57, Offset: 0x25e8
// Size: 0x1a8
function private function_ec2c9808(response, intpayload) {
    if (!isalive(self) && !player::function_73da2f89()) {
        return;
    }
    foreach (player in getplayers()) {
        if (player.team === self.team) {
            if (response == "placed") {
                xcoord = int(intpayload / 1000);
                ycoord = intpayload - xcoord * 1000;
                player luinotifyevent(#"teammate_waypoint_placed", 3, self getentitynumber(), xcoord, ycoord);
                continue;
            }
            if (response == "removed") {
                player luinotifyevent(#"teammate_waypoint_removed", 1, self getentitynumber());
            }
        }
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x595021ca, Offset: 0x2798
// Size: 0x28
function function_cc47bb2f() {
    if (game.state == #"pregame") {
        return true;
    }
    return false;
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x341ac22b, Offset: 0x27c8
// Size: 0x52a
function on_player_spawned() {
    self endon(#"death");
    level endon(#"game_ended");
    self.var_1ab1ec0c = self.origin;
    self laststand_mp::function_7e714b6a();
    dogtag = self.var_c0ad34c;
    if (isdefined(dogtag)) {
        item_drop::function_ccba50c6(dogtag);
    }
    self clientfield::set_player_uimodel("hudItems.playerCleanUps", self.cleanups);
    self clientfield::set_player_uimodel("hudItems.playerKills", self.kills);
    level hud::function_22df4165();
    character_index = self getcharacterbodytype();
    fields = getcharacterfields(character_index, currentsessionmode());
    if (isdefined(fields)) {
        if (isdefined(fields.var_9c1be670) && fields.var_9c1be670) {
            self hidepart("tag_ability_hero");
        }
        if (isdefined(fields.var_1b216715) && fields.var_1b216715) {
            self hidepart("tag_equipment_hero");
        }
    }
    if (isdefined(self.pers) && isdefined(self.pers[#"lives"])) {
        self spawn::function_1390f875(self.pers[#"lives"]);
        if (self.pers[#"lives"] != 1 && !is_true(self.var_874448e8)) {
            self clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 1);
            self.var_874448e8 = 1;
        }
        if (self.pers[#"lives"] == 1) {
            self clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 0);
        }
    }
    if (function_cc47bb2f()) {
        if (is_true(getgametypesetting("allowPlayerMovementPrematch"))) {
            self val::reset(#"spawn_player", "freezecontrols");
        }
        self val::reset(#"spawn_player", "disablegadgets");
        self val::set(#"warzonestaging", "takedamage", 0);
        if (level.var_79219af4 > 0 && function_a1ef346b().size + 1 >= level.var_79219af4) {
            level function_73b0f715();
        }
        return;
    }
    if (player_reinsertion::function_42a8e289()) {
        self thread player_reinsertion::function_1579c63e();
        return;
    }
    if (level.var_f2814a96 === 0) {
        /#
            if (getdvarint(#"scr_disable_infiltration", 0)) {
                return;
            }
        #/
        var_7eb8f61a = isdefined(getgametypesetting(#"wzplayerinsertiontypeindex")) ? getgametypesetting(#"wzplayerinsertiontypeindex") : 0;
        switch (var_7eb8f61a) {
        case 0:
            self thread player_reinsertion::function_584c9f1();
            break;
        case 1:
            self thread player_reinsertion::function_39a51e47();
            break;
        case 2:
            self thread player_reinsertion::function_3c4884f1();
            break;
        }
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x265f002c, Offset: 0x2d00
// Size: 0x34
function on_end_round(var_c1e98979) {
    teams::function_f1394038();
    function_16e6bd2e(var_c1e98979);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0xecac81d, Offset: 0x2d40
// Size: 0x1e4
function on_dead_event(team) {
    if (team == "all") {
        var_d72df62 = teams::function_c7eae573();
        winning_team = teams::function_c2f2fb84(var_d72df62);
        count = 2;
        foreach (final_team in var_d72df62) {
            if (!isdefined(winning_team) || util::function_fbce7263(winning_team, final_team.team)) {
                teams::team_eliminated(final_team.team, count);
                count++;
            }
        }
        teams::function_5fed3908(winning_team);
        round::function_af2e264f(winning_team);
        thread globallogic::end_round(6);
        return;
    }
    if (teams::function_9dd75dad(team) && !is_true(level.var_606becce[team]) && teams::is_all_dead(team)) {
        teams::team_eliminated(team, globallogic::function_e9e52d05() + 1);
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0xde34e4a5, Offset: 0x2f30
// Size: 0x54
function function_5af3a29(params) {
    level thread function_3832a0d2(params.teams_alive[0]);
    teams::function_5fed3908(params.teams_alive[0]);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x851e6f52, Offset: 0x2f90
// Size: 0xfc
function function_3832a0d2(team) {
    winner = function_b5f4c9d8(team);
    if (isdefined(winner)) {
        bundle_name = winner getmpdialogname();
        if (isdefined(bundle_name)) {
            player_bundle = getscriptbundle(bundle_name);
            if (isdefined(player_bundle)) {
                var_520b24a = player_bundle.boostwin;
                if (isdefined(var_520b24a)) {
                    level.var_fec861a7 = 1;
                    winner battlechatter::function_a48c33ff(var_520b24a, 148, 5);
                    level.var_fec861a7 = undefined;
                }
            }
        }
    }
    wait 5;
    globallogic_audio::leader_dialog("warTeamWon", team);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x4
// Checksum 0xdf12be4a, Offset: 0x3098
// Size: 0x106
function private function_b5f4c9d8(team) {
    winner = undefined;
    players = getplayers(team);
    foreach (player in players) {
        if (!isalive(player)) {
            continue;
        }
        if (!isdefined(player.lastkilltime)) {
            player.lastkilltime = 0;
        }
        if (!isdefined(winner) || player.lastkilltime > winner.lastkilltime) {
            winner = player;
        }
    }
    return winner;
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x8739e24c, Offset: 0x31a8
// Size: 0xea
function on_one_left_event(team) {
    if (team == "all") {
        return;
    }
    foreach (player in getplayers(team)) {
        if (isalive(player) && !player laststand::player_is_in_laststand()) {
            player globallogic_audio::leader_dialog_on_player("warLastManStanding");
            return;
        }
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x8ca69c79, Offset: 0x32a0
// Size: 0x14
function function_379afb41() {
    death_circle::function_27d5d349();
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x2dc27c9e, Offset: 0x32c0
// Size: 0xa4
function on_end_game(*var_c1e98979) {
    function_379afb41();
    level.var_bde3d03 = &oob::function_b777ff94;
    level thread globallogic_audio::function_85818e24("matchcomplete");
    winner = round::get_winner();
    match::function_af2e264f(winner);
    setmatchflag("game_ended", 1);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x2f3fd4e5, Offset: 0x3370
// Size: 0x264
function function_c1a417ee(params) {
    level hud::function_22df4165();
    attacker = params.attacker;
    weapon = params.weapon;
    smeansofdeath = params.smeansofdeath;
    if (isdefined(params.laststandparams)) {
        attacker = params.laststandparams.attacker;
        weapon = params.laststandparams.weapon;
        smeansofdeath = params.laststandparams.smeansofdeath;
    }
    if (isplayer(attacker)) {
        itemindex = getitemindexfromref(weapon.name);
        if (itemindex == 0) {
            itemindex = getitemindexfromref(weapon.statname);
        }
        var_97dcd0a5 = getunlockableiteminfofromindex(itemindex, 1);
        if (isdefined(var_97dcd0a5)) {
            attackerid = attacker getentitynumber();
            self luinotifyevent(#"eliminator_info", 3, attackerid, 0, weapon.statindex);
        } else {
            self luinotifyevent(#"eliminator_info", 3, 0, function_4a856ead(smeansofdeath), 0);
        }
    } else {
        self luinotifyevent(#"eliminator_info", 3, 0, function_4a856ead(smeansofdeath), 0);
    }
    self function_e6f9e3cd();
    self.specialty = self getloadoutperks(0);
    self loadout::register_perks();
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x549db863, Offset: 0x35e0
// Size: 0x84
function on_item_pickup(params) {
    item = params.item;
    itementry = item.itementry;
    if (itementry.itemtype != #"dogtag") {
        return;
    }
    if (isfunctionptr(level.var_c4dc9178)) {
        item [[ level.var_c4dc9178 ]](self);
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0xa61c72ee, Offset: 0x3670
// Size: 0x150
function function_c14ef1aa(attacker) {
    if (getdvarint(#"hash_10c3f1c0958c1fba", 0) == 0) {
        return false;
    }
    if (!isdedicated()) {
        return false;
    }
    if (isalive(self)) {
        return false;
    }
    if (isdefined(self.switching_teams)) {
        return false;
    }
    if (isdefined(attacker) && attacker == self) {
        return false;
    }
    if (level.teambased && isdefined(attacker) && isdefined(attacker.team) && attacker.team == self.team) {
        return false;
    }
    if (isdefined(attacker) && (!isdefined(attacker.team) || attacker.team == #"none") && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
        return false;
    }
    return true;
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 9, eflags: 0x0
// Checksum 0x93e7ccaa, Offset: 0x37c8
// Size: 0x304
function player_killed(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    self clientfield::set_to_player("realtime_multiplay", 0);
    if (smeansofdeath == "MOD_META") {
        return;
    }
    if (is_true(level.droppedtagrespawn) && !is_true(getgametypesetting(#"useitemspawns"))) {
        thread dogtags::checkallowspectating();
        should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
        if (should_spawn_tags) {
            level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
        }
    }
    if (isplayer(attacker) && self function_c14ef1aa(attacker)) {
        encounterid = self getxuid(1) + attacker getxuid(1);
        self function_b096092b(encounterid);
        attacker function_b096092b(encounterid);
    }
    if (isplayer(attacker) && attacker.team != self.team) {
        if (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || is_true(level.killstreaksgivegamescore)) {
            attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
            self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);
            if (smeansofdeath == "MOD_HEAD_SHOT") {
                attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
            }
        }
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x414f5f3e, Offset: 0x3ad8
// Size: 0x104
function function_16e6bd2e(var_c1e98979) {
    gamemodedata = spawnstruct();
    gamemodedata.remainingtime = max(0, globallogic_utils::gettimeremaining());
    switch (var_c1e98979) {
    case 2:
        gamemodedata.wintype = "time_limit_reached";
        break;
    case 3:
        gamemodedata.wintype = "score_limit_reached";
        break;
    case 9:
    case 10:
    default:
        gamemodedata.wintype = "NA";
        break;
    }
    bb::function_bf5cad4e(gamemodedata);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0x683c73dc, Offset: 0x3be8
// Size: 0x80
function function_73b0f715(*player) {
    if (game.state != #"pregame") {
        return;
    }
    if (isdedicated()) {
        if (getdvarint(#"hash_41feb500743b0d15", 0) != 0) {
            return;
        }
    }
    level notify(#"hash_78e53817cafb5265");
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x5bd03642, Offset: 0x3c70
// Size: 0x10
function function_486a8395() {
    return !level.var_b02808b6;
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x3f714814, Offset: 0x3c88
// Size: 0x1e
function function_a3e209ba() {
    if (player_insertion::function_6660c1f()) {
        return false;
    }
    return true;
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0xdd8c5bc7, Offset: 0x3cb0
// Size: 0x6c
function function_aaa24662() {
    belowworldtrigger = getent("below_world_trigger", "targetname");
    if (!isentity(belowworldtrigger)) {
        return;
    }
    belowworldtrigger callback::on_trigger(&function_3c8be2d2);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x4
// Checksum 0x6405ff0e, Offset: 0x3d28
// Size: 0x264
function private function_1e150a0b(player) {
    if (!isplayer(player)) {
        assert(0);
        return;
    }
    var_9c24b065 = 5;
    var_2497d4aa = 100;
    var_9a5b8004 = 250;
    var_3a60655f = 100;
    var_50c30b0c = 250;
    var_5988a0d = 10000;
    var_85d40a8 = player.origin[2] + 500;
    startpos = (player.origin[0] + randomintrange(var_2497d4aa, var_9a5b8004), player.origin[1] + randomintrange(var_3a60655f, var_50c30b0c), var_5988a0d);
    endpos = (startpos[0], startpos[1], var_85d40a8);
    for (index = 0; index < var_9c24b065; index++) {
        var_708a2754 = physicstrace(startpos, endpos, (0, 0, 0), (0, 0, 0), player, 32);
        if (var_708a2754[#"fraction"] < 1) {
            player setorigin(var_708a2754[#"position"]);
            return;
        }
        startpos = (startpos[0] + randomintrange(var_2497d4aa, var_9a5b8004), startpos[1] + randomintrange(var_3a60655f, var_50c30b0c), var_5988a0d);
        endpos = (startpos[0], startpos[1], var_85d40a8);
    }
    player dodamage(player.health * 100, player.origin);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 2, eflags: 0x4
// Checksum 0xdb6f2fda, Offset: 0x3f98
// Size: 0x264
function private function_6ee52dd0(damage, damageinterval) {
    level flag::wait_till(#"insertion_teleport_completed");
    var_366959 = 0;
    var_1b5e849 = int(damageinterval * 1000);
    while (!is_true(level.gameended)) {
        time = gettime();
        foreach (i, player in getplayers()) {
            if (!isalive(player)) {
                continue;
            }
            if (!isdefined(player.var_21b83511)) {
                if (player ishidden() || player isinfreefall() || player isparachuting()) {
                    continue;
                }
                player.var_21b83511 = time + var_1b5e849;
                continue;
            }
            if (player.heal.enabled) {
                delta = player.var_21b83511 - time;
                player.var_21b83511 = time + delta;
                continue;
            }
            if (i % 10 == var_366959 && player.var_21b83511 < time) {
                player dodamage(damage, player.origin, undefined, undefined, undefined, "MOD_BLED_OUT");
                player.var_21b83511 = time + var_1b5e849;
            }
        }
        var_366959 = (var_366959 + 1) % 10;
        waitframe(1);
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 0, eflags: 0x0
// Checksum 0x1225aeec, Offset: 0x4208
// Size: 0x124
function function_77319881() {
    if (!is_true(level.spawnsystem.deathcirclerespawn)) {
        return;
    }
    level flag::set(#"spawning_allowed");
    /#
        function_cc5d43a1("<dev string:x688>");
    #/
    level player_reinsertion::function_fec68e5c();
    /#
        function_cc5d43a1("<dev string:x69c>");
    #/
    level flag::clear(#"spawning_allowed");
    waitframe(1);
    if (!util::function_47851c07()) {
        player_reinsertion::function_8ea9be1c();
        level callback::remove_callback(#"hash_3057417db7f8acdd", &function_77319881);
    }
}

/#

    // Namespace namespace_17baa64d/namespace_17baa64d
    // Params 1, eflags: 0x0
    // Checksum 0xe0dd6a23, Offset: 0x4338
    // Size: 0x3c
    function function_cc5d43a1(msg) {
        println(msg);
        adddebugcommand("<dev string:x6b1>");
    }

#/

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x0
// Checksum 0xb9a5182c, Offset: 0x4380
// Size: 0x24
function function_1f93e91f(*params) {
    util::function_8076d591("warSupplyDropIncoming");
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x4
// Checksum 0x653e7657, Offset: 0x43b0
// Size: 0x16c
function private function_293cd859(ent) {
    if (isplayer(ent)) {
        data = {#pos_x:ent.origin[0], #pos_y:ent.origin[1], #pos_z:ent.origin[2], #type:#"player"};
        function_92d1707f(#"hash_5820ed7a498888c4", data);
        return;
    }
    data = {#pos_x:ent.origin[0], #pos_y:ent.origin[1], #pos_z:ent.origin[2], #type:ent.model};
    function_92d1707f(#"hash_5820ed7a498888c4", data);
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x4
// Checksum 0xde86ae67, Offset: 0x4528
// Size: 0x140
function private function_3ca20639(vehicle) {
    occupants = vehicle getvehoccupants();
    foreach (occupant in occupants) {
        occupant unlink();
    }
    vehicle delete();
    foreach (occupant in occupants) {
        function_1e150a0b(occupant);
    }
}

// Namespace namespace_17baa64d/namespace_17baa64d
// Params 1, eflags: 0x4
// Checksum 0x8af36dc6, Offset: 0x4670
// Size: 0x3bc
function private function_3c8be2d2(trigger_struct) {
    level endon(#"game_ended");
    self endon(#"death");
    usetrigger = self;
    activator = trigger_struct.activator;
    if (isplayer(activator)) {
        /#
            iprintlnbold("<dev string:x6c0>" + activator.origin[0] + "<dev string:x6e8>" + activator.origin[1] + "<dev string:x6e8>" + activator.origin[2] + "<dev string:x6ee>");
        #/
        function_293cd859(activator);
        if (activator isinvehicle()) {
            vehicle = activator getvehicleoccupied();
            function_3ca20639(vehicle);
        } else {
            function_1e150a0b(activator);
        }
        return;
    }
    if (isvehicle(activator)) {
        /#
            iprintlnbold("<dev string:x6f3>" + activator.origin[0] + "<dev string:x6e8>" + activator.origin[1] + "<dev string:x6e8>" + activator.origin[2] + "<dev string:x6ee>");
            print("<dev string:x6f3>" + activator.origin[0] + "<dev string:x6e8>" + activator.origin[1] + "<dev string:x6e8>" + activator.origin[2] + "<dev string:x6ee>" + "<dev string:x71c>");
        #/
        function_293cd859(activator);
        function_3ca20639(activator);
        return;
    }
    if (isentity(activator)) {
        /#
            iprintlnbold("<dev string:x721>" + activator.origin[0] + "<dev string:x6e8>" + activator.origin[1] + "<dev string:x6e8>" + activator.origin[2] + "<dev string:x6ee>");
            print("<dev string:x721>" + activator.origin[0] + "<dev string:x6e8>" + activator.origin[1] + "<dev string:x6e8>" + activator.origin[2] + "<dev string:x6ee>" + "<dev string:x71c>");
        #/
        function_293cd859(activator);
        activator delete();
    }
}

