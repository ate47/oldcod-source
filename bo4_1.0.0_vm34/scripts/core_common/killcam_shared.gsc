#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\weapons\tacticalinsertion;

#namespace killcam;

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x2
// Checksum 0xb0673be8, Offset: 0x218
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"killcam", &__init__, undefined, undefined);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xab016616, Offset: 0x260
// Size: 0x114
function __init__() {
    callback::on_start_gametype(&init);
    clientfield::register("clientuimodel", "hudItems.killcamAllowRespawn", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.voteKillcamSkip", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.voteProgress", 1, 5, "float");
    clientfield::register("clientuimodel", "hudItems.voteCommitted", 1, 4, "int");
    clientfield::register("clientuimodel", "hudItems.voteRequired", 1, 4, "int");
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x4bfc40b1, Offset: 0x380
// Size: 0x6c
function init() {
    level.killcam = getgametypesetting(#"allowkillcam");
    level.finalkillcam = getgametypesetting(#"allowfinalkillcam");
    init_final_killcam();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xb5f924d1, Offset: 0x3f8
// Size: 0x16
function end_killcam() {
    self notify(#"end_killcam");
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0xe2e73568, Offset: 0x418
// Size: 0x68
function get_killcam_entity_start_time(killcamentity) {
    killcamentitystarttime = 0;
    if (isdefined(killcamentity)) {
        if (isdefined(killcamentity.starttime)) {
            killcamentitystarttime = killcamentity.starttime;
        } else {
            killcamentitystarttime = killcamentity.birthtime;
        }
        if (!isdefined(killcamentitystarttime)) {
            killcamentitystarttime = 0;
        }
    }
    return killcamentitystarttime;
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x1b043227, Offset: 0x488
// Size: 0x5a
function store_killcam_entity_on_entity(killcam_entity) {
    assert(isdefined(killcam_entity));
    self.killcamentitystarttime = get_killcam_entity_start_time(killcam_entity);
    self.killcamentityindex = killcam_entity getentitynumber();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x9d17d824, Offset: 0x4f0
// Size: 0xc6
function init_final_killcam() {
    level.finalkillcamsettings = [];
    init_final_killcam_team(#"none");
    foreach (team, _ in level.teams) {
        init_final_killcam_team(team);
    }
    level.finalkillcam_winner = undefined;
    level.finalkillcam_winnerpicked = undefined;
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x4ab3f2a8, Offset: 0x5c0
// Size: 0x44
function init_final_killcam_team(team) {
    level.finalkillcamsettings[team] = spawnstruct();
    clear_final_killcam_team(team);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x21f99f88, Offset: 0x610
// Size: 0x116
function clear_final_killcam_team(team) {
    level.finalkillcamsettings[team].spectatorclient = undefined;
    level.finalkillcamsettings[team].weapon = undefined;
    level.finalkillcamsettings[team].meansofdeath = undefined;
    level.finalkillcamsettings[team].deathtime = undefined;
    level.finalkillcamsettings[team].deathtimeoffset = undefined;
    level.finalkillcamsettings[team].offsettime = undefined;
    level.finalkillcamsettings[team].killcam_entity_info = undefined;
    level.finalkillcamsettings[team].targetentityindex = undefined;
    level.finalkillcamsettings[team].perks = undefined;
    level.finalkillcamsettings[team].killstreaks = undefined;
    level.finalkillcamsettings[team].attacker = undefined;
}

// Namespace killcam/killcam_shared
// Params 11, eflags: 0x0
// Checksum 0xa4aa602b, Offset: 0x730
// Size: 0x396
function record_settings(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker) {
    if (isdefined(attacker) && isdefined(attacker.team) && isdefined(level.teams[attacker.team])) {
        team = attacker.team;
        level.finalkillcamsettings[team].spectatorclient = spectatorclient;
        level.finalkillcamsettings[team].weapon = weapon;
        level.finalkillcamsettings[team].meansofdeath = meansofdeath;
        level.finalkillcamsettings[team].deathtime = deathtime;
        level.finalkillcamsettings[team].deathtimeoffset = deathtimeoffset;
        level.finalkillcamsettings[team].offsettime = offsettime;
        level.finalkillcamsettings[team].killcam_entity_info = killcam_entity_info;
        level.finalkillcamsettings[team].targetentityindex = targetentityindex;
        level.finalkillcamsettings[team].perks = perks;
        level.finalkillcamsettings[team].killstreaks = killstreaks;
        level.finalkillcamsettings[team].attacker = attacker;
    }
    level.finalkillcamsettings[#"none"].spectatorclient = spectatorclient;
    level.finalkillcamsettings[#"none"].weapon = weapon;
    level.finalkillcamsettings[#"none"].meansofdeath = meansofdeath;
    level.finalkillcamsettings[#"none"].deathtime = deathtime;
    level.finalkillcamsettings[#"none"].deathtimeoffset = deathtimeoffset;
    level.finalkillcamsettings[#"none"].offsettime = offsettime;
    level.finalkillcamsettings[#"none"].killcam_entity_info = killcam_entity_info;
    level.finalkillcamsettings[#"none"].targetentityindex = targetentityindex;
    level.finalkillcamsettings[#"none"].perks = perks;
    level.finalkillcamsettings[#"none"].killstreaks = killstreaks;
    level.finalkillcamsettings[#"none"].attacker = attacker;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x3196a22e, Offset: 0xad0
// Size: 0xb6
function erase_final_killcam() {
    clear_final_killcam_team(#"none");
    foreach (team, _ in level.teams) {
        clear_final_killcam_team(team);
    }
    level.finalkillcam_winner = undefined;
    level.finalkillcam_winnerpicked = undefined;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x7b399214, Offset: 0xb90
// Size: 0x2c
function final_killcam_waiter() {
    if (level.finalkillcam_winnerpicked === 1) {
        level waittill(#"final_killcam_done");
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xef72a2d0, Offset: 0xbc8
// Size: 0x3c
function post_round_final_killcam() {
    if (!level.finalkillcam) {
        return;
    }
    level notify(#"play_final_killcam");
    final_killcam_waiter();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xede2d2f6, Offset: 0xc10
// Size: 0x4c
function function_5a897061() {
    if (potm::function_8720246()) {
        println("<dev string:x30>");
        return;
    }
    post_round_final_killcam();
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0xac6a0c15, Offset: 0xc68
// Size: 0x70
function function_193bf9a3(winner) {
    if (!isdefined(winner)) {
        return #"none";
    }
    if (isentity(winner)) {
        return (isdefined(winner.team) ? winner.team : #"none");
    }
    return winner;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xcc138517, Offset: 0xce0
// Size: 0x110
function function_a15b9453() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    level endon(#"final_killcam_done");
    while (true) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        if (menu == "PlayOfTheMatchWidget") {
            if (isplayer(self) && response == "voteSkip") {
                self.var_264d351 = 1;
                self clientfield::set_player_uimodel("hudItems.voteKillcamSkip", 1);
                return;
            }
        }
        waitframe(1);
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x59737542, Offset: 0xdf8
// Size: 0x2e6
function function_603ed677() {
    level endon(#"game_ended");
    level endon(#"final_killcam_done");
    numplayers = 0;
    foreach (player in level.players) {
        if (!isbot(player)) {
            numplayers++;
        }
    }
    var_13c9a1ef = numplayers;
    foreach (player in level.players) {
        player clientfield::set_player_uimodel("hudItems.voteRequired", var_13c9a1ef);
    }
    while (true) {
        var_9861a377 = 0;
        foreach (player in level.players) {
            if (isdefined(player.var_264d351) && player.var_264d351) {
                var_9861a377++;
            }
        }
        foreach (player in level.players) {
            player clientfield::set_player_uimodel("hudItems.voteCommitted", var_9861a377);
        }
        waitframe(1);
        if (var_9861a377 >= var_13c9a1ef) {
            foreach (player in level.players) {
                player function_2beac224();
            }
            return;
        }
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x5e1f06bb, Offset: 0x10e8
// Size: 0xdc
function function_b2d43336() {
    foreach (player in level.players) {
        player.var_264d351 = 0;
        player clientfield::set_player_uimodel("hudItems.voteKillcamSkip", 0);
        if (!isbot(player)) {
            player thread function_a15b9453();
        }
    }
    level thread function_603ed677();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xc45efd6, Offset: 0x11d0
// Size: 0x29e
function do_final_killcam() {
    level waittill(#"play_final_killcam");
    if (!util::waslastround()) {
        function_b2d43336();
    }
    setslowmotion(1, 1, 0);
    level.infinalkillcam = 1;
    winner = #"none";
    if (isdefined(level.finalkillcam_winner)) {
        winner = level.finalkillcam_winner;
    }
    winning_team = function_193bf9a3(winner);
    if (!isdefined(level.finalkillcamsettings[winning_team].targetentityindex)) {
        level.infinalkillcam = 0;
        level notify(#"final_killcam_done");
        return;
    }
    attacker = level.finalkillcamsettings[winning_team].attacker;
    if (isdefined(attacker) && isdefined(attacker.archetype) && attacker.archetype == "mannequin") {
        level.infinalkillcam = 0;
        level notify(#"final_killcam_done");
        return;
    }
    if (isdefined(attacker)) {
        challenges::getfinalkill(attacker);
    }
    visionsetnaked("default", 0);
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        if (!ispc()) {
            player closeingamemenu();
        }
        player thread final_killcam(winner);
    }
    wait 0.1;
    while (are_any_players_watching()) {
        waitframe(1);
    }
    level notify(#"final_killcam_done");
    level.infinalkillcam = 0;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x1a1fd2b2, Offset: 0x1478
// Size: 0x6e
function are_any_players_watching() {
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        if (isdefined(player.killcam)) {
            return true;
        }
    }
    return false;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xbf84a221, Offset: 0x14f0
// Size: 0x4c
function watch_for_skip_killcam() {
    self endon(#"begin_killcam");
    self waittill(#"disconnect", #"spawned");
    waitframe(1);
    level.numplayerswaitingtoenterkillcam--;
}

// Namespace killcam/killcam_shared
// Params 14, eflags: 0x0
// Checksum 0x64ffaa2c, Offset: 0x1548
// Size: 0x6da
function killcam(attackernum, targetnum, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, respawn, maxtime, perks, killstreaks, attacker, keep_deathcam) {
    self endon(#"disconnect");
    self endon(#"spawned");
    level endon(#"game_ended");
    if (attackernum < 0) {
        return;
    }
    self thread watch_for_skip_killcam();
    level.numplayerswaitingtoenterkillcam++;
    assert(level.numplayerswaitingtoenterkillcam < 20);
    if (level.numplayerswaitingtoenterkillcam > 1) {
        println("<dev string:x76>");
        waitframe(level.numplayerswaitingtoenterkillcam - 1);
    }
    waitframe(1);
    level.numplayerswaitingtoenterkillcam--;
    assert(level.numplayerswaitingtoenterkillcam > -1);
    postdeathdelay = float(gettime() - deathtime) / 1000;
    predelay = postdeathdelay + deathtimeoffset;
    killcamentitystarttime = get_killcam_entity_info_starttime(killcam_entity_info);
    camtime = calc_time(weapon, killcamentitystarttime, predelay, maxtime);
    postdelay = calc_post_delay();
    killcamlength = camtime + postdelay;
    if (isdefined(maxtime) && killcamlength > maxtime) {
        if (maxtime < 2) {
            return;
        }
        if (maxtime - camtime >= 1) {
            postdelay = maxtime - camtime;
        } else {
            postdelay = 1;
            camtime = maxtime - 1;
        }
        killcamlength = camtime + postdelay;
    }
    killcamoffset = camtime + predelay;
    self notify(#"begin_killcam", {#start_time:gettime()});
    self util::clientnotify("sndDEDe");
    killcamstarttime = gettime() - int(killcamoffset * 1000);
    self.sessionstate = "spectator";
    self.spectatekillcam = 1;
    self.spectatorclient = attackernum;
    self.killcamentity = -1;
    self thread set_killcam_entities(killcam_entity_info, killcamstarttime);
    self.killcamtargetentity = targetnum;
    self.killcamweapon = weapon;
    self.killcammod = meansofdeath;
    self.archivetime = killcamoffset;
    self.killcamlength = killcamlength;
    self.psoffsettime = offsettime;
    foreach (team, _ in level.teams) {
        self allowspectateteam(team, 1);
    }
    self allowspectateteam("freelook", 1);
    self allowspectateteam(#"none", 1);
    self callback::function_1dea870d(#"on_end_game", &on_end_game);
    waitframe(1);
    if (self.archivetime <= predelay) {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        self end_killcam();
        return;
    }
    self thread check_for_abrupt_end();
    self.killcam = 1;
    self function_62ea5b06(respawn);
    /#
        if (!self issplitscreen() && level.perksenabled == 1) {
            self hud::showperks();
        }
    #/
    self thread spawned_killcam_cleanup();
    self thread wait_skip_killcam_button();
    self thread function_a34016eb();
    self thread wait_team_change_end_killcam();
    self thread wait_killcam_time();
    self thread tacticalinsertion::cancel_button_think();
    self waittill(#"end_killcam");
    self end(0);
    if (isdefined(keep_deathcam) && keep_deathcam) {
        return;
    }
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0x6d9c3d51, Offset: 0x1c30
// Size: 0x7a
function set_entity(killcamentityindex, delayms) {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    self endon(#"spawned");
    if (delayms > 0) {
        wait float(delayms) / 1000;
    }
    self.killcamentity = killcamentityindex;
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0x23304c84, Offset: 0x1cb8
// Size: 0x9c
function set_killcam_entities(entity_info, killcamstarttime) {
    for (index = 0; index < entity_info.entity_indexes.size; index++) {
        delayms = entity_info.entity_spawntimes[index] - killcamstarttime - 100;
        thread set_entity(entity_info.entity_indexes[index], delayms);
        if (delayms <= 0) {
            return;
        }
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x18b736a8, Offset: 0x1d60
// Size: 0x5c
function wait_killcam_time() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    self endon(#"begin_killcam");
    wait self.killcamlength - 0.05;
    self end_killcam();
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0x36699c8f, Offset: 0x1dc8
// Size: 0x134
function wait_final_killcam_slowdown(deathtime, starttime) {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    secondsuntildeath = float(deathtime - starttime) / 1000;
    deathtime = gettime() + int(secondsuntildeath * 1000);
    waitbeforedeath = 2;
    wait max(0, secondsuntildeath - waitbeforedeath);
    util::setclientsysstate("levelNotify", "sndFKsl");
    setslowmotion(1, 0.25, waitbeforedeath);
    wait waitbeforedeath + 0.5;
    setslowmotion(0.25, 1, 1);
    wait 0.5;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x4db5c31e, Offset: 0x1f08
// Size: 0x7c
function function_2beac224() {
    if (!isdefined(self.killcamsskipped)) {
        self.killcamsskipped = 0;
    }
    self.killcamsskipped++;
    self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
    self end_killcam();
    self util::clientnotify("fkce");
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x760d54db, Offset: 0x1f90
// Size: 0x94
function wait_skip_killcam_button() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (self usebuttonpressed()) {
        waitframe(1);
    }
    while (!self usebuttonpressed()) {
        waitframe(1);
    }
    if (!(isdefined(self.var_a65a4ffc) && self.var_a65a4ffc)) {
        function_2beac224();
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x23b08e79, Offset: 0x2030
// Size: 0x94
function function_a34016eb() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (self jumpbuttonpressed()) {
        waitframe(1);
    }
    while (!self jumpbuttonpressed()) {
        waitframe(1);
    }
    if (!(isdefined(self.var_a65a4ffc) && self.var_a65a4ffc)) {
        function_2beac224();
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x7f57b5e9, Offset: 0x20d0
// Size: 0x74
function wait_team_change_end_killcam() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    self waittill(#"changed_class", #"joined_team");
    end(0);
    self end_killcam();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x36c54a, Offset: 0x2150
// Size: 0x8c
function wait_skip_killcam_safe_spawn_button() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (self fragbuttonpressed()) {
        waitframe(1);
    }
    while (!self fragbuttonpressed()) {
        waitframe(1);
    }
    self.wantsafespawn = 1;
    self end_killcam();
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x29e56ebe, Offset: 0x21e8
// Size: 0x8c
function end(final) {
    self.killcam = undefined;
    self callback::function_1f42556c(#"on_end_game", &on_end_game);
    self callback::function_1f42556c(#"on_end_game", &function_ee1db574);
    self thread spectating::set_permissions();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x6e83eb53, Offset: 0x2280
// Size: 0x64
function check_for_abrupt_end() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (true) {
        if (self.archivetime <= 0) {
            break;
        }
        waitframe(1);
    }
    self end_killcam();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x5018faa8, Offset: 0x22f0
// Size: 0x54
function spawned_killcam_cleanup() {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    self waittill(#"spawned");
    self end(0);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x38081375, Offset: 0x2350
// Size: 0xbc
function spectator_killcam_cleanup(attacker) {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    attacker endon(#"disconnect");
    waitresult = attacker waittill(#"begin_killcam");
    waittime = max(0, waitresult.start_time - self.deathtime - 50);
    wait waittime;
    self end(0);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xfdb63629, Offset: 0x2418
// Size: 0x30
function on_end_game() {
    self end(0);
    self [[ level.spawnspectator ]](0);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x4a0237c9, Offset: 0x2450
// Size: 0x1c
function function_ee1db574() {
    self end(1);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xf451b4a9, Offset: 0x2478
// Size: 0x1a
function cancel_use_button() {
    return self usebuttonpressed();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x2c8884fc, Offset: 0x24a0
// Size: 0x1a
function cancel_safe_spawn_button() {
    return self fragbuttonpressed();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xe3151f4f, Offset: 0x24c8
// Size: 0x12
function cancel_callback() {
    self.cancelkillcam = 1;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x5a2928f7, Offset: 0x24e8
// Size: 0x1e
function cancel_safe_spawn_callback() {
    self.cancelkillcam = 1;
    self.wantsafespawn = 1;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x1833e7f9, Offset: 0x2510
// Size: 0x34
function cancel_on_use() {
    self thread cancel_on_use_specific_button(&cancel_use_button, &cancel_callback);
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0x5755b8c7, Offset: 0x2550
// Size: 0x124
function cancel_on_use_specific_button(pressingbuttonfunc, finishedfunc) {
    self endon(#"death_delay_finished");
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        if (!self [[ pressingbuttonfunc ]]()) {
            waitframe(1);
            continue;
        }
        buttontime = 0;
        while (self [[ pressingbuttonfunc ]]()) {
            buttontime += 0.05;
            waitframe(1);
        }
        if (buttontime >= 0.5) {
            continue;
        }
        buttontime = 0;
        while (!self [[ pressingbuttonfunc ]]() && buttontime < 0.5) {
            buttontime += 0.05;
            waitframe(1);
        }
        if (buttontime >= 0.5) {
            continue;
        }
        self [[ finishedfunc ]]();
        return;
    }
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0xc8938456, Offset: 0x2680
// Size: 0x3e2
function final_killcam_internal(winner) {
    winning_team = function_193bf9a3(winner);
    killcamsettings = level.finalkillcamsettings[winning_team];
    postdeathdelay = float(gettime() - killcamsettings.deathtime) / 1000;
    predelay = postdeathdelay + killcamsettings.deathtimeoffset;
    killcamentitystarttime = get_killcam_entity_info_starttime(killcamsettings.killcam_entity_info);
    camtime = calc_time(killcamsettings.weapon, killcamentitystarttime, predelay, undefined);
    postdelay = calc_post_delay();
    killcamoffset = camtime + predelay;
    killcamlength = camtime + postdelay - 0.05;
    killcamstarttime = gettime() - int(killcamoffset * 1000);
    self notify(#"begin_killcam", {#start_time:gettime()});
    util::setclientsysstate("levelNotify", "sndFKs");
    self.sessionstate = "spectator";
    self.spectatorclient = killcamsettings.spectatorclient;
    self.killcamentity = -1;
    self thread set_killcam_entities(killcamsettings.killcam_entity_info, killcamstarttime);
    self.killcamtargetentity = killcamsettings.targetentityindex;
    self.killcamweapon = killcamsettings.weapon;
    self.killcammod = killcamsettings.meansofdeath;
    self.archivetime = killcamoffset;
    self.killcamlength = killcamlength;
    self.psoffsettime = killcamsettings.offsettime;
    self allowspectateallteams(1);
    self allowspectateteam("freelook", 1);
    self allowspectateteam(#"none", 1);
    self callback::function_1dea870d(#"on_end_game", &function_ee1db574);
    waitframe(1);
    if (self.archivetime <= predelay) {
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        self end_killcam();
        return;
    }
    self thread check_for_abrupt_end();
    self.killcam = 1;
    self thread wait_killcam_time();
    self thread wait_final_killcam_slowdown(level.finalkillcamsettings[winning_team].deathtime, killcamstarttime);
    self waittill(#"end_killcam");
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0xe5ceba9a, Offset: 0x2a70
// Size: 0x254
function final_killcam(winner) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    if (util::waslastround()) {
        setmatchflag("final_killcam", 1);
        setmatchflag("round_end_killcam", 0);
    } else {
        setmatchflag("final_killcam", 0);
        setmatchflag("round_end_killcam", 1);
    }
    /#
        if (getdvarint(#"scr_force_finalkillcam", 0) == 1) {
            setmatchflag("<dev string:xb1>", 1);
            setmatchflag("<dev string:xbf>", 0);
        }
    #/
    /#
        while (getdvarint(#"scr_endless_finalkillcam", 0) == 1) {
            final_killcam_internal(winner);
        }
    #/
    final_killcam_internal(winner);
    util::setclientsysstate("levelNotify", "sndFKe");
    luinotifyevent(#"post_killcam_transition");
    self val::set(#"killcam", "freezecontrols", 1);
    self end(1);
    setmatchflag("final_killcam", 0);
    setmatchflag("round_end_killcam", 0);
    self spawn_end_of_final_killcam();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x14a0b4c5, Offset: 0x2cd0
// Size: 0x1c
function spawn_end_of_final_killcam() {
    self visionset_mgr::player_shutdown();
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x7daeae30, Offset: 0x2cf8
// Size: 0x30
function is_entity_weapon(weapon) {
    if (weapon.name == #"planemortar") {
        return true;
    }
    return false;
}

// Namespace killcam/killcam_shared
// Params 4, eflags: 0x0
// Checksum 0xd3206c7f, Offset: 0x2d30
// Size: 0x142
function calc_time(weapon, entitystarttime, predelay, maxtime) {
    camtime = 0;
    if (getdvarstring(#"scr_killcam_time") == "") {
        if (is_entity_weapon(weapon)) {
            camtime = float(gettime() - entitystarttime) / 1000 - predelay - 0.1;
        } else if (weapon.isgrenadeweapon) {
            camtime = 4.25;
        } else {
            camtime = 2.5;
        }
    } else {
        camtime = getdvarfloat(#"scr_killcam_time", 0);
    }
    if (isdefined(maxtime)) {
        if (camtime > maxtime) {
            camtime = maxtime;
        }
        if (camtime < 0.05) {
            camtime = 0.05;
        }
    }
    return camtime;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xbec48641, Offset: 0x2e80
// Size: 0x8e
function calc_post_delay() {
    postdelay = 0;
    if (getdvarstring(#"scr_killcam_posttime") == "") {
        postdelay = 2;
    } else {
        postdelay = getdvarfloat(#"scr_killcam_posttime", 0);
        if (postdelay < 0.05) {
            postdelay = 0.05;
        }
    }
    return postdelay;
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x215d6b29, Offset: 0x2f18
// Size: 0x2c
function function_62ea5b06(respawn) {
    self clientfield::set_player_uimodel("hudItems.killcamAllowRespawn", respawn);
}

// Namespace killcam/killcam_shared
// Params 3, eflags: 0x0
// Checksum 0xb7c938a7, Offset: 0x2f50
// Size: 0x1ea
function get_closest_killcam_entity(attacker, killcamentities, depth = 0) {
    closestkillcament = undefined;
    closestkillcamentindex = undefined;
    closestkillcamentdist = undefined;
    origin = undefined;
    foreach (killcamentindex, killcament in killcamentities) {
        if (killcament == attacker) {
            continue;
        }
        origin = killcament.origin;
        if (isdefined(killcament.offsetpoint)) {
            origin += killcament.offsetpoint;
        }
        dist = distancesquared(self.origin, origin);
        if (!isdefined(closestkillcament) || dist < closestkillcamentdist) {
            closestkillcament = killcament;
            closestkillcamentdist = dist;
            closestkillcamentindex = killcamentindex;
        }
    }
    if (depth < 3 && isdefined(closestkillcament)) {
        if (!bullettracepassed(closestkillcament.origin, self.origin, 0, self)) {
            killcamentities[closestkillcamentindex] = undefined;
            betterkillcament = get_closest_killcam_entity(attacker, killcamentities, depth + 1);
            if (isdefined(betterkillcament)) {
                closestkillcament = betterkillcament;
            }
        }
    }
    return closestkillcament;
}

// Namespace killcam/killcam_shared
// Params 3, eflags: 0x0
// Checksum 0x1e4730ef, Offset: 0x3148
// Size: 0x2e6
function get_killcam_entity(attacker, einflictor, weapon) {
    if (!isdefined(einflictor)) {
        return undefined;
    }
    if (isdefined(self.killcamkilledbyent)) {
        return self.killcamkilledbyent;
    }
    if (einflictor == attacker) {
        if (isai(einflictor)) {
            return einflictor;
        }
        if (!isdefined(einflictor.ismagicbullet)) {
            return undefined;
        }
        if (isdefined(einflictor.ismagicbullet) && !einflictor.ismagicbullet) {
            return undefined;
        }
    } else if (isdefined(level.levelspecifickillcam)) {
        levelspecifickillcament = self [[ level.levelspecifickillcam ]]();
        if (isdefined(levelspecifickillcament)) {
            return levelspecifickillcament;
        }
    }
    if (weapon.name == #"hero_gravityspikes") {
        return undefined;
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker isremotecontrolling() && (einflictor.controlled === 1 || einflictor.occupied === 1)) {
        if (weapon.name == #"sentinel_turret" || weapon.name == #"amws_gun_turret_mp_player" || weapon.name == #"auto_gun_turret") {
            return undefined;
        }
    }
    if (weapon.name == #"dart") {
        return undefined;
    }
    if (isdefined(einflictor.killcament)) {
        if (einflictor.killcament == attacker) {
            return undefined;
        }
        return einflictor.killcament;
    } else if (isdefined(einflictor.killcamentities)) {
        return get_closest_killcam_entity(attacker, einflictor.killcamentities);
    }
    if (isdefined(einflictor.script_gameobjectname) && einflictor.script_gameobjectname == "bombzone") {
        return einflictor.killcament;
    }
    if (isai(attacker)) {
        return attacker;
    }
    if (isplayer(attacker)) {
        if (attacker function_80cbd71f()) {
            return undefined;
        }
    }
    return einflictor;
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0xb98759ea, Offset: 0x3438
// Size: 0x86
function get_secondary_killcam_entity(entity, entity_info) {
    if (!isdefined(entity) || !isdefined(entity.killcamentityindex)) {
        return;
    }
    entity_info.entity_indexes[entity_info.entity_indexes.size] = entity.killcamentityindex;
    entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = entity.killcamentitystarttime;
}

// Namespace killcam/killcam_shared
// Params 4, eflags: 0x0
// Checksum 0xe18b9dca, Offset: 0x34c8
// Size: 0xf4
function get_primary_killcam_entity(attacker, einflictor, weapon, entity_info) {
    killcamentity = self get_killcam_entity(attacker, einflictor, weapon);
    killcamentitystarttime = get_killcam_entity_start_time(killcamentity);
    killcamentityindex = -1;
    if (isdefined(killcamentity)) {
        killcamentityindex = killcamentity getentitynumber();
    }
    entity_info.entity_indexes[entity_info.entity_indexes.size] = killcamentityindex;
    entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = killcamentitystarttime;
    get_secondary_killcam_entity(killcamentity, entity_info);
}

// Namespace killcam/killcam_shared
// Params 3, eflags: 0x0
// Checksum 0x953a827b, Offset: 0x35c8
// Size: 0x70
function get_killcam_entity_info(attacker, einflictor, weapon) {
    entity_info = spawnstruct();
    entity_info.entity_indexes = [];
    entity_info.entity_spawntimes = [];
    get_primary_killcam_entity(attacker, einflictor, weapon, entity_info);
    return entity_info;
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x9034c6e0, Offset: 0x3640
// Size: 0x44
function get_killcam_entity_info_starttime(entity_info) {
    if (entity_info.entity_spawntimes.size == 0) {
        return 0;
    }
    return entity_info.entity_spawntimes[entity_info.entity_spawntimes.size - 1];
}

