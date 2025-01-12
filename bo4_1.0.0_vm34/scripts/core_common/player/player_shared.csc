#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace player;

// Namespace player/player_shared
// Params 0, eflags: 0x2
// Checksum 0x50612fed, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"player", &__init__, undefined, undefined);
}

// Namespace player/player_shared
// Params 0, eflags: 0x0
// Checksum 0x3c5e3fcb, Offset: 0x118
// Size: 0xec
function __init__() {
    clientfield::register("world", "gameplay_started", 1, 1, "int", &gameplay_started_callback, 0, 1);
    clientfield::register("toplayer", "gameplay_allows_deploy", 1, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "player_dof_settings", 1, 2, "int", &function_3c1374be, 0, 0);
    callback::on_localplayer_spawned(&local_player_spawn);
}

// Namespace player/player_shared
// Params 7, eflags: 0x0
// Checksum 0x84aa16b6, Offset: 0x210
// Size: 0x84
function gameplay_started_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setdvar(#"cg_isgameplayactive", newval);
    if (newval) {
        level callback::callback(#"on_gameplay_started", localclientnum);
    }
}

// Namespace player/player_shared
// Params 1, eflags: 0x0
// Checksum 0x4b6a9fff, Offset: 0x2a0
// Size: 0x54
function local_player_spawn(localclientnum) {
    if (!self function_60dbc438()) {
        return;
    }
    setdepthoffield(localclientnum, 0, 0, 0, 0, 6, 1.8);
}

// Namespace player/player_shared
// Params 7, eflags: 0x0
// Checksum 0x132fe27c, Offset: 0x300
// Size: 0x122
function function_3c1374be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        setdepthoffield(localclientnum, 0, 0, 512, 512, 4, 0);
        break;
    case 1:
        setdepthoffield(localclientnum, 0, 0, 512, 4000, 4, 0);
        break;
    case 2:
        setdepthoffield(localclientnum, 0, 128, 512, 4000, 6, 1.8);
        break;
    default:
        break;
    }
}

