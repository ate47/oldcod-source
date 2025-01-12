#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\round;

#namespace globallogic_audio;

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x2
// Checksum 0xbb4b7a87, Offset: 0x558
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"globallogic_audio", &__init__, undefined, undefined);
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x4bf8da7e, Offset: 0x5a0
// Size: 0x6e
function __init__() {
    callback::on_start_gametype(&init);
    level.playleaderdialogonplayer = &leader_dialog_on_player;
    level.playequipmentdestroyedonplayer = &play_equipment_destroyed_on_player;
    level.playequipmenthackedonplayer = &play_equipment_hacked_on_player;
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x9b1913c8, Offset: 0x618
// Size: 0x84a
function init() {
    game.music[#"defeat"] = "mus_defeat";
    game.music[#"victory_spectator"] = "mus_defeat";
    game.music[#"winning"] = "mus_time_running_out_winning";
    game.music[#"losing"] = "mus_time_running_out_losing";
    game.music[#"match_end"] = "mus_match_end";
    game.music[#"victory_tie"] = "mus_defeat";
    game.music[#"spawn_short"] = "SPAWN_SHORT";
    game.music[#"suspense"] = [];
    game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_01";
    game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_02";
    game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_03";
    game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_04";
    game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_05";
    game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_06";
    level callback::function_1dea870d(#"on_end_game", &on_end_game);
    level.multipledialogkeys = [];
    level.multipledialogkeys[#"enemyaitank"] = "enemyAiTankMultiple";
    level.multipledialogkeys[#"enemysupplydrop"] = "enemySupplyDropMultiple";
    level.multipledialogkeys[#"enemycombatrobot"] = "enemyCombatRobotMultiple";
    level.multipledialogkeys[#"enemycounteruav"] = "enemyCounterUavMultiple";
    level.multipledialogkeys[#"enemydart"] = "enemyDartMultiple";
    level.multipledialogkeys[#"enemyemp"] = "enemyEmpMultiple";
    level.multipledialogkeys[#"hash_1feb9f6dc95d56df"] = "enemySentinelMultiple";
    level.multipledialogkeys[#"enemymicrowaveturret"] = "enemyMicrowaveTurretMultiple";
    level.multipledialogkeys[#"enemyrcbomb"] = "enemyRcBombMultiple";
    level.multipledialogkeys[#"enemyplanemortar"] = "enemyPlaneMortarMultiple";
    level.multipledialogkeys[#"enemyhelicoptergunner"] = "enemyHelicopterGunnerMultiple";
    level.multipledialogkeys[#"enemyraps"] = "enemyRapsMultiple";
    level.multipledialogkeys[#"enemydronestrike"] = "enemyDroneStrikeMultiple";
    level.multipledialogkeys[#"enemyturret"] = "enemyTurretMultiple";
    level.multipledialogkeys[#"enemyhelicopter"] = "enemyHelicopterMultiple";
    level.multipledialogkeys[#"enemyuav"] = "enemyUavMultiple";
    level.multipledialogkeys[#"enemysatellite"] = "enemySatelliteMultiple";
    level.multipledialogkeys[#"friendlyaitank"] = "";
    level.multipledialogkeys[#"friendlysupplydrop"] = "";
    level.multipledialogkeys[#"friendlycombatrobot"] = "";
    level.multipledialogkeys[#"friendlycounteruav"] = "";
    level.multipledialogkeys[#"friendlydart"] = "";
    level.multipledialogkeys[#"friendlyemp"] = "";
    level.multipledialogkeys[#"hash_46e3ab0231528832"] = "";
    level.multipledialogkeys[#"friendlymicrowaveturret"] = "";
    level.multipledialogkeys[#"friendlyrcbomb"] = "";
    level.multipledialogkeys[#"friendlyplanemortar"] = "";
    level.multipledialogkeys[#"friendlyhelicoptergunner"] = "";
    level.multipledialogkeys[#"friendlyraps"] = "";
    level.multipledialogkeys[#"friendlydronestrike"] = "";
    level.multipledialogkeys[#"friendlyturret"] = "";
    level.multipledialogkeys[#"friendlyhelicopter"] = "";
    level.multipledialogkeys[#"friendlyuav"] = "";
    level.multipledialogkeys[#"friendlysatellite"] = "";
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x45f4e33a, Offset: 0xe70
// Size: 0x2ba
function function_af3f9891(var_7b0e81b, taacombundle) {
    bundlename = undefined;
    switch (var_7b0e81b) {
    case #"tank_robot":
        bundlename = taacombundle.aitankdialogbundle;
        break;
    case #"counteruav":
        bundlename = taacombundle.counteruavdialogbundle;
        break;
    case #"dart":
        bundlename = taacombundle.dartdialogbundle;
        break;
    case #"drone_squadron":
        bundlename = taacombundle.var_6da8e496;
        break;
    case #"ac130":
        bundlename = taacombundle.var_2dde669a;
        break;
    case #"helicopter_comlink":
        bundlename = taacombundle.helicopterdialogbundle;
        break;
    case #"overwatch_helicopter":
        bundlename = taacombundle.overwatchhelicopterdialogbundle;
        break;
    case #"overwatch_helicopter_snipers":
        bundlename = taacombundle.var_266c3ff9;
        break;
    case #"planemortar":
        bundlename = taacombundle.planemortardialogbundle;
        break;
    case #"recon_car":
        bundlename = taacombundle.rcbombdialogbundle;
        break;
    case #"remote_missile":
        bundlename = taacombundle.remotemissiledialogbundle;
        break;
    case #"straferun":
        bundlename = taacombundle.straferundialogbundle;
        break;
    case #"supply_drop":
        bundlename = taacombundle.supplydropdialogbundle;
        break;
    case #"swat_team":
        bundlename = taacombundle.var_53d97d33;
        break;
    case #"uav":
        bundlename = taacombundle.uavdialogbundle;
        break;
    case #"ultimate_turret":
        bundlename = taacombundle.ultturretdialogbundle;
        break;
    default:
        break;
    }
    if (!isdefined(bundlename)) {
        return;
    }
    killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", bundlename);
    return killstreakbundle;
}

// Namespace globallogic_audio/globallogic_audio
// Params 4, eflags: 0x0
// Checksum 0xb94b4cfb, Offset: 0x1138
// Size: 0x8e
function set_leader_gametype_dialog(startgamedialogkey, starthcgamedialogkey, offenseorderdialogkey, defenseorderdialogkey) {
    level.leaderdialog = spawnstruct();
    level.leaderdialog.startgamedialog = startgamedialogkey;
    level.leaderdialog.starthcgamedialog = starthcgamedialogkey;
    level.leaderdialog.offenseorderdialog = offenseorderdialogkey;
    level.leaderdialog.defenseorderdialog = defenseorderdialogkey;
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x2d0146d3, Offset: 0x11d0
// Size: 0x1c
function function_8065d7d5() {
    leader_dialog("roundSwitchSides");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x7ab1d13, Offset: 0x11f8
// Size: 0x1c
function function_eb44731f() {
    leader_dialog("roundHalftime");
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xc12cd9e0, Offset: 0x1220
// Size: 0x1a4
function announce_round_winner(delay) {
    if (delay > 0) {
        wait delay;
    }
    winner = round::get_winner();
    if (!isdefined(winner) || isplayer(winner)) {
        return;
    }
    if (isdefined(level.teams[winner])) {
        if (level.gametype !== "bounty") {
            leader_dialog("roundEncourageWon", winner);
            leader_dialog_for_other_teams("roundEncourageLost", winner);
        } else {
            leader_dialog("bountyRoundEncourageWon", winner);
            leader_dialog_for_other_teams("bountyRoundEncourageLost", winner);
        }
        return;
    }
    foreach (team, _ in level.teams) {
        thread sound::play_on_players("mus_round_draw" + "_" + level.teampostfix[team]);
    }
    leader_dialog("roundDraw");
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x75c4ac4e, Offset: 0x13d0
// Size: 0xe4
function announce_game_winner(outcome) {
    wait battlechatter::mpdialog_value("announceWinnerDelay", 0);
    if (level.teambased) {
        if (outcome::get_flag(outcome, "tie") || !match::function_c6c8145e()) {
            leader_dialog("gameDraw");
            return;
        }
        leader_dialog("gameWon", outcome::get_winner(outcome));
        leader_dialog_for_other_teams("gameLost", outcome::get_winner(outcome));
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x62e80c8e, Offset: 0x14c0
// Size: 0xc
function function_e89544a8(outcome) {
    
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x37eb347f, Offset: 0x14d8
// Size: 0x9c
function function_fa0ee392(tie) {
    if (tie) {
        self set_music_on_player("matchDraw");
        return;
    }
    if (match::function_356f8b9b(self)) {
        self set_music_on_player("matchWin");
        return;
    }
    if (!level.splitscreen) {
        self set_music_on_player("matchLose");
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x54fbfac4, Offset: 0x1580
// Size: 0x80
function flush_dialog() {
    foreach (player in level.players) {
        player flush_dialog_on_player();
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xcb5faae5, Offset: 0x1608
// Size: 0x3e
function flush_dialog_on_player() {
    self.leaderdialogqueue = [];
    self.currentleaderdialog = undefined;
    self.killstreakdialogqueue = [];
    self.scorestreakdialogplaying = 0;
    self notify(#"flush_dialog");
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x38e3fe1e, Offset: 0x1650
// Size: 0x7e
function flush_killstreak_dialog_on_player(killstreakid) {
    if (!isdefined(killstreakid)) {
        return;
    }
    for (i = self.killstreakdialogqueue.size - 1; i >= 0; i--) {
        if (killstreakid === self.killstreakdialogqueue[i].killstreakid) {
            arrayremoveindex(self.killstreakdialogqueue, i);
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x2e7f5e7f, Offset: 0x16d8
// Size: 0x88
function flush_objective_dialog(objectivekey) {
    foreach (player in level.players) {
        player flush_objective_dialog_on_player(objectivekey);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x300e9a0d, Offset: 0x1768
// Size: 0x82
function flush_objective_dialog_on_player(objectivekey) {
    if (!isdefined(objectivekey)) {
        return;
    }
    for (i = self.leaderdialogqueue.size - 1; i >= 0; i--) {
        if (objectivekey === self.leaderdialogqueue[i].objectivekey) {
            arrayremoveindex(self.leaderdialogqueue, i);
            break;
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xcab86a6a, Offset: 0x17f8
// Size: 0x88
function flush_leader_dialog_key(dialogkey) {
    foreach (player in level.players) {
        player flush_leader_dialog_key_on_player(dialogkey);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xd19e138c, Offset: 0x1888
// Size: 0x7e
function flush_leader_dialog_key_on_player(dialogkey) {
    if (!isdefined(dialogkey)) {
        return;
    }
    for (i = self.leaderdialogqueue.size - 1; i >= 0; i--) {
        if (dialogkey === self.leaderdialogqueue[i].dialogkey) {
            arrayremoveindex(self.leaderdialogqueue, i);
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 3, eflags: 0x0
// Checksum 0xc51d95a2, Offset: 0x1910
// Size: 0x3c
function play_taacom_dialog(dialogkey, killstreaktype, killstreakid) {
    self killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid);
}

// Namespace globallogic_audio/globallogic_audio
// Params 4, eflags: 0x0
// Checksum 0xe4926df4, Offset: 0x1958
// Size: 0x144
function killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(dialogkey)) {
        return;
    }
    if (!level.allowannouncer) {
        return;
    }
    if (level.gameended) {
        return;
    }
    newdialog = spawnstruct();
    newdialog.dialogkey = dialogkey;
    newdialog.killstreaktype = killstreaktype;
    newdialog.pilotindex = pilotindex;
    newdialog.killstreakid = killstreakid;
    self.killstreakdialogqueue[self.killstreakdialogqueue.size] = newdialog;
    if (self.killstreakdialogqueue.size > 1 || isdefined(self.currentkillstreakdialog)) {
        return;
    }
    if (self.playingdialog === 1 && dialogkey == "arrive") {
        self thread wait_for_player_dialog();
        return;
    }
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x5f85957a, Offset: 0x1aa8
// Size: 0x6c
function wait_for_player_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    while (self.playingdialog) {
        wait 0.5;
    }
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xd6c5a500, Offset: 0x1b20
// Size: 0x29c
function play_next_killstreak_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    if (self.killstreakdialogqueue.size == 0) {
        self.currentkillstreakdialog = undefined;
        return;
    }
    nextdialog = self.killstreakdialogqueue[0];
    arrayremoveindex(self.killstreakdialogqueue, 0);
    if (isdefined(self.pers[#"mptaacom"])) {
        taacombundle = struct::get_script_bundle("mpdialog_taacom", self.pers[#"mptaacom"]);
    }
    if (isdefined(taacombundle)) {
        if (isdefined(nextdialog.killstreaktype)) {
            if (isdefined(nextdialog.pilotindex)) {
                pilotarray = taacombundle.pilotbundles[nextdialog.killstreaktype];
                if (isdefined(pilotarray) && nextdialog.pilotindex < pilotarray.size) {
                    killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", pilotarray[nextdialog.pilotindex]);
                    if (isdefined(killstreakbundle)) {
                        dialogalias = get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
                    }
                }
            } else if (isdefined(nextdialog.killstreaktype)) {
                killstreakbundle = function_af3f9891(nextdialog.killstreaktype, taacombundle);
                if (isdefined(killstreakbundle)) {
                    dialogalias = self get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
                }
            }
        } else {
            dialogalias = self get_dialog_bundle_alias(taacombundle, nextdialog.dialogkey);
        }
    }
    if (!isdefined(dialogalias)) {
        self play_next_killstreak_dialog();
        return;
    }
    self playlocalsound(dialogalias);
    self.currentkillstreakdialog = nextdialog;
    self thread wait_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xde1ccf3b, Offset: 0x1dc8
// Size: 0x6c
function wait_next_killstreak_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    wait battlechatter::mpdialog_value("killstreakDialogBuffer", 0);
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 5, eflags: 0x0
// Checksum 0xdce1296d, Offset: 0x1e40
// Size: 0xe0
function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
    assert(isdefined(skipteam));
    foreach (team, _ in level.teams) {
        if (team != skipteam) {
            leader_dialog(dialogkey, team, undefined, objectivekey, killstreakid, dialogbufferkey);
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 6, eflags: 0x0
// Checksum 0xbe6785b, Offset: 0x1f28
// Size: 0x160
function leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey) {
    assert(isdefined(level.players));
    foreach (player in level.players) {
        if (!isdefined(player.pers[#"team"])) {
            continue;
        }
        if (isdefined(team) && team != player.pers[#"team"]) {
            continue;
        }
        if (isdefined(excludelist) && globallogic_utils::isexcluded(player, excludelist)) {
            continue;
        }
        player leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 5, eflags: 0x0
// Checksum 0x3295a2b6, Offset: 0x2090
// Size: 0x3ac
function leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey, introdialog) {
    if (!isdefined(dialogkey)) {
        return;
    }
    if (!level.allowannouncer) {
        return;
    }
    if (!(isdefined(self.playleaderdialog) && self.playleaderdialog) && !(isdefined(introdialog) && introdialog)) {
        return;
    }
    self flush_objective_dialog_on_player(objectivekey);
    if (self.leaderdialogqueue.size == 0 && isdefined(self.currentleaderdialog) && isdefined(objectivekey) && self.currentleaderdialog.objectivekey === objectivekey && self.currentleaderdialog.dialogkey == dialogkey) {
        return;
    }
    if (isdefined(killstreakid)) {
        foreach (item in self.leaderdialogqueue) {
            if (item.dialogkey == dialogkey) {
                item.killstreakids[item.killstreakids.size] = killstreakid;
                return;
            }
        }
        if (self.leaderdialogqueue.size == 0 && isdefined(self.currentleaderdialog) && self.currentleaderdialog.dialogkey == dialogkey) {
            if (self.currentleaderdialog.playmultiple === 1) {
                return;
            }
            playmultiple = 1;
        }
    }
    newitem = spawnstruct();
    newitem.priority = dialogkey_priority(dialogkey);
    newitem.dialogkey = dialogkey;
    newitem.multipledialogkey = level.multipledialogkeys[dialogkey];
    newitem.playmultiple = playmultiple;
    newitem.objectivekey = objectivekey;
    if (isdefined(killstreakid)) {
        newitem.killstreakids = [];
        newitem.killstreakids[0] = killstreakid;
    }
    newitem.dialogbufferkey = dialogbufferkey;
    iteminserted = 0;
    if (isdefined(newitem.priority)) {
        for (i = 0; i < self.leaderdialogqueue.size; i++) {
            if (isdefined(self.leaderdialogqueue[i].priority) && self.leaderdialogqueue[i].priority <= newitem.priority) {
                continue;
            }
            arrayinsert(self.leaderdialogqueue, newitem, i);
            iteminserted = 1;
            break;
        }
    }
    if (!iteminserted) {
        self.leaderdialogqueue[self.leaderdialogqueue.size] = newitem;
    }
    if (isdefined(self.currentleaderdialog)) {
        return;
    }
    self thread play_next_leader_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x1e5fb415, Offset: 0x2448
// Size: 0x27c
function play_next_leader_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    if (self.leaderdialogqueue.size == 0) {
        self.currentleaderdialog = undefined;
        return;
    }
    nextdialog = self.leaderdialogqueue[0];
    arrayremoveindex(self.leaderdialogqueue, 0);
    dialogkey = nextdialog.dialogkey;
    if (isdefined(nextdialog.killstreakids)) {
        triggeredcount = 0;
        foreach (killstreakid in nextdialog.killstreakids) {
            if (isdefined(level.killstreaks_triggered[killstreakid])) {
                triggeredcount++;
            }
        }
        if (triggeredcount == 0) {
            self thread play_next_leader_dialog();
            return;
        } else if (triggeredcount > 1 || nextdialog.playmultiple === 1) {
            if (isdefined(level.multipledialogkeys[dialogkey])) {
                dialogkey = level.multipledialogkeys[dialogkey];
            }
        }
    }
    dialogalias = self get_commander_dialog_alias(dialogkey);
    if (!isdefined(dialogalias)) {
        self thread play_next_leader_dialog();
        return;
    }
    self playlocalsound(dialogalias);
    nextdialog.playtime = gettime();
    self.currentleaderdialog = nextdialog;
    dialogbuffer = battlechatter::mpdialog_value(nextdialog.dialogbufferkey, battlechatter::mpdialog_value("commanderDialogBuffer", 0));
    self thread wait_next_leader_dialog(dialogbuffer);
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xc7f21d1e, Offset: 0x26d0
// Size: 0x5c
function wait_next_leader_dialog(dialogbuffer) {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    wait dialogbuffer;
    self thread play_next_leader_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x5b8b545a, Offset: 0x2738
// Size: 0x6c4
function dialogkey_priority(dialogkey) {
    switch (dialogkey) {
    case #"enemyhelicoptergunner":
    case #"enemyplanemortarmultiple":
    case #"enemyaitank":
    case #"enemydronestrike":
    case #"enemymicrowaveturretmultiple":
    case #"enemyaitankmultiple":
    case #"enemydartmultiple":
    case #"enemydart":
    case #"enemyplanemortar":
    case #"hash_1feb9f6dc95d56df":
    case #"enemycombatrobotmultiple":
    case #"enemyrcbombmultiple":
    case #"enemyremotemissilemultiple":
    case #"enemyrapsmultiple":
    case #"enemyrcbomb":
    case #"enemycombatrobot":
    case #"enemyhelicopter":
    case #"enemyturret":
    case #"enemyturretmultiple":
    case #"enemyhelicoptergunnermultiple":
    case #"enemydronestrikemultiple":
    case #"enemyraps":
    case #"enemySentinelMultiple":
    case #"enemyplanemortarused":
    case #"enemyhelicoptermultiple":
    case #"enemymicrowaveturret":
    case #"enemyremotemissile":
        return 1;
    case #"roundencouragelastplayer":
    case #"gamelosing":
    case #"nearwinning":
    case #"gamewinning":
    case #"gameleadtaken":
    case #"neardrawing":
    case #"nearlosing":
    case #"gameleadlost":
        return 1;
    case #"uplorders":
    case #"sfgrobotneedreboot":
    case #"domfriendlysecuredall":
    case #"hubsonline":
    case #"sfgstarttow":
    case #"sfgtheyreturn":
    case #"sfgrobotunderfire":
    case #"kothonline":
    case #"bombfriendlytaken":
    case #"ctffriendlyflagcaptured":
    case #"sfgrobotrebootedtowdefender":
    case #"hubmoved":
    case #"sfgrobotrebootedtowattacker":
    case #"uplweuplinkremote":
    case #"bombplanted":
    case #"uplreset":
    case #"sfgrobotrebooteddefender":
    case #"ctfenemyflagdropped":
    case #"sfgrobotunderfireneutral":
    case #"ctffriendlyflagdropped":
    case #"domenemyhasc":
    case #"domenemyhasb":
    case #"kothcontested":
    case #"ctfenemyflagtaken":
    case #"domenemyhasa":
    case #"bombenemytaken":
    case #"uplwedrop":
    case #"uplweuplink":
    case #"hubsoffline":
    case #"domenemysecureda":
    case #"domenemysecuredb":
    case #"domenemysecuredc":
    case #"uplwetake":
    case #"upltransferred":
    case #"sfgstarthrdefend":
    case #"upltheyuplinkremote":
    case #"ctfenemyflagreturned":
    case #"sfgrobotcloseattacker":
    case #"bombdefused":
    case #"sfgstarthrattack":
    case #"sfgrobotclosedefender":
    case #"kothsecured":
    case #"sfgwereturn":
    case #"domenemysecuringc":
    case #"sfgstartattack":
    case #"ctfenemyflagcaptured":
    case #"sfgrobotdisabledattacker":
    case #"sfgrobotrebootedattacker":
    case #"hubonline":
    case #"sfgstartdefend":
    case #"ctffriendlyflagreturned":
    case #"ctffriendlyflagtaken":
    case #"upltheytake":
    case #"domenemysecuringb":
    case #"domenemysecuringa":
    case #"huboffline":
    case #"hubsmoved":
    case #"sfgrobotdisableddefender":
    case #"domfriendlysecuredc":
    case #"domfriendlysecuredb":
    case #"domfriendlysecureda":
    case #"upltheydrop":
    case #"kothlocated":
    case #"kothcaptured":
    case #"upltheyuplink":
    case #"kothlost":
    case #"bombfriendlydropped":
    case #"domfriendlysecuringb":
    case #"domfriendlysecuringc":
    case #"domfriendlysecuringa":
        return 1;
    }
    return undefined;
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xb98bcbf4, Offset: 0x2e08
// Size: 0x24
function play_equipment_destroyed_on_player() {
    self play_taacom_dialog("equipmentDestroyed");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x18bd1fe7, Offset: 0x2e38
// Size: 0x24
function play_equipment_hacked_on_player() {
    self play_taacom_dialog("equipmentHacked");
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xc1c44d6b, Offset: 0x2e68
// Size: 0x7a
function get_commander_dialog_alias(dialogkey) {
    if (!isdefined(self.pers[#"mpcommander"])) {
        return undefined;
    }
    commanderbundle = struct::get_script_bundle("mpdialog_commander", self.pers[#"mpcommander"]);
    return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0xc5279b68, Offset: 0x2ef0
// Size: 0x84
function get_dialog_bundle_alias(dialogbundle, dialogkey) {
    if (!isdefined(dialogbundle) || !isdefined(dialogkey)) {
        return undefined;
    }
    dialogalias = dialogbundle.(dialogkey);
    if (!isdefined(dialogalias)) {
        return;
    }
    voiceprefix = dialogbundle.("voiceprefix");
    if (isdefined(voiceprefix)) {
        dialogalias = voiceprefix + dialogalias;
    }
    return dialogalias;
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x2783993, Offset: 0x2f80
// Size: 0xd4
function is_team_winning(checkteam) {
    score = game.stat[#"teamscores"][checkteam];
    foreach (team, _ in level.teams) {
        if (team != checkteam) {
            if (game.stat[#"teamscores"][team] >= score) {
                return false;
            }
        }
    }
    return true;
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xd707ca0e, Offset: 0x3060
// Size: 0xc0
function announce_team_is_winning() {
    foreach (team, _ in level.teams) {
        if (is_team_winning(team)) {
            leader_dialog("gameWinning", team);
            leader_dialog_for_other_teams("gameLosing", team);
            return true;
        }
    }
    return false;
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0xedcbd379, Offset: 0x3128
// Size: 0xd6
function play_2d_on_team(alias, team) {
    assert(isdefined(level.players));
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
            player playlocalsound(alias);
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x973d8a06, Offset: 0x3208
// Size: 0x2e
function get_round_switch_dialog(switchtype) {
    switch (switchtype) {
    case 2:
        return "roundHalftime";
    case 4:
        return "roundOvertime";
    default:
        return "roundSwitchSides";
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x77beb7ed, Offset: 0x3280
// Size: 0x5c
function on_end_game() {
    level util::clientnotify("pm");
    level waittill(#"sfade");
    level util::clientnotify("pmf");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xb7c244ad, Offset: 0x32e8
// Size: 0x16c
function announcercontroller() {
    level endon(#"game_ended");
    level waittill(#"match_ending_soon");
    if (util::islastround() || util::isoneround()) {
        if (level.teambased) {
            if (!announce_team_is_winning()) {
                leader_dialog("min_draw");
            }
        }
        level waittill(#"match_ending_very_soon");
        foreach (team, _ in level.teams) {
            leader_dialog("roundTimeWarning", team, undefined, undefined);
        }
        return;
    }
    level waittill(#"match_ending_vox");
    leader_dialog("roundTimeWarning");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x9f9bd588, Offset: 0x3460
// Size: 0x64
function sndmusicfunctions() {
    level thread sndmusictimesout();
    level thread sndmusichalfway();
    level thread sndmusictimelimitwatcher();
    level thread sndmusicunlock();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x63db845e, Offset: 0x34d0
// Size: 0x86
function sndmusicsetrandomizer() {
    if (game.roundsplayed == 0) {
        game.musicset = randomintrange(1, 8);
        if (game.musicset <= 9) {
            game.musicset = "0" + game.musicset;
        }
        game.musicset = "_" + game.musicset;
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x9fc3fbad, Offset: 0x3560
// Size: 0x104
function sndmusicunlock() {
    level waittill(#"game_ended");
    unlockname = undefined;
    switch (game.musicset) {
    case #"_01":
        unlockname = "mus_dystopia_intro";
        break;
    case #"_02":
        unlockname = "mus_filter_intro";
        break;
    case #"_03":
        unlockname = "mus_immersion_intro";
        break;
    case #"_04":
        unlockname = "mus_ruin_intro";
        break;
    case #"_05":
        unlockname = "mus_cod_bites_intro";
        break;
    }
    if (isdefined(unlockname)) {
        level thread audio::unlockfrontendmusic(unlockname);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xc7f197ed, Offset: 0x3670
// Size: 0xb4
function sndmusictimesout() {
    level endon(#"game_ended");
    level endon(#"musicendingoverride");
    level waittill(#"match_ending_very_soon");
    if (isdefined(level.gametype) && level.gametype == "sd") {
        level thread set_music_on_team("timeOutQuiet");
        return;
    }
    level thread set_music_on_team("timeOut");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x59d7e31c, Offset: 0x3730
// Size: 0x84
function sndmusichalfway() {
    level endon(#"game_ended");
    level endon(#"match_ending_soon");
    level endon(#"match_ending_very_soon");
    level waittill(#"sndmusichalfway");
    level thread set_music_on_team("underscore");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x884c1b96, Offset: 0x37c0
// Size: 0x114
function sndmusictimelimitwatcher() {
    level endon(#"game_ended");
    level endon(#"match_ending_soon");
    level endon(#"match_ending_very_soon");
    level endon(#"sndmusichalfway");
    if (!isdefined(level.timelimit) || level.timelimit == 0) {
        return;
    }
    halfway = level.timelimit * 60 * 0.5;
    while (true) {
        timeleft = float(globallogic_utils::gettimeremaining()) / 1000;
        if (timeleft <= halfway) {
            level notify(#"sndmusichalfway");
            return;
        }
        wait 2;
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 5, eflags: 0x0
// Checksum 0x35f65c46, Offset: 0x38e0
// Size: 0x198
function set_music_on_team(state, team = "both", wait_time = 0, save_state = 0, return_state = 0) {
    assert(isdefined(level.players));
    foreach (player in level.players) {
        if (team == "both") {
            player thread set_music_on_player(state, wait_time, save_state, return_state);
            continue;
        }
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
            player thread set_music_on_player(state, wait_time, save_state, return_state);
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 4, eflags: 0x0
// Checksum 0x1bab99f2, Offset: 0x3a80
// Size: 0x104
function set_music_on_player(state, wait_time = 0, save_state = 0, return_state = 0) {
    self endon(#"disconnect");
    assert(isplayer(self));
    if (!isdefined(state)) {
        return;
    }
    if (!isdefined(game.musicset)) {
        return;
    }
    if (sessionmodeiswarzonegame()) {
        return;
    }
    if (isdefined(level.var_b63fca05) && level.var_b63fca05) {
        return;
    }
    music::setmusicstate(state + game.musicset, self);
}

// Namespace globallogic_audio/globallogic_audio
// Params 4, eflags: 0x0
// Checksum 0xf99acda3, Offset: 0x3b90
// Size: 0xc4
function set_music_global(state, wait_time = 0, save_state = 0, return_state = 0) {
    if (!isdefined(state)) {
        return;
    }
    if (!isdefined(game.musicset)) {
        return;
    }
    if (isdefined(level.var_b63fca05) && level.var_b63fca05) {
        return;
    }
    if (sessionmodeiswarzonegame()) {
        return;
    }
    music::setmusicstate(state + game.musicset);
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x91e91011, Offset: 0x3c60
// Size: 0x13c
function function_18cbfc40(var_b2532871, team) {
    if (!isdefined(game.musicset)) {
        return;
    }
    if (!isdefined(var_b2532871)) {
        return;
    }
    if (isdefined(team)) {
        foreach (player in level.players) {
            if (!isdefined(player.pers[#"team"])) {
                continue;
            }
            if (isdefined(team) && team != player.pers[#"team"]) {
                continue;
            }
            music::setmusicstate(var_b2532871 + game.musicset, player);
        }
        return;
    }
    music::setmusicstate(var_b2532871 + game.musicset);
}

