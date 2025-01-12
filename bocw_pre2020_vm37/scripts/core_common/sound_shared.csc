#using script_71463f7d72636705;

#namespace sound;

// Namespace sound/sound_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x69b1aa79, Offset: 0x80
// Size: 0x8c
function loop_fx_sound(clientnum, alias, origin, ender) {
    sound_entity = spawn(clientnum, origin, "script_origin");
    if (isdefined(ender)) {
        thread loop_delete(ender, sound_entity);
        self endon(ender);
    }
    sound_entity playloopsound(alias);
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x1adbefbe, Offset: 0x118
// Size: 0x34
function play_in_space(localclientnum, alias, origin) {
    playsound(localclientnum, alias, origin);
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9c562969, Offset: 0x158
// Size: 0x34
function loop_delete(ender, sound_entity) {
    self waittill(ender);
    sound_entity delete();
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x2a807f59, Offset: 0x198
// Size: 0x4c
function play_on_client(sound_alias) {
    players = level.localplayers;
    playsound(0, sound_alias, players[0].origin);
}

// Namespace sound/sound_shared
// Params 4, eflags: 0x0
// Checksum 0x2c5e6333, Offset: 0x1f0
// Size: 0x82
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

