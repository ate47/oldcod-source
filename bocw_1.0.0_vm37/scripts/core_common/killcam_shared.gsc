#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace killcam;

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x6
// Checksum 0x8bd5efbc, Offset: 0x190
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"killcam", &preinit, undefined, undefined, undefined);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x4
// Checksum 0x4283479e, Offset: 0x1d8
// Size: 0x24
function private preinit() {
    callback::on_start_gametype(&init);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xaeccdee7, Offset: 0x208
// Size: 0xd4
function init() {
    level.killcammode = getgametypesetting(#"killcammode");
    level.finalkillcam = getgametypesetting(#"allowfinalkillcam");
    level.killcamtime = getgametypesetting(#"killcamtime");
    level.var_a95350da = getgametypesetting(#"hash_154db5a1b2e9d757");
    level.var_7abccc83 = !sessionmodeiswarzonegame();
    init_final_killcam();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x7cb12e8c, Offset: 0x2e8
// Size: 0x3c
function end_killcam() {
    self.spectatorclient = -1;
    self notify(#"end_killcam");
    self setmodellodbias(0);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x50d7511e, Offset: 0x330
// Size: 0x3c
function function_2f7579f(weaponnamehash) {
    if (!isdefined(level.var_ef3352fc)) {
        level.var_ef3352fc = [];
    }
    level.var_ef3352fc[weaponnamehash] = 1;
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x4f208949, Offset: 0x378
// Size: 0x60
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
// Checksum 0xe0435589, Offset: 0x3e0
// Size: 0x5a
function store_killcam_entity_on_entity(killcam_entity) {
    assert(isdefined(killcam_entity));
    self.killcamentitystarttime = get_killcam_entity_start_time(killcam_entity);
    self.killcamentityindex = killcam_entity getentitynumber();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x27cd8751, Offset: 0x448
// Size: 0xce
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
// Checksum 0xbe87ac6e, Offset: 0x520
// Size: 0x3c
function init_final_killcam_team(team) {
    level.finalkillcamsettings[team] = spawnstruct();
    clear_final_killcam_team(team);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0xfd5c7dbe, Offset: 0x568
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
// Checksum 0x494dd238, Offset: 0x688
// Size: 0x36e
function record_settings(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker) {
    if (!isdefined(level.finalkillcamsettings)) {
        return;
    }
    if (isdefined(attacker.team) && isdefined(attacker) && isdefined(level.teams[attacker.team])) {
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
// Params 11, eflags: 0x0
// Checksum 0xf9ae1d8e, Offset: 0xa00
// Size: 0x14e
function function_eb3deeec(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker) {
    player = self;
    if (spectatorclient == -1) {
        spectatorclient = player getentitynumber();
    }
    player.var_e59bd911 = {#spectatorclient:spectatorclient, #weapon:weapon, #meansofdeath:meansofdeath, #deathtime:deathtime, #deathtimeoffset:deathtimeoffset, #offsettime:offsettime, #killcam_entity_info:killcam_entity_info, #targetentityindex:targetentityindex, #perks:perks, #killstreaks:killstreaks, #attacker:attacker};
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x90de4aaa, Offset: 0xb58
// Size: 0xc
function has_deathcam() {
    return isdefined(self.var_e59bd911);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x6e6d7ae1, Offset: 0xb70
// Size: 0xa8
function start_deathcam() {
    if (!self has_deathcam()) {
        self.sessionstate = "spectator";
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        return false;
    }
    if (is_true(self.var_e5681505)) {
        return false;
    }
    self thread deathcam(self);
    return true;
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x962cf59f, Offset: 0xc20
// Size: 0x1de
function deathcam(victim) {
    self endon(#"disconnect");
    self.var_e5681505 = 1;
    self clientfield::set_player_uimodel("hudItems.killcamActive", 1);
    s = victim.var_e59bd911;
    self killcam(s.spectatorclient, s.targetentityindex, s.killcam_entity_info, s.weapon, s.meansofdeath, s.deathtime, s.deathtimeoffset, s.offsettime, 0, undefined, s.perks, s.killstreaks, s.attacker, 0);
    var_9a73aefe = self.currentspectatingclient;
    self stopfollowing();
    if (var_9a73aefe >= 0) {
        var_e1f8d08d = getentbynum(var_9a73aefe);
        if (isdefined(var_e1f8d08d)) {
            self setcurrentspectatorclient(var_e1f8d08d);
        }
    }
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self luinotifyevent(#"hash_5b2d65a026de792d", 0);
    self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
    self.var_e5681505 = undefined;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x9c31be29, Offset: 0xe08
// Size: 0xbe
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
// Checksum 0x217dfce8, Offset: 0xed0
// Size: 0x2c
function final_killcam_waiter() {
    if (level.finalkillcam_winnerpicked === 1) {
        level waittill(#"final_killcam_done");
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x21676351, Offset: 0xf08
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
// Checksum 0x27ab8970, Offset: 0xf50
// Size: 0x4c
function function_a26057ee() {
    if (potm::function_ec01de3()) {
        println("<dev string:x38>");
        return;
    }
    post_round_final_killcam();
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0xc653ff33, Offset: 0xfa8
// Size: 0x70
function function_de2b637d(winner) {
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
// Checksum 0x1a8c5344, Offset: 0x1020
// Size: 0x26c
function do_final_killcam() {
    level waittill(#"play_final_killcam");
    setslowmotion(1, 1, 0);
    level.infinalkillcam = 1;
    winner = #"none";
    if (isdefined(level.finalkillcam_winner)) {
        winner = level.finalkillcam_winner;
    }
    winning_team = function_de2b637d(winner);
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
        if (!player function_8b1a219a()) {
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
// Checksum 0xa8c9d06d, Offset: 0x1298
// Size: 0x64
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
// Checksum 0x26d5d772, Offset: 0x1308
// Size: 0x4c
function watch_for_skip_killcam() {
    self endon(#"begin_killcam");
    self waittill(#"disconnect", #"spawned");
    waitframe(1);
    level.numplayerswaitingtoenterkillcam--;
}

// Namespace killcam/killcam_shared
// Params 14, eflags: 0x0
// Checksum 0x7fdadf89, Offset: 0x1360
// Size: 0x7f2
function killcam(attackernum, targetnum, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, *respawn, maxtime, *perks, *killstreaks, *attacker, keep_deathcam) {
    self endon(#"disconnect", #"spawned", #"game_ended");
    if (meansofdeath < 0) {
        return;
    }
    self thread watch_for_skip_killcam();
    self callback::function_52ac9652(#"on_end_game", &on_end_game, undefined, 1);
    self callback::function_d8abfc3d(#"on_end_game", &on_end_game);
    level.numplayerswaitingtoenterkillcam++;
    if (level.numplayerswaitingtoenterkillcam > 1) {
        println("<dev string:x81>");
        waitframe(level.numplayerswaitingtoenterkillcam - 1);
    }
    waitframe(1);
    level.numplayerswaitingtoenterkillcam--;
    if (!function_7f088568()) {
        println("<dev string:xbf>");
        while (!function_7f088568()) {
            waitframe(1);
        }
    }
    assert(level.numplayerswaitingtoenterkillcam > -1);
    postdeathdelay = float(gettime() - maxtime) / 1000;
    predelay = postdeathdelay + perks;
    killcamentitystarttime = get_killcam_entity_info_starttime(deathtimeoffset);
    camtime = calc_time(offsettime, killcamentitystarttime, predelay, attacker, deathtimeoffset.var_30f79181);
    postdelay = calc_post_delay();
    killcamlength = camtime + postdelay;
    if (isdefined(attacker) && killcamlength > attacker) {
        if (attacker < 2) {
            return;
        }
        if (attacker - camtime >= 1) {
            postdelay = attacker - camtime;
        } else {
            postdelay = 1;
            camtime = attacker - 1;
        }
        killcamlength = camtime + postdelay;
    }
    killcamoffset = camtime + predelay;
    self notify(#"begin_killcam", {#start_time:gettime()});
    if (isdefined(offsettime) && offsettime.name === #"straferun_rockets") {
        self setmodellodbias(8);
    }
    self util::clientnotify("sndDEDe");
    killcamstarttime = gettime() - int(killcamoffset * 1000);
    self.sessionstate = "spectator";
    self.spectatekillcam = 1;
    self.spectatorclient = meansofdeath;
    self.killcamentity = -1;
    self thread set_killcam_entities(deathtimeoffset, killcamstarttime);
    self.killcamtargetentity = deathtime;
    self.killcamweapon = offsettime;
    self.killcammod = respawn;
    self.archivetime = killcamoffset;
    self.killcamlength = killcamlength;
    self.psoffsettime = killstreaks;
    /#
        if (getdvarfloat(#"hash_475a5a67154785d", -1) >= 0) {
            self.killcamlength = max(0.5, min(self.killcamlength, getdvarfloat(#"hash_475a5a67154785d", -1)));
        }
    #/
    foreach (team, _ in level.teams) {
        self allowspectateteam(team, 1);
    }
    self allowspectateteam("freelook", 1);
    self allowspectateteam(#"none", 1);
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
    /#
        if (!self issplitscreen() && level.perksenabled == 1) {
            self hud::showperks();
        }
    #/
    self thread spawned_killcam_cleanup();
    self thread wait_skip_killcam_button();
    self thread function_fa405b23();
    self thread wait_team_change_end_killcam();
    self thread wait_killcam_time();
    if (isdefined(level.var_60ac2c9)) {
        self thread [[ level.var_60ac2c9 ]]();
    }
    self waittill(#"end_killcam");
    self end(0);
    if (is_true(keep_deathcam)) {
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
// Checksum 0xfd290c5f, Offset: 0x1b60
// Size: 0x7a
function set_entity(killcamentityindex, delayms) {
    self endon(#"disconnect", #"end_killcam", #"spawned");
    if (delayms > 0) {
        wait float(delayms) / 1000;
    }
    self.killcamentity = killcamentityindex;
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0x62dfffaf, Offset: 0x1be8
// Size: 0x92
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
// Checksum 0xdcd510a0, Offset: 0x1c88
// Size: 0x5c
function wait_killcam_time() {
    self endon(#"disconnect", #"end_killcam", #"begin_killcam");
    wait self.killcamlength - 0.05;
    self end_killcam();
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0x87b7d4ac, Offset: 0x1cf0
// Size: 0x134
function wait_final_killcam_slowdown(deathtime, starttime) {
    self endon(#"disconnect", #"end_killcam");
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
// Checksum 0xabc77df6, Offset: 0x1e30
// Size: 0x7c
function function_875fc588() {
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
// Checksum 0xadead78a, Offset: 0x1eb8
// Size: 0x9c
function wait_skip_killcam_button() {
    self endon(#"disconnect", #"end_killcam");
    while (self usebuttonpressed()) {
        waitframe(1);
    }
    while (!self usebuttonpressed()) {
        waitframe(1);
    }
    if (!is_true(self.var_eca4c67f)) {
        function_875fc588();
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x32ac62b5, Offset: 0x1f60
// Size: 0x9c
function function_fa405b23() {
    self endon(#"disconnect", #"end_killcam");
    while (self jumpbuttonpressed()) {
        waitframe(1);
    }
    while (!self jumpbuttonpressed()) {
        waitframe(1);
    }
    if (!is_true(self.var_eca4c67f)) {
        function_875fc588();
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x1c638086, Offset: 0x2008
// Size: 0x74
function wait_team_change_end_killcam() {
    self endon(#"disconnect", #"end_killcam");
    self waittill(#"changed_class", #"joined_team");
    end(0);
    self end_killcam();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x7cf7ef1e, Offset: 0x2088
// Size: 0x8c
function wait_skip_killcam_safe_spawn_button() {
    self endon(#"disconnect", #"end_killcam");
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
// Checksum 0x229fc62b, Offset: 0x2120
// Size: 0x8c
function end(*final) {
    self.killcam = undefined;
    self callback::function_52ac9652(#"on_end_game", &on_end_game);
    self callback::function_52ac9652(#"on_end_game", &function_f5f2d8e6);
    self thread spectating::set_permissions();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x81cf6b8a, Offset: 0x21b8
// Size: 0x64
function check_for_abrupt_end() {
    self endon(#"disconnect", #"end_killcam");
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
// Checksum 0xa79b3ea, Offset: 0x2228
// Size: 0x54
function spawned_killcam_cleanup() {
    self endon(#"end_killcam", #"disconnect");
    self waittill(#"spawned");
    self end(0);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0xfe100c85, Offset: 0x2288
// Size: 0xbc
function spectator_killcam_cleanup(attacker) {
    self endon(#"end_killcam", #"disconnect");
    attacker endon(#"disconnect");
    waitresult = attacker waittill(#"begin_killcam");
    waittime = max(0, waitresult.start_time - self.deathtime - 50);
    wait waittime;
    self end(0);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x2397f39, Offset: 0x2350
// Size: 0x50
function on_end_game() {
    if (level.var_7abccc83) {
        self notify(#"game_ended");
        self end(0);
        self [[ level.spawnspectator ]](0);
    }
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x16e35efe, Offset: 0x23a8
// Size: 0x2c
function function_f5f2d8e6() {
    self notify(#"game_ended");
    self end(1);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xd437ca6b, Offset: 0x23e0
// Size: 0x1a
function cancel_use_button() {
    return self usebuttonpressed();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xacddf929, Offset: 0x2408
// Size: 0x1a
function cancel_safe_spawn_button() {
    return self fragbuttonpressed();
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x236ca2c7, Offset: 0x2430
// Size: 0x12
function cancel_callback() {
    self.cancelkillcam = 1;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x7412ec6f, Offset: 0x2450
// Size: 0x1e
function cancel_safe_spawn_callback() {
    self.cancelkillcam = 1;
    self.wantsafespawn = 1;
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0x957407c6, Offset: 0x2478
// Size: 0x34
function cancel_on_use() {
    self thread cancel_on_use_specific_button(&cancel_use_button, &cancel_callback);
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0x5ccdd266, Offset: 0x24b8
// Size: 0x120
function cancel_on_use_specific_button(pressingbuttonfunc, finishedfunc) {
    self endon(#"death_delay_finished", #"disconnect", #"game_ended");
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
// Checksum 0xb91a556f, Offset: 0x25e0
// Size: 0x3d2
function final_killcam_internal(winner) {
    winning_team = function_de2b637d(winner);
    killcamsettings = level.finalkillcamsettings[winning_team];
    postdeathdelay = float(gettime() - killcamsettings.deathtime) / 1000;
    predelay = postdeathdelay + killcamsettings.deathtimeoffset;
    killcamentitystarttime = get_killcam_entity_info_starttime(killcamsettings.killcam_entity_info);
    camtime = calc_time(killcamsettings.weapon, killcamentitystarttime, predelay, undefined, killcamsettings.killcam_entity_info.var_30f79181);
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
    self callback::function_d8abfc3d(#"on_end_game", &function_f5f2d8e6);
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
// Checksum 0xb2c857f3, Offset: 0x29c0
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
            setmatchflag("<dev string:xe7>", 1);
            setmatchflag("<dev string:xf8>", 0);
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
// Checksum 0x5c71cd07, Offset: 0x2c20
// Size: 0x1c
function spawn_end_of_final_killcam() {
    self visionset_mgr::player_shutdown();
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0xe32dd526, Offset: 0x2c48
// Size: 0x30
function is_entity_weapon(weapon) {
    if (weapon.statname == #"planemortar") {
        return true;
    }
    return false;
}

// Namespace killcam/killcam_shared
// Params 5, eflags: 0x0
// Checksum 0xd0ff4410, Offset: 0x2c80
// Size: 0x156
function calc_time(weapon, entitystarttime, predelay, maxtime, var_30f79181) {
    camtime = 0;
    if (getdvarstring(#"scr_killcam_time") == "") {
        if (is_entity_weapon(weapon) || var_30f79181 === 1) {
            camtime = float(gettime() - entitystarttime) / 1000 - predelay - 0.1;
        } else if (weapon.isgrenadeweapon) {
            camtime = level.var_a95350da;
        } else {
            camtime = level.killcamtime;
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
// Checksum 0x8528a2c3, Offset: 0x2de0
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
// Params 3, eflags: 0x0
// Checksum 0x59f1dcd1, Offset: 0x2e78
// Size: 0x1da
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
// Checksum 0x852e76d3, Offset: 0x3060
// Size: 0x3a8
function get_killcam_entity(attacker, einflictor, weapon) {
    if (!isdefined(einflictor)) {
        return undefined;
    }
    if (isdefined(self.killcamkilledbyent)) {
        return self.killcamkilledbyent;
    }
    if (isdefined(level.var_93a0cd8f[weapon.name])) {
        var_3808f6bd = level [[ level.var_93a0cd8f[weapon.name] ]](attacker, einflictor);
        if (isdefined(var_3808f6bd)) {
            return var_3808f6bd;
        }
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
        if (einflictor.killcament == attacker || is_true(attacker.var_5c5fca5)) {
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
    if (isplayer(attacker) && isvehicle(einflictor)) {
        if (attacker getvehicleoccupied() === einflictor) {
            if (!attacker isremotecontrolling() || is_true(attacker.var_5c5fca5)) {
                return undefined;
            }
        }
    }
    return einflictor;
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0xefab1d1b, Offset: 0x3410
// Size: 0x70
function get_secondary_killcam_entity(entity, entity_info) {
    if (!isdefined(entity) || !isdefined(entity.killcamentityindex)) {
        return;
    }
    entity_info.entity_indexes[entity_info.entity_indexes.size] = entity.killcamentityindex;
    entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = entity.killcamentitystarttime;
}

// Namespace killcam/killcam_shared
// Params 4, eflags: 0x0
// Checksum 0x3a823234, Offset: 0x3488
// Size: 0x1d4
function get_primary_killcam_entity(attacker, einflictor, weapon, entity_info) {
    killcamentity = self get_killcam_entity(attacker, einflictor, weapon);
    if (isdefined(level.var_ef3352fc) && isdefined(level.var_ef3352fc[weapon.name])) {
        if (isdefined(einflictor) && isdefined(einflictor.owner) && isdefined(einflictor.owner.killcament)) {
            killcamentity store_killcam_entity_on_entity(einflictor.owner.killcament);
        }
    }
    killcamentitystarttime = get_killcam_entity_start_time(killcamentity);
    killcamentityindex = -1;
    if (isdefined(killcamentity)) {
        killcamentityindex = killcamentity getentitynumber();
    } else {
        var_a5dd317c = self function_af5b3411();
        if (isdefined(var_a5dd317c)) {
            killcamentityindex = var_a5dd317c;
            killcamentitystarttime = self function_cefc1515() - 750;
            if (killcamentitystarttime < 0) {
                killcamentitystarttime = 0;
            }
            entity_info.var_30f79181 = 1;
        }
    }
    entity_info.entity_indexes[entity_info.entity_indexes.size] = killcamentityindex;
    entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = killcamentitystarttime;
    get_secondary_killcam_entity(killcamentity, entity_info);
}

// Namespace killcam/killcam_shared
// Params 3, eflags: 0x0
// Checksum 0x8efcfc04, Offset: 0x3668
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
// Checksum 0xfdbab336, Offset: 0x36e0
// Size: 0x40
function get_killcam_entity_info_starttime(entity_info) {
    if (entity_info.entity_spawntimes.size == 0) {
        return 0;
    }
    return entity_info.entity_spawntimes[entity_info.entity_spawntimes.size - 1];
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0x8584cdd6, Offset: 0x3728
// Size: 0x24
function function_4789a39a(weaponname, func) {
    level.var_93a0cd8f[weaponname] = func;
}

