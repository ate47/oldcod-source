#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace music;

// Namespace music/music_shared
// Params 0, eflags: 0x6
// Checksum 0xf920fe66, Offset: 0xc0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"music", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace music/music_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x2b37df63, Offset: 0x108
// Size: 0x5c
function private function_70a657d8() {
    level.musicstate = "";
    util::registerclientsys("musicCmd");
    if (sessionmodeiscampaigngame()) {
        callback::on_spawned(&on_player_spawned);
    }
}

// Namespace music/music_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x1b4e0113, Offset: 0x170
// Size: 0x3c
function setmusicstate(state, player, delay) {
    level thread function_d6f7c644(state, player, delay);
}

// Namespace music/music_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xa777c6d0, Offset: 0x1b8
// Size: 0xa4
function function_d6f7c644(state, player, delay) {
    if (isdefined(level.musicstate)) {
        if (isdefined(delay)) {
            wait delay;
        }
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
// Params 2, eflags: 0x1 linked
// Checksum 0xbb91075a, Offset: 0x268
// Size: 0xc0
function setmusicstatebyteam(state, str_teamname) {
    foreach (player in level.players) {
        if (isdefined(player.team) && player.team == str_teamname) {
            setmusicstate(state, player);
        }
    }
}

// Namespace music/music_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x16057600, Offset: 0x330
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
// Checksum 0x13b68e87, Offset: 0x3a0
// Size: 0x24
function function_cbeeecf() {
    if (isdefined(self)) {
        setmusicstate("none", self);
    }
}

// Namespace music/music_shared
// Params 2, eflags: 0x0
// Checksum 0x782c3d95, Offset: 0x3d0
// Size: 0x44
function function_edda155f(str_alias, n_delay) {
    level thread function_2b18b6d6(#"mus_" + str_alias + "_intro", n_delay);
}

// Namespace music/music_shared
// Params 3, eflags: 0x0
// Checksum 0x52e45990, Offset: 0x420
// Size: 0x12c
function function_2af5f0ec(str_alias, var_e08a84d6, n_delay) {
    if (isdefined(var_e08a84d6)) {
        level thread function_2b18b6d6(#"mus_" + str_alias + "_loop_" + var_e08a84d6, n_delay);
        return;
    }
    var_d49193ec = "mus_" + str_alias + "_loop_";
    n_max = 0;
    for (i = 0; i < 9; i++) {
        if (!soundexists(var_d49193ec + i)) {
            n_max = i;
        }
    }
    if (n_max > 0) {
        level thread function_2b18b6d6(#"mus_" + str_alias + "_loop_" + randomintrange(0, n_max), n_delay);
    }
}

// Namespace music/music_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd7fd75f1, Offset: 0x558
// Size: 0x3c
function function_2b18b6d6(str_alias, n_delay) {
    if (isdefined(n_delay)) {
        wait n_delay;
    }
    playsoundatposition(str_alias, (0, 0, 0));
}

