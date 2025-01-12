#using scripts/core_common/callbacks_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace music;

// Namespace music/music_shared
// Params 0, eflags: 0x2
// Checksum 0x588e1ff2, Offset: 0x110
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("music", &__init__, undefined, undefined);
}

// Namespace music/music_shared
// Params 0, eflags: 0x0
// Checksum 0xd867f7a6, Offset: 0x150
// Size: 0x64
function __init__() {
    level.musicstate = "";
    util::registerclientsys("musicCmd");
    if (sessionmodeiscampaigngame()) {
        callback::on_spawned(&on_player_spawned);
    }
}

// Namespace music/music_shared
// Params 2, eflags: 0x0
// Checksum 0xa03342de, Offset: 0x1c0
// Size: 0x94
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
// Checksum 0x6b7dbc0d, Offset: 0x260
// Size: 0xca
function setmusicstatebyteam(state, str_teamname) {
    foreach (player in level.players) {
        if (isdefined(player.team) && player.team == str_teamname) {
            setmusicstate(state, player);
        }
    }
}

// Namespace music/music_shared
// Params 0, eflags: 0x0
// Checksum 0x3d5638fd, Offset: 0x338
// Size: 0xac
function on_player_spawned() {
    if (isdefined(level.musicstate)) {
        if (issubstr(level.musicstate, "_igc") || issubstr(level.musicstate, "igc_")) {
            return;
        }
        if (isdefined(self)) {
            setmusicstate(level.musicstate, self);
            return;
        }
        setmusicstate(level.musicstate);
    }
}

