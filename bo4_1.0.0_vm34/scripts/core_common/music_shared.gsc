#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace music;

// Namespace music/music_shared
// Params 0, eflags: 0x2
// Checksum 0xb12d405b, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"music", &__init__, undefined, undefined);
}

// Namespace music/music_shared
// Params 0, eflags: 0x0
// Checksum 0x8bea636, Offset: 0xe8
// Size: 0x8c
function __init__() {
    level.musicstate = "";
    util::registerclientsys("musicCmd");
    if (sessionmodeiscampaigngame()) {
        callback::on_spawned(&on_player_spawned);
    }
    if (sessionmodeiswarzonegame()) {
        callback::on_connect(&function_43b0a4df);
    }
}

// Namespace music/music_shared
// Params 2, eflags: 0x0
// Checksum 0x7e749733, Offset: 0x180
// Size: 0x8a
function setmusicstate(state, player) {
    if (isdefined(level.musicstate)) {
        if (isdefined(player)) {
            util::setclientsysstate("musicCmd", state, player);
            return;
        } else if (level.musicstate != state) {
            util::setclientsysstate("musicCmd", state);
        }
    }
    level.musicstate = state;
}

// Namespace music/music_shared
// Params 2, eflags: 0x0
// Checksum 0xe192ab47, Offset: 0x218
// Size: 0xb8
function setmusicstatebyteam(state, str_teamname) {
    foreach (player in level.players) {
        if (isdefined(player.team) && player.team == str_teamname) {
            setmusicstate(state, player);
        }
    }
}

// Namespace music/music_shared
// Params 0, eflags: 0x0
// Checksum 0x9d9fe08b, Offset: 0x2d8
// Size: 0x66
function on_player_spawned() {
    if (isdefined(level.musicstate)) {
        if (issubstr(level.musicstate, "_igc") || issubstr(level.musicstate, "igc_")) {
            return;
        }
        if (isdefined(self)) {
        }
    }
}

// Namespace music/music_shared
// Params 0, eflags: 0x0
// Checksum 0x2da3dcc3, Offset: 0x348
// Size: 0x24
function function_43b0a4df() {
    if (isdefined(self)) {
        setmusicstate("none", self);
    }
}

