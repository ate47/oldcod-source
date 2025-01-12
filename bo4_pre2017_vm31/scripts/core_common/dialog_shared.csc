#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace dialog_shared;

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x2
// Checksum 0x6e1dad7f, Offset: 0x320
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("dialog_shared", &__init__, undefined, undefined);
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x52c7ae7f, Offset: 0x360
// Size: 0x204
function __init__() {
    level.mpboostresponse = [];
    level.mpboostresponse["assassin"] = "Spectre";
    level.mpboostresponse["grenadier"] = "Grenadier";
    level.mpboostresponse["outrider"] = "Outrider";
    level.mpboostresponse["prophet"] = "Technomancer";
    level.mpboostresponse["pyro"] = "Firebreak";
    level.mpboostresponse["reaper"] = "Reaper";
    level.mpboostresponse["ruin"] = "Mercenary";
    level.mpboostresponse["seraph"] = "Enforcer";
    level.mpboostresponse["trapper"] = "Trapper";
    level.mpboostresponse["blackjack"] = "Blackjack";
    level.clientvoicesetup = &client_voice_setup;
    clientfield::register("world", "boost_number", 1, 2, "int", &set_boost_number, 1, 1);
    clientfield::register("allplayers", "play_boost", 1, 2, "int", &play_boost_vox, 1, 0);
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xf5b79d91, Offset: 0x570
// Size: 0x84
function client_voice_setup(localclientnum) {
    self thread snipervonotify(localclientnum, "playerbreathinsound", "exertSniperHold");
    self thread snipervonotify(localclientnum, "playerbreathoutsound", "exertSniperExhale");
    self thread snipervonotify(localclientnum, "playerbreathgaspsound", "exertSniperGasp");
}

// Namespace dialog_shared/dialog_shared
// Params 3, eflags: 0x0
// Checksum 0x6a205e38, Offset: 0x600
// Size: 0xa0
function snipervonotify(localclientnum, notifystring, dialogkey) {
    self endon(#"death");
    for (;;) {
        self waittill(notifystring);
        if (isunderwater(localclientnum)) {
            return;
        }
        dialogalias = self get_player_dialog_alias(dialogkey);
        if (isdefined(dialogalias)) {
            self playsound(0, dialogalias);
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 7, eflags: 0x0
// Checksum 0xfe168abe, Offset: 0x6a8
// Size: 0x4c
function set_boost_number(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.boostnumber = newval;
}

// Namespace dialog_shared/dialog_shared
// Params 7, eflags: 0x0
// Checksum 0x357cb93a, Offset: 0x700
// Size: 0x15c
function play_boost_vox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayerteam = getlocalplayerteam(localclientnum);
    entitynumber = self getentitynumber();
    if (newval == 0 || self.team != localplayerteam || level._sndnextsnapshot != "mpl_prematch" || level.booststartentnum === entitynumber || level.boostresponseentnum === entitynumber) {
        return;
    }
    if (newval == 1) {
        level.booststartentnum = entitynumber;
        self thread play_boost_start_vox(localclientnum);
        return;
    }
    if (newval == 2) {
        level.boostresponseentnum = entitynumber;
        self thread play_boost_start_response_vox(localclientnum);
    }
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x1d6b3ff, Offset: 0x868
// Size: 0x13c
function play_boost_start_vox(localclientnum) {
    self endon(#"death");
    wait 2;
    playbackid = self play_dialog("boostStart" + level.boostnumber, localclientnum);
    if (isdefined(playbackid) && playbackid >= 0) {
        while (soundplaying(playbackid)) {
            wait 0.05;
        }
    }
    wait 0.5;
    level.booststartresponse = "boostStartResp" + level.mpboostresponse[self getmpdialogname()] + level.boostnumber;
    if (isdefined(level.boostresponseentnum)) {
        responder = getentbynum(localclientnum, level.boostresponseentnum);
        if (isdefined(responder)) {
            responder thread play_boost_start_response_vox(localclientnum);
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xbf6f883d, Offset: 0x9b0
// Size: 0x74
function play_boost_start_response_vox(localclientnum) {
    self endon(#"death");
    if (!isdefined(level.booststartresponse) || self.team != getlocalplayerteam(localclientnum)) {
        return;
    }
    self play_dialog(level.booststartresponse, localclientnum);
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xb0f2f63d, Offset: 0xa30
// Size: 0x62
function get_commander_dialog_alias(commandername, dialogkey) {
    if (!isdefined(commandername)) {
        return;
    }
    commanderbundle = struct::get_script_bundle("mpdialog_commander", commandername);
    return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x8ba2af87, Offset: 0xaa0
// Size: 0x82
function get_player_dialog_alias(dialogkey) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    return get_dialog_bundle_alias(playerbundle, dialogkey);
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x820109a1, Offset: 0xb30
// Size: 0x96
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

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x3016f54c, Offset: 0xbd0
// Size: 0x162
function play_dialog(dialogkey, localclientnum) {
    if (!isdefined(dialogkey) || !isdefined(localclientnum)) {
        return -1;
    }
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (!isdefined(dialogalias)) {
        return -1;
    }
    soundpos = (self.origin[0], self.origin[1], self.origin[2] + 60);
    if (!isspectating(localclientnum)) {
        return self playsound(undefined, dialogalias, soundpos);
    }
    voicebox = spawn(localclientnum, self.origin, "script_model");
    self thread update_voice_origin(voicebox);
    voicebox thread delete_after(10);
    return voicebox playsound(undefined, dialogalias, soundpos);
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x6c7cd60e, Offset: 0xd40
// Size: 0x50
function update_voice_origin(voicebox) {
    while (true) {
        wait 0.1;
        if (!isdefined(self) || !isdefined(voicebox)) {
            return;
        }
        voicebox.origin = self.origin;
    }
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xa15ad44, Offset: 0xd98
// Size: 0x24
function delete_after(waittime) {
    wait waittime;
    self delete();
}

