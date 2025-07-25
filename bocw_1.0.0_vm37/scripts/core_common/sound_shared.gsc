#using scripts\core_common\ai_shared;
#using scripts\core_common\util_shared;

#namespace sound;

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0x48e1337b, Offset: 0xa0
// Size: 0x94
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
// Checksum 0xf94a19ba, Offset: 0x140
// Size: 0x4c
function loop_delete(ender, ent) {
    ent endon(#"death");
    self waittill(ender);
    ent delete();
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0x72d4fa1b, Offset: 0x198
// Size: 0xbc
function play_in_space(alias, origin, *master) {
    org = spawn("script_origin", (0, 0, 1));
    if (!isdefined(master)) {
        master = self.origin;
    }
    org.origin = master;
    org playsoundwithnotify(origin, "sounddone");
    org waittill(#"sounddone");
    if (isdefined(org)) {
        org deletedelay();
    }
}

// Namespace sound/sound_shared
// Params 3, eflags: 0x0
// Checksum 0x7099a4eb, Offset: 0x260
// Size: 0x14c
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
// Params 5, eflags: 0x0
// Checksum 0xebcf1425, Offset: 0x3b8
// Size: 0x204
function play_on_tag(alias, tag, ends_on_death, var_50bba55f, *radio_dialog) {
    if (self ai::is_dead_sentient()) {
        return;
    }
    org = spawn("script_origin", self.origin);
    org endon(#"death");
    thread delete_on_death_wait_sound(org, "sounddone");
    if (isdefined(ends_on_death)) {
        org linkto(self, ends_on_death, (0, 0, 0), (0, 0, 0));
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    /#
        if (self === level.player_radio_emitter) {
            println("<dev string:x38>" + tag);
        }
    #/
    org playsoundwithnotify(tag, "sounddone");
    if (isdefined(var_50bba55f)) {
        assert(var_50bba55f, "<dev string:x5a>");
        if (!isdefined(wait_for_sounddone_or_death(org))) {
            org stopsounds();
        }
        waitframe(1);
    } else {
        org waittill(#"sounddone");
    }
    if (isdefined(radio_dialog)) {
        self notify(radio_dialog);
    }
    org delete();
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0x3f81eccc, Offset: 0x5c8
// Size: 0x60
function wait_for_sounddone_or_death(org, other) {
    if (isdefined(other)) {
        other endon(#"death");
    }
    self endon(#"death");
    org waittill(#"sounddone");
    return true;
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xa76efc56, Offset: 0x630
// Size: 0x7c
function delete_on_death_wait_sound(ent, sounddone) {
    ent endon(#"death");
    self waittill(#"death");
    if (isdefined(ent)) {
        if (ent iswaitingonsound()) {
            ent waittill(sounddone);
        }
        ent deletedelay();
    }
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x0
// Checksum 0x3f11ba06, Offset: 0x6b8
// Size: 0x24
function play_on_entity(alias) {
    play_on_tag(alias);
}

// Namespace sound/sound_shared
// Params 1, eflags: 0x0
// Checksum 0xff041d8c, Offset: 0x6e8
// Size: 0x20
function stop_loop_on_entity(alias) {
    self notify("stop sound" + alias);
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0x761056d2, Offset: 0x710
// Size: 0x144
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
// Checksum 0x8a040cdb, Offset: 0x860
// Size: 0xbc
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
// Checksum 0xa956d2df, Offset: 0x928
// Size: 0x5c
function delete_on_death_wait(ent, *sounddone) {
    sounddone endon(#"death");
    self waittill(#"death");
    if (isdefined(sounddone)) {
        sounddone delete();
    }
}

// Namespace sound/sound_shared
// Params 2, eflags: 0x0
// Checksum 0xc9d55e08, Offset: 0x990
// Size: 0x174
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
            if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
                player playlocalsound(sound);
            }
        }
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        level.players[i] playlocalsound(sound);
    }
}

