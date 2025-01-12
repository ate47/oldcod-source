#namespace sound;

// Namespace sound/sound_shared
// Params 4, eflags: 0x0
// Checksum 0xc6a2e552, Offset: 0x90
// Size: 0x9c
function loop_fx_sound(clientnum, alias, origin, ender) {
    sound_entity = spawn(clientnum, origin, "script_origin");
    if (isdefined(ender)) {
        thread loop_delete(ender, sound_entity);
        self endon(ender);
    }
    sound_entity playloopsound(alias);
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0x98020c8b, Offset: 0x138
// Size: 0x3c
function play_in_space(localclientnum, alias, origin) {
    playsound(localclientnum, alias, origin);
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xaa77c34, Offset: 0x180
// Size: 0x34
function loop_delete(ender, sound_entity) {
    self waittill(ender);
    sound_entity delete();
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x0
// Checksum 0x460f7064, Offset: 0x1c0
// Size: 0x4c
function play_on_client(sound_alias) {
    players = level.localplayers;
    playsound(0, sound_alias, players[0].origin);
}

// Namespace sound/sound_shared
// Params 4, eflags: 0x0
// Checksum 0xae63fd2c, Offset: 0x218
// Size: 0x8a
function loop_on_client(sound_alias, min_delay, max_delay, end_on) {
    players = level.localplayers;
    if (isdefined(end_on)) {
        level endon(end_on);
    }
    for (;;) {
        play_on_client(sound_alias);
        wait min_delay + randomfloat(max_delay);
    }
}

