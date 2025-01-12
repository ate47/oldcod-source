#using scripts/core_common/util_shared;

#namespace sound;

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0x118cce4a, Offset: 0xd0
// Size: 0xa4
function loop_fx_sound(alias, origin, ender) {
    org = spawn("script_origin", (0, 0, 0));
    if (isdefined(ender)) {
        thread loop_delete(ender, org);
        self endon(ender);
    }
    org.origin = origin;
    org playloopsound(alias);
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xf0e0684, Offset: 0x180
// Size: 0x44
function loop_delete(ender, ent) {
    ent endon(#"death");
    self waittill(ender);
    ent delete();
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0x589ec840, Offset: 0x1d0
// Size: 0xc4
function play_in_space(alias, origin, master) {
    org = spawn("script_origin", (0, 0, 1));
    if (!isdefined(origin)) {
        origin = self.origin;
    }
    org.origin = origin;
    org playsoundwithnotify(alias, "sounddone");
    org waittill("sounddone");
    if (isdefined(org)) {
        org delete();
    }
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0xf2a9cbf7, Offset: 0x2a0
// Size: 0x16c
function loop_on_tag(alias, tag, bstopsoundondeath) {
    org = spawn("script_origin", (0, 0, 0));
    org endon(#"death");
    if (!isdefined(bstopsoundondeath)) {
        bstopsoundondeath = 1;
    }
    if (bstopsoundondeath) {
        thread util::delete_on_death(org);
    }
    if (isdefined(tag)) {
        org linkto(self, tag, (0, 0, 0), (0, 0, 0));
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    org playloopsound(alias);
    self waittill("stop sound" + alias);
    org stoploopsound(alias);
    org delete();
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0xb84606e, Offset: 0x418
// Size: 0x1a4
function play_on_tag(alias, tag, ends_on_death) {
    org = spawn("script_origin", (0, 0, 0));
    org endon(#"death");
    thread delete_on_death_wait(org, "sounddone");
    if (isdefined(tag)) {
        org.origin = self gettagorigin(tag);
        org linkto(self, tag, (0, 0, 0), (0, 0, 0));
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    org playsoundwithnotify(alias, "sounddone");
    if (isdefined(ends_on_death)) {
        assert(ends_on_death, "<dev string:x28>");
        wait_for_sounddone_or_death(org);
        waitframe(1);
    } else {
        org waittill("sounddone");
    }
    org delete();
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x0
// Checksum 0xc61852c0, Offset: 0x5c8
// Size: 0x24
function play_on_entity(alias) {
    play_on_tag(alias);
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x0
// Checksum 0xed80f93e, Offset: 0x5f8
// Size: 0x28
function wait_for_sounddone_or_death(org) {
    self endon(#"death");
    org waittill("sounddone");
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x0
// Checksum 0xb3cac54d, Offset: 0x628
// Size: 0x20
function stop_loop_on_entity(alias) {
    self notify("stop sound" + alias);
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xc3041b70, Offset: 0x650
// Size: 0x16c
function loop_on_entity(alias, offset) {
    org = spawn("script_origin", (0, 0, 0));
    org endon(#"death");
    thread util::delete_on_death(org);
    if (isdefined(offset)) {
        org.origin = self.origin + offset;
        org.angles = self.angles;
        org linkto(self);
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    org playloopsound(alias);
    self waittill("stop sound" + alias);
    org stoploopsound(0.1);
    org delete();
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0xcc36fe53, Offset: 0x7c8
// Size: 0xd4
function loop_in_space(alias, origin, ender) {
    org = spawn("script_origin", (0, 0, 1));
    if (!isdefined(origin)) {
        origin = self.origin;
    }
    org.origin = origin;
    org playloopsound(alias);
    level waittill(ender);
    org stoploopsound();
    wait 0.1;
    org delete();
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xba056c06, Offset: 0x8a8
// Size: 0x54
function delete_on_death_wait(ent, sounddone) {
    ent endon(#"death");
    self waittill("death");
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0x75881d19, Offset: 0x908
// Size: 0x196
function play_on_players(sound, team) {
    assert(isdefined(level.players));
    if (level.splitscreen) {
        if (isdefined(level.players[0])) {
            level.players[0] playlocalsound(sound);
        }
        return;
    }
    if (isdefined(team)) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
                player playlocalsound(sound);
            }
        }
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        level.players[i] playlocalsound(sound);
    }
}

