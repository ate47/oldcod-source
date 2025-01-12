#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace serversettings;

// Namespace serversettings/serversettings
// Params 0, eflags: 0x2
// Checksum 0xf9fbb1ad, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"serversettings", &__init__, undefined, undefined);
}

// Namespace serversettings/serversettings
// Params 0, eflags: 0x0
// Checksum 0x6e9f7379, Offset: 0xe8
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace serversettings/serversettings
// Params 0, eflags: 0x0
// Checksum 0x7ad6acfd, Offset: 0x118
// Size: 0x396
function init() {
    level.hostname = getdvarstring(#"sv_hostname");
    if (level.hostname == "") {
        level.hostname = "CoDHost";
    }
    setdvar(#"sv_hostname", level.hostname);
    level.allowvote = getdvarint(#"g_allowvote", 1);
    setdvar(#"g_allowvote", level.allowvote);
    level.allow_teamchange = 0;
    allowingameteamchange = getgametypesetting(#"allowingameteamchange");
    if ((sessionmodeisprivate() || !sessionmodeisonlinegame()) && isdefined(allowingameteamchange) && allowingameteamchange) {
        level.allow_teamchange = 1;
    }
    level.friendlyfire = getgametypesetting(#"friendlyfiretype");
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
    level.mapsize = getdvarfloat(#"scr_mapsize", 0);
    constrain_gametype(util::get_game_type());
    constrain_map_size(level.mapsize);
    for (;;) {
        update();
        wait 5;
    }
}

// Namespace serversettings/serversettings
// Params 0, eflags: 0x0
// Checksum 0x82668e16, Offset: 0x4b8
// Size: 0x16c
function update() {
    sv_hostname = getdvarstring(#"sv_hostname");
    if (level.hostname != sv_hostname) {
        level.hostname = sv_hostname;
        setdvar(#"ui_hostname", level.hostname);
    }
    g_allowvote = getdvarstring(#"g_allowvote");
    if (level.allowvote != g_allowvote) {
        level.allowvote = g_allowvote;
        setdvar(#"ui_allowvote", level.allowvote);
    }
    scr_friendlyfire = getgametypesetting(#"friendlyfiretype");
    if (level.friendlyfire != scr_friendlyfire) {
        level.friendlyfire = scr_friendlyfire;
        setdvar(#"ui_friendlyfire", level.friendlyfire);
    }
}

// Namespace serversettings/serversettings
// Params 1, eflags: 0x0
// Checksum 0x350f4f0e, Offset: 0x630
// Size: 0x23e
function constrain_gametype(gametype) {
    entities = getentarray();
    for (i = 0; i < entities.size; i++) {
        entity = entities[i];
        if (gametype == "dm") {
            if (isdefined(entity.script_gametype_dm) && entity.script_gametype_dm != 1) {
                entity delete();
            }
            continue;
        }
        if (gametype == "tdm") {
            if (isdefined(entity.script_gametype_tdm) && entity.script_gametype_tdm != 1) {
                entity delete();
            }
            continue;
        }
        if (gametype == "ctf") {
            if (isdefined(entity.script_gametype_ctf) && entity.script_gametype_ctf != 1) {
                entity delete();
            }
            continue;
        }
        if (gametype == "hq") {
            if (isdefined(entity.script_gametype_hq) && entity.script_gametype_hq != 1) {
                entity delete();
            }
            continue;
        }
        if (gametype == "sd") {
            if (isdefined(entity.script_gametype_sd) && entity.script_gametype_sd != 1) {
                entity delete();
            }
            continue;
        }
        if (gametype == "koth") {
            if (isdefined(entity.script_gametype_koth) && entity.script_gametype_koth != 1) {
                entity delete();
            }
        }
    }
}

// Namespace serversettings/serversettings
// Params 1, eflags: 0x0
// Checksum 0x480ba192, Offset: 0x878
// Size: 0x1be
function constrain_map_size(mapsize) {
    entities = getentarray();
    for (i = 0; i < entities.size; i++) {
        entity = entities[i];
        if (int(mapsize) == 8) {
            if (isdefined(entity.script_mapsize_08) && entity.script_mapsize_08 != 1) {
                entity delete();
            }
            continue;
        }
        if (int(mapsize) == 16) {
            if (isdefined(entity.script_mapsize_16) && entity.script_mapsize_16 != 1) {
                entity delete();
            }
            continue;
        }
        if (int(mapsize) == 32) {
            if (isdefined(entity.script_mapsize_32) && entity.script_mapsize_32 != 1) {
                entity delete();
            }
            continue;
        }
        if (int(mapsize) == 64) {
            if (isdefined(entity.script_mapsize_64) && entity.script_mapsize_64 != 1) {
                entity delete();
            }
        }
    }
}

