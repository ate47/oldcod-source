#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace battlechatter;

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x0
// Checksum 0xbc8978e5, Offset: 0xf0
// Size: 0x42
function function_b59a25c5(player) {
    playerbundle = function_58c93260(player);
    if (!isdefined(playerbundle)) {
        return undefined;
    }
    return playerbundle.voiceprefix;
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x0
// Checksum 0x30d180a5, Offset: 0x140
// Size: 0x52
function function_cdd81094(weapon) {
    assert(isdefined(weapon));
    if (!isdefined(weapon.var_5c238c21)) {
        return undefined;
    }
    return getscriptbundle(weapon.var_5c238c21);
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x0
// Checksum 0x1076712, Offset: 0x1a0
// Size: 0x80
function function_b79dc4e7(player) {
    teammask = getteammask(player.team);
    for (teamindex = 0; teammask > 1; teamindex++) {
        teammask >>= 1;
    }
    if (teamindex % 2) {
        return "blops_taacom";
    }
    return "cdp_taacom";
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x0
// Checksum 0x95c9e989, Offset: 0x228
// Size: 0x7e
function mpdialog_value(mpdialogkey, defaultvalue) {
    if (!isdefined(mpdialogkey)) {
        return defaultvalue;
    }
    mpdialog = getscriptbundle("mpdialog_default");
    if (!isdefined(mpdialog)) {
        return defaultvalue;
    }
    structvalue = mpdialog.(mpdialogkey);
    if (!isdefined(structvalue)) {
        return defaultvalue;
    }
    return structvalue;
}

// Namespace battlechatter/namespace_7819da81
// Params 4, eflags: 0x0
// Checksum 0x5545eb1e, Offset: 0x2b0
// Size: 0x156
function function_d804d2f0(localclientnum, speakingplayer, player, allyradiussq) {
    if (!isdefined(player)) {
        return false;
    }
    if (!isdefined(player.origin)) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    if (player underwater()) {
        return false;
    }
    if (player isdriving(localclientnum)) {
        return false;
    }
    if (function_e75c64a4(localclientnum)) {
        return false;
    }
    if (!isdefined(speakingplayer)) {
        return false;
    }
    if (!isdefined(speakingplayer.origin)) {
        return false;
    }
    if (player == speakingplayer || player.team != speakingplayer.team) {
        return false;
    }
    if (player hasperk(localclientnum, "specialty_quieter")) {
        return false;
    }
    distsq = distancesquared(speakingplayer.origin, player.origin);
    if (distsq > allyradiussq) {
        return false;
    }
    return true;
}

// Namespace battlechatter/namespace_7819da81
// Params 3, eflags: 0x0
// Checksum 0x1ebeb591, Offset: 0x410
// Size: 0x11a
function function_db89c38f(localclientnum, speakingplayer, allyradiussq) {
    allies = [];
    foreach (player in getplayers(localclientnum)) {
        if (!function_d804d2f0(localclientnum, speakingplayer, player, allyradiussq)) {
            continue;
        }
        allies[allies.size] = player;
    }
    allies = arraysort(allies, speakingplayer.origin);
    if (!isdefined(allies) || allies.size == 0) {
        return undefined;
    }
    return allies[0];
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x0
// Checksum 0x228c336, Offset: 0x538
// Size: 0x9a
function function_5d7ad9a9(hacker, originalowner) {
    if (!isdefined(originalowner) || !isplayer(originalowner) || !originalowner function_21c0fa55()) {
        return false;
    }
    if (!isdefined(hacker) || !isplayer(hacker) || !isalive(hacker)) {
        return false;
    }
    return true;
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x0
// Checksum 0xb6405ba3, Offset: 0x5e0
// Size: 0x32
function function_84eb6127(player) {
    return getscriptbundle(function_b79dc4e7(player));
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x0
// Checksum 0xf5532393, Offset: 0x620
// Size: 0x10a
function get_player_dialog_alias(dialogkey, meansofdeath = undefined) {
    if (!isdefined(self)) {
        return undefined;
    }
    bundlename = self getmpdialogname();
    if (isdefined(meansofdeath) && meansofdeath == "MOD_META" && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0)) {
        bundlename = self.var_89c4a60f;
    }
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = getscriptbundle(bundlename);
    if (!isdefined(playerbundle)) {
        return undefined;
    }
    return get_dialog_bundle_alias(playerbundle, dialogkey);
}

// Namespace battlechatter/namespace_7819da81
// Params 2, eflags: 0x0
// Checksum 0x2bbd8404, Offset: 0x738
// Size: 0x80
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

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x0
// Checksum 0x26ac12f2, Offset: 0x7c0
// Size: 0x24
function delete_after(waittime) {
    wait waittime;
    self delete();
}

// Namespace battlechatter/namespace_7819da81
// Params 1, eflags: 0x0
// Checksum 0xe03ce8db, Offset: 0x7f0
// Size: 0x62
function function_58c93260(player) {
    if (!isplayer(player)) {
        return undefined;
    }
    bundlename = player getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    return getscriptbundle(bundlename);
}

