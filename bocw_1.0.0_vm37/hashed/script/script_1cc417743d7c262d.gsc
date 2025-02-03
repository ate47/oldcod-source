#using script_396f7d71538c9677;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace globallogic_audio;

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x6
// Checksum 0xc4d84dbb, Offset: 0x570
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"globallogic_audio", &preinit, undefined, undefined, undefined);
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x4
// Checksum 0x52dfece5, Offset: 0x5b8
// Size: 0x1c
function private preinit() {
    level thread function_dd5d8f8e();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x7d5d4a5e, Offset: 0x5e0
// Size: 0x80
function function_dd5d8f8e() {
    if (!isdefined(game.musicset)) {
        game.musicset = randomintrange(1, 5);
        if (game.musicset <= 9) {
            game.musicset = "0" + game.musicset;
        }
        game.musicset = "_" + game.musicset;
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x3735bf5a, Offset: 0x668
// Size: 0x4da
function function_6e084fd3(var_37ecca7, taacombundle) {
    bundlename = undefined;
    switch (var_37ecca7) {
    case #"tank_robot":
        bundlename = taacombundle.aitankdialogbundle;
        break;
    case #"inventory_chopper_gunner":
    case #"chopper_gunner":
        bundlename = taacombundle.var_3f45482e;
        break;
    case #"counteruav":
        bundlename = taacombundle.counteruavdialogbundle;
        break;
    case #"dart":
        bundlename = taacombundle.dartdialogbundle;
        break;
    case #"sig_lmg":
        bundlename = taacombundle.var_4129b7a;
        break;
    case #"drone_squadron":
        bundlename = taacombundle.var_69a9ca12;
        break;
    case #"sig_bow_flame":
        bundlename = taacombundle.var_82cefc8c;
        break;
    case #"hero_flamethrower":
        bundlename = taacombundle.var_43bcc95e;
        break;
    case #"ac130":
    case #"inventory_ac130":
        bundlename = taacombundle.var_71693229;
        break;
    case #"hero_pineapplegun":
        bundlename = taacombundle.var_dcfac86e;
        break;
    case #"helicopter_comlink":
    case #"inventory_helicopter_comlink":
        bundlename = taacombundle.helicopterdialogbundle;
        break;
    case #"inventory_helicopter_guard":
    case #"helicopter_guard":
        bundlename = taacombundle.var_7275c81d;
        break;
    case #"hero_annihilator":
        bundlename = taacombundle.var_679bf19;
        break;
    case #"dog":
        bundlename = taacombundle.var_f68cebf2;
        break;
    case #"hoverjet":
    case #"inventory_hoverjet":
        bundlename = taacombundle.var_c96adb95;
        break;
    case #"overwatch_helicopter":
    case #"inventory_overwatch_helicopter":
        bundlename = taacombundle.overwatchhelicopterdialogbundle;
        break;
    case #"overwatch_helicopter_snipers":
        bundlename = taacombundle.var_4062b33e;
        break;
    case #"planemortar":
        bundlename = taacombundle.planemortardialogbundle;
        break;
    case #"recon_car":
        bundlename = taacombundle.rcbombdialogbundle;
        break;
    case #"recon_plane":
        bundlename = taacombundle.var_5b8e4a97;
        break;
    case #"remote_missile":
    case #"inventory_remote_missile":
        bundlename = taacombundle.remotemissiledialogbundle;
        break;
    case #"straferun":
    case #"inventory_straferun":
        bundlename = taacombundle.straferundialogbundle;
        break;
    case #"supply_drop":
        bundlename = taacombundle.supplydropdialogbundle;
        break;
    case #"swat_team":
        bundlename = taacombundle.var_d93fd150;
        break;
    case #"uav":
        bundlename = taacombundle.uavdialogbundle;
        break;
    case #"ultimate_turret":
    case #"inventory_ultimate_turret":
        bundlename = taacombundle.ultturretdialogbundle;
        break;
    case #"hash_49d514608adc6a24":
    case #"jetfighter":
        bundlename = taacombundle.var_2f6e3044;
        break;
    case #"napalm_strike":
    case #"inventory_napalm_strike":
        bundlename = taacombundle.var_3ab478cf;
        break;
    case #"weapon_armor":
    case #"hash_6bf7a941e385e178":
        bundlename = taacombundle.var_17e0a105;
        break;
    default:
        break;
    }
    if (!isdefined(bundlename)) {
        return;
    }
    killstreakbundle = getscriptbundle(bundlename);
    return killstreakbundle;
}

// Namespace globallogic_audio/globallogic_audio
// Params 6, eflags: 0x0
// Checksum 0xfff5da6c, Offset: 0xb50
// Size: 0xc6
function set_leader_gametype_dialog(startgamedialogkey, starthcgamedialogkey, offenseorderdialogkey, defenseorderdialogkey, var_2888cc9d, var_826b3c1a) {
    level.leaderdialog = spawnstruct();
    level.leaderdialog.startgamedialog = startgamedialogkey;
    level.leaderdialog.var_f6fda321 = var_2888cc9d;
    level.leaderdialog.starthcgamedialog = starthcgamedialogkey;
    level.leaderdialog.var_d04b3734 = var_826b3c1a;
    level.leaderdialog.offenseorderdialog = offenseorderdialogkey;
    level.leaderdialog.defenseorderdialog = defenseorderdialogkey;
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xcd8128e8, Offset: 0xc20
// Size: 0x88
function flush_dialog() {
    foreach (player in level.players) {
        player flush_dialog_on_player();
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x5bff34d8, Offset: 0xcb0
// Size: 0x56
function flush_dialog_on_player() {
    if (!isdefined(self.leaderdialogqueue)) {
        self.leaderdialogqueue = [];
    }
    self.currentleaderdialog = undefined;
    if (!isdefined(self.killstreakdialogqueue)) {
        self.killstreakdialogqueue = [];
    }
    self.scorestreakdialogplaying = 0;
    self notify(#"flush_dialog");
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x3cb762f9, Offset: 0xd10
// Size: 0x8c
function flush_killstreak_dialog_on_player(killstreakid) {
    if (!isdefined(killstreakid) || !isdefined(self.killstreakdialogqueue)) {
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
// Checksum 0xbe745507, Offset: 0xda8
// Size: 0x94
function function_fd32b1bd(killstreaktype) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(killstreaktype) || !isdefined(self.killstreakdialogqueue)) {
        return;
    }
    for (i = self.killstreakdialogqueue.size - 1; i >= 0; i--) {
        if (killstreaktype === self.killstreakdialogqueue[i].killstreaktype) {
            arrayremoveindex(self.killstreakdialogqueue, i);
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xb956007a, Offset: 0xe48
// Size: 0x98
function flush_objective_dialog(objectivekey) {
    foreach (player in level.players) {
        player flush_objective_dialog_on_player(objectivekey);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x62d87734, Offset: 0xee8
// Size: 0x90
function flush_objective_dialog_on_player(objectivekey) {
    if (!isdefined(objectivekey) || !isdefined(self.leaderdialogqueue)) {
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
// Checksum 0xe1733d48, Offset: 0xf80
// Size: 0x98
function flush_leader_dialog_key(dialogkey) {
    foreach (player in level.players) {
        player flush_leader_dialog_key_on_player(dialogkey);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x93fe41c1, Offset: 0x1020
// Size: 0x8c
function flush_leader_dialog_key_on_player(dialogkey) {
    if (!isdefined(dialogkey)) {
        return;
    }
    if (!isdefined(self.leaderdialogqueue)) {
        return;
    }
    for (i = self.leaderdialogqueue.size - 1; i >= 0; i--) {
        if (dialogkey === self.leaderdialogqueue[i].dialogkey) {
            arrayremoveindex(self.leaderdialogqueue, i);
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 7, eflags: 0x0
// Checksum 0xdb07b90c, Offset: 0x10b8
// Size: 0x64
function play_taacom_dialog(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority) {
    self killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, undefined, soundevent, var_8a6b001a, weapon, priority);
}

// Namespace globallogic_audio/globallogic_audio
// Params 8, eflags: 0x0
// Checksum 0x38259bf6, Offset: 0x1128
// Size: 0x1b4
function killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex, soundevent, var_8a6b001a, weapon, priority) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.killstreakdialogqueue)) {
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
    newdialog.soundevent = soundevent;
    newdialog.var_8a6b001a = var_8a6b001a;
    newdialog.weapon = weapon;
    if (priority === 1) {
        arrayinsert(self.killstreakdialogqueue, newdialog, 0);
    } else {
        self.killstreakdialogqueue[self.killstreakdialogqueue.size] = newdialog;
    }
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
// Checksum 0xbcfb17a5, Offset: 0x12e8
// Size: 0x74
function wait_for_player_dialog() {
    self endon(#"disconnect", #"flush_dialog");
    level endon(#"game_ended");
    while (self.playingdialog) {
        wait 0.5;
    }
    if (!isdefined(self)) {
        return;
    }
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x1fff64fc, Offset: 0x1368
// Size: 0x38c
function play_next_killstreak_dialog() {
    self endon(#"disconnect", #"flush_dialog");
    level endon(#"game_ended");
    if (self.killstreakdialogqueue.size == 0) {
        self.currentkillstreakdialog = undefined;
        return;
    }
    if (isdefined(self.pers[level.var_bc01f047])) {
        taacombundle = getscriptbundle(self.pers[level.var_bc01f047]);
    } else {
        self.killstreakdialogqueue = [];
        self.currentkillstreakdialog = undefined;
        return;
    }
    for (dialogalias = undefined; !isdefined(dialogalias) && self.killstreakdialogqueue.size > 0; dialogalias = self get_dialog_bundle_alias(taacombundle, nextdialog.dialogkey)) {
        nextdialog = self.killstreakdialogqueue[0];
        arrayremoveindex(self.killstreakdialogqueue, 0);
        if (isdefined(nextdialog.killstreaktype)) {
            if (isdefined(nextdialog.pilotindex)) {
                pilotarray = taacombundle.pilotbundles[nextdialog.killstreaktype];
                if (isdefined(pilotarray) && nextdialog.pilotindex < pilotarray.size) {
                    killstreakbundle = getscriptbundle(pilotarray[nextdialog.pilotindex]);
                    if (isdefined(killstreakbundle)) {
                        dialogalias = get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
                    }
                }
            } else if (isdefined(nextdialog.killstreaktype)) {
                killstreakbundle = function_6e084fd3(nextdialog.killstreaktype, taacombundle);
                if (isdefined(killstreakbundle)) {
                    dialogalias = self get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
                }
            }
            continue;
        }
    }
    if (!isdefined(dialogalias)) {
        self.currentkillstreakdialog = undefined;
        return;
    }
    waittime = 0;
    if (isdefined(nextdialog.soundevent) && isdefined(nextdialog.var_8a6b001a) && isalive(nextdialog.var_8a6b001a)) {
        waittime += battlechatter::mpdialog_value("taacomHackAndReplyDialogBuffer", 0);
        self thread function_30f16f29(nextdialog.soundevent, nextdialog.var_8a6b001a, nextdialog.weapon);
    } else {
        /#
            function_d9079fc1(dialogalias, "<dev string:x38>");
        #/
        self playlocalsound(dialogalias);
        waittime += battlechatter::mpdialog_value("killstreakDialogBuffer", 0);
    }
    self.currentkillstreakdialog = nextdialog;
    self thread wait_next_killstreak_dialog(waittime);
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x193c7fdb, Offset: 0x1700
// Size: 0x64
function wait_next_killstreak_dialog(waittime) {
    self endon(#"disconnect", #"flush_dialog");
    level endon(#"game_ended");
    wait waittime;
    if (!isdefined(self)) {
        return;
    }
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 3, eflags: 0x0
// Checksum 0x6165d6d5, Offset: 0x1770
// Size: 0x5c
function function_30f16f29(soundevent, var_8a6b001a, weapon) {
    if (isdefined(var_8a6b001a) && isalive(var_8a6b001a)) {
        var_8a6b001a playsoundevent(soundevent, weapon, self);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 5, eflags: 0x0
// Checksum 0xcb3f4104, Offset: 0x17d8
// Size: 0xe0
function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
    assert(isdefined(skipteam));
    foreach (team, _ in level.teams) {
        if (team != skipteam) {
            leader_dialog(dialogkey, team, objectivekey, killstreakid, dialogbufferkey);
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 6, eflags: 0x0
// Checksum 0x7e8d3e63, Offset: 0x18c0
// Size: 0xd8
function function_61e17de0(dialogkey, players, objectivekey, killstreakid, dialogbufferkey, dialogalias) {
    assert(isdefined(players));
    foreach (player in players) {
        player leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey, undefined, dialogalias);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 6, eflags: 0x0
// Checksum 0xd1e640a3, Offset: 0x19a0
// Size: 0xdc
function function_248fc9f7(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey) {
    assert(isdefined(excludelist));
    assert(isdefined(level.players));
    players = isdefined(team) ? getplayers(team) : level.players;
    players = array::exclude(players, excludelist);
    function_61e17de0(dialogkey, players, objectivekey, killstreakid, dialogbufferkey);
}

// Namespace globallogic_audio/globallogic_audio
// Params 6, eflags: 0x0
// Checksum 0xee6f3c4d, Offset: 0x1a88
// Size: 0xdc
function function_b4319f8e(dialogkey, team, exclude, objectivekey, killstreakid, dialogbufferkey) {
    assert(isdefined(exclude));
    assert(isdefined(level.players));
    players = isdefined(team) ? getplayers(team) : level.players;
    arrayremovevalue(players, exclude);
    function_61e17de0(dialogkey, players, objectivekey, killstreakid, dialogbufferkey);
}

// Namespace globallogic_audio/globallogic_audio
// Params 5, eflags: 0x0
// Checksum 0xa5a3b63f, Offset: 0x1b70
// Size: 0xac
function leader_dialog(dialogkey, team, objectivekey, killstreakid, dialogbufferkey) {
    if (is_true(level.is_survival)) {
        if (isdefined(dialogkey)) {
            if (issubstr(dialogkey, "Response")) {
                return;
            }
        }
    }
    players = getplayers(team);
    function_61e17de0(dialogkey, players, objectivekey, killstreakid, dialogbufferkey);
}

// Namespace globallogic_audio/globallogic_audio
// Params 6, eflags: 0x0
// Checksum 0x8add9a11, Offset: 0x1c28
// Size: 0x3a4
function leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey, introdialog, dialogalias) {
    if (!isdefined(dialogkey)) {
        return;
    }
    if (!level.allowannouncer) {
        return;
    }
    if (!is_true(self.playleaderdialog) && !is_true(introdialog)) {
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
    self thread play_next_leader_dialog(dialogalias);
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xb29a0db5, Offset: 0x1fd8
// Size: 0x3f4
function play_next_leader_dialog(dialogalias) {
    self endon(#"disconnect", #"flush_dialog");
    level endon(#"game_ended");
    if (self.leaderdialogqueue.size == 0) {
        self notify(#"hash_73f839d8939452ad");
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
    if (dialogkey === "gamePlayerKicked") {
        self playsoundevent(2);
    } else if (dialogkey === "gameDraw") {
        self playsoundevent(12);
    } else if (dialogkey === "gameLost") {
        self playsoundevent(13);
    } else if (dialogkey === "gameWon") {
        self playsoundevent(14);
    } else {
        if (!isdefined(dialogalias)) {
            dialogalias = self get_commander_dialog_alias(dialogkey);
        }
        if (!isdefined(dialogalias)) {
            self thread play_next_leader_dialog();
            return;
        }
        /#
            function_d9079fc1(dialogalias, "<dev string:x4d>");
        #/
        self playlocalsound(dialogalias);
    }
    nextdialog.playtime = gettime();
    self.currentleaderdialog = nextdialog;
    if (is_true(level.var_28ebc1e8)) {
        dialogbuffer = float(max(isdefined(soundgetplaybacktime(dialogalias)) ? soundgetplaybacktime(dialogalias) : 500, 500)) / 1000;
    } else {
        dialogbuffer = battlechatter::mpdialog_value(nextdialog.dialogbufferkey, battlechatter::mpdialog_value("commanderDialogBuffer", 0));
    }
    self thread wait_next_leader_dialog(dialogbuffer);
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x5be5d7c6, Offset: 0x23d8
// Size: 0x64
function wait_next_leader_dialog(dialogbuffer) {
    self endon(#"disconnect", #"flush_dialog");
    level endon(#"game_ended");
    wait dialogbuffer;
    if (isdefined(self)) {
        self thread play_next_leader_dialog();
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x5ba1c35, Offset: 0x2448
// Size: 0x6a4
function dialogkey_priority(dialogkey) {
    switch (dialogkey) {
    case #"enemydronestrikemultiple":
    case #"enemyplanemortarmultiple":
    case #"enemyaitank":
    case #"enemydronestrike":
    case #"enemymicrowaveturretmultiple":
    case #"enemydart":
    case #"enemydartmultiple":
    case #"enemyremotemissile":
    case #"enemyplanemortar":
    case #"enemycombatrobotmultiple":
    case #"enemyrcbombmultiple":
    case #"enemyremotemissilemultiple":
    case #"enemyrapsmultiple":
    case #"enemyhelicoptergunner":
    case #"enemyrcbomb":
    case #"enemycombatrobot":
    case #"enemyhelicopter":
    case #"enemyturret":
    case #"enemyturretmultiple":
    case #"enemyhelicoptergunnermultiple":
    case #"enemyraps":
    case #"enemyplanemortarused":
    case #"enemyhelicoptermultiple":
    case #"enemymicrowaveturret":
    case #"enemyaitankmultiple":
        return 1;
    case #"roundencouragelastplayer":
    case #"gamelosing":
    case #"nearwinning":
    case #"gameleadlost":
    case #"nearlosing":
    case #"neardrawing":
    case #"gameleadtaken":
    case #"gamewinning":
        return 1;
    case #"upltheyuplink":
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
    case #"upltheydrop":
    case #"domenemyhasc":
    case #"kothcontested":
    case #"ctfenemyflagtaken":
    case #"domenemyhasb":
    case #"uplwedrop":
    case #"uplweuplink":
    case #"hubsoffline":
    case #"domenemysecureda":
    case #"domenemysecuredb":
    case #"domenemysecuredc":
    case #"domenemyhasa":
    case #"upltransferred":
    case #"sfgstarthrdefend":
    case #"upltheyuplinkremote":
    case #"ctfenemyflagreturned":
    case #"bombenemytaken":
    case #"uplwetake":
    case #"sfgstarthrattack":
    case #"sfgrobotclosedefender":
    case #"kothsecured":
    case #"sfgwereturn":
    case #"hubsmoved":
    case #"sfgstartattack":
    case #"ctfenemyflagcaptured":
    case #"sfgrobotdisabledattacker":
    case #"sfgrobotrebootedattacker":
    case #"hubonline":
    case #"sfgstartdefend":
    case #"ctffriendlyflagreturned":
    case #"ctffriendlyflagtaken":
    case #"upltheytake":
    case #"sfgrobotcloseattacker":
    case #"bombdefused":
    case #"huboffline":
    case #"domenemysecuringc":
    case #"sfgrobotdisableddefender":
    case #"domfriendlysecuredc":
    case #"domfriendlysecuredb":
    case #"domfriendlysecureda":
    case #"domenemysecuringb":
    case #"domenemysecuringa":
    case #"kothcaptured":
    case #"kothlocated":
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
// Checksum 0xbc891baa, Offset: 0x2af8
// Size: 0x24
function play_equipment_destroyed_on_player() {
    self play_taacom_dialog("equipmentDestroyed");
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xa008634f, Offset: 0x2b28
// Size: 0x24
function play_equipment_hacked_on_player() {
    self play_taacom_dialog("equipmentHacked");
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x4d80eafb, Offset: 0x2b58
// Size: 0x72
function get_commander_dialog_alias(dialogkey) {
    if (!isdefined(self.pers[level.var_7ee6af9f])) {
        return undefined;
    }
    commanderbundle = getscriptbundle(self.pers[level.var_7ee6af9f]);
    return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x591ba1d7, Offset: 0x2bd8
// Size: 0x118
function get_dialog_bundle_alias(dialogbundle, dialogkey) {
    if (!isdefined(dialogbundle) || !isdefined(dialogkey)) {
        return undefined;
    }
    if (ishash(dialogkey)) {
        if (isdefined(level.var_3727097e)) {
            dialogalias = self [[ level.var_3727097e ]](dialogbundle, dialogkey);
        } else {
            /#
                iprintlnbold("<dev string:x62>" + function_9e72a96(dialogkey) + "<dev string:x77>");
            #/
        }
    } else {
        dialogalias = dialogbundle.(dialogkey);
    }
    if (!isdefined(dialogalias)) {
        return;
    }
    if (!ishash(dialogalias)) {
        voiceprefix = dialogbundle.("voiceprefix");
        if (isdefined(voiceprefix)) {
            dialogalias = voiceprefix + dialogalias;
        }
    }
    return dialogalias;
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xc9e3ef1e, Offset: 0x2cf8
// Size: 0x72
function function_2523d20f(dialogkey) {
    if (!isdefined(self.pers[level.var_7ee6af9f])) {
        return undefined;
    }
    commanderbundle = getscriptbundle(self.pers[level.var_7ee6af9f]);
    return function_f554c1ad(commanderbundle, dialogkey);
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x260676d3, Offset: 0x2d78
// Size: 0xdc
function function_f554c1ad(dialogbundle, dialogkey) {
    if (!isdefined(dialogbundle) || !isdefined(dialogkey)) {
        return undefined;
    }
    dialogkey += "SpeakerBundle";
    if (ishash(dialogkey)) {
        if (isdefined(level.var_9f234058)) {
            var_3a0f7868 = self [[ level.var_9f234058 ]](dialogbundle, dialogkey);
        } else {
            /#
                iprintlnbold("<dev string:x62>" + function_9e72a96(dialogkey) + "<dev string:x130>");
            #/
        }
    } else {
        var_3a0f7868 = dialogbundle.(dialogkey);
    }
    return var_3a0f7868;
}

// Namespace globallogic_audio/globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0xda4cb343, Offset: 0x2e60
// Size: 0xdc
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
// Params 2, eflags: 0x0
// Checksum 0x32e7f2e9, Offset: 0x2f48
// Size: 0x98
function function_abf21f69(alias, players) {
    foreach (player in players) {
        player playlocalsound(alias);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x690e92bb, Offset: 0x2fe8
// Size: 0x3c
function play_2d_on_team(alias, team) {
    function_abf21f69(alias, getplayers(team));
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x86805a2, Offset: 0x3030
// Size: 0x5c
function on_end_game() {
    level util::clientnotify("pm");
    level waittill(#"sfade");
    level util::clientnotify("pmf");
}

// Namespace globallogic_audio/globallogic_audio
// Params 5, eflags: 0x0
// Checksum 0x4fab93ee, Offset: 0x3098
// Size: 0x190
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
// Params 5, eflags: 0x0
// Checksum 0x10f8cc9d, Offset: 0x3230
// Size: 0x160
function function_89fe8163(state, team = "both", wait_time = 0, save_state = 0, return_state = 0) {
    assert(isdefined(level.players));
    foreach (player in level.players) {
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] != team) {
            player thread set_music_on_player(state, wait_time, save_state, return_state);
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 4, eflags: 0x0
// Checksum 0x33059bfe, Offset: 0x3398
// Size: 0xe4
function set_music_on_player(state, *wait_time, *save_state, *return_state) {
    self endon(#"disconnect");
    assert(isplayer(self));
    if (!isdefined(return_state)) {
        return;
    }
    if (!isdefined(game.musicset)) {
        return;
    }
    if (is_true(level.is_survival)) {
        return;
    }
    if (is_true(level.var_3a701785)) {
        return;
    }
    music::setmusicstate(return_state + game.musicset, self);
}

// Namespace globallogic_audio/globallogic_audio
// Params 4, eflags: 0x0
// Checksum 0x2fdac093, Offset: 0x3488
// Size: 0xb4
function set_music_global(state, wait_time, *save_state, *return_state = 0) {
    if (!isdefined(save_state)) {
        return;
    }
    if (!isdefined(game.musicset)) {
        return;
    }
    if (is_true(level.is_survival)) {
        return;
    }
    if (is_true(level.var_3a701785)) {
        return;
    }
    music::setmusicstate(save_state + game.musicset, undefined, return_state);
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x34abd8f8, Offset: 0x3548
// Size: 0x3c
function function_85818e24(var_9c1ed9ea, team) {
    
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x2df62698, Offset: 0x36b8
// Size: 0x8c
function function_c246758e(str_state, n_delay = 0) {
    assert(isplayer(self));
    if (!isdefined(str_state)) {
        return;
    }
    if (game.state != #"playing") {
        return;
    }
    music::setmusicstate(str_state, self, n_delay);
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x180a76b1, Offset: 0x3750
// Size: 0x64
function function_6fbfba95(str_state, n_delay = 0) {
    if (!isdefined(str_state)) {
        return;
    }
    if (game.state != #"playing") {
        return;
    }
    music::setmusicstate(str_state, undefined, n_delay);
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x3f3c095c, Offset: 0x37c0
// Size: 0x184
function function_6daffa93(weapon, var_f3ab6571) {
    if (!isdefined(weapon)) {
        return;
    }
    switch (weapon.name) {
    case #"ability_smart_cover":
        taacomdialog = "smartCoverWeaponDestroyedFriendly";
        break;
    case #"gadget_jammer":
        taacomdialog = "jammerWeaponDestroyedFriendly";
        break;
    case #"gadget_supplypod":
        taacomdialog = "supplyPodWeaponDestroyedFriendly";
        break;
    case #"land_mine":
        taacomdialog = "landmineWeaponDestroyedFriendly";
        break;
    case #"listening_device":
        taacomdialog = "listenWeaponDestroyedFriendly";
        break;
    case #"missile_turret":
        taacomdialog = "missileTurretWeaponDestroyedFriendly";
        break;
    case #"tear_gas":
        taacomdialog = "tearGasWeaponDestroyedFriendly";
        break;
    case #"trophy_system":
        taacomdialog = "trophyWeaponDestroyedFriendly";
        break;
    }
    if (isdefined(taacomdialog)) {
        if (is_true(var_f3ab6571)) {
            taacomdialog += "Multiple";
        }
        play_taacom_dialog(taacomdialog);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x1738ce6c, Offset: 0x3950
// Size: 0x184
function function_a2cde53d(weapon, var_f3ab6571) {
    if (!isdefined(weapon)) {
        return;
    }
    switch (weapon.name) {
    case #"ability_smart_cover":
        taacomdialog = "smartCoverHacked";
        break;
    case #"gadget_jammer":
        taacomdialog = "jammerHacked";
        break;
    case #"gadget_supplypod":
        taacomdialog = "supplyPodHacked";
        break;
    case #"land_mine":
        taacomdialog = "landmineHacked";
        break;
    case #"listening_device":
        taacomdialog = "listenHacked";
        break;
    case #"missile_turret":
        taacomdialog = "missileTurretHacked";
        break;
    case #"tear_gas":
        taacomdialog = "tearGasHacked";
        break;
    case #"trophy_system":
        taacomdialog = "trophyHacked";
        break;
    }
    if (isdefined(taacomdialog)) {
        if (is_true(var_f3ab6571)) {
            taacomdialog += "Multiple";
        }
        play_taacom_dialog(taacomdialog);
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 3, eflags: 0x0
// Checksum 0x47fa8d4e, Offset: 0x3ae0
// Size: 0x67e
function function_4fb91bc7(weapon, var_df17fa82, var_53c10ed8) {
    if (!isdefined(weapon) || !isdefined(var_df17fa82) || !isplayer(var_df17fa82) || !isdefined(self) || !isplayer(self)) {
        return;
    }
    switch (weapon.name) {
    case #"eq_emp_grenade":
        taacomdialog = "jammerWeaponHacked";
        break;
    case #"eq_tripwire":
        taacomdialog = "meshMineWeaponHacked";
        var_b3fe42a9 = 1;
        break;
    case #"eq_seeker_mine":
        taacomdialog = "seekerMineWeaponHacked";
        var_b3fe42a9 = 1;
        break;
    case #"eq_sensor":
        taacomdialog = "sensorDartHacked";
        var_b3fe42a9 = 1;
        break;
    case #"ability_smart_cover":
    case #"gadget_smart_cover":
        taacomdialog = "smartCoverHacked";
        var_b3fe42a9 = 1;
        break;
    case #"gadget_spawnbeacon":
        taacomdialog = "spawnBeaconHacked";
        break;
    case #"gadget_supplypod":
        taacomdialog = "supplyPodHacked";
        var_b3fe42a9 = 1;
        break;
    case #"trophy_system":
        taacomdialog = "trophyWeaponHacked";
        var_b3fe42a9 = 1;
        break;
    case #"ac130":
    case #"inventory_ac130":
        taacomdialog = "ac130Hacked";
        break;
    case #"inventory_chopper_gunner":
    case #"chopper_gunner":
        taacomdialog = "chopperGunnerHacked";
        break;
    case #"inventory_tank_robot":
    case #"tank_robot":
    case #"ai_tank_marker":
        taacomdialog = "aiTankHacked";
        var_b3fe42a9 = 1;
        break;
    case #"cobra_20mm_comlink":
    case #"helicopter_comlink":
    case #"inventory_helicopter_comlink":
        taacomdialog = "attackChopperHacked";
        break;
    case #"inventory_helicopter_guard":
    case #"helicopter_guard":
        taacomdialog = "heavyAttackChopperHacked";
        break;
    case #"counteruav":
        taacomdialog = "cuavHacked";
        var_b3fe42a9 = 1;
        break;
    case #"dart":
    case #"inventory_dart":
        taacomdialog = "dartHacked";
        break;
    case #"inventory_drone_squadron":
    case #"drone_squadron":
        taacomdialog = "droneSquadHacked";
        var_b3fe42a9 = 1;
        break;
    case #"hoverjet":
    case #"inventory_hoverjet":
        taacomdialog = "hoverJetHacked";
        break;
    case #"recon_car":
    case #"inventory_recon_car":
        taacomdialog = "reconCarHacked";
        break;
    case #"recon_plane":
    case #"inventory_recon_plane":
        taacomdialog = "reconPlaneHacked";
        break;
    case #"remote_missile":
    case #"inventory_remote_missile":
        taacomdialog = "hellstormHacked";
        break;
    case #"inventory_planemortar":
    case #"planemortar":
        taacomdialog = "lightningStrikeHacked";
        break;
    case #"overwatch_helicopter":
    case #"inventory_overwatch_helicopter":
        taacomdialog = "overwatchHelicopterHacked";
        break;
    case #"straferun":
    case #"inventory_straferun":
        taacomdialog = "strafeRunHacked";
        break;
    case #"supplydrop":
        taacomdialog = "supplyDropHacked";
        var_b3fe42a9 = 1;
        break;
    case #"uav":
        taacomdialog = "uavHacked";
        var_b3fe42a9 = 1;
        break;
    case #"inventory_ultimate_turret":
    case #"ultimate_turret":
        taacomdialog = "sentryHacked";
        var_b3fe42a9 = 1;
        break;
    }
    if (!isdefined(taacomdialog)) {
        return;
    }
    if ((isdefined(self.var_d6422943) ? self.var_d6422943 : 0) > gettime()) {
        self thread play_taacom_dialog(taacomdialog);
        return;
    }
    if (var_b3fe42a9 === 1) {
        if (var_53c10ed8 === 1) {
            self thread play_taacom_dialog(taacomdialog, undefined, undefined, 5, var_df17fa82, weapon);
        } else {
            self thread play_taacom_dialog(taacomdialog, undefined, undefined, 3, var_df17fa82, weapon);
        }
    } else {
        self thread play_taacom_dialog(taacomdialog, undefined, undefined, 4, var_df17fa82);
    }
    self.var_d6422943 = gettime() + int(battlechatter::mpdialog_value("taacomHackedReplyCooldownSec", 0) * 1000);
}

/#

    // Namespace globallogic_audio/globallogic_audio
    // Params 2, eflags: 0x0
    // Checksum 0xc53efbfe, Offset: 0x4168
    // Size: 0x174
    function function_d9079fc1(str_alias, var_3cd9c84b) {
        var_a1f778fa = isdedicated() && function_541e02d0(str_alias) || soundexists(str_alias);
        if (getdvarint(#"debug_vo", 0)) {
            if (!var_a1f778fa) {
                var_2dbe34fe = "<dev string:x1eb>" + "<dev string:x1f9>" + function_9e72a96(str_alias) + "<dev string:x20a>";
                iprintlnbold(var_2dbe34fe);
                println(var_2dbe34fe);
            }
        }
        if (var_a1f778fa) {
            if (getdvarint(#"debug_vo", 0)) {
                iprintlnbold(var_3cd9c84b + function_9e72a96(str_alias));
                println(var_3cd9c84b + function_9e72a96(str_alias));
            }
        }
    }

#/
