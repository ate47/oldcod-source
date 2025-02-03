#using scripts\core_common\struct;

#namespace namespace_f9b02f80;

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 0, eflags: 0x0
// Checksum 0x88a3876c, Offset: 0xd8
// Size: 0x9e
function function_196f2c38() {
    level.play_killstreak_firewall_being_hacked_dialog = undefined;
    level.play_killstreak_firewall_hacked_dialog = undefined;
    level.play_killstreak_being_hacked_dialog = undefined;
    level.play_killstreak_hacked_dialog = undefined;
    level.play_pilot_dialog_on_owner = undefined;
    level.play_pilot_dialog = undefined;
    level.play_taacom_dialog_response_on_owner = undefined;
    level.play_taacom_dialog = undefined;
    level.var_daaa6db3 = undefined;
    level.var_514f9d20 = undefined;
    level.var_992ad5b3 = undefined;
    level.var_6d7da491 = undefined;
    level.var_9f8e080d = undefined;
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x0
// Checksum 0x1328988f, Offset: 0x180
// Size: 0x112
function killstreak_dialog_queued(dialogkey, killstreaktype, killstreakid) {
    if (!isdefined(dialogkey) || !isdefined(killstreaktype)) {
        return;
    }
    if (isdefined(self.currentkillstreakdialog)) {
        if (dialogkey === self.currentkillstreakdialog.dialogkey && killstreaktype === self.currentkillstreakdialog.killstreaktype && killstreakid === self.currentkillstreakdialog.killstreakid) {
            return 1;
        }
    }
    for (i = 0; i < self.killstreakdialogqueue.size; i++) {
        if (dialogkey === self.killstreakdialogqueue[i].dialogkey && killstreaktype === self.killstreakdialogqueue[i].killstreaktype && killstreaktype === self.killstreakdialogqueue[i].killstreaktype) {
            return 1;
        }
    }
    return 0;
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 2, eflags: 0x0
// Checksum 0x88f691dc, Offset: 0x2a0
// Size: 0xcc
function play_killstreak_ready_dialog(killstreaktype, taacomwaittime) {
    self notify("killstreak_ready_" + killstreaktype);
    self endon(#"death", "killstreak_start_" + killstreaktype, "killstreak_ready_" + killstreaktype);
    level endon(#"game_ended");
    if (isdefined(level.gameended) && level.gameended) {
        return;
    }
    if (killstreak_dialog_queued("ready", killstreaktype)) {
        return;
    }
    if (isdefined(taacomwaittime)) {
        wait taacomwaittime;
    }
    self play_taacom_dialog("ready", killstreaktype);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 4, eflags: 0x0
// Checksum 0xf7d8318b, Offset: 0x378
// Size: 0x7c
function play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, pilotindex) {
    assert(isdefined(dialogkey));
    assert(isdefined(killstreaktype));
    if (!isdefined(pilotindex)) {
        return;
    }
    self play_taacom_dialog(dialogkey + pilotindex, killstreaktype, killstreakid);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 7, eflags: 0x0
// Checksum 0xbed388b9, Offset: 0x400
// Size: 0x6c
function play_taacom_dialog(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority) {
    if (isdefined(level.play_taacom_dialog)) {
        self [[ level.play_taacom_dialog ]](dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x0
// Checksum 0xd6549ef1, Offset: 0x478
// Size: 0x44
function function_daaa6db3(weapon, var_df17fa82, var_53c10ed8) {
    if (isdefined(level.var_daaa6db3)) {
        self [[ level.var_daaa6db3 ]](weapon, var_df17fa82, var_53c10ed8);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x0
// Checksum 0x4c51f773, Offset: 0x4c8
// Size: 0x44
function play_taacom_dialog_response_on_owner(dialogkey, killstreaktype, killstreakid) {
    if (isdefined(level.play_taacom_dialog_response_on_owner)) {
        self [[ level.play_taacom_dialog_response_on_owner ]](dialogkey, killstreaktype, killstreakid);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 5, eflags: 0x0
// Checksum 0xea3957e2, Offset: 0x518
// Size: 0x58
function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
    if (isdefined(level.var_9f8e080d)) {
        [[ level.var_9f8e080d ]](dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 5, eflags: 0x0
// Checksum 0x5c8812cd, Offset: 0x578
// Size: 0x58
function leader_dialog(dialogkey, team, objectivekey, killstreakid, dialogbufferkey) {
    if (isdefined(level.var_514f9d20)) {
        [[ level.var_514f9d20 ]](dialogkey, team, objectivekey, killstreakid, dialogbufferkey);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 6, eflags: 0x0
// Checksum 0x3c5532d0, Offset: 0x5d8
// Size: 0x64
function function_b4319f8e(dialogkey, team, exclusion, objectivekey, killstreakid, dialogbufferkey) {
    if (isdefined(level.var_992ad5b3)) {
        [[ level.var_992ad5b3 ]](dialogkey, team, exclusion, objectivekey, killstreakid, dialogbufferkey);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 6, eflags: 0x0
// Checksum 0xd4682bc8, Offset: 0x648
// Size: 0x64
function function_248fc9f7(dialogkey, team, exclusions, objectivekey, killstreakid, dialogbufferkey) {
    if (isdefined(level.var_6d7da491)) {
        [[ level.var_6d7da491 ]](dialogkey, team, exclusions, objectivekey, killstreakid, dialogbufferkey);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 2, eflags: 0x0
// Checksum 0xa27035e7, Offset: 0x6b8
// Size: 0x3c
function play_killstreak_firewall_being_hacked_dialog(killstreaktype, killstreakid) {
    if (isdefined(level.play_killstreak_firewall_being_hacked_dialog)) {
        self [[ level.play_killstreak_firewall_being_hacked_dialog ]](killstreaktype, killstreakid);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 2, eflags: 0x0
// Checksum 0x4fecac78, Offset: 0x700
// Size: 0x3c
function play_killstreak_firewall_hacked_dialog(killstreaktype, killstreakid) {
    if (isdefined(level.play_killstreak_firewall_hacked_dialog)) {
        self [[ level.play_killstreak_firewall_hacked_dialog ]](killstreaktype, killstreakid);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 2, eflags: 0x0
// Checksum 0xea712cb8, Offset: 0x748
// Size: 0x3c
function play_killstreak_being_hacked_dialog(killstreaktype, killstreakid) {
    if (isdefined(level.play_killstreak_being_hacked_dialog)) {
        self [[ level.play_killstreak_being_hacked_dialog ]](killstreaktype, killstreakid);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x0
// Checksum 0x2fbd5d31, Offset: 0x790
// Size: 0x44
function play_killstreak_hacked_dialog(killstreaktype, killstreakid, hacker) {
    if (isdefined(level.play_killstreak_hacked_dialog)) {
        self [[ level.play_killstreak_hacked_dialog ]](killstreaktype, killstreakid, hacker);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x0
// Checksum 0xc9336821, Offset: 0x7e0
// Size: 0x44
function play_killstreak_start_dialog(hardpointtype, team, killstreak_id) {
    if (isdefined(level.play_killstreak_start_dialog)) {
        self [[ level.play_killstreak_start_dialog ]](hardpointtype, team, killstreak_id);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 4, eflags: 0x0
// Checksum 0x96dfcacf, Offset: 0x830
// Size: 0x50
function play_pilot_dialog(dialogkey, killstreaktype, killstreakid, pilotindex) {
    if (isdefined(level.play_pilot_dialog)) {
        self [[ level.play_pilot_dialog ]](dialogkey, killstreaktype, killstreakid, pilotindex);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x0
// Checksum 0xe51bda8f, Offset: 0x888
// Size: 0x44
function play_pilot_dialog_on_owner(dialogkey, killstreaktype, killstreakid) {
    if (isdefined(level.play_pilot_dialog_on_owner)) {
        self [[ level.play_pilot_dialog_on_owner ]](dialogkey, killstreaktype, killstreakid);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 2, eflags: 0x0
// Checksum 0x5f25672f, Offset: 0x8d8
// Size: 0x3c
function play_destroyed_dialog_on_owner(killstreaktype, killstreakid) {
    if (isdefined(level.play_destroyed_dialog_on_owner)) {
        self [[ level.play_destroyed_dialog_on_owner ]](killstreaktype, killstreakid);
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 1, eflags: 0x0
// Checksum 0x2bcec395, Offset: 0x920
// Size: 0x1cc
function function_1110a5de(killstreaktype) {
    assert(isdefined(killstreaktype), "<dev string:x38>");
    assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x74>");
    pilotdialogarraykey = level.killstreaks[killstreaktype].script_bundle.var_b7bd2ff9;
    if (isdefined(pilotdialogarraykey)) {
        taacombundles = getscriptbundles("mpdialog_taacom");
        foreach (bundle in taacombundles) {
            if (!isdefined(bundle.pilotbundles)) {
                bundle.pilotbundles = [];
            }
            bundle.pilotbundles[killstreaktype] = [];
            i = 0;
            field = pilotdialogarraykey + i;
            for (fieldvalue = bundle.(field); isdefined(fieldvalue); fieldvalue = bundle.(field)) {
                bundle.pilotbundles[killstreaktype][i] = fieldvalue;
                i++;
                field = pilotdialogarraykey + i;
            }
        }
        level.tacombundles = taacombundles;
    }
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 1, eflags: 0x0
// Checksum 0xfe4c7268, Offset: 0xaf8
// Size: 0x56
function get_killstreak_inform_dialog(killstreaktype) {
    if (isdefined(level.killstreaks[killstreaktype].script_bundle.var_5fbfc70d)) {
        return level.killstreaks[killstreaktype].script_bundle.var_5fbfc70d;
    }
    return "";
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 1, eflags: 0x0
// Checksum 0x5572c7e5, Offset: 0xb58
// Size: 0x30
function get_mpdialog_tacom_bundle(name) {
    if (!isdefined(level.tacombundles)) {
        return undefined;
    }
    return level.tacombundles[name];
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 1, eflags: 0x0
// Checksum 0xd42cb40b, Offset: 0xb90
// Size: 0x4c
function function_d2219b7d(type) {
    self play_pilot_dialog_on_owner("timeout", type);
    self play_taacom_dialog_response_on_owner("timeoutConfirmed", type);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 1, eflags: 0x0
// Checksum 0xa45e27f1, Offset: 0xbe8
// Size: 0xda
function get_random_pilot_index(killstreaktype) {
    if (!isdefined(killstreaktype)) {
        return undefined;
    }
    if (!isdefined(self.pers[level.var_bc01f047])) {
        return undefined;
    }
    taacombundle = get_mpdialog_tacom_bundle(self.pers[level.var_bc01f047]);
    if (!isdefined(taacombundle) || !isdefined(taacombundle.pilotbundles)) {
        return undefined;
    }
    if (!isdefined(taacombundle.pilotbundles[killstreaktype])) {
        return undefined;
    }
    numpilots = taacombundle.pilotbundles[killstreaktype].size;
    if (numpilots <= 0) {
        return undefined;
    }
    return randomint(numpilots);
}

