#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace dialog_shared;

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x2
// Checksum 0x3efc24a1, Offset: 0x1f8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"dialog_shared", &__init__, undefined, undefined);
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xa5383533, Offset: 0x240
// Size: 0x24c
function __init__() {
    level.mpboostresponse = [];
    level.mpboostresponse[#"battery"] = "Battery";
    level.mpboostresponse[#"buffassault"] = "BuffAssault";
    level.mpboostresponse[#"engineer"] = "Engineer";
    level.mpboostresponse[#"firebreak"] = "Firebreak";
    level.mpboostresponse[#"nomad"] = "Nomad";
    level.mpboostresponse[#"prophet"] = "Prophet";
    level.mpboostresponse[#"recon"] = "Recon";
    level.mpboostresponse[#"ruin"] = "Ruin";
    level.mpboostresponse[#"seraph"] = "Seraph";
    level.mpboostresponse[#"swatpolice"] = "SwatPolice";
    level.clientvoicesetup = &client_voice_setup;
    clientfield::register("world", "boost_number", 1, 2, "int", &set_boost_number, 1, 1);
    clientfield::register("allplayers", "play_boost", 1, 2, "int", &play_boost_vox, 1, 0);
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x72893f0b, Offset: 0x498
// Size: 0x84
function client_voice_setup(localclientnum) {
    self thread snipervonotify(localclientnum, "playerbreathinsound", "exertSniperHold");
    self thread snipervonotify(localclientnum, "playerbreathoutsound", "exertSniperExhale");
    self thread snipervonotify(localclientnum, "playerbreathgaspsound", "exertSniperGasp");
}

// Namespace dialog_shared/dialog_shared
// Params 3, eflags: 0x0
// Checksum 0x520cc4ad, Offset: 0x528
// Size: 0x98
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
// Checksum 0x79abf3f2, Offset: 0x5c8
// Size: 0x4a
function set_boost_number(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.boostnumber = newval;
}

// Namespace dialog_shared/dialog_shared
// Params 7, eflags: 0x0
// Checksum 0xc9b2575e, Offset: 0x620
// Size: 0x14c
function play_boost_vox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayerteam = function_e4542aa3(localclientnum);
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
// Checksum 0x1bbb1205, Offset: 0x778
// Size: 0x124
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
// Checksum 0xf93a8d1, Offset: 0x8a8
// Size: 0x6c
function play_boost_start_response_vox(localclientnum) {
    self endon(#"death");
    if (!isdefined(level.booststartresponse) || !self function_55a8b32b()) {
        return;
    }
    self play_dialog(level.booststartresponse, localclientnum);
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x401f5ec2, Offset: 0x920
// Size: 0x5a
function get_commander_dialog_alias(commandername, dialogkey) {
    if (!isdefined(commandername)) {
        return;
    }
    commanderbundle = struct::get_script_bundle("mpdialog_commander", commandername);
    return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x44bbfa2, Offset: 0x988
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

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xb5610d74, Offset: 0xa18
// Size: 0x86
function mpdialog_value(mpdialogkey, defaultvalue) {
    if (!isdefined(mpdialogkey)) {
        return defaultvalue;
    }
    mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
    if (!isdefined(mpdialog)) {
        return defaultvalue;
    }
    structvalue = mpdialog.(mpdialogkey);
    if (!isdefined(structvalue)) {
        return defaultvalue;
    }
    return structvalue;
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xaf22ca51, Offset: 0xaa8
// Size: 0x112
function get_player_dialog_alias(dialogkey, meansofdeath = undefined) {
    if (!isdefined(self)) {
        return undefined;
    }
    bundlename = self getmpdialogname();
    if (isdefined(meansofdeath) && meansofdeath == "MOD_META" && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0)) {
        bundlename = self.var_4d52496f;
    }
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return undefined;
    }
    return get_dialog_bundle_alias(playerbundle, dialogkey);
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x861b93f6, Offset: 0xbc8
// Size: 0x14a
function play_dialog(dialogkey, localclientnum) {
    if (!isdefined(dialogkey) || !isdefined(localclientnum)) {
        return -1;
    }
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (!isdefined(dialogalias)) {
        return -1;
    }
    soundpos = (self.origin[0], self.origin[1], self.origin[2] + 60);
    if (!function_9a47ed7f(localclientnum)) {
        return self playsound(undefined, dialogalias, soundpos);
    }
    voicebox = spawn(localclientnum, self.origin, "script_model");
    self thread update_voice_origin(voicebox);
    voicebox thread delete_after(10);
    return voicebox playsound(undefined, dialogalias, soundpos);
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x1a28cbe7, Offset: 0xd20
// Size: 0x4a
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
// Checksum 0xd51a33e9, Offset: 0xd78
// Size: 0x24
function delete_after(waittime) {
    wait waittime;
    self delete();
}

