#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_customgame;

#namespace serversettings;

// Namespace serversettings/serversettings
// Params 0, eflags: 0x6
// Checksum 0x119491c7, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"serversettings", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace serversettings/serversettings
// Params 0, eflags: 0x5 linked
// Checksum 0xde80baf3, Offset: 0xd8
// Size: 0x24
function private function_70a657d8() {
    callback::on_start_gametype(&main);
}

// Namespace serversettings/serversettings
// Params 0, eflags: 0x1 linked
// Checksum 0xdf636c58, Offset: 0x108
// Size: 0x47e
function main() {
    level.hostname = getdvarstring(#"sv_hostname");
    if (level.hostname == "") {
        level.hostname = "CoDHost";
    }
    setdvar(#"sv_hostname", level.hostname);
    setdvar(#"ui_hostname", level.hostname);
    level.motd = getdvarstring(#"scr_motd");
    if (level.motd == "") {
        level.motd = "";
    }
    setdvar(#"scr_motd", level.motd);
    setdvar(#"ui_motd", level.motd);
    level.allowvote = getdvarint(#"g_allowvote", 1);
    setdvar(#"g_allowvote", level.allowvote);
    setdvar(#"ui_allowvote", level.allowvote);
    level.allow_teamchange = 0;
    if (sessionmodeisprivate() || !sessionmodeisonlinegame()) {
        level.allow_teamchange = 1;
    }
    setdvar(#"ui_allow_teamchange", level.allow_teamchange);
    level.friendlyfire = getgametypesetting(#"zmfriendlyfiretype");
    if (!isdefined(level.friendlyfire)) {
        level.friendlyfire = 0;
    }
    setdvar(#"ui_friendlyfire", level.friendlyfire);
    if (!isdefined(getdvar(#"scr_mapsize"))) {
        setdvar(#"scr_mapsize", 64);
    } else if (getdvarfloat(#"scr_mapsize", 0) >= 64) {
        setdvar(#"scr_mapsize", 64);
    } else if (getdvarfloat(#"scr_mapsize", 0) >= 32) {
        setdvar(#"scr_mapsize", 32);
    } else if (getdvarfloat(#"scr_mapsize", 0) >= 16) {
        setdvar(#"scr_mapsize", 16);
    } else {
        setdvar(#"scr_mapsize", 8);
    }
    for (;;) {
        updateserversettings();
        wait 5;
    }
}

// Namespace serversettings/serversettings
// Params 0, eflags: 0x1 linked
// Checksum 0x4b445437, Offset: 0x590
// Size: 0x204
function updateserversettings() {
    sv_hostname = getdvarstring(#"sv_hostname");
    if (level.hostname != sv_hostname) {
        level.hostname = sv_hostname;
        setdvar(#"ui_hostname", level.hostname);
    }
    scr_motd = getdvarstring(#"scr_motd");
    if (level.motd != scr_motd) {
        level.motd = scr_motd;
        setdvar(#"ui_motd", level.motd);
    }
    g_allowvote = getdvarstring(#"g_allowvote");
    if (level.allowvote != g_allowvote) {
        level.allowvote = g_allowvote;
        setdvar(#"ui_allowvote", level.allowvote);
    }
    scr_friendlyfire = getgametypesetting(#"zmfriendlyfiretype");
    if (!isdefined(scr_friendlyfire)) {
        scr_friendlyfire = 0;
    }
    if (level.friendlyfire != scr_friendlyfire) {
        level.friendlyfire = scr_friendlyfire;
        zm_custom::function_928be07c();
        setdvar(#"ui_friendlyfire", level.friendlyfire);
    }
}

