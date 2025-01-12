#using script_52d2de9b438adc78;
#using script_702b73ee97d18efe;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\draft;
#using scripts\mp_common\dynamic_loadout;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\laststand;
#using scripts\mp_common\pickup_ammo;
#using scripts\mp_common\pickup_health;
#using scripts\mp_common\player\player_killed;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;

#namespace bounty;

// Namespace bounty/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x90bf6d70, Offset: 0x5d0
// Size: 0x9fc
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 500);
    util::registerroundlimit(0, 12);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.overrideteamscore = 1;
    level.var_3626d83c = 1;
    level.var_4ec8f819 = 1;
    level.takelivesondeath = 1;
    level.var_eedab0b0 = 1;
    level.endgameonscorelimit = 0;
    level.scoreroundwinbased = 1;
    level.var_a62f76a1 = 1;
    level.var_f4b44a8a = 1;
    level.var_4a4ff0d5 = 1;
    level.var_83469c04 = 1;
    if (!isdefined(game.var_23ae85e6)) {
        game.var_23ae85e6 = getgametypesetting(#"hash_2847dbf50c74391f");
    }
    level.var_5ad77f69 = getgametypesetting(#"bountypurchasephaseduration");
    level.var_818200f0 = getgametypesetting(#"hash_63f088c667689f40");
    level.var_4795ccd4 = getgametypesetting(#"hash_32995dae734b94b6");
    level.var_8998e12a = getgametypesetting(#"hash_561be47168b4e674");
    level.var_42f58464 = getgametypesetting(#"hash_2270a3136e7cd914");
    level.var_83f0508d = getgametypesetting(#"hash_48a1a06a8787b8d5");
    level.var_886d23a9 = getgametypesetting(#"bountystartmoney");
    level.var_1543ee60 = getgametypesetting(#"hash_57fb5c079ad2fb7a");
    level.var_1f133895 = getgametypesetting(#"hash_b5542a4bc9afce9");
    level.var_9f490fb = getgametypesetting(#"hash_b3a34a4bc841d67");
    if (level.var_1f133895 > level.var_9f490fb) {
        var_48fdea1a = level.var_9f490fb;
        level.var_9f490fb = level.var_1f133895;
        level.var_1f133895 = var_48fdea1a;
    }
    if (level.var_1f133895 == level.var_9f490fb) {
        level.var_9f490fb += 0.001;
    }
    assert(level.var_1f133895 <= level.var_9f490fb);
    level.var_b89bb1c = max(getgametypesetting(#"hash_381587a813feab3e"), 1);
    level.bountydepositsitecapturetime = max(getgametypesetting(#"bountydepositsitecapturetime"), 1);
    level.var_f73dd0cd = getgametypesetting(#"hash_3ffec9399ef7052f");
    level.var_dd94719f = getgametypesetting(#"hash_6aba2f652c6f4e07");
    level.var_3be08e47 = getgametypesetting(#"hash_926bf70c5a0d23b");
    level.var_1572b8b7 = getgametypesetting(#"hash_3da025c068c34bcb");
    level.var_434d8dd9 = getgametypesetting(#"hash_1e3a29a0321c9293");
    level.var_fcd18873 = getgametypesetting(#"hash_78e49b8491ad6446");
    level.var_1fd62126 = getgametypesetting(#"hash_63f8d60d122e755b");
    level.var_fe755201 = getgametypesetting(#"hash_45ff0effd8383bae");
    level.var_9048dd5 = getgametypesetting(#"hash_ef8682282bd2e10");
    level.var_d8c58ed = getgametypesetting(#"bountybagomoneymovescale");
    level.var_3d16bbd7 = getgametypesetting(#"bountydepositextratime");
    level.var_b77af8d7 = getgametypesetting(#"bountybagomoneymoney");
    level.var_dd32a91 = level.var_b77af8d7;
    level.laststandhealth = getgametypesetting(#"laststandhealth");
    level.laststandtimer = getgametypesetting(#"laststandtimer");
    level.var_dc454b18 = getgametypesetting(#"hash_4462b9c231538fc9");
    if (level.var_dc454b18) {
        level.var_3112b67c = getgametypesetting(#"hash_74efbd1bd1ee6413");
    }
    level.decayprogress = isdefined(getgametypesetting(#"decayprogress")) ? getgametypesetting(#"decayprogress") : 0;
    level.autodecaytime = isdefined(getgametypesetting(#"autodecaytime")) ? getgametypesetting(#"autodecaytime") : undefined;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.ondeadevent = &ondeadevent;
    level.ontimelimit = &ontimelimit;
    level.ononeleftevent = &ononeleftevent;
    level.onroundswitch = &onroundswitch;
    level.var_a9a13a28 = &function_a9a13a28;
    level.var_60230117 = &function_60230117;
    level.var_80d46925 = &function_80d46925;
    player::function_b0320e78(&onplayerkilled);
    callback::on_connect(&onconnect);
    callback::on_spawned(&onspawned);
    callback::on_player_damage(&onplayerdamage);
    laststand_mp::function_e2cfa34c(&function_903bfc03);
    laststand_mp::function_499f611d(&onplayerrevived);
    setdvar(#"g_allowlaststandforactiveclients", 1);
    setdvar(#"hash_7036719f41a78d54", getgametypesetting(#"laststandrevivehealth"));
    clientfield::register("allplayers", "bountymoneytrail", 1, 1, "int");
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xb6b6d85f, Offset: 0xfd8
// Size: 0x35c
function private onconnect() {
    waitframe(1);
    if (!isdefined(self.pers[#"money"])) {
        self.pers[#"money"] = level.var_886d23a9;
        self.pers[#"money_earned"] = 0;
        if (game.roundsplayed > 0) {
            numteammates = 0;
            var_7253bb3a = 0;
            foreach (player in level.players) {
                if (player == self) {
                    continue;
                }
                if (!isdefined(player.pers[#"money_earned"])) {
                    continue;
                }
                if (player.team == self.team) {
                    numteammates++;
                    var_7253bb3a += player.pers[#"money_earned"];
                }
            }
            if (numteammates) {
                self function_ee6e4e8a(int(var_7253bb3a / numteammates));
            }
        }
    }
    if (level.var_dc454b18 && !isdefined(self.pers[#"dynamic_loadout"].weapons[1])) {
        self.pers[#"dynamic_loadout"].weapons[1] = spawnstruct();
        self.pers[#"dynamic_loadout"].weapons[1].name = #"pistol_standard_t8";
        self.pers[#"dynamic_loadout"].weapons[1].attachments = [];
        self.pers[#"dynamic_loadout"].weapons[1].ammo = -1;
        self.pers[#"dynamic_loadout"].weapons[1].startammo = level.var_3112b67c;
        dynamic_loadout::function_49b19715(1, "luielement.BountyHunterLoadout.secondary", 7);
    }
    self clientfield::set_to_player("bountyMoney", self.pers[#"money"]);
    if (level.draftstage != 3) {
        draft::assign_remaining_players(self);
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xf723050f, Offset: 0x1340
// Size: 0x9c
function private onspawned() {
    self clientfield::set_to_player("bountyMoney", self.pers[#"money"]);
    if (isdefined(level.purchasephase) && level.purchasephase) {
        self freezecontrols(1);
        self thread function_7c9ca17c();
        self setlowready(1);
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x6ca03ebc, Offset: 0x13e8
// Size: 0x44
function private function_7c9ca17c() {
    self endon(#"death", #"disconnect");
    waitframe(1);
    self function_7ba60bfe();
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x9f58c5b7, Offset: 0x1438
// Size: 0x2ec
function private onstartgametype() {
    globallogic_spawn::addsupportedspawnpointtype("bounty");
    globallogic_spawn::addspawns();
    level.alwaysusestartspawns = 1;
    foreach (team, _ in level.teams) {
        level.var_710cc7bb[team] = 1;
        level.var_1c4b75ec[team] = 1;
    }
    thread function_f619b4d4();
    level thread function_7db0515a();
    var_4f39fd4c = game.roundsplayed + 1;
    if (var_4f39fd4c == game.var_23ae85e6) {
        game.var_23ae85e6 += getgametypesetting(#"hash_7e30d3849ca91b60");
        thread function_3f49423b();
    }
    level.var_ffea59c = function_c502e8c9();
    thread function_d4c3f73d();
    if (level.scoreroundwinbased) {
        [[ level._setteamscore ]](#"allies", game.stat[#"roundswon"][#"allies"]);
        [[ level._setteamscore ]](#"axis", game.stat[#"roundswon"][#"axis"]);
    }
    laststand_mp::function_e551580a(level.laststandtimer, level.laststandhealth);
    level.var_2c2e3dd5 = struct::get_script_bundle("killstreak", #"killstreak_bounty_deposit_site_heli");
    function_7e4fa139();
    function_1953b3cb();
    level thread function_9233d35c(1.5);
    /#
        level thread function_fae6617b();
    #/
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0xed264bdb, Offset: 0x1730
// Size: 0x24
function private onspawnplayer(predictedspawn) {
    spawning::onspawnplayer(predictedspawn);
}

// Namespace bounty/bounty
// Params 0, eflags: 0x0
// Checksum 0x4be26da6, Offset: 0x1760
// Size: 0x88
function function_a61cc4f0() {
    self endon(#"death");
    self endon(#"revived");
    while (isdefined(self)) {
        if (self function_77dc119d()) {
            self dodamage(10000, self.origin, undefined, undefined, undefined, "MOD_UNKNOWN", 0, level.shockrifleweapon);
            return;
        }
        waitframe(1);
    }
}

// Namespace bounty/bounty
// Params 5, eflags: 0x4
// Checksum 0x39834069, Offset: 0x17f0
// Size: 0x1ac
function private function_903bfc03(attacker, victim, inflictor, weapon, meansofdeath) {
    if (attacker == self) {
        return;
    }
    var_fe11b7ad = 0;
    if (isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
        var_fe11b7ad = 1;
    }
    if (!var_fe11b7ad) {
        overrideentitycamera = player::function_2cebe94b(attacker, weapon);
        var_fc963626 = potm::function_d2f2ef08(weapon, meansofdeath);
        potm::function_e6fdcbca(#"hash_11588f7b0737f095", attacker, self, inflictor, var_fc963626, overrideentitycamera);
    }
    if (isdefined(attacker)) {
        [[ level.var_b11ed148 ]](attacker, 1);
        attacker.pers[#"downs"] = (isdefined(attacker.pers[#"downs"]) ? attacker.pers[#"downs"] : 0) + 1;
        attacker.downs = attacker.pers[#"downs"];
    }
    self thread function_a61cc4f0();
}

// Namespace bounty/bounty
// Params 2, eflags: 0x4
// Checksum 0xf9c9149f, Offset: 0x19a8
// Size: 0xd0
function private onplayerrevived(revivee, reviver) {
    [[ level.var_b11ed148 ]](reviver, 1);
    reviver.pers[#"revives"] = (isdefined(reviver.pers[#"revives"]) ? reviver.pers[#"revives"] : 0) + 1;
    reviver.revives = reviver.pers[#"revives"];
    revivee notify(#"revived");
}

// Namespace bounty/bounty
// Params 0, eflags: 0x0
// Checksum 0x13a21b8a, Offset: 0x1a80
// Size: 0x64
function function_7ba60bfe() {
    assert(isdefined(level.var_265c8248));
    if (!level.var_265c8248 bountyhunterbuy::is_open(self)) {
        level.var_265c8248 bountyhunterbuy::open(self);
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x0
// Checksum 0x1b9a4edb, Offset: 0x1af0
// Size: 0x8c
function function_467127ba() {
    assert(isdefined(level.var_265c8248));
    if (level.var_265c8248 bountyhunterbuy::is_open(self)) {
        level.var_265c8248 bountyhunterbuy::close(self);
    }
    level.var_ffea59c gameobjects::set_visible_team(#"any");
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xa1fdedc5, Offset: 0x1b88
// Size: 0x60c
function private function_d4c3f73d() {
    level.var_f1294938 = 1;
    objective_setinvisibletoall(level.var_ffea59c.objectiveid);
    while (game.state != "playing") {
        waitframe(1);
    }
    globallogic_utils::pausetimer();
    level.purchasephase = 1;
    foreach (player in level.players) {
        player thread globallogic_audio::set_music_on_player("spawnPreLoop");
        player [[ level.givecustomloadout ]]();
    }
    if (function_7d64cef6()) {
        foreach (player in level.players) {
            player freezecontrols(1);
            player globallogic_ui::closemenus();
        }
        wait 1;
    }
    foreach (player in level.players) {
        if (!function_7d64cef6()) {
            player freezecontrols(1);
        }
        player function_7ba60bfe();
        player setlowready(1);
    }
    thread globallogic_audio::leader_dialog("bountyBuyStart");
    clockobject = spawn("script_origin", (0, 0, 0));
    timeremaining = level.var_5ad77f69;
    while (timeremaining > 0) {
        level clientfield::set_world_uimodel("BountyHunterLoadout.timeRemaining", timeremaining);
        if (timeremaining == 5) {
            foreach (player in level.players) {
                player globallogic_audio::set_music_on_player("spawnPreRise");
            }
        }
        if (timeremaining <= 5) {
            clockobject playsound(#"mpl_ui_timer_countdown");
        }
        if (timeremaining <= 1) {
            foreach (player in level.players) {
                player setlowready(0);
                player function_467127ba();
                player globallogic_ui::closemenus();
            }
        }
        timeremaining--;
        wait 1;
    }
    level.var_f1294938 = 0;
    level.purchasephase = 0;
    foreach (player in level.players) {
        player [[ level.givecustomloadout ]]();
        player freezecontrols(0);
        player globallogic_audio::set_music_on_player("spawnShort");
    }
    if (game.roundsplayed == 0) {
        if (level.hardcoremode) {
            thread globallogic_audio::leader_dialog("hcStartBounty");
        } else {
            thread globallogic_audio::leader_dialog("startBounty");
        }
        thread globallogic_audio::leader_dialog("bountyModeOrder");
    } else {
        thread globallogic_audio::leader_dialog("startRoundBounty");
    }
    level clientfield::set_world_uimodel("hudItems.specialistSwitchIsLethal", 1);
    globallogic_utils::resumetimer();
    objective_setvisibletoall(level.var_ffea59c.objectiveid);
    thread radarsweeps();
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x9eb53653, Offset: 0x21a0
// Size: 0x144
function private ondeadevent(team) {
    if (team == "all") {
        if (isdefined(level.var_f58e1502)) {
            function_8eee536a(level.var_f58e1502, 6);
            return;
        }
        function_980f4c1b(6);
        return;
    }
    if (isdefined(level.var_f58e1502)) {
        return;
    }
    level.var_f58e1502 = util::get_enemy_team(team);
    function_5cf0c5db(level.var_f58e1502);
    if (game.stat[#"roundswon"][level.var_f58e1502] >= level.roundwinlimit - 1) {
        function_8eee536a(level.var_f58e1502, 6);
        return;
    }
    level thread function_5d327b27();
    level thread function_3d6ac842(level.var_f58e1502);
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x2bc2865e, Offset: 0x22f0
// Size: 0xe4
function private function_5d327b27() {
    level.var_ed9a778e = 1;
    while (game.state == "playing") {
        if (isdefined(level.var_51b8493b) && isdefined(level.var_51b8493b.inuse) && level.var_51b8493b.inuse) {
            level.var_51b8493b.userate *= level.var_ed9a778e;
            level.var_ed9a778e += 0.1 * float(level.var_b5db3a4) / 1000;
        }
        waitframe(1);
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x784dcee, Offset: 0x23e0
// Size: 0xd4
function private function_3d6ac842(winner) {
    thread globallogic_audio::leader_dialog("bountyCashTimerStart", winner);
    level.timelimitoverride = 1;
    setgameendtime(gettime() + int(level.var_3d16bbd7 * 1000));
    hostmigration::waitlongdurationwithgameendtimeupdate(level.var_3d16bbd7);
    if (game.state != "playing") {
        return;
    }
    thread globallogic_audio::leader_dialog("bountyCashTimerFail", winner);
    function_8eee536a(winner, 6);
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x5388d9a9, Offset: 0x24c0
// Size: 0x1c
function private ontimelimit() {
    function_980f4c1b(2);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x0
// Checksum 0x8650d9d6, Offset: 0x24e8
// Size: 0x5c
function function_980f4c1b(var_c3d87d03) {
    round::set_flag("tie");
    function_5b5b3627(#"none");
    thread globallogic::end_round(var_c3d87d03);
}

// Namespace bounty/bounty
// Params 2, eflags: 0x0
// Checksum 0x444d613a, Offset: 0x2550
// Size: 0x5c
function function_8eee536a(winning_team, var_c3d87d03) {
    round::set_winner(winning_team);
    function_5b5b3627(winning_team);
    thread globallogic::function_e0994b4(winning_team, var_c3d87d03);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0xa241821a, Offset: 0x25b8
// Size: 0x1ac
function private ononeleftevent(team) {
    if (!isdefined(level.warnedlastplayer)) {
        level.warnedlastplayer = [];
    }
    if (isdefined(level.warnedlastplayer[team])) {
        return;
    }
    level.warnedlastplayer[team] = 1;
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team && isdefined(player.pers[#"class"])) {
            if (player.sessionstate == "playing" && !player.afk) {
                break;
            }
        }
    }
    if (i == players.size) {
        return;
    }
    players[i] thread givelastattackerwarning(team);
    util::function_d1f9db00(17, player.team, player getentitynumber());
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x7590218, Offset: 0x2770
// Size: 0x14
function private onroundswitch() {
    gametype::on_round_switch();
}

// Namespace bounty/bounty
// Params 9, eflags: 0x4
// Checksum 0xea4f318f, Offset: 0x2790
// Size: 0x224
function private onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    clientfield::set_player_uimodel("hudItems.playerLivesCount", level.numlives - self.var_b1f81f5d);
    enemy_team = util::getotherteam(self.team);
    if (!isdefined(level.var_506cc71d)) {
        level.var_506cc71d = [];
    }
    var_97496aa1 = level.playercount[self.team] - level.deaths[self.team];
    if (var_97496aa1 == 1) {
        level.var_506cc71d[self.team] = 1;
    } else if (var_97496aa1 <= 3 && var_97496aa1 > 1 && !(isdefined(level.var_506cc71d[self.team]) && level.var_506cc71d[self.team])) {
        thread globallogic_audio::leader_dialog("bountyLowLives", self.team);
        thread globallogic_audio::leader_dialog("bountyLowLivesEnemy", enemy_team);
        level.var_506cc71d[self.team] = 1;
    }
    if (isdefined(self) && isdefined(attacker) && attacker != self) {
        scoreevents::processscoreevent(#"eliminated_enemy", attacker, self, weapon);
    }
    self dynamic_loadout::removearmor();
    self function_fe8b9b47();
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0xfa3518a, Offset: 0x29c0
// Size: 0xbc
function private function_a9a13a28(params) {
    event = params.event;
    if (!isdefined(level.scoreinfo[event])) {
        return;
    }
    money = self rank::function_c079071f(event);
    if (isdefined(money) && money > 0 && !(params.victim === self)) {
        self function_ee6e4e8a(money);
        self playsoundtoplayer(#"hash_767e2476f594e0f3", self);
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x800a9ecc, Offset: 0x2a88
// Size: 0x12c
function private onplayerdamage(params) {
    if (isdefined(params) && isdefined(params.eattacker) && isplayer(params.eattacker) && isdefined(params.idamage)) {
        if (params.eattacker.team == self.team) {
            return;
        }
        player = params.eattacker;
        var_7b8dacdf = params.idamage;
        if (laststand::player_is_in_laststand() && isdefined(self.var_aab2a993) && var_7b8dacdf > self.var_aab2a993) {
            var_7b8dacdf = self.var_aab2a993;
        }
        player function_ee6e4e8a(var_7b8dacdf);
        player playsoundtoplayer(#"hash_767e2476f594e0f3", player);
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x7f0a56d5, Offset: 0x2bc0
// Size: 0xb4
function private function_60230117() {
    if (game.state == "playing") {
        foreach (weapondata in self.pers[#"dynamic_loadout"].weapons) {
            weapondata.ammo = -1;
        }
    }
    self thread function_80eff207();
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xaf4ead6, Offset: 0x2c80
// Size: 0x54
function private function_80eff207() {
    waitframe(1);
    if (isdefined(self) && isalive(self)) {
        level thread popups::displayteammessagetoteam(#"hash_4fe1c041d2f3e71", self, self.team, undefined, undefined);
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x33e47341, Offset: 0x2ce0
// Size: 0x44
function private function_80d46925(revivedplayer) {
    level thread popups::displayteammessagetoteam(#"hash_17c6b0524e578976", self, self.team, revivedplayer.entnum, undefined);
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xba6d39a3, Offset: 0x2d30
// Size: 0x44
function private function_7db0515a() {
    waitframe(1);
    clientfield::set_world_uimodel("hudItems.team1.noRespawnsLeft", 1);
    clientfield::set_world_uimodel("hudItems.team2.noRespawnsLeft", 1);
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x4b461f3, Offset: 0x2d80
// Size: 0x150
function private function_fe8b9b47() {
    if (!isdefined(level.var_ffea59c)) {
        return;
    }
    if (!isdefined(level.var_ffea59c.carrier)) {
        return;
    }
    if (!isdefined(self.team)) {
        return;
    }
    var_6c94a6b3 = getteamplayersalive(self.team);
    if (var_6c94a6b3 <= 0) {
        self.var_fb1a56a1 = level.var_ffea59c.carrier getentitynumber();
        return;
    }
    teammates = getplayers(self.team);
    foreach (teammate in teammates) {
        if (teammate == level.var_ffea59c.carrier) {
            self.var_fb1a56a1 = teammate getentitynumber();
            return;
        }
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0xde614132, Offset: 0x2ed8
// Size: 0x174
function private givelastattackerwarning(team) {
    self endon(#"death");
    self endon(#"disconnect");
    fullhealthtime = 0;
    interval = 0.05;
    self.lastmansd = 1;
    enemyteam = util::get_enemy_team(team);
    if (level.alivecount[enemyteam] > 2) {
        self.var_2cde88da = 1;
    }
    while (true) {
        if (self.health != self.maxhealth) {
            fullhealthtime = 0;
        } else {
            fullhealthtime += interval;
        }
        wait interval;
        if (self.health == self.maxhealth && fullhealthtime >= 3) {
            break;
        }
    }
    self thread globallogic_audio::leader_dialog_on_player("roundEncourageLastPlayer");
    thread globallogic_audio::leader_dialog_for_other_teams("roundEncourageLastPlayerEnemy", self.team, undefined, undefined);
    self playlocalsound(#"mus_last_stand");
}

// Namespace bounty/bounty
// Params 0, eflags: 0x0
// Checksum 0xc266cccc, Offset: 0x3058
// Size: 0xb8
function function_25f4f75a() {
    foreach (player in level.players) {
        if (isdefined(level.var_800af2f) && level.var_800af2f == player.team) {
            player function_ee6e4e8a(level.var_b77af8d7);
        }
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x46c08584, Offset: 0x3118
// Size: 0x1b8
function private function_5b5b3627(winner) {
    foreach (player in level.players) {
        if (isalive(player)) {
            foreach (weapondata in player.pers[#"dynamic_loadout"].weapons) {
                weapondata.ammo = -1;
            }
        }
        player dynamic_loadout::function_a5286e6a();
        if (!level.var_1543ee60) {
            player.pers[#"pickup_health"] = 0;
        }
        if (player.team == winner) {
            player scoreevents::processscoreevent(#"round_won", player);
            continue;
        }
        player scoreevents::processscoreevent(#"round_lost", player);
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xd62a936a, Offset: 0x32d8
// Size: 0x37e
function private function_c502e8c9() {
    var_8baaf970 = struct::get_array("bounty_bag_o_money", "variantname");
    var_3009057a = var_8baaf970[randomint(var_8baaf970.size)].origin;
    usetrigger = spawn("trigger_radius_use", var_3009057a + (0, 0, 15), 0, 80, 60);
    usetrigger triggerignoreteam();
    usetrigger setvisibletoall();
    usetrigger setteamfortrigger(#"none");
    usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    usetrigger function_c64750aa(-800);
    var_331797d3 = [];
    var_331797d3[0] = spawn("script_model", var_3009057a);
    var_331797d3[0] setmodel("p8_heist_duffel_bag_set_open");
    var_ffea59c = gameobjects::create_carry_object(#"neutral", usetrigger, var_331797d3, (0, 0, 0), #"hash_28e240e1bf135064");
    var_ffea59c gameobjects::set_use_hint_text(#"hash_ee4d709a0f80280");
    var_ffea59c gameobjects::allow_carry(#"any");
    var_ffea59c gameobjects::set_visible_team(#"any");
    var_ffea59c gameobjects::set_use_time(level.var_fcd18873);
    var_ffea59c gameobjects::set_objective_entity(var_ffea59c);
    var_ffea59c gameobjects::function_c64a0782(#"hash_510667a4ac8024c3");
    var_ffea59c.objectiveonself = 1;
    var_ffea59c.allowweapons = 1;
    var_ffea59c.onpickup = &function_1b411841;
    var_ffea59c.ondrop = &function_e817b85e;
    var_ffea59c.dropoffset = -10;
    var_ffea59c.var_9c48a02d = 0;
    var_ffea59c.var_5e0996c0 = gameobjects::get_next_obj_id();
    objective_add(var_ffea59c.var_5e0996c0, "invisible", var_ffea59c, #"hash_34a0ac740c9d0bc2");
    objective_onentity(var_ffea59c.var_5e0996c0, var_ffea59c);
    var_ffea59c gameobjects::set_visible_team(#"none");
    level.var_ffea59c = var_ffea59c;
    return var_ffea59c;
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x37ac6564, Offset: 0x3660
// Size: 0x314
function private function_1b411841(player) {
    level.var_800af2f = player.team;
    enemy_team = gameobjects::get_enemy_team(player.team);
    self gameobjects::set_visible_team(#"none");
    player setmovespeedscale(level.var_d8c58ed);
    player clientfield::set_player_uimodel("hudItems.BountyCarryingBag", 1);
    player clientfield::set("bountymoneytrail", 1);
    objective_setstate(self.var_5e0996c0, "active");
    objective_onentity(self.var_5e0996c0, player);
    objective_setteam(self.var_5e0996c0, player.team);
    function_c3a2445a(self.var_5e0996c0, player.team, 1);
    objective_setinvisibletoplayer(self.var_5e0996c0, player);
    if (!isdefined(self.var_10c3d0ff)) {
        scoreevents::processscoreevent(#"hash_2626334909405935", player, undefined, undefined);
        self.var_10c3d0ff = 1;
    }
    level thread function_5fdcd6b4();
    foreach (client in level.players) {
        if (client.team == level.var_800af2f) {
            client iprintlnbold(#"hash_59c00ede667b8208");
            continue;
        }
        client iprintlnbold(#"hash_11a63b819a280ff0");
    }
    level thread popups::displayteammessagetoall(#"hash_5f69531a71a74e3d", player);
    thread globallogic_audio::leader_dialog("bountyCashAcquiredFriendly", player.team);
    thread globallogic_audio::leader_dialog("bountyCashAcquiredEnemy", util::getotherteam(player.team));
    self thread function_b8d188f7(player);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0xe0cd4948, Offset: 0x3980
// Size: 0x304
function private function_b8d188f7(player) {
    self endon(#"hash_1af469c6cd76e56b");
    objective_setprogress(self.var_5e0996c0, float(level.var_b77af8d7) / level.var_dd32a91);
    player clientfield::set_to_player("bountyBagMoney", int(float(level.var_b77af8d7) / level.var_1fd62126));
    while (level.var_b77af8d7 > level.var_9048dd5) {
        if (isdefined(level.var_51b8493b)) {
            if (player istouching(level.var_51b8493b.trigger)) {
                if (player clientfield::get("bountymoneytrail") != 0) {
                    player clientfield::set("bountymoneytrail", 0);
                }
                waitframe(1);
                continue;
            } else if (player clientfield::get("bountymoneytrail") == 0) {
                player clientfield::set("bountymoneytrail", 1);
            }
        }
        wait level.var_fe755201;
        level.var_b77af8d7 -= level.var_1fd62126;
        if (level.var_b77af8d7 < level.var_9048dd5) {
            level.var_b77af8d7 = level.var_9048dd5;
        } else if (level.var_b77af8d7 > level.var_b77af8d7) {
            level.var_b77af8d7 = level.var_b77af8d7;
        }
        objective_setprogress(self.var_5e0996c0, float(level.var_b77af8d7) / level.var_dd32a91);
        player clientfield::set_to_player("bountyBagMoney", int(float(level.var_b77af8d7) / level.var_1fd62126));
    }
    player clientfield::set("bountymoneytrail", 0);
    player clientfield::set_to_player("bountyBagMoney", int(float(level.var_b77af8d7) / level.var_1fd62126));
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x2533b80e, Offset: 0x3c90
// Size: 0x238
function private function_e817b85e(player) {
    self notify(#"hash_1af469c6cd76e56b");
    if (isdefined(self.var_5e0996c0)) {
        objective_setstate(self.var_5e0996c0, "invisible");
        objective_onentity(self.var_5e0996c0, self);
        objective_setteam(self.var_5e0996c0, #"none");
        objective_setvisibletoplayer(self.var_5e0996c0, player);
        function_c3a2445a(self.var_5e0996c0, player.team, 0);
    }
    player setmovespeedscale(1);
    level.var_800af2f = undefined;
    level.var_b77af8d7 -= level.var_434d8dd9;
    self gameobjects::set_visible_team(#"any");
    level thread popups::displayteammessagetoall(#"hash_5e8cd98e9533c77d", player);
    player clientfield::set_player_uimodel("hudItems.BountyCarryingBag", 0);
    player clientfield::set("bountymoneytrail", 0);
    self playsound(#"hash_6f33c21d562757a1");
    foreach (client in level.players) {
        client iprintlnbold(#"hash_5c2a786ab2a51fa9");
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x3dccdfa5, Offset: 0x3ed0
// Size: 0xe0
function private function_5cf0c5db(team) {
    players = getplayers(team);
    foreach (player in players) {
        if (isbot(player)) {
            continue;
        }
        if (!isalive(player)) {
            continue;
        }
        player iprintlnbold(#"hash_3191d03a1c0615ad");
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xc8411290, Offset: 0x3fb8
// Size: 0x1d2
function private function_66915580() {
    if (isdefined(level.var_e2a1d148)) {
        return level.var_e2a1d148;
    }
    var_34c5c54 = struct::get_array("bounty_deposit_location", "variantname");
    if (var_34c5c54.size == 0) {
        var_34c5c54[0] = {};
        mapcenter = airsupport::getmapcenter();
        var_34c5c54[0].origin = getclosestpointonnavmesh(mapcenter, 256, 32);
    } else if (var_34c5c54.size > 1) {
        closestdist = 2147483647;
        closestindex = -1;
        for (i = 0; i < var_34c5c54.size; i++) {
            dist = distancesquared(level.var_ffea59c.origin, var_34c5c54[i].origin);
            if (dist < closestdist) {
                closestdist = dist;
                closestindex = i;
            }
        }
        if (closestindex >= 0) {
            arrayremoveindex(var_34c5c54, closestindex);
        }
    }
    var_f3e238ce = var_34c5c54[randomint(var_34c5c54.size)].origin;
    level.var_e2a1d148 = var_f3e238ce;
    return level.var_e2a1d148;
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xe14da399, Offset: 0x4198
// Size: 0xe
function private function_7e4fa139() {
    level.var_e2a1d148 = undefined;
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x64729f7c, Offset: 0x41b0
// Size: 0x36
function private function_1953b3cb() {
    if (isdefined(level.var_36bae6fa)) {
        level.var_36bae6fa notify(#"strobe_stop");
        level.var_36bae6fa = undefined;
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0xfe42ac1, Offset: 0x41f0
// Size: 0x6e
function private function_9233d35c(delay) {
    if (isdefined(level.var_36bae6fa)) {
        return;
    }
    if (isdefined(delay)) {
        wait delay;
    }
    var_f3e238ce = function_66915580();
    level.var_36bae6fa = ir_strobe::function_aebde85a(var_f3e238ce, #"wpn_t8_eqp_grenade_smoke_world");
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x19dba43c, Offset: 0x4268
// Size: 0x74
function private function_5fdcd6b4() {
    if (isdefined(level.var_fb786d81)) {
        return;
    }
    level.var_fb786d81 = 1;
    function_9233d35c();
    tempcontext = {};
    function_71f861ef(function_66915580(), tempcontext);
}

// Namespace bounty/bounty
// Params 2, eflags: 0x4
// Checksum 0xb8ff66c2, Offset: 0x42e8
// Size: 0x454
function private function_71f861ef(var_f3e238ce, context) {
    assert(isdefined(var_f3e238ce));
    level.var_36bae6fa = ir_strobe::function_aebde85a(var_f3e238ce, #"wpn_t8_eqp_grenade_smoke_world");
    var_8f94d84e = randomfloatrange(level.var_1f133895, level.var_9f490fb);
    wait var_8f94d84e;
    destination = getstartorigin(var_f3e238ce, (0, 0, 0), #"ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2");
    var_799562a = helicopter::getvalidrandomstartnode(destination).origin;
    helicopter = function_8a4f0343(var_799562a, vectortoangles(destination - var_799562a), context);
    helicopter endon(#"death");
    helicopter endon(#"hash_69d2c68fdf86b6d7");
    helicopter.hardpointtype = undefined;
    waitframe(1);
    function_85c0a295(helicopter);
    helicopter thread function_3c73b0a(helicopter, destination);
    helicopter waittill(#"reached_destination");
    helicopter thread function_eb638194(helicopter, var_f3e238ce);
    foreach (player in level.players) {
        player iprintlnbold(#"hash_538845c490abb83e");
    }
    wait_start = gettime();
    while (helicopter.origin[2] - var_f3e238ce[2] > 620 && gettime() - wait_start < 1000) {
        wait 0.1;
    }
    level thread function_4f63b7ce(helicopter);
    if (!isdefined(level.var_51b8493b)) {
        level.var_51b8493b = function_32206c4f(var_f3e238ce);
    } else {
        level.var_51b8493b function_4f791c39(var_f3e238ce);
    }
    waitresult = level.var_51b8493b waittill(#"hash_5677d0c5246418e5");
    for (prevprogress = 0; waitresult._notify == "timeout" && level.var_51b8493b.curprogress > prevprogress; prevprogress = level.var_51b8493b.curprogress) {
        waitresult = level.var_51b8493b waittilltimeout(0.25, #"hash_5677d0c5246418e5");
    }
    if (!isdefined(level.var_51b8493b)) {
        return;
    }
    if (waitresult._notify == "timeout") {
        level.var_51b8493b function_623b263d();
    }
    level.var_36bae6fa notify(#"strobe_stop");
    helicopter thread function_59cbcc66(helicopter);
    context.deployed = 1;
    helicopter thread function_e4896678(helicopter);
}

// Namespace bounty/bounty
// Params 2, eflags: 0x4
// Checksum 0x8f92798b, Offset: 0x4748
// Size: 0x158
function private function_eb638194(helicopter, var_c004c549) {
    helicopter endon(#"death");
    helicopter endon(#"hash_589604da14bd8976");
    var_953e0008 = var_c004c549;
    lerp_duration = max((helicopter.origin[2] - var_c004c549[2] - 600) / 625, 0.8);
    helicopter animation::play(#"ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2", var_953e0008, (0, helicopter.angles[1], 0), 1, 0.1, 0.2, lerp_duration);
    while (true) {
        helicopter animation::play(#"ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2", var_953e0008, (0, helicopter.angles[1], 0), 1, 0.1, 0.2, 0.8);
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x80a00dc1, Offset: 0x48a8
// Size: 0x10c
function private function_85c0a295(helicopter) {
    assert(!isdefined(helicopter.rope));
    helicopter.rope = spawn("script_model", helicopter.origin);
    assert(isdefined(helicopter.rope));
    helicopter.rope useanimtree("generic");
    helicopter.rope setmodel(#"hash_142fee14ea7bdb9b");
    helicopter.rope linkto(helicopter, "tag_origin_animate");
    helicopter.rope hide();
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x6206ad52, Offset: 0x49c0
// Size: 0x104
function private function_4f63b7ce(helicopter) {
    assert(isdefined(helicopter.rope));
    helicopter endon(#"death", #"hash_69d2c68fdf86b6d7", #"hash_3478587618f28c8");
    helicopter.rope endon(#"death");
    helicopter.rope show();
    helicopter.rope animation::play(#"hash_751de00c6e9e0862", helicopter, "tag_origin_animate", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
    childthread function_6f4cb042(helicopter);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x11d78bb5, Offset: 0x4ad0
// Size: 0x88
function private function_6f4cb042(helicopter) {
    assert(isdefined(helicopter.rope));
    while (true) {
        helicopter.rope animation::play(#"hash_217d8ba9d8489561", helicopter, "tag_origin_animate", 1, 0.1, 0.1, undefined, undefined, undefined, 0);
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0xe13c3791, Offset: 0x4b60
// Size: 0x124
function private function_59cbcc66(helicopter) {
    if (!isdefined(helicopter.rope)) {
        return;
    }
    helicopter endon(#"hash_69d2c68fdf86b6d7");
    helicopter endon(#"death");
    helicopter.rope endon(#"death");
    helicopter notify(#"hash_3478587618f28c8");
    helicopter.rope thread animation::play(#"hash_3d52f6faf02fd23", helicopter, "tag_origin_animate", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
    var_ba98827b = getanimlength(#"hash_3d52f6faf02fd23") + 15;
    wait var_ba98827b;
    function_7ecfa6bb(helicopter);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x8fe5429, Offset: 0x4c90
// Size: 0x4c
function private function_7ecfa6bb(helicopter) {
    helicopter endon(#"death");
    if (isdefined(helicopter.rope)) {
        helicopter.rope delete();
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x0
// Checksum 0x8e805135, Offset: 0x4ce8
// Size: 0x74
function heli_reset() {
    self cleartargetyaw();
    self cleargoalyaw();
    self setyawspeed(75, 45, 45);
    self setmaxpitchroll(30, 30);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x0
// Checksum 0x130d8630, Offset: 0x4d68
// Size: 0x3bc
function function_e4896678(helicopter) {
    helicopter notify(#"leaving");
    helicopter notify(#"hash_589604da14bd8976");
    helicopter.leaving = 1;
    leavenode = helicopter::getvalidrandomleavenode(helicopter.origin);
    var_b321594 = leavenode.origin;
    heli_reset();
    helicopter vehclearlookat();
    exitangles = vectortoangles(var_b321594 - helicopter.origin);
    helicopter setgoalyaw(exitangles[1]);
    if (isdefined(level.var_6fb48cdb) && level.var_6fb48cdb) {
        if (!ispointinnavvolume(helicopter.origin, "navvolume_big")) {
            if (issentient(helicopter)) {
                helicopter function_32aff240();
            }
            radius = distance(self.origin, leavenode.origin);
            var_40c02d23 = getclosestpointonnavvolume(helicopter.origin, "navvolume_big", radius);
            if (isdefined(var_40c02d23)) {
                helicopter function_8474d4c8(var_40c02d23, 0);
                while (true) {
                    /#
                        recordsphere(var_40c02d23, 8, (0, 0, 1), "<dev string:x30>");
                    #/
                    var_6f7637e2 = ispointinnavvolume(helicopter.origin, "navvolume_big");
                    if (var_6f7637e2) {
                        helicopter makesentient();
                        break;
                    }
                    waitframe(1);
                }
            }
        }
        if (!ispointinnavvolume(leavenode.origin, "navvolume_big")) {
            helicopter thread function_768b2544(leavenode);
            helicopter waittill(#"hash_2bf34763927dd61b");
        }
    }
    helicopter function_8474d4c8(var_b321594, 1);
    helicopter waittilltimeout(20, #"near_goal", #"death");
    if (isdefined(helicopter)) {
        helicopter stoploopsound(1);
        helicopter util::death_notify_wrapper();
        if (isdefined(helicopter.alarm_snd_ent)) {
            helicopter.alarm_snd_ent stoploopsound();
            helicopter.alarm_snd_ent delete();
            helicopter.alarm_snd_ent = undefined;
        }
        helicopter delete();
    }
}

// Namespace bounty/bounty
// Params 3, eflags: 0x4
// Checksum 0x5af889bd, Offset: 0x5130
// Size: 0x200
function private function_8a4f0343(origin, angles, context) {
    helicopter = spawnvehicle(#"vehicle_t8_mil_helicopter_swat_transport", origin, angles, "bounty_deposit_site_helicopter");
    helicopter.spawntime = gettime();
    helicopter.attackers = [];
    helicopter.attackerdata = [];
    helicopter.attackerdamage = [];
    helicopter.flareattackerdamage = [];
    helicopter.killstreak_id = context.killstreak_id;
    helicopter setdrawinfrared(1);
    helicopter.allowcontinuedlockonafterinvis = 1;
    helicopter.soundmod = "heli";
    helicopter.takedamage = 0;
    notifydist = 128;
    helicopter setneargoalnotifydist(notifydist);
    bundle = level.var_2c2e3dd5;
    helicopter.maxhealth = bundle.kshealth;
    helicopter.health = bundle.kshealth;
    helicopter.overridevehicledamage = &function_6b4bb168;
    context.helicopter = helicopter;
    var_81df57ba = 0;
    if (var_81df57ba) {
        helicopter.target_offset = (0, 0, -25);
        target_set(helicopter, (0, 0, -25));
    }
    helicopter setrotorspeed(1);
    return helicopter;
}

// Namespace bounty/bounty
// Params 2, eflags: 0x4
// Checksum 0xc52ddec5, Offset: 0x5338
// Size: 0x290
function private function_3c73b0a(helicopter, destination) {
    helicopter endon(#"death");
    var_1d9e00b4 = destination;
    if (isdefined(level.var_6fb48cdb) && level.var_6fb48cdb) {
        helicopter thread function_b973a2e3();
        if (!ispointinnavvolume(var_1d9e00b4, "navvolume_big")) {
            var_40c02d23 = getclosestpointonnavvolume(destination, "navvolume_big", 10000);
            var_1d9e00b4 = (var_40c02d23[0], var_40c02d23[1], destination[2]);
            if (isdefined(var_1d9e00b4)) {
                helicopter function_8474d4c8(var_1d9e00b4, 1);
                helicopter.var_1d9e00b4 = var_1d9e00b4;
                if (!ispointinnavvolume(var_1d9e00b4, "navvolume_big")) {
                    self waittilltimeout(10, #"hash_340ab3c2b94ff86a");
                }
            }
        }
        self function_8474d4c8(var_1d9e00b4, 1);
        self waittill(#"near_goal");
    } else {
        helicopter thread airsupport::setgoalposition(destination, "bounty_deposit_site_heli_reached", 1);
        helicopter waittill(#"bounty_deposit_site_heli_reached");
    }
    last_distance_from_goal_squared = 1e+07 * 1e+07;
    continue_waiting = 1;
    for (remaining_tries = 30; continue_waiting && remaining_tries > 0; remaining_tries--) {
        current_distance_from_goal_squared = distance2dsquared(helicopter.origin, destination);
        continue_waiting = current_distance_from_goal_squared < last_distance_from_goal_squared && current_distance_from_goal_squared > 4 * 4;
        last_distance_from_goal_squared = current_distance_from_goal_squared;
        if (continue_waiting) {
            waitframe(1);
        }
    }
    helicopter notify(#"reached_destination");
}

// Namespace bounty/bounty
// Params 15, eflags: 0x0
// Checksum 0x88aa140, Offset: 0x55d0
// Size: 0x150
function function_6b4bb168(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    bundle = level.var_2c2e3dd5;
    chargelevel = 0;
    weapon_damage = killstreak_bundles::function_9c163c89(bundle, self.maxhealth, eattacker, weapon, smeansofdeath, idamage, idflags, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = killstreaks::get_old_damage(eattacker, weapon, smeansofdeath, idamage, 1);
    }
    weapon_damage = int(weapon_damage);
    if (weapon_damage >= self.health) {
        thread destroy_heli(self);
    }
    return weapon_damage;
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x1da24d6d, Offset: 0x5728
// Size: 0xb4
function private destroy_heli(helicopter) {
    if (isdefined(level.var_51b8493b)) {
        level.var_51b8493b function_623b263d();
        level.var_36bae6fa notify(#"strobe_stop");
        if (isdefined(helicopter.rope)) {
            helicopter.rope delete();
        }
    }
    helicopter helicopter::function_236dcb7b();
    wait 0.1;
    if (isdefined(helicopter)) {
        helicopter delete();
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xee11cd8b, Offset: 0x57e8
// Size: 0xfc
function private function_b973a2e3() {
    self endon(#"death");
    while (true) {
        var_6f7637e2 = ispointinnavvolume(self.origin, "navvolume_big");
        if (var_6f7637e2) {
            heli_reset();
            self makepathfinder();
            self makesentient();
            self.ignoreme = 1;
            if (isdefined(self.heligoalpos)) {
                self function_8474d4c8(self.heligoalpos, 1);
            }
            self notify(#"hash_340ab3c2b94ff86a");
            break;
        }
        waitframe(1);
    }
}

// Namespace bounty/bounty
// Params 2, eflags: 0x0
// Checksum 0x4869b798, Offset: 0x58f0
// Size: 0x114
function function_8474d4c8(goalpos, stop) {
    self.heligoalpos = goalpos;
    if (isdefined(level.var_6fb48cdb) && level.var_6fb48cdb) {
        if (issentient(self) && ispathfinder(self) && ispointinnavvolume(self.origin, "navvolume_big")) {
            self setgoal(goalpos, stop);
            self function_3c8dce03(goalpos, stop, 1);
        } else {
            self function_3c8dce03(goalpos, stop, 0);
        }
        return;
    }
    self setgoal(goalpos, stop);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x100f2dda, Offset: 0x5a10
// Size: 0x166
function private function_768b2544(leavenode) {
    self endon(#"death");
    radius = distance(self.origin, leavenode.origin);
    var_40c02d23 = getclosestpointonnavvolume(leavenode.origin, "navvolume_big", radius);
    if (isdefined(var_40c02d23)) {
        self function_8474d4c8(var_40c02d23, 0);
        while (true) {
            /#
                recordsphere(var_40c02d23, 8, (0, 0, 1), "<dev string:x30>");
            #/
            var_6f7637e2 = ispointinnavvolume(self.origin, "navvolume_big");
            if (!var_6f7637e2) {
                self function_32aff240();
                self notify(#"hash_2bf34763927dd61b");
                break;
            }
            waitframe(1);
        }
        return;
    }
    self function_32aff240();
    self notify(#"hash_2bf34763927dd61b");
}

// Namespace bounty/bounty
// Params 1, eflags: 0x0
// Checksum 0xc5530938, Offset: 0x5b80
// Size: 0x20e
function function_32206c4f(origin) {
    trigger = spawn("trigger_radius_new", origin, 0, 90, 100);
    trigger triggerignoreteam();
    useobj = gameobjects::create_use_object(#"none", trigger, [], (0, 0, 0), #"hash_7e7657e9c8f441eb");
    useobj gameobjects::set_visible_team(#"any");
    useobj gameobjects::allow_use(#"any");
    useobj gameobjects::set_owner_team(#"neutral");
    useobj gameobjects::set_use_time(level.bountydepositsitecapturetime);
    useobj gameobjects::set_key_object(level.var_ffea59c);
    useobj gameobjects::set_onbeginuse_event(&function_e7539c43);
    useobj gameobjects::set_onuse_event(&function_80b7f697);
    useobj gameobjects::function_12cc0652(1);
    useobj gameobjects::function_c60ddd9f(1);
    useobj function_4b6da077(origin);
    useobj.onuseupdate = &onuseupdate;
    useobj.decayprogress = level.decayprogress;
    useobj.autodecaytime = level.autodecaytime;
    useobj.cancontestclaim = 0;
    return useobj;
}

// Namespace bounty/bounty
// Params 3, eflags: 0x0
// Checksum 0xb0a4cfe4, Offset: 0x5d98
// Size: 0x54
function onuseupdate(team, progress, change) {
    if (change > 0) {
        self gameobjects::set_flags(team == "allies" ? 1 : 2);
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x0
// Checksum 0x3b5b4deb, Offset: 0x5df8
// Size: 0xc4
function function_4b6da077(origin) {
    useobj = self;
    useobj function_91bd2039();
    fwd = (0, 0, 1);
    right = (0, -1, 0);
    useobj.fx = spawnfx(#"ui/fx_dom_marker_team_r90", origin, fwd, right);
    useobj.fx.team = #"none";
    triggerfx(useobj.fx, 0.001);
}

// Namespace bounty/bounty
// Params 0, eflags: 0x0
// Checksum 0x1f990c0, Offset: 0x5ec8
// Size: 0x3c
function function_91bd2039() {
    useobj = self;
    if (isdefined(useobj.fx)) {
        useobj.fx delete();
    }
}

// Namespace bounty/bounty
// Params 1, eflags: 0x0
// Checksum 0x70d54789, Offset: 0x5f10
// Size: 0xcc
function function_4f791c39(origin) {
    useobj = self;
    useobj.origin = origin;
    useobj gameobjects::clear_progress();
    useobj gameobjects::set_visible_team(#"any");
    useobj gameobjects::allow_use(#"any");
    useobj gameobjects::set_owner_team(#"neutral");
    useobj gameobjects::set_model_visibility(1);
    useobj function_4b6da077(origin);
}

// Namespace bounty/bounty
// Params 0, eflags: 0x0
// Checksum 0x2f9d33ae, Offset: 0x5fe8
// Size: 0x84
function function_623b263d() {
    useobj = self;
    useobj gameobjects::set_visible_team(#"none");
    useobj gameobjects::allow_use(#"none");
    useobj gameobjects::set_model_visibility(0);
    useobj function_91bd2039();
}

// Namespace bounty/bounty
// Params 1, eflags: 0x0
// Checksum 0x212261a6, Offset: 0x6078
// Size: 0x12c
function function_80b7f697(player) {
    if (!isdefined(player)) {
        return;
    }
    useobj = self;
    useobj notify(#"hash_5677d0c5246418e5");
    useobj function_623b263d();
    player playsoundtoplayer(#"hash_19f756f885db9bb8", player);
    [[ level.var_b11ed148 ]](player, 1);
    player.pers[#"objscore"]++;
    player.objscore = player.pers[#"objscore"];
    level thread popups::displayteammessagetoall(#"hash_6bea5c334a4ab164", player);
    level function_25f4f75a();
    function_8eee536a(player getteam(), 1);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x1593bfbe, Offset: 0x61b0
// Size: 0x114
function private function_e7539c43(sentient) {
    useobj = self;
    player = sentient;
    if (!isplayer(player)) {
        player = sentient.owner;
    }
    var_45fc0bf1 = player getteam();
    if (!isdefined(level.var_42d65ef5) || gettime() > level.var_42d65ef5) {
        level.var_42d65ef5 = gettime() + 1000;
        thread globallogic_audio::leader_dialog("bountyCashDepositingFriendly", var_45fc0bf1);
        thread globallogic_audio::leader_dialog("bountyCashDepositingEnemy", util::getotherteam(var_45fc0bf1));
    }
    function_49806ea6(level.var_7b46ab9, var_45fc0bf1);
}

// Namespace bounty/bounty
// Params 2, eflags: 0x4
// Checksum 0x6060dbc9, Offset: 0x62d0
// Size: 0x54
function private function_49806ea6(var_e198b4fe, var_7a1bf7d3) {
    if (!isdefined(var_e198b4fe)) {
        return;
    }
    if (var_7a1bf7d3 != var_e198b4fe gameobjects::get_owner_team()) {
        var_e198b4fe gameobjects::set_owner_team(var_7a1bf7d3);
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xc6badd53, Offset: 0x6330
// Size: 0x2c
function private function_f619b4d4() {
    waitframe(1);
    pickup_health::function_d5892da4();
    pickup_ammo::function_63593f88();
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xa0f3f786, Offset: 0x6368
// Size: 0x2cc
function private function_3f49423b() {
    waitframe(1);
    droplocations = struct::get_array("bounty_drop", "variantname");
    droppoint = droplocations[randomint(droplocations.size)].origin;
    droppoint += (0, 0, 2000);
    startpoint = helicopter::getvalidrandomstartnode(droppoint).origin;
    startpoint = (startpoint[0], startpoint[1], droppoint[2]);
    timer = randomintrange(level.var_4795ccd4, level.var_8998e12a);
    wait timer;
    supplydropveh = spawnvehicle(#"vehicle_t8_mil_helicopter_transport_mp", startpoint, vectortoangles(vectornormalize(droppoint - startpoint)));
    supplydropveh.goalradius = 128;
    supplydropveh.goalheight = 128;
    if (!isdefined(supplydropveh)) {
        return;
    }
    supplydropveh setspeed(100);
    supplydropveh setrotorspeed(1);
    supplydropveh setcandamage(0);
    supplydropveh vehicle::toggle_tread_fx(1);
    supplydropveh vehicle::toggle_exhaust_fx(1);
    supplydropveh vehicle::toggle_sounds(1);
    supplydrop = spawn("script_model", (0, 0, 0));
    supplydrop setmodel("wpn_t7_drop_box_wz");
    supplydrop linkto(supplydropveh, "tag_cargo_attach", (0, 0, -30));
    supplydropveh.supplydrop = supplydrop;
    supplydropveh function_3c8dce03(droppoint, 1, 0);
    supplydropveh thread function_9eda4c2e(droppoint);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x9fc72f58, Offset: 0x6640
// Size: 0x194
function private function_9eda4c2e(droppoint) {
    self endon(#"death");
    exitpoint = droppoint + droppoint - self.origin;
    while (true) {
        waitframe(1);
        currdist = distancesquared(self.origin, droppoint);
        if (currdist < 225 * 225) {
            self setspeed(0);
            self.supplydrop unlink();
            self.supplydrop moveto(droppoint - (0, 0, 1990), 2);
            self.supplydrop playsound("evt_supply_drop");
            self.supplydrop thread function_ac41a964();
            self.supplydrop = undefined;
            self setspeed(100);
            break;
        }
    }
    self function_3c8dce03(exitpoint);
    timeout = distance(self.origin, exitpoint) / 1000;
    wait timeout;
    self delete();
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0x212ef63a, Offset: 0x67e0
// Size: 0x1dc
function private function_ac41a964() {
    wait 2.01;
    self physicslaunch();
    self waittill(#"stationary");
    self.trigger = spawn("trigger_radius_use", self.origin, 0, 100, 60);
    self.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    self.trigger triggerignoreteam();
    self.gameobject = gameobjects::create_use_object(#"neutral", self.trigger, [], (0, 0, 60), "bounty_drop", 1);
    self.gameobject gameobjects::set_objective_entity(self.gameobject);
    self.gameobject gameobjects::set_visible_team(#"any");
    self.gameobject gameobjects::allow_use(#"any");
    self.gameobject gameobjects::set_use_time(1.5);
    self.gameobject.onenduse = &function_c3c0d859;
    self.gameobject.usecount = 0;
    self.gameobject.var_c477841c = self;
    thread globallogic_audio::leader_dialog("bountyAirdropDetected");
}

// Namespace bounty/bounty
// Params 3, eflags: 0x4
// Checksum 0x17ddc66, Offset: 0x69c8
// Size: 0x1c6
function private function_c3c0d859(team, player, result) {
    self.isdisabled = 0;
    if (isdefined(result) && result && isdefined(player) && isplayer(player)) {
        self.usecount++;
        player function_ee6e4e8a(level.var_818200f0);
        player pickup_health::function_b7e28ea0(level.var_42f58464);
        weapons = player getweaponslist();
        foreach (weapon in weapons) {
            player givestartammo(weapon);
        }
        player playsoundtoplayer(#"hash_19f756f885db9bb8", player);
        self gameobjects::hide_waypoint(player);
        self.trigger setinvisibletoplayer(player);
        if (self.usecount >= level.var_83f0508d) {
            self gameobjects::disable_object(1);
            return;
        }
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x4
// Checksum 0xaa2e5f74, Offset: 0x6b98
// Size: 0xf8
function private radarsweeps() {
    if (level.var_dd94719f) {
        while (float(globallogic_utils::gettimeremaining()) / 1000 > level.var_1572b8b7) {
            wait level.var_dd94719f;
            thread doradarsweep();
        }
    } else {
        while (float(globallogic_utils::gettimeremaining()) / 1000 > level.var_1572b8b7) {
            wait 1;
        }
    }
    if (level.var_3be08e47) {
        while (game.state == "playing") {
            wait level.var_3be08e47;
            thread doradarsweep();
        }
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x0
// Checksum 0x73827908, Offset: 0x6c98
// Size: 0xcc
function doradarsweep() {
    if (globallogic_utils::gettimeremaining() > 10) {
        thread globallogic_audio::leader_dialog("bountyUAVSweep");
    }
    setteamspyplane(#"allies", 1);
    setteamspyplane(#"axis", 1);
    wait 5;
    setteamspyplane(#"allies", 0);
    setteamspyplane(#"axis", 0);
}

// Namespace bounty/bounty
// Params 1, eflags: 0x0
// Checksum 0xdb16ba4f, Offset: 0x6d70
// Size: 0xf4
function function_ee6e4e8a(amount) {
    if (!isdefined(self.pers[#"money"])) {
        return;
    }
    self.pers[#"money"] = self.pers[#"money"] + amount;
    self.pers[#"money_earned"] = self.pers[#"money_earned"] + amount;
    [[ level._setplayerscore ]](self, self.pers[#"money_earned"]);
    self clientfield::set_to_player("bountyMoney", self.pers[#"money"]);
}

/#

    // Namespace bounty/bounty
    // Params 0, eflags: 0x0
    // Checksum 0x7df79a9a, Offset: 0x6e70
    // Size: 0xfc
    function function_55f85445() {
        path = "<dev string:x37>";
        cmd = "<dev string:x4a>";
        util::add_devgui(path + "<dev string:x60>", cmd + "<dev string:x6b>");
        util::add_devgui(path + "<dev string:x6e>", cmd + "<dev string:x7a>");
        util::add_devgui(path + "<dev string:x7e>", cmd + "<dev string:x8a>");
        util::add_devgui(path + "<dev string:x8e>", cmd + "<dev string:x9a>");
        util::add_devgui(path + "<dev string:x9e>", cmd + "<dev string:xab>");
    }

    // Namespace bounty/bounty
    // Params 0, eflags: 0x0
    // Checksum 0xa119d29c, Offset: 0x6f78
    // Size: 0x168
    function function_fae6617b() {
        level notify(#"hash_7069fa0a73642e1f");
        level endon(#"hash_7069fa0a73642e1f");
        wait 1;
        function_55f85445();
        wait 1;
        while (true) {
            wait 0.25;
            var_45a5da42 = getdvarint(#"hash_312d65fd43c7008c", 0);
            if (var_45a5da42 <= 0) {
                continue;
            }
            player = level.players[0];
            if (isplayer(player)) {
                player.pers[#"money"] = player.pers[#"money"] + var_45a5da42;
                player clientfield::set_to_player("<dev string:xb0>", player.pers[#"money"]);
            }
            setdvar(#"hash_312d65fd43c7008c", 0);
        }
    }

#/
