#using script_1cc417743d7c262d;
#using script_44b0b8420eabacad;
#using script_6167e26342be354b;
#using scripts\core_common\armor;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\draft;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\player\player_killed;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_monitor;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;

#namespace globallogic_spawn;

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x6
// Checksum 0xa5d95f4d, Offset: 0x2b8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"globallogic_spawn", &function_70a657d8, undefined, undefined, #"gamestate");
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x5 linked
// Checksum 0xb5815235, Offset: 0x308
// Size: 0x9c
function private function_70a657d8() {
    level.var_b3c4b7b7 = getgametypesetting(#"hash_4bf99a809542e4ea");
    level.spawnsystem.var_3709dc53 = 0;
    spawning::add_default_spawnlist("auto_normal");
    callback::add_callback(#"on_end_game", &on_end_game);
    level thread function_621bbb3();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x9e09cae8, Offset: 0x3b0
// Size: 0xe
function getspawnentitytypes() {
    return level.spawnentitytypes;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x39d48a6a, Offset: 0x3c8
// Size: 0xe
function getmpspawnpoints() {
    return level.allspawnpoints;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x2631ca2b, Offset: 0x3e0
// Size: 0x326
function timeuntilspawn(includeteamkilldelay) {
    if (level.ingraceperiod && is_false(self.hasspawned)) {
        return 0;
    }
    respawndelay = 0;
    var_c04d33cd = 0;
    if (is_true(self.var_20250438)) {
        return 0;
    }
    if (is_true(self.hasspawned)) {
        var_28f1fc71 = isdefined(getgametypesetting(#"hash_78d9e3544c3a5eaf")) ? getgametypesetting(#"hash_78d9e3544c3a5eaf") : 0;
        if (squad_spawn::function_d072f205() && var_28f1fc71) {
            if (self clientfield::get_player_uimodel("hudItems.squadSpawnSquadWipe")) {
                return var_28f1fc71;
            }
        }
        result = self [[ level.onrespawndelay ]]();
        if (isdefined(result)) {
            respawndelay = result;
            var_c04d33cd = 1;
        } else {
            respawndelay = level.playerrespawndelay;
        }
        if (isdefined(level.playerincrementalrespawndelay) && isdefined(self.pers[#"spawns"])) {
            respawndelay += level.playerincrementalrespawndelay * self.pers[#"spawns"];
        }
        if (is_true(self.suicide) && level.suicidespawndelay > 0) {
            respawndelay += level.suicidespawndelay;
        }
        if (is_true(self.teamkilled) && level.teamkilledspawndelay > 0) {
            respawndelay += level.teamkilledspawndelay;
        }
        if (includeteamkilldelay && is_true(self.teamkillpunish)) {
            respawndelay += player::function_821200bb();
        }
    }
    if (is_true(level.deathcirclerespawn)) {
        return self function_ac5b273c(respawndelay);
    }
    wavebased = level.waverespawndelay > 0;
    if (wavebased && !var_c04d33cd) {
        return self timeuntilwavespawn(respawndelay);
    }
    if (is_true(self.usedresurrect)) {
        return 0;
    }
    return respawndelay;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x5742dcc6, Offset: 0x710
// Size: 0xb0
function allteamshaveexisted() {
    foreach (team, _ in level.teams) {
        if (!teams::function_9dd75dad(team)) {
            return false;
        }
        if (level.everexisted[team] > gettime() + 1000) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x94a490c3, Offset: 0x7c8
// Size: 0xbe
function function_c6cf4045() {
    if (level.teambased) {
        gamehasstarted = allteamshaveexisted();
    } else {
        gamehasstarted = level.maxplayercount > 1 || !util::isoneround() && !util::isfirstround();
    }
    if (gamehasstarted && is_true(level.var_60507c71)) {
        if (!level.ingraceperiod && !self.hasspawned) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xfb3a2f5f, Offset: 0x890
// Size: 0x11c
function mayspawn() {
    if (isdefined(level.mayspawn) && !self [[ level.mayspawn ]]()) {
        return false;
    }
    if (level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !spawning::usestartspawns()) {
        return false;
    }
    if (game.state == "playing" && level.var_c2cc011f && function_a1ef346b(self.team).size == 0) {
        return false;
    }
    if (isdefined(level.var_75db41a7) && gettime() >= level.var_75db41a7) {
        return false;
    }
    return globallogic_player::function_38527849() && function_c6cf4045();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0xb8c05e01, Offset: 0x9b8
// Size: 0x92
function function_ac5b273c(minimumwait) {
    earliestspawntime = gettime() + int(minimumwait * 1000);
    if (!isdefined(level.deathcircle.var_d60fd7cd)) {
        return 0;
    }
    return max(float(level.deathcircle.var_d60fd7cd - gettime()) / 1000, 0);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0xec3f6169, Offset: 0xa58
// Size: 0x154
function timeuntilwavespawn(minimumwait) {
    earliestspawntime = gettime() + int(minimumwait * 1000);
    lastwavetime = level.lastwave[self.pers[#"team"]];
    wavedelay = int(level.wavedelay[self.pers[#"team"]] * 1000);
    if (wavedelay == 0) {
        return 0;
    }
    numwavespassedearliestspawntime = (earliestspawntime - lastwavetime) / wavedelay;
    numwaves = ceil(numwavespassedearliestspawntime);
    timeofspawn = lastwavetime + numwaves * wavedelay;
    if (isdefined(self.wavespawnindex)) {
        timeofspawn += 50 * self.wavespawnindex;
    }
    return float(timeofspawn - gettime()) / 1000;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xeb403ba7, Offset: 0xbb8
// Size: 0x46
function stoppoisoningandflareonspawn() {
    self endon(#"disconnect");
    self.inpoisonarea = 0;
    self.inburnarea = 0;
    self.inflarevisionarea = 0;
    self.ingroundnapalm = 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x10c6a370, Offset: 0xc08
// Size: 0x130
function spawnplayerprediction() {
    self endon(#"disconnect", #"end_respawn", #"game_ended", #"joined_spectators", #"spawned");
    plrs = teams::count_players();
    if (is_true(level.var_153e7dad)) {
        return;
    }
    nolivesleft = level.numlives && !self.pers[#"lives"] || level.numteamlives && game.lives[self.team] > 0;
    if (nolivesleft) {
        return;
    }
    while (true) {
        wait 0.5;
        spawning::onspawnplayer(1);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x84dc3565, Offset: 0xd40
// Size: 0x1b4
function playmatchstartaudio(team) {
    self endon(#"disconnect");
    for (index = 0; index < 5; index++) {
        waitframe(1);
    }
    if (self.pers[#"playedgamemode"] !== 1) {
        if (level.hardcoremode) {
            if (globallogic_utils::function_308e3379()) {
                self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_d04b3734);
            } else {
                self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog);
            }
        } else if (globallogic_utils::function_308e3379()) {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_f6fda321);
        } else {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog);
        }
        self.pers[#"playedgamemode"] = 1;
    }
    if (team == game.attackers) {
        self globallogic_audio::leader_dialog_on_player(level.leaderdialog.offenseorderdialog);
        return;
    }
    self globallogic_audio::leader_dialog_on_player(level.leaderdialog.defenseorderdialog);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0xd9bd2e3a, Offset: 0xf00
// Size: 0x194
function doinitialspawnmessaging(*params) {
    pixbeginevent(#"sound");
    if (sessionmodeismultiplayergame() && !is_true(self.var_b279086a)) {
        self show();
        self solid();
    }
    if (level.gametype !== "bounty") {
        if (isdefined(self.pers[#"music"].spawn) && self.pers[#"music"].spawn == 0) {
            self.pers[#"music"].spawn = 1;
        }
    }
    if (level.splitscreen) {
        if (isdefined(level.playedstartingmusic)) {
            music = undefined;
        } else {
            level.playedstartingmusic = 1;
        }
    }
    self.playleaderdialog = 1;
    if (isdefined(level.leaderdialog)) {
        self thread playmatchstartaudio(self.pers[#"team"]);
    }
    pixendevent();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xbe586d6f, Offset: 0x10a0
// Size: 0xe
function resetattackersthisspawnlist() {
    self.attackersthisspawn = [];
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x7760d014, Offset: 0x10b8
// Size: 0xd8
function function_baf09253() {
    if (!isdefined(level.spawn_manager.queue)) {
        level.spawn_manager.queue = [];
    } else if (!isarray(level.spawn_manager.queue)) {
        level.spawn_manager.queue = array(level.spawn_manager.queue);
    }
    if (!isinarray(level.spawn_manager.queue, self)) {
        level.spawn_manager.queue[level.spawn_manager.queue.size] = self;
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xcdbffcd5, Offset: 0x1198
// Size: 0xc0
function function_4ce66c5b() {
    foreach (index, player in level.spawn_manager.queue) {
        if (self == player) {
            level.spawn_manager.queue = array::remove_index(level.spawn_manager.queue, index, 0);
            return;
        }
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xcb491439, Offset: 0x1260
// Size: 0x246
function function_621bbb3() {
    if (!isdefined(level.spawn_manager)) {
        level.spawn_manager = {#queue:[]};
    }
    var_fc6b3d59 = getdvarint(#"hash_1d65ee43ab40a691", 1);
    var_75b515ff = getdvarfloat(#"hash_117d09abf84fb041", float(16) / 1000);
    while (true) {
        if (gamestate::is_game_over()) {
            return;
        }
        arrayremovevalue(level.spawn_manager.queue, undefined);
        if (level.spawn_manager.queue.size > 0) {
            var_f16b79a = 0;
            foreach (index, player in level.spawn_manager.queue) {
                if (var_f16b79a >= var_fc6b3d59) {
                    break;
                }
                assert(!isalive(player));
                assert(player.sessionstate == "<dev string:x38>" || player.sessionstate == "<dev string:x40>");
                player thread spawnplayer();
                level.spawn_manager.queue[index] = undefined;
                var_f16b79a++;
            }
        }
        wait var_75b515ff;
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xcf1c2fe9, Offset: 0x14b0
// Size: 0xd9c
function spawnplayer() {
    if (getdvarint(#"hash_538d8545b881ef93") > 0) {
        setdvar(#"r_jqprof_capture", 1);
        waitframe(1);
    }
    pixbeginevent(#"spawnplayer_preuts");
    self endon(#"disconnect", #"joined_spectators");
    hadspawned = self.hasspawned;
    self player::spawn_player();
    if (globallogic_utils::getroundstartdelay()) {
        self thread globallogic_utils::applyroundstartdelay();
    }
    if (isdefined(self.spawnlightarmor) && self.spawnlightarmor > 0) {
        self thread armor::setlightarmor(self.spawnlightarmor);
    }
    self.nextkillstreakfree = undefined;
    self.deathmachinekills = 0;
    self resetattackersthisspawnlist();
    self.diedonvehicle = undefined;
    if (is_false(self.wasaliveatmatchstart)) {
        if (level.ingraceperiod || globallogic_utils::gettimepassed() < int(20 * 1000)) {
            self.wasaliveatmatchstart = 1;
            self globallogic_ui::function_bc2eb1b8();
        }
    }
    pixbeginevent(#"onspawnplayer");
    self [[ level.onspawnplayer ]](0);
    if (isdefined(level.playerspawnedcb)) {
        self [[ level.playerspawnedcb ]]();
    }
    pixendevent();
    pixendevent();
    level thread globallogic::updateteamstatus();
    pixbeginevent(#"spawnplayer_postuts");
    self val::nuke("disable_oob");
    self thread stoppoisoningandflareonspawn();
    self.sensorgrenadedata = undefined;
    self.var_342564dd = 0;
    self.var_6a9b15ba = undefined;
    self.var_ec59e88c = undefined;
    self.var_f7900902 = undefined;
    if (level.var_b3c4b7b7 === 1) {
        self player_role::clear();
        draft::assign_remaining_players(self);
    }
    role = self player_role::get();
    assert(!loadout::function_87bcb1b() || globallogic_utils::isvalidclass(self.curclass));
    assert(player_role::is_valid(role));
    self.pers[#"momentum_at_spawn_or_game_end"] = isdefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0;
    if (loadout::function_87bcb1b()) {
        self loadout::function_53b62db1(self.curclass);
    }
    var_e0f216b9 = 1;
    self loadout::give_loadout(self.team, self.curclass, var_e0f216b9);
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        specialist = function_b14806c6(role, currentsessionmode());
        if (isdefined(specialist)) {
            self function_6c3348ac(specialist);
        }
        var_be574bd8 = self function_b568258e();
        outfitindex = self getcharacteroutfit();
        gender = self getplayergendertype();
        warpaintoutfitindex = self function_3d1a97c6();
        var_8fa79650 = self function_564cfaeb();
        decallootid = self function_e1c06cd0();
        var_b3d9cfaa = self function_11d0e790();
        var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
        if (isdefined(var_f8e6b703)) {
            self match_record::set_stat(#"lives", var_f8e6b703, #"character_gender", gender);
            self match_record::set_stat(#"lives", var_f8e6b703, #"character_decal_lootid", decallootid);
            self match_record::set_stat(#"lives", var_f8e6b703, #"character_outfit_lootid", var_be574bd8);
            self match_record::set_stat(#"lives", var_f8e6b703, #"character_warpaint_lootid", var_8fa79650);
            self match_record::set_stat(#"lives", var_f8e6b703, #"character_outfit", outfitindex);
            self match_record::set_stat(#"lives", var_f8e6b703, #"character_warpaint_outfit", warpaintoutfitindex);
            for (i = 0; i < var_b3d9cfaa.size; i++) {
                self match_record::set_stat(#"lives", var_f8e6b703, #"hash_20d6751cb2f9ca09", i, var_b3d9cfaa[i]);
            }
        }
    }
    pixendevent();
    if (is_true(getgametypesetting(#"hash_2966662989c3484c"))) {
        self function_8a945c0e(1);
        self function_8b8a321a(1);
    }
    self squad_spawn::spawn_player();
    pixbeginevent(#"hash_7411f890f210f198");
    if (level.inprematchperiod) {
        var_60653c9b = 0;
        /#
            if (function_7373cc35()) {
                var_60653c9b = 0;
            }
        #/
        if (!var_60653c9b) {
            if (!is_true(level.var_3d1e480e)) {
                self val::set(#"spawn_player", "freezecontrols");
            }
            self val::set(#"spawn_player", "disablegadgets");
            if (sessionmodeismultiplayergame() && !is_true(level.var_b82a5c35)) {
                self notsolid();
            }
        }
        self callback::on_prematch_end(&doinitialspawnmessaging);
    } else {
        self val::reset(#"spawn_player", "freezecontrols");
        self val::reset(#"spawn_player", "disablegadgets");
        self enableweapons();
        if (!is_true(hadspawned) && game.state == "playing") {
            self thread doinitialspawnmessaging();
        }
    }
    if (is_true(level.scoreresetondeath)) {
        self globallogic_score::resetplayermomentumonspawn();
    } else {
        self globallogic_score::function_1ceb2820();
    }
    self.deathtime = 0;
    self.pers[#"deathtime"] = 0;
    if (self hasperk(#"specialty_anteup")) {
        anteup_bonus = getdvarint(#"perk_killstreakanteupresetvalue", 0);
        if (self.pers[#"momentum_at_spawn_or_game_end"] < anteup_bonus) {
            globallogic_score::_setplayermomentum(self, anteup_bonus, 0);
        }
    }
    if (!isdefined(getdvar(#"scr_showperksonspawn"))) {
        setdvar(#"scr_showperksonspawn", 0);
    }
    if (level.hardcoremode) {
        setdvar(#"scr_showperksonspawn", 0);
    }
    /#
        if (getdvarint(#"scr_showperksonspawn", 0) == 1 && !gamestate::is_game_over()) {
            pixbeginevent(#"showperksonspawn");
            if (level.perksenabled == 1) {
                self hud::showperks();
            }
            pixendevent();
        }
    #/
    if (isdefined(self.pers[#"momentum"])) {
        self.momentum = self.pers[#"momentum"];
    }
    self setsprintboost(0);
    pixendevent();
    waittillframeend();
    self notify(#"spawned_player");
    callback::callback(#"on_player_spawned");
    self thread player_monitor::monitor();
    /#
        print("<dev string:x4d>" + self.origin[0] + "<dev string:x53>" + self.origin[1] + "<dev string:x53>" + self.origin[2] + "<dev string:x58>");
    #/
    setdvar(#"scr_selecting_location", "");
    if (gamestate::is_game_over()) {
        assert(!level.intermission);
        self player::freeze_player_for_round_end();
    }
    self util::set_lighting_state();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x90952c7c, Offset: 0x2258
// Size: 0x5c
function on_end_game() {
    self.pers[#"momentum_at_spawn_or_game_end"] = isdefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x1 linked
// Checksum 0x6f095d58, Offset: 0x22c0
// Size: 0x4c
function spawnspectator(origin, angles) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x1 linked
// Checksum 0x1060abb0, Offset: 0x2318
// Size: 0x2c
function respawn_asspectator(origin, angles) {
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xc7935b12, Offset: 0x2350
// Size: 0x1ce
function function_3ee5119e() {
    if (self.pers[#"team"] != #"spectator" && level.spectatetype == 5 && self.var_ba35b2d2 == #"invalid") {
        var_74578e76 = function_c65231e2(self.squad);
        player = spectating::function_327e6270(var_74578e76, &spectating::function_44d43a69, #"invalid");
        assert(isdefined(player));
        self.var_ba35b2d2 = player.squad;
    }
    if (self.pers[#"team"] != #"spectator" && level.spectatetype == 4 && self.spectatorteam == #"invalid") {
        team_players = getplayers(self.team);
        player = spectating::function_327e6270(team_players, &spectating::spectator_team, #"invalid");
        assert(isdefined(player));
        self.spectatorteam = player.team;
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x5 linked
// Checksum 0xcaa8781e, Offset: 0x2528
// Size: 0x66
function private function_9ead6959() {
    if (self.pers[#"team"] == #"spectator") {
        return true;
    }
    if (level.spectatetype != 5 || level.spectatetype != 4) {
        return true;
    }
    return false;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x1 linked
// Checksum 0x35765da9, Offset: 0x2598
// Size: 0x164
function in_spawnspectator(origin, angles) {
    pixmarker("BEGIN: in_spawnSpectator");
    self player::set_spawn_variables();
    self.sessionstate = "spectator";
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    if (self.pers[#"team"] == #"spectator") {
        self.statusicon = "";
    } else {
        self.statusicon = "hud_status_dead";
    }
    if (function_9ead6959()) {
        self.spectatorclient = -1;
        spectating::set_permissions_for_machine();
    }
    function_3ee5119e();
    [[ level.onspawnspectator ]](origin, angles);
    level thread globallogic::updateteamstatus();
    pixmarker("END: in_spawnSpectator");
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xed0734fc, Offset: 0x2708
// Size: 0x148
function forcespawn(time) {
    self endon(#"death", #"disconnect", #"spawned");
    if (!isdefined(time)) {
        time = 60;
    }
    wait time;
    if (is_true(self.hasspawned)) {
        return;
    }
    if (self.pers[#"team"] == #"spectator") {
        return;
    }
    if (!globallogic_utils::isvalidclass(self.pers[#"class"])) {
        self.pers[#"class"] = "CLASS_CUSTOM1";
        self.curclass = self.pers[#"class"];
    }
    if (!self function_8b1a219a()) {
        self globallogic_ui::closemenus();
    }
    self thread [[ level.spawnclient ]]();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x8f9c7e69, Offset: 0x2858
// Size: 0x64
function kickifdontspawn() {
    /#
        if (getdvarint(#"scr_hostmigrationtest", 0) == 1) {
            return;
        }
    #/
    if (self ishost()) {
        return;
    }
    self kickifidontspawninternal();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x23c631b8, Offset: 0x28c8
// Size: 0x29c
function kickifidontspawninternal() {
    self endon(#"death", #"disconnect", #"spawned");
    while (true) {
        if (!is_true(level.inprematchperiod) && self isstreamerready()) {
            break;
        }
        wait 5;
    }
    waittime = 90;
    if (getdvarstring(#"scr_kick_time") != "") {
        waittime = getdvarfloat(#"scr_kick_time", 0);
    }
    mintime = 45;
    if (getdvarstring(#"scr_kick_mintime") != "") {
        mintime = getdvarfloat(#"scr_kick_mintime", 0);
    }
    starttime = gettime();
    kickwait(waittime);
    timepassed = float(gettime() - starttime) / 1000;
    if (timepassed < waittime - 0.1 && timepassed < mintime) {
        return;
    }
    if (is_true(self.hasspawned)) {
        return;
    }
    if (sessionmodeisprivate()) {
        return;
    }
    if (self.pers[#"team"] == #"spectator") {
        return;
    }
    if (!mayspawn() && self.pers[#"time_played_total"] > 0) {
        return;
    }
    globallogic::gamehistoryplayerkicked();
    kick(self getentitynumber(), "EXE/PLAYERKICKED_NOTSPAWNED");
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x89da090c, Offset: 0x2b70
// Size: 0x34
function kickwait(waittime) {
    level endon(#"game_ended");
    hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x15c1f101, Offset: 0x2bb0
// Size: 0x16c
function spawninterroundintermission() {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self player::set_spawn_variables();
    self hud_message::clearlowermessage();
    self val::reset(#"spawn_player", "freezecontrols");
    self val::reset(#"spawn_player", "disablegadgets");
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    self globallogic_defaults::default_onspawnintermission();
    self setorigin(self.origin);
    self setplayerangles(self.angles);
    self clientfield::set_to_player("player_dof_settings", 2);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x1 linked
// Checksum 0x9829b543, Offset: 0x2d28
// Size: 0x174
function spawnintermission(usedefaultcallback, endgame) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self endon(#"disconnect");
    self player::set_spawn_variables();
    self hud_message::clearlowermessage();
    self val::reset(#"spawn_player", "freezecontrols");
    self val::reset(#"spawn_player", "disablegadgets");
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    if (isdefined(usedefaultcallback) && usedefaultcallback) {
        globallogic_defaults::default_onspawnintermission();
    } else {
        [[ level.onspawnintermission ]](endgame);
    }
    self clientfield::set_to_player("player_dof_settings", 2);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x4667aea8, Offset: 0x2ea8
// Size: 0xb8
function spawnqueuedclientonteam(team) {
    player_to_spawn = undefined;
    for (i = 0; i < level.deadplayers[team].size; i++) {
        player = level.deadplayers[team][i];
        if (player.waitingtospawn) {
            continue;
        }
        player_to_spawn = player;
        break;
    }
    if (isdefined(player_to_spawn)) {
        player_to_spawn.allowqueuespawn = 1;
        player_to_spawn globallogic_ui::closemenus();
        player_to_spawn thread [[ level.spawnclient ]]();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x1 linked
// Checksum 0x9dcdd6be, Offset: 0x2f68
// Size: 0x130
function spawnqueuedclient(dead_player_team, killer) {
    if (!level.playerqueuedrespawn) {
        return;
    }
    util::waittillslowprocessallowed();
    spawn_team = undefined;
    if (isdefined(killer) && isdefined(killer.team) && isdefined(level.teams[killer.team])) {
        spawn_team = killer.team;
    }
    if (isdefined(spawn_team)) {
        spawnqueuedclientonteam(spawn_team);
        return;
    }
    foreach (team, _ in level.teams) {
        if (team == dead_player_team) {
            continue;
        }
        spawnqueuedclientonteam(team);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x9b8dfe93, Offset: 0x30a0
// Size: 0xd6
function allteamsnearscorelimit() {
    if (!level.teambased) {
        return false;
    }
    if (level.scorelimit <= 1) {
        return false;
    }
    foreach (team, _ in level.teams) {
        if (!(game.stat[#"teamscores"][team] >= level.scorelimit - 1)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x6b69a82a, Offset: 0x3180
// Size: 0x6e
function shouldshowrespawnmessage() {
    if (util::waslastround()) {
        return false;
    }
    if (util::isoneround()) {
        return false;
    }
    if (isdefined(level.livesdonotreset) && level.livesdonotreset) {
        return false;
    }
    if (allteamsnearscorelimit()) {
        return false;
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x8bfdc2a2, Offset: 0x31f8
// Size: 0x64
function default_spawnmessage() {
    if (util::getroundsplayed() + 1 < level.roundlimit) {
        hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
        self thread globallogic_ui::removespawnmessageshortly(3);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xda90ab74, Offset: 0x3268
// Size: 0x28
function showspawnmessage() {
    if (shouldshowrespawnmessage()) {
        self thread [[ level.spawnmessage ]]();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0xac1f3680, Offset: 0x3298
// Size: 0x1f6
function spawnclient(timealreadypassed) {
    pixbeginevent(#"spawnclient");
    assert(isdefined(self.team));
    assert(!loadout::function_87bcb1b() || globallogic_utils::isvalidclass(self.curclass));
    if (!self mayspawn() && !is_true(self.usedresurrect)) {
        currentorigin = self.origin;
        currentangles = self.angles;
        self showspawnmessage();
        self thread [[ level.spawnspectator ]](currentorigin + (0, 0, 60), currentangles);
        pixendevent();
        return;
    }
    if (is_true(self.waitingtospawn)) {
        pixendevent();
        return;
    }
    self.waitingtospawn = 1;
    self.allowqueuespawn = undefined;
    if (!is_true(level.takelivesondeath)) {
        game.lives[self.team]--;
    }
    pixendevent();
    self waitandspawnclient(timealreadypassed);
    if (isdefined(self)) {
        self.waitingtospawn = 0;
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x31b502cb, Offset: 0x3498
// Size: 0x708
function waitandspawnclient(timealreadypassed) {
    self endon(#"disconnect", #"end_respawn");
    level endon(#"game_ended");
    spawnedasspectator = 0;
    userespawntime = isdefined(timealreadypassed) ? 1 : 0;
    if (squad_spawn::function_d072f205()) {
        thread squad_spawn::function_5f24fd47(self, userespawntime);
        self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        spawnedasspectator = 1;
    }
    if (!isdefined(timealreadypassed)) {
        timealreadypassed = 0;
    }
    if (is_true(self.teamkillpunish)) {
        var_821200bb = player::function_821200bb();
        if (var_821200bb > timealreadypassed) {
            var_821200bb -= timealreadypassed;
        } else {
            var_821200bb = 0;
        }
        if (var_821200bb > 0) {
            hud_message::setlowermessage(#"mp/friendly_fire_will_not", var_821200bb);
            self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
            spawnedasspectator = 1;
            wait var_821200bb;
        }
        self.teamkillpunish = 0;
    }
    if (!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team])) {
        self.wavespawnindex = level.waveplayerspawnindex[self.team];
        level.waveplayerspawnindex[self.team]++;
    }
    timeuntilspawn = timeuntilspawn(0);
    if (timeuntilspawn > timealreadypassed) {
        timeuntilspawn -= timealreadypassed;
    } else {
        timeuntilspawn = 0;
    }
    if (timeuntilspawn > 0) {
        var_3ffa560b = squad_spawn::function_d072f205() && self clientfield::get_player_uimodel("hudItems.squadSpawnSquadWipe");
        if (!var_3ffa560b) {
            if (level.playerqueuedrespawn) {
                hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
            } else {
                hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
            }
        }
        if (!spawnedasspectator) {
            spawnorigin = self.origin + (0, 0, 60);
            spawnangles = self.angles;
            if (isdefined(level.useintermissionpointsonwavespawn) && [[ level.useintermissionpointsonwavespawn ]]() == 1) {
                spawnpoint = spawning::get_random_intermission_point();
                if (isdefined(spawnpoint)) {
                    spawnorigin = spawnpoint.origin;
                    spawnangles = spawnpoint.angles;
                }
            }
            self thread respawn_asspectator(spawnorigin, spawnangles);
        }
        spawnedasspectator = 1;
        self notify(#"waitingtospawn", {#timeuntilspawn:timeuntilspawn});
        while (true) {
            var_d4dbe16 = gettime();
            self waittilltimeout(timeuntilspawn, #"force_spawn", #"hash_33713849648e651d");
            timealreadypassed = float(gettime() - var_d4dbe16) / 1000 + timealreadypassed;
            var_3ffa560b = squad_spawn::function_d072f205() && self clientfield::get_player_uimodel("hudItems.squadSpawnSquadWipe");
            var_239ada2f = timeuntilspawn(0);
            if (!var_3ffa560b) {
                if (var_239ada2f > timealreadypassed) {
                    var_239ada2f -= timealreadypassed;
                } else {
                    var_239ada2f = 0;
                }
            }
            if (var_239ada2f <= 0) {
                break;
            }
            timeuntilspawn = var_239ada2f;
            if (!var_3ffa560b) {
                if (level.playerqueuedrespawn) {
                    hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
                } else {
                    hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
                }
                continue;
            }
            hud_message::clearlowermessage();
        }
        self notify(#"stop_wait_safe_spawn_button");
    }
    if (function_b142f8d4()) {
        if (squad_spawn::function_d072f205()) {
            self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 1);
            hud_message::clearlowermessage();
            self squad_spawn::function_6a7e8977();
        } else {
            hud_message::setlowermessage(game.strings[#"press_to_spawn"]);
        }
        if (!spawnedasspectator) {
            self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        }
        spawnedasspectator = 1;
        self waitrespawnorsafespawnbutton();
    }
    self.waitingtospawn = 0;
    self hud_message::clearlowermessage();
    self.wavespawnindex = undefined;
    self.respawntimerstarttime = undefined;
    self.pers[#"spawns"]++;
    self thread [[ level.spawnplayer ]]();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x5 linked
// Checksum 0xfc338329, Offset: 0x3ba8
// Size: 0xbe
function private function_b142f8d4() {
    if (level.playerforcerespawn) {
        return false;
    }
    if (!self.hasspawned) {
        return false;
    }
    wavebased = level.waverespawndelay > 0;
    if (wavebased && !(isdefined(getgametypesetting(#"hash_2b1f40bc711c41f3")) ? getgametypesetting(#"hash_2b1f40bc711c41f3") : 0)) {
        return false;
    }
    if (self.wantsafespawn) {
        return false;
    }
    if (level.playerqueuedrespawn) {
        return false;
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xda33f5c2, Offset: 0x3c70
// Size: 0xa4
function waitrespawnorsafespawnbutton() {
    self endon(#"disconnect", #"end_respawn");
    while (true) {
        if (squad_spawn::function_d072f205()) {
            if (self squad_spawn::function_2ffd5f18()) {
                break;
            }
        } else if (!is_true(self.var_20250438)) {
            if (self usebuttonpressed()) {
                break;
            }
        }
        waitframe(1);
    }
}

