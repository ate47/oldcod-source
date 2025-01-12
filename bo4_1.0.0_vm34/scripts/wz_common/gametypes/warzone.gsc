#using script_164ba4a711296dd5;
#using script_59e751bcf51faec6;
#using script_693306f733341b42;
#using script_7a60382865b0c32f;
#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\music_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player_insertion;
#using scripts\core_common\rat_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\voice\voice_events;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\gameadvertisement;
#using scripts\mp_common\gametypes\display_transition;
#using scripts\mp_common\gametypes\dogtags;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\menus;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\laststand_warzone;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#using scripts\weapons\sensor_dart;
#using scripts\wz_common\player;
#using scripts\wz_common\vehicle;
#using scripts\wz_common\wz_ai;
#using scripts\wz_common\wz_ai_zonemgr;
#using scripts\wz_common\wz_progression;
#using scripts\wz_common\wz_rat;

#namespace warzone;

// Namespace warzone/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xc25cc1e, Offset: 0x478
// Size: 0x834
function event_handler[gametype_init] main(eventstruct) {
    level.var_cd383ec5 = 0;
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
    level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
    level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
    level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
    level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
    level.var_ba5bd3ee = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &on_start_game_type;
    level.onspawnplayer = &on_spawn_player;
    level.onroundswitch = &on_round_switch;
    level.onendround = &on_end_round;
    level.onendgame = &on_end_game;
    level.ondeadevent = &on_dead_event;
    level.ononeleftevent = &on_one_left_event;
    level.givecustomloadout = &give_custom_loadout;
    level.var_3c16bcb = &function_13637a21;
    level.var_8c85e786 = &function_8c85e786;
    level.var_2cff5def = 0;
    level.var_f591e76f = 0;
    level.var_30cb1d41 = 0;
    level.var_6a59f8eb = &function_a1e842c9;
    level.insertionpassenger = insertion_passenger_count::register("insertionPassengerElem");
    level.var_baf14e0 = &insertion_passenger_count::is_open;
    level.var_b9dc7c68 = &insertion_passenger_count::open;
    level.var_38dff31c = &insertion_passenger_count::close;
    level.var_2fd944bd = &insertion_passenger_count::set_count;
    level.deathZoneElem = death_zone::register("deathZoneElem");
    level.var_e6d0a17e = &death_zone::is_open;
    level.var_13af540a = &death_zone::open;
    level.var_36dfdb0e = &death_zone::close;
    level.var_bf65d627 = &death_zone::set_shutdown_sec;
    level.var_51eea74b = [];
    level.resurrect_override_spawn = &override_spawn;
    clientfield::register("worlduimodel", "hudItems.warzone.collapseTimerState", 1, 2, "int");
    clientfield::register("worlduimodel", "hudItems.warzone.collapseProgress", 1, 7, "float");
    clientfield::register("clientuimodel", "hudItems.distanceFromDeathCircle", 1, 7, "float");
    clientfield::register("clientuimodel", "hudItems.alivePlayerCount", 1, 7, "int");
    clientfield::register("clientuimodel", "hudItems.aliveTeammateCount", 1, 7, "int");
    clientfield::register("clientuimodel", "hudItems.spectatorsCount", 1, 7, "int");
    clientfield::register("clientuimodel", "hudItems.playerKills", 1, 7, "int");
    clientfield::register("clientuimodel", "presence.modeparam", 1, 7, "int");
    player::function_b0320e78(&player_killed);
    callback::on_player_killed(&on_player_killed);
    callback::on_spawned(&on_player_spawned);
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_game_playing(&start_warzone);
    globallogic_spawn::addsupportedspawnpointtype("tdm");
    function_6fb3fb65();
    level.var_36ef23d2 = &function_2de813ed;
    setdvar(#"g_allowlaststandforactiveclients", 1);
    setdvar(#"hash_7036719f41a78d54", 50);
    setdvar(#"hash_6d545f685fa213dd", 3);
    setdvar(#"scr_deleteexplosivesonspawn", 0);
    level.wound_disabled = 1;
    level thread function_e7215636();
    function_34e75cc5(10, 1600);
    globallogic_audio::set_leader_gametype_dialog("startWarzone", undefined, undefined, undefined);
    level.var_4afbefa2 = [];
    /#
        level.var_571dce92 = &function_4901c3d1;
        forcedplayerteam = getdvarstring(#"forcedplayerteam", "<dev string:x30>");
        if (forcedplayerteam != "<dev string:x30>") {
            level.forcedplayerteam = forcedplayerteam;
        }
        level thread function_6915e66a();
    #/
}

/#

    // Namespace warzone/warzone
    // Params 0, eflags: 0x4
    // Checksum 0xd8607af8, Offset: 0xcb8
    // Size: 0x108
    function private function_6915e66a() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x31>" + mapname + "<dev string:x3f>");
        while (true) {
            waitframe(1);
            string = getdvarstring(#"warzone_devgui_cmd", "<dev string:x30>");
            switch (string) {
            case #"start":
                function_4901c3d1();
                break;
            default:
                break;
            }
            setdvar(#"warzone_devgui_cmd", "<dev string:x30>");
        }
    }

#/

// Namespace warzone/warzone
// Params 3, eflags: 0x4
// Checksum 0xc5fe3e8c, Offset: 0xdc8
// Size: 0x84
function private function_cd15f4c6(var_e20c5661, playercount, var_c767388) {
    data = {#var_5384ea49:var_e20c5661, #var_dbce6386:playercount, #var_90ff33fa:var_c767388};
    function_b1f6086c(#"hash_7bcd081bd6940681", data);
}

// Namespace warzone/warzone
// Params 0, eflags: 0x4
// Checksum 0x333f3851, Offset: 0xe58
// Size: 0x7c0
function private function_e7215636() {
    while (!isdefined(game.state) || game.state != "pregame") {
        waitframe(1);
    }
    while (!isdefined(level.activeplayers)) {
        waitframe(1);
    }
    if (getdvarint(#"wz_test_mode", 0) != 0) {
        println("<dev string:x71>");
        level function_4901c3d1();
        return;
    }
    if (getdvarint(#"hash_2cc9b0ef1896d89a", 1) != 0) {
        println("<dev string:xa4>");
        return;
    }
    level endon(#"start_warzone");
    level.var_a129f03b = isdefined(getgametypesetting(#"hash_3bec501a2905266f")) ? getgametypesetting(#"hash_3bec501a2905266f") : 80;
    level.var_d80be6e7 = isdefined(getgametypesetting(#"hash_3a951d6ad1411b73")) ? getgametypesetting(#"hash_3a951d6ad1411b73") : 10;
    level.var_b89836ff = isdefined(getgametypesetting(#"hash_2c91798e3806740b")) ? getgametypesetting(#"hash_2c91798e3806740b") : 10;
    level.var_eba599 = isdefined(getgametypesetting(#"hash_36548858327b1d89")) ? getgametypesetting(#"hash_36548858327b1d89") : 60;
    level.var_6e687310 = isdefined(getgametypesetting(#"hash_ad6c0d1cd92c1fe")) ? getgametypesetting(#"hash_ad6c0d1cd92c1fe") : 10;
    level.var_617c2bef = isdefined(getgametypesetting(#"hash_7070772c64884d57")) ? getgametypesetting(#"hash_7070772c64884d57") : 5;
    if (level.var_eba599 <= 0) {
        level.var_eba599 = 1;
    }
    println("<dev string:xcd>" + gettime());
    var_db542181 = 3;
    level.var_32bd2da9 = level.var_a129f03b;
    starttime = gettime();
    level.var_354ac898 = spawnstruct();
    while (true) {
        if (level.activeplayers.size >= level.var_32bd2da9) {
            if (level.activeplayers.size < level.var_a129f03b) {
                println("<dev string:xe4>" + level.var_a129f03b + "<dev string:x120>" + level.activeplayers.size);
                level.var_354ac898.var_e39307df = level.activeplayers.size;
                level.var_354ac898.var_7198d0b5 = level.var_32bd2da9;
                level.var_354ac898.var_1e58f0c1 = level.var_a129f03b;
                if (level.var_6e687310 > 0) {
                    timeleft = level.var_6e687310;
                    println("<dev string:x12e>" + level.var_6e687310);
                    while (timeleft > 0) {
                        timeleft -= 1;
                        wait 1;
                        if (level.activeplayers.size == level.var_a129f03b) {
                            break;
                        }
                    }
                }
                level.var_354ac898.var_20d68242 = level.activeplayers.size - level.var_354ac898.var_e39307df;
            }
            if (level.activeplayers.size < level.var_32bd2da9) {
                wait 5;
                var_db542181 = 3;
                continue;
            }
            println("<dev string:x16c>");
            gameadvertisement::setadvertisedstatus(0);
            level.var_354ac898.duration = gettime() - starttime;
            println("<dev string:x18a>" + gettime());
            level function_4901c3d1();
            return;
        }
        if (level.var_617c2bef <= 0 && level.activeplayers.size < level.var_d80be6e7) {
            if (var_db542181 > 0) {
                wait 5;
                var_db542181--;
                println("<dev string:x1a1>" + var_db542181);
                continue;
            }
            function_cd15f4c6(gettime() - starttime, level.activeplayers.size, level.var_d80be6e7);
            println("<dev string:x1ba>" + gettime());
            exitlevel();
        }
        timeleft = level.var_eba599;
        while (timeleft > 0) {
            timeleft -= 1;
            wait 1;
            if (level.activeplayers.size >= level.var_32bd2da9) {
                break;
            }
        }
        println("<dev string:x1d4>");
        level.var_32bd2da9 -= level.var_b89836ff;
        if (level.var_32bd2da9 < 0) {
            level.var_32bd2da9 = 0;
        }
        if (level.var_617c2bef > 0) {
            level.var_617c2bef--;
        }
        println("<dev string:x1fb>" + level.var_32bd2da9);
        println("<dev string:x21d>" + level.var_617c2bef);
    }
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0xcf7e87aa, Offset: 0x1620
// Size: 0x27c
function on_start_game_type() {
    level.displayroundendtext = 0;
    level.usestartspawns = 0;
    level.var_77664dab = [];
    level thread function_7183d684();
    level.var_50c2ca68 = &function_6d06064f;
    laststand_warzone::function_e551580a(90, 150);
    laststand_warzone::function_e551580a(25, 150);
    laststand_warzone::function_e551580a(15, 150);
    voice_events::register_handler(#"warboostinfiltration", &function_f1e61cc2);
    voice_events::register_handler(#"warcircledetectedfirst", &function_f1e61cc2);
    voice_events::register_handler(#"warcircledetectedlast", &function_f1e61cc2);
    voice_events::register_handler(#"warcircledetected", &function_f1e61cc2);
    voice_events::register_handler(#"warcirclecollapseimminent", &function_f1e61cc2);
    voice_events::register_handler(#"warcirclecollapseoccurring", &function_f1e61cc2);
    voice_events::register_handler(#"warsupplydropincoming", &function_f1e61cc2);
    voice_events::register_handler(#"warteamwon", &function_f1e61cc2);
    voice_events::register_handler(#"warteamlost", &function_f1e61cc2);
    setdvar(#"hash_2b903fa2368b18c9", 0);
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x7a8a01b5, Offset: 0x18a8
// Size: 0xc4
function function_6d06064f() {
    /#
        if (getdvarint(#"hash_52908cf59a030701", 0)) {
            return;
        }
    #/
    level waittill(#"hash_78e53817cafb5265");
    if (isdefined(getgametypesetting(#"hash_69f74281cacb8a0f")) && getgametypesetting(#"hash_69f74281cacb8a0f")) {
        println("<dev string:x24b>");
        gameadvertisement::setadvertisedstatus(0);
    }
}

// Namespace warzone/warzone
// Params 0, eflags: 0x4
// Checksum 0xf2946aa1, Offset: 0x1978
// Size: 0x6e
function private start_insertion() {
    /#
        if (getdvarint(#"scr_disable_infiltration", 0)) {
            level flagsys::set(#"insertion_teleport_completed");
            return;
        }
    #/
    level player_insertion::function_23ed850a();
    level.var_36ef23d2 = undefined;
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x2c6c3ea2, Offset: 0x19f0
// Size: 0x1a0
function start_warzone() {
    level notify(#"start_warzone");
    function_52ef2d54();
    function_e729750();
    level thread function_4d29a1b8();
    level thread wz_ai::ai_init();
    level start_insertion();
    foreach (player in getplayers()) {
        player val::reset(#"warzonestaging", "takedamage");
    }
    if (isdefined(level.var_dafecba5)) {
        foreach (dest in level.var_dafecba5) {
            function_763b2da1(dest);
        }
    }
}

// Namespace warzone/warzone
// Params 0, eflags: 0x4
// Checksum 0x42bc4bef, Offset: 0x1b98
// Size: 0x64
function private function_4d29a1b8() {
    level flagsys::wait_till(#"insertion_teleport_completed");
    function_f7cb54cd();
    resetglass();
    level flagsys::set(#"hash_507a4486c4a79f1d");
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0xfe1dde20, Offset: 0x1c08
// Size: 0x64
function on_spawn_player(predictedspawn) {
    self.usingobj = undefined;
    if (level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn) {
        level.usestartspawns = 0;
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0xc2c43d46, Offset: 0x1c78
// Size: 0x86
function on_player_connect() {
    level function_cfff7b78();
    if (self function_7564f6bc()) {
        self waittill(#"spawned_player");
        self.pers[#"lives"] = level.var_c8bec28c < 1 ? 0 : level.var_c8bec28c - 1;
    }
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x24588e3d, Offset: 0x1d08
// Size: 0x1c
function on_player_disconnect() {
    level function_cfff7b78(self);
}

// Namespace warzone/warzone
// Params 2, eflags: 0x4
// Checksum 0x6aca1b08, Offset: 0x1d30
// Size: 0x188
function private function_7dd9c2c8(response, intpayload) {
    if (!isalive(self)) {
        return;
    }
    foreach (player in getplayers()) {
        if (player.team == self.team) {
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

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0xdc2b7125, Offset: 0x1ec0
// Size: 0x154
function on_player_spawned() {
    self endon(#"death");
    level endon(#"game_ended");
    self.var_667f8f08 = self.origin;
    level function_cfff7b78();
    if (game.state == "pregame") {
        self val::reset(#"spawn_player", "freezecontrols");
        self val::reset(#"spawn_player", "disablegadgets");
        self val::set(#"warzonestaging", "takedamage", 0);
    } else if (game.state == "playing" && !isbot(self)) {
        self player_insertion::function_9aa959c3();
    }
    self menus::register_menu_response_callback("WaypointPlaced", &function_7dd9c2c8);
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x878798c3, Offset: 0x2020
// Size: 0x4e
function on_player_killed() {
    if (isdefined(level.deathcircle) && level.deathcircle.radius <= level.var_8916946f) {
        self.pers[#"lives"] = 0;
    }
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x6d690d7a, Offset: 0x2078
// Size: 0x24
function on_round_switch() {
    gametype::on_round_switch();
    globallogic_score::updateteamscorebyroundswon();
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x3a368fdc, Offset: 0x20a8
// Size: 0x24
function on_end_round(var_c3d87d03) {
    function_3ff7dce9(var_c3d87d03);
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x326ee277, Offset: 0x20d8
// Size: 0x2a0
function on_dead_event(team) {
    level callback::callback(#"on_dead_event", team);
    if (team == "all") {
        foreach (team in level.teams) {
            if (isdefined(level.everexisted[team]) && level.everexisted[team] && !(isdefined(level.var_4afbefa2[team]) && level.var_4afbefa2[team]) && globallogic::isteamalldead(team)) {
                level thread globallogic_audio::function_18cbfc40("matchlose", team);
                globallogic_audio::leader_dialog("warTeamLost", team);
            }
        }
        round::set_flag("tie");
        thread globallogic::end_round(6);
        return;
    }
    if (isdefined(level.everexisted[team] != 0) && level.everexisted[team] != 0 && !(isdefined(level.var_4afbefa2[team]) && level.var_4afbefa2[team]) && globallogic::isteamalldead(team)) {
        level thread globallogic_audio::function_18cbfc40("matchlose", team);
        level.var_4afbefa2[team] = 1;
        globallogic_audio::leader_dialog("warTeamLost", team);
    }
    var_718021e5 = globallogic::function_4f9a4c7f();
    if (isdefined(var_718021e5)) {
        level thread globallogic_audio::function_18cbfc40("matchwin", var_718021e5);
        globallogic_audio::leader_dialog("warTeamWon", var_718021e5);
        [[ level.onlastteamaliveevent ]](var_718021e5);
    }
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x1038bbbe, Offset: 0x2380
// Size: 0xc2
function on_one_left_event(team) {
    if (team == "all") {
        return;
    }
    foreach (player in getplayers(team)) {
        if (isalive(player)) {
            player globallogic_audio::leader_dialog_on_player("warLastManStanding");
            return;
        }
    }
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x4b8619f6, Offset: 0x2450
// Size: 0x24
function function_8145ff5b() {
    death_circle::function_313433f();
    wz_ai_zonemgr::function_b64bfdab();
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x956007b3, Offset: 0x2480
// Size: 0xb8
function function_a986ce89(team) {
    foreach (player in getplayers(team)) {
        if (isalive(player)) {
            player match_record::set_player_stat(#"player_placement", 1);
        }
    }
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x2288050d, Offset: 0x2540
// Size: 0x1c4
function on_end_game(var_c3d87d03) {
    function_8145ff5b();
    foreach (team in level.teams) {
        foreach (player in getplayers(team)) {
            if (isalive(player) && !player laststand::player_is_in_laststand()) {
                match::function_622b7e5e(hash(team));
                wz_progression::function_b49628df(team);
                function_a986ce89(team);
                if (ispc()) {
                    player clientfield::set_to_player("RGB_keyboard_manager", 1);
                }
                return;
            }
        }
    }
    match::function_622b7e5e(undefined);
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0xab5ae0a, Offset: 0x2710
// Size: 0x74
function function_eac2457a(attacker) {
    player_counts = function_88b34120();
    if (isplayer(self)) {
        self match_record::set_player_stat(#"player_placement", player_counts[#"alive_players"] + 1);
    }
}

// Namespace warzone/warzone
// Params 9, eflags: 0x0
// Checksum 0x770f0488, Offset: 0x2790
// Size: 0x324
function player_killed(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (smeansofdeath == "MOD_META") {
        return;
    }
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        thread dogtags::checkallowspectating();
        should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
        if (should_spawn_tags) {
            level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
        }
    }
    teamranking = globallogic::function_be9037f8() + 1;
    self luinotifyevent(#"team_eliminated", 1, teamranking);
    if (isplayer(attacker) == 0 || attacker.team == self.team) {
        self luinotifyevent(#"eliminator_info", 3, 0, function_eee1f896(smeansofdeath), 0);
        return;
    }
    if (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
        attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
        self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
        }
    }
    self function_eac2457a(attacker);
    wz_progression::player_killed(attacker, self);
    self luinotifyevent(#"eliminator_info", 3, attacker.clientid, 0, weapon.statindex);
    level function_cfff7b78();
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x386d8d9f, Offset: 0x2ac0
// Size: 0x114
function function_3ff7dce9(var_c3d87d03) {
    gamemodedata = spawnstruct();
    gamemodedata.remainingtime = max(0, globallogic_utils::gettimeremaining());
    switch (var_c3d87d03) {
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
    bb::function_a4648ef4(gamemodedata);
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x8a577269, Offset: 0x2be0
// Size: 0x48
function function_4901c3d1(player = undefined) {
    if (game.state != "pregame") {
        return;
    }
    level notify(#"hash_78e53817cafb5265");
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0xf5cd3f4e, Offset: 0x2c30
// Size: 0x368
function function_7183d684() {
    destinations = struct::get_array("destination_influencer");
    if (destinations.size < 1) {
        return;
    }
    level.var_dafecba5 = [];
    /#
        if (getdvarint(#"hash_270a21a654a1a79f", 0)) {
            level.totalspawnpoints = [];
            foreach (destination in destinations) {
                level.totalspawnpoints = arraycombine(level.totalspawnpoints, struct::get_array(destination.target, "<dev string:x263>"), 0, 0);
            }
        }
    #/
    destinations = arraysortclosest(destinations, (0, 0, 0));
    var_2ce70617 = getdvarint(#"wz_dest_id", -1);
    if (var_2ce70617 == -1) {
        var_2ce70617 = function_8a95365d();
    }
    var_c1d2b984 = var_2ce70617 % destinations.size;
    var_3fe20eac = destinations[var_c1d2b984];
    arrayremoveindex(destinations, var_c1d2b984);
    level.var_dafecba5[0] = var_3fe20eac;
    if (destinations.size > 0) {
        destinations = arraysortclosest(destinations, var_3fe20eac.origin);
        lastindex = destinations.size - 1;
        level.var_dafecba5[1] = destinations[lastindex];
        arrayremoveindex(destinations, lastindex);
    }
    foreach (dest in level.var_dafecba5) {
        dest.spawns = struct::get_array(dest.target, "targetname");
    }
    foreach (dest in destinations) {
        function_763b2da1(dest);
    }
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x6afe19dc, Offset: 0x2fa0
// Size: 0x256
function override_spawn(ispredictedspawn) {
    if (!isdefined(level.var_dafecba5)) {
        return false;
    }
    if (level.var_dafecba5.size < 1) {
        self.resurrect_origin = (0, 0, 0);
        self.resurrect_angles = (0, 0, 0);
        return true;
    }
    teammask = getteammask(self.team);
    for (teamindex = 0; teammask > 1; teamindex++) {
        teammask >>= 1;
    }
    destindex = teamindex % level.var_dafecba5.size;
    dest = level.var_dafecba5[destindex];
    players = getplayers(self.team);
    var_d973b1dc = 0;
    foreach (player in players) {
        if (player != self && isdefined(player.hasspawned) && player.hasspawned) {
            var_d973b1dc++;
        }
    }
    var_72d6d5c9 = int(teamindex / level.var_dafecba5.size);
    spawnindex = var_72d6d5c9 * level.maxteamplayers + var_d973b1dc;
    spawnindex %= dest.spawns.size;
    spawn = dest.spawns[spawnindex];
    self.resurrect_origin = spawn.origin;
    self.resurrect_angles = spawn.angles;
    return true;
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0xb07a1e6d, Offset: 0x3200
// Size: 0xc4
function function_763b2da1(dest) {
    targets = struct::get_array(dest.target, "targetname");
    foreach (target in targets) {
        function_2c4c7ac(target);
    }
    function_2c4c7ac(dest);
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0xcc88bfd3, Offset: 0x32d0
// Size: 0xae
function function_2c4c7ac(struct) {
    if (!isarray(level.struct)) {
        return;
    }
    foreach (i, val in level.struct) {
        if (val === struct) {
            level.struct[i] = undefined;
            return;
        }
    }
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x686cd786, Offset: 0x3388
// Size: 0x152
function function_88b34120(disconnectedplayer) {
    players = getplayers();
    player_count = [];
    player_count[#"totalplayers"] = 0;
    player_count[#"alive_players"] = 0;
    player_count[#"spectators"] = 0;
    foreach (player in players) {
        if (disconnectedplayer === player) {
            continue;
        }
        player_count[#"totalplayers"]++;
        if (isalive(player)) {
            player_count[#"alive_players"]++;
        }
        if (player util::is_spectating()) {
            player_count[#"spectators"]++;
        }
    }
    return player_count;
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0x1f94a6e, Offset: 0x34e8
// Size: 0x238
function function_cfff7b78(disconnectedplayer) {
    player_counts = function_88b34120(disconnectedplayer);
    players = getplayers();
    foreach (player in players) {
        aliveplayercount = player_counts[#"alive_players"];
        player clientfield::set_player_uimodel("hudItems.alivePlayerCount", aliveplayercount);
        player clientfield::set_player_uimodel("presence.modeparam", aliveplayercount);
        player clientfield::set_player_uimodel("hudItems.spectatorsCount", player_counts[#"spectators"]);
        aliveteammates = 0;
        teammembers = getplayers(player.team);
        foreach (member in teammembers) {
            if (isalive(member) && member != player) {
                aliveteammates++;
            }
        }
        player clientfield::set_player_uimodel("hudItems.aliveTeammateCount", aliveteammates);
        player clientfield::set_player_uimodel("hudItems.playerKills", player.kills);
    }
}

// Namespace warzone/warzone
// Params 1, eflags: 0x0
// Checksum 0xca080d48, Offset: 0x3728
// Size: 0x2e8
function give_custom_loadout(takeoldweapon = 0) {
    self loadout::init_player(!takeoldweapon);
    if (takeoldweapon) {
        oldweapon = self getcurrentweapon();
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            self takeweapon(weapon);
        }
    }
    nullprimary = getweapon(#"null_offhand_primary");
    self giveweapon(nullprimary);
    self setweaponammoclip(nullprimary, 0);
    self switchtooffhand(nullprimary);
    healthgadget = getweapon(#"gadget_health_regen");
    self giveweapon(healthgadget);
    self setweaponammoclip(healthgadget, 0);
    self switchtooffhand(healthgadget);
    level.var_5a62046e = healthgadget;
    var_2545c87c = self gadgetgetslot(healthgadget);
    self gadgetpowerset(var_2545c87c, 0);
    bare_hands = getweapon(#"bare_hands");
    self giveweapon(bare_hands);
    self switchtoweapon(bare_hands, 1);
    if (self.firstspawn !== 0) {
        self setspawnweapon(bare_hands);
    }
    self.specialty = self getloadoutperks(self.class_num);
    self loadout::register_perks();
    return bare_hands;
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0xbce12bf0, Offset: 0x3a18
// Size: 0x14
function function_13637a21() {
    return level.numlives > 1;
}

// Namespace warzone/warzone
// Params 2, eflags: 0x4
// Checksum 0x44f54bf9, Offset: 0x3a38
// Size: 0x2c
function private function_f1e61cc2(event, params) {
    globallogic_audio::leader_dialog(event);
}

// Namespace warzone/warzone
// Params 2, eflags: 0x4
// Checksum 0x7e04b048, Offset: 0x3a70
// Size: 0x196
function private function_34e75cc5(lives = 0, minradius = 0) {
    level.var_c8bec28c = getdvarint(#"hash_75a049a5347c12f0", lives);
    level.var_8916946f = getdvarint(#"hash_755932e6f6392fa2", minradius);
    level.var_ea869ed6 = array("dyoung2", "botmonkey");
    var_45b3094c = getdvarstring(#"hash_76843dd3bcc6a825", "");
    var_620199db = strtok(var_45b3094c, ",");
    foreach (name in var_620199db) {
        level.var_ea869ed6[level.var_ea869ed6.size] = tolower(name);
    }
}

// Namespace warzone/warzone
// Params 0, eflags: 0x4
// Checksum 0xf231190d, Offset: 0x3c10
// Size: 0xaa
function private function_7564f6bc() {
    if (isbot(self)) {
        return 0;
    }
    name = self.name;
    var_e335697e = strtok(name, "]");
    if (var_e335697e.size > 1) {
        name = var_e335697e[1];
    }
    name = tolower(name);
    return isinarray(level.var_ea869ed6, name);
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x7ba3e73f, Offset: 0x3cc8
// Size: 0x1e
function function_8c85e786() {
    if (player_insertion::function_9d75b2d0()) {
        return false;
    }
    return true;
}

// Namespace warzone/warzone
// Params 0, eflags: 0x0
// Checksum 0x3b46318f, Offset: 0x3cf0
// Size: 0x6c
function function_6fb3fb65() {
    belowworldtrigger = getent("below_world_trigger", "targetname");
    if (!isentity(belowworldtrigger)) {
        return;
    }
    belowworldtrigger callback::on_trigger(&function_bda0200);
}

// Namespace warzone/warzone
// Params 1, eflags: 0x4
// Checksum 0x35c8e24e, Offset: 0x3d68
// Size: 0x28c
function private function_c48b27c9(player) {
    if (!isplayer(player)) {
        assert(0);
        return;
    }
    var_dc686e63 = 5;
    var_c8cd644c = 100;
    var_b3aebcb2 = 250;
    var_2d0b8597 = 100;
    var_f9bf0e9 = 250;
    var_e5d3ec30 = 10000;
    var_fe0dee97 = player.origin[2] + 500;
    startpos = (player.origin[0] + randomintrange(var_c8cd644c, var_b3aebcb2), player.origin[1] + randomintrange(var_2d0b8597, var_f9bf0e9), var_e5d3ec30);
    endpos = (startpos[0], startpos[1], var_fe0dee97);
    for (index = 0; index < var_dc686e63; index++) {
        var_b5a54b54 = physicstrace(startpos, endpos, (0, 0, 0), (0, 0, 0), player, 32);
        if (var_b5a54b54[#"fraction"] < 1) {
            player setorigin(var_b5a54b54[#"position"]);
            return;
        }
        startpos = (startpos[0] + randomintrange(var_c8cd644c, var_b3aebcb2), startpos[1] + randomintrange(var_2d0b8597, var_f9bf0e9), var_e5d3ec30);
        endpos = (startpos[0], startpos[1], var_fe0dee97);
    }
    player dodamage(player.health * 100, player.origin);
}

// Namespace warzone/warzone
// Params 1, eflags: 0x4
// Checksum 0x74e66835, Offset: 0x4000
// Size: 0x17c
function private function_5e1d7f26(ent) {
    if (isplayer(ent)) {
        data = {#pos_x:ent.origin[0], #pos_y:ent.origin[1], #pos_z:ent.origin[2], #type:#"player"};
        function_b1f6086c(#"hash_5820ed7a498888c4", data);
        return;
    }
    data = {#pos_x:ent.origin[0], #pos_y:ent.origin[1], #pos_z:ent.origin[2], #type:ent.model};
    function_b1f6086c(#"hash_5820ed7a498888c4", data);
}

// Namespace warzone/warzone
// Params 1, eflags: 0x4
// Checksum 0x7cad0321, Offset: 0x4188
// Size: 0x324
function private function_bda0200(trigger_struct) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    usetrigger = self;
    activator = trigger_struct.activator;
    if (isplayer(activator)) {
        /#
            iprintlnbold("<dev string:x26e>" + activator.origin[0] + "<dev string:x293>" + activator.origin[1] + "<dev string:x293>" + activator.origin[2] + "<dev string:x296>");
        #/
        function_5e1d7f26(activator);
        if (activator isinvehicle()) {
            vehicle = activator getvehicleoccupied();
            occupants = vehicle getvehoccupants();
            foreach (occupant in occupants) {
                occupant unlink();
            }
            vehicle delete();
            foreach (occupant in occupants) {
                function_c48b27c9(occupant);
            }
            return;
        }
        function_c48b27c9(activator);
        return;
    }
    if (isentity(activator)) {
        /#
            iprintlnbold("<dev string:x298>" + activator.origin[0] + "<dev string:x293>" + activator.origin[1] + "<dev string:x293>" + activator.origin[2] + "<dev string:x296>");
        #/
        function_5e1d7f26(activator);
        activator delete();
    }
}

// Namespace warzone/warzone
// Params 1, eflags: 0x4
// Checksum 0x4901feda, Offset: 0x44b8
// Size: 0x224
function private function_2de813ed(entity) {
    /#
        iprintlnbold("<dev string:x2bd>" + entity.origin[0] + "<dev string:x293>" + entity.origin[1] + "<dev string:x293>" + entity.origin[2] + "<dev string:x296>");
    #/
    if (entity isinvehicle()) {
        vehicle = entity getvehicleoccupied();
        occupants = vehicle getvehoccupants();
        foreach (occupant in occupants) {
            occupant unlink();
        }
        vehicle val::set(#"oob", "takedamage", 1);
        vehicle kill();
        foreach (occupant in occupants) {
            occupant setorigin(occupant.var_667f8f08);
        }
        return;
    }
    entity setorigin(entity.var_667f8f08);
}

// Namespace warzone/warzone
// Params 2, eflags: 0x4
// Checksum 0x6a920b6f, Offset: 0x46e8
// Size: 0xbe
function private function_a1e842c9(dart, owner) {
    dart endon(#"death");
    while (true) {
        if (isdefined(level.deathcircle)) {
            distsq = distance2dsquared(level.deathcircle.origin, dart.origin);
            if (distsq > level.deathcircle.radius * level.deathcircle.radius) {
                dart sensor_dart::function_95e3375a();
            }
        }
        wait 1;
    }
}

